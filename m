From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CE18A9F.5030007@domain.hid>
References: <4CE18A9F.5030007@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 21:20:37 +0100
Message-ID: <1289852437.1933.173.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Flaw in x86-32 syscall/irq return path - and maybe
 more
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Mon, 2010-11-15 at 20:31 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> debugging some variant of I-pipe over an x86-32 target, I think I found
> some fairly old flaw in the IRQ virtualization that causes rescheduling
> delays (up to deadlocks) for Linux:
> 
> - we are in sysenter_tail (other exit paths should be affected as well)
> - we DISABLE_INTERRUPTS, but only virtually
> - we go past "testl $_TIF_ALLWORK_MASK, %ecx", nothing to be done
> - an IRQ for Linux arrives, it is pushed to the backlog
> - __ipipe_unstall_iret_root replays the IRQ as the regs we are about to
>   return to have IF set (obviously, we return from a syscall)
> - the Linux IRQ handler sets _TIF_NEED_RESCHED, but doesn't perform the
>   work on return as __ipipe_sync_stage set the stall flag for the Linux
>   domain before calling the handler
> - but now the preempted sysenter return also does no reschedule as it
>   already passed the check - bang!

Ouch. You must have had a really busy Monday to find this one.

> 
> Another variant of this Linux rescheduling issue:
> 
> - we are in a lengthy loop inside the kernel, but we are preemptible
>   most of the time
> - after disabling Linux IRQs briefly, we are calling
>   local_irq_enable() again
> - in the meantime, we received a Linux IRQ which is now pending in the
>   backlog
> - __ipipe_unstall_root triggers __ipipe_sync_stage
> - Linux handler is called, sets NEED_RESCHED but does not reschedule
>   (see above)
> - we do not test for resched again as we are not returning to user
>   space, and that for quite some time - bang!
> 
> I think both issues are only related to virtualizing DISABLE_INTERRUPTS
> for entry_32.S and I wonder if this doesn't finally qualify for a switch
> to the 64-bit model. Or do you see simpler fixes?
> 

We could probably use hw masking from sysenter_tail and on, but quite
frankly, I think this time, enough is enough and this bug calls for a
radical fix, which is indeed getting rid of interrupt virtualization in
the kernel entry/exit paths for x86_32, which no other arch ever
implemented anyway.

The decision to virtualize there as well was taken circa 2.4.18, when
upstream did not care that much about latency yet. Things have changed,
and there is no more reason to virtualize interrupts in very short
critical sections, at the expense of a lot more complexity.

- __ipipe_unstall_iret_root
- __ipipe_kpreempt_root
and much of the nonsense we do to track linux's interrupt state would go
away.

-- 
Philippe.



