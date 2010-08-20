Message-ID: <4C6E50C1.9040700@domain.hid>
Date: Fri, 20 Aug 2010 11:54:09 +0200
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
	<4C6BE297.4060706@domain.hid>
	<1282140262.5255.313.camel@domain.hid>	
	<4C6BE9D3.1080907@domain.hid>
	<1282141537.5255.315.camel@domain.hid>	
	<4C6BEE9B.1080000@domain.hid>
	<1282144162.5255.325.camel@domain.hid>	
	<4C6BF8B1.8080206@domain.hid>
	<1282297638.5255.373.camel@domain.hid>
In-Reply-To: <1282297638.5255.373.camel@domain.hid>
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
>> Yes, now if you find the culprit option, it would be nice to report he=
re
>> so that we can fix the I-pipe patch.
>>
>=20
>=20
> I do know it still. All i have are two configs. One which does not work=

> and one working. I have tried so far breaking working one and also
> fixing broken. Both attempts have been unsuccessful.
>=20
> I tried many "obvious" settings mainly in "processor type and features"=

> with no luck.
>=20
> This process must take some time ( i can't spend whole days on trying
> one-by-one each difference, recompile kernel,ync target's rootfs,
> reboot target and run fork regression test even that many steps i have
> automated)

ever heard about bisecting ? List the diffs between the two configs
apply half of them
if it still works, apply half of the rest
if it does not unapply half of the one you applied
etc...
if there are 65000 differences, you will get to the result in 16 steps.
you can keep the same rootfs, all you have to do is rebuild the kernel
(without "make clean", so that only what changed in the .config is
re-compiled).

It should take just an hour or two.

>=20
> Regards,


--=20
					    Gilles.


