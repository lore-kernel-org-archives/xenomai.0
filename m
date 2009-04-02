Message-ID: <49D4ED4E.40707@domain.hid>
Date: Thu, 02 Apr 2009 18:52:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49D481EF.1010908@domain.hid>
In-Reply-To: <49D481EF.1010908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01499DA12910E7BFD03E90A6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Fix rt_task_shadow error path without __thread.
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01499DA12910E7BFD03E90A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> it seems that rt_task_shadow currently leaves the self tsd assigned (an=
d
> uninitialized) in case of error. So, here is an attempt to fix this
> situation:

Good point.

>=20
> Index: src/skins/native/task.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/native/task.c     (revision 4727)
> +++ src/skins/native/task.c     (working copy)
> @@ -187,15 +187,8 @@
>=20
>  #ifdef HAVE___THREAD
>         self =3D &__native_self;
> -#else /* !HAVE___THREAD */
> -       self =3D pthread_getspecific(__native_tskey);
> +#endif /* HAVE___THREAD */
>=20
> -       if (!self)
> -               self =3D malloc(sizeof(*self));
> -
> -       pthread_setspecific(__native_tskey, self);
> -#endif /* !HAVE___THREAD */
> -
>         if (task =3D=3D NULL)
>                 task =3D &task_desc; /* Discarded. */
>=20
> @@ -217,9 +210,13 @@
>                                 NULL);
>=20
>         if (!err) {
> -               if (self)
> -                       *self =3D *task;
> +#ifndef HAVE___THREAD
> +               self =3D malloc(sizeof(*self));

Hmm, this creates a potential relaxation point (and may raise SIGXCPU if
the warn flag is set). I would prefer to keep early allocation and
release the chunk properly on error (as well as reset the tsd).

>=20
> +               pthread_setspecific(__native_tskey, self);
> +#endif /* !HAVE___THREAD */
> +               *self =3D *task;

And if self is NULL, ie. malloc failed for whatever obscure reasons? The
existing code skipped over this, maybe we should actually handle it and
return an error code.

> +
>                 xeno_set_current();
>=20
>                 if (mode & T_WARNSW)
>=20
>=20

Jan


--------------enig01499DA12910E7BFD03E90A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknU7VIACgkQniDOoMHTA+ndFgCfe2CRMQI7+b9hgfP92DUZ3EmG
Il0An3lLd/KO2MiPlLM5C8Knjajf/JVJ
=rysy
-----END PGP SIGNATURE-----

--------------enig01499DA12910E7BFD03E90A6--

