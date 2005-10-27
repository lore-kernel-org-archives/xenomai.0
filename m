Message-ID: <4360B46C.5030104@domain.hid>
Date: Thu, 27 Oct 2005 13:05:16 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A95B1A6183B1A9704816986"
Subject: [Xenomai-core] [patch] serial driver fixes/improvements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A95B1A6183B1A9704816986
Content-Type: multipart/mixed; boundary="------------060109010409090300070403"

This is a multi-part message in MIME format.
--------------060109010409090300070403
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this patch improves the behaviour of xeno_16550A on
RTSER_RTIOC_EVENT_WAIT. In case it is invoked from non-RT, the driver
tries to trigger an automatic switch-back to RT via returning ENOSYS.
The patch also fixes another remaining issue about the right context
when calling RTSER_RTIOC_SET_CONFIG (forgot the corner case of releasing
the RX history buffer in RT).

Note that I intentionally did not apply the EPERM->ENOSYS scheme on
RTSER_RTIOC_SET_CONFIG. Here a switch to non-RT might be required if the
device was opened in non-RT and a reconfigure request regarding the RX
history buffer is now issued in RT. I think it's better to let the user
decide via a preceding explicit switch to non-RT if leaving RT is really
correct.

The patch furthermore contains a README describing the device setup. I
hope I addressed potential questions and problems sufficiently, feedback
is welcome.

Jan

--------------060109010409090300070403
Content-Type: text/plain;
 name="16550A-1.1.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A-1.1.2.patch"

Index: drivers/16550A/Kconfig
===================================================================
--- drivers/16550A/Kconfig	(revision 73)
+++ drivers/16550A/Kconfig	(working copy)
@@ -3,4 +3,5 @@
 	bool "16550A UART driver"
 	default n
 	help
-	Real-time UART driver for 16550A compatible controllers.
+	Real-time UART driver for 16550A compatible controllers. See
+	drivers/16550A/README for more details.
Index: drivers/16550A/16550A.c
===================================================================
--- drivers/16550A/16550A.c	(revision 73)
+++ drivers/16550A/16550A.c	(working copy)
@@ -556,18 +556,24 @@
                 config = &config_buf;
             }
 
-            if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY) &&
-                testbits(config->timestamp_history,
-                         RTSER_RX_TIMESTAMP_HISTORY)) {
-                if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags)) {
-                    if (rtdm_in_rt_context())
-                        return -EPERM;
+            if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY)) {
+                if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags) &&
+                    rtdm_in_rt_context()) {
+                    /* already fail if we MAY allocate or release a non-RT
+                     * buffer in RT context */
+                    return -EPERM;
+                }
 
-                    hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(__u64),
-                                       GFP_KERNEL);
-                } else
-                    hist_buf =
-                        rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
+                if (testbits(config->timestamp_history,
+                             RTSER_RX_TIMESTAMP_HISTORY)) {
+                    if (test_bit(RTDM_CREATED_IN_NRT,
+                                 &context->context_flags))
+                        hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(__u64),
+                                           GFP_KERNEL);
+                    else
+                        hist_buf =
+                            rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
+                }
 
                 if (!hist_buf)
                     return -ENOMEM;
@@ -643,7 +649,7 @@
             rtdm_toseq_t        timeout_seq;
 
             if (!rtdm_in_rt_context())
-                return -EPERM;
+                return -ENOSYS;
 
             /* only one waiter allowed, stop any further attempts here */
             if (test_and_set_bit(0, &ctx->ioc_event_lock))
@@ -1005,7 +1011,7 @@
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
     driver_name:        "rt_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 1, 1),
+    driver_version:     RTDM_DRIVER_VER(1, 1, 2),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };
Index: drivers/16550A/README
===================================================================
--- drivers/16550A/README	(revision 0)
+++ drivers/16550A/README	(revision 0)
@@ -0,0 +1,34 @@
+Real-Time Serial Driver for 16550A-Compatible Devices
+=====================================================
+
+Preparation
+-----------
+ - decide which serial ports are to be managed by the real-time driver
+
+ - identify their I/O addresses and IRQ numbers:
+
+   setserial /dev/ttyS<N>
+
+ - disable the Linux driver for all these devices:
+
+   setserial /dev/ttyS<N> uart none
+
+
+Invocation
+----------
+
+modprobe xeno_16550A ioaddr=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
+                     [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
+
+Arguments:
+    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
+    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
+    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>, default is 16
+    start_index - First device instance number to be used, default is 0
+
+
+Usage
+-----
+
+The API is described in the API documentation under Modules -> Real-Time
+Driver Model -> Device Profiles -> Serial Devices.

--------------060109010409090300070403--

--------------enig1A95B1A6183B1A9704816986
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYLRsncNeS9Q0k+IRAp4fAJ0Zu2Na+Yk/VoM4ctXif1QUYLFFZACePqyT
nfTAxck++ngF95vJe8ySRBI=
=NjHs
-----END PGP SIGNATURE-----

--------------enig1A95B1A6183B1A9704816986--

