MIME-Version: 1.0
In-Reply-To: <CAE2JnQyzqxUv+JSu=L1f+Kqxt0txxBxf3xnCBHvSeQVMgfdt=g@mail.gmail.com>
References: <CAE2JnQzDaSfwwuuq+voM+ZqPLHoqmjitsa4XzRpqcoukNJGrsg@mail.gmail.com>
 <537FA0A3.301@xenomai.org>
 <CAE2JnQyzqxUv+JSu=L1f+Kqxt0txxBxf3xnCBHvSeQVMgfdt=g@mail.gmail.com>
Date: Sat, 24 May 2014 10:55:17 -0300
Message-ID: <CAE2JnQy_seXdtaf4vM90VhLK7ypzJw=k96Rfs2SV0-LJSoaORw@mail.gmail.com>
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
To: xenomai@xenomai.org

2014-05-23 22:06 GMT-03:00 Alexandre Donisete Bensi <adbensi@gmail.com>:
> 2014-05-23 16:25 GMT-03:00 Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>:
>> On 05/23/2014 09:08 PM, Alexandre Donisete Bensi wrote:
>>> Hi!
>>>
>>>  I am trying to install xenomai on ARM Cortex A9 - ARMv7 (v7l) SoC
>>> Samsung Exynos 4412 on linux-3.8.13.23 board OdroidU2/U3. To port
>>> xenomai to this board I need to add some functions to hardware timer
>>> and interrupt handler according
>>
>> No.
>>
>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>
>>>  But mach-exynos directory is different and I cannot find the files
>>> referenced :(
>>>
>>> root@odroid:/usr/src/linux-3.8.13.23/arch/arm/mach-exynos#
>>> clock-exynos4210.c  clock-exynos4212.c  clock-exynos4.c
>>> mach-hkdk4412.c  mach-smdk4x12.c  mach-exynos4-dt.c
>>>
>>> I confess that I am with many doubts. All attempts I made on this
>>> platform end as:
>>> checking file mm/vmalloc.c
>>> prepare-kernel.sh: Unable to patch kernel 3.8.13.23 with
>>> ipipe-core-3.8.13-arm-3.patch.
>>>
>>>  Is there any documentation that is closest to my case?
>>
>> You have the documentation, you only do not read it carefully. The patch
>> for 3.8.13 is for 3.8.13, not for 3.8.13.23.
>>
>
> Thanks Gilles. I learned another...
>
> The path was successfully applied,
> I had the error below with make on kernel (from kernel.org). I
> accepted all the default options with make oldconfig.
>
> I am post my config file, I must pay attention to some specific option?
> Config File : http://paste.debian.net/101508/
>
> Error:
> make -j4 concluido
>   WRAP    arch/arm/include/generated/asm/auxvec.h
>   WRAP    arch/arm/include/generated/asm/bitsperlong.h
>   WRAP    arch/arm/include/generated/asm/cputime.h
>   CHK     include/generated/uapi/linux/version.h
>   WRAP    arch/arm/include/generated/asm/current.h
>   WRAP    arch/arm/include/generated/asm/emergency-restart.h
>   UPD     include/generated/uapi/linux/version.h
>   WRAP    arch/arm/include/generated/asm/errno.h
>   WRAP    arch/arm/include/generated/asm/exec.h
>   WRAP    arch/arm/include/generated/asm/ioctl.h
>   WRAP    arch/arm/include/generated/asm/ipcbuf.h
>   WRAP    arch/arm/include/generated/asm/irq_regs.h
>   WRAP    arch/arm/include/generated/asm/kdebug.h
>   WRAP    arch/arm/include/generated/asm/local.h
>   WRAP    arch/arm/include/generated/asm/local64.h
>   WRAP    arch/arm/include/generated/asm/msgbuf.h
>   WRAP    arch/arm/include/generated/asm/param.h
>   WRAP    arch/arm/include/generated/asm/parport.h
>   WRAP    arch/arm/include/generated/asm/poll.h
>   WRAP    arch/arm/include/generated/asm/sections.h
>   WRAP    arch/arm/include/generated/asm/segment.h
>   WRAP    arch/arm/include/generated/asm/sembuf.h
>   WRAP    arch/arm/include/generated/asm/serial.h
>   WRAP    arch/arm/include/generated/asm/shmbuf.h
>   WRAP    arch/arm/include/generated/asm/siginfo.h
>   WRAP    arch/arm/include/generated/asm/sizes.h
>   WRAP    arch/arm/include/generated/asm/socket.h
>   WRAP    arch/arm/include/generated/asm/sockios.h
>   WRAP    arch/arm/include/generated/asm/termbits.h
>   WRAP    arch/arm/include/generated/asm/termios.h
>   WRAP    arch/arm/include/generated/asm/timex.h
>   WRAP    arch/arm/include/generated/asm/trace_clock.h
>   WRAP    arch/arm/include/generated/asm/types.h
>   WRAP    arch/arm/include/generated/asm/unaligned.h
>   CHK     include/generated/utsrelease.h
>   UPD     include/generated/utsrelease.h
>   HOSTCC  scripts/kallsyms
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   HOSTCC  scripts/pnmtologo
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/bin2c
>   HOSTCC  scripts/sortextable
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
>   Generating include/generated/mach-types.h
>   CC      kernel/bounds.s
>   GEN     include/generated/bounds.h
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/ipipe.h:33:0,
>                  from include/linux/sched.h:25,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/ipipe.h: In function =C3=A2__ipipe_hrclock_ok=C3=A2:
> /usr/src/linux-3.8.13/arch/arm/include/asm/ipipe.h:99:30: error:
> =C3=A2__ipipe_hrtimer_freq=C3=A2 undeclared (first use in this function)
>  #define __ipipe_hrclock_freq __ipipe_hrtimer_freq
>                               ^
> include/linux/ipipe.h:114:9: note: in expansion of macro =C3=A2__ipipe_hr=
clock_freq=C3=A2
>   return __ipipe_hrclock_freq !=3D 0;
>          ^
> /usr/src/linux-3.8.13/arch/arm/include/asm/ipipe.h:99:30: note: each
> undeclared identifier is reported only once for each function it
> appears in
>  #define __ipipe_hrclock_freq __ipipe_hrtimer_freq
>                               ^
> include/linux/ipipe.h:114:9: note: in expansion of macro =C3=A2__ipipe_hr=
clock_freq=C3=A2
>   return __ipipe_hrclock_freq !=3D 0;
>          ^
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> make: *** Waiting for unfinished jobs....
>   HOSTLD  scripts/mod/modpost

I changed my config file as other platforms like Allwinner A10 and
Raspberry and I am confident that the problem can be
_ipipe_hrtimer_freq on the files:

./arch/arm/kernel/ipipe.c
./arch/arm/include/asm/ipipe.h
./include/linux/ipipe_tickdev.h
./kernel/ipipe/timer.c

I could not do much because my ipipe versions differ greatly.

How to know the correct value of __ipipe_hrtimer_freq =3D t->freq; to
fix (or this is not the way?)

Best Regards

