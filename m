Message-ID: <44CC5D59.3080405@domain.hid>
Date: Sun, 30 Jul 2006 09:18:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
References: <44CB2884.80801@domain.hid>	<17611.36969.814874.846387@domain.hid>
	<17611.37633.881446.443324@domain.hid>
In-Reply-To: <17611.37633.881446.443324@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5763EB7FAA22C2FD6D678729"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5763EB7FAA22C2FD6D678729
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > How about solving this in Kconfig ?
>  > Index: scripts/Kconfig.frag
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > --- scripts/Kconfig.frag	(revision 1388)
>  > +++ scripts/Kconfig.frag	(working copy)
>  > @@ -2,6 +2,7 @@
>  >  menu "Real-time sub-system"
>  > =20
>  >  config XENOMAI
>  > +	depends on CONFIG_X86_TSC || !X86 || !CONFIG_INPUT_PCSPKR
>  >  	bool "Xenomai"
>  >  	default y
>  >          select IPIPE
>=20
> Sorry, I meant:
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: scripts/Kconfig.frag
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- scripts/Kconfig.frag	(revision 1388)
> +++ scripts/Kconfig.frag	(working copy)
> @@ -2,6 +2,7 @@
>  menu "Real-time sub-system"
> =20
>  config XENOMAI
> +	depends on X86_TSC || !X86 || !INPUT_PCSPKR
>  	bool "Xenomai"
>  	default y
>          select IPIPE

No problem, but only when combining with a

comment "Switch off CONFIG_INPUT_PCSPKR to use Xenomai" (or so)
	depends on !X86_TSC && X86 && INPUT_PCSPKR

Otherwise the user will be left alone here with a non-selectable Xenomai
option...

This actually remind me of my suggestion some months ago to add Kconfig
warnings for CONFIG_CPU_FREQ & friends. Might be a good chance to catch
this all. Is scripts/Kconfig.frag the preferred place to add it?

Jan


--------------enig5763EB7FAA22C2FD6D678729
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzF1ZniDOoMHTA+kRAoHAAJ46h6hywH7U1IQKnkuPY0P7JIWdbQCbB9Ys
DRNfBk5bRBh44ZEHNR0thfo=
=YgKy
-----END PGP SIGNATURE-----

--------------enig5763EB7FAA22C2FD6D678729--

