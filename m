Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <452E9ACD.20800@domain.hid>
References: <452E9ACD.20800@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:42:07 +0200
Message-Id: <1161178927.5053.81.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2006-10-12 at 21:43 +0200, Jan Kiszka wrote:

[...]

> It continues with the second patch that applies xnstat on the IRQ
> subsystem, both for counting hits as well as for measuring the execution
> time. The accounting model applied in this patch is as simple as this:
> measure the time some driver- or application-supplied ISR executes and
> accumulate it per-CPU. The rescheduling is still accounted to the
> preempted thread.
> 
> In my endless quest for perfection, I applied an -as I feel- enhanced
> model on top of this (already working!) set, that's the third patch.
> This model adds the scheduler path to the IRQ account. And it only
> accounts to an IRQ if its ISR reported XN_ISR_HANDLED. This is relevant
> for shared IRQs when only one source fired (the typical case). Also, it
> reduces churning by avoiding account switches in the average case. But,
> the downside, it may be less convenient to understand and increases the
> code a bit (only for the shared IRQ case). Dmitry and I were not yet
> able to agree on THE model, so I'm simply posting both for public
> feedback. :)

The bottom-line is that /proc/xenomai/stats should provide information
allowing people to better understand how their applications/drivers
perform, which has a higher priority than allowing us to understand how
the nucleus behaves. In this vein, having the rescheduling path
accounted and charged to the ISR - and not to the preempted thread -
provides a more accurate information, since this operation is quite
significant time-wise, and it seems unfair and inaccurate to charge any
random thread for this.

The issue about whether we should integrate every bit of the ISR runtime
into the accounted value (including source detection for shared
interrupts), or not by filtering on XN_ISR_HANDLED, seems related to the
previous point. At first sight, I would also filter out unhandled IRQs,
given that accepting an interrupt and performing actions upon it should
be more significant time-wise than solely probing the IRQ sources. 

Dmitry, are there other issues I'm missing, that you think would be
better solved using a simpler accounting model?

-- 
Philippe.



