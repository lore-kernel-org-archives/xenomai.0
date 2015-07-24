MIME-Version: 1.0
In-Reply-To: <79d475ba9149de2628440336fa6947b3.squirrel@sourcetrek.com>
References: <CAGFtc0Yj6yztoEUOBcM7Do5h2erYeX_2-Fcmd=4XrFxzc7JYFA@mail.gmail.com>
 <79d475ba9149de2628440336fa6947b3.squirrel@sourcetrek.com>
From: =?UTF-8?B?5byg56uL6ZGr?= <intelligentcodemail@gmail.com>
Date: Fri, 24 Jul 2015 16:01:03 +0800
Message-ID: <CAGFtc0aqh8irfJmApH2S72htAKe4hr5P9VykBjXm7_Z5uvp18g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai use for Raspberry Pi (ARM7) has error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Can support Raspberry Pi 2 (ARM7)  bcm2709



2015-07-24 0:20 GMT+08:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

>
> =E5=BC=A0=E7=AB=8B=E9=91=AB wrote:
> > https://github.com/raspberrypi/linux
> >
> > git reset --hard 43f497a2035f3d4a2f766d20827c68e0437cdd58
> >
> > use
> >
> https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/configs/bcm=
2709_defconfig
> >
> > $ export
> >
> PATH=3D$PATH:~/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabi=
hf-raspbian/bin
> > $ export CCPI=3Darm-linux-gnueabihf-
> > $ KERNEL=3Dkernel7
> > $ mkdir build
> > $ make mrproper
> > $ make ARCH=3Darm O=3Dbuild CROSS_COMPILE=3D$CCPI bcm2709_defconfig
> > $ make ARCH=3Darm O=3Dbuild CROSS_COMPILE=3D$CCPI menuconfig
> >
> > enabled ipipe
>
> It is not obvious at this point how you got the I-pipe patch for that
> processor. The git you use is not a git supported by the Xenomai project,
> as such we have no information about it. And the list of processors
> supported by Xenomai (not by third parties gits obviously) may be found
> here:
>
> http://xenomai.org/embedded-hardware/#Supported_SoC
>
>
> --
>                                             Gilles.
> https://click-hack.org
>
>
