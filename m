Message-ID: <45798B74.90108@domain.hid>
Date: Fri, 08 Dec 2006 16:57:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1Grrzu-0008JP-G8@domain.hid> <45769862.1060208@domain.hid>
	<E1GrzHI-0003oE-S6@domain.hid>
In-Reply-To: <E1GrzHI-0003oE-S6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3D1FAF64C5546C01E94B245"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3D1FAF64C5546C01E94B245
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Then would you mind moving the trace enabling point as I said and post=
 a
>> patch?
>=20
> See attachment.

Thanks, works fine here. Philippe, please include in the next release.

>=20
>> And if you have any idea for a characteristic CONFIG-switch that=20
>> should lower the default TRACE_SHIFT (CONFIG_EMBEDDED? Or per arch?),
>> you are welcome as well. TIA.
>=20
> Why not lower the default value globally to 13?

Because I like to have those 16K trace points that 14 gives us. And who
knows if the next small embedded platform will not scream for 12?

>=20
> --
> Sebastian
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- ipipe/v2.6/common/kernel/ipipe/tracer.c	2006-10-12 20:08:50.0000000=
00 +0200
> +++ ipipe.work/v2.6/common/kernel/ipipe/tracer.c	2006-12-06 16:53:23.00=
0000000 +0100
> @@ -100,12 +100,10 @@ enum ipipe_trace_type
> =20
> =20
>  #ifdef CONFIG_IPIPE_TRACE_VMALLOC
> -#define IPIPE_DEFAULT_TRACE_STATE   0
> =20
>  static struct ipipe_trace_path *trace_paths[NR_CPUS];
> =20
>  #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
> -#define IPIPE_DEFAULT_TRACE_STATE   CONFIG_IPIPE_TRACE_ENABLE_VALUE
> =20
>  static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS]=
 =3D
>  	{ [0 ... NR_CPUS-1] =3D
> @@ -115,7 +113,7 @@ static struct ipipe_trace_path trace_pat
>  	};
>  #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
> =20
> -int ipipe_trace_enable =3D IPIPE_DEFAULT_TRACE_STATE;
> +int ipipe_trace_enable =3D 0;
> =20
>  static int active_path[NR_CPUS] =3D
>  	{ [0 ... NR_CPUS-1] =3D IPIPE_DEFAULT_ACTIVE };
> @@ -1217,8 +1215,8 @@ void __init __ipipe_init_tracer(void)
>  			trace_paths[cpu][path].end   =3D -1;
>  		}
>  	}
> -	ipipe_trace_enable =3D CONFIG_IPIPE_TRACE_ENABLE_VALUE;
>  #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
> +	ipipe_trace_enable =3D CONFIG_IPIPE_TRACE_ENABLE_VALUE;
> =20
>  	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
> =20

Jan


--------------enigC3D1FAF64C5546C01E94B245
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeYt0niDOoMHTA+kRAqmXAJ985pdj+WhKQJjGrQmeh9J45/pH4gCcDcPM
PaB9imFt8UOLUrra71mUt98=
=AxWg
-----END PGP SIGNATURE-----

--------------enigC3D1FAF64C5546C01E94B245--

