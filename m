Message-ID: <45A4F18A.4040209@domain.hid>
Date: Wed, 10 Jan 2007 15:00:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>	
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
In-Reply-To: <b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2B31D3A47A5E8386925FB90"
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
--------------enigA2B31D3A47A5E8386925FB90
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi,
>=20
> I suppose, one more thing was missed. intr_reg.patch is to address it.
>=20
> intr_swap.patch - to be safe with xnintr_t::name in all cases. In
> particular, the reported crash should disappear without other
> additional patches.
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- ./ksrc/skins/native/intr.c	2006-06-15 14:15:44.000000000 +0200
> +++ ./ksrc/skins/native/intr-new.c	2007-01-10 14:45:26.320565000 +0100
> @@ -223,6 +223,7 @@ static xnpnode_t __intr_pnode =3D {
>   *
>   * - Kernel module initialization/cleanup code
>   * - Kernel-based task
> + * - User-space task
>   *
>   * Rescheduling: possible.
>   *
> @@ -262,11 +263,21 @@ int rt_intr_create(RT_INTR *intr,
>  	/* <!> Since xnregister_enter() may reschedule, only register
>  	   complete objects, so that the registry cannot return handles to
>  	   half-baked objects... */
> +	if (!err && name) {
> +		xnpnode_t *pnode =3D &__intr_pnode;
> =20
> -	if (!err)
> -		err =3D
> -		    xnregistry_enter(intr->name, intr, &intr->handle,
> -				     &__intr_pnode);
> +		if (!*name) {
> +			/* Since this is an anonymous object (empty name on entry)

Isn't a NULL name representing an anonymous object as well?

> +			 * from user-space, it gets registered under an unique
> +			 * internal name but is not exported through /proc. */
> +			xnobject_create_name(intr->name, sizeof(intr->name),
> +				(void *)intr);
> +			pnode =3D NULL;
> +		}
> +
> +		err =3D xnregistry_enter(intr->name, intr, &intr->handle, pnode);
> +	}=09
> +=09
>  #endif /* CONFIG_XENO_OPT_REGISTRY */
> =20
>  	if (err)
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- ./ksrc/skins/native/intr-new.c	2007-01-10 14:45:26.320565000 +0100
> +++ ./ksrc/skins/native/intr-new2.c	2007-01-10 14:46:08.319442000 +0100=

> @@ -242,8 +242,8 @@ int rt_intr_create(RT_INTR *intr,
>  	if (xnpod_asynch_p())
>  		return -EPERM;
> =20
> -	xnintr_init(&intr->intr_base, name, irq, isr, iack, mode);
>  	xnobject_copy_name(intr->name, name);
> +	xnintr_init(&intr->intr_base, intr->name, irq, isr, iack, mode);

This will set xnintr_t::name to "" if name is NULL - intentionally?

Jan


--------------enigA2B31D3A47A5E8386925FB90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpPGKniDOoMHTA+kRAkwAAJ9LKEjGPsKabeYUNZcmUfY/90d9RQCfeulW
ROJb02T2kn+hKWkF19gQYYs=
=5/0Y
-----END PGP SIGNATURE-----

--------------enigA2B31D3A47A5E8386925FB90--

