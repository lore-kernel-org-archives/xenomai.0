Message-ID: <27256731.1168438778663.JavaMail.ngmail@domain.hid>
Date: Wed, 10 Jan 2007 15:19:38 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name
	leads
In-Reply-To: <45A4F18A.4040209@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <45A4F18A.4040209@domain.hid>
	<15523442.1168430357436.JavaMail.ngmail@domain.hid>	
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, dmitry.adamushko@domain.hid
Cc: xenomai@xenomai.org

Hi,

one more comment on this issue:
Regarding to the API documentation it is not required to use a static alloc=
ated
string for the name parameter
(API docu: "When non-NULL and non-empty, this string is copied to a safe pl=
ace into the descriptor").

However, when I use a name variable that is created on the stack (using spr=
intf), I see
that the /proc/xenomai/registry/native/interrupts/xxx  name is fine, howeve=
r the name in=20
/proc/xenomai/irq is not valid.
I.e. I have to use a static name variable to pass to rt_inter_create() as t=
he name pointer
seems to be used without a copy action in /proc/xenomai/irq.


Regards

Mathias
> > Hi,
> >=20
> > I suppose, one more thing was missed. intr_reg.patch is to address it.
> >=20
> > intr_swap.patch - to be safe with xnintr_t::name in all cases. In
> > particular, the reported crash should disappear without other
> > additional patches.
> >=20
> >=20
> >=20
> > -----------------------------------------------------------------------=
-
> >=20
> > --- ./ksrc/skins/native/intr.c=092006-06-15 14:15:44.000000000 +0200
> > +++ ./ksrc/skins/native/intr-new.c=092007-01-10 14:45:26.320565000 +010=
0
> > @@ -223,6 +223,7 @@ static xnpnode_t __intr_pnode =3D {
> >   *
> >   * - Kernel module initialization/cleanup code
> >   * - Kernel-based task
> > + * - User-space task
> >   *
> >   * Rescheduling: possible.
> >   *
> > @@ -262,11 +263,21 @@ int rt_intr_create(RT_INTR *intr,
> >  =09/* <!> Since xnregister_enter() may reschedule, only register
> >  =09   complete objects, so that the registry cannot return handles to
> >  =09   half-baked objects... */
> > +=09if (!err && name) {
> > +=09=09xnpnode_t *pnode =3D &__intr_pnode;
> > =20
> > -=09if (!err)
> > -=09=09err =3D
> > -=09=09    xnregistry_enter(intr->name, intr, &intr->handle,
> > -=09=09=09=09     &__intr_pnode);
> > +=09=09if (!*name) {
> > +=09=09=09/* Since this is an anonymous object (empty name on entry)
>=20
> Isn't a NULL name representing an anonymous object as well?
>=20
> > +=09=09=09 * from user-space, it gets registered under an unique
> > +=09=09=09 * internal name but is not exported through /proc. */
> > +=09=09=09xnobject_create_name(intr->name, sizeof(intr->name),
> > +=09=09=09=09(void *)intr);
> > +=09=09=09pnode =3D NULL;
> > +=09=09}
> > +
> > +=09=09err =3D xnregistry_enter(intr->name, intr, &intr->handle, pnode)=
;
> > +=09}=09
> > +=09
> >  #endif /* CONFIG_XENO_OPT_REGISTRY */
> > =20
> >  =09if (err)
> >=20
> >=20
> > -----------------------------------------------------------------------=
-
> >=20
> > --- ./ksrc/skins/native/intr-new.c=092007-01-10 14:45:26.320565000 +010=
0
> > +++ ./ksrc/skins/native/intr-new2.c=092007-01-10 14:46:08.319442000 +01=
00
> > @@ -242,8 +242,8 @@ int rt_intr_create(RT_INTR *intr,
> >  =09if (xnpod_asynch_p())
> >  =09=09return -EPERM;
> > =20
> > -=09xnintr_init(&intr->intr_base, name, irq, isr, iack, mode);
> >  =09xnobject_copy_name(intr->name, name);
> > +=09xnintr_init(&intr->intr_base, intr->name, irq, isr, iack, mode);
>=20
> This will set xnintr_t::name to "" if name is NULL - intentionally?
>=20
> Jan
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

