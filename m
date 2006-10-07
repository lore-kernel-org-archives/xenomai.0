Message-ID: <452767E0.3050107@domain.hid>
Date: Sat, 07 Oct 2006 10:40:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
	<4526B48F.50705@domain.hid>
In-Reply-To: <4526B48F.50705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E36158F6658FA5E2503F98D"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E36158F6658FA5E2503F98D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> ...
> Index: ksrc/drivers/can/rtcan_internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_internal.h	(revision 1695)
> +++ ksrc/drivers/can/rtcan_internal.h	(working copy)
> @@ -111,6 +111,10 @@
> =20
>  #ifndef compat_module_int_param_array
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
> +# define compat_module_int_param(name) \
> +    MODULE_PARM(name, "i")
> +# define compat_module_charp_param(name) \
> +    MODULE_PARM(name, "s")
>  # define compat_module_byte_param_array(name, count) \
>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "b")
>  # define compat_module_short_param_array(name, count) \
> @@ -118,6 +122,10 @@
>  # define compat_module_int_param_array(name, count) \
>      MODULE_PARM(name, "1-" __MODULE_STRING(count) "i")
>  #else
> +# define compat_module_int_param(name) \
> +    module_param(name, int, 0444)
> +# define compat_module_charp_param(name) \
> +    module_param(name, charp, 0444)
>  # define compat_module_byte_param_array(name, count) \
>      module_param_array(name, byte, NULL, 0444)
>  # define compat_module_short_param_array(name, count) \

No need, module_param comes even with 2.4. We only need wrapping for
parameter arrays (due to different semantics of the macro arguments).

So, this patch can be shorter... :)

Jan


--------------enig8E36158F6658FA5E2503F98D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFJ2fmniDOoMHTA+kRAjhSAJ9u7lpr3tkX8r5n9BqMMchJeMnSpQCeOIXv
kVxRm3vnelo1dUuTLdvyPLI=
=Bh6c
-----END PGP SIGNATURE-----

--------------enig8E36158F6658FA5E2503F98D--

