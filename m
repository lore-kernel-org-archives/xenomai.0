Message-ID: <47E8B4FC.5010708@domain.hid>
Date: Tue, 25 Mar 2008 09:17:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47C51F5B.6090903@domain.hid>
In-Reply-To: <47C51F5B.6090903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [RFC][PATCH] Reduce pipeline_head access overhead
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
> This patch is in fact part of my xnlock rework (updates on that one will
> follow the next days). I noticed that the complexity of
> ipipe_cpudom_var(head_domain, *), normally inlined, is fairly relevant
> for the text size of Xenomai and may thus impact the WCET as well.
> 
> So I applied the same pattern as already used for ipipe_root_cpudom_var
> also to the head domain, ie. assigned a fixed slot, the topmost, in
> ipipe_percpu_daddr/darray to the head domain. This gives a nice text
> size reduction as we no longer need to go via
> __ipipe_pipeline.next->slot (2 memory accesses, even 3 on x867/SMP +
> some arithmetics) to look up the address of per-cpu domain variables
> like "status".
> 
> The drawback is that this introduces an inconsistency to the
> ipipe_*_pipeline_head API: It no longer works for head == root. While
> this is most probably irrelevant in practice, it remains ugly. I already
> thought about renaming the modified services (and deprecating the
> original ones), but for now I would like to focus the discussion on the
> optimized services.
> 
> The patch already survived quite some testing on various real and
> virtual boxes with Xenomai. Latency reduction is hard to estimate as
> such comparably small optimizations are within the noise range of fast
> test boxes. Maybe someone could give this a try on a smaller device (UP
> should benefit from this patch as well!).
>

The root domain cannot be an invariant pipeline head, by design, so I don't see
any showstopper regarding this approach. This looks good.

> Jan
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

