Message-ID: <482368B8.9070008@domain.hid>
Date: Thu, 08 May 2008 22:55:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4823620F.3020904@domain.hid>
In-Reply-To: <4823620F.3020904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [BUG] ipipe_sync_stage deadlock
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> I love KVM - not only because I'm heavily hacking on it now, also
> because it is so easy to trigger various kinds of guest issues with
> it (SMP host + threaded virtual CPUs => true SMP guest - and if you
> want to watch fancy things happen, just load one host core).
> 
> Here is one I found that way:
> 
> void fastcall __ipipe_sync_stage(unsigned long syncmask)
> {
> [ ... ]
> 	while ((mask = (ipipe_this_cpudom_var(irqpend_himask) & syncmask)) != 0) {
> 		level = __ipipe_ffnz(mask);
> 
> 		while ((submask = ipipe_this_cpudom_var(irqpend_lomask)[level]) != 0) {
> 			rank = __ipipe_ffnz(submask);
> 			irq = (level << IPIPE_IRQ_ISHIFT) + rank;
> 
> 			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
> 				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
- 				continue;
+				goto rpm_needs_more_neurons;
> 			}
> 
> 			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
> 
+ rpm_needs_more_neurons:
> 			if (ipipe_this_cpudom_var(irqpend_lomask)[level] == 0)
> 				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
> [ ... ]
> 
> Who sees the deadlock? 100 points for the right answer! But be quick,
> I'm already hacking on a fix. :)
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.

