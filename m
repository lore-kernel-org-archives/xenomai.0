Message-ID: <4908FF4D.4050706@domain.hid>
Date: Thu, 30 Oct 2008 01:26:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49085904.8080302@domain.hid>
In-Reply-To: <49085904.8080302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD77AC68784EC3CBB6942032F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN: correct bug with filter
	registration
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, Sebastian Smolorz <Sebastian.Smolorz@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD77AC68784EC3CBB6942032F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan and Sebastian,
>=20
> attached is the patch fixing the filter problem. I'm going to apply it
> to the trunk as well if there are no complaints.
>=20
> Wolfgang.
>=20
> Index: ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ChangeLog	(revision 4287)
> +++ ChangeLog	(working copy)
> @@ -1,3 +1,9 @@
> +2008-10-29  Wolfgang Grandegger  <wg@domain.hid>
> +
> +	* ksrc/drivers/can/rtcan_raw_filter.c(rtcan_raw_mount_filter):
> +	Applying the filter mask required for fast filter checks got lost
> +	somehow with commit 2202.
> +
>  2008-10-28  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
> =20
>  	* ksrc/nucleus/thread.c (xnthread_init): Change initialization
> Index: ksrc/drivers/can/rtcan_raw_filter.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_raw_filter.c	(revision 4287)
> +++ ksrc/drivers/can/rtcan_raw_filter.c	(working copy)
> @@ -62,6 +62,9 @@
>  	recv_filter->can_id =3D filter->can_id;
>  	recv_filter->can_mask =3D filter->can_mask & ~CAN_INV_FILTER;
>      }
> +
> +    /* Apply mask for fast filter check */
> +    recv_filter->can_id &=3D recv_filter->can_mask;
>  }
> =20
> =20

Ack from me, too. Please commit to trunk and 2.4.x.

Thanks for spotting this, Sebastian!

Jan


--------------enigD77AC68784EC3CBB6942032F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkI/1MACgkQniDOoMHTA+kUJQCfZBizfvZWUxMHHmx44KkGHab+
9QsAn1vhrw3BdHocEYUJHApTUkwAIQme
=8lZe
-----END PGP SIGNATURE-----

--------------enigD77AC68784EC3CBB6942032F--

