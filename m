Message-ID: <4A0335C9.7060708@domain.hid>
Date: Thu, 07 May 2009 21:26:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33078D69D037AAAE24F2938C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] posix: Improve access checks in select
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33078D69D037AAAE24F2938C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ Please pull from git://git.xenomai.org/xenomai-jki.git for-upstream ]

Add missing range checks for select parameters and refactor the code.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/posix/syscall.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index c7950a6..4a5830e 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -2345,15 +2345,17 @@ static int __select(struct pt_regs *regs)
 	struct timeval tv;
 	pthread_t thread;
 	int i, err, nfds;
+	size_t fds_size;
=20
 	thread =3D pse51_current_thread();
 	if (!thread)
 		return -EPERM;
=20
 	if (__xn_reg_arg5(regs)) {
-		if (__xn_copy_from_user(&tv,
-					(void __user *)__xn_reg_arg5(regs),
-					sizeof(tv)))
+		if (!access_wok((void __user *)__xn_reg_arg5(regs), sizeof(tv))
+		    || __xn_copy_from_user(&tv,
+					   (void __user *)__xn_reg_arg5(regs),
+					   sizeof(tv)))
 			return -EFAULT;
=20
 		if (tv.tv_usec > 1000000)
@@ -2364,15 +2366,16 @@ static int __select(struct pt_regs *regs)
 	}
=20
 	nfds =3D __xn_reg_arg1(regs);
+	fds_size =3D __FDELT(nfds + __NFDBITS - 1) * sizeof(long);
=20
 	for (i =3D 0; i < XNSELECT_MAX_TYPES; i++)
 		if (ufd_sets[i]) {
 			in_fds[i] =3D &in_fds_storage[i];
 			out_fds[i] =3D & out_fds_storage[i];
-			if (__xn_copy_from_user(in_fds[i],
-						(void __user *) ufd_sets[i],
-						__FDELT(nfds + __NFDBITS - 1)
-						* sizeof(long)))
+			if (!access_wok((void __user *) ufd_sets[i], fds_size)
+			    || __xn_copy_from_user(in_fds[i],
+						   (void __user *) ufd_sets[i],
+						   fds_size))
 				return -EFAULT;
 		}
=20


--------------enig33078D69D037AAAE24F2938C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkoDNckACgkQniDOoMHTA+k4BgCfR4rPJtAY/Ws+rtgiR5R92QQ2
XN8AnipZqi8X9w8UdjlzyeuAuA6bIhzY
=ylAm
-----END PGP SIGNATURE-----

--------------enig33078D69D037AAAE24F2938C--

