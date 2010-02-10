Message-ID: <4B72A39A.6020300@domain.hid>
Date: Wed, 10 Feb 2010 13:16:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>	<4B729B04.9010909@domain.hid>	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid>
	<4B72A0C7.3040000@domain.hid>
In-Reply-To: <4B72A0C7.3040000@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Felipe Brand=C3=A3o Cavalcanti wrote:
>> 2010/2/10 Felipe Brand=C3=A3o Cavalcanti <cavalkaf@domain.hid>
>>
>>> 2010/2/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
om>
>>>
>>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>>>> Hello,
>>>>>
>>>>> I am having some problems when trying to cross-compile the userspac=
e
>>>> portion
>>>>> of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenom=
ai
>>>>> running on a IGEPv2 OMAP board (Beagleboard based), so I am
>>>> cross-compiling
>>>>> with bitbake on top of a poky Linux distribution.
>>>> Do you have the same problem if you build Xenomai user-space portion=

>>>> running the standard build procedure without additional CFLAGS and
>>>> LDFLAGS?
>>>>
>>>>
>>> I have not tried this - the cross compiler automatically adds them, a=
nd I
>>> am not sure what I can remove. However, I will try removing them to s=
ee what
>>> works. One thing that I noticed using the -k option in the make comma=
nd is
>>> that compiling fails only in the testsuite.
>>>
>>> I found an old thread with a similar problem:
>>> https://mail.gna.org/public/xenomai-help/2008-07/msg00141.html
>>>
>>>
>> Just tried removing the LDFLAGS and CFLAGS, same error. I've attached =
the
>> configure and make logs.
>=20
> You still compile with the same flags:
> libtool: link: ../../../scripts/wrap-link.sh arm-none-linux-gnueabi-gcc=

> -march=3Darmv7-a -mtune=3Dcortex-a8 -mfpu=3Dneon -mfloat-abi=3Dsoftfp
> -fno-tree-vectorize
> -Wl,@/home/jdoe/poky/poky/build/tmp-poky/work/armv7a-none-linux-gnueabi=
/xenomai-2.5.1-r0/xenomai-2.5.1/src/skins/posix/posix.wrappers
> -Wl,-O1 -Wl,--as-needed -o .libs/cyclictest cyclictest-cyclictest.o
> ../../skins/posix/.libs/libpthread_rt.so -lpthread -lrt
>=20
> a normal Xenomai build would not have -mtune=3Dcortex-a8, -mfpu=3Dneon
> -fno-tree-vectorize -Wl,-O1 -WL,--as-needed

-mtune=3Dcortex-a8 -mfpu=3Dneon come from your CC variable, unset CC and =
run
configure passing --host=3Darm-none-linux-gnueabi, CC will be set
automatically.

to find the other options, grep the output of the "export" command, and
unset the variables you find.

--=20
					    Gilles.


