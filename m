Message-ID: <463A2E31.4010302@domain.hid>
Date: Thu, 03 May 2007 20:47:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>	<1178204088.29605.85.camel@domain.hid>
	<4639FAC7.9060207@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43DC9@domain.hid>
	<17978.11531.902028.392269@domain.hid>
In-Reply-To: <17978.11531.902028.392269@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B913B5E839452F75D5F2B01"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B913B5E839452F75D5F2B01
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Daniel Schnell wrote:
>  >=20
>  > If, say, I would use latencies calibrated with user space POSIX
>  > timers for a typical work load, what would happen to timers that are=

>  > running in kernel or interrupt space ? Would they then be too early =
?=20
>  > Have negative values any negative effect besides running too early ?=

>  >=20
>  > In other words: when one uses timers inside Kernel, ISR's and User
>  > space at the same time, which value should be used for
>  > /proc/xenomai/latency ? Wouldn't it make sense then to have 3
>  > different latency values for the 3 possible environments ?
>=20
> Yes the current situation is that there is only one constant, so, if yo=
u
> calibrate it for ISRs, user-space programs will be systematically
> late. Having three different constants would mean that we track, at
> nucleus level where each timer is used, and that we order timers in the=

> timer queue according to their anticipated expiration date. This is
> quite a modification.

Quick shot: Maybe the caller of xntimer_start could already account for
the usage scenario and subtract some magic offset from the timeout date.

Jan


--------------enig2B913B5E839452F75D5F2B01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOi4xniDOoMHTA+kRAnfmAJ9SP/2Pkb3VTXhYUN65sRV+jYDhbgCeJ3Wm
A1AHhWjcheOKEwD4Vc4YEFQ=
=wnBd
-----END PGP SIGNATURE-----

--------------enig2B913B5E839452F75D5F2B01--

