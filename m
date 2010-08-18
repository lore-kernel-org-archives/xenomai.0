Message-ID: <4C6BD403.4030902@domain.hid>
Date: Wed, 18 Aug 2010 14:37:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>	
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>	
	<4C6BCB51.4010805@domain.hid>
	<1282133876.5255.296.camel@domain.hid>
In-Reply-To: <1282133876.5255.296.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: xenomai@xenomai.org

Krzysztof B=C5=82aszkowski wrote:
>>> rather i use native clean x86 environment (on e.g. x86_64)
>> I do this all the time, and never had any problem.
>=20
> i had lots with header files mainly.

Well, the glibc and Xenomai header files are the same on 64 bits and 32
bits machines... of course, if you are talking about other libs...

> and i am happy with my way.
>=20
>> Also, why not running 64 bits code on your atom? There are some x86_32=

>> only atoms? What about SMP?
>=20
> for some other constraints i will not mention i use 32 bits now.
>=20
> this is single core cpu so no point to use smp for e.g. 8 cpus (nor
> bigsmp)

Well, my atom has hyper-threading, so, SMP can be used, Linux sees two
threads. I suspect yours has hyper-threading too, since Linux mentions
that it sees an ACPI SMP table, but usually, hyper-threading needs to be
enabled at BIOS level.

--=20
					    Gilles.


