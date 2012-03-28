Message-ID: <4F7339A8.6060701@domain.hid>
Date: Wed, 28 Mar 2012 18:17:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F7333E7.7030608@domain.hid>
In-Reply-To: <4F7333E7.7030608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms. Question.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2012 05:53 PM, Makarand Pradhan wrote:
> Hi All,
>
> I am working with MPC8360, Linux 3.0.0, Xenomai 2.6.
>
> I am experiencing delays as high as 250ms in processing interrupt 43
> (2b). Interrupt 43 indicates that the power quicc engine has
> transmitted/received a frame. This interrupt is being handled in Xenomai.
>
> The ipipe trace indicates that ipipe has kept the interrupt masked which
> may be the cause of the problem.
>
> The problem is seen intermittently after upgrading to Xenomai 2.6. This
> problem was never seen in Xenomai 2.4.10.
> *
> Normal operation:*
> Under normal operation, the irq is unmasked roughly within 300usecs.
> after it is masked on receipt of an int: e.g.
>
>  From attached file: *good_int2b_ipipe_frozen*

The log says your code wants to control when the IRQ is enabled again, 
by calling rt_intr_enable() from userland. I guess you are setting 
I_NOAUTOENA too. Correct?

>
> Int masked for 647 - 370 = 277 usec
> Int received:
> :| +begin 0x0000002b *-647 * 0.590 __ipipe_qe_ic_cascade_irq+0x2c
> (qe_ic_cascade_low_ipic+0x5c)
> :| +func -646 0.575 __ipipe_handle_irq+0x8 (__ipipe_qe_ic_cascade_irq+0x38)
> :| +func -646 0.787 __ipipe_ack_level_irq+0x8 (__ipipe_handle_irq+0xbc)
> :| +func -645 0.666 qe_ic_mask_irq+0x8 (__ipipe_ack_level_irq+0x40)
>
> Int unmasked:
> :| +end 0x0000002b *-370*+ 1.151 __ipipe_qe_ic_cascade_irq+0x40
> (qe_ic_cascade_low_ipic+0x5c)
> :| +func -369 0.742 ipic_unmask_irq+0x8 (qe_ic_cascade_low_ipic+0x70)
>
> *Problem scenario:*
> The ipipe trace indicates that the irq stayed masked for a long time:
>
> From: bad_int2b_ipipe_frozen
>
> The int stayed masked for more than 50ms after which it was unmasked:
>
> Int received: No begin 0x0000002b for more than 50ms. So the int has
> occurred more than 50ms ago.
>
> Int unmasked:
> :| #end 0x0000002b -434+ 2.272 __ipipe_qe_ic_cascade_irq+0x40
> (qe_ic_cascade_low_ipic+0x5c)
> :| #func -432+ 1.212 ipic_unmask_irq+0x8 (qe_ic_cascade_low_ipic+0x70)
>
>
> The ipipe traces are attached to this email for reference.
>
> Can you please help me understand the cause for this behavior? Any
> pointers would be appreciated.
>
> The interrupt is being handled in user space thorugh rt_intr_wait. Do I
> need to invoke a rt call to tell ipipe to unmask the intr?
>
> Please feel free to correct me if the traces are being interpreted wrongly.
>
> Warm Rgds,
> Mak.
>
>
>
> --
> ___________________________________________________________________________
> NOTICE OF CONFIDENTIALITY:
> This e-mail and any attachments may contain confidential and privileged information.  If you are
> not the intended recipient, please notify the sender immediately by return e-mail and delete this
> e-mail and any copies.  Any dissemination or use of this information by a person other than the
> intended recipient is unauthorized and may be illegal.
> _____________________________________________________________________
>
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

