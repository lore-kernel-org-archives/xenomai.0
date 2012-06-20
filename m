MIME-Version: 1.0
In-Reply-To: <CAM1yFZ8PK+i3quP2MfFeEAR2Wya0f9bV=bjYehXeY5KTw8EJuQ@mail.gmail.com>
References: <CAM1yFZ8PK+i3quP2MfFeEAR2Wya0f9bV=bjYehXeY5KTw8EJuQ@mail.gmail.com>
Date: Wed, 20 Jun 2012 18:24:48 +0530
Message-ID: <CAM1yFZ-X6L6q4Ogh58mMkk4cRm8=_bcnbmhFyeEvDA-=yjNS5A@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
	=?windows-1252?q?error=3A_storage_size_of_=91sysinfo=92?=
	=?windows-1252?q?_isn=92t_known?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The kernel version I am using is: linux-2.6.38.8
Xenomai version: xenomai-2.6.0

What else info should I provide to help you to help me?


On 20/06/2012, Anisha Kaul <born.rebel.83@gmail.com> wrote:
> Greetings,
>
> linux-2gbt:~ # uname -a
> Linux linux-2gbt 2.6.22.5-31-default #1 SMP 2007/09/21 22:29:00 UTC
> i686 i686 i386 GNU/Linux
>
> xenomai-2.6.0
> ----------------------------------------------------------------------
> My "Power management and ACPI options" screen currently looks exactly lik=
e
> this:
>
>
> [*] Power Management support
> [ ]   Power Management Debug Support
> [*] Suspend to RAM and standby
> [ ] Hibernation (aka 'suspend to disk')
> [ ] Run-time PM core functionality
> [ ] ACPI (Advanced Configuration and Power Interface) Support  --->
> [ ] SFI (Simple Firmware Interface) Support  --->
> < > APM (Advanced Power Management) BIOS support  --->
> CPU Frequency scaling  --->
> [ ] CPU idle PM support
> ----------------------------------------------------------------------
>
> The `CPU Frequency scaling` menu is totally disabled.
>
> Since this link:
> http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86=
_kernel
>
> asks us to disable the following:
>
> * CONFIG_APM
> * CONFIG_ACPI_PROCESSOR
> * CONFIG_INTEL_IDLE
> * CONFIG_CPU_FREQ
> ----------------------------------------------------------------------
>
>
> The "make" is resulting in the following errors:
>
> include/asm-generic/xenomai/hal.h:227: error: storage size of
> =91sysinfo=92 isn=92t known
> include/asm-generic/xenomai/hal.h:228: error: implicit declaration of
> function =91ipipe_get_sysinfo=92
> include/asm-generic/xenomai/hal.h:227: warning: unused variable =91sysinf=
o=92
> include/asm-generic/xenomai/hal.h: In function =91rthal_get_timerfreq=92:
> include/asm-generic/xenomai/hal.h:234: error: storage size of
> =91sysinfo=92 isn=92t known
> include/asm-generic/xenomai/hal.h:234: warning: unused variable =91sysinf=
o=92
> include/asm-generic/xenomai/hal.h: In function =91set_task_nowakeup=92:
> include/asm-generic/xenomai/hal.h:324: error: =91TASK_NOWAKEUP=92
> undeclared (first use in this function)
> include/asm-generic/xenomai/hal.h:324: error: (Each undeclared
> identifier is reported only once
> include/asm-generic/xenomai/hal.h:324: error: for each function it appear=
s
> in.)
> include/asm-generic/xenomai/hal.h: In function =91clear_task_nowakeup=92:
> include/asm-generic/xenomai/hal.h:329: error: =91TASK_NOWAKEUP=92
> undeclared (first use in this function)
> include/asm-generic/xenomai/hal.h: In function =91rthal_enable_notifier=
=92:
>
> ----------------------------------------------------------------------
>
> What could I have done wrong this time? Please help. :(
>
> --
> Anisha Kaul
>


--=20
Anisha Kaul

