Message-ID: <4B241D1B.1030002@domain.hid>
Date: Sat, 12 Dec 2009 23:45:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1260281665.792922.9257.nullmailer@domain.hid>	<4B1E6B1B.5080306@domain.hid>	<1260370202.738468.27358.nullmailer@domain.hid>	<4B1FEC63.9070100@domain.hid>	<1260439679.561436.26932.nullmailer@domain.hid>
	<4B20E2D7.8060103@domain.hid>
In-Reply-To: <4B20E2D7.8060103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig417CD806B156CB6806292DFA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xenomai 2.4.10 - invalid opcode: 0000
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417CD806B156CB6806292DFA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> Reproducible with your .config under kvm, will investigate later.
>=20

It looks like we have a problem with CONFIG_PREEMPT on x86-SMP at the
moment (2.6.30&.31, maybe also older kernels). You may try with
CONFIG_PREEMPT_VOLUNTARY/NONE, but I can't promise that this heals the
issue, maybe it just makes it far less probable.

The corruption is easy to reproduce - but always at different spots,
thus it's very hard to catch. Still investigating.

Jan


--------------enig417CD806B156CB6806292DFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEUEARECAAYFAkskHSIACgkQitSsb3rl5xRcVwCg1Qjrmew7dA7qjCTcaVNc7Rzm
iRsAl1/xvv0k0qKhRK1AUh92ApFSFfY=
=tLBB
-----END PGP SIGNATURE-----

--------------enig417CD806B156CB6806292DFA--

