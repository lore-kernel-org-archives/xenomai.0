Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <4316FD8F.30203@domain.hid>
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
	<1125577206.4641.8.camel@domain.hid>
	<1125579791.4685.2.camel@domain.hid>
	<4316FD8F.30203@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Thu, 01 Sep 2005 15:30:25 +0200
Message-Id: <1125581425.4639.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

Le jeudi 01 septembre 2005 =C3=A0 16:09 +0300, Heikki Lindholm a =C3=A9cr=
it :
> Stelian Pop kirjoitti:
> > Le jeudi 01 septembre 2005 =C3=A0 14:20 +0200, Stelian Pop a =C3=A9cr=
it :
> >=20
> >=20
> >>I'll try testing the 2.6.10 patch, maybe this will tell if the proble=
m
> >>is in the adeos core or in the newer kernel changes...
> >=20
> >=20
> > Okay, it also hangs with the 2.6.10 patch (even with the fix for
> > activate_mm()). It took two invocations of 'rtai-test' but it ended u=
p
> > hanging just like before.
>=20
> Are you sure this is not the same I was experiencing, eg. missed=20
> decrementer interrupt that stalls the machine (looks like hard lock-up)=
=20
> for two minutes.

I tried waiting (at least 5 minutes) and nothing happened.

>  It only happens on the more "advanced" PPCs, like 6xx=20
> and 7xxx.

This _is_ an advanced PPC, it's a (fairly recent) Powerbook:

processor	: 0
cpu		: 7447A, altivec supported
clock		: 1499MHz
revision	: 0.2 (pvr 8003 0102)
bogomips	: 1495.04
machine		: PowerBook5,6
motherboard	: PowerBook5,6 MacRISC3 Power Macintosh=20
detected as	: 287 (PowerBook G4 15")
pmac flags	: 0000001b
L2 cache	: 512K unified
memory		: 512MB
pmac-generation	: NewWorld

Stelian.
--=20
Stelian Pop <stelian@domain.hid>


