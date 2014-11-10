Date: Mon, 10 Nov 2014 21:14:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141110201409.GS17476@sisyphus.hd.free.fr>
References: <20141110124308.GK17476@sisyphus.hd.free.fr>
 <5460D139.7090709@siemens.com>
 <20141110155634.GM17476@sisyphus.hd.free.fr>
 <54610426.4080707@siemens.com>
 <20141110194606.GO17476@sisyphus.hd.free.fr>
 <5461182E.1060201@web.de>
 <20141110200028.GQ17476@sisyphus.hd.free.fr>
 <546119F2.4080709@web.de>
 <20141110200632.GR17476@sisyphus.hd.free.fr>
 <54611BB7.1090500@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54611BB7.1090500@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 10, 2014 at 09:10:31PM +0100, Jan Kiszka wrote:
> On 2014-11-10 21:06, Gilles Chanteperdrix wrote:
> > On Mon, Nov 10, 2014 at 09:02:58PM +0100, Jan Kiszka wrote:
> >> On 2014-11-10 21:00, Gilles Chanteperdrix wrote:
> >>> On Mon, Nov 10, 2014 at 08:55:26PM +0100, Jan Kiszka wrote:
> >>>> On 2014-11-10 20:46, Gilles Chanteperdrix wrote:
> >>>>> On Mon, Nov 10, 2014 at 07:29:58PM +0100, Jan Kiszka wrote:
> >>>>>> On 2014-11-10 16:56, Gilles Chanteperdrix wrote:
> >>>>>>> On Mon, Nov 10, 2014 at 03:52:41PM +0100, Jan Kiszka wrote:
> >>>>>>>> On 2014-11-10 13:43, Gilles Chanteperdrix wrote:
> >>>>>>>>> On Mon, Nov 10, 2014 at 09:08:47AM +0000, Stoidner, Christoph wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi Gilles,
> >>>>>>>>>>
> >>>>>>>>>>> Do you have the same message with exactly the same kernel
> >>>>>>>>>>> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?
> >>>>>>>>>>
> >>>>>>>>>> When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does not 
> >>>>>>>>>> appear on boot-up.
> >>>>>>>>>>
> >>>>>>>>>>> Do you have FCSE enabled? If yes, did you try disabling it? same
> >>>>>>>>>>> with unlocked context switch.
> >>>>>>>>>>
> >>>>>>>>>> FCSE is already disabled at all.
> >>>>>>>>>>
> >>>>>>>>>> Do you have an idea how to overcome the problem?
> >>>>>>>>>
> >>>>>>>>> I am not sure the lockdep message really is a problem. lockdep could
> >>>>>>>>> be confused by the fact that the hardware interrupts are not off
> >>>>>>>>> when running the I-pipe, or because we are missing some bit in the
> >>>>>>>>> I-pipe arm specific code to get it looking at the virtual mask
> >>>>>>>>> instead of the hardware mask.
> >>>>>>>>>
> >>>>>>>>> As for the scheduling while atomic and random segmentation fault,
> >>>>>>>>> you should use the I-pipe tracer, configure it with enough back
> >>>>>>>>> trace points, something like 1000 or 10000, and trigger a trace
> >>>>>>>>> freeze in the kernell code when the problem happens.
> >>>>>>>>>
> >>>>>>>>> Also, for the "scheduling while atomic", it may happen if you call
> >>>>>>>>> some Linux service which reschedules from primary mode, you can try
> >>>>>>>>> enabling I-pipe debugging, and in fact all Xenomai debugging, to try
> >>>>>>>>> and catch such mistakes. This is especially important if you are
> >>>>>>>>> running a custom skin.
> >>>>>>>>
> >>>>>>>> "Scheduling while atomic" may have the same reason why lockdep stumbles:
> >>>>>>>> some changes of I-pipe messe up with IRQ state tracing of Linux. I just
> >>>>>>>> started to look into this issue again. We tried earlier but got distracted.
> >>>>>>>
> >>>>>>> I doubt that very much. Though I never run with lockdep, I sometimes
> >>>>>>> run with CONFIG_PREEMPT, and never saw this message. From what I can
> >>>>>>> see, the "scheduling while atomic" message is based on the
> >>>>>>> preempt_count only and does not use irqs_disabled() (which by the
> >>>>>>> way is known to work with I-pipe on ARM as well, so, if something is
> >>>>>>> broken, that should be something more obscure).
> >>>>>>
> >>>>>> Let's see. I think I've identified one wrong path:
> >>>>>>
> >>>>>> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> >>>>>> index d32f8bd..ab911f8 100644
> >>>>>> --- a/arch/arm/kernel/entry-header.S
> >>>>>> +++ b/arch/arm/kernel/entry-header.S
> >>>>>> @@ -198,7 +198,10 @@
> >>>>>>  #ifdef CONFIG_TRACE_IRQFLAGS
> >>>>>>  	@ The parent context IRQs must have been enabled to get here in
> >>>>>>  	@ the first place, so there's no point checking the PSR I bit.
> >>>>>> -	bl	trace_hardirqs_on
> >>>>>> +	tst	\rpsr, #PSR_I_BIT
> >>>>>> +	bleq	trace_hardirqs_off
> >>>>>> +	tst	\rpsr, #PSR_I_BIT
> >>>>>> +	blne	trace_hardirqs_on
> >>>>>>  #endif
> >>>>>>  	.else
> >>>>>>  	@ IRQs off again before pulling preserved data off the stack
> >>>>>>
> >>>>>> This is probably no fix, but a with that change applied, the warning is
> >>>>>> gone. Now the question is what to really test for when returning here. I
> >>>>>> suppose we want the pipeline state of root here - should I
> >>>>>> __ipipe_check_root_interruptible?
> >>>>>
> >>>>> This does not make sense, read the comment above that change: there
> >>>>> is no way an interrupt can be taken, and so entering svc_entry, with
> >>>>> interrupts off. Besides this is mainline code, so it would be a
> >>>>> problem for mainline too. We are necessarily returning to a place
> >>>>> where hardware irqs were on.
> >>>>
> >>>> Did you also look at the trace I posted?
> >>>
> >>> Yes, but I did not see what I am supposed to see. The only thing I
> >>> see is that these trace functions should never have been called from
> >>> rt domain in the first place.
> >>>
> >>
> >> There is no RT domain in the trace, only an inconsistent Linux trace
> >> state after return from IRQ.
> > 
> > What can I say, when returning from IRQ, you are necessarily
> > returning to a point where irqs are ON, as the comment says, and it
> > makes perfect sense. So your "fix" should be a nop. So, something
> > else is broken.
> 
> The test is for selecting trace_hardirqs_off/on is wrong, that's why I
> was asking for a better check. Also, if that path can be taken by RT
> domains as well, calling trace_hardirqs_off/on was always wrong, and we
> additionally need to check for the caller's domain.
> 
> > 
> >>
> >>> Note that the fact that this trace_irqs stuff is not working well
> >>> may be the fact that part of them are commented with CONFIG_IPIPE
> >>> (see asm_trace_hardirqs_on_cond, asm_trace_hardirqs_off)
> >>
> >> No, that doesn't solve all issues. Even with my hack (which may not
> >> address all cases properly) plus the reversion of that commit, there are
> >> still inconsistencies.
> > 
> > You can not reverse that commit, otherwise you will end-up calling
> > trace_hardirqs_on/trace_hardirqs_off from RT domain,  which, I
> > repeat, can not work.
> 
> I can help to understand if that is sufficient to resolve the tracing
> breakage - it isn't, there are more paths missing or wrongly instrumented.

My idea of all this is that CONFIG_TRACE_IRQFLAGS should depend on
!IPIPE, since the I-pipe tracer provides the same functionality. And
is not broken.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141110/9d9110a1/attachment.sig>
