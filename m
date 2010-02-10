Message-ID: <4B72C18F.20903@domain.hid>
Date: Wed, 10 Feb 2010 15:24:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid>
In-Reply-To: <8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid>
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

Felipe Brand=C3=A3o Cavalcanti wrote:
> 2010/2/10 Felipe Brand=C3=A3o Cavalcanti <cavalkaf@domain.hid>
>=20
>>
>> 2010/2/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
m>
>>
>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>>> Hello,
>>>>
>>>> I am having some problems when trying to cross-compile the userspace=

>>> portion
>>>> of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenoma=
i
>>>> running on a IGEPv2 OMAP board (Beagleboard based), so I am
>>> cross-compiling
>>>> with bitbake on top of a poky Linux distribution.
>>> Do you have the same problem if you build Xenomai user-space portion
>>> running the standard build procedure without additional CFLAGS and
>>> LDFLAGS?
>>>
>>>
>> I have not tried this - the cross compiler automatically adds them, an=
d I
>> am not sure what I can remove. However, I will try removing them to se=
e what
>> works. One thing that I noticed using the -k option in the make comman=
d is
>> that compiling fails only in the testsuite.
>>
>> I found an old thread with a similar problem:
>> https://mail.gna.org/public/xenomai-help/2008-07/msg00141.html
>>
>>
>=20
> Just tried removing the LDFLAGS and CFLAGS, same error. I've attached t=
he
> configure and make logs.

Ok. Made a diff between your configure log and mine. It seems the
problem is at some point configure does not find a compiler named
"arm-linux-gcc" and decides to use "gcc". So, your host compiler is
probably used to test whether shm_open/shm_unlink and a few other
functions exist for your target, and finds them whereas they are
probably not available.

So, the cure is to pass --host=3Darm-none-linux-gnueabi instead of
--host=3Darm-linux.

This looks a bit like a bug. Did you (or bit-bake, or poky, whatever)
re-run autoconf or are you using the original configure script?

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


