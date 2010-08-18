Message-ID: <4C6BE297.4060706@domain.hid>
Date: Wed, 18 Aug 2010 15:39:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>	
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>	
	<4C6BCB51.4010805@domain.hid>
	<1282133876.5255.296.camel@domain.hid>	
	<4C6BD403.4030902@domain.hid>
	<1282136147.5255.306.camel@domain.hid>
In-Reply-To: <1282136147.5255.306.camel@domain.hid>
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
> On Wed, 2010-08-18 at 14:37 +0200, Gilles Chanteperdrix wrote:
>> Krzysztof B=C5=82aszkowski wrote:
>>>>> rather i use native clean x86 environment (on e.g. x86_64)
>>>> I do this all the time, and never had any problem.
>>> i had lots with header files mainly.
>> Well, the glibc and Xenomai header files are the same on 64 bits and 3=
2
>> bits machines... of course, if you are talking about other libs...
>=20
>=20
> ;) i don't mean Xenomai and degree of crosscompilation complexity
> depends on what you try to compile.
> i remember a few years ago it was not so funny.
>=20
>>> and i am happy with my way.
>>>
>>>> Also, why not running 64 bits code on your atom? There are some x86_=
32
>>>> only atoms? What about SMP?
>>> for some other constraints i will not mention i use 32 bits now.
>>>
>>> this is single core cpu so no point to use smp for e.g. 8 cpus (nor
>>> bigsmp)
>> Well, my atom has hyper-threading, so, SMP can be used, Linux sees two=

>> threads. I suspect yours has hyper-threading too, since Linux mentions=

>> that it sees an ACPI SMP table, but usually, hyper-threading needs to =
be
>> enabled at BIOS level.
>>
>=20
> yes, it has "ht". disabled now. i thought that i don't want to try to
> solve superposition of various corner cases and stuck on solving this.
>=20
> otoh, i could create such case. did i ?
>=20
> (btw, rtai 3.7 works)

This does not give us any clue, since neither the I-pipe patch nor the
heap code are shared. But as I said, I suspect the bug is rather in the
kernel configuration than anywhere else.

We are going to try something else. The .config I use on my atom is here:=

http://git.xenomai.org/?p=3Dmkrootfs.git;a=3Dblob_plain;f=3Dboards/generi=
c/atom-32/config-2.6.31;hb=3DHEAD

Could you start from this configuration, adding only what is needed to
boot your box (root filesystem device controller, or network controller
if booting over nfs, root filesystem), then test this kernel?

--=20
					    Gilles.


