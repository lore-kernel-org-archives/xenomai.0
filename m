Message-ID: <457EA179.5070606@domain.hid>
Date: Tue, 12 Dec 2006 13:32:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid>
	<1165778549.8255.17.camel@domain.hid>		<457CA36C.5060805@domain.hid>
	<1165828053.5025.8.camel@domain.hid> <457D23CA.0@domain.hid>
	<457E6A01.4090500@domain.hid>
In-Reply-To: <457E6A01.4090500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE5FB30458F40AFCB744132F"
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
--------------enigBE5FB30458F40AFCB744132F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> On Mon, 2006-12-11 at 01:16 +0100, Jan Kiszka wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>> On Sun, 2006-12-10 at 11:21 +0100, Jan Kiszka wrote:
>>>>>
>>>>>> The only part of the Xenomai user-space package not yet following
>>>>>> standard installation rules is the testsuite. It gets installed to=

>>>>>> $prefix/testsuite, by default /usr/testsuite. The attached patch i=
s an
>>>>>> approach to overcome this unusual layout.
>>>>> Ack. Implementation-wise, we have to fix the following though:
>>>>>
>>>>> xeno-load.in needs to be fixed, so that passing a single dot as arg=
ument
>>>>> correctly picks the default runinfo target in the current directory=
=2E
>>>>> This currently does not work as expected.
>>>> [obviously now fixed in svn]
>>>>
>>>>
>>>>> The second patch works around a problem with sudo relying on the
>>>>> contents of the user's PATH variable. This won't work for people us=
ing a
>>>>> version of sudo compiled with the secure path option by their favou=
rite
>>>>> distro. In that case, /usr/xenomai/bin (or whatever the user picked=
 to
>>>>> install xenomai) won't appear in that secure path, so the binary pr=
ogram
>>>>> given in the runinfo file won't be found. A possible option is to
>>>>> provide a relative path to locate the binary program,
>>>>> e.g. ../../../../bin/latency for the latency test, as the example p=
atch
>>>>> shows. Not pretty, but the other way would need to autoconfiscate t=
he
>>>>> runinfo files, or at least run them through sed before installing, =
so
>>>>> that we could substitute some placeholder with $exec_prefix.
>>>> Relative paths are not fully safe,=20
>>> Why, provided the sudo sub-shell in xeno-load changes dir to the
>>> target_dir variable contents?
>>>
>>
>> Because exec_prefix (=3D>bindir) may be different from prefix
>> (=3D>pkgdatadir), thus there is no fixed relation between the .runinfo=

>> location and the binaries until after the installation.
>=20
> Since the testsuite scripts are supposed to be run on the target, I
> think they should be installed under exec_prefix.
>=20

I didn't come across some scenario yet where I had to split exec_prefix
from prefix. So I followed this definition:

"Generally, $(exec_prefix) is used for directories that contain
machine-specific files (such as executables and subroutine libraries),
while $(prefix) is used directly for other directories."

As the scripts just like the .runinfos are certainly
machine-independent, my feeling is that prefix is the right thing.

Jan



--------------enigBE5FB30458F40AFCB744132F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfqF5niDOoMHTA+kRAravAJ49Kt8PjoG0Pr8viI3LMOHJve0qTwCcC6Ii
M8sTNYGp3Hqo6YkcwBX2pWY=
=lBiC
-----END PGP SIGNATURE-----

--------------enigBE5FB30458F40AFCB744132F--

