Message-ID: <45A4F9CC.6070807@domain.hid>
Date: Wed, 10 Jan 2007 15:35:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>	
	<45A4DDA8.6090800@domain.hid>	
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>	
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
In-Reply-To: <b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7AB96D2BD1F0531481E0BF5C"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7AB96D2BD1F0531481E0BF5C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> > +     if (!err && name) {
>> > +             xnpnode_t *pnode =3D &__intr_pnode;
>> >
>> > -     if (!err)
>> > -             err =3D
>> > -                 xnregistry_enter(intr->name, intr, &intr->handle,
>> > -                                  &__intr_pnode);
>> > +             if (!*name) {
>> > +                     /* Since this is an anonymous object (empty
>> name on entry)
>>
>> Isn't a NULL name representing an anonymous object as well?
>=20
> Anonymous objects are supported only for user-space clients.
> We agreed on it with Philippe when similar code was introduced for
> other objects. In this case, name is not NULL but "\0" on entry of
> native::rt_object_create (object =3D mutex,event,etc.).

OK, I see.

>=20
> Now, don't ask me why the same is not applicable for the kernel-side
> objects as I'll have to think about it (can't recall right now) and
> may overheat. Likely, just some political issues. Yes, we want to make
> life of kernel-side developers a bit more difficult. Namely, want an
> object to be exported via registry? Give a valid name upon its
> creation.
>=20
>> > -     xnintr_init(&intr->intr_base, name, irq, isr, iack, mode);
>> >       xnobject_copy_name(intr->name, name);
>> > +     xnintr_init(&intr->intr_base, intr->name, irq, isr, iack, mode=
);
>>
>> This will set xnintr_t::name to "" if name is NULL - intentionally?
>=20
> xnintr_t::name becomes a reference to RT_INTR::name. The later one
> exists as long as the former anyway so there shoudn't be a broken
> reference.

Yes, this specifically addresses Mathias' concern about passed names
that are temporary variables.

It just leaves xnintr_t::name with an emptry string instead of "unknown"
in some cases. Either xnintr_init needs to take care of this, or we
should catch that case already here. I think empty strings in
/proc/xenomai/irq are bad in case of shared IRQ lists.

Jan


--------------enig7AB96D2BD1F0531481E0BF5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpPnMniDOoMHTA+kRAkXrAJ9mOhTvUMlvid/20tV7bgSHRQus0QCcDU7S
QK3yoUAS8cZYAbVLZi+CcNY=
=OsDK
-----END PGP SIGNATURE-----

--------------enig7AB96D2BD1F0531481E0BF5C--

