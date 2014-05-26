MIME-Version: 1.0
In-Reply-To: <5380B4FD.6070504@xenomai.org>
References: <CAE2JnQzDaSfwwuuq+voM+ZqPLHoqmjitsa4XzRpqcoukNJGrsg@mail.gmail.com>
 <537FA0A3.301@xenomai.org>
 <CAE2JnQyzqxUv+JSu=L1f+Kqxt0txxBxf3xnCBHvSeQVMgfdt=g@mail.gmail.com>
 <CAE2JnQy_seXdtaf4vM90VhLK7ypzJw=k96Rfs2SV0-LJSoaORw@mail.gmail.com>
 <5380A6E8.3080902@xenomai.org>
 <CAE2JnQycQRAks3B60=T7-2P5PTheuzBvQJimsQm97+4q96AV=A@mail.gmail.com>
 <5380B4FD.6070504@xenomai.org>
Date: Sun, 25 May 2014 22:10:34 -0300
Message-ID: <CAE2JnQyLRYY+PUnKLJy9_CpeF2ZVmX2KFNjuAuJGzeZiaJnUVA@mail.gmail.com>
From: Alexandre Donisete Bensi <adbensi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai on linux-3.8.13 core ARM Cortex A9 - ARMv7
 (v7l) SoC Samsung Exynos 4412
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

