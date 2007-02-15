Message-ID: <45D45F63.5050009@domain.hid>
Date: Thu, 15 Feb 2007 14:25:55 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D35545.20100@domain.hid>
In-Reply-To: <45D35545.20100@domain.hid>
Content-Type: multipart/mixed; boundary="------------080903040102020609020504"
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
--------------080903040102020609020504
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> fiddling with the CAN utils, I noticed the behaviour that rtcansend on
> freshly registered but stopped devices simply blocks. And when you
> meanwhile call rtcanconfig up on that device, rtcansend will continue to
> block.

I see the expected behavior on stopped devices:

   bash-2.05b# rtcansend rtcan0
   rt_dev_send: Network is down

This is, because the tx_sem is marked "destroyed" already when the 
device gets initialized. I wonder why your app blocks.

> The reason is that during startup of CAN devices the tx-semaphore is
> re-initialised while it is already set up during device registration.
> Re-init on an already initialised rtdm_sem is, say, undefined.

That makes definitely trouble. A CAN_MODE_START should only start the 
device if it's not active. The attached patch fixes this. Another 
possibility would be to force a CAN_MODE_STOP in case the device is 
already active (=restart).

> So rtdm_sem should better only be initialised/destroyed by the drivers.
> Trying to send on a shut down CAN device could be catched differently,
> e.g. via the device state. This likely needs more thoughts, take it as a
> note that $something should be done.

With the fix above I do not see further problems with the existing 
implementation using the "destroyed" state to mark the device unavailable.

Wolfgang.

--------------080903040102020609020504
Content-Type: text/x-patch;
 name="xenomai-rtcan-txsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-txsem.patch"

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
 

--------------080903040102020609020504--

