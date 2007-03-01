Message-ID: <45E7371B.6080406@domain.hid>
Date: Thu, 01 Mar 2007 21:27:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] warnings and tangled threads.
References: <bc4264770702271525q6d5d164lfa34b421a64eeb70@domain.hid>	
	<45E5357B.4090107@domain.hid> <45E53FF0.7050200@domain.hid>	
	<45E58964.5040304@domain.hid>
	<bc4264770703011151r41b38f80m4e1dd3288ba08053@domain.hid>
In-Reply-To: <bc4264770703011151r41b38f80m4e1dd3288ba08053@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7FBFC7C24C2C4159BB877B06"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FBFC7C24C2C4159BB877B06
Content-Type: multipart/mixed; boundary="------------090001040002040508070003"

This is a multi-part message in MIME format.
--------------090001040002040508070003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> My hardware has arrived. Well some of it, the rest should be coming
> tomorrow. So will be testing the CAN functionality for real if I
> finally get some time to work on this project other than at night. :(
>=20
> In the mean time I still wanted to squeeze in applying the patch
> below. However it fails, says something like
>=20
> Hunk1 failed at line 295
> Hunk2 succeeded.......
>=20
> 1 out of 2 failed.
>=20
> This is what I did:
> Put your patch in a file rtdmpatch in the root of the install (not the
> source) directory. Then ran
> patch -p0 < rtdmpatch.
>=20
> What am I doing wrong? Running it in the root of the source directory
> won't make a difference will it?
>=20

Some mail clients tend to mess with inlined patches. I attached it as
file, applicable against v2.3.x (trunk already contain the fix).

Jan

--------------090001040002040508070003
Content-Type: text/plain;
 name="rtdm-warning.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-warning.patch"

Index: include/rtdm/rtdm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm.h	(Revision 2270)
+++ include/rtdm/rtdm.h	(Arbeitskopie)
@@ -268,13 +268,22 @@ static inline ssize_t rt_dev_recvfrom(in
                                       struct sockaddr *from,
                                       socklen_t *fromlen)
 {
-    struct iovec    iov =3D {buf, len};
-    struct msghdr   msg =3D
-        {from, (from !=3D NULL) ? *fromlen : 0, &iov, 1, NULL, 0};
-    int             ret;
+    struct iovec iov =3D {
+        .iov_base =3D buf,
+        .iov_len =3D len
+    };
+    struct msghdr msg =3D {
+        .msg_name =3D from,
+        .msg_namelen =3D from ? *fromlen : 0,
+        .msg_iov =3D &iov,
+        .msg_iovlen =3D 1,
+        .msg_control =3D NULL,
+        .msg_controllen =3D 0
+    };
+    int ret;
=20
     ret =3D rt_dev_recvmsg(fd, &msg, flags);
-    if ((ret >=3D 0) && (from !=3D NULL))
+    if (ret >=3D 0 && from)
         *fromlen =3D msg.msg_namelen;
     return ret;
 }
@@ -318,9 +327,18 @@ static inline ssize_t rt_dev_sendto(int=20
                                     int flags, const struct sockaddr *to=
,
                                     socklen_t tolen)
 {
-    struct iovec    iov =3D {(void *)buf, len};
-    struct msghdr   msg =3D
-        {(struct sockaddr *)to, tolen, &iov, 1, NULL, 0};
+    struct iovec iov =3D {
+        .iov_base =3D (void *)buf,
+        .iov_len =3D len
+    };
+    struct msghdr msg =3D {
+        .msg_name =3D (struct sockaddr *)to,
+        .msg_namelen =3D tolen,
+        .msg_iov =3D &iov,
+        .msg_iovlen =3D 1,
+        .msg_control =3D NULL,=20
+        .msg_controllen =3D 0
+    };
=20
     return rt_dev_sendmsg(fd, &msg, flags);
 }

--------------090001040002040508070003--

--------------enig7FBFC7C24C2C4159BB877B06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5zcbniDOoMHTA+kRAn46AJ0Y6yPw+EfhB1G9klbF0xyUMB9QowCff26E
jdWiH/Ru32UpxcIjnaLYQn0=
=zyN4
-----END PGP SIGNATURE-----

--------------enig7FBFC7C24C2C4159BB877B06--

