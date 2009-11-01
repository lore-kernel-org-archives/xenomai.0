From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <77331.50156.qm@domain.hid>
References: <125483.39803.qm@domain.hid>
	<1256986919.2065.364.camel@domain.hid>
	<77331.50156.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 01 Nov 2009 11:56:47 +0100
Message-ID: <1257073007.2065.399.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Basic Xenomai Questions?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wael Showair <showair2003@domain.hid>
Cc: Xenomai-core@domain.hid

On Sat, 2009-10-31 at 16:19 -0700, Wael Showair wrote:
> Thanks philippe for ur reply, i have already read this part but i am
> little confused about the same 2 questions i have sent
> 
> 
> ______________________________________________________________________
> From: Philippe Gerum <rpm@xenomai.org>
> To: Wael Showair <showair2003@domain.hid>
> Cc: Xenomai-core@domain.hid
> Sent: Sat, October 31, 2009 1:01:59 PM
> Subject: Re: [Xenomai-core] Basic Xenomai Questions?
> 
> On Fri, 2009-10-30 at 18:22 -0700, Wael Showair wrote:
> > Hi All,
> > i am beginner to Xenomai & i m trying to understand how will it go
> in
> > the future so i have 2 questions:
> > 
> > 
> > 1. the patch of Adeos just enables the sharing of hardware between
> > different OS, (Linux Vanilla kernel & Xenomai Nucleus), does it make
> > this step only?
> >

Yes, but in a limited form. It simply enables interrupts, exceptions and
syscalls to be controlled on a per-OS basis, and prioritized. This is by
no mean a complete bare metal hypervisor.

>  
> > 
> > 
> > 
> > 2. In Xenomai 2, there r 2 different kernels Normal Linux Vanilla &
> > Xenomai Nucleus, but i read that Xenomai 3 will tend to use
> >  PREEMPT_RT support which leads to the only one Native kernel will
> > exist, does it mean that the Nucleus will vanish & will it be the
> > patched RT Vanilla Linux Kernel itself?

The roadmap explicitly states there that the dual kernel approach will
be kept, and the ability to run over -rt will be introduced. There is no
one-fits-it-all solution, for all hw and sw combos, for all use cases,
so we must keep the two options open.

> > or does it mean that the Nuecleuse will no longer be a part of the
> > kernel space so it will be in user space?

The nucleus is currently two parts:
- a real-time enabling core; the thing that provides a RTOS stack
running side-by-side with a non-RT Linux. This layer is tightly coupled
with Adeos. Both cooperate to make a Linux system real-time aware via a
dual kernel architecture.
- an emulation core; a set of basic building blocks for implementing
RTOS APIs of all sorts. This is somewhat equivalent to a kernel API, but
with semantics close to traditional RTOS ones.

When X3 runs over -rt, -rt is fully in charge of providing real-time
guarantees. So neither Adeos nor the "real-time enabling" part of the
nucleus will be used in this context, and a userland implementation of
its emulation core will appear.

The only remaining piece of Xenomai code running in kernel space should
be a native RTDM module, to natively support real-time drivers coming
from the dual kernel world, fully relying on the regular kernel
services.

> > I beleive in the nucleus of Xenomai must exist in all cases?
> > 

An emulation core must exist in all cases, in order to support real-time
APIs. With -rt, that core will support all APIs; in dual kernel mode, it
will support those APIs but the POSIX and Xenomai/native ones, which
will still be directly based on the nucleus services as they are today.
The connection between the emulation core in userland and the RTOS
services in kernel space will be the POSIX API, the standard NPTL one
with -rt, the Xenomai POSIX API in dual kernel mode.

A prototype for the userland emulation core already exists, it's the
Xenomai/SOLO base library. http://git.denx.de/?p=xenomai-solo.git;a=tree
It will be extended for X3, but the main logic is already there.

> 
> http://www.xenomai.org/index.php/Xenomai:Roadmap#Toward_Xenomai_3
> 
> > 
> > 
> > 
> > Regards,
> > Wael
> > 
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 
> 
> -- 
> Philippe.
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



