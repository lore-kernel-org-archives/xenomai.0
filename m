Message-ID: <460510D8.2010205@domain.hid>
Date: Sat, 24 Mar 2007 12:51:52 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>	<4601958C.90502@domain.hid>
	<4601A6E4.9020908@domain.hid>	<46023991.4020301@domain.hid>	<46036D32.7000603@domain.hid>
	<46036F22.60709@domain.hid>	<46039128.90609@domain.hid>
	<4603950D.9040801@domain.hid>
In-Reply-To: <4603950D.9040801@domain.hid>
Content-Type: multipart/mixed; boundary="------------090407060207000307050600"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090407060207000307050600
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Oliver Hartkopp wrote:
>>> Additionally to the written stuff below (please read that first), i want
>>> to remark:
>>>
>>> - Remember that we are talking about a case that is not a standard
>>> operation mode but a (temporary) error condition that normally leads to
>>> a bus-off state and appears only in development and hardware setup 
>>> phase!
>>> - i would suggest to use some low resolution timestamp (like jiffies)
>>> for this, which is very cheap in CPU usage
>>> - the throttling should be configured as a driver module parameter (e.g.
>>> bei_thr=0 or bei_thr=200 )due to the need of the global use-case. If you
>>> are writing a CAN analysis tool you might want to set bei_thr=0 in other
>>> cases a default of 200ms might be the right thing.
>>
>> We are falling back to #1, i.e. where we are now already. Your
>> suggestion doesn't help us to provide a generic RT-stack for Xenomai.
>>
>>> Regards,
>>> Oliver
>>>
>>>
>>>
>>> Oliver Hartkopp wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Wolfgang Grandegger wrote:
>>>>>>> Oliver Hartkopp wrote:
>>>>>>>
>>>>>>>> I would tend to reduce the notifications to the user by creating a
>>>>>>>> timer at the first bus error interrupt. The first BE irq would
>>>>>>>> lead to a CAN_ERR_BUSERROR and after a (configurable) time
>>>>>>>> (e.g.250ms) the next information about bus errors is allowed to be
>>>>>>>> passed to the user. After this time period is over a new
>>>>>>>> CAN_ERR_BUSERROR may be passed to the user containing the count of
>>>>>>>> occurred bus errors somewhere in the data[]-section of the Error
>>>>>>>> Frame. When a normal RX/TX-interrupt indicates a 'working' CAN
>>>>>>>> again, the timer would be terminated.
>>>>>>>>
>>>>>>>> Instead of a fix configurable time we could also think about a
>>>>>>>> dynamic behaviour (e.g. with increasing periods).
>>>>>>>>
>>>>>>>> What do you think about this?
>>>>>>> The question is if one bus-error does provide enough information on
>>>>>>> the cause of the electrical problem or if a sequence is better.
>>>>>>> Furthermore, I personally regard the use of timers as to heavy. But
>>>>>>> the solution is feasible, of course. Any other opinions?
>>>>>>>
>>>>>> I think Oliver's suggestions points in the right direction. But 
>>>>>> instead
>>>>>> of only coding a timer into the stack, I still vote for closing the
>>>>>> loop
>>>>>> over the application:
>>>>>>
>>>>>> After the first error in a potential series, the related error 
>>>>>> frame is
>>>>>> queued, listeners are woken up, and BEI is disabled for now. Once 
>>>>>> some
>>>>>> listener read the error frame *and* decided to call into the stack 
>>>>>> for
>>>>>> further bus errors, BEI is enabled again.
>>>>>>
>>>>>> That way the application decides about the error-related IRQ rate and
>>>>>> can easily throttle it by delaying the next receive call. Moreover,
>>>>>> threads of higher priority will be delayed at worst by one error IRQ.
>>>>>> This mechanism just needs some words in the documentation ("Be 
>>>>>> warned:
>>>>>> error frames may overwhelm you. Throttle your reception!"), but no
>>>>>> further user-visible config options.
>>>>> I understand, BEI interrupts get (re-)enabled in recvmsg() if the
>>>>> socket wants to receive bus errors. There can me multiple readers,
>>>>> but that's not a problem. Just some overhead in this function. This
>>>>> would also simplify the implementation as my previous one with
>>>>> "on-demand" bus error would be obsolete. I start to like this 
>>>>> solution.
>>>> Hm - to reenable the BEI on user interaction would be a nice thing 
>>>> BUT i
>>>> can see several problems:
>>>>
>>>> 1. In socketcan you have receive queues into the userspace with a
>>>> length >1
>>
>> Can you explain to me what the problem behind this is? I don't see it 
>> yet.
>>
>>>> 2. How can we handle multiple subscribers (A reads three error frames
>>>> and reenables therefore the BEI, B reads nothing in this time). Please
>>>> remember: To have multiple applications it a vital idea from socketcan.
>>
>> Same here, I don't see the issue. A and B will both find the first error
>> frame in their queues/ring buffers/whatever. If A has higher priority
>> (or gets an earlier timeslice), it may already re-enable BEI before B
>> was able to run as well. But that's an application-specific scheduling
>> issue and not a problem of the CAN stack (often it is precisely what you
>> want when assigning priorities...).
>>
>>>> 3. The count of occured BEIs gets lost (maybe this is unimportant)
>>
>> Agreed, but I also don't consider this problematic.
>>
>>>> ----
>>>>
>>>> Regarding (2) the solution could be not to reenable the BEI for a 
>>>> device
>>>> until every subscriber has read his error frame. But this collides with
>>>> a raw-socket that's bound to 'any' device (ifindex = 0).
>>
>> That can cause prio-inversion: a low-prio BEI-reader decides about when
>> a high-prio one gets the next message. No-go for RT.
>>
>>>> Regarding (3) we could count the BEIs (which would not reduce the
>>>> interrupt load) or we just stop the BEI after the first occurance which
>>>> might possibly not enough for some people to implement the CAN
>>>> academical correct.
>>>>
>>>> As you may see here a tight coupling of the problems on the CAN bus 
>>>> with
>>>> the application(s!) is very tricky or even impossible in socketcan.
>>>> Regarding other network devices (like ethernet devices) the 
>>>> notification
>>>> about Layer 1/2 problems is unusual. The concept of creating error
>>>> frames was a good compromise for this reason.
>>>>
>>>> As i also would like to avoid to create a timer for "bus error
>>>> throttling", i got a new idea:
>>>>
>>>> - on the first BEI: create an error frame, set a counter to zero and
>>>> save the current timestamp
>>>> - on the next BEI:
>>>>  - increment the counter
>>>>  - check if the time is up for the next error frame (e.g. after 200ms -
>>>> configurable?)
>>>>  - if so: Send the next error frame (including the number of occured
>>>> error frames in this 200ms)
>>>>
>>>> BEI means ONLY to have a BEI (and no other error).
>>>>
>>>> Of course this does NOT reduce the interrupt load but all this
>>>> throttling is performed inside the interrupt context. This should 
>>>> not be
>>>> that problem, or is it? And we do not need a timer ...
>>>>
>>>> Any comments to this idea?
>>>>
>>>> Regards,
>>>> Oliver
>>>>
>>
>> Well, I may oversee some pitfalls of my suggestion, so please help me to
>> understand your concerns.
> 
> There might be a problem with re-enabling BEI interrupts because we need 
>  to read the ECC. OK, I'm going to implement the method as well to check 
> for pitfalls.

Attached is the patch and it works fine. The key function 
rtcan_sja_enable_bus_err() is called from sendmsg():

void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
{
     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;

     if (chip->bus_err_on < 2) {
	if (chip->bus_err_on < 1)
	    chip->read_reg(dev, SJA_ECC);
	chip->bus_err_on = 2;
     }
}

And I do also do not see a real problem with multiple readers. I would 
commit this solution. I'm just unsure if we should select it silently or 
if the user should have the choice.

Wolfgang.

--------------090407060207000307050600
Content-Type: text/x-patch;
 name="xenomai-rtcan-bus-err-on-send.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-bus-err-on-send.patch"

Index: ksrc/drivers/can/Kconfig
===================================================================
--- ksrc/drivers/can/Kconfig	(revision 2335)
+++ ksrc/drivers/can/Kconfig	(working copy)
@@ -49,6 +49,19 @@ config XENO_DRIVERS_CAN_MAX_RECEIVERS
 
 	The driver maintains a receive filter list per device for fast access.
 
+config XENO_DRIVERS_CAN_BUS_ERR
+	depends on XENO_DRIVERS_CAN
+	bool
+	default n
+	help
+
+	To avoid unnecessary bus error interrupt flooding, this option enables
+	bus error interrupts when an application is calling a receive function
+	on a socket listening on bus errors. After one bus error has occured,
+	the interrupt will be disabled to allow the application time for error
+	processing. This option is automatically selected for CAN controllers
+	supporting bus error interrupts like the SJA1000.
+
 config XENO_DRIVERS_CAN_VIRT
 	depends on XENO_DRIVERS_CAN
 	tristate "Virtual CAN bus driver"
Index: ksrc/drivers/can/rtcan_dev.h
===================================================================
--- ksrc/drivers/can/rtcan_dev.h	(revision 2335)
+++ ksrc/drivers/can/rtcan_dev.h	(working copy)
@@ -118,6 +118,7 @@ struct rtcan_device {
     int                 (*do_set_bit_time)(struct rtcan_device *dev,
 					   struct can_bittime *bit_time,
 					   rtdm_lockctx_t *lock_ctx);
+    void                (*do_enable_bus_err)(struct rtcan_device *dev);
 
     /* Reception list head. This list contains all filters which have been
      * registered via a bind call. */
Index: ksrc/drivers/can/rtcan_raw_dev.c
===================================================================
--- ksrc/drivers/can/rtcan_raw_dev.c	(revision 2335)
+++ ksrc/drivers/can/rtcan_raw_dev.c	(working copy)
@@ -312,3 +312,33 @@ int rtcan_raw_ioctl_dev(struct rtdm_dev_
 
     return ret;
 }
+
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+void __rtcan_raw_enable_bus_err(struct rtcan_socket *sock)
+{
+    int i, begin, end;
+    struct rtcan_device *dev;
+    rtdm_lockctx_t lock_ctx;
+    int ifindex = atomic_read(&sock->ifindex);
+
+    if (ifindex) {
+	begin = ifindex;
+	end   = ifindex;
+    } else {
+	begin = 1;
+	end = RTCAN_MAX_DEVICES;
+    }
+
+    for (i = begin; i <= end; i++) {
+	if ((dev = rtcan_dev_get_by_index(i)) == NULL)
+	    continue;
+
+	if (dev->do_enable_bus_err) {
+	    rtdm_lock_get_irqsave(&dev->device_lock, lock_ctx);
+	    dev->do_enable_bus_err(dev);
+	    rtdm_lock_put_irqrestore(&dev->device_lock, lock_ctx);
+	}
+	rtcan_dev_dereference(dev);
+    }
+}
+#endif /* CONFIG_XENO_DRIVERS_CAN_BUS_ERR*/
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(revision 2335)
+++ ksrc/drivers/can/rtcan_raw.c	(working copy)
@@ -624,6 +624,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
             return -EINVAL;
     }
 
+    rtcan_raw_enable_bus_err(sock);
 
     /* Set RX timeout */
     timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->rx_timeout;
Index: ksrc/drivers/can/rtcan_raw.h
===================================================================
--- ksrc/drivers/can/rtcan_raw.h	(revision 2335)
+++ ksrc/drivers/can/rtcan_raw.h	(working copy)
@@ -41,6 +41,17 @@ void rtcan_loopback(struct rtcan_device 
 #define rtcan_loopback_pending(dev) (0)
 #endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+void __rtcan_raw_enable_bus_err(struct rtcan_socket *sock);
+static inline void rtcan_raw_enable_bus_err(struct rtcan_socket *sock)
+{
+    if ((sock->err_mask & CAN_ERR_BUSERROR))
+	__rtcan_raw_enable_bus_err(sock);
+}
+#else
+#define rtcan_raw_enable_bus_err(sock)
+#endif
+
 int __init rtcan_raw_proto_register(void);
 void __exit rtcan_raw_proto_unregister(void);
 
Index: ksrc/drivers/can/sja1000/Kconfig
===================================================================
--- ksrc/drivers/can/sja1000/Kconfig	(revision 2335)
+++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
@@ -1,6 +1,7 @@
 config XENO_DRIVERS_CAN_SJA1000
 	depends on XENO_DRIVERS_CAN
 	tristate "Philips SJA1000 CAN controller"
+	select XENO_DRIVERS_CAN_BUS_ERR
 
 config XENO_DRIVERS_CAN_SJA1000_ISA
 	depends on XENO_DRIVERS_CAN_SJA1000
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 2335)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -293,18 +293,21 @@ static int rtcan_sja_interrupt(rtdm_irq_
             dev->state = dev->state_before_sleep;
 
 	/* Error Interrupt? */
-        if (irq_source & (SJA_IR_EI | SJA_IR_DOI | SJA_IR_EPI | 
+        if (irq_source & (SJA_IR_EI | SJA_IR_DOI | SJA_IR_EPI |
 			  SJA_IR_ALI | SJA_IR_BEI)) {
+
 	    /* Check error condition and fill error frame */
-	    rtcan_sja_err_interrupt(dev, chip, &skb, irq_source);
+	    if (!((irq_source & SJA_IR_BEI) && (chip->bus_err_on-- < 2))) {
+		rtcan_sja_err_interrupt(dev, chip, &skb, irq_source);
 
-	    if (recv_lock_free) {
-		recv_lock_free = 0;
-		rtdm_lock_get(&rtcan_recv_list_lock);
-		rtdm_lock_get(&rtcan_socket_lock);
+		if (recv_lock_free) {
+		    recv_lock_free = 0;
+		    rtdm_lock_get(&rtcan_recv_list_lock);
+		    rtdm_lock_get(&rtcan_socket_lock);
+		}
+		/* Pass error frame out to the sockets */
+		rtcan_rcv(dev, &skb);
 	    }
-	    /* Pass error frame out to the sockets */
-	    rtcan_rcv(dev, &skb);
 	}
 
         /* Transmit Interrupt? */
@@ -625,8 +628,16 @@ int rtcan_sja_set_bit_time(struct rtcan_
     return 0;
 }
 
+void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
+{
+    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
-
+    if (chip->bus_err_on < 2) {
+	if (chip->bus_err_on < 1)
+	    chip->read_reg(dev, SJA_ECC);
+	chip->bus_err_on = 2;
+    }
+}
 
 /*
  *  Start a transmission to a SJA1000 device
@@ -745,8 +756,10 @@ int rtcan_sja1000_register(struct rtcan_
     dev->do_set_mode = rtcan_sja_set_mode;
     dev->do_get_state = rtcan_sja_get_state;
     dev->do_set_bit_time = rtcan_sja_set_bit_time;
+    dev->do_enable_bus_err = rtcan_sja_enable_bus_err;
+    chip->bus_err_on = 1;
 
-    ret = rtdm_irq_request(&dev->irq_handle, 
+    ret = rtdm_irq_request(&dev->irq_handle,
 			   chip->irq_num, rtcan_sja_interrupt,
 			   chip->irq_flags, sja_ctrl_name, dev);
     if (ret) {
Index: ksrc/drivers/can/sja1000/Config.in
===================================================================
--- ksrc/drivers/can/sja1000/Config.in	(revision 2335)
+++ ksrc/drivers/can/sja1000/Config.in	(working copy)
@@ -4,6 +4,10 @@
 
 dep_tristate 'Philips SJA1000 CAN controller' CONFIG_XENO_DRIVERS_CAN_SJA1000 $CONFIG_XENO_DRIVERS_CAN
 
+if [ "$CONFIG_XENO_DRIVERS_CAN_SJA1000" != "n" ]; then
+	define_bool CONFIG_XENO_DRIVERS_CAN_BUS_ERR y
+fi
+
 dep_tristate '  Standard ISA controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA $CONFIG_XENO_DRIVERS_CAN_SJA1000
 if [ "$CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA" != "n" ]; then
 	int '    Maximum number of controllers' CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA_MAX_DEV 4
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.h
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000.h	(revision 2335)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.h	(working copy)
@@ -30,6 +30,7 @@ struct rtcan_sja1000 {
     unsigned short irq_flags;
     unsigned char ocr;
     unsigned char cdr;
+    char bus_err_on;
 };
 
 int rtcan_sja_create_proc(struct rtcan_device* dev);

--------------090407060207000307050600--

