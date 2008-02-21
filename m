Message-ID: <47BD316D.3070801@domain.hid>
Date: Thu, 21 Feb 2008 09:08:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200802202358.25792.ngustavson@domain.hid>
In-Reply-To: <200802202358.25792.ngustavson@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58418B6871FDBD9C905C0EA9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] writing from user space through fifo problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <metalninjadragon@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58418B6871FDBD9C905C0EA9
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

NZG wrote:
> I've got 2 programs, one Xenomai user space real time thread and one no=
rmal=20
> user space program.
>=20
> My normal user space is trying to pass a structure to my real time prog=
ram and=20
> failing.
>=20
> my RT thread reads in a 1ms loop with:
> err =3D rt_pipe_read(control_pipe,k,sizeof(control_t),TM_NONBLOCK);
>=20
> my regular linux program writes a real time fifo with:
>=20
> int fd =3D open(dev, O_WRONLY|O_SYNC);
> err =3D write(fd,&c,sizeof(c));
> if(err<=3D0)error(0,-err, "write failed  with %d",err);
> close(fd);
>=20
> The user space program succeeds (write returns no error and doesn't blo=
ck),=20
> but the RT thread never see's the data, continually returning -EINTR.

Are you sure it is EINTR? A first glance at the possible code path,
specifically at xnpipe_recv, suggests that you cannot reach the line
returning this error code if TM_NONBLOCK was passed.

What Xenomai version are we talking about BTW? And, as usual:
self-contained simple test cases are always appreciated. :)

Jan


--------------enig58418B6871FDBD9C905C0EA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHvTF1niDOoMHTA+kRAoVSAJ920tpcwMvOAAckSj7x13oUzVqhDQCZAdSk
5r/sGEuF9/uVL5vfOWEhsuI=
=v/4h
-----END PGP SIGNATURE-----

--------------enig58418B6871FDBD9C905C0EA9--

