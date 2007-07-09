Message-ID: <469250F0.9080601@domain.hid>
Date: Mon, 09 Jul 2007 17:14:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>
	<4692501E.1060108@domain.hid>
In-Reply-To: <4692501E.1060108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0496DD7875C1E4207D8F61A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0496DD7875C1E4207D8F61A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> the attached patch changes:
>>>>
>>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>>>
>>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.=

>>>>
>>> Merged, thanks.
>>
>> You are too fast for me - I was still test-building my approach!
>=20
> Too fast? My i-Pipe patched Linux 2.4 kernel did simply not built ;-).

Yeah, and my 2.4 kernel was lying around in the corner, slightly dusty,
definitely not touched for several months.

Hell, the amount of regressions one (specifically I) can produce due to
all this config variants is amazing. What would be really nice is a
playground for patches, some build system you could post a patch series
and a set of .configs to and that will then "simply" try to generate
various kernels and the xenomai userland for various archs
automatically, reporting back any errors or warnings. Without going
through SVN with the changes every time. Just a dream.

Jan


--------------enigA0496DD7875C1E4207D8F61A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGklDwniDOoMHTA+kRAilqAJ4nxWgFNvkZOFLTjUn0La+oHCI+CACfRrDM
vNln3Pj0Eo6/6VSyj7HfivE=
=oggt
-----END PGP SIGNATURE-----

--------------enigA0496DD7875C1E4207D8F61A--

