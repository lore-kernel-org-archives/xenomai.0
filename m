Message-ID: <DUB121-W1EC856DF0BB8FC70B291281BF0@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Mon, 8 Jun 2015 12:53:22 +0000
In-Reply-To: <201506081211.15597.paul_c@tuxcnc.org>
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>,
 <201506081211.15597.paul_c@tuxcnc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> From: paul_c@tuxcnc.org
> To: xenomai@xenomai.org
> Date: Mon=2C 8 Jun 2015 12:11:15 +0100
> Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
>=20
> On Monday 08 June 2015=2C mobin Motallebizadeh wrote:
> > HiCan anybody provide some information about making a patch for
> > Raspberry Pi 2 ?The patches :
> > xenomai-2.6.4/ksrc/arch/arm/patches/raspberryand the both `pre` and
> > `post` patch need some changes to be applicable for rpi2 and 3.18
> > kernel.Specially in :
> > https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/mach-bc
> >m2709/bcm2708_gpio.c Thanx in advance
>=20
>=20
> There are two separate development paths for the Raspberry kernel.
>=20
> 1) The "official" Raspberry Pi Foundation (RPF) work which is found=20
> under mach-bcm2708 - This is what is targeted by the pre/post patches=20
> you refer to.=20
>=20
> 2) The "official" Linux support is to be found in the mach-bcm2709 tree.=
=20
> This is still "work in progress"=2C but looks to be at the stage where it=
=20
> is usable - I've not been following developments too closely=2C is it in=
=20
> the mainline kernel yet ?
never heard of it! and couldn't find it on Google. can you provide the link=
?

> If the RPF kernel runs on the RPi2 board=2C it wouldn't take much to=20
> update the pre/post patches to 3.18.
>=20

yes.This is what I tried to do but the gpio driver  [above link] the  `bcm2=
708_gpio_interrupt` function needs to be reviewed by an expert. 		 	   		  =
