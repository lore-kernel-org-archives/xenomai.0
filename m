Message-ID: <43A44BEE.6080800@domain.hid>
Date: Sat, 17 Dec 2005 18:33:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig931A242DC23D88657CB7EDD3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix typos around 16550A driver
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
--------------enig931A242DC23D88657CB7EDD3
Content-Type: multipart/mixed; boundary="------------050407010206040009070407"

This is a multi-part message in MIME format.
--------------050407010206040009070407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

these are two typo fixes for the serial driver. One of them should have
broken kernel 2.4 compilation for this driver, the other is cosmetic

Jan


PS: What about this splnone in gatekeeper_thread(), BTW. Still needed?

--- ksrc/nucleus/shadow.c       (Revision 285)
+++ ksrc/nucleus/shadow.c       (Arbeitskopie)
@@ -384,7 +384,6 @@
        set_current_state(TASK_INTERRUPTIBLE);
        up(&gk->sync); /* Make the request token available. */
        schedule();
-       splnone();

        if (kthread_should_stop())
            break;

--------------050407010206040009070407
Content-Type: text/x-patch;
 name="16550A_typos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A_typos.patch"

Index: ksrc/drivers/16550A/16550A.c
===================================================================
--- ksrc/drivers/16550A/16550A.c	(Revision 285)
+++ ksrc/drivers/16550A/16550A.c	(Arbeitskopie)
@@ -1025,7 +1025,7 @@
 
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
-    driver_name:        "rt_16550A",
+    driver_name:        "xeno_16550A",
     driver_version:     RTDM_DRIVER_VER(1, 2, 1),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
Index: ksrc/drivers/16550A/Makefile
===================================================================
--- ksrc/drivers/16550A/Makefile	(Revision 285)
+++ ksrc/drivers/16550A/Makefile	(Arbeitskopie)
@@ -12,7 +12,7 @@
 
 O_TARGET := built-in.o
 
-obj-$(CONFIG_XENO_SKIN_16550A) := xeno_16550A.o
+obj-$(CONFIG_XENO_DRIVERS_16550A) := xeno_16550A.o
 
 list-multi := xeno_16550A.o
 

--------------050407010206040009070407--

--------------enig931A242DC23D88657CB7EDD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDpEvuniDOoMHTA+kRAv8BAJ9slE7qjyVgelXykpBRWsBCtrbh7wCeIA+r
Y10rl0vJNKQKJwGz9IUQgFs=
=cI5K
-----END PGP SIGNATURE-----

--------------enig931A242DC23D88657CB7EDD3--

