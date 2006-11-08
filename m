Message-ID: <45518795.5070507@domain.hid>
Date: Wed, 08 Nov 2006 08:30:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on Athlon XP (and PIII)
References: <4550E7A6.9090408@domain.hid>
In-Reply-To: <4550E7A6.9090408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F66BC89E6F021925E10670D"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F66BC89E6F021925E10670D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I'm currently setting up a PC for Xenomai-Tests. I'm using my good old
> PC with an Athlon XP (Thunderbird) for this purpose. The kernel hangs a=
t
> boot time when I enable APIC via boot argument (lapic). With local APIC=

> disabled the kernel boots but I see some Opps messages while running th=
e
> latency test and trying a slogin to the system (in the scheduler). Are
> there any known issues with this X86 arch? I remember, that I have seen=

> similar problems with my (old) PIII-Notebook (lapic did not work).

No known issues, both scenarios *must* work, the P-III at least in PIC
mode when Linux refuses to enabled lapic on boot.

>=20
> I will be more precise when time permits.
>=20

Kind of weird that both systems fail. Compiler issue? Though there are
no known issues here as well. Well, you know the usual information
required to dig deeper...

Jan


--------------enig7F66BC89E6F021925E10670D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUYeWniDOoMHTA+kRAm1sAJ9tNb8LTQSP10jgt8ZKWod9AEncPgCfZgUi
X3I0IJC+WI2+QAp+NHYT5GU=
=c9Tg
-----END PGP SIGNATURE-----

--------------enig7F66BC89E6F021925E10670D--

