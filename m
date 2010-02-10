Message-ID: <4B73207C.6020400@domain.hid>
Date: Wed, 10 Feb 2010 22:09:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid>
In-Reply-To: <4B73180C.6070301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F8089CF261C4E78BF02DCC3"
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
--------------enig9F8089CF261C4E78BF02DCC3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> GIT version control wrote:
>>>>>> Module: xenomai-jki
>>>>>> Branch: for-upstream
>>>>>> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D=
6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>
>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>> Date:   Wed Feb 10 13:24:29 2010 +0100
>>>>>>
>>>>>> Make xnarch_init_timeconv an uninlined weak function
>>>>>>
>>>>>> Otherwise the wrong set of time conversion variables might get
>>>>>> initialized when using > 1 skin libraries.
>>>>> If that would be possible, then it is the conversion variables whic=
h
>>>>> should made be weak, not the function.
>>>>>
>>>>> The way I see it, the posix and native skins currently get a differ=
ent
>>>>> set of variables and functions, which works, but with your change, =
since
>>>>> there is only one function, only one set of variable gets initializ=
ed by
>>>>> the two function calls. And one skin just broke.
>>>>>
>>>>> Or am I missing something? Does the patch fix a problem you really =
had?
>>>> Frankly, I wasn't able to test in the field yet as replacing the lib=
s
>>>> there is non-trivial. But I was able to observe that only one set of=

>>>> functions is used - which is logical considering the weak marks. And=

>>>> this breaks due to the static inline initialization.
>>>>
>>>> However, let's mark both functions and variables weak to fix the iss=
ue
>>>> and avoid leaving unused variables around. Will update my patch in a=
 minute.
>>> Ok. I am reverting this patch until you provide me with another
>>> solution. It causes latency to segfault purely and simply at startup =
on
>>> my dual PIII.
>>>
>> Cannot reproduce yet. Do you have a backtrace?
>=20
> No. But the problem is probably the same as the one signaled by Henri,
> a misplaced weak directive ending up in a symbol with no address at all=
=2E
> Since the current situation works, I am going to wait for the "clean"
> fix which puts some code/data in the src/skins/common directory.
>=20

Find it in my tree. But it's not yet well tested.

Jan


--------------enig9F8089CF261C4E78BF02DCC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktzIIIACgkQitSsb3rl5xSgVwCg0OrLzoy6jHNev53fLbSKLSoN
yPMAoIwGsEO5c9fmBY4vUF4zNAHfQtmK
=IJrr
-----END PGP SIGNATURE-----

--------------enig9F8089CF261C4E78BF02DCC3--

