Message-ID: <4601A701.6070802@domain.hid>
Date: Wed, 21 Mar 2007 22:43:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Socket Buffer overflow
References: <460191E0.7020606@domain.hid> <4601993C.5010701@domain.hid>
	<4601A451.7090408@domain.hid>
In-Reply-To: <4601A451.7090408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC774DE398DD7DE09F55A60A3"
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
To: Robin Walser <robinwalser45@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC774DE398DD7DE09F55A60A3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Robin Walser wrote:
>=20
>> Are you using RT-Socket-CAN? Could you please provide more detailed
>> information like what is the returned error code and are there kernel
>> log messages (visible with $ dmsg)?
>>
>> Wolfgang.
> My programm based on frag-ip:
> http://www.rts.uni-hannover.de/rtnet/lxr/source//examples/xenomai/nativ=
e/frag-ip.c

[Hmm, might be tricky to tell apart, but this is now an example for a
RTnet-specific question =3D> rtnet-user list. If it wasn't, xenomai-help
would have been the preferred place for support requests.]

>=20
> I use RTnet. The returned error code is always -115 and I have no kerne=
l
> log messages.
> I think, I'm only need a buffer status report. Is this available?

Are you sure it's 115? Anyway, buffer overflows can happen if you sent
out frames at a higher rate than hardware can handle. Throttle your
transmission, at least once that error pops up.

But what is your desired transmission rate after all? Why not set up a
periodic transmission task, either waiting for timer events or on the
RTmac/TDMA cycle (if you use TDMA with RTnet)?

Jan


--------------enigC774DE398DD7DE09F55A60A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGAacBniDOoMHTA+kRAuFfAJ9D/QQ0PA8MPmtNacXRd7F/TSvICgCfXLsR
daLpEPtmlTHfjwftSl4GLpM=
=byqg
-----END PGP SIGNATURE-----

--------------enigC774DE398DD7DE09F55A60A3--

