Subject: Re: [Adeos-main] Signalling virtual interrupts to higher priority
	domains
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <B213B204A377E148A31BC71DE4955C9702EBD59F@nbgm346a.ww004.siemens.net>
References: 
	 <B213B204A377E148A31BC71DE4955C9702EBD59F@nbgm346a.ww004.siemens.net>
Content-Type: text/plain
Message-Id: <1097614490.672.6.camel@domain.hid>
Mime-Version: 1.0
Date: Tue, 12 Oct 2004 22:59:31 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Neugebauer Manfred <manfred.neugebauer@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2004-10-04 at 11:28, Neugebauer Manfred wrote:
> Hallo,
> 
> I'm using the Adeos nanokernel (2.6.8.1-i386-r7c2) within a project to
> implement a specific realtime environment embedded within Linux. I
> recognized the following problem sending virtual interrupts between Linux
> and my realtime domain (having a higher priority):
> 
> First I created a virtual interrupt in my realtime domain using
> adeos_alloc_irq() and adeos_virtualize_irq_from(). This worked fine. 
> 
> My first problem was to signal a virtual interrupt from the Linux domain.
> adeos_schedule_irq() and adeos_propagate_irq() seem to start from the
> current (or the next) domain to signal the interrupt to one domain down
> within the domain chain. Since my receiving domain has a higher priority
> than the Linux domain, no interrupts were signalled. I solved this problem
> by using the call __adeos_schedule_irq() with (&__adeos_pipeline)->next as
> starting point. An idea may be always to use __adoes_pipeline as a start
> point when applying adeos_schedule_irq().

> 
> The second problem appeared when I looked at the specific timing sequence
> between sending and receiving this interrupt. From my point of view it looks
> this way that the interrupt is only signaled to the interrupt array in the
> higher priority domain, but the domain is not started. This will be done
> later, when a different (hardware) interrupt or a software event forces the
> higher priority domain to be scheduled. This behavior is not in the way I
> expected: I prefered an immediate start of the higher priority domain.
> 

Use adeos_trigger_irq() to send interrupts to the head of the pipeline.
Linux will be preempted as you wish. propagate/schedule() are only used
to make the IRQ progress down the pipeline as you noticed, possibly
starting at the current stage if you want to log it and have it played
when the next sync occurs, or start with the next stage directly.

> I don't know whether this behavior is planned (or I do something wrong).
> Additional information is appreciated.
> 
> Manfred.
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


