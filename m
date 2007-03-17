Message-ID: <45FBD768.9050407@domain.hid>
Date: Sat, 17 Mar 2007 12:56:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOW5u-0006Ap-EW@mailer.emlix.com>
	<45F7DEA8.2050309@domain.hid>
	<E1HRSws-0007cE-R3@domain.hid>
In-Reply-To: <E1HRSws-0007cE-R3@domain.hid>
Content-Type: multipart/mixed; boundary="------------070204020502020602050602"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070204020502020602050602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

Sebastian Smolorz wrote:
> Wolfgang Grandegger wrote:
>> Sebastian Smolorz wrote:
>>> Last summer we had a discussion about the BEI issue on the socketcan-ML.
>>> Two additional handling policies popped up:
>>> 1. The interface could restart itself after an amount of BEIs, thus
>>> taking responsibility from the user application.
>>> 2. The BEI could be completely disabled if no one is interested in this
>>> type of error frame.
>> I tried to implement 2. for SJA1000, but re-enabling the BIE on the fly
>> does not work. :-(. The controller requires a re-start of the device to
>> get the bus error reporting back to work.
> 
> Oh, really? I wasn't aware of this.

Well, I got it working. Reading the ECC register after re-enabling the 
bus error interrupts fixed the problem:

     if (CAN_STATE_OPERATING(dev->state)) {
        chip->write_reg(dev, SJA_IER, chip->ier); /* update on the fly */
        chip->read_reg(dev, SJA_ECC);
     }

>>> Maybe it is time to think about the implementation of these policies as
>>> more and more users seem to run into the BEI issue with a disconnected
>>> bus. Wolfgang, Jan, what is your opinion?
>> Well, solution 2. with the limitations mentioned above is therefore less
>> attractive because it interrupts the CAN traffic.
> 
> True.

Back to our preferred solution 1. Attached is a patch for review 
including some other fixes and suggestions accumulated over time:

      * ksrc/drivers/can/*: To avoid unnecessary bus error interrupt
      flooding, the option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now allows to
      enable bus error interrupts "on demand" only if an application is
      interested in such errors. It is automatically selected for CAN
      controllers supporting bus error interrupts like the SJA1000.

      * include/rtdm/rtcan.h: Add some doc on bus-off and bus-error error
      conditions and the restart policy.

      * src/utils/can/rtcanconfig.c: Controller mode settings and doc
      has been corrected.

>> The Socket-CAN 
>> implementation actually restarts the CAN controller after a certain
>> amount of bus error interrupts (200 by default) which matches your first
>> policy above. But in RT-Socket-CAN, we do not automatically re-start the
>> device by purpose. Therefore I tend to just stop the device. It's then
>> up to the application to restart it. What do you think?
> 
> No fundamental objections but it would be best if an application would be 
> informed of this special situation e.g. through an error frame with the 
> meaning "controller was stopped because of a disconnected bus after trying to 
> send 200 times the same message".
> 
> A question pops up in this context: Why do we define CAN_ERR_RESTARTED if we 
> never do this? Only to be compatible with Socket-CAN? Then I would propose to 
> extend the documentation by pointing out that this will not appear under 
> RT-Socket-CAN.

Let's wait if solution 1. is sufficient. maybe we need 2. later as well.

Wolfgang.


--------------070204020502020602050602
Content-Type: text/x-patch;
 name="xenomai-rtcan-bus-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-bus-error.patch"

Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 2299)
+++ include/rtdm/rtcan.h	(working copy)
@@ -598,16 +598,16 @@ typedef struct can_frame {
 /**
  * CAN error mask
  *
- * A CAN error mask (see @ref Errors) can be set with @c setsockopt. This 
- * mask is then used to decided if error frames are send to this socket 
- * in case of error condidtions. The error frames are marked with the 
- * @ref CAN_ERR_FLAG of @ref CAN_xxx_FLAG and must be handled by the 
- * application properly. A detailed description of the error can be
- * found in the @c can_id and the @c data fields of struct can_frame 
- * (see @ref Errors for futher details). 
+ * A CAN error mask (see @ref Errors) can be set with @c setsockopt. This
+ * mask is then used to decide if error frames are delivered to this socket
+ * in case of error condidtions. The error frames are marked with the
+ * @ref CAN_ERR_FLAG of @ref CAN_xxx_FLAG and must be handled by the
+ * application properly. A detailed description of the errors can be
+ * found in the @c can_id and the @c data fields of struct can_frame
+ * (see @ref Errors for futher details).
  *
  * @n
- * @param [in] level @b SOL_CAN_RAW 
+ * @param [in] level @b SOL_CAN_RAW
  *
  * @param [in] optname @b CAN_RAW_ERR_FILTER
  *
@@ -1062,7 +1062,19 @@ typedef struct can_frame {
 /*!
  * @anchor Errors @name Error mask
  * Error class (mask) in @c can_id field of struct can_frame to
- * be used with @ref CAN_RAW_ERR_FILTER. 
+ * be used with @ref CAN_RAW_ERR_FILTER.
+ *
+ * @b Note: In case of a bus-off error condition (@ref CAN_ERR_BUSOFF), the
+ * CAN controller is @b not restarted automatically. It is the application's
+ * responsibility to react appropriately, e.g. calling @ref CAN_MODE_START.
+ *
+ * @b Note: Bus error interrupts (@ref CAN_ERR_BUSERROR) are normally enabled
+ * "on demand" only if the application is interested in such errors using
+ * @ref CAN_RAW_ERR_FILTER. This avoids unnessecary bus error interrupt
+ * flooding. Flooding can still occur if the error interrupt rate is high
+ * and especially if the RT-Socket-CAN debugging option
+ * (@c CONFIG_XENO_DRIVERS_CAN_DEBUG) is enabled resulting in socket buffer
+ * overflow messages. Alternatively, you could check @c /proc/rtcan/sockets.
  * @{ */
 
 /** TX timeout (netdevice driver) */
@@ -1074,7 +1086,7 @@ typedef struct can_frame {
 /** Controller problems (see @ref Error1 "data[1]") */
 #define CAN_ERR_CRTL         0x00000004U
 
-/** Protocol violations (see @ref Error2 "data[2]", 
+/** Protocol violations (see @ref Error2 "data[2]",
                              @ref Error3 "data[3]") */
 #define CAN_ERR_PROT         0x00000008U
 
@@ -1088,14 +1100,14 @@ typedef struct can_frame {
 #define CAN_ERR_BUSOFF       0x00000040U
 
 /** Bus error (may flood!) */
-#define CAN_ERR_BUSERROR     0x00000080U 
+#define CAN_ERR_BUSERROR     0x00000080U
 
 /** Controller restarted */
 #define CAN_ERR_RESTARTED    0x00000100U
 
 /** Omit EFF, RTR, ERR flags */
 #define CAN_ERR_MASK         0x1FFFFFFFU
- 
+
 /** @} */
 
 /*!
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2299)
+++ ChangeLog	(working copy)
@@ -1,3 +1,17 @@
+2007-03-17  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/*: To avoid unnecessary bus error interrupt
+	flooding, the option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now allows to
+	enable bus error interrupts "on demand" only if an application is
+	interested in such errors. It is automatically selected for CAN
+	controllers supporting bus error interrupts like the SJA1000.
+
+	* include/rtdm/rtcan.h: Add some doc on bus-off and bus-error error
+	conditions and the restart policy.
+
+	* src/utils/can/rtcanconfig.c: Controller mode settings and doc
+	has been corrected.
+
 2007-03-12  Paul Corner <paul_c@domain.hid>
 
 	* debian/: Add rule set for generating a series of Debian
Index: src/utils/can/rtcanconfig.c
===================================================================
--- src/utils/can/rtcanconfig.c	(revision 2299)
+++ src/utils/can/rtcanconfig.c	(working copy)
@@ -41,7 +41,7 @@ static void print_usage(char *prg)
 	    "Options:\n"
 	    " -v, --verbose            be verbose\n"
 	    " -h, --help               this help\n"
-	    " -c, --ctrlmode=M1:M2:... listenonly or loopback mode\n"
+	    " -c, --ctrlmode=CTRLMODE  listenonly, loopback or none\n"
 	    " -b, --baudrate=BPS       baudrate in bits/sec\n"
 	    " -B, --bittime=BTR0:BTR1  BTR or standard bit-time\n"
 	    " -B, --bittime=BRP:PROP_SEG:PHASE_SEG1:PHASE_SEG2:SJW:SAM\n",
@@ -73,8 +73,10 @@ int string_to_ctrlmode(char *str)
 	return CAN_CTRLMODE_LISTENONLY;
     else if ( !strcmp(str, "loopback") )
 	return CAN_CTRLMODE_LOOPBACK;
+    else if ( !strcmp(str, "none") )
+	return 0;
 
-    return 0;
+    return -1;
 }
 
 int main(int argc, char *argv[])
@@ -137,7 +139,12 @@ int main(int argc, char *argv[])
 	    break;
 
 	case 'c':
-	    new_ctrlmode |= string_to_ctrlmode(optarg);
+	    ret = string_to_ctrlmode(optarg);
+	    if (ret == -1) {
+		print_usage(argv[0]);
+		exit(0);
+	    }
+	    new_ctrlmode |= ret;
 	    set_ctrlmode = 1;
 	    break;
 
Index: ksrc/drivers/can/Kconfig
===================================================================
--- ksrc/drivers/can/Kconfig	(revision 2299)
+++ ksrc/drivers/can/Kconfig	(working copy)
@@ -49,6 +49,17 @@ config XENO_DRIVERS_CAN_MAX_RECEIVERS
 
 	The driver maintains a receive filter list per device for fast access.
 
+config XENO_DRIVERS_CAN_BUS_ERR
+	depends on XENO_DRIVERS_CAN
+	bool
+	default n
+	help
+
+	To avoid unnecessary bus error interrupt flooding, this option enables
+	bus error interrupts "on demand" only if an application is interested
+	in such errors. It is automatically selected for CAN controllers
+	supporting bus error interrupts like the SJA1000.
+
 config XENO_DRIVERS_CAN_VIRT
 	depends on XENO_DRIVERS_CAN
 	tristate "Virtual CAN bus driver"
Index: ksrc/drivers/can/rtcan_dev.h
===================================================================
--- ksrc/drivers/can/rtcan_dev.h	(revision 2299)
+++ ksrc/drivers/can/rtcan_dev.h	(working copy)
@@ -142,6 +142,10 @@ struct rtcan_device {
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry *proc_root;
 #endif
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+    int bus_err_users;
+    void (*do_set_bus_err)(struct rtcan_device *dev, int enable);
+#endif
 #ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
     struct rtcan_skb tx_skb;
     struct rtcan_socket *tx_socket;
Index: ksrc/drivers/can/rtcan_raw_dev.c
===================================================================
--- ksrc/drivers/can/rtcan_raw_dev.c	(revision 2299)
+++ ksrc/drivers/can/rtcan_raw_dev.c	(working copy)
@@ -312,3 +312,49 @@ int rtcan_raw_ioctl_dev(struct rtdm_dev_
 
     return ret;
 }
+
+void rtcan_raw_set_err_mask(struct rtcan_socket *sock,
+			    can_err_mask_t err_mask)
+{
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+    int i, begin, end;
+    struct rtcan_device *dev;
+    rtdm_lockctx_t lock_ctx;
+    int ifindex = atomic_read(&sock->ifindex);
+
+    if ((sock->err_mask & CAN_ERR_BUSERROR) != (err_mask & CAN_ERR_BUSERROR)) {
+
+	if (ifindex) {
+	    begin = ifindex;
+	    end   = ifindex;
+	} else {
+	    begin = 1;
+	    end = RTCAN_MAX_DEVICES;
+	}
+
+	for (i = begin; i <= end; i++) {
+	    if ((dev = rtcan_dev_get_by_index(i)) == NULL)
+		continue;
+
+	    if (dev->do_set_bus_err) {
+		rtdm_lock_get_irqsave(&dev->device_lock, lock_ctx);
+		if (err_mask & CAN_ERR_BUSERROR) {
+		    if (dev->bus_err_users == 0)
+			dev->do_set_bus_err(dev, 1);
+		    dev->bus_err_users++;
+		} else {
+		    if (dev->bus_err_users > 0) {
+			dev->bus_err_users--;
+			if (dev->bus_err_users == 0)
+			    dev->do_set_bus_err(dev, 0);
+		    }
+		}
+		rtdm_lock_put_irqrestore(&dev->device_lock, lock_ctx);
+	    }
+	    rtcan_dev_dereference(dev);
+	}
+    }
+#endif /* CONFIG_XENO_DRIVERS_CAN_BUS_ERR*/
+
+    sock->err_mask = err_mask;
+}
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(revision 2299)
+++ ksrc/drivers/can/rtcan_raw.c	(working copy)
@@ -116,9 +116,9 @@ static void rtcan_rcv_deliver(struct rtc
 	sock->recv_tail = (sock->recv_tail + cpy_size) &
 	    (RTCAN_RXBUF_SIZE - 1);
 
-	/*Notify the delivery of the message */
+	/* Notify the delivery of the message */
 	rtdm_sem_up(&sock->recv_sem);
-	
+
     } else {
 	/* Overflow of socket's ring buffer! */
 	sock->rx_buf_full++;
@@ -242,6 +242,9 @@ static int rtcan_raw_close(struct rtdm_d
     /* Get lock for reception lists */
     rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
 
+    /* Reset error mask? */
+    rtcan_raw_set_err_mask(sock, 0x0);
+
     /* Check if socket is bound */
     if (rtcan_sock_is_bound(sock))
         rtcan_raw_unbind(sock);
@@ -378,7 +381,7 @@ static int rtcan_raw_setsockopt(struct r
 
 	/* Get lock for reception lists */
 	rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
-	sock->err_mask = err_mask;
+	rtcan_raw_set_err_mask(sock, err_mask);
 	rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
 
 	break;
Index: ksrc/drivers/can/rtcan_version.h
===================================================================
--- ksrc/drivers/can/rtcan_version.h	(revision 2299)
+++ ksrc/drivers/can/rtcan_version.h	(working copy)
@@ -22,6 +22,6 @@
 
 #define RTCAN_MAJOR_VER    0
 #define RTCAN_MINOR_VER   90
-#define RTCAN_BUGFIX_VER   1
+#define RTCAN_BUGFIX_VER   2
 
 #endif /* __RTCAN_VERSION_H_ */
Index: ksrc/drivers/can/rtcan_raw.h
===================================================================
--- ksrc/drivers/can/rtcan_raw.h	(revision 2299)
+++ ksrc/drivers/can/rtcan_raw.h	(working copy)
@@ -32,6 +32,9 @@ void rtcan_raw_remove_filter(struct rtca
 
 void rtcan_rcv(struct rtcan_device *rtcandev, struct rtcan_skb *skb);
 
+void rtcan_raw_set_err_mask(struct rtcan_socket *sock,
+			    can_err_mask_t err_mask);
+
 void rtcan_loopback(struct rtcan_device *rtcandev);
 #ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
 #define rtcan_loopback_enabled(sock) (sock->loopback)
Index: ksrc/drivers/can/sja1000/Kconfig
===================================================================
--- ksrc/drivers/can/sja1000/Kconfig	(revision 2299)
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
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 2299)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -66,7 +66,7 @@
 /* Value for the interrupt enable register */
 #define SJA1000_IER                 SJA_IER_RIE | SJA_IER_TIE | \
                                     SJA_IER_EIE | SJA_IER_WUIE | \
-                                    SJA_IER_EPIE | SJA_IER_BEIE | \
+                                    SJA_IER_EPIE | \
                                     SJA_IER_ALIE | SJA_IER_DOIE
 
 static char *sja_ctrl_name = "SJA1000"; 
@@ -247,7 +247,7 @@ static inline void rtcan_sja_err_interru
 
 	else
 	    /* Bus-off recovery complete, enable all interrupts again */
-	    chip->write_reg(dev, SJA_IER, SJA1000_IER);
+	    chip->write_reg(dev, SJA_IER, chip->ier);
     }
 
     if (state != dev->state && 
@@ -439,7 +439,7 @@ static int rtcan_sja_mode_stop(struct rt
     } else {
         ret = -EAGAIN;
         /* Enable interrupts again as we did not succeed */
-        chip->write_reg(dev, SJA_IER, SJA1000_IER);
+        chip->write_reg(dev, SJA_IER, chip->ier);
     }
 
  out:
@@ -489,7 +489,7 @@ static int rtcan_sja_mode_start(struct r
 	/* Set up sender "mutex" */
 	rtdm_sem_init(&dev->tx_sem, 1);
 	/* Enable interrupts */
-	chip->write_reg(dev, SJA_IER, SJA1000_IER);
+	chip->write_reg(dev, SJA_IER, chip->ier);
 
 	/* Clear reset mode bit in SJA1000 */
 	chip->write_reg(dev, SJA_MOD, mod_reg);
@@ -621,12 +621,26 @@ int rtcan_sja_set_bit_time(struct rtcan_
 
     chip->write_reg(dev, SJA_BTR0, btr0);
     chip->write_reg(dev, SJA_BTR1, btr1);
-    
+
     return 0;
 }
 
+/*
+ * Enable/disable bus error reporting
+ */
+void rtcan_sja_set_bus_err(struct rtcan_device *dev, int enable)
+{
+    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
-
+    if (enable)
+	chip->ier |= SJA_IER_BEIE;
+    else
+	chip->ier &= ~SJA_IER_BEIE;
+    if (CAN_STATE_OPERATING(dev->state)) {
+	chip->write_reg(dev, SJA_IER, chip->ier); /* update on the fly */
+	chip->read_reg(dev, SJA_ECC);
+    }
+}
 
 /*
  *  Start a transmission to a SJA1000 device
@@ -722,7 +736,7 @@ static void sja1000_chip_config(struct r
 
 int rtcan_sja1000_register(struct rtcan_device *dev)
 {
-    int                         ret;
+    int ret;
     struct rtcan_sja1000 *chip = dev->priv;
 
     if (chip == NULL)
@@ -745,8 +759,10 @@ int rtcan_sja1000_register(struct rtcan_
     dev->do_set_mode = rtcan_sja_set_mode;
     dev->do_get_state = rtcan_sja_get_state;
     dev->do_set_bit_time = rtcan_sja_set_bit_time;
+    dev->do_set_bus_err = rtcan_sja_set_bus_err;
+    chip->ier = SJA1000_IER;
 
-    ret = rtdm_irq_request(&dev->irq_handle, 
+    ret = rtdm_irq_request(&dev->irq_handle,
 			   chip->irq_num, rtcan_sja_interrupt,
 			   chip->irq_flags, sja_ctrl_name, dev);
     if (ret) {
Index: ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c	(revision 2299)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c	(working copy)
@@ -36,20 +36,20 @@ static int rtcan_sja_proc_regs(char *buf
     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
     int i;
     RTCAN_PROC_PRINT_VARS(80);
-    
+
     if (!RTCAN_PROC_PRINT("SJA1000 registers"))
 	goto done;
     for (i = 0; i < 0x20; i++) {
 	if ((i % 0x10) == 0) {
 	    if (!RTCAN_PROC_PRINT("\n%02x:", i))
-		goto done; 
+		goto done;
 	}
 	if (!RTCAN_PROC_PRINT(" %02x", chip->read_reg(dev, i)))
-	    goto done; 
+	    goto done;
     }
     if (!RTCAN_PROC_PRINT("\n"))
 	goto done;
-    
+
  done:
     RTCAN_PROC_PRINT_DONE;
 }
Index: ksrc/drivers/can/sja1000/Config.in
===================================================================
--- ksrc/drivers/can/sja1000/Config.in	(revision 2299)
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
--- ksrc/drivers/can/sja1000/rtcan_sja1000.h	(revision 2299)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.h	(working copy)
@@ -30,6 +30,7 @@ struct rtcan_sja1000 {
     unsigned short irq_flags;
     unsigned char ocr;
     unsigned char cdr;
+    unsigned char ier;
 };
 
 int rtcan_sja_create_proc(struct rtcan_device* dev);

--------------070204020502020602050602--

