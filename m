Message-ID: <46010B20.4050807@domain.hid>
Date: Wed, 21 Mar 2007 11:38:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>	<17914.63535.18893.207257@domain.hid>	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>	<17920.13832.789072.876398@domain.hid>	<b647ffbd0703201721g1752e0falbe3fed8df405b3f8@domain.hid>	<17920.60301.400005.135175@domain.hid>	<4600F735.2030205@domain.hid>
	<4601059E.6040903@domain.hid>
In-Reply-To: <4601059E.6040903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DAEBC7DAA43C54BC892277E"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DAEBC7DAA43C54BC892277E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> I think implementing coloured caches (with reservations for RT
>> processes) could be an option as well. Once RT context switches no
>> longer require full cache flushes, those for non-RT processes could be=

>> made interruptible. But all this would require heavy Linux hacking, I'=
m
>> afraid.
>=20
> Using TCM removes any cache effect and does not require Linux hacking.
>=20

How is TCM managed? Can you push parts of I-pipe/Xenomai or even some
applications into it? Or does this only help here if you have a few ops
of an interrupt handler to be saved from the (RT-wise) lousy caching
architecture of ARM?

[I threw coloured caches into the ring also to trigger some discussion
on a long-term solution for MMU-based Xenomai on ARM.]

Jan


--------------enig5DAEBC7DAA43C54BC892277E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGAQsgniDOoMHTA+kRAsF+AKCCQIoD5Dq1SdrUCkYyva2MH8PY5wCfeGhs
gMOgvpf0KD4zfKD6osrH5Ic=
=pgGy
-----END PGP SIGNATURE-----

--------------enig5DAEBC7DAA43C54BC892277E--

