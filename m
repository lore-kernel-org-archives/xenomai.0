Message-ID: <4448F656.6070101@domain.hid>
Date: Fri, 21 Apr 2006 17:12:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4448EE7D.1020003@domain.hid>
In-Reply-To: <4448EE7D.1020003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [PATCH] let ipipe_catch_event
	return old handler
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
Cc: adeos-main@gna.org, xenomai@xenomai.org

Jan Kiszka wrote:

<snip>

Don't you mean this instead?

> -int ipipe_catch_event(struct ipipe_domain *ipd,
> -		      unsigned event,
> -		      int (*handler)(unsigned event, struct ipipe_domain *ipd, void *data))
> +ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
> +					unsigned event,
> +					ipipe_event_handler_t handler)
>  {
+       ipipe_event_handler_t old_handler;
>  	int self = 0;
>  
> @@ -278,7 +278,7 @@
>  	}
>  
>  	if (event >= IPIPE_NR_EVENTS)
> -		return -EINVAL;
> +		return NULL;
>  
-  	if (!xchg(&ipd->evhand[event],handler))	{
+  	if (!(old_handler = xchg(&ipd->evhand[event],handler)))	{
>  		if (handler) {
> @@ -301,7 +301,7 @@
>  			ipd->evself |= (1LL << event);
>  	}
>  
> -	return 0;
> +	return handler;
-	return handler;
+	return old_handler;
>  }
>  
>  cpumask_t ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)
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

