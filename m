Message-ID: <43C2D90B.30504@domain.hid>
Date: Mon, 09 Jan 2006 22:43:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH, RFC] nucleus:shared irq, draft v.2
References: <b647ffbd0601091221h5596da2fg@domain.hid>
In-Reply-To: <b647ffbd0601091221h5596da2fg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigACF4746007C0BAC66533FC73"
Sender: jan.kiszka@domain.hid
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACF4746007C0BAC66533FC73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dmitry Adamushko wrote:
> Hi everybody,
> 
> I'm presenting it one last time as a draft, so it's a right time to give all
> the remarks concerning design/implementation issues for all interested
> parties.
> 
> Any feedback is wellcome.
> 
> --
> Best regards,
> Dmitry Adamushko
> 

My mail client unfortunately refused to inline your patches, so I have to:

> --- intr-cvs.c	2005-12-02 19:56:20.000000000 +0100
> +++ intr.c	2006-01-09 21:26:44.000000000 +0100
[...]
> @@ -204,11 +242,66 @@
>  int xnintr_attach (xnintr_t *intr,
>  		   void *cookie)
>  {
> +    rthal_irq_handler_t irq_handler;
> +    unsigned irq = intr->irq;
> +    xnshared_irq_t *shirq;
> +    int err = 0;
> +    spl_t s;
> +
>      intr->hits = 0;
>      intr->cookie = cookie;
> -    return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
> +
> +    xnlock_get_irqsave(&nklock,s);
> +
> +    irq_handler = rthal_irq_handler(&rthal_domain,irq);
> +    
> +    if (irq_handler)
> +	{
> +	xnintr_t *old;
> +	shirq = rthal_irq_cookie(&rthal_domain,irq);
> +	
> +	if (irq_handler != &xnintr_irq_handler)
> +	    {
> +	    err = -EBUSY;
> +	    goto unlock_and_exit;
> +	    }
> +	
> +	old = link2intr(getheadq(&shirq->handlers));
> +
> +	if (!(old->flags & intr->flags & XN_ISR_SHARED))
> +	    {
> +	    err = -EBUSY;
> +	    goto unlock_and_exit;
> +	    }
> +	
> +	appendq(&shirq->handlers,&intr->link);
> +	}
> +    else
> +	{
> +	shirq = xnmalloc(sizeof(*shirq));

Why not allocating that piece of memory before taking the global lock?
If you don't need it, you can drop it again afterward. If you need but
the returned pointer is NULL, you can still check at the same place you
do now. Just an idea to avoid complex functions inside the global lock
for new xeno-code.

> +	
> +	if (!shirq)
> +	    {
> +	    err = -ENOMEM;
> +	    goto unlock_and_exit;
> +	    }
> +
> +	initq(&shirq->handlers);
> +	appendq(&shirq->handlers,&intr->link);
> +
> +	err = xnarch_hook_irq(irq,&xnintr_irq_handler,intr->iack,shirq);
> +	
> +	if (err)
> +	    xnfree(shirq);
> +	}
> +
> +unlock_and_exit:
> +    
> +    xnlock_put_irqrestore(&nklock,s);
> +    return err;
>  }
>  
> +
>  /*! 
>   * \fn int xnintr_detach (xnintr_t *intr)
>   * \brief Detach an interrupt object.
> @@ -241,7 +334,32 @@
>  int xnintr_detach (xnintr_t *intr)
>  
>  {
> -    return xnarch_release_irq(intr->irq);
> +    unsigned irq = intr->irq;
> +    xnshared_irq_t *shirq;
> +    int cleanup = 0;
> +    int err = 0;
> +    spl_t s;
> +
> +    xnlock_get_irqsave(&nklock,s);
> +
> +    shirq = rthal_irq_cookie(&rthal_domain,irq);
> +
> +    removeq(&shirq->handlers,&intr->link);
> +    
> +    if (!countq(&shirq->handlers))
> +	{
> +	err = xnarch_release_irq(irq);
> +	cleanup = 1;
> +	}
> +
> +    xnlock_put_irqrestore(&nklock,s);
> +
> +    xnintr_shirq_spin(shirq);
> +
> +    if (cleanup)
> +	xnfree(shirq);
> +
> +    return err;
>  }
>  
>  /*! 
> @@ -350,17 +468,45 @@

I guess here starts the new IRQ handler. BTW, diff -p helps a lot when
reading patches as a human being and not as a patch tool. ;)

>  
>  {
>      xnsched_t *sched = xnpod_current_sched();
> -    xnintr_t *intr = (xnintr_t *)cookie;
> -    int s;
> +    xnshared_irq_t *shirq = (xnshared_irq_t *)cookie;
> +    xnholder_t holder;
> +    spl_t flags;
> +    int s = 0;
>  
>      xnarch_memory_barrier();
>  
>      xnltt_log_event(xeno_ev_ienter,irq);
>  
> +    xnlock_get_irqsave(&nklock,flags);
> +
> +    shirq = rthal_irq_cookie(&rthal_domain,irq);
> +    xnintr_shirq_lock(shirq);
> +
> +    xnlock_put_irqrestore(&nklock,flags);

Why "_irqsave" in IRQ context?

Regarding this locking isssue in general, I first had some RCU-mechanism
in mind to avoid the reader-side lock in the IRQ handler. But as IRQs
typically touch some nucleus service with its own nklock-acquire anyway,
optimising this here does not seem to be worth the effort now. As long
as we have the global lock, it's ok and much simpler I think.

> +    
> +    if (!shirq)
> +	{
> +	xnintr_shirq_unlock(shirq);
> +	xnltt_log_event(xeno_ev_iexit,irq);
> +    	return;
> +	}
> +    
>      ++sched->inesting;
> -    s = intr->isr(intr);
> +    
> +    holder = getheadq(&shirq->handlers);
> +    
> +    while (holder)
> +	{
> +	xnintr_t *intr = link2intr(holder);
> +	holder = nextq(&shirq->handlers,holder);
> +
> +	s |= intr->isr(intr);
> +	++intr->hits;
> +	}
> +
> +    xnintr_shirq_unlock(shirq);
> +
>      --sched->inesting;
> -    ++intr->hits;
>  
>      if (s & XN_ISR_ENABLE)
>  	xnarch_enable_irq(irq);

Looking forward to see this in Xenomai - at letting some real tests run
with it. :)

Jan

--------------enigACF4746007C0BAC66533FC73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwtkLniDOoMHTA+kRAjw6AJ9dwzO/iGDy6oucm1wzP2PUJAxRGwCfXYhi
hCRJvoVbFhdN2vU+SdBa6IQ=
=KfTi
-----END PGP SIGNATURE-----

--------------enigACF4746007C0BAC66533FC73--

