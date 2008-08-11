Message-ID: <f52fe4ab0808102210q1602ec37rf885178fe0ae41ea@domain.hid>
Date: Mon, 11 Aug 2008 13:10:13 +0800
From: "=?GB2312?B?uqu3xg==?=" <feiyeahfar@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_84086_19651056.1218431413765"
Subject: [Xenomai-help] Error : Compiling 2.6.15 with xenomai-2.3.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_84086_19651056.1218431413765
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello :
I've got errors when I compiled linux kernel 2.6.15 with
adeos-ipipe-2.6.15-arm-1.5-08.patch, my gcc version is 3.4.1, my target
board is at91rm9200(arm) which is said to be supported by xenomai-2.3.4,
I've changed arch and cross-compile in Makefile. Here are my steps:
# zcat 2.6.15-at91.patch.gz |patch -p1
# xenomai_root=/usr/local/arm/xenomai-2.3.4
# linux_tree=/usr/local/arm/linux-2.6.15
# $xenomai_root/scripts/prepare-kernel.sh --arch=arm \

--adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.15-arm-1.5-08.patch
\
  --linux=$linux_tree
# make at91rm9200dk_defconfig
# make menuconfig
# make zImage
Then  I  got  errors:
arch/arm/kernel/built-in.o(.text+0x6174): In function
`__ipipe_init_platform':
: undefined reference to `__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/built-in.o(.text+0x61c8): In function `ipipe_get_sysinfo':
: undefined reference to `__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/built-in.o(.text+0x61cc): In function `ipipe_get_sysinfo':
: undefined reference to `__ipipe_mach_timerint'
arch/arm/kernel/built-in.o(.text+0x6244): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
arch/arm/kernel/built-in.o(.text+0x626c): In function `$a':
: undefined reference to `__ipipe_mach_set_dec'
arch/arm/kernel/built-in.o(.text+0x62e8): In function `ipipe_tune_timer':
: undefined reference to `__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/built-in.o(.text+0x6534): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
arch/arm/kernel/built-in.o(.text+0x6540): In function `$a':
: undefined reference to `__ipipe_mach_get_dec'
arch/arm/kernel/built-in.o(.text+0x664c): In function
`__ipipe_enable_pipeline':
: undefined reference to `__ipipe_mach_get_tsc'
arch/arm/kernel/built-in.o(.text+0x6658): In function
`__ipipe_enable_pipeline':
: undefined reference to `__ipipe_mach_get_dec'
arch/arm/kernel/built-in.o(.text+0x6680): In function
`__ipipe_enable_pipeline':
: undefined reference to `__ipipe_mach_timerint'
arch/arm/kernel/built-in.o(.text+0x673c): In function
`__ipipe_ack_timerirq':
: undefined reference to `__ipipe_mach_acktimer'
arch/arm/kernel/built-in.o(.text+0x69c8): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_get_tsc'
arch/arm/kernel/built-in.o(.text+0x69e4): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_set_dec'
arch/arm/kernel/built-in.o(.text+0x69f0): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_irq_mux_p'
arch/arm/kernel/built-in.o(.text+0x6a04): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_demux_irq'
arch/arm/kernel/built-in.o(.text+0x6a58): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_timerint'
arch/arm/kernel/built-in.o(.text+0x6a64): In function `__ipipe_grab_irq':
: undefined reference to `__ipipe_mach_ticks_per_jiffy'
kernel/built-in.o(.text+0x23a30): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x23b48): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x23b7c): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x23ba8): In function `$a':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x23f04): In function `xnintr_irq_proc':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x240ac): In function `xnintr_query':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x246bc): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x25400): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x25c38): In function `xnpod_fatal_helper':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x25f60): In function `xnpod_fatal_helper':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x26ecc): In function `xnpod_schedule_runnable':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2707c): more undefined references to
`__ipipe_mach_get_tsc' follow
kernel/built-in.o(.text+0x291a4): In function `xnpod_start_timer':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x29b64): In function `xnpod_wait_thread_period':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x29bb8): In function `xnpod_wait_thread_period':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2aeb4): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b148): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b1f8): In function `$a':
: undefined reference to `__ipipe_mach_set_dec'
kernel/built-in.o(.text+0x2b220): In function `$a':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x2b2d0): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b384): In function `$a':
: undefined reference to `__ipipe_mach_set_dec'
kernel/built-in.o(.text+0x2b3c4): In function `$a':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x2b4e8): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b754): In function
`xntimer_get_jiffies_aperiodic':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b858): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2b8bc): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2ba7c): In function `$a':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x2bb30): In function `$a':
: undefined reference to `__ipipe_mach_set_dec'
kernel/built-in.o(.text+0x2bb50): In function `$a':
: undefined reference to `__ipipe_mach_timerint'
kernel/built-in.o(.text+0x33ad0): In function `rt_timer_inquire':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x33bf8): In function `rt_timer_tsc':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x33c18): In function `rt_timer_spin':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x33d18): In function `rt_timer_spin':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x3f808): In function
`pse51_cond_timedwait_prologue':
: undefined reference to `__ipipe_mach_get_tsc'
kernel/built-in.o(.text+0x42568): more undefined references to
`__ipipe_mach_get_tsc' follow
arch/arm/xenomai/built-in.o(.text+0x70): In function `rthal_timer_request':
: undefined reference to `__ipipe_mach_set_dec'
arch/arm/xenomai/built-in.o(.text+0xa8): In function `rthal_timer_request':
: undefined reference to `__ipipe_mach_timerstolen'
arch/arm/xenomai/built-in.o(.text+0xb0): In function `rthal_timer_request':
: undefined reference to `__ipipe_mach_ticks_per_jiffy'
arch/arm/xenomai/built-in.o(.text+0xb4): In function `rthal_timer_request':
: undefined reference to `__ipipe_mach_timerint'
arch/arm/xenomai/built-in.o(.text+0xf0): In function `rthal_timer_release':
: undefined reference to `__ipipe_mach_release_timer'
arch/arm/xenomai/built-in.o(.text+0x11c): In function `rthal_timer_release':
: undefined reference to `__ipipe_mach_timerint'
arch/arm/xenomai/built-in.o(.text+0x120): In function `rthal_timer_release':
: undefined reference to `__ipipe_mach_timerstolen'
make: *** [.tmp_vmlinux1] Error 1
I've tried several  times,  and I got similar errors relate to variables and
functions in i-pipe patch. Please help me. Thank you very much!

------=_Part_84086_19651056.1218431413765
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hello :<br>I&#39;ve got errors when I compiled linux kernel 2.6.15 with adeos-ipipe-2.6.15-arm-1.5-08.patch, my gcc version is 3.4.1, my target board is at91rm9200(arm) which is said to be supported by xenomai-2.3.4, I&#39;ve changed arch and cross-compile in Makefile. Here are my steps:<br>
# zcat 2.6.15-at91.patch.gz |patch -p1<br># xenomai_root=/usr/local/arm/xenomai-2.3.4<br># linux_tree=/usr/local/arm/linux-2.6.15<br># $xenomai_root/scripts/prepare-kernel.sh --arch=arm \<br>&nbsp; --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.15-arm-1.5-08.patch \<br>
&nbsp; --linux=$linux_tree<br># make at91rm9200dk_defconfig<br># make menuconfig<br># make zImage <br>Then&nbsp; I&nbsp; got&nbsp; errors:<br>arch/arm/kernel/built-in.o(.text+0x6174): In function `__ipipe_init_platform&#39;:<br>: undefined reference to `__ipipe_mach_ticks_per_jiffy&#39;<br>
arch/arm/kernel/built-in.o(.text+0x61c8): In function `ipipe_get_sysinfo&#39;:<br>: undefined reference to `__ipipe_mach_ticks_per_jiffy&#39;<br>arch/arm/kernel/built-in.o(.text+0x61cc): In function `ipipe_get_sysinfo&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>arch/arm/kernel/built-in.o(.text+0x6244): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>arch/arm/kernel/built-in.o(.text+0x626c): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_set_dec&#39;<br>arch/arm/kernel/built-in.o(.text+0x62e8): In function `ipipe_tune_timer&#39;:<br>: undefined reference to `__ipipe_mach_ticks_per_jiffy&#39;<br>arch/arm/kernel/built-in.o(.text+0x6534): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>arch/arm/kernel/built-in.o(.text+0x6540): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_dec&#39;<br>arch/arm/kernel/built-in.o(.text+0x664c): In function `__ipipe_enable_pipeline&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>arch/arm/kernel/built-in.o(.text+0x6658): In function `__ipipe_enable_pipeline&#39;:<br>: undefined reference to `__ipipe_mach_get_dec&#39;<br>arch/arm/kernel/built-in.o(.text+0x6680): In function `__ipipe_enable_pipeline&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>arch/arm/kernel/built-in.o(.text+0x673c): In function `__ipipe_ack_timerirq&#39;:<br>: undefined reference to `__ipipe_mach_acktimer&#39;<br>arch/arm/kernel/built-in.o(.text+0x69c8): In function `__ipipe_grab_irq&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>arch/arm/kernel/built-in.o(.text+0x69e4): In function `__ipipe_grab_irq&#39;:<br>: undefined reference to `__ipipe_mach_set_dec&#39;<br>arch/arm/kernel/built-in.o(.text+0x69f0): In function `__ipipe_grab_irq&#39;:<br>
: undefined reference to `__ipipe_mach_irq_mux_p&#39;<br>arch/arm/kernel/built-in.o(.text+0x6a04): In function `__ipipe_grab_irq&#39;:<br>: undefined reference to `__ipipe_mach_demux_irq&#39;<br>arch/arm/kernel/built-in.o(.text+0x6a58): In function `__ipipe_grab_irq&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>arch/arm/kernel/built-in.o(.text+0x6a64): In function `__ipipe_grab_irq&#39;:<br>: undefined reference to `__ipipe_mach_ticks_per_jiffy&#39;<br>kernel/built-in.o(.text+0x23a30): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x23b48): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x23b7c): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x23ba8): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x23f04): In function `xnintr_irq_proc&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x240ac): In function `xnintr_query&#39;:<br>: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x246bc): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x25400): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x25c38): In function `xnpod_fatal_helper&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x25f60): In function `xnpod_fatal_helper&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x26ecc): In function `xnpod_schedule_runnable&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2707c): more undefined references to `__ipipe_mach_get_tsc&#39; follow<br>kernel/built-in.o(.text+0x291a4): In function `xnpod_start_timer&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x29b64): In function `xnpod_wait_thread_period&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x29bb8): In function `xnpod_wait_thread_period&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2aeb4): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b148): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b1f8): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_set_dec&#39;<br>kernel/built-in.o(.text+0x2b220): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x2b2d0): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b384): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_set_dec&#39;<br>kernel/built-in.o(.text+0x2b3c4): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x2b4e8): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b754): In function `xntimer_get_jiffies_aperiodic&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b858): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2b8bc): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2ba7c): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x2bb30): In function `$a&#39;:<br>: undefined reference to `__ipipe_mach_set_dec&#39;<br>kernel/built-in.o(.text+0x2bb50): In function `$a&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>kernel/built-in.o(.text+0x33ad0): In function `rt_timer_inquire&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x33bf8): In function `rt_timer_tsc&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x33c18): In function `rt_timer_spin&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x33d18): In function `rt_timer_spin&#39;:<br>
: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x3f808): In function `pse51_cond_timedwait_prologue&#39;:<br>: undefined reference to `__ipipe_mach_get_tsc&#39;<br>kernel/built-in.o(.text+0x42568): more undefined references to `__ipipe_mach_get_tsc&#39; follow<br>
arch/arm/xenomai/built-in.o(.text+0x70): In function `rthal_timer_request&#39;:<br>: undefined reference to `__ipipe_mach_set_dec&#39;<br>arch/arm/xenomai/built-in.o(.text+0xa8): In function `rthal_timer_request&#39;:<br>
: undefined reference to `__ipipe_mach_timerstolen&#39;<br>arch/arm/xenomai/built-in.o(.text+0xb0): In function `rthal_timer_request&#39;:<br>: undefined reference to `__ipipe_mach_ticks_per_jiffy&#39;<br>arch/arm/xenomai/built-in.o(.text+0xb4): In function `rthal_timer_request&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>arch/arm/xenomai/built-in.o(.text+0xf0): In function `rthal_timer_release&#39;:<br>: undefined reference to `__ipipe_mach_release_timer&#39;<br>arch/arm/xenomai/built-in.o(.text+0x11c): In function `rthal_timer_release&#39;:<br>
: undefined reference to `__ipipe_mach_timerint&#39;<br>arch/arm/xenomai/built-in.o(.text+0x120): In function `rthal_timer_release&#39;:<br>: undefined reference to `__ipipe_mach_timerstolen&#39;<br>make: *** [.tmp_vmlinux1] Error 1<br>
I&#39;ve tried several&nbsp; times,&nbsp; and I got similar errors relate to variables and functions in i-pipe patch. Please help me. Thank you very much!<br></div>

------=_Part_84086_19651056.1218431413765--

