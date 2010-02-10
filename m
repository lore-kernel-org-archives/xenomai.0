Message-ID: <4B729FC7.2060602@domain.hid>
Date: Wed, 10 Feb 2010 13:00:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
In-Reply-To: <8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
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
> 2010/2/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
>=20
>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>> Hello,
>>>
>>> I am having some problems when trying to cross-compile the userspace
>> portion
>>> of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenomai=

>>> running on a IGEPv2 OMAP board (Beagleboard based), so I am
>> cross-compiling
>>> with bitbake on top of a poky Linux distribution.
>> Do you have the same problem if you build Xenomai user-space portion
>> running the standard build procedure without additional CFLAGS and LDF=
LAGS?
>>
>>
> I have not tried this - the cross compiler automatically adds them, and=
 I am
> not sure what I can remove. However, I will try removing them to see wh=
at
> works. One thing that I noticed using the -k option in the make command=
 is
> that compiling fails only in the testsuite.

You probably have some CFLAGS and LDFLAGS defined in the environment.
This way of passing CFLAGS and LDFLAGS to the autotools is deprecated.

>=20
> I found an old thread with a similar problem:
> https://mail.gna.org/public/xenomai-help/2008-07/msg00141.html

No, these are unrelated problems. The problems you mention have been
solved by using the wrap-link.sh script, which you can seen on the
command line you posted, but which unfortunately either the CFLAGS or
LDFLAGS you pass, or your toolchain seem to upset.

To know if the issue is the flags or the toolchain, I ask you to
recompile with the same toolchain, but without your custom flags.

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


