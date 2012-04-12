Message-ID: <4F86FB84.3030009@domain.hid>
Date: Thu, 12 Apr 2012 17:57:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F7333E7.7030608@domain.hid> <4F7339A8.6060701@domain.hid>
	<4F735716.4020508@domain.hid> <4F7C7DEA.5070201@domain.hid>
	<990B36E792F1A4488D3E2B1C46FD62D692DDD85791@domain.hid>
In-Reply-To: <990B36E792F1A4488D3E2B1C46FD62D692DDD85791@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Pustylnik <MichaelPustylnik@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/12/2012 05:45 PM, Michael Pustylnik wrote:
> The code masking the interrupt in IPIC (call for
> ipipe_pre_cascade_noeoi()) initially showed up in the patch you
> recommended (see your email attached).
>
> Later on it was integrated in Xenomai commit
> "9a5e42df8bccc59620c08caeb4b9fe92dbf94a1b".
>
> As shown in the trail below, it keeps interrupts all the time until the
> scheduler returns, thus breaking real-time responsiveness.
>
> A solution to this is probably to remove calling
> ipipe_pre_cascade_noeoi() and let the cascading handler mask the
> interrupt. Am I missing something? Do you think it is safe to use this
> solution?

No, as interrupts could be re-enabled before invoking the handler, you=20
would get an IRQ storm.

The solution is to rework the cascaded IRQ handling in the generic=20
pipeline core, so that all decoded IRQs are acked/masked, then the=20
multiplex IRQ unmasked, then all the decoded IRQ handlers fired when=20
syncing the relevant pipeline stage.

A fix for this will follow when enough testing will have been done on=20
arm and ppc, to check whether that logic does not raise other issue.

