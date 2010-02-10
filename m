Message-ID: <4B731608.6010803@domain.hid>
Date: Wed, 10 Feb 2010 21:24:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid>
In-Reply-To: <4B730A04.9040908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9AB671F185E3BB49C38559AB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AB671F185E3BB49C38559AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> GIT version control wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-upstream
>>>> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D6=
b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>
>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>> Date:   Wed Feb 10 13:24:29 2010 +0100
>>>>
>>>> Make xnarch_init_timeconv an uninlined weak function
>>>>
>>>> Otherwise the wrong set of time conversion variables might get
>>>> initialized when using > 1 skin libraries.
>>> If that would be possible, then it is the conversion variables which
>>> should made be weak, not the function.
>>>
>>> The way I see it, the posix and native skins currently get a differen=
t
>>> set of variables and functions, which works, but with your change, si=
nce
>>> there is only one function, only one set of variable gets initialized=
 by
>>> the two function calls. And one skin just broke.
>>>
>>> Or am I missing something? Does the patch fix a problem you really ha=
d?
>> Frankly, I wasn't able to test in the field yet as replacing the libs
>> there is non-trivial. But I was able to observe that only one set of
>> functions is used - which is logical considering the weak marks. And
>> this breaks due to the static inline initialization.
>>
>> However, let's mark both functions and variables weak to fix the issue=

>> and avoid leaving unused variables around. Will update my patch in a m=
inute.
>=20
> Ok. I am reverting this patch until you provide me with another
> solution. It causes latency to segfault purely and simply at startup on=

> my dual PIII.
>=20

Cannot reproduce yet. Do you have a backtrace?

Jan


--------------enig9AB671F185E3BB49C38559AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktzFgwACgkQitSsb3rl5xSZgwCeI74w6tf6jh2BDGDiXvAQqI/H
N5cAn3VytNSVAC1kxD56lFOD9Xd+gwPq
=6RwH
-----END PGP SIGNATURE-----

--------------enig9AB671F185E3BB49C38559AB--

