Message-ID: <44CF691C.30706@domain.hid>
Date: Tue, 01 Aug 2006 16:45:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>	
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>	
	<200607282317.34990.bidsonux@domain.hid>
	<44CB6EB3.5070707@domain.hid>	 <1154282619.4970.25.camel@domain.hid>
	<44CD099F.9010507@domain.hid>	 <1154294584.4970.49.camel@domain.hid>	
	<17613.60380.820599.627459@domain.hid>	
	<1154355564.5015.12.camel@domain.hid> <1154442627.4963.21.camel@domain.hid>
In-Reply-To: <1154442627.4963.21.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4726B93D21E90E8C7A50F75"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] tame the watchdog (was: Beginner's question /
	testsuite / latency)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4726B93D21E90E8C7A50F75
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>> Still, reinitializing X while the latency test runs causes
>> the latter to hang, albeit LOC is still flowing properly and the box
>> keeps going normally.
>=20
> This one was due to the nucleus watchdog which triggered right after th=
e
> graphic mode was fully initialized, due to the huge amount of
> unpreemptible time spent doing this; this caused the sampling task to b=
e
> detected as a runaway thread. So the behaviour is ok, albeit a bit
> frightening at first.
>=20

That reminds of the unfortunate characteristics of the 2.6 oom-killer:
unless you set your time-critical app's oom_adj to -17, you are never
really safe from being killed accidentally on low-mem scenarios.

What about introducing some mechanism to protect audited tasks against
the watchdog? A simple thread flag settable via existing APIs, ignored
if there is no watchdog compiled in?

Jan


--------------enigB4726B93D21E90E8C7A50F75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEz2kcniDOoMHTA+kRAiviAJ46gjMHIpOqUEZ3cn6lr1FTio/ubgCfcprV
qPvBWhG9wj5ucn/1yqoZTFg=
=sL1B
-----END PGP SIGNATURE-----

--------------enigB4726B93D21E90E8C7A50F75--