2014-05-24 12:04 GMT-03:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On 05/24/2014 05:00 PM, Alexandre Donisete Bensi wrote:
>> 2014-05-24 11:04 GMT-03:00 Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org>:
>>> On 05/24/2014 03:55 PM, Alexandre Donisete Bensi wrote:
>>>> 2014-05-23 22:06 GMT-03:00 Alexandre Donisete Bensi <adbensi@gmail.com=
>:
>>>>> 2014-05-23 16:25 GMT-03:00 Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org>:
>>>>>> On 05/23/2014 09:08 PM, Alexandre Donisete Bensi wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>  I am trying to install xenomai on ARM Cortex A9 - ARMv7 (v7l) SoC
>>>>>>> Samsung Exynos 4412 on linux-3.8.13.23 board OdroidU2/U3. To port
>>>>>>> xenomai to this board I need to add some functions to hardware time=
r
>>>>>>> and interrupt handler according
>>>>>>
>>>>>> No.
>>>>>>
>>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>>>>>
>>>>>>>  But mach-exynos directory is different and I cannot find the files
>>>>>>> referenced :(
>>>>>>>
>>>>>>> root@odroid:/usr/src/linux-3.8.13.23/arch/arm/mach-exynos#
>>>>>>> clock-exynos4210.c  clock-exynos4212.c  clock-exynos4.c
>>>>>>> mach-hkdk4412.c  mach-smdk4x12.c  mach-exynos4-dt.c
>>>>>>>
>>>>>>> I confess that I am with many doubts. All attempts I made on this
>>>>>>> platform end as:
>>>>>>> checking file mm/vmalloc.c
>>>>>>> prepare-kernel.sh: Unable to patch kernel 3.8.13.23 with
>>>>>>> ipipe-core-3.8.13-arm-3.patch.
>>>>>>>
>>>>>>>  Is there any documentation that is closest to my case?
>>>>>>
>>>>>> You have the documentation, you only do not read it carefully. The p=
atch
>>>>>> for 3.8.13 is for 3.8.13, not for 3.8.13.23.
>>>>>>
>>>>>
>>>>> Thanks Gilles. I learned another...
>>>>>
>>>>> The path was successfully applied,
>>>>> I had the error below with make on kernel (from kernel.org). I
>>>>> accepted all the default options with make oldconfig.
>>>>>
>>>>> I am post my config file, I must pay attention to some specific optio=
n?
>>>>> Config File : http://paste.debian.net/101508/
>>>>>
>>>>> Error:
>>>>> make -j4 concluido
>>>>>   WRAP    arch/arm/include/generated/asm/auxvec.h
>>>>>   WRAP    arch/arm/include/generated/asm/bitsperlong.h
>>>>>   WRAP    arch/arm/include/generated/asm/cputime.h
>>>>>   CHK     include/generated/uapi/linux/version.h
>>>>>   WRAP    arch/arm/include/generated/asm/current.h
>>>>>   WRAP    arch/arm/include/generated/asm/emergency-restart.h
>>>>>   UPD     include/generated/uapi/linux/version.h
>>>>>   WRAP    arch/arm/include/generated/asm/errno.h
>>>>>   WRAP    arch/arm/include/generated/asm/exec.h
>>>>>   WRAP    arch/arm/include/generated/asm/ioctl.h
>>>>>   WRAP    arch/arm/include/generated/asm/ipcbuf.h
>>>>>   WRAP    arch/arm/include/generated/asm/irq_regs.h
>>>>>   WRAP    arch/arm/include/generated/asm/kdebug.h
>>>>>   WRAP    arch/arm/include/generated/asm/local.h
>>>>>   WRAP    arch/arm/include/generated/asm/local64.h
>>>>>   WRAP    arch/arm/include/generated/asm/msgbuf.h
>>>>>   WRAP    arch/arm/include/generated/asm/param.h
>>>>>   WRAP    arch/arm/include/generated/asm/parport.h
>>>>>   WRAP    arch/arm/include/generated/asm/poll.h
>>>>>   WRAP    arch/arm/include/generated/asm/sections.h
>>>>>   WRAP    arch/arm/include/generated/asm/segment.h
>>>>>   WRAP    arch/arm/include/generated/asm/sembuf.h
>>>>>   WRAP    arch/arm/include/generated/asm/serial.h
>>>>>   WRAP    arch/arm/include/generated/asm/shmbuf.h
>>>>>   WRAP    arch/arm/include/generated/asm/siginfo.h
>>>>>   WRAP    arch/arm/include/generated/asm/sizes.h
>>>>>   WRAP    arch/arm/include/generated/asm/socket.h
>>>>>   WRAP    arch/arm/include/generated/asm/sockios.h
>>>>>   WRAP    arch/arm/include/generated/asm/termbits.h
>>>>>   WRAP    arch/arm/include/generated/asm/termios.h
>>>>>   WRAP    arch/arm/include/generated/asm/timex.h
>>>>>   WRAP    arch/arm/include/generated/asm/trace_clock.h
>>>>>   WRAP    arch/arm/include/generated/asm/types.h
>>>>>   WRAP    arch/arm/include/generated/asm/unaligned.h
>>>>>   CHK     include/generated/utsrelease.h
>>>>>   UPD     include/generated/utsrelease.h
>>>>>   HOSTCC  scripts/kallsyms
>>>>>   CC      scripts/mod/empty.o
>>>>>   HOSTCC  scripts/mod/mk_elfconfig
>>>>>   HOSTCC  scripts/pnmtologo
>>>>>   MKELF   scripts/mod/elfconfig.h
>>>>>   HOSTCC  scripts/mod/file2alias.o
>>>>>   HOSTCC  scripts/conmakehash
>>>>>   HOSTCC  scripts/bin2c
>>>>>   HOSTCC  scripts/sortextable
>>>>>   HOSTCC  scripts/mod/modpost.o
>>>>>   HOSTCC  scripts/mod/sumversion.o
>>>>>   Generating include/generated/mach-types.h
>>>>>   CC      kernel/bounds.s
>>>>>   GEN     include/generated/bounds.h
>>>>>   CC      arch/arm/kernel/asm-offsets.s
>>>>> In file included from include/linux/ipipe.h:33:0,
>>>>>                  from include/linux/sched.h:25,
>>>>>                  from arch/arm/kernel/asm-offsets.c:13:
>>>>> include/linux/ipipe.h: In function =C3=A2__ipipe_hrclock_ok=C3=A2:
>>>>> /usr/src/linux-3.8.13/arch/arm/include/asm/ipipe.h:99:30: error:
>>>>> =C3=A2__ipipe_hrtimer_freq=C3=A2 undeclared (first use in this functi=
on)
>>>>>  #define __ipipe_hrclock_freq __ipipe_hrtimer_freq
>>>>>                               ^
>>>>> include/linux/ipipe.h:114:9: note: in expansion of macro =C3=A2__ipip=
e_hrclock_freq=C3=A2
>>>>>   return __ipipe_hrclock_freq !=3D 0;
>>>>>          ^
>>>>> /usr/src/linux-3.8.13/arch/arm/include/asm/ipipe.h:99:30: note: each
>>>>> undeclared identifier is reported only once for each function it
>>>>> appears in
>>>>>  #define __ipipe_hrclock_freq __ipipe_hrtimer_freq
>>>>>                               ^
>>>>> include/linux/ipipe.h:114:9: note: in expansion of macro =C3=A2__ipip=
e_hrclock_freq=C3=A2
>>>>>   return __ipipe_hrclock_freq !=3D 0;
>>>>>          ^
>>>>> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
>>>>> make: *** [prepare0] Error 2
>>>>> make: *** Waiting for unfinished jobs....
>>>>>   HOSTLD  scripts/mod/modpost
>>>>
>>>> I changed my config file as other platforms like Allwinner A10 and
>>>> Raspberry and I am confident that the problem can be
>>>> _ipipe_hrtimer_freq on the files:
>>>
>>> Allwinner A10 is not supported by the I-pipe patch for 3.8.13
>>> Raspberry Pi is not supported by the I-pipe patch for 3.8.13, and is no=
t
>>> a cortex a9 anyway.
>>
>> I have other versions of kernel and Ipipe working with these Boards.
>> Just checked the menuconfig options between boards to determine if it
>> was not my fault. This lesson I have assimilated. Thanks for
>> responding;
>>
>>>> ./arch/arm/kernel/ipipe.c
>>>> ./arch/arm/include/asm/ipipe.h
>>>> ./include/linux/ipipe_tickdev.h
>>>> ./kernel/ipipe/timer.c
>>>>
>>>> I could not do much because my ipipe versions differ greatly.
>>>>
>>>> How to know the correct value of __ipipe_hrtimer_freq =3D t->freq; to
>>>> fix (or this is not the way?)
>>>
>>> You have to carefully read the documentation and do what it says. How
>>> many time are you going to make me repeat this?
>>>
>>
>> I prefer to know what is happening than make You repeat it, sorry
>> about that. You can be sure, I've read but did not understand how to
>> support the platform. The path was applied without error, the problem
>> now is to build Kernel.
>
> What part of "You should also ensure that the symbol
> "CONFIG_IPIPE_ARM_KUSER_TSC" gets selected." do you not understand?
>

The kernel with XENOMAI stops after the message: "Uncompressing
Linux... done, booting the kernel"
I try Troubleshooting: "enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK
add 'earlyprintk' to the kernel parameters"
and nothing... I try  building the Kernel without Xenomai path and I
found that the problem is just with earlyprintk.

If the earlyprintk is removed from kernel parameters the system load
the kernel without xenomai.
I think the same happens with kernel-Xenomai, but without earlyprintk
I am not know what prevents kernel Xenomai to continue.

I would like to patch it (may be wrong point in the debug-macro.S).
Please, I need Help, I'm out of ideas.

I change arch/arm/Kconfig
config ARCH_EXYNOS
        select IPIPE_ARM_KUSER_TSC if IPIPE

I change arch/arm/mach-exynos/include/mach/irqs.h
#include <asm/smp_twd.h>

I have bootargs:
setenv fdt_high "0xffffffff"
setenv bootcmd "fatload mmc 0:1 0x40008000 zImage; fatload mmc 0:1
0x43000000 uInitrd; bootm 0x40008000 0x43000000"
setenv bootargs "fb_x_res=3D1920 fb_y_res=3D1080 hdmi_phy_res=3D1080
no_console_suspend console=3Dtty0 console=3DttySAC1,115200n8 debug
earlyprintk=3Dserial,0x13810000,115200 loglevel=3D9 root=3D/dev/mmcblk0p2
rootwait rw mem=3D2047M"
boot

and .config
CONFIG_DEBUG_LL=3Dy
# CONFIG_DEBUG_LL_UART_NONE is not set
CONFIG_DEBUG_LL_INCLUDE=3D"mach/debug-macro.S"
CONFIG_EARLY_PRINTK=3Dy

cat /proc/tty/driver/s3c2410_serial
serinfo:1.0 driver revision:
0: uart:S3C6400/10 mmio:0x13800000 irq:84 tx:0 rx:0 CTS|DSR|CD
1: uart:S3C6400/10 mmio:0x13810000 irq:85 tx:6532 rx:140 RTS|DTR|DSR|CD
2: uart:S3C6400/10 mmio:0x13820000 irq:86 tx:0 rx:0 DSR|CD
3: uart:S3C6400/10 mmio:0x13830000 irq:87 tx:0 rx:0 DSR|CD

