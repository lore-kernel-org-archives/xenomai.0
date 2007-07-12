Message-ID: <4696A9BE.4090008@domain.hid>
Date: Fri, 13 Jul 2007 00:22:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4696082A.5090006@domain.hid> <1184261926.6014.157.camel@domain.hid>
In-Reply-To: <1184261926.6014.157.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF05FA3EC29442F866F092CC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xenomai release check
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF05FA3EC29442F866F092CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-07-12 at 10:53 +0000, St=E9phane ANCELOT wrote:
>> Hi,
>>
>> Is it possible to setup a function that returns the xeno version strin=
g ?
>>
>=20
> Have a look at XENO_VERSION_CODE and friends in nucleus/version.h

I think Stephan has a different problem:

>=20
>> In cross compiled environment, this will permit to check at runtime th=
at
>> you are running the program with the expected xeno libraries !!!
>>
>> We have had following problem on the target we setted up:
>> kernel modules were right, but usr/xenomai/libs  were coming from an
>> older xeno release !!
>> at runtime , our program had some bad issues !

He dynamically linked against some old Xenomai lib over a new kernel,
right? That should be caught by the ABI check on library init these
days. Stephan, can you tell us which versions where involved here?

Jan


--------------enigDF05FA3EC29442F866F092CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGlqm+niDOoMHTA+kRApp2AJ9ZpbO1qwiQKgpROrxXsGfkXV7QhQCdGJ/1
gDDqxfIXAKnhWjBgb4g7kMY=
=mmgU
-----END PGP SIGNATURE-----

--------------enigDF05FA3EC29442F866F092CC--

