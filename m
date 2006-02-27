Message-ID: <440315AC.2000304@domain.hid>
Date: Mon, 27 Feb 2006 16:07:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] prepare-kernel is broken
References: <4402FA52.3080606@domain.hid>	<17411.1445.159527.784570@domain.hid>	<44031010.7010407@domain.hid>
	<17411.5135.897479.800009@domain.hid>
In-Reply-To: <17411.5135.897479.800009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFDB1DE2EA63804CAE8709F6B"
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
--------------enigFDB1DE2EA63804CAE8709F6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Hi,
>  > >  >=20
>  > >  > the last check-in seems to have messed something up:
>  > >  >=20
>  > >  > .../xenomai/scripts/prepare-kernel.sh: line 61: syntax error ne=
ar
>  > >  > unexpected token `fi'
>  > >  >=20
>  > >  > I do not understand what's going on here, so I don't want to ha=
ck some
>  > >  > probably wrong fix for this.
>  > >=20
>  > > In order to have it work, I had to make the following changes to
>  > > revision 610 :
>  > >=20
>  >=20
>  > We seem to use different find versions:
>=20
> What about revision 614 ?
>=20

Ok, no errors, no warnings, should be ok now (at least for the --linux=3D=

scenario).

Jan


--------------enigFDB1DE2EA63804CAE8709F6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAxWsniDOoMHTA+kRAo1oAJ9PprG5ft+MQofYB78VD1mHxEU0JQCfebfu
14G0S6PFflEhDX+jQ2zxNfw=
=GVin
-----END PGP SIGNATURE-----

--------------enigFDB1DE2EA63804CAE8709F6B--

