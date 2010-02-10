Message-ID: <4B7323D5.1040804@domain.hid>
Date: Wed, 10 Feb 2010 22:23:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid>
In-Reply-To: <4B73218A.9080306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE073E7078F357F4F375B12D4"
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
--------------enigE073E7078F357F4F375B12D4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> GIT version control wrote:
>>>>>>>> Module: xenomai-jki
>>>>>>>> Branch: for-upstream
>>>>>>>> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=
=3D6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>>>
>>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>>> Date:   Wed Feb 10 13:24:29 2010 +0100
>>>>>>>>
>>>>>>>> Make xnarch_init_timeconv an uninlined weak function
>>>>>>>>
>>>>>>>> Otherwise the wrong set of time conversion variables might get
>>>>>>>> initialized when using > 1 skin libraries.
>>>>>>> If that would be possible, then it is the conversion variables wh=
ich
>>>>>>> should made be weak, not the function.
>>>>>>>
>>>>>>> The way I see it, the posix and native skins currently get a diff=
erent
>>>>>>> set of variables and functions, which works, but with your change=
, since
>>>>>>> there is only one function, only one set of variable gets initial=
ized by
>>>>>>> the two function calls. And one skin just broke.
>>>>>>>
>>>>>>> Or am I missing something? Does the patch fix a problem you reall=
y had?
>>>>>> Frankly, I wasn't able to test in the field yet as replacing the l=
ibs
>>>>>> there is non-trivial. But I was able to observe that only one set =
of
>>>>>> functions is used - which is logical considering the weak marks. A=
nd
>>>>>> this breaks due to the static inline initialization.
>>>>>>
>>>>>> However, let's mark both functions and variables weak to fix the i=
ssue
>>>>>> and avoid leaving unused variables around. Will update my patch in=
 a minute.
>>>>> Ok. I am reverting this patch until you provide me with another
>>>>> solution. It causes latency to segfault purely and simply at startu=
p on
>>>>> my dual PIII.
>>>>>
>>>> Cannot reproduce yet. Do you have a backtrace?
>>> No. But the problem is probably the same as the one signaled by Henri=
,
>>> a misplaced weak directive ending up in a symbol with no address at a=
ll.
>>> Since the current situation works, I am going to wait for the "clean"=

>>> fix which puts some code/data in the src/skins/common directory.
>>>
>> Find it in my tree. But it's not yet well tested.
>=20
> I do not like it either. Functions which are in src/skins/common should=

> still be weak, since this lib is included in all the skins libraries.

Those functions are now in libxeno_common only, so I see no point in
allowing them to be overloaded.

>=20
> xnarch_init_timeconv does not need to be exported, it may only be calle=
d
> in common (bind.c, or timeconv.c, or something like that).

If xnarch_init_timeconv shall be executed unconditionally, I will
happily make it static inline again and call it from xeno_bind_skin_opt
(which would imply retrieving sysinfo as well).

>=20
> xnarch_tsc_to_ns/ns_to_tsc have no reason to be put in arith.h,
> timeconv.h was about just right. Maybe create asm-generic/timeconv.h?
>=20

Makes sense.

Jan


--------------enigE073E7078F357F4F375B12D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktzI9gACgkQitSsb3rl5xQk6ACghUU9n2/CdbJT9ctMGMTlqL3d
qdIAoJoeq4EC8o/oIzvVyPcP3mz0ileO
=RlGo
-----END PGP SIGNATURE-----

--------------enigE073E7078F357F4F375B12D4--

