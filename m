Message-ID: <46CDEF34.2030003@domain.hid>
Date: Thu, 23 Aug 2007 22:33:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>	<46C49070.8070807@domain.hid>
	<46C4BAB8.20103@domain.hid>	<46C559A2.6090807@domain.hid>
	<46C5E4AC.1090608@domain.hid> <46C692FD.4080302@domain.hid>
	<46C9FFDA.8030200@domain.hid>
In-Reply-To: <46C9FFDA.8030200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62FAE76F9CBE8EEA1F932BFA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM context_size question
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62FAE76F9CBE8EEA1F932BFA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

sorry for the delay - I was and still am short on time.

trem wrote:
> Hi
>=20
> Oh, I understand your point of view, and I found it fine. We do an
> example quite complete (and with some sense), and we split it into step=
=2E
>=20
> The first complete example could contain :
> - global buffer (one for all device)
> - device buffer (one for each device)
> - local buffer (one for each open)
> - synchronization: semaphore used to block read when no data are ready
> - ioctl: used to to select the active buffer (ie global, device, local)=

>=20
> Now, how to split it ? I propose :
>=20
> tut01: global buffer + read/write
> tut02: {global, device, local} buffer + ioctl + read/write
> tut03: {global, device, local} buffer + ioctl + read/write + synchroniz=
ation
>=20

Let's write the full example first, look at the result, and then decide
about the best split-up.

Jan


--------------enig62FAE76F9CBE8EEA1F932BFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGze80niDOoMHTA+kRAgOFAJ9XAn+nFTrqMF3UjdLJ5Xdexq2MYwCfQSAr
g3Fv/lbNl29jN+uHOrq2bzw=
=+Zre
-----END PGP SIGNATURE-----

--------------enig62FAE76F9CBE8EEA1F932BFA--

