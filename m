Message-ID: <43A536FB.1010806@domain.hid>
Date: Sun, 18 Dec 2005 11:16:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF44E7A54681D3CEA9B89B8BE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix 16550A for 2.4
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
--------------enigF44E7A54681D3CEA9B89B8BE
Content-Type: multipart/mixed; boundary="------------000408020309030902060707"

This is a multi-part message in MIME format.
--------------000408020309030902060707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

it takes more to get the serial driver running on 2.4 kernels. The
current trunk version does not let the user set any module parameter
(effectively commented out). This patch fixes it.

Jan


--------------000408020309030902060707
Content-Type: text/x-patch;
 name="16550A_module_param.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A_module_param.patch"

Index: ksrc/drivers/16550A/16550A.c
===================================================================
--- ksrc/drivers/16550A/16550A.c	(Revision 287)
+++ ksrc/drivers/16550A/16550A.c	(Arbeitskopie)
@@ -114,26 +114,34 @@
 static struct rtdm_device   *device[MAX_DEVICES];
 
 static unsigned long        ioaddr[MAX_DEVICES];
-static int                  ioaddr_c;
 static unsigned int         irq[MAX_DEVICES];
-static int                  irq_c;
 static unsigned int         baud_base[MAX_DEVICES];
-static int                  baud_base_c;
 static int                  tx_fifo[MAX_DEVICES];
-static int                  tx_fifo_c;
 static unsigned int         start_index;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+static int                  ioaddr_c;
+static int                  irq_c;
+static int                  baud_base_c;
+static int                  tx_fifo_c;
+
 module_param_array(ioaddr, ulong, &ioaddr_c, 0400);
+module_param_array(irq, uint, &irq_c, 0400);
+module_param_array(baud_base, uint, &baud_base_c, 0400);
+module_param_array(tx_fifo, int, &tx_fifo_c, 0400);
+#else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) */
+MODULE_PARM(ioaddr, "1-" __MODULE_STRING(MAX_DEVICES) "i");
+MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_DEVICES) "i");
+MODULE_PARM(baud_base, "1-" __MODULE_STRING(MAX_DEVICES) "i");
+MODULE_PARM(tx_fifo, "1-" __MODULE_STRING(MAX_DEVICES) "i");
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0) */
+
 MODULE_PARM_DESC(ioaddr, "I/O addresses of the serial devices");
-module_param_array(irq, uint, &irq_c, 0400);
 MODULE_PARM_DESC(irq, "IRQ numbers of the serial devices");
-module_param_array(baud_base, uint, &baud_base_c, 0400);
 MODULE_PARM_DESC(baud_base,
     "Maximum baud rate of the serial device (internal clock rate / 16)");
-module_param_array(tx_fifo, int, &tx_fifo_c, 0400);
 MODULE_PARM_DESC(tx_fifo, "Transmitter FIFO size");
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0) */
+
 module_param(start_index, uint, 0400);
 MODULE_PARM_DESC(start_index, "First device instance number to be used");
 
@@ -1026,7 +1034,7 @@
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
     driver_name:        "xeno_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 2, 1),
+    driver_version:     RTDM_DRIVER_VER(1, 2, 2),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };
@@ -1040,10 +1048,15 @@
     int                 i;
 
 
-    if (irq_c < ioaddr_c)
-        return -EINVAL;
+    for (i = 0; i < MAX_DEVICES; i++) {
+        if (!ioaddr[i])
+            continue;
 
-    for (i = 0; i < ioaddr_c; i++) {
+        ret = -EINVAL;
+        if (!irq[i]) {
+            goto cleanup_out;
+        }
+
         dev = kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);
         ret = -ENOMEM;
         if (!dev)


--------------000408020309030902060707--

--------------enigF44E7A54681D3CEA9B89B8BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDpTcAniDOoMHTA+kRAtKwAJ4kZujbkEFASYhAvaZXFUQy7/ZzzACff9No
JO//oCIYjIvjYiWoNZ9nNqk=
=cYJs
-----END PGP SIGNATURE-----

--------------enigF44E7A54681D3CEA9B89B8BE--

