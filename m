MIME-Version: 1.0
In-Reply-To: <4FCE28F8.9040001@xenomai.org>
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
	<4FCDFB35.1050705@xenomai.org>
	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
	<4FCE28F8.9040001@xenomai.org>
Date: Wed, 13 Jun 2012 17:31:59 +0200
Message-ID: <CAHue_TW1ntMpOxwACiawgtm67nYq_e7i11CDxz=CfpGGwRes_A@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi again,

I'm still stuck in compiling Xenomai 2.6.0 with linux 3.0.13 and I'm still
receiving mulitple definitions. Lately i run the compiling process with " |
grep __ipipe" option to see the warnings at the begining of the compilation
and i got this:

*$ make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnueabi- zImage | grep
__ipipe

arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO:
return_address should use unwind tables"

In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:27:1:
warning: "__ipipe_mach_hrtimer_irq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:180:1:
warning: this is the location of the previous definition
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:31:1:
warning: "__ipipe_mach_ext_hrtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:187:1:
warning: this is the location of the previous definition
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:33:1:
warning: "__ipipe_mach_localtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:203:1:
warning: this is the location of the previous definition
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:37:1:
warning: "__ipipe_mach_doirq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:206:1:
warning: this is the location of the previous definition
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:46:1:
warning: "__ipipe_mach_ackirq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:209:1:
warning: this is the location of the previous definition
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/localtimer.h:30,
                 from arch/arm/kernel/smp.c:41:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:73:1:
warning: "__ipipe_mach_hrtimer_freq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from arch/arm/kernel/smp.c:14:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:167:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:27:1:
warning: "__ipipe_mach_hrtimer_irq" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:180:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:31:1:
warning: "__ipipe_mach_ext_hrtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:187:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:33:1:
warning: "__ipipe_mach_localtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:203:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:37:1:
warning: "__ipipe_mach_doirq" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:206:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:46:1:
warning: "__ipipe_mach_ackirq" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:209:1:
warning: this is the location of the previous definition
In file included from arch/arm/kernel/smp_twd.c:24:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:73:1:
warning: "__ipipe_mach_hrtimer_freq" redefined
In file included from include/linux/ipipe.h:31,
                 from arch/arm/kernel/smp_twd.c:22:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:167:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:27:1:
warning: "__ipipe_mach_hrtimer_irq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:180:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:31:1:
warning: "__ipipe_mach_ext_hrtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:187:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:33:1:
warning: "__ipipe_mach_localtimer" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:203:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:37:1:
warning: "__ipipe_mach_doirq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:206:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:46:1:
warning: "__ipipe_mach_ackirq" redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:209:1:
warning: this is the location of the previous definition
In file included from arch/arm/mach-vexpress/ct-ca9x4.c:18:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/smp_twd.h:73:1:
warning: "__ipipe_mach_hrtimer_freq"redefined
In file included from include/linux/ipipe.h:31,
                 from include/linux/sched.h:65,
                 from include/linux/i2c.h:34,
                 from include/linux/fb.h:5,
                 from include/linux/amba/clcd.h:12,
                 from arch/arm/mach-vexpress/ct-ca9x4.c:10:
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/ipipe.h:167:1:
warning: this is the location of the previous definition
kernel/time/tick-sched.c:47: warning: 'tick_do_update_jiffies64' defined
but not used
kernel/time/tick-sched.c:89: warning: 'tick_init_jiffy_update' defined but
not used
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/wrappers.h=
:27,
                 from include/asm-generic/xenomai/syscall.h:69,
                 from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/syscall.h:=
29,
                 from include/xenomai/nucleus/shadow.h:27,
                 from kernel/xenomai/skins/posix/signal.c:50:
include/linux/ipipe.h:645: warning: 'struct vm_area_struct' declared inside
parameter list
include/linux/ipipe.h:645: warning: its scope is only this definition or
declaration, which is probably not what you want
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/wrappers.h=
:27,
                 from include/asm-generic/xenomai/syscall.h:69,
                 from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/syscall.h:=
