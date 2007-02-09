Message-ID: <45CCEB58.8020103@domain.hid>
Date: Fri, 09 Feb 2007 22:44:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC6F73CF7B793DC4F23F15BA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xnpod_suspend_thread and past absolute timeouts
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
--------------enigDC6F73CF7B793DC4F23F15BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

RTnet revealed a problem of rtdm_task_sleep_until in trunk. When being
called with a past date, it blocks forever because xnpod_suspend_thread
considers such timeouts as infinite:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c?v=3D=
SVN-trunk#1456

Are there users relying on this property of xnpod_suspend_thread? If
yes, I would unfortunately have to catch this case in RTDM.

Jan


--------------enigDC6F73CF7B793DC4F23F15BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzOteniDOoMHTA+kRArWmAJsEiYlxJV/Uvlaa/3IB15zo+3RXIwCeLBGf
lU2oug20RPO9tYIuJ9XAibI=
=1CvU
-----END PGP SIGNATURE-----

--------------enigDC6F73CF7B793DC4F23F15BA--

