From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <470E8BFE.4070804@domain.hid>
References: <470E8BFE.4070804@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Fri, 12 Oct 2007 10:58:44 +0200
Message-Id: <1192179524.5149.23.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Hi Jan,

[taking this on the list after several mails with Philippe...]

Le jeudi 11 octobre 2007 =C3=A0 22:47 +0200, Jan Kiszka a =C3=A9crit :
> This patch for SVN trunk fixes most of the current bugs around hardware
> timer takeover and release from/to Linux.
[...]

I have a problem with the timer on my MacBook Pro (Core2Duo, used in
_32_ bit mode)(*): when Xenomai takes over the timer (at 'modprobe
xeno_native' time), the Linux timer stops.

Looking into /proc/xenomai/irq shows that Xenomai does receive the
hardware interrupts, and /proc/interrupts shows that they are no longer
forwarded to Linux. Before loading xeno_native, everything is ok.

Linux userspace continues to somewhat work: I can issue commands, and
depending on the syscalls they made I suppose (no, strace doesn't work),
sometimes they end correctly sometimes they hang (and I cannot interrupt
them by ^C or other signals.).

I tried several .config variations, without any change in behaviour: my
current test config has SMP, NO_HZ, APIC, PREEMPT, HIRES all disabled).

This happens with a 2.6.22.9 kernel, adeos-ipipe-2.6.22-i386-1.10-07,
xenomai svn HEAD (rev 3050), with or without your current patch. It is
quite possible that this is not a new problem, since I have this laptop
since a few weeks only and I never ran Xenomai on it.=20

I'll happily provide any further information or test results if you
need.

Thanks,

Stelian.

(*) yeah, I know I could install a x86_64 distribution but I had some
terrible experiences in the past - mainly due to the usage of some
proprietary bricks like flash, java etc. I know some of those have been
resolved today, and one of these days I should try once more, but now it
is not a good time for this.
--=20
Stelian Pop <stelian@domain.hid>