>
> Michael Pustylnik, P.Eng.
> Senior Software Engineer
> *RuggedCom Inc.*
> www.ruggedcom.com <http://www.ruggedcom.com/>
> 300 Applewood Crescent
> Concord, Ontario, L4K 5C7
> Tel: (905)482-4523
> Fax: (905)856-1995
>
> ------------------------------------------------------------------------
>
> *From:*xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] *On Behalf Of *Makarand Pradhan
> *Sent:* Wednesday, April 04, 2012 12:59 PM
> *To:* Philippe Gerum
> *Cc:* xenomai@xenomai.org
> *Subject:* Re: [Xenomai-help] Interrupt latency greater than 250ms.
> Question.
>
> Hi Philippe,
>
> We have found that the problem is that the interrupt is unexpectedly
> held masked at the IPIC level for a long time. Please find the trace belo=
w:
>
> 2552 :| + func -54413 0.590 qe_ic_cascade_low_ipic+0x8
> (__ipipe_ack_irq+0x2c)
> 2553 :| + func -54412 0.696 qe_ic_get_low_irq+0x8
> (qe_ic_cascade_low_ipic+0x30)
> 2554 :| + func -54411 0.666 irq_linear_revmap+0x8 (qe_ic_get_low_irq+0x5c)
>
> *MASK in IPIC (SIMSR_H register bit 1)*
> 2555 :| + func -54411 0.606 ipic_mask_irq+0x8 (qe_ic_cascade_low_ipic+0x4=
8)
> 2556 :| + func -54410 0.590 irqd_to_hwirq+0x8 (ipic_mask_irq+0x30)
> 2557 :| + func -54410 0.909 __ipipe_spin_lock_irqsave+0x8
> (ipic_mask_irq+0x40)
> 2558 :| # func -54409 0.727 __ipipe_spin_unlock_irqrestore+0x8
> (ipic_mask_irq+0xa8 )
> 2559 :| + func -54408 0.560 __ipipe_qe_ic_cascade_irq+0x8
> (qe_ic_cascade_low_ipic+ 0x5c)
> 2560 :| + begin 0x0000002b -54407 0.530 __ipipe_qe_ic_cascade_irq+0x2c
> (qe_ic_cascade_low_ipic +0x5c)
> 2561 :| + func -54407 0.651 __ipipe_handle_irq+0x8
> (__ipipe_qe_ic_cascade_irq+0x38 )
> 2562 :| + func -54406 0.939 __ipipe_ack_level_irq+0x8
> (__ipipe_handle_irq+0xbc)
>
> *MASK in QUICC (CIMR register bit 11)*
> 2563 :| + func -54405 0.787 qe_ic_mask_irq+0x8 (__ipipe_ack_level_irq+0x4=
0)
>
> *XENOMAI SCHEDULER IS INVOKED*
> 2576 :| # func -54393 0.590 __xnpod_schedule+0x8 (xnintr_irq_handler+0x1f=
8)
> *
> UNMASK in QUICC (done by our user space handler)*
> 2595 : + func -54377 0.621 __rt_intr_enable+0x8 [xeno_native]
> (hisyscall_event+0x 1e4)
>
> *UNMASK in IPIC (after 50ms, i.e. only after the scheduler returns):*
> 31637 :| #end 0x0000002b -518+ 2.272 __ipipe_qe_ic_cascade_irq+0x40
> (qe_ic_cascade_low_ipic+ 0x5c)
> 31638 :| #func -516+ 1.090 ipic_unmask_irq+0x8 (qe_ic_cascade_low_ipic+0x=
70)
>
> As you can see from the trace above, the interrupt is held masked at the
> IPIC level all the time until the Xenomai scheduler returns and is only
> unmasked after that.
>
> Is it really the way it should be? Shouldn=92t the interrupt be unmasked
> at the IPIC level right after masking it at the QUICC engine level?
>
> Rgds,
> Mak.
>
>
>
> On 28/03/12 02:23 PM, Makarand Pradhan wrote:
>
> Hi Philippe,
>
>
>
> On 28/03/12 12:17 PM, Philippe Gerum wrote:
>
>> The log says your code wants to control when the IRQ is enabled again,
>> by calling rt_intr_enable() from userland. I guess you are setting
>> I_NOAUTOENA too. Correct?
>
>
> That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the
>
> level trigerred interrupt will not allow the userland processing of the
>
> int. The userland handler is very small and it unconditionally
>
> rt_intr_enables the intr.
>
>
>
> Testing indicates that the interrupt is always enabled from user space
>
> within 250 usec after kernel gets the interrupt.
>
>
>
> I have noted that unless I see"#end 0x0000002b"  and a hit to the
>
> ipic_unmask_irq, the next interrupt is not processed.
>
>
>
> And this is getting delayed once in a while which causes a delay in
>
> processing the next interrupt.
>
>
>
> So the sequence of events leading to the problem is:
>
>
>
> 1. Get interrupt: #begin      0x0000002b noted in ipipe trace
>
> 2. Intr enabled from user space. Always happens roughly within 250usec.
>
> 3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipip=
e.
>
>
>
> When I see the problem, step 3 is delayed. I am trying to capture a
>
> trace where the begin, int enable and end are captured.
>
>
>
> Your thoughts on what might cause this delay would be appreciated.
>
>
>
> Rgds,
>
> Mak.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> --
>
> _________________________________________________________________________=
__
>
> NOTICE OF CONFIDENTIALITY:
>
> This e-mail and any attachments may contain confidential and privileged i=
nformation.  If you are
>
> not the intended recipient, please notify the sender immediately by retur=
n e-mail and delete this
>
> e-mail and any copies.    Any dissemination or use of this information by=
 a person other than the
>
> intended recipient is unauthorized and may be illegal.
>
> _____________________________________________________________________
>
>
>
>
>
> No virus found in this incoming message.
> Checked by AVG - www.avg.com
> Version: 8.5.455 / Virus Database: 271.1.1/4175 - Release Date: 04/03/12
> 18:35:00
>


--=20
Philippe.

