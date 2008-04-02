Message-ID: <47F34C0D.6090809@domain.hid>
Date: Wed, 02 Apr 2008 11:04:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
In-Reply-To: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig02F675164243A57E6BEA8982"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig02F675164243A57E6BEA8982
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Cornelius K=F6pp wrote:
> Hello,
> I run the latency test from testsuite on several hard and software conf=
igurations. Running on Xenomai 2.4.2, Linux 2.6.24 the results shows a "s=
trange" behavior: In Kernel mode (-t1) the latencys constantly linear dec=
rease. See attached plot 'drifting_latencys_in_kernelmode.png' of latency=
 test running 48h on Pentium3 700. This effect could be reproduced, even =
on other hardware (Pentium-M 1400).

As our P3 boards did not support APIC-based timing (IIRC), your kernel=20
has correctly disabled the related kernel support. But the Pentium M=20
should be fine. So could you check if we are seeing some TSC clocks vs.=20
PIT timer rounding issue by enabling the local APIC on the Pentium M?

> The usermode (-t0) did not show a drifting, but is influenced by a test=
 ran in kernelmode before.

What do you mean with "is influenced"?

>=20
> I talked with Sebastian Smolorz about this and he builds his own indepe=
ndent kernel-config to check. He got the same drifting-effect with Xenoma=
i 2.4.2 and Xenomai 2.4.3 running latency over several hours. His kernel-=
config ist attached as 'config-2.6.24-xenomai-2.4.3__ssm'.
>=20
> Our kernel-configs are both based on a config used with Xenomai 2.3.4 a=
nd Linux 2.6.20.15 without any drifting effects.

2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it is not=20
a PIC vs. APIC thing, but rather a rounding problem of larger TSC values =

(that naturally show up when the system runs for a longer time).

Jan


--------------enig02F675164243A57E6BEA8982
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH80wTniDOoMHTA+kRAmYkAJ0dAMz9mxsYfmCfiRk5AWFjb4gEGgCfcgMl
wnpaECZQmbD598ZRPTICz80=
=BgTS
-----END PGP SIGNATURE-----

--------------enig02F675164243A57E6BEA8982--

