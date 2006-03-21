Message-ID: <441F47C6.9080108@domain.hid>
Date: Tue, 21 Mar 2006 01:24:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt-video interface
References: <200603201715.08482.lbocseg@domain.hid>
In-Reply-To: <200603201715.08482.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C3F2BDAA9CE255F22D44339"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C3F2BDAA9CE255F22D44339
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan and others interested.
>=20
> I've finally got my driver in a usable condition. It lacks a lot of=20
> functionalities yet, but it aplies to my needs.
>=20
> I would like to propose a real-time video interface for using with RTDM=
=2E
>=20
> For making it simple to port Linux applications to Xenomai, I tried to =
make it=20
> as close as possible to Video for Linux 2 API. I didn't see any serious=
=20
> problem regarding its use on real-time environments in the specificatio=
n. So,=20
> the changes I think that would be necessary are:
>=20
> o Change open/fopen to rtdm_dev_open
> o Implement MMAP/MUNMAP as an IOCTL (while it can not be done in a rt-c=
ontext=20
> in the mean time, nor should be necessary)
> o Implement also as IOCTLs: select and poll (I didn't implement them on=
 my=20
> driver because I didn't need them, but it should be necessary accordlin=
g to=20
> specs)

You may want to have a look at this thread regarding poll/select and RT:

http://www.mail-archive.com/rtnet-users%40lists.sourceforge.net/msg00968.=
htm

Do video capturing applications tend to have to observe multiple
channels asynchronously via a single thread? If so, my statement about
how often poll/select is actually required in RT-applications may have
to be reconsidered.

> o Change all timeval structs to uint64_t or some typedef to it for maki=
ng it=20
> easier to store the timestamps (we use rtdm_clock_read() instead of=20
> gettimeofday())
>=20
> I can't remember of another issue now. I think these changes would be e=
nough.
>=20
> Any ideas?

Does your time allow to list the minimal generic services a RTDM video
capturing driver has to provide in a similar fashion like the serial or
the CAN profile? If it's mostly about copying existing Linux API specs,
feel free to just reference them. But the differences should certainly
fill up a RT-video (or so) profile, and that would be great!

Jan


--------------enig3C3F2BDAA9CE255F22D44339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEH0fGniDOoMHTA+kRAhkJAJ9lPo4mHgTzIr4eJJeap8F1+yBV6gCdHZwE
73Ji3qJxJhalLFl2kR7ZGSQ=
=8meQ
-----END PGP SIGNATURE-----

--------------enig3C3F2BDAA9CE255F22D44339--

