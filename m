Message-ID: <445F4CC5.20301@domain.hid>
Date: Mon, 08 May 2006 15:51:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
References: <17502.13773.674199.219762@domain.hid>
	<17503.16072.557355.759746@domain.hid>
In-Reply-To: <17503.16072.557355.759746@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > These patches are not ready for inclusion, they are not tested
>  > yet.
> 
> The attached versions are tested. I still wonder if handling this in
> shadow.c is the right solution, or if there should be an xnppd_set call
> that could be called from within the skins event callbacks.
>

That would likely be better, since some skin might not want any cleanup 
code to be called, and in the current implementation, every skin needs 
to provide some ppd info when returning from the event callback, even if 
only the CLIENT_ATTACH event is to be monitored. On the other hand, we 
could argue that registering an event callback requires to implement all 
requests, including CLIENT_DETACH, possibly by returning a no-op value, 
so that no ppd registration would be done from bind_to_interface(). 
Actually, I think the latter would be the better option.

> 
> 
> ------------------------------------------------------------------------
> 
> --- ./include/asm-i386/ipipe.h~	2006-05-07 16:00:37.000000000 +0200
> +++ ./include/asm-i386/ipipe.h	2006-05-07 19:00:34.000000000 +0200
> @@ -135,7 +135,8 @@ do { \
>  #define IPIPE_EVENT_SIGWAKE	(IPIPE_FIRST_EVENT + 2)
>  #define IPIPE_EVENT_SETSCHED	(IPIPE_FIRST_EVENT + 3)
>  #define IPIPE_EVENT_EXIT	(IPIPE_FIRST_EVENT + 4)
> -#define IPIPE_LAST_EVENT	IPIPE_EVENT_EXIT
> +#define IPIPE_EVENT_PEXIT	(IPIPE_FIRST_EVENT + 5)
> +#define IPIPE_LAST_EVENT	IPIPE_EVENT_PEXIT
>  #define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
>  

I've merged such support for process cleanup event notification in the 
Adeos codebase, it will be available with the next patches to come. I've 
named it IPIPE_EVENT_CLEANUP instead of PEXIT though, since that's what 
it is about, and EXIT/PEXIT might be confusing.

+}
> +
> +static inline struct xnppd_holder *
> +xnppd_lookup(unsigned skin_magic, struct mm_struct *mm, unsigned remove)
> +{

Let's separate the lookup and removal ops here, making the latter return 
the removed element. All-in-one stuff may save a few lines but is a pain 
for readability.

>  
> +static inline void do_pexit_event (struct mm_struct *mm)
> +{
> +    unsigned muxid;
> +    spl_t s;
> +    
> +    for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++)
> +        {
> +        xnlock_get_irqsave(&nklock, s);
> +        if (muxtable[muxid].systab && muxtable[muxid].eventcb)
> +            {
> +            struct xnppd_holder *ppd;
> +
> +            ppd = xnppd_lookup(muxtable[muxid].magic, mm, 1);
> +
> +            if (ppd)
> +                muxtable[muxid].eventcb(XNSHADOW_CLIENT_DETACH, ppd);
> +            }
> +        xnlock_put_irqrestore(&nklock, s);
> +        }
> +}
> +

Maybe a better approach would be to simply hash holders referring to 
busy muxtable entries on mm struct pointers? This way, we would only 
have to scan a list handling one element per attached skin per 
terminating process, which will be most of the time a matter of walking 
through a 1/2 element queue.

i.e. indexing table entries on mm pointers from bind_to_interface() to 
ask for the CLIENT_DETACH event to be fired upon process cleanup:

(key: curr->mm) ->
	(holder: &muxtable[muxid1]) ->
	(holder: &muxtable[muxid2]) ->
	(holder: &muxtable[muxid3])

then, scanning the list hashed on the terminating process's mm struct, 
in order to fire the appropriate event callbacks.

Btw, on 2.4 at least, the global Linux mm_lock is held before firing the 
process cleanup notification at Adeos level, so one has to be careful 
about what's actually done in those per-skin cleanup handlers.

-- 

Philippe.

