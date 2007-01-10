Message-ID: <b647ffbd0701100629w6ee989a6k39c8be0e8433919@domain.hid>
Date: Wed, 10 Jan 2007 15:29:24 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
In-Reply-To: <b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
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

On 10/01/07, Dmitry Adamushko <dmitry.adamushko@domain.hid> wrote:
> > > +     if (!err && name) {
> > > +             xnpnode_t *pnode = &__intr_pnode;
> > >
> > > -     if (!err)
> > > -             err =
> > > -                 xnregistry_enter(intr->name, intr, &intr->handle,
> > > -                                  &__intr_pnode);
> > > +             if (!*name) {
> > > +                     /* Since this is an anonymous object (empty name on entry)
> >
> > Isn't a NULL name representing an anonymous object as well?
>
> Anonymous objects are supported only for user-space clients.
> We agreed on it with Philippe when similar code was introduced for
> other objects. In this case, name is not NULL but "\0" on entry of
> native::rt_object_create (object = mutex,event,etc.).
>
> Now, don't ask me why the same is not applicable for the kernel-side
> objects as I'll have to think about it (can't recall right now) and
> may overheat. Likely, just some political issues. Yes, we want to make
> life of kernel-side developers a bit more difficult. Namely, want an
> object to be exported via registry? Give a valid name upon its
> creation.
>

Although, intr objects would be an exception. As their names are
visible not only through the register but also through
/proc/xenomai/irq. On the other hand, showing something like 81234560
(an address of the object - if we use xnobject_create_name) instead
wouldn't be of any great avail?
Ah, at least one would see how many "anonymous" kernel-side handlers
are attached to the line.


-- 
Best regards,
Dmitry Adamushko

