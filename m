Message-ID: <43B26C65.7020807@domain.hid>
Date: Wed, 28 Dec 2005 11:43:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD03B331B3EAD9E19892EB1C3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fixing modprobe hint in libs
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
--------------enigD03B331B3EAD9E19892EB1C3
Content-Type: multipart/mixed; boundary="------------070800060007000307000304"

This is a multi-part message in MIME format.
--------------070800060007000307000304
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this patches fixes the hint a user sees when trying to start some
RT-application without the related core service being available. Might
be frustrating for a newbie if the suggested command fails...

Jan

--------------070800060007000307000304
Content-Type: text/x-patch;
 name="modprobe_hint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprobe_hint.patch"

Index: src/skins/uvm/init.c
===================================================================
--- src/skins/uvm/init.c	(Revision 304)
+++ src/skins/uvm/init.c	(Arbeitskopie)
@@ -56,7 +56,7 @@
 	case -ESRCH:
 
 	    fprintf(stderr,"Xenomai: UVM skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_uvm.ko?)\n");
+	    fprintf(stderr,"(modprobe xeno_uvm?)\n");
 	    exit(1);
 
 	default:
Index: src/skins/rtai/init.c
===================================================================
--- src/skins/rtai/init.c	(Revision 304)
+++ src/skins/rtai/init.c	(Arbeitskopie)
@@ -53,7 +53,7 @@
 	case -ESRCH:
 
 	    fprintf(stderr,"Xenomai: RTAI skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_rtai.ko?)\n");
+	    fprintf(stderr,"(modprobe xeno_rtai?)\n");
 	    exit(1);
 
 	default:
Index: src/skins/posix/init.c
===================================================================
--- src/skins/posix/init.c	(Revision 304)
+++ src/skins/posix/init.c	(Arbeitskopie)
@@ -59,7 +59,7 @@
 	case -ESRCH:
 
 	    fprintf(stderr,"Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_posix.ko?)\n");
+	    fprintf(stderr,"(modprobe xeno_posix?)\n");
 	    exit(1);
 
 	default:
Index: src/skins/native/init.c
===================================================================
--- src/skins/native/init.c	(Revision 304)
+++ src/skins/native/init.c	(Arbeitskopie)
@@ -65,7 +65,7 @@
 	case -ESRCH:
 
 	    fprintf(stderr,"Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_native.ko?)\n");
+	    fprintf(stderr,"(modprobe xeno_native?)\n");
 	    exit(1);
 
 	default:

--------------070800060007000307000304--

--------------enigD03B331B3EAD9E19892EB1C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsmxpniDOoMHTA+kRAoU0AJ46DRxXPkZJoMsQe4al1/GQZ9vRtwCeN5tB
PlUZoC6ej9qakqg4ve/RKLE=
=hUA+
-----END PGP SIGNATURE-----

--------------enigD03B331B3EAD9E19892EB1C3--

