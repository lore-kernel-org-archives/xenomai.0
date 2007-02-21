Message-ID: <45DC3E6C.8040905@domain.hid>
Date: Wed, 21 Feb 2007 13:43:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid>
In-Reply-To: <45DC39DE.8050802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA3C621C9B854774C2C4AC1C"
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
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA3C621C9B854774C2C4AC1C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Roland Tollenaar wrote:
>>> Hi list,
>>>
>>> does anyone have, or can anyone direct met to a project or code-snipp=
et
>>> that shows how the CAN driver in the xenomai patch is used in an
>>> application? If not that any documentation that gives and explains wh=
at
>>> calls it responds to.
>>
>> Check src/utils/can/ on some tools that can also serve as nice example=
s.
>> But maybe we should also add even simpler demo code to the examples
>> repository. Just takes someone to write them...
>=20
> The utility programs rtcanconfig, rtcansend and rtcanrcv in
> src/utils/can already demonstrate most of RT-Socket-CAN's functionality=

> including filter definition and error handling. I do not see a need for=

> simpler examples.

Yeah, maybe already a link (README) from the examples repos would be
enough to point beginners to them. Or maybe we should ask some beginners
what they expect, what they didn't understand... (Roland?)

> I have attached a patch for a nice program to measure
> the round trip time of CAN messages. It contrast to the other CAN
> utility programs, it uses the POSIX-API and works as-is for Socket-CAN
> as well. Jan, any objections to include it? If yes, I'm going to provid=
e
> a README.

On first glance, nope, looks nice and clean.

>=20
> BTW: some time ago I provided a patch to make the CAN utility programs
> part of the Doxygen documentation. IIRC, we said it's nice to have
> hyperlinked examples in general.

Some link at hand? Does it still apply? Sounds like something worth to
apply.

Jan


--------------enigFA3C621C9B854774C2C4AC1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3D5sniDOoMHTA+kRAtqgAJ9GHXstuYOlQeziMxwOzdzdwrJjSACfaIh4
Kj8FA3w4DVpcSDeBwX0XF0c=
=KLUI
-----END PGP SIGNATURE-----

--------------enigFA3C621C9B854774C2C4AC1C--

