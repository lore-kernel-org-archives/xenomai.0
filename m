Message-ID: <45CA5AFD.9020805@domain.hid>
Date: Thu, 08 Feb 2007 00:04:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE6A53ED0C192805423BAEED"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Linux lock-up with rtcanrecv
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE6A53ED0C192805423BAEED
Content-Type: multipart/mixed; boundary="------------080901030205000709080500"

This is a multi-part message in MIME format.
--------------080901030205000709080500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

fiddling with latest Xenomai trunk and 2.3.x on one of our robots (there
is still a bug in trunk /wrt broken timeouts of rt_dev_read on
xeno_16550A - different issue...), I ran into a weird behaviour of
rtcanrecv:

I have a continuous stream of a few thousand packets/s towards the
robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or one +
our own receiver application), the second one causes a Linux lock-up.
Sometimes this happens during startup of the second rtcanrecv, but at
latest on its termination. Other RT tasks are still running. I can
resolve the lock-up by pulling the CAN cable, everyone is fine
afterwards and can be cleaned up. I played with quite a few combinations
of recent ipipe patches and Xenomai revisions (even back to #1084 in
v2.3.x), no noticeable difference.

Seems like I have to take a closer look - once time permits and the
robot is available. So any ideas or attempts to reproduce this are
welcome, current .config attached (no magic knob found there yet).

Jan


PS: Wolfgang, any objections against "decoupling" -v from -p and
lowering the receiver priority to 0?

Index: src/utils/can/rtcanrecv.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/utils/can/rtcanrecv.c	(revision 2146)
+++ src/utils/can/rtcanrecv.c	(working copy)
@@ -192,6 +192,7 @@ int main(int argc, char **argv)

 	case 'p':
 	    print =3D strtoul(optarg, NULL, 0);
+	    break;

 	case 'v':
 	    verbose =3D 1;
@@ -312,7 +313,7 @@ int main(int argc, char **argv)
     }

     snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
-    ret =3D rt_task_shadow(&rt_task_desc, name, 1, 0);
+    ret =3D rt_task_shadow(&rt_task_desc, name, 0, 0);
     if (ret) {
 	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
 	goto failure;


--------------080901030205000709080500
Content-Type: application/octet-stream;
 name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config.bz2"

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
FOFCQew2Tzg=
--------------080901030205000709080500--

--------------enigAE6A53ED0C192805423BAEED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFylr9niDOoMHTA+kRApL+AJ9buhSyFUKMj/KcBmOwdy2mzwtnQACfUl+E
npiSmwWLV6tgisPjJNwpLrk=
=HVMk
-----END PGP SIGNATURE-----

--------------enigAE6A53ED0C192805423BAEED--

