References: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail/x86 still broken /wrt exception fixups
In-reply-to: <d38b6799-ed3e-f384-a70e-51c2d5170c73@siemens.com>
Date: Wed, 02 Jun 2021 18:53:46 +0200
Message-ID: <87eedkgqcl.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> we are leaking the inband stall state into user land when the kernel
> takes a fixable exception in oob. The problem is either
> cond_disable_irqs() or its (missing?) counterpart. Where is the stall
> bit set in handle_page_fault->cond_disable_irqs supposed to be cleared
> again?
>

It depends: irqentry_exit_to_user_mode if the fault was triggered by
user, otherwise the assumption is made that any entry from kernel
context, unstalled _and_ in_band would lead to IRQENTRY_INBAND_STALLED
being set into the stage info bits.

Which is unfortunately wrong in one case: when the execution stage was
downgraded by the companion core from oob to in-band as a result of
handling the fault (oob_trap_notify). This is basically what you are
looking at ATM.

i.e.

oob exec from kernel:
        raw_copy_to/from_user(bad_u_pointer)
                irqentry_enter, IRQENTRY_OOB_ENTRY is set
                       handle_page_fault
                           do_user_addr_fault
                                oob_trap_notify, switching in-band
in-band:                   cond_disable_irqs
                irqentry_exit
                        in-band but !IRQENTRY_INBAND_STALLED => bummer,
                                            won't unstall

Would the fault have happened from in-band kernel context, and
IRQENTRY_INBAND_STALLED would have been set, preventing the issue.

This also means that this particular issue is different from the RCU
stall bug we mentioned this morning during the community call: that
setup never exercises stage transition between oob and in-band task
contexts, so we could not observe it with CONFIG_DOVETAIL off.

> I-pipe is fine in that regard, but it took us many years to get it into
> that state - and it didn't have to deal with the impact of ca4c6a9858
> ("x86/traps: Make interrupt enable/disable symmetric in C code") anymore...
>

The I-pipe required many years of fixing because it does way too many
things from the asm code, which is error-prone and caused painful merges
in many occasions. There is no valid reason for the fault handling path
to require years of fixing pipeline-wise in any case.

The logic of #ca4c6a9858 makes a lot of sense. Dovetail never assumed
anything wrt what the asm might do regarding the IRQ state anyway,
framing what happens from C code is much easier.

-- 
Philippe.

