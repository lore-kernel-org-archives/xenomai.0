Message-ID: <49A69429.1090502@domain.hid>
Date: Thu, 26 Feb 2009 14:07:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0ef0a9d0902260303k711d228ct82e4bdae85d5ed1f@domain.hid>
In-Reply-To: <a0ef0a9d0902260303k711d228ct82e4bdae85d5ed1f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai uClinux issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ghanem Lafi <lafi.ghanem@domain.hid>
Cc: xenomai@xenomai.org

Ghanem Lafi wrote:
> hello,
> 
> my project is running on :
> 
> *  uclinux20051014
> * linux 2.6.15
> * LPC2292 (arm7 tdmi)
> * arm-elf-gcc 2.95.3
> * xenomai  2.6.4
> * Adeos : adeos-ipipe-2.6.15-arm-1.5-08.patch
> 
> 
> 
> 
> when i arrive to this step :
> 
>> make
> 
> i have this error :
> 
> 
> root@domain.hid# make
> make -C tools/ucfront
> make[1]: Entering directory
> `/home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront'
> make[1]: `ucfront' is up to date.
> make[1]: Leaving directory
> `/home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront'
> ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront/ucfront
> tools/ucfront-gcc
> ln -sf /home/sst/Bureau/Exp1/uClinux-dist/tools/ucfront/ucfront
> tools/ucfront-g++
> make ARCH=arm CROSS_COMPILE=arm-elf- -C linux-2.6.x  || exit 1
> make[1]: Entering directory `/home/sst/Bureau/Exp1/uClinux-dist/linux-2.6.x'
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   SYMLINK include/asm-arm/arch -> include/asm-arm/arch-
>   Generating include/asm-arm/mach-types.h
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/sched.h:4,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/param.h:14: asm/arch/param.h: No such file or directory
> In file included from include/linux/prefetch.h:14,
>                  from include/linux/list.h:7,
>                  from include/asm/ipipe.h:30,
>                  from include/linux/preempt.h:31,
>                  from include/linux/spinlock.h:50,
>                  from include/linux/ipipe.h:26,
>                  from include/linux/sched.h:7,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/processor.h:25: asm/arch/memory.h: No such file or directory
> In file included from include/asm/ipipe.h:34,
>                  from include/linux/preempt.h:31,
>                  from include/linux/spinlock.h:50,
>                  from include/linux/ipipe.h:26,
>                  from include/linux/sched.h:7,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/irq.h:4: asm/arch/irqs.h: No such file or directory
> In file included from include/linux/slab.h:18,
>                  from include/linux/percpu.h:4,
>                  from include/linux/ipipe.h:28,
>                  from include/linux/sched.h:7,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/page.h:11: unterminated `#if' conditional
> In file included from include/linux/timex.h:61,
>                  from include/linux/sched.h:12,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/timex.h:15: asm/arch/timex.h: No such file or directory
> In file included from include/linux/sched.h:13,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:213: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:385: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: warning: `CLOCK_TICK_RATE' is not defined
> include/linux/jiffies.h:416: division by zero in #if
> include/linux/jiffies.h:416: division by zero in #if
> In file included from include/linux/sched.h:22,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/page.h:11: unterminated `#if' conditional
> In file included from include/linux/mm.h:35,
>                  from arch/arm/kernel/asm-offsets.c:14:
> include/asm/page.h:11: unterminated `#if' conditional
> In file included from include/asm/pgtable-nommu.h:21,
>                  from include/asm/pgtable.h:17,
>                  from include/linux/mm.h:36,
>                  from arch/arm/kernel/asm-offsets.c:14:
> include/asm/page.h:11: unterminated `#if' conditional
> In file included from include/asm/io.h:28,
>                  from include/asm/pgtable-nommu.h:22,
>                  from include/asm/pgtable.h:17,
>                  from include/linux/mm.h:36,
>                  from arch/arm/kernel/asm-offsets.c:14:
> include/asm/memory.h:28: asm/arch/memory.h: No such file or directory
> In file included from include/asm/pgtable-nommu.h:22,
>                  from include/asm/pgtable.h:17,
>                  from include/linux/mm.h:36,
>                  from arch/arm/kernel/asm-offsets.c:14:
> include/asm/io.h:71: asm/arch/io.h: No such file or directory
> arch/arm/kernel/asm-offsets.c:37: warning: `__GNUC_PATCHLEVEL__' is not
> defined
> make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make[1]: *** [prepare0] Error 2
> make[1]: Leaving directory `/home/sst/Bureau/Exp1/uClinux-dist/linux-2.6.x'
> make: *** [linux] Error 1
> root@domain.hid#
> 
> *********************
> 
> 
> 
> how can i correct this mistakes ??

By doing things step by step: first try and compile uclinux without
Xenomai, then when it works, try and apply the I-pipe patch and run
prepare-kernel.sh, using the same .config which worked with uclinux with
only the xenomai options enabled.

As I told you in a previous mail, probably nobody ever used uclinux with
Xenomai on ARM, so there may be a few issues to solve to be able to
simply compile the kernel.

As I also told you in a previous mail, picking such old versions of
linux, and gcc (gcc 2.95 is really really old now) is a bad idea.

-- 
                                                 Gilles.

