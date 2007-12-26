Message-ID: <47729E7C.1050909@domain.hid>
Date: Wed, 26 Dec 2007 19:33:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <477275F1.6020708@domain.hid>
In-Reply-To: <477275F1.6020708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix __ipipe_tick_irq tracking across
	APIC reprogramming
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> As LOCAL_TIMER_VECTOR != RTHAL_APIC_TIMER_VECTOR (Philippe, what was the
> motivation for this?),

In some cases, it's much saner to have two separate timer hw interrupt
sources, so that we may trigger a timer tick targeted at the Linux
kernel only from whatever domain, while grabbing the real-time timer
interrupt within the Xenomai domain, without getting any "boomerang"
effect. This is why we grab IPI3 and propagate to the local timer vector.

 we need to update __ipipe_tick_irq when we
> reprogram the APIC. Otherwise, I-pipe will not be able to capture and
> forward the related IRQ registers.
> 
> At this chance, refactor some references to Xenomai's own APIC timer IRQ.
> 
> Merry Christmas and all the best for 2008 to everyone!
> 

Thanks, best wishes for 2008 too.

> Jan
> 


-- 
Philippe.

