Message-ID: <4A30CF49.8010007@domain.hid>
Date: Thu, 11 Jun 2009 11:32:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A30CB83.5080504@domain.hid>
In-Reply-To: <4A30CB83.5080504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF3311B28A9CA8C7767212C3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry
	changes in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF3311B28A9CA8C7767212C3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

Vladimir Zapolskiy wrote:
> Hello,
>=20
> please apply the attached simple patch, which resolves a kind of
> compilation problems against 2.6.30 kernel.
>=20
> --=20
> With best wishes,
> Vladimir=20
>=20
> From 894660f7dc91b406d8e078247b46606778562de9 Mon Sep 17 00:00:00 2001
> From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
> Date: Thu, 11 Jun 2009 12:32:00 +0400
> Subject: [PATCH] Made conditional inclusion of owner field in struct pr=
oc_dir_entry due to changes in 2.6.30
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
> ---
>  ksrc/arch/generic/hal.c              |    6 ++++++
>  ksrc/drivers/comedi/device.c         |    2 ++
>  ksrc/drivers/comedi/rtdm_interface.c |    4 ++++
>  ksrc/nucleus/registry.c              |    2 ++
>  4 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
> index e4f0f31..b983b68 100644
> --- a/ksrc/arch/generic/hal.c
> +++ b/ksrc/arch/generic/hal.c
> @@ -738,7 +738,9 @@ struct proc_dir_entry *rthal_add_proc_leaf(const ch=
ar *name,
>  	entry->data =3D data;
>  	entry->read_proc =3D rdproc;
>  	entry->write_proc =3D wrproc;
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
>  	entry->owner =3D THIS_MODULE;
> +#endif

I would suggest to squeeze all these assignments into a helper function
that is void from 2.6.30 on, hiding the #ifdefs

Jan


--------------enigBF3311B28A9CA8C7767212C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkowz0kACgkQniDOoMHTA+m/igCffsWvLvbBi0wh2MF+Cw8XU/it
AZ4An1qZNUBvQrRRh7jy3z+ytzqgcp+1
=YjrA
-----END PGP SIGNATURE-----

--------------enigBF3311B28A9CA8C7767212C3--

