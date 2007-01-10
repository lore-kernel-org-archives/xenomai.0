Message-ID: <b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
Date: Wed, 10 Jan 2007 15:21:03 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
In-Reply-To: <45A4F18A.4040209@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

> > +     if (!err && name) {
> > +             xnpnode_t *pnode = &__intr_pnode;
> >
> > -     if (!err)
> > -             err =
> > -                 xnregistry_enter(intr->name, intr, &intr->handle,
> > -                                  &__intr_pnode);
> > +             if (!*name) {
> > +                     /* Since this is an anonymous object (empty name on entry)
>
> Isn't a NULL name representing an anonymous object as well?

Anonymous objects are supported only for user-space clients.
We agreed on it with Philippe when similar code was introduced for
other objects. In this case, name is not NULL but "\0" on entry of
native::rt_object_create (object = mutex,event,etc.).

Now, don't ask me why the same is not applicable for the kernel-side
objects as I'll have to think about it (can't recall right now) and
may overheat. Likely, just some political issues. Yes, we want to make
life of kernel-side developers a bit more difficult. Namely, want an
object to be exported via registry? Give a valid name upon its
creation.

> > -     xnintr_init(&intr->intr_base, name, irq, isr, iack, mode);
> >       xnobject_copy_name(intr->name, name);
> > +     xnintr_init(&intr->intr_base, intr->name, irq, isr, iack, mode);
>
> This will set xnintr_t::name to "" if name is NULL - intentionally?

xnintr_t::name becomes a reference to RT_INTR::name. The later one
exists as long as the former anyway so there shoudn't be a broken
reference.

Just in case xnintr::name is used somewhere else, aside of xnintr_irq_proc().

>
> Jan
>


-- 
Best regards,
Dmitry Adamushko

