Message-ID: <457064F3.5050300@domain.hid>
Date: Fri, 01 Dec 2006 18:22:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
In-Reply-To: <45705C11.2010502@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3B30FFFA836869C92A748305"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B30FFFA836869C92A748305
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> the new Xenomai example repository has been created. I don't want to
>> repeat here what is explained already on the related wiki page, please=

>> have a look at
>>
>>     http://www.xenomai.org/index.php/Examples
>>
>> Instead, let me sketch what could be done next:
>>
>>  o Port existing examples, snippets, demos from ksrc/skins/* over, mak=
e
>>    them compilable and runnable if required.
>>
>>  o Identify what kind of examples are lacking. You, the user, is neede=
d
>>    here. What do *you* think is missing, what would be helpful to show=
?
>>
>>  o Check what is needed to compile kernel-based examples over PPC 2.4.=

>>    Philippe indicated that some switches are likely missing (x86 is fi=
ne
>>    already, other archs are 2.6-only).
>=20
> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
> capturing" trick to get proper switches for 2.4:
>=20
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D9493711&forum_=
id=3D24610
>=20
>=20
> We could do the same trick here.

Yeah, I had a look at this before. The point is that I would prefer to
keep things _simple_ and self-contained. This capturing requires some
helper Makefile and complex call nestings that likely only people with
advanced make and shell skills can understand and adopt to their projects=
=2E

But maybe things are that complicated already, and this is just
different complexity. How do you compile simple out-of-tree modules
against 2.4 PPC kernels? Are there any standard flags? Or is it
different for each board or each compiler version or whatever?

Jan


--------------enig3B30FFFA836869C92A748305
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFcGTzniDOoMHTA+kRAqqgAJ4nnYid1fcFdFul7hUY6/iGTnI7rwCeLqDA
Sq6YGCx8jfAsH9HN7h8k5JM=
=RZvL
-----END PGP SIGNATURE-----

--------------enig3B30FFFA836869C92A748305--

