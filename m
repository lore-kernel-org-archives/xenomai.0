Message-ID: <44A0E712.3020604@domain.hid>
Date: Tue, 27 Jun 2006 10:06:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
References: <449A7261.7040503@domain.hid>
	<449A7602.1020004@domain.hid>	<17563.61309.258099.930934@domain.hid>	<1151079971.4438.103.camel@domain.hid>	<17564.11393.93645.251930@domain.hid>
	<17564.12674.330717.263818@domain.hid>
In-Reply-To: <17564.12674.330717.263818@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD48F692BA3ED2A92B141F80D"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD48F692BA3ED2A92B141F80D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > misinterpretation. When issuing syscalls with a fixed muxid whereas
>  > there is no interface corresponding to this muxid, the nucleus crash=
es,
>  > but it is acceptable, user-space interfaces should issue an
>  > __xn_sys_bind syscall first.
>=20
> This is not even possible, since the invalid syscall go through
> do_hisyscall_event first and get handled there.
>=20

Do I get this correctly now: problem fixed by commit #1264? Is there
still anything we should do about the RTDM lib?

Jan


--------------enigD48F692BA3ED2A92B141F80D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEoOcSniDOoMHTA+kRAogaAJ9GqSJrX/ihpbOdAp3o7KFHO4a2TACfdFT9
sjbUq+IgNW+OE/YFkVmB6rc=
=vTCH
-----END PGP SIGNATURE-----

--------------enigD48F692BA3ED2A92B141F80D--

