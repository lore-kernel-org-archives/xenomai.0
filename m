Message-ID: <43F47705.90309@domain.hid>
Date: Thu, 16 Feb 2006 13:58:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	<43F3C4EA.7050303@domain.hid>
	<b647ffbd0602160220we254aacx@domain.hid>
In-Reply-To: <b647ffbd0602160220we254aacx@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E7710371EC3785ECC8DD93B"
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
--------------enig8E7710371EC3785ECC8DD93B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
> Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
>> before merging (i.e. make XN_ISR_HANDLED non-zero)?
>=20
>=20
> Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now
> non-zero.
> Actually, at first I wanted to make it just the other way about.
>=20

Hmm, thinking about this again, I would like to revert my suggestion in
favour of a third approach (trying to keep you busy ;) ).

Recommended default values:
<new>XN_ISR_HANDLED =3D> <old non-zero>XN_ISR_HANDLED | <old>XN_ISR_ENABL=
E

<new>XN_ISR_NOINT =3D> <new>XN_ISR_NO_ENABLE


Additional bits:
<new>XN_ISR_NO_ENABLE
 =3D> indicate that <old>XN_ISR_ENABLE is not set
    (use case: handle but delay re-enable)

<new>XN_ISR_PROPAGATE
 =3D> <old>XN_ISR_CHAINED (the new name is closer to the related function=

                         calls - at least for me).


Not expressible combination:
<old>XN_ISR_ENABLE | <new>XN_ISR_NOINT
 =3D> Doesn't make sense, does it?


Still expressible invalid combination:
<new>XN_ISR_HANDLED | <new>XN_ISR_PROPAGATE
 =3D> The implicit enable request should be easy to ignore at nucleus
    level.


Rational:

Most users will either indicate that an IRQ was handled and should be
re-enabled as soon as possible or that it was unhandled and should
better remain masked if no one else cares.

XN_ISR_PROPAGATE (or related skin defines) are only useful for very very
special corner-case drivers and applications. Normal generic drivers
should not touch this (including my own xeno_16550A... bah!). BTW, if
there is some unintentional IRQ sharing so that spurious RT interrupts
occur, I think we should detect this at nucleus level and bail out.
Otherwise, systems quickly lock up (I just faced this once again two
days ago on an old RTAI box).


This will break some stuff (RTDM e.g., but we have some version flags
for such cases), but it takes us closer to the standard Linux API
without loosing control over the details when required.

Comments?

>=20
> Moreover, I attached an add-on patch to overcome the name buffer in
>> xnintr_t. Note that this patch is only compile-tested, I have no nativ=
e
>> interrupt test-case at hand.
>=20
>=20
>=20
> Heh.. someone once suggested the -p key with "diff" to me? :o)

Mmpf. Must have been too late, and I was too impressed how interdiff
worked out this patch. :)

>=20
> I bet your patch would even work but it's, well, slightly broken indeed=
 ;-)
>=20
> Look at the native/syscall.c : __rt_intr_delete() :
>=20
> RT_INTR *intr =3D (RT_INTR *)rt_registry_fetch(ph.opaque);
> ...
> xnfree(intr);
>=20
> "intr" actually points to intr_buf->intr and it works as expected only
> because "RT_INTR intr" is the first member of the struct, so that it's
> address =3D=3D the address of the whole object of this struct.

But this is not an unusual trick, and I see no practical problems.

>=20
> To do it properly you would need to make your "unnamed" struct visible
> for both __rt_intr_create() and __rt_intr_delete(). Something like :
>=20
> struct RT_INTR_ENV {
>=20
> #define link2intr_env(laddr) \
> ((RT_INTR_ENV *)(((char* )laddr) - (int)(&((RT_INTR_ENV *)0)->intr)))
>=20
>     RT_INTR intr;
>     char name[XNOBJECT_NAME_LEN];
> };
>=20
> and then make use of link2intr_env() in __rt_intr_delet().
>=20
>=20
> Ok, with you approach we would avoid allocating memory
> for name[XNOBJECT_NAME_LEN] when an object is created in kernel-mode
> and do it via RT_INTR_ENV only when it's created in user-mode.
>=20
> We could even use that approach for all objects in native skin, but we =
can't
> because of "anonymous" objects supported in kernel-mode too and, well, =
I
> personally would not like those RT_OBJECT_ENV structures all over the m=
ap in
> syscall.c :)

Me too.

>=20
> So I don't want to break the whole picture only for the RT_INTR object =
(it
> doesn't support "anonymous" objects now).
>=20
> Nevertheless, if you still want to save a hundred bytes of data or so (=
how
> many interrupt objects would a normal system have? and I guess the leng=
ht of
> name is about 10 symbols on average :)

RT_INTR is now disabled by default in the kernel config. Thus most users
should not see its code in their kernels, only the additional data and
code related to xnintr_t.name.

>=20
> for the users that don't use native skin, then I would suggest the foll=
owing
> way :
>=20
> xnintr_t contains just the link "char *name" as you suggested but RT_IN=
TR
> contains the name[XNOBJECT_NAME_LEN] member (as it was before actually)=
=2E
>=20
> If it's ok,  then I'll send um... yet another final patch that addresse=
s
> both issues :)

I'm fine with this as well if you prefer it, no problem.

Jan


--------------enig8E7710371EC3785ECC8DD93B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD9HcFniDOoMHTA+kRAifrAJ4o320YR254KhBnMHNSixIRhj2OQwCbB6SB
Z+pB1t5uyFMPm7/sm5HndYs=
=axcq
-----END PGP SIGNATURE-----

--------------enig8E7710371EC3785ECC8DD93B--

