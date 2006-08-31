From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608310208m514f5128l7276dd30c18b883@domain.hid>
References: <b647ffbd0608221412s3167e49fx843da826f870b03c@domain.hid>
	<1156286237.4319.124.camel@domain.hid>
	<b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
	<1156976481.28417.43.camel@domain.hid>
	<b647ffbd0608310208m514f5128l7276dd30c18b883@domain.hid>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:27:55 +0200
Message-Id: <1157016475.4359.23.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [patch,
	minor] irq proc output + ipipe_unregister_domain() vs.
	ipipe_sync_stage()
Reply-To: rpm@xenomai.org
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

On Thu, 2006-08-31 at 11:08 +0200, Dmitry Adamushko wrote:
> 
> 
>         A way to solve this would be to have a transaction identifier
>         into each
>         object descriptor, that is incremented each time the object's
>         internal 
>         state is altered (e.g. removal/insertion of some element
>         from/to the
>         pendq and so on). 
> 
> This works as long as the object descriptor itself can _not_ be
> deleted in the mean time.
> 
> IOW, "object->current_rev != prev_rev" makes sense only if "object"
> remains to be valid.
> 

This is the purpose of revalidating the object, step 6a.
You alo have to copy the source data to be printed out under nklock
protection, then sprintf those fields outside of such protection.

> So it's not applicable to any native skin's primitives unless you have
> an additional mean to  determine that the object was deleted / or
> guarantee that it can't be deleted (e.g. reference counting).

If the object provides /proc support, then it must be registered. In
which case, its handle is hashed by the registry, so you could always
determine whether it is still alive or not (provided the registry is not
too fast on recycling handles, and fortunately, we are already making
sure it's not).

> 
> In case of Jan's optimization it works as long as "nkpod" object is
> valid :
> 
> see comments below...
> 
> ...
>         /* Take a snapshot element-wise, restart if something changes
>            underneath us. */
> 
>         while (holder) {
>                 xnthread_t *thread;
>                 xnsched_t *sched;
>                 xnticks_t period;
>                 int n;
> 
>                 xnlock_get_irqsave(&nklock, s);          (1)
> 
>                 if (nkpod->threadq_rev != rev)            (2)
>                         goto restart;
> 
>                 rev = nkpod->threadq_rev;                 (3)
> ...
> 
> btw, (3) doesn't make any sense. You can be there only when
> "nkpod->thread_rev == rev".
> 
> In fact, nkpod also can be NULL in (2) if xnpod_shutdown() was called
> (skin was unloaded) before (1). Although, it has quite low
> probability.
> 

xnpod_shutdown() must be used over the regular Linux context, this is a
strong requirement. So we could use this to enforce synchronization
with /proc routines.

This whole discussion makes me think that if we want to go down the path
of providing a generally safe and latency-aware support for the /proc
routines, we should definitely define some common mechanisms to
implement them, typically in the registry code.

> 
> 
> 
>         --
>         Philippe.
>         
> 
> -- 
> Best regards,
> Dmitry Adamushko
-- 
Philippe.



