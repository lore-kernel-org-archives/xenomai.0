Message-ID: <434FC080.3000900@domain.hid>
Date: Fri, 14 Oct 2005 16:28:16 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig402C40AED4BEDE122E641538"
Subject: [Xenomai-core] Fixes for serial driver
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
--------------enig402C40AED4BEDE122E641538
Content-Type: multipart/mixed; boundary="------------090608050208080601060201"

This is a multi-part message in MIME format.
--------------090608050208080601060201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

attached are two minor fixes for the serial driver and header: one is
cosmetic, the other addresses out-of-memory detection.

Credits go, as usual, to Sebastian. ;)

Jan


--------------090608050208080601060201
Content-Type: text/plain;
 name="serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.patch"

Index: skins/rtdm/rtserial.h
===================================================================
--- skins/rtdm/rtserial.h	(revision 29)
+++ skins/rtdm/rtserial.h	(working copy)
@@ -113,7 +113,7 @@
 
 /*!
  * @anchor RTSER_xxx_PARITY   @name RTSER_xxx_PARITY
- * Number of parity bits @anchor RTSER_xxx_PARITY
+ * Number of parity bits
  * @{ */
 #define RTSER_NO_PARITY             0x00
 #define RTSER_ODD_PARITY            0x01
Index: drivers/16550A/16550A.c
===================================================================
--- drivers/16550A/16550A.c	(revision 29)
+++ drivers/16550A/16550A.c	(working copy)
@@ -568,6 +568,9 @@
                 } else
                     hist_buf =
                         rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
+
+                if (!hist_buf)
+                    return -ENOMEM;
             }
 
             rt_16550_set_config(ctx, config, &hist_buf);

--------------090608050208080601060201--

--------------enig402C40AED4BEDE122E641538
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDT8CAncNeS9Q0k+IRAgqoAJ9PP8yy6zfqA0VXYVtqwqBYUU2DPQCcCsB7
sIl6uV0oJHeiiKARtqXoo3M=
=pqqi
-----END PGP SIGNATURE-----

--------------enig402C40AED4BEDE122E641538--

