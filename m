Message-ID: <505AF49D.6020905@xenomai.org>
Date: Thu, 20 Sep 2012 12:49:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com>
In-Reply-To: <505AF205.6010206@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Revert "ipipe: ipipe_request_irq(),
 ipipe_free_irq() are root-only services"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 09/20/2012 12:37 PM, Jan Kiszka wrote:
> This reverts commit 073ff1e8045d0311b8cf390687c0ba3619681672.
> 
> Both service are NOT just root-only services. E.g., rtdm_irq_request
> requires by specification support also over non-Linux contexts.

Nack. We can't run the enable code for MSIs over non-root, and
that code typically follows the irq request. Besides, we want to mask
the source upon irq free to handle the SMP case properly, which we could
not do from non-root with MSIs.

So either we have both request+enable and free usable over non-root, or
there is no point.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> We run all critical code under an I-pipe spin lock, so this restriction
> seems artificial. Nevertheless, I briefly checked if some arch has
> specific needs but didn't find any trace in core-3.5.
> 
> Wolfgang, this already resolves the issue I mentioned regarding startup
> of RTnet NICs.
> 
>  kernel/ipipe/core.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 9898b92..23a2146 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -846,8 +846,6 @@ int ipipe_request_irq(struct ipipe_domain *ipd,
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	ipipe_root_only();
> -
>  	if (handler == NULL ||
>  	    (irq >= IPIPE_NR_XIRQS && !ipipe_virtual_irq_p(irq)))
>  		return -EINVAL;
> @@ -881,8 +879,6 @@ void ipipe_free_irq(struct ipipe_domain *ipd,
>  {
>  	unsigned long flags;
>  
> -	ipipe_root_only();
> -
>  	spin_lock_irqsave(&__ipipe_lock, flags);
>  
>  	if (ipd->irqs[irq].handler == NULL)
> 


-- 
Philippe.

