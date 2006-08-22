Message-ID: <44EAB53C.1020705@domain.hid>
Date: Tue, 22 Aug 2006 09:41:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0608212353u13a450f4w16069329cea3966a@domain.hid>
In-Reply-To: <b647ffbd0608212353u13a450f4w16069329cea3966a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFFBF80AF7EE5653977804AAC"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch, minor] irq proc output in intr.c
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
--------------enigFFBF80AF7EE5653977804AAC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 19/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> just realised that the output of /proc/xenomai/irq is suboptimal (no
>> names) under !CONFIG_XENO_OPT_SHIRQ_LEVEL &&
>> !CONFIG_XENO_OPT_SHIRQ_EDGE...
>=20
>=20
>=20
> It should be ok but just in case, Jan, pls give it a try first. I was n=
ot
> able to test a branch with rthal_irq_cookie() (but as I recall it worke=
d
> when it was implemented) as I don't have any driver at hand to be loade=
d.

Thanks for the patch. I'm posting some comments below.

>=20
> TIA,
>=20
>=20
> Thanks,
>> Jan
>>
>>
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> diff -urp xenomai-SVN/include/nucleus/intr.h xenomai-a/include/nucleus/=
intr.h
> --- xenomai-SVN/include/nucleus/intr.h	2006-07-20 11:09:01.000000000 +0=
200
> +++ xenomai-a/include/nucleus/intr.h	2006-08-22 09:32:24.000000000 +020=
0
> @@ -71,7 +71,9 @@ int xnintr_mount(void);
> =20
>  void xnintr_clock_handler(void);
> =20
> +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
>  int xnintr_irq_proc(unsigned int irq, char *str);
> +#endif /* CONFIG_PROC_FS && __KERNEL__ */
> =20
>      /* Public interface. */
> =20
> diff -urp xenomai-SVN/ksrc/nucleus/intr.c xenomai-a/ksrc/nucleus/intr.c=

> --- xenomai-SVN/ksrc/nucleus/intr.c	2006-07-20 12:35:40.000000000 +0200=

> +++ xenomai-a/ksrc/nucleus/intr.c	2006-08-22 09:34:28.000000000 +0200
> @@ -691,6 +691,7 @@ int xnintr_mount(void)
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
>  int xnintr_irq_proc(unsigned int irq, char *str)
>  {
>  	xnintr_shirq_t *shirq;
> @@ -727,6 +728,7 @@ int xnintr_irq_proc(unsigned int irq, ch
> =20
>  	return p - str;
>  }
> +#endif /* CONFIG_PROC_FS && __KERNEL__ */
> =20
>  #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE *=
/
> =20
> @@ -735,10 +737,31 @@ int xnintr_mount(void)
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
>  int xnintr_irq_proc(unsigned int irq, char *str)
>  {
> -	return 0;
> +	xnintr_t *intr;
> +	char *p =3D str;

+	spl_t s;

> +
> +	if (rthal_virtual_irq_p(irq)) {
> +		p +=3D sprintf(p, "         [virtual]");
> +		return p - str;
> +	} else if (irq =3D=3D XNARCH_TIMER_IRQ) {
> +		p +=3D sprintf(p, "         %s", nkclock.name);
> +		return p - str;
> +	}
> +
> +	xnlock_get_irqsave(&nklock, s);

What's the idea of this lock? I'm asking as xnintr_attach/detach should
not run under nklock, right? So, how can it protect us then?

> +
> +	intr =3D rthal_irq_cookie(&rthal_domain, irq);
> +	if (intr && *(intr->name))
> +		p +=3D sprintf(p, "        %s", intr->name);
> +
> +	xnlock_put_irqrestore(&nklock, s);
> +
> +	return p - str;
>  }
> +#endif /* CONFIG_PROC_FS && __KERNEL__ */
> =20
>  #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */=

> =20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- ChangeLog-SVN	2006-08-22 02:14:43.000000000 +0200
> +++ ChangeLog	2006-08-22 02:19:21.000000000 +0200
> @@ -10,6 +10,9 @@
> =20
>  	* ksrc/nucleus/pipe.c (xnpipe_recv): Re-evaluate the timeout value
>  	as we iterate over the message acquisition.
> +=09
> +	* ksrc/nucleus/intr.c (xnintr_irq_proc): Print the names of registere=
d
> +	handlers also in case of non-shared interrupts.
> =20
>  2006-08-20  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
> =20

Jan


--------------enigFFBF80AF7EE5653977804AAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6rU8niDOoMHTA+kRApGNAJ4yrlenLRWlwRca3eIwGNRNSeKW8QCeKzti
riE1KQFzTo+Wdjq7EAe8BZE=
=5VM+
-----END PGP SIGNATURE-----

--------------enigFFBF80AF7EE5653977804AAC--

