Date: Tue, 18 Nov 2014 07:28:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141118062856.GU31920@sisyphus.hd.free.fr>
References: <20141110205512.GW17476@sisyphus.hd.free.fr>
 <20141110215846.GX17476@sisyphus.hd.free.fr>
 <20141112172738.GD17476@sisyphus.hd.free.fr>
 <546A26C0.1050309@siemens.com>
 <20141117165924.GM26613@sisyphus.hd.free.fr>
 <546A2C50.3060204@siemens.com>
 <20141117173330.GR26613@sisyphus.hd.free.fr>
 <546A477B.4020602@siemens.com>
 <20141117192417.GA31920@sisyphus.hd.free.fr>
 <546AE4E5.7060804@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546AE4E5.7060804@siemens.com>
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Nov 18, 2014 at 07:19:17AM +0100, Jan Kiszka wrote:
> On 2014-11-17 20:24, Gilles Chanteperdrix wrote:
> > On Mon, Nov 17, 2014 at 08:07:39PM +0100, Jan Kiszka wrote:
> >> On 2014-11-17 18:33, Gilles Chanteperdrix wrote:
> >>> On Mon, Nov 17, 2014 at 06:11:44PM +0100, Jan Kiszka wrote:
> >>>> On 2014-11-17 17:59, Gilles Chanteperdrix wrote:
> >>>>> On Mon, Nov 17, 2014 at 05:48:00PM +0100, Jan Kiszka wrote:
> >>>>>> On 2014-11-12 18:27, Gilles Chanteperdrix wrote:
> >>>>>>> We do not need trace_hardirqs_on and trace_hardirqs_off for the
> >>>>>>> particular case of IRQs: they are already handled by
> >>>>>>> __ipipe_do_sync_stage. 
> >>>>>>
> >>>>>> That was the key: Simply disabling the instrumentations in the
> >>>>>> CONFIG_IPIPE removes all lock state inconsistencies, at least this far:
> >>>>>>
> >>>>>> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> >>>>>> index d32f8bd..d8e0b2c 100644
> >>>>>> --- a/arch/arm/kernel/entry-header.S
> >>>>>> +++ b/arch/arm/kernel/entry-header.S
> >>>>>> @@ -195,7 +195,7 @@
> >>>>>>  #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
> >>>>>>  	bl	__ipipe_bugon_irqs_enabled
> >>>>>>  #endif
> >>>>>> -#ifdef CONFIG_TRACE_IRQFLAGS
> >>>>>> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
> >>>>>>  	@ The parent context IRQs must have been enabled to get here in
> >>>>>>  	@ the first place, so there's no point checking the PSR I bit.
> >>>>>>  	bl	trace_hardirqs_on
> >>>>>> @@ -203,7 +203,7 @@
> >>>>>>  	.else
> >>>>>>  	@ IRQs off again before pulling preserved data off the stack
> >>>>>>  	disable_irq_notrace
> >>>>>> -#ifdef CONFIG_TRACE_IRQFLAGS
> >>>>>> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
> >>>>>>  	tst	\rpsr, #PSR_I_BIT
> >>>>>>  	bleq	trace_hardirqs_on
> >>>>>>  	tst	\rpsr, #PSR_I_BIT
> >>>>>>
> >>>>>> Will send a patch.
> >>>>>
> >>>>> Will this work for other paths in entry.S, such as exceptions or
> >>>>> syscalls?
> >>>>
> >>>> Do they all come along that code? Then we need to differentiate, likely
> >>>> via a separate macro parameter.
> >>>>
> >>>> Just noticed that there is also svc_enter, and that should be handled in
> >>>> the same way. And it's likely also shared across the board.
> >>>
> >>> There are 4 macros:
> >>> svc_enter
> >>> svc_exit
> >>> when entering/exiting svc mode (whether from irq, data abort,
> >>> prefetch abort), that means reentering the
> >>> irq/exception path when already in kerne-mode
> >>>
> >>> usr_enter
> >>> usr_exit
> >>> when entering/exiting usr mode (whether from irq, data abort,
> >>> prefetch abort, or syscall), which is entered from user mode.
> >>>
> >>> All these paths call trace_hardirqs_on/trace_hardirqs_off
> >>> I have not checked the details on the how and when and if, but since
> >>> you are the one working on this, I suggest you do.
> >>>
> >>> If there is a need to call the real
> >>> trace_hardirqs_on/trace_hardirqs_off in some cases, I would very
> >>> much prefer replacing the bl trace_hard_irqs* with a bl
> >>> __ipipe_trace_hardirqs* sorting out the details in C, in
> >>> arch/arm/kernel/ipipe.c, than doing this in assembly files with
> >>> complicated #if conditions, or retrieval of the current domain
> >>> in assembly.
> >>>
> >>
> >> OK, here is another proposal: filter out tracing in kernel IRQ exit path
> >> (that is required as we may have interrupted Linux with virtual IRQs
> >> off), but otherwise rely on domain filtering in the respective tracing
> >> functions:
> > 
> > The only case where it does not work, is for asymmetric things,
> > namely syscalls, and exceptions (page faults) because you
> > can enter a syscall or exception in secondary mode (so
> > trace_hardirqs_on gets called) and leave in primary mode, in which
> > case you will reenter root with the kernel considering that hardirqs
> > are off whereas they may not be.
> > 
> > Listen, you have stop trying and testing patches and just say "it
> > works, so, take my patch", this will not work. I absolutely require
> > of you that you enumerate for each case, what the code does, and why
> > it works. I will not accept a patch that was quickly tested and
> > appeared to work. I consider that stuff a corner case, and not
> > really useful, so, I would very much prefer get it to depend on
> > !IPIPE. However, you seem to want and have it working, that is fine
> > by me, but in that case do the work well, so that we do not get
> > users complaining that it does not work in corner cases.
> 
> The current changes already return lockdep to usable state, which is an
> improvement.

If this causes the kernel to hang and crash in some cases, no this
is not an improvement over "depends on !IPIPE", which is what I will
merge unless you provide me with something better. See, you are not
competing with the current state of the I-pipe, you are competing
with "depends on !IPIPE".

> Plus they remove remaining risks to call the tracing
> functions over the head domain, another improvement over the existing
> code, for all archs. That this may not catch all migration corner cases
> yet shouldn't be your worries - if you don't care about lockdep at all.

As soon as I merge your patch, I am the one maintaining it, this
means I will start enabling LOCKDEP in my "full debug" configuration
when validating the I-pipe patch, and I do not want it to crash.
Besides I am the one answering user requests about the I-pipe patch
for the ARM architecture, and I do not want to have to deal with
users reporting weird crashes with LOCKDEP turned on. So, this will
become my worry, and no, I do not want any case not covered by your
patch. Besides there are not that many paths in entry.S, so asking
for a thorough analysis is not asking for something tedious or
complicated..

> 
> However, I will propose properly described and signed-off patches for
> merge once testing and analysis provide the required confidence in the
> approach.

Validation by testing is required, but by no means as valuable as a
good design.

-- 
					    Gilles.

