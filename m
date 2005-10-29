Message-ID: <4363318A.1000604@domain.hid>
Date: Sat, 29 Oct 2005 10:23:38 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig665C08EF56BB7729383D31D2"
Subject: [Xenomai-core] [patch] clearify 16550A readme
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
--------------enig665C08EF56BB7729383D31D2
Content-Type: multipart/mixed; boundary="------------020100070502010809090909"

This is a multi-part message in MIME format.
--------------020100070502010809090909
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hope this improves the understandability.

Jan

--------------020100070502010809090909
Content-Type: text/x-patch;
 name="16550A-readme.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A-readme.patch"

Index: drivers/16550A/README
===================================================================
--- drivers/16550A/README	(Revision 86)
+++ drivers/16550A/README	(Arbeitskopie)
@@ -21,10 +21,14 @@
                      [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
 
 Arguments:
-    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
-    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
-    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>, default is 16
+    ioaddr      - I/O addresses of the devices, comma separated
+                  (e.g. "0x3f8,0x2f8")
+    irq         - interrupt numbers of the devices, comma separated
+                  (e.g. "4,3")
+    tx_fifo     - Transmitter FIFO sizes of the devices in bytes, comma
+                  separated, default is 16
     start_index - First device instance number to be used, default is 0
+                  (=> "rtser0")
 
 
 Usage

--------------020100070502010809090909--

--------------enig665C08EF56BB7729383D31D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYzGKncNeS9Q0k+IRAvAKAKDai7z3iG8sRn+Wwm635JSk+rYhUACfVDKo
xe8Li/ODVaA63V3M/GbS1rI=
=ARpk
-----END PGP SIGNATURE-----

--------------enig665C08EF56BB7729383D31D2--

