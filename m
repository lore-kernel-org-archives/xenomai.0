Message-ID: <79d475ba9149de2628440336fa6947b3.squirrel@sourcetrek.com>
In-Reply-To: <CAGFtc0Yj6yztoEUOBcM7Do5h2erYeX_2-Fcmd=4XrFxzc7JYFA@mail.gmail.com>
References: <CAGFtc0Yj6yztoEUOBcM7Do5h2erYeX_2-Fcmd=4XrFxzc7JYFA@mail.gmail.com>
Date: Thu, 23 Jul 2015 18:20:00 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai use for Raspberry Pi (ARM7) has error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?IuW8oOeri+mRqyI=?= <intelligentcodemail@gmail.com>
Cc: xenomai@xenomai.org


张立鑫 wrote:
> https://github.com/raspberrypi/linux
>
> git reset --hard 43f497a2035f3d4a2f766d20827c68e0437cdd58
>
> use
> https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/configs/bcm2709_defconfig
>
> $ export
> PATH=$PATH:~/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
> $ export CCPI=arm-linux-gnueabihf-
> $ KERNEL=kernel7
> $ mkdir build
> $ make mrproper
> $ make ARCH=arm O=build CROSS_COMPILE=$CCPI bcm2709_defconfig
> $ make ARCH=arm O=build CROSS_COMPILE=$CCPI menuconfig
>
> enabled ipipe

It is not obvious at this point how you got the I-pipe patch for that
processor. The git you use is not a git supported by the Xenomai project,
as such we have no information about it. And the list of processors
supported by Xenomai (not by third parties gits obviously) may be found
here:

http://xenomai.org/embedded-hardware/#Supported_SoC


-- 
                                            Gilles.
https://click-hack.org


