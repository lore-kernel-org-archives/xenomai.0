Message-ID: <44416943.4070702@domain.hid>
Date: Sat, 15 Apr 2006 23:44:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
In-Reply-To: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
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
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Hi,
> 
> the following question/suggestion :
> 
> it could be good to eliminate the use of rthal_critical_enter/exit()
> from rthal_irq_request() if it's not
> strictly necessary.
> 
> 
> the proposal :
> 
> int rthal_irq_request (unsigned irq,
> 		       rthal_irq_handler_t handler,
> 		       rthal_irq_ackfn_t ackfn,
> 		       void *cookie)
> {
> -    unsigned long flags;
>     int err = 0;
> 
>     if (handler == NULL || irq >= IPIPE_NR_IRQS)
> 	return -EINVAL;
> 
> -    flags = rthal_critical_enter(NULL);
> -
> -    if (rthal_irq_handler(&rthal_domain, irq) != NULL)
> -	{
> -	err = -EBUSY;
> -	goto unlock_and_exit;
> -	}
> -
>     err = rthal_virtualize_irq(&rthal_domain,
> 			       irq,
> 			       handler,
> 			       cookie,
> 			       ackfn,
> -			       IPIPE_DYNAMIC_MASK);
> +				IPIPE_DYNAMIC_MASK|IPIPE_EXCLUSIVE_MASK);
> 
> - unlock_and_exit:
> -
> -    rthal_critical_exit(flags);
> -
>     return err;
> }
> 
> IPIPE_EXCLUSIVE_MASK causes a -EBUZY error to be returned by
> ipipe_virtualize_irq() when
> handler != NULL and the current ipd->irqs[irq].handler != NULL.
> 

Sounds reasonable. Using the synchronized inter-processor lock is most 
often a bad idea except in very specific initialization/shutdown stuff 
at Adeos level anyway, and this does introduce deadlock issues at 
Xenomai level when inadvertently using it with the nklock held, so let's 
get rid of this. In the rthal_irq_request() case, it's even useless indeed.

> (IPIPE_EXCLUSIVE_MASK is actually not used at the moment anywere,
> though ipipe_catch_event() is mentioned in comments).
>

The existing flag was aimed to implement self-directed events, but I 
eventually this support differently, so we can recycle it safely.

> Another variant :
> 
> ipipe_virtualize_irq() should always return -EBUZY when handler !=
> NULL and the current ipd->irqs[irq].handler != NULL,
> not taking into account the IPIPE_EXCLUSIVE_FLAG.
> 
>

<snip>

> --
> Best regards,
> Dmitry Adamushko
> 


-- 

Philippe.

