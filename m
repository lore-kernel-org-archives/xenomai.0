Message-ID: <b647ffbd0601100744ybfd84a1s@domain.hid>
Date: Tue, 10 Jan 2006 07:44:59 -0800
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43C2D90B.30504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0601091221h5596da2fg@domain.hid>
	<43C2D90B.30504@domain.hid>
Subject: [Xenomai-core] Re: nucleus:shared irq, draft v.2
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
Cc: xenomai@xenomai.org

On 09/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> My mail client unfortunately refused to inline your patches, so I have to=
:
>
> > --- intr-cvs.c=092005-12-02 19:56:20.000000000 +0100
> > +++ intr.c=092006-01-09 21:26:44.000000000 +0100
> [...]
> > @@ -204,11 +242,66 @@
> >  int xnintr_attach (xnintr_t *intr,
> >  =09=09   void *cookie)
> >  {
> > +    rthal_irq_handler_t irq_handler;
> > +    unsigned irq =3D intr->irq;
> > +    xnshared_irq_t *shirq;
> > +    int err =3D 0;
> > +    spl_t s;
> > +
> >      intr->hits =3D 0;
> >      intr->cookie =3D cookie;
> > -    return
> xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
> > +
> > +    xnlock_get_irqsave(&nklock,s);
> > +
> > +    irq_handler =3D rthal_irq_handler(&rthal_domain,irq);
> > +
> > +    if (irq_handler)
> > +=09{
> > +=09xnintr_t *old;
> > +=09shirq =3D rthal_irq_cookie(&rthal_domain,irq);
> > +=09
> > +=09if (irq_handler !=3D &xnintr_irq_handler)
> > +=09    {
> > +=09    err =3D -EBUSY;
> > +=09    goto unlock_and_exit;
> > +=09    }
> > +=09
> > +=09old =3D link2intr(getheadq(&shirq->handlers));
> > +
> > +=09if (!(old->flags & intr->flags & XN_ISR_SHARED))
> > +=09    {
> > +=09    err =3D -EBUSY;
> > +=09    goto unlock_and_exit;
> > +=09    }
> > +=09
> > +=09appendq(&shirq->handlers,&intr->link);
> > +=09}
> > +    else
> > +=09{
> > +=09shirq =3D xnmalloc(sizeof(*shirq));
>
> Why not allocating that piece of memory before taking the global lock?
> If you don't need it, you can drop it again afterward. If you need but
> the returned pointer is NULL, you can still check at the same place you
> do now. Just an idea to avoid complex functions inside the global lock
> for new xeno-code.

Ack. I thought about that actually.

>
> > +=09
> > +=09if (!shirq)
> > +=09    {
> > +=09    err =3D -ENOMEM;
> > +=09    goto unlock_and_exit;
> > +=09    }
> > +
> > +=09initq(&shirq->handlers);
> > +=09appendq(&shirq->handlers,&intr->link);
> > +
> > +=09err =3D xnarch_hook_irq(irq,&xnintr_irq_handler,intr->iack,shirq);
> > +=09
> > +=09if (err)
> > +=09    xnfree(shirq);
> > +=09}
> > +
> > +unlock_and_exit:
> > +
> > +    xnlock_put_irqrestore(&nklock,s);
> > +    return err;
> >  }
> >
> > +
> >  /*!
> >   * \fn int xnintr_detach (xnintr_t *intr)
> >   * \brief Detach an interrupt object.
> > @@ -241,7 +334,32 @@
> >  int xnintr_detach (xnintr_t *intr)
> >
> >  {
> > -    return xnarch_release_irq(intr->irq);
> > +    unsigned irq =3D intr->irq;
> > +    xnshared_irq_t *shirq;
> > +    int cleanup =3D 0;
> > +    int err =3D 0;
> > +    spl_t s;
> > +
> > +    xnlock_get_irqsave(&nklock,s);
> > +
> > +    shirq =3D rthal_irq_cookie(&rthal_domain,irq);
> > +
> > +    removeq(&shirq->handlers,&intr->link);
> > +
> > +    if (!countq(&shirq->handlers))
> > +=09{
> > +=09err =3D xnarch_release_irq(irq);
> > +=09cleanup =3D 1;
> > +=09}
> > +
> > +    xnlock_put_irqrestore(&nklock,s);
> > +
> > +    xnintr_shirq_spin(shirq);
> > +
> > +    if (cleanup)
> > +=09xnfree(shirq);
> > +
> > +    return err;
> >  }
> >
> >  /*!
> > @@ -350,17 +468,45 @@
>
> I guess here starts the new IRQ handler. BTW, diff -p helps a lot when
> reading patches as a human being and not as a patch tool. ;)
>
> >
> >  {
> >      xnsched_t *sched =3D xnpod_current_sched();
> > -    xnintr_t *intr =3D (xnintr_t *)cookie;
> > -    int s;
> > +    xnshared_irq_t *shirq =3D (xnshared_irq_t *)cookie;
> > +    xnholder_t holder;
> > +    spl_t flags;
> > +    int s =3D 0;
> >
> >      xnarch_memory_barrier();
> >
> >      xnltt_log_event(xeno_ev_ienter,irq);
> >
> > +    xnlock_get_irqsave(&nklock,flags);
> > +
> > +    shirq =3D rthal_irq_cookie(&rthal_domain,irq);
> > +    xnintr_shirq_lock(shirq);
> > +
> > +    xnlock_put_irqrestore(&nklock,flags);
>
> Why "_irqsave" in IRQ context?
>
> Regarding this locking isssue in general, I first had some RCU-mechanism
> in mind to avoid the reader-side lock in the IRQ handler. But as IRQs
> typically touch some nucleus service with its own nklock-acquire anyway,
> optimising this here does not seem to be worth the effort now. As long
> as we have the global lock, it's ok and much simpler I think.

As Gilles has pointed out, nklock is dangerous here so let's forget
about it so far.
Actually, the way the shirq->handlers list is used remains some kind
of RCU, I guess.

Look, xnintr_irq_handler() doesn't hold the lock while iterating
through the list.

That's why xnintr_shirq_spin() is there, I tried to explain the idea
in my previous answer to the Gilles's letter.

Actually, I still have some doubts regarding this way, in particular,
whether everything is ok with atomicity.

I don't have my computer at hand and it seems I am occuping the comp
of my friend at the moment :) I'll post other details later if need
be.

>
> > +
> > +    if (!shirq)
> > +=09{
> > +=09xnintr_shirq_unlock(shirq);
> > +=09xnltt_log_event(xeno_ev_iexit,irq);
> > +    =09return;
> > +=09}
> > +
> >      ++sched->inesting;
> > -    s =3D intr->isr(intr);
> > +
> > +    holder =3D getheadq(&shirq->handlers);
> > +
> > +    while (holder)
> > +=09{
> > +=09xnintr_t *intr =3D link2intr(holder);
> > +=09holder =3D nextq(&shirq->handlers,holder);
> > +
> > +=09s |=3D intr->isr(intr);
> > +=09++intr->hits;
> > +=09}
> > +
> > +    xnintr_shirq_unlock(shirq);
> > +
> >      --sched->inesting;
> > -    ++intr->hits;
> >
> >      if (s & XN_ISR_ENABLE)
> >  =09xnarch_enable_irq(irq);
>
> Looking forward to see this in Xenomai - at letting some real tests run
> with it. :)

So am I. Heh.. :)

>
> Jan
>
>


--
Best regards,
Dmitry Adamushko

