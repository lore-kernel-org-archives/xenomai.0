Message-ID: <434A4719.60503@domain.hid>
Date: Mon, 10 Oct 2005 12:48:57 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC20F93357141765CCB06EEDB"
Subject: [Xenomai-core] [16550-patch] detect required context of
	RTSER_RTIOC_WAIT_EVENT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC20F93357141765CCB06EEDB
Content-Type: multipart/mixed; boundary="------------040908070508080803030204"

This is a multi-part message in MIME format.
--------------040908070508080803030204
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

again thanks to a smart student reviewing my ugly code, here is another
minor fix for the serial driver.

Jan


--------------040908070508080803030204
Content-Type: text/plain;
 name="16550A-1.1.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A-1.1.1.patch"

Index: drivers/16550A/16550A.c
===================================================================
--- drivers/16550A/16550A.c	(revision 14)
+++ drivers/16550A/16550A.c	(working copy)
@@ -516,8 +516,8 @@
 }
 
 
-int rt_16550_ioctl_rt(struct rtdm_dev_context *context,
-                      rtdm_user_info_t *user_info, int request, void *arg)
+int rt_16550_ioctl(struct rtdm_dev_context *context,
+                   rtdm_user_info_t *user_info, int request, void *arg)
 {
     struct rt_16550_context *ctx;
     int                     ret = 0;
@@ -639,6 +639,9 @@
             rtdm_lockctx_t      lock_ctx;
             rtdm_toseq_t        timeout_seq;
 
+            if (!rtdm_in_rt_context())
+                return -EPERM;
+
             /* only one waiter allowed, stop any further attempts here */
             if (test_and_set_bit(0, &ctx->ioc_event_lock))
                 return -EBUSY;
@@ -980,8 +983,8 @@
         close_rt:       rt_16550_close,
         close_nrt:      rt_16550_close,
 
-        ioctl_rt:       rt_16550_ioctl_rt,
-        ioctl_nrt:      rt_16550_ioctl_rt,
+        ioctl_rt:       rt_16550_ioctl,
+        ioctl_nrt:      rt_16550_ioctl,
 
         read_rt:        rt_16550_read,
         read_nrt:       NULL,
@@ -999,7 +1002,7 @@
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
     driver_name:        "rt_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 1, 0),
+    driver_version:     RTDM_DRIVER_VER(1, 1, 1),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };

--------------040908070508080803030204--

--------------enigC20F93357141765CCB06EEDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSkcZncNeS9Q0k+IRAmB2AJ0duzo7es+cjguwLlnI0gSf0t9cBQCgxnxk
plcLjLHazIXKM96ow90hSi8=
=8ptk
-----END PGP SIGNATURE-----

--------------enigC20F93357141765CCB06EEDB--

