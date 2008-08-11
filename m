Message-ID: <48A000B2.2040502@domain.hid>
Date: Mon, 11 Aug 2008 11:04:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f52fe4ab0808102210q1602ec37rf885178fe0ae41ea@domain.hid>
In-Reply-To: <f52fe4ab0808102210q1602ec37rf885178fe0ae41ea@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Error : Compiling 2.6.15 with xenomai-2.3.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6Z+p6I+y?= <feiyeahfar@domain.hid>
Cc: xenomai@xenomai.org

韩菲 wrote:
> Hello :
> I've got errors when I compiled linux kernel 2.6.15 with
> adeos-ipipe-2.6.15-arm-1.5-08.patch, my gcc version is 3.4.1, my target
> board is at91rm9200(arm) which is said to be supported by xenomai-2.3.4,

No, it is not clear from the documentation, but at91rm9200 is not
supported by the 2.6.15 patch, you should pick the 2.6.20 one. However,
why picking this version of Xenomai ? There are more recent ones in the
same branch, and there is a more recent branch (v2.4.x). If you are
starting a new development and have no particular constraint to stay
with an old kernel, I suggest you go with Xenomai 2.4.4, using the
2.6.26 kernel.

> I've changed arch and cross-compile in Makefile. Here are my steps:
> # zcat 2.6.15-at91.patch.gz |patch -p1
> # xenomai_root=/usr/local/arm/xenomai-2.3.4
> # linux_tree=/usr/local/arm/linux-2.6.15
> # $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
> 
> --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.15-arm-1.5-08.patch
> \
>   --linux=$linux_tree
> # make at91rm9200dk_defconfig
> # make menuconfig
> # make zImage
> Then  I  got  errors:
> arch/arm/kernel/built-in.o(.text+0x6174): In function
> `__ipipe_init_platform':
> : undefined reference to `__ipipe_mach_ticks_per_jiffy'
> arch/arm/kernel/built-in.o(.text+0x61c8): In function `ipipe_get_sysinfo':
> : undefined reference to `__ipipe_mach_ticks_per_jiffy'
> arch/arm/kernel/built-in.o(.text+0x61cc): In function `ipipe_get_sysinfo':
> : undefined reference to `__ipipe_mach_timerint'
> arch/arm/kernel/built-in.o(.text+0x6244): In function `$a':
> : undefined reference to `__ipipe_mach_get_tsc'

Your version of binutils is outdated, you will run into problem, see the
arm linux FAQ. Also, 3.4.1 is a too old version of gcc, I think the
oldest version supported to build the linux kernel is 3.4.4.

-- 
                                                 Gilles.

