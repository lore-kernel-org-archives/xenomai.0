Message-ID: <4FBB5393.5040003@xenomai.org>
Date: Tue, 22 May 2012 10:51:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com>, <4FBB4951.5070803@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : A possible mis-interaction between
 CONFIG_PREEMPT and GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2012 10:34 AM, Jean-Pascal JULIEN wrote:
> Hi,
> 
> I have patch with the http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=81bfc05c4716b76e79f5e486baf4c52015a3b92c. for avoid my IRQ latency.
> Unfortunately, I have the same result. 
> 
> Between the new patch and the patch of the next week this piece of code is missing.
> @@ -483,7 +483,8 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
>         else {
>                 head = __ipipe_pipeline.next;
>                 next_domain = list_entry(head, struct ipipe_domain, p_link);
> -               if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))) {
> +               if (!(flags & IPIPE_IRQF_NOSYNC)
> +                   && likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))) {
>                         if (!m_ack && next_domain->irqs[irq].acknowledge) {
>                                 desc = ipipe_virtual_irq_p(irq) ? NULL : irq_to_desc(irq);
>                                 next_domain->irqs[irq].acknowledge(irq, desc);
> 
> It is normally?

Yes, as I explained in the two mails you are replying to, you should try
the patch I posted.


-- 
					    Gilles.

