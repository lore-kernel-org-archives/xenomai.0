Message-ID: <44DA6D99.9090502@domain.hid>
Date: Thu, 10 Aug 2006 01:19:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] -EINTR using rt_pipe_read with TM_INFINITE
References: <58356.127.0.0.1.1155128979.squirrel@domain.hid>
In-Reply-To: <58356.127.0.0.1.1155128979.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D237E31D60E7D524FD43B26"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jacques GANGLOFF <jacques@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D237E31D60E7D524FD43B26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jacques GANGLOFF wrote:
> Hi,
>=20
> I did this little test :
>=20
> Below I have attached two sources, one on the kernel side and one on th=
e
> user side.
> I do here a very simple fifo handshaking test. I insert the kernel modu=
le
> then I run the user program. When I do the test with the "THE BUG IS HE=
RE"
> line commented, I got :
>=20
> root@domain.hid# ./user
> user : j'ai envoy=E9 A
> user :j'ai bien re=E7u E
> root@domain.hid# dmesg
> hello world
> kernel : j'ai bien re=E7u A
> kernel : ret =3D 1
> kernel :j'ai envoy=E9 E
>=20
> Now, when I uncomment the line :
> root@domain.hid# ./user
> user : j'ai envoy=E9 A
> [CRTL-C] because the user program is blocking ...
> root@domain.hid# dmesg
> hello world
> kernel : j'ai bien re=E7u A
> kernel : ret =3D -4
> kernel :j'ai envoy=E9 E
>=20

That looks like a correct behaviour to me: the kernel module is trying
to read from pipe1 (MyPipe0, /dev/rtp0) and is blocked on it. The
user-space tool tries to do the same (is this intended BTW?). Then the
user-space program gets terminate, thus pipe1 is cleaned up. During that
cleanup all RT-readers on the pipe are woken up with -EINTR as return
code [1].

>=20
> Now, ret=3D-4 is the code for -EINTR. According to the doc :
> "-EINTR is returned if rt_task_unblock() has been called for the waitin=
g
> task before any data was available."
>=20
> I cannot see where rt_task_unblock() could be called. What is wrong ?
>=20

Ok, the documentation is insufficient here. We should actually add the
second reason for EINTR as sketched above.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pipe.c#=
L607


--------------enig2D237E31D60E7D524FD43B26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE2m2eniDOoMHTA+kRAn/eAJ46wd8F0iR6cgWMs23TktyTeomPrQCfWLtx
FrKXtMwUxV/tnmoayQGvs8w=
=snvl
-----END PGP SIGNATURE-----

--------------enig2D237E31D60E7D524FD43B26--

