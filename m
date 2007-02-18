Message-ID: <45D8AEB3.4020909@domain.hid>
Date: Sun, 18 Feb 2007 20:53:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-CAN tx_sem
References: <45D35545.20100@domain.hid>
	<45D45F63.5050009@domain.hid>	<45D461DC.20303@domain.hid>
	<45D4661D.7010506@domain.hid>	<45D46E55.7020907@domain.hid>
	<45D48E27.1090200@domain.hid> <45D6D6CB.4030602@domain.hid>
	<45D89B66.6050907@domain.hid>
In-Reply-To: <45D89B66.6050907@domain.hid>
Content-Type: multipart/mixed; boundary="------------070709020402050802060800"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070709020402050802060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> I thought about this issue again and found the reason for my vague bad
>> feeling: re-init is not atomic, thus racy. But also the test+sem_init
>> pattern I suggested is not save.
>>
>> I guess we need to enhance rtdm_XXX_init in this regard to make the
>> RT-CAN use case an officially allowed one. /me is planning to spend more
>> thoughts on this the next days.
> 
> OK, done, rtdm_{event,sem,mutex}_init are now protected by the nklock in
> trunk. This should make the in-place re-initialisation of RTDM IPC
> objects race-free and allow to use them in RT-CAN as originally
> intended. I think I will back-port that pieces also to v2.3.x later.
> 
> What patch should now go in to avoid double init/destroy and fix rtcan_virt?

Attached. Thanks.

Wolfgang.


--------------070709020402050802060800
Content-Type: text/x-patch;
 name="xenomai-rtcan-txsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-txsem.patch"

Index: quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_raw.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
@@ -967,12 +967,13 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_de
 
     /* Controller should be operating */
     if (!CAN_STATE_OPERATING(dev->state)) {
+	if (dev->state == CAN_STATE_SLEEPING) {
+	    ret = -ECOMM;
+	    rtdm_sem_up(&dev->tx_sem);
+	    goto send_out2;
+	}
         ret = -ENETDOWN;
         goto send_out2;
-    } else if (dev->state == CAN_STATE_SLEEPING) {
-        ret = -ECOMM;
-        rtdm_sem_up(&dev->tx_sem);
-        goto send_out2;
     }
 
     dev->tx_count++;
Index: quilt/xenomai/ksrc/drivers/can/rtcan_raw_dev.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_raw_dev.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_raw_dev.c
@@ -193,7 +193,8 @@ static inline int rtcan_raw_ioctl_dev_se
     switch (request) {
     case SIOCSCANMODE:
 	mode = (can_mode_t *)&ifr->ifr_ifru;
-	if (dev->do_set_mode)
+	if (dev->do_set_mode &&
+	    !(*mode == CAN_MODE_START && CAN_STATE_OPERATING(dev->state)))
 	    ret = dev->do_set_mode(dev, *mode, &lock_ctx);
 	break;
 
Index: quilt/xenomai/ksrc/drivers/can/rtcan_virt.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_virt.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_virt.c
@@ -102,8 +102,7 @@ static int rtcan_virt_set_mode(struct rt
 		break;
 
 	case CAN_MODE_START:
-		if (dev->state == CAN_STATE_STOPPED)
-			rtdm_sem_init(&dev->tx_sem, VIRT_TX_BUFS);
+		rtdm_sem_init(&dev->tx_sem, VIRT_TX_BUFS);
 		dev->state = CAN_STATE_ACTIVE;
 		break;
 
@@ -126,7 +125,7 @@ static int __init rtcan_virt_init_one(in
 	dev->ctrl_name = virt_ctlr_name;
 	dev->board_name = virt_board_name;
 
-	dev->state = CAN_STATE_STOPPED;
+	rtcan_virt_set_mode(dev, CAN_MODE_STOP, NULL);
 
 	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
Index: quilt/xenomai/ChangeLog
===================================================================
--- quilt.orig/xenomai/ChangeLog
+++ quilt/xenomai/ChangeLog
@@ -1,5 +1,15 @@
 2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
 
+	* xenomai/ksrc/drivers/can/rtcan_raw.c,
+	xenomai/ksrc/drivers/can/rtcan_raw_dev.c
+	xenomai/ksrc/drivers/can/rtcan_virt.c: The TX semaphore must be in
+	a destroyed state for proper operation. This was not the case for
+	the "virt" driver. Furthermore, to avoid re-initialization of the
+	TX semaphore, the device specific start routine is only called when
+	the device is not operating to avoid re-initialization.
+
+2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
+
 	* ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_socket.h: add
 	prefix RTCAN_ to TIMESTAMP_SIZE, HAS_TIMESTAMP and HAS_NO_TIMESTAMP
 	to avoild name clashes, e.g. TIMESTAMP_SIZE is used by the kernel

--------------070709020402050802060800--

