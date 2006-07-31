Message-ID: <44CE350F.5060303@domain.hid>
Date: Mon, 31 Jul 2006 18:51:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
References: <44CB2884.80801@domain.hid>	<17611.36969.814874.846387@domain.hid>	<17611.37633.881446.443324@domain.hid>	<44CC5D59.3080405@domain.hid>
	<17614.12685.956714.372133@domain.hid>
In-Reply-To: <17614.12685.956714.372133@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67CB78D5C169D746FF352393"
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
--------------enig67CB78D5C169D746FF352393
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > No problem, but only when combining with a
>  >=20
>  > comment "Switch off CONFIG_INPUT_PCSPKR to use Xenomai" (or so)
>  > 	depends on !X86_TSC && X86 && INPUT_PCSPKR
>  >=20
>  > Otherwise the user will be left alone here with a non-selectable Xen=
omai
>  > option...
>  >=20
>  > This actually remind me of my suggestion some months ago to add Kcon=
fig
>  > warnings for CONFIG_CPU_FREQ & friends. Might be a good chance to ca=
tch
>  > this all. Is scripts/Kconfig.frag the preferred place to add it?
>=20
>=20
> Why not? Here is a second patch that follows your suggestions.

No objections! Looks good to me. But shouldn't we add APM as well?

Jan

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
> --- scripts/Kconfig.frag	(revision 1402)
> +++ scripts/Kconfig.frag	(working copy)
> @@ -1,7 +1,20 @@
> =20
>  menu "Real-time sub-system"
> =20
> +comment "WARNING! You enabled CPU Frequency scaling or use of ACPI"
> +	depends on CPU_FREQ || ACPI_PROCESSOR
> +comment "processor C states as idle handler (ACPI 'processor' option).=
"
> +	depends on CPU_FREQ || ACPI_PROCESSOR
> +comment "These options are known to cause troubles with Xenomai."
> +	depends on CPU_FREQ || ACPI_PROCESSOR
> +
> +comment "NOTE: Xenomai conflicts with PC speaker support."
> +	depends on !X86_TSC && X86 && INPUT_PCSPKR
> +comment "(menu Device Drivers/Input device support/Miscellaneous devic=
es)"
> +	depends on !X86_TSC && X86 && INPUT_PCSPKR
> +
>  config XENOMAI
> +	depends on X86_TSC || !X86 || !INPUT_PCSPKR
>  	bool "Xenomai"
>  	default y
>          select IPIPE



--------------enig67CB78D5C169D746FF352393
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzjUPniDOoMHTA+kRAqU4AJ9Ztnw9RTfVfBxRbU3BJt+cl6hihQCeJEd6
afJE20QFTbvbFpVUlJzb2qI=
=XQSS
-----END PGP SIGNATURE-----

--------------enig67CB78D5C169D746FF352393--

