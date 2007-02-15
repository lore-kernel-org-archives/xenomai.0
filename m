Message-ID: <45D48E27.1090200@domain.hid>
Date: Thu, 15 Feb 2007 17:45:27 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D35545.20100@domain.hid> <45D45F63.5050009@domain.hid>
	<45D461DC.20303@domain.hid> <45D4661D.7010506@domain.hid>
	<45D46E55.7020907@domain.hid>
In-Reply-To: <45D46E55.7020907@domain.hid>
Content-Type: multipart/mixed; boundary="------------010908070105090906040602"
Subject: [Xenomai-core] Re: RT-CAN tx_sem
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
--------------010908070105090906040602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hi Jan,
>>>>
>>>> Jan Kiszka wrote:
>>>>> Hi Wolfgang,
>>>>>
>>>>> fiddling with the CAN utils, I noticed the behaviour that rtcansend on
>>>>> freshly registered but stopped devices simply blocks. And when you
>>>>> meanwhile call rtcanconfig up on that device, rtcansend will
>>>>> continue to
>>>>> block.
>>>> I see the expected behavior on stopped devices:
>>>>
>>>>   bash-2.05b# rtcansend rtcan0
>>>>   rt_dev_send: Network is down
>>>>
>>>> This is, because the tx_sem is marked "destroyed" already when the
>>>> device gets initialized. I wonder why your app blocks.
>>> Unlikely, because the sem is _not_ marked destroyed on startup:
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_dev.c#181
>>>
>> You missed
>>
>>     /* Set dummy state for following call */
>>     dev->state = CAN_STATE_ACTIVE;
>>     /* Enter reset mode */
>>     rtcan_sja_mode_stop(dev, NULL);
>>
>> in the init part of rtcan_sja1000.c and rtcan_mscan.c, ...
>>
>>> In case it makes a subtle difference: I tested with xeno_can_virt, but I
>>> think I saw the same effect on real SJA1000 hw as well.
>> ... which is missing in rtcan_virt.c. I already thought moving it to the
>> common part. The attached patch fixes that.
> 
> I'm still not happy with this pattern, at least it's hidden from the
> drivers now. But do not rtcan_sja1000.c and rtcan_mscan.c require some
> changes as well to avoid double destruction when this happens in generic
> code from now on?

Well, what needs a better implementaion is the code fragment shown above 
but I don't have a quick solution at hand. Therefore I tend to the 
attached patch.

>>>>> The reason is that during startup of CAN devices the tx-semaphore is
>>>>> re-initialised while it is already set up during device registration.
>>>>> Re-init on an already initialised rtdm_sem is, say, undefined.
>>>> That makes definitely trouble. A CAN_MODE_START should only start the
>>>> device if it's not active. The attached patch fixes this. Another
>>>> possibility would be to force a CAN_MODE_STOP in case the device is
>>>> already active (=restart).
>>>>
>>>>> So rtdm_sem should better only be initialised/destroyed by the drivers.
>>>>> Trying to send on a shut down CAN device could be catched differently,
>>>>> e.g. via the device state. This likely needs more thoughts, take it
>>>>> as a
>>>>> note that $something should be done.
>>>> With the fix above I do not see further problems with the existing
>>>> implementation using the "destroyed" state to mark the device
>>>> unavailable.
>>> The problem of double init remains. I don't think that the sem state
>>> should be used for encoding the CAN device state towards potential
>>> senders.
>> As I see it, Sebastian's trick saves code and synchronization.
> 
> Well, we are discussing a single test here. Or doesn't dev->state hold
> the require information as well. Moreover, the existing pattern was easy
> to get wrong between core and driver.

We speak about adding:

  if (!CAN_STATE_OPERATING(dev->state)) {
	if (dev->state == CAN_STATE_SLEEPING)
	    return-ECOMM;
	else
	    return-ENETDOWN;
  }

before calling rtdm_sem_timeddown().

> On the other hand, if we manage to clean the code up, I may change my mind.

I think we should avoid the above lines in a frequently used function.

Wolfgang.

--------------010908070105090906040602
Content-Type: text/x-patch;
 name="xenomai-rtcan-txsem3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-txsem3.patch"

+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.c.TXSEM xenomai/ksrc/drivers/can/rtcan_dev.c
+ diff -u xenomai/ksrc/drivers/can/rtcan_raw.c.TXSEM xenomai/ksrc/drivers/can/rtcan_raw.c
--- xenomai/ksrc/drivers/can/rtcan_raw.c.TXSEM	2007-02-15 17:11:11.000000000 +0100
+++ xenomai/ksrc/drivers/can/rtcan_raw.c	2007-02-15 13:46:02.000000000 +0100
@@ -964,12 +964,13 @@
 
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
+ diff -u xenomai/ksrc/drivers/can/rtcan_raw_dev.c.TXSEM xenomai/ksrc/drivers/can/rtcan_raw_dev.c
--- xenomai/ksrc/drivers/can/rtcan_raw_dev.c.TXSEM	2007-02-15 11:21:43.000000000 +0100
+++ xenomai/ksrc/drivers/can/rtcan_raw_dev.c	2007-02-15 14:16:16.000000000 +0100
@@ -193,7 +193,8 @@
     switch (request) {
     case SIOCSCANMODE:
 	mode = (can_mode_t *)&ifr->ifr_ifru;
-	if (dev->do_set_mode)
+	if (dev->do_set_mode &&
+	    !(*mode == CAN_MODE_START && CAN_STATE_OPERATING(dev->state)))
 	    ret = dev->do_set_mode(dev, *mode, &lock_ctx);
 	break;
 
+ diff -u xenomai/ksrc/drivers/can/rtcan_virt.c.TXSEM xenomai/ksrc/drivers/can/rtcan_virt.c
--- xenomai/ksrc/drivers/can/rtcan_virt.c.TXSEM	2007-02-15 11:24:14.000000000 +0100
+++ xenomai/ksrc/drivers/can/rtcan_virt.c	2007-02-15 17:13:23.000000000 +0100
@@ -102,8 +102,7 @@
 		break;
 
 	case CAN_MODE_START:
-		if (dev->state == CAN_STATE_STOPPED)
-			rtdm_sem_init(&dev->tx_sem, VIRT_TX_BUFS);
+		rtdm_sem_init(&dev->tx_sem, VIRT_TX_BUFS);
 		dev->state = CAN_STATE_ACTIVE;
 		break;
 
@@ -126,7 +125,7 @@
 	dev->ctrl_name = virt_ctlr_name;
 	dev->board_name = virt_board_name;
 
-	dev->state = CAN_STATE_STOPPED;
+	rtcan_virt_set_mode(dev, CAN_MODE_STOP, NULL);
 
 	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 

--------------010908070105090906040602--

