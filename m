Message-ID: <439AEBA5.1090502@domain.hid>
Date: Sat, 10 Dec 2005 15:52:21 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix rt_task_delete for cancellable   
	rt-threads
References: <43987EA2.9000504@domain.hid>
	<4399E194.6020403@domain.hid>
In-Reply-To: <4399E194.6020403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21F8A596860BC15089250C13"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21F8A596860BC15089250C13
Content-Type: multipart/mixed; boundary="------------080600060102010005050605"

This is a multi-part message in MIME format.
--------------080600060102010005050605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

really hope we can close this issue soon, but I managed to add another
regression with my fix (rt_task_delete(NULL) caused seg-faults, e.g. in
latency). Please apply the attached path against current SVN.

Jan

--------------080600060102010005050605
Content-Type: text/plain;
 name="rt_task_delete.patch.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_task_delete.patch.fix"

Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(Revision 251)
+++ src/skins/native/task.c	(Arbeitskopie)
@@ -206,9 +206,11 @@
 {
     int err;
 
-    err = pthread_cancel((pthread_t)task->opaque2)
-    if (err)
-        return -err;
+    if (task) {
+	err = pthread_cancel((pthread_t)task->opaque2);
+	if (err)
+	    return -err;
+    }
 
     err = XENOMAI_SKINCALL1(__native_muxid,
 			    __native_task_delete,

--------------080600060102010005050605--

--------------enig21F8A596860BC15089250C13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmuuqncNeS9Q0k+IRAtAbAKDnKVqJCR6f9bi88s/Gz9OmwjqeAACeOGyK
4TaKv6cAI3EmQj9jj5ExZTs=
=aAVR
-----END PGP SIGNATURE-----

--------------enig21F8A596860BC15089250C13--

