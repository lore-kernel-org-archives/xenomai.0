Message-ID: <467F9FE5.1070205@domain.hid>
Date: Mon, 25 Jun 2007 12:58:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>	<1182708919.7044.201.camel@domain.hid>	<467F5CBF.9040108@domain.hid>
	<18047.40395.671989.328415@domain.hid>
In-Reply-To: <18047.40395.671989.328415@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9280D8D872C693449467D83A"
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
--------------enig9280D8D872C693449467D83A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Ok, I think it's time to summarise some results of this thread:
>  >=20
>  >  - xntimers will be of three kinds: real-time absolute, monotonic
>  >    absolute, and monotonic relative ones (ie. all POSIX). I'm curren=
tly
>  >    in favour of passing this property on timer start and not pushing=

>  >    parts or more of it into timer init.
>=20
> The posix skin can live without monotonic absolute timers: monotonic
> timeout could simply be converted to relative timeouts.
>=20

The POSIX skin will not be the only user, and I rather see disadvantages
/wrt the hot-path (multiple timer readouts + conversions) when moving
over emulation mode again.

Anyway, I hope I can come up with some patches over the next days,
clarifying what we actually need to change (not much I think).

Jan


--------------enig9280D8D872C693449467D83A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGf5/lniDOoMHTA+kRAs4ZAJsFXwcTUyALbnJGzYZqzpIJGO8O8gCfTgiK
uiSy4o/5O12/C3s3iP+8sUI=
=bChG
-----END PGP SIGNATURE-----

--------------enig9280D8D872C693449467D83A--

