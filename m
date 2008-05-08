Message-ID: <48236F39.1000002@domain.hid>
Date: Thu, 08 May 2008 23:23:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4823620F.3020904@domain.hid> <482368B8.9070008@domain.hid>
	<482369FE.6070508@domain.hid> <48236CE2.5050907@domain.hid>
In-Reply-To: <48236CE2.5050907@domain.hid>
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
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> I love KVM - not only because I'm heavily hacking on it now, also
>>>> because it is so easy to trigger various kinds of guest issues with
>>>> it (SMP host + threaded virtual CPUs => true SMP guest - and if you
>>>> want to watch fancy things happen, just load one host core).
>>>>
>>>> Here is one I found that way:
>>>>
>>>> void fastcall __ipipe_sync_stage(unsigned long syncmask)
>>>> {
>>>> [ ... ]
>>>> 	while ((mask = (ipipe_this_cpudom_var(irqpend_himask) & syncmask)) != 0) {
>>>> 		level = __ipipe_ffnz(mask);
>>>>
>>>> 		while ((submask = ipipe_this_cpudom_var(irqpend_lomask)[level]) != 0) {
>>>> 			rank = __ipipe_ffnz(submask);
>>>> 			irq = (level << IPIPE_IRQ_ISHIFT) + rank;
>>>>
>>>> 			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
>>>> 				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
>>> - 				continue;
>>> +				goto rpm_needs_more_neurons;
>>>> 			}
>>>>
>>>> 			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
>>>>
>>> + rpm_needs_more_neurons:
>>>> 			if (ipipe_this_cpudom_var(irqpend_lomask)[level] == 0)
>>>> 				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
>>>> [ ... ]
>>>>
>> Of course, I'm not saying this is the real fix, but that just points at a
>> possible issue. I do want those 100 points on my score card.
> 
> Well, I wasn't asking for a fix, just for spotting the gremlin - so you
> won! :->
> 

Ah! Great. So this is the ultimate proof that when it comes to software
development, one neuron is one too many!

> Then let us fix this for real:
>

Ok, will merge thanks.

> ---
>  kernel/ipipe/core.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> Index: b/kernel/ipipe/core.c
> ===================================================================
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -957,16 +957,14 @@ void fastcall __ipipe_sync_stage(unsigne
>  			rank = __ipipe_ffnz(submask);
>  			irq = (level << IPIPE_IRQ_ISHIFT) + rank;
>  
> -			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
> -				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
> -				continue;
> -			}
> -
>  			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
>  
>  			if (ipipe_this_cpudom_var(irqpend_lomask)[level] == 0)
>  				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
>  
> +			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
> +				continue;
> +
>  			__set_bit(IPIPE_STALL_FLAG, &ipipe_this_cpudom_var(status));
>  
>  			if (ipd == ipipe_root_domain)
> 


-- 
Philippe.

