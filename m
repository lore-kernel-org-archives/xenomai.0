Message-ID: <46800E62.9090300@domain.hid>
Date: Mon, 25 Jun 2007 20:50:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>	<1182708919.7044.201.camel@domain.hid>	<467F5CBF.9040108@domain.hid>	<18047.40395.671989.328415@domain.hid>	<467F9FE5.1070205@domain.hid>	<467FD25B.1040607@domain.hid>
	<18048.2782.400727.660810@domain.hid>
In-Reply-To: <18048.2782.400727.660810@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4640B13F0B0DAC9A253FE75"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
--------------enigA4640B13F0B0DAC9A253FE75
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > +/* Timer operation modes */
>  > +typedef enum xntimer_mode {
>  > +	XNTM_MONOREL =3D 0,
>  > +	XNTM_MONOABS =3D XNTIMER_ABSOLUTE,
>  > +	XNTM_REALABS =3D XNTIMER_REALTIME | XNTIMER_ABSOLUTE
>  > +} xntimer_mode_t;
>=20
> Is not it a bit weird to use enums ? I mean=E7 we use #defines everywhe=
re
> else.

I'm starting to like these kind of types, because they express what
values are expected and allowed here. Anyway, if this is not desired, I
can use plain defines again as well.

>=20
>  > +	default: /* XNTM_MONOABS || XNTM_REALABS */
>  >  		date =3D xnarch_ns_to_tsc(value);
>  >  		if (date <=3D now)
>  >  			return -ETIMEDOUT;
>  > +		__setbits(timer->status, XNTIMER_REALTIME);
>  > +		break;
>=20
> Having the same treatment for absolute monotonic and realtime clocks
> looks suspicious.

Nope, please have a look at the two line above this excerpt, they should
explain the difference.

>=20
>=20
>  > +	default: /* XNTM_MONOABS || XNTM_REALABS */
>  >  		if (value <=3D timer->base->jiffies)
>  >  			return -ETIMEDOUT;
>  > +		__setbits(timer->status, XNTIMER_REALTIME);
>  > +		break;
>=20
> Same here
>=20
>=20

Thanks for a having a view,

Jan


--------------enigA4640B13F0B0DAC9A253FE75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgA5jniDOoMHTA+kRAndwAJ0ZL/BW4imXMy0OQUEKP6GrAlbSWQCfarTu
EUzMdEMsQ2hpoKxdd59UecA=
=rSg6
-----END PGP SIGNATURE-----

--------------enigA4640B13F0B0DAC9A253FE75--

