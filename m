Message-ID: <44048246.9080002@domain.hid>
Date: Tue, 28 Feb 2006 18:03:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0602270656m4719d6aes@domain.hid>
In-Reply-To: <b647ffbd0602270656m4719d6aes@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (yet another movie :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hi there,
> 
> I have explicitly cc'ed Gilles as this patch affects the posix skin.
> 
> In the light of the recent discussions, the AUTOENA flag has been 
> converted to NOAUTOENA and the IRQ line is re-enabled on return from 
> xnintr_irq_handler() and shirq brothers by default.
> Also XN_ISR_CHAINED -> XN_ISR_PROPAGATE.
> 
> I'm still not sutisfied with results, namely - return values of ISR. 
> But, well, this is a quite separate question to the shirq support so the 
> later one should not remain in pending status only because of that.
> 
> I still would like to see something along scalar values : NONE, HANDLED, 
> PROPAGATE and xnintr_disable() being called in ISR to defer IRQ line 
> enabling (not .ending -> PROPAGATE does it).
> (*)
> 
> Currently, there is a XN_ISR_NOENABLE bit which asks the real-time layer 
> to defer the IRQ line, Warning!, .ending (and not just enabling) until 
> later. In common case, xnarch_end_irq() must be called by the rt_task 
> that stands for a bottom half (and not just xnintr_enable() - this may 
> not work on ppc).
> This adds a bit of confusion and we will avoid it with (*) scheme. So 
> this is a subject to change in the future.
> As I pointed out in another message, the implementation for PPC is not 
> yet clear at the moment. That's it...
>

That's great.

> Ok, are there any objections as to the current patch? If no, please apply.
>

Applied, thanks.

> CHANGELOG.patch is here 
> https://mail.gna.org/public/xenomai-core/2006-02/msg00154.html
> 
> -- 
> Best regards,
> Dmitry Adamushko


-- 

Philippe.

