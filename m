Message-ID: <4B732679.4030306@domain.hid>
Date: Wed, 10 Feb 2010 22:34:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid> <4B7323D5.1040804@domain.hid>
	<4B732487.50103@domain.hid>
In-Reply-To: <4B732487.50103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5FAA673A7821C1594D7F45C5"
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
--------------enig5FAA673A7821C1594D7F45C5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>> GIT version control wrote:
>>>>>>>>>> Module: xenomai-jki
>>>>>>>>>> Branch: for-upstream
>>>>>>>>>> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit=
;h=3D6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>>>>>
>>>>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>>>>> Date:   Wed Feb 10 13:24:29 2010 +0100
>>>>>>>>>>
>>>>>>>>>> Make xnarch_init_timeconv an uninlined weak function
>>>>>>>>>>
>>>>>>>>>> Otherwise the wrong set of time conversion variables might get=

>>>>>>>>>> initialized when using > 1 skin libraries.
>>>>>>>>> If that would be possible, then it is the conversion variables =
which
>>>>>>>>> should made be weak, not the function.
>>>>>>>>>
>>>>>>>>> The way I see it, the posix and native skins currently get a di=
fferent
>>>>>>>>> set of variables and functions, which works, but with your chan=
ge, since
>>>>>>>>> there is only one function, only one set of variable gets initi=
alized by
>>>>>>>>> the two function calls. And one skin just broke.
>>>>>>>>>
>>>>>>>>> Or am I missing something? Does the patch fix a problem you rea=
lly had?
>>>>>>>> Frankly, I wasn't able to test in the field yet as replacing the=
 libs
>>>>>>>> there is non-trivial. But I was able to observe that only one se=
t of
>>>>>>>> functions is used - which is logical considering the weak marks.=
 And
>>>>>>>> this breaks due to the static inline initialization.
>>>>>>>>
>>>>>>>> However, let's mark both functions and variables weak to fix the=
 issue
>>>>>>>> and avoid leaving unused variables around. Will update my patch =
in a minute.
>>>>>>> Ok. I am reverting this patch until you provide me with another
>>>>>>> solution. It causes latency to segfault purely and simply at star=
tup on
>>>>>>> my dual PIII.
>>>>>>>
>>>>>> Cannot reproduce yet. Do you have a backtrace?
>>>>> No. But the problem is probably the same as the one signaled by Hen=
ri,
>>>>> a misplaced weak directive ending up in a symbol with no address at=
 all.
>>>>> Since the current situation works, I am going to wait for the "clea=
n"
>>>>> fix which puts some code/data in the src/skins/common directory.
>>>>>
>>>> Find it in my tree. But it's not yet well tested.
>>> I do not like it either. Functions which are in src/skins/common shou=
ld
>>> still be weak, since this lib is included in all the skins libraries.=

>> Those functions are now in libxeno_common only, so I see no point in
>> allowing them to be overloaded.
>=20
> Yes, but libxeno_common is included in libpthread_rt.so and
> libnative.so. So, if you link with both libraries, you get
> libxeno_common twice.
>=20

Do we link libxeno_common statically? Otherwise, this conflict is not
logical to me. Also, there are other symbols in bind.c that are non-weak.=


Jan


--------------enig5FAA673A7821C1594D7F45C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktzJoAACgkQitSsb3rl5xQLZQCgzvzcCFbFP7tOUTPoUshGyhMN
CZIAnRG638dWhYK5E3yboNlkf9NSjqiY
=KsCN
-----END PGP SIGNATURE-----

--------------enig5FAA673A7821C1594D7F45C5--

