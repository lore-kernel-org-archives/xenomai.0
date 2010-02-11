Message-ID: <4B73BBCC.6040907@domain.hid>
Date: Thu, 11 Feb 2010 09:11:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <245373446233674495BCA5CA2FC1EB173713B4D0CD@RCexchangeSVR1.ruggedcom.local>,
	<4B72F95E.3080402@domain.hid>
	<245373446233674495BCA5CA2FC1EB173713B4D0CF@RCexchangeSVR1.ruggedcom.local>,
	<4B72FBF1.2020109@domain.hid>
	<245373446233674495BCA5CA2FC1EB173713B4D0D1@domain.hid>
In-Reply-To: <245373446233674495BCA5CA2FC1EB173713B4D0D1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel oops when reading /proc/xenomai/stats
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Andreas Glatz wrote:
> Hi,
> 
>>>>> That's the kernel oops with additional debugging info (starts with 'HUHU' - see code below the oops):
>>>>>
>>>>> HUHU count=1 xnintr_count=-12
>>>> That's not good. What is your Xenomai version?
>>> Hardware=MPC8360, Linux=2.6.32, Xenomai=2.4.10, ipipe=2.8-00
>>>
>>>> Does everything work fine if you application terminates normally and
>>>> deletes the rt_intr objects explicitly?
>>> Checking...
>>>
>> And then you may want to track this down at the site that decrements
>> xnintr_count, ie. rt_intr_delete -> xnintr_detach.
> 
> This Email contains three patches.

Good catches! But please post them as separated patches following the
well-know standards (proper subject, a short description, signed-off,
inlined patch against xenomai.git).

> 
> The problem was in rt_intr_delete(): 
> 
> First xnintr_detach() was called followed by xnintr_destroy() which in
> turn called xnintr_detach() once more. I'm assuming xnintr_destroy()
> is the right one to call.
> 
> --- A/kernel/xenomai/skins/native/intr.c	2009-12-08 18:30:05.000000000 -0500
> +++ B/kernel/xenomai/skins/native/intr.c	2010-02-10 17:30:41.000000000 -0500
> @@ -373,8 +373,7 @@
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> -	err = xnintr_detach(&intr->intr_base);
> -	xnintr_destroy(&intr->intr_base);
> +	err = xnintr_destroy(&intr->intr_base);

Yep, that detach used to be redundant for a fairly long time.

But the actual bug is in xnintr_irq_attach/detach for
!CONFIG_XENO_OPT_SHIRQ: Those functions fail to maintain and evaluate
XN_ISR_ATTACHED like their big brothers do. So, if you are already at
it... :)

>  
>  	if (rc == XNSYNCH_RESCHED)
>  		/* Some task has been woken up as a result of the deletion:
> 
> This change makes xnintr_destroy() return the return value of 
> xnintr_detach() as described in the comment. 
> 
> --- A/kernel/xenomai/nucleus/intr.c	2009-12-08 18:30:05.000000000 -0500
> +++ B/kernel/xenomai/nucleus/intr.c	2010-02-10 17:25:47.000000000 -0500
> @@ -638,7 +640,7 @@
>   * @param intr The descriptor address of the interrupt object to
>   * destroy.
>   *
> - * @return 0 is returned on success. Otherwise, -EBUSY is returned if
> + * @return 0 is returned on success. Otherwise, -EINVAL is returned if
>   * an error occurred while detaching the interrupt (see
>   * xnintr_detach()).
>   *
> @@ -654,8 +656,7 @@
>  
>  int xnintr_destroy(xnintr_t *intr)
>  {
> -	xnintr_detach(intr);
> -	return 0;
> +	return xnintr_detach(intr);
>  }
>  
>  /*!
> 
> I also found a minor issue. I think noone ever noticed that because
> the second parameter passed to xeno_flush_rq() is always named rq.
> 
> --- A/include/xenomai/native/ppd.h	2009-12-08 18:30:05.000000000 -0500
> +++ B/include/xenomai/native/ppd.h	2010-02-10 17:36:18.000000000 -0500
> @@ -104,7 +104,7 @@
>  			if (unlikely(err)) {				\
>  				if ((__rq) != &__native_global_rholder.__name##q) { \
>  					xnlock_get_irqsave(&nklock, s);	\
> -					nholder = popq((rq), holder);	\
> +					nholder = popq((__rq), holder);	\
>  					appendq(&__native_global_rholder.__name##q, holder); \
>  					obj->rqueue = &__native_global_rholder.__name##q; \
>  				}
> 
> 
> Andreas

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