29,
                 from include/xenomai/posix/syscall.h:23,
                 from kernel/xenomai/skins/posix/module.c:50:
include/linux/ipipe.h:645: warning: 'struct vm_area_struct' declared inside
parameter list
include/linux/ipipe.h:645: warning: its scope is only this definition or
declaration, which is probably not what you want
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/wrappers.h=
:27,
                 from kernel/xenomai/skins/posix/syscall.c:24:
include/linux/ipipe.h:645: warning: 'struct vm_area_struct' declared inside
parameter list
include/linux/ipipe.h:645: warning: its scope is only this definition or
declaration, which is probably not what you want
In file included from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/wrappers.h=
:27,
                 from include/asm-generic/xenomai/syscall.h:69,
                 from
/home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/syscall.h:=
29,
                 from include/xenomai/nucleus/shadow.h:27,
                 from kernel/xenomai/skins/rtdm/syscall.c:20:
include/linux/ipipe.h:645: warning: 'struct vm_area_struct' declared inside
parameter list
include/linux/ipipe.h:645: warning: its scope is only this definition or
declaration, which is probably not what you want
arch/arm/common/built-in.o: In function `gic_raise_softirq':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/gic.c:450: multiple
definition of `__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/entry-armv.S:80:
first defined here
arch/arm/common/built-in.o: In function `__ipipe_mach_set_dec':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/timer-sp.c:231:
multiple definition of `__ipipe_mach_set_dec'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/smp_twd.c:60:
first defined here
arch/arm/common/built-in.o: In function `__ipipe_mach_release_timer':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/timer-sp.c:239:
multiple definition of `__ipipe_mach_release_timer'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/smp.c:509:
first defined here
arch/arm/common/built-in.o: In function `gic_raise_softirq':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/gic.c:450: multiple
definition of `__ipipe_mach_timerstolen'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/entry-armv.S:79:
first defined here
arch/arm/common/built-in.o: In function `__ipipe_mach_get_dec':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/timer-sp.c:249:
multiple definition of `__ipipe_mach_get_dec'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/smp_twd.c:71:
first defined here
arch/arm/common/built-in.o: In function `__ipipe_check_tickdev':
/home/marcin/Documents/linux-3.0.13/arch/arm/common/timer-sp.c:215:
multiple definition of `__ipipe_check_tickdev'
arch/arm/kernel/built-in.o:/home/marcin/Documents/linux-3.0.13/arch/arm/ker=
nel/smp_twd.c:75:
first defined here
make: *** [vmlinux.o] Error 1*

In the listing above it's seen that mostly smp_twd.c and smp_twd.h is the
problem with multiple definitions but i don't know which option i should
uncheck to avoid these definitions - any ideas?
I'm pretty sure that my configs are set to one processor only 'cause in
buildroot menuconfig i chose cortex-a9 as "Target Architecture Variant".

regards,
Marcin

2012/6/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 06/05/2012 05:34 PM, Marcin Ku=B6ka wrote:
> > Thank you for quick response.
> >
> > Again I tried to compile it using buildroot but this time I used
> > following commands:
> > /
> > /
> > /# cd /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.1=
3
> > # make ARCH=3Darm vexpress_defconfig // i suppose this sets kernel
> > configuration only for versatile express (ommiting multiple definitions=
)?
> > # cd ..
> > # xenomai/scripts/prepare-kernel.sh --linux=3Dlinux-3.0.13
> > --adeos=3Dadeos-ipipe-3.0.13-arm-1.18-09.patch --arch=3Darm
> > # cd /home/marcin/Documents/buildroot-2012.05
> > # make all
> > /
>
> You should run make vexpress_defoncig after the prepare-kernel.sh step.
>
> I do not think vexpress_defconfig compiles for one board only, as the
> versatile board may hold several processor. Anyway, it is easy to check:
> just run make menuconfig/xconfig/whateverconfigyoulike yourself, and
> check what boards are enabled in the config.
>
> --
>                                            Gilles.
>



--=20
Marcin Ku=B6ka
