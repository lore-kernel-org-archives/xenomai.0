From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <466EDF1F.5050103@domain.hid>
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
	<1181630207.7354.20.camel@domain.hid> <466ED96E.4050806@domain.hid>
	<466EDC2C.3020200@domain.hid>  <466EDF1F.5050103@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 20:08:28 +0200
Message-Id: <1181671708.6792.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] CONFIG_SMP in switchtest
Reply-To: rpm@xenomai.org
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
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-06-12 at 19:59 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>
> >>> On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
> >>>
> >>>> Hi everybody,
> >>>>
> >>>> I want to know why the --enable-smp option for "configure" of Xenomai is used when there
> >>>> is already the corresponding option selected with the kernel configuration?
> >>> --enable-smp is only used when you want the user-space side to _require_
> >>> SMP support to be present into the running kernel; i.e. for some (weird)
> >>> reason, your application really needs this. Xenomai libraries don't care
> >>> whether SMP support is enabled or not, they are not sensitive to that
> >>> issue (see the "weak" status of this option in README.INSTALL)
> >>
> >> Switchtest bases some compile-time decisions on CONFIG_SMP. Nitpicking,
> >> OK, but I wonder if this is required. Gilles?
> > 
> > If you do not enable the smp option, switchtest will only use one cpu.
> > The reason why I made this is that, on some UP machine, (probably arm,
> > but I do no longer remember) sysconf(_SC_NPROCESSORS_ONLN) did not work.
> 
> Welcome to embedded hell :-/. What was the effect precisely? Can we
> detect this during runtime? The point is I see people trying this test
> on SMP without providing the right switch to configure. Would be a pity
> IMHO.
> 
> At this chance: I also noticed problems with our sched_setscheduler
> detection and bfin's uClibc. Compilations works, linking fails - they
> provide headers, but lack implementations. Patch suggestion will follow.
> 
> And my pthread_spin_lock detection got nicely vaporised on bfin once
> again. I'm considering to switch back to the original configure-based
> detection.

Notice that you have no atomic ops available on Blackfin CPUs, and to
emulate them, you would have to mask interrupts, which you can't do in
user-space (privileged instruction). So you will always end up issuing a
syscall under the hood (bfin_spinlock), that does some kind of spinlock
emulation from kernel space. Next kernel releases might improve things
by allowing to jump to atomic emulation routines directly from
user-space, but this is not yet available AFAIK. IOW, don't expect
performance improvements from user-space locking, yet.

> 
> Enough of the moaning.
> 

Still, this is quite a fun architecture to work with.

> Jan
> 
-- 
Philippe.



