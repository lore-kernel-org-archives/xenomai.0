Message-ID: <457D23CA.0@domain.hid>
Date: Mon, 11 Dec 2006 10:24:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid> <1165778549.8255.17.camel@domain.hid>	
	<457CA36C.5060805@domain.hid> <1165828053.5025.8.camel@domain.hid>
In-Reply-To: <1165828053.5025.8.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1090DAC909D4C239814EE650"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1090DAC909D4C239814EE650
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-12-11 at 01:16 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2006-12-10 at 11:21 +0100, Jan Kiszka wrote:
>>>> The only part of the Xenomai user-space package not yet following
>>>> standard installation rules is the testsuite. It gets installed to
>>>> $prefix/testsuite, by default /usr/testsuite. The attached patch is =
an
>>>> approach to overcome this unusual layout.
>>> Ack. Implementation-wise, we have to fix the following though:
>>>
>>> xeno-load.in needs to be fixed, so that passing a single dot as argum=
ent
>>> correctly picks the default runinfo target in the current directory.
>>> This currently does not work as expected.
>> [obviously now fixed in svn]
>>
>>> The second patch works around a problem with sudo relying on the
>>> contents of the user's PATH variable. This won't work for people usin=
g a
>>> version of sudo compiled with the secure path option by their favouri=
te
>>> distro. In that case, /usr/xenomai/bin (or whatever the user picked t=
o
>>> install xenomai) won't appear in that secure path, so the binary prog=
ram
>>> given in the runinfo file won't be found. A possible option is to
>>> provide a relative path to locate the binary program,
>>> e.g. ../../../../bin/latency for the latency test, as the example pat=
ch
>>> shows. Not pretty, but the other way would need to autoconfiscate the=

>>> runinfo files, or at least run them through sed before installing, so=

>>> that we could substitute some placeholder with $exec_prefix.
>> Relative paths are not fully safe,=20
>=20
> Why, provided the sudo sub-shell in xeno-load changes dir to the
> target_dir variable contents?
>=20

Because exec_prefix (=3D>bindir) may be different from prefix
(=3D>pkgdatadir), thus there is no fixed relation between the .runinfo
location and the binaries until after the installation.


--------------enig1090DAC909D4C239814EE650
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfSPKniDOoMHTA+kRAs5GAJ49pE2dqDJQO+AfLQoIz0SGOfOUjACeJLpt
yvmfvB0Z2oel3UGxPXZim9A=
=T2jw
-----END PGP SIGNATURE-----

--------------enig1090DAC909D4C239814EE650--

