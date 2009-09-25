Message-ID: <4ABC8140.4000301@domain.hid>
Date: Fri, 25 Sep 2009 10:37:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580909242312i2a817f43y6a63a8d15631d3ec@domain.hid>
In-Reply-To: <1f3e02580909242312i2a817f43y6a63a8d15631d3ec@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org, mohamad.sharifi@domain.hid, "Me (Samsung Account)" <d.sergey@domain.hid>, jorge.ramirez@domain.hid

Didenko Sergey wrote:
> Hello All
> 
> I'm porting Xenomai 2.4.9 to the Linux Kernel 2.6.29.
> 
> Target platform is MV 88F6290

I do not find this platform anywhere, neither in the kernel source, nor
on the internet.

> CPU: ARM926EJ-S
> Adeos patch: adeos-ipipe-2.6.29-arm-1.13-03.patch
> 
> I do patch the kernel with xenomai and adeos:
> ./prepare-kernel.sh --arch=arm
> --linux=/.../kernel/linux-2.6.29-v02.00.29/
> --adeos=/.../xenomai-2.4.9/ksrc/arch/arm/patches/adeos-ipipe-2.6.29-arm-1.13-03.patch
> 
> Then I compile the Linux kernel.
> At the time when I start to compile the kernel I have to answer for many
> questions regarding configuration, it is Ok!
> But finally I got the compile error like:
> 
> ===
> arch/arm/kernel/ipipe.c: In function '__ipipe_grab_irq':
> arch/arm/kernel/ipipe.c:492: error: implicit declaration of function
> '__ipipe_mach_irq_mux_p'
> make[1]: *** [arch/arm/kernel/ipipe.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> ===
> 
> the reason of this error is that there is no definition of the macro
> "__ipipe_mach_irq_mux_p" for the target platform as well as there are no
> the others CPU dependent definitions.
> 
> If I refer to the file "arch/arm/mach-at91/include/mach/irqs.h" all
> definitions like
> CONFIG_ARCH_AT91SAM9* are not defined

So, it is an AT91 something ?

> 
> But, in the Xenomai's build questionnaire messages (build time) I found
> next lines:
> 
> ===
> 
> *
> * System Type
> *
> ARM system type
>   1. Agilent AAEC-2000 based (ARCH_AAEC2000)
>  .
>  .
>  .
>   38. Nuvoton W90X900 CPU (ARCH_W90X900)
>> 39. Marvell MV88F6290 (ARCH_MV88F6290)
> choice[1-39]: 39
> 
> ===
> 
> Actually I did not select any system type anyhow. And it does not allow
> me to select it somehow, but the default choice is correct - system type
> is MV88F6290! I don't know why but it is a very nice that default system
> type is exactly what I need :) (please give some comments on it)
> 
> The questions!
> 
> 1) It looks like Xenomai do support the target SoC (MV88F6290), as well
> as do support processor type ARM926 it has.

There is no Xenomai code specific to a CPU core. What matters is what
SOC you are using, and from your description MV88F6290 is not a SOC, it
is a board. The SOC being an AT91 from what you told us. And yes, most
AT91 are supported.

> Then why I can not find the CPU dependent definitions in the patched
> kernel's source code?
> 2) What does it takes for you to support this system and CPU if it is
> not supported yet?

This question is an FAQ, the answer may be found here:
http://www.xenomai.org/index.php/I-pipe:ArmPorting
But from your description, if the SOC is really an AT91, what is missing
is probably just a #ifdef for its multiplexed GPIOS.

But if you tell me exactly what kernel sources you are using and send me
your .config, and I will be able to give you a definitive answer.

-- 
                                          Gilles


