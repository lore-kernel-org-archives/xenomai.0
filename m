Message-ID: <46F80F45.7050406@domain.hid>
Date: Mon, 24 Sep 2007 21:25:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>	<46F7F868.2050904@domain.hid>
	<18168.1587.763871.556961@domain.hid>
In-Reply-To: <18168.1587.763871.556961@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEBBAED9F16BD91EBCE00C68E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
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
--------------enigEBBAED9F16BD91EBCE00C68E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Richard Cochran wrote:
>  > > I know that this is a bit off topic, yet perhaps some on this list=

>  > > have interest or knowledge in this area. I am also posting this id=
ea
>  > > to the linux-arm-kernel list.
>  > >=20
>  > > I would like to implement the ARM FCSE under Linux, using the Inte=
l
>  > > IXP425 board. Before I start, I would like to ask:
>  > >=20
>  > > 1. Has any work already been done in this area?
>  > >=20
>  > > 2. Is there something about the current Linux MM that would make t=
his
>  > >    impractical?
>  >=20
>  > Nothing is impossible (specifically as FASS proves its feasibility),=

>  > it's just a question how much work it is to implement it AND maintai=
n it
>  > or merge it into standard Linux. And I cannot imagine ARM or its
>  > licensees dropping this feature without an acceptable alternative on=
ce
>  > Linux started to use it broadly...
>=20
> The feature was already dropped, it is deprecated in ARMv6.
>=20

I'm not claiming to be an ARM insider, but browsing through some manuals
makes me think that "The c13, Context ID Register, [...] replaces the
FCSE PID register. Use of the FCSE PID Register is deprecated."
Moreover: "The ARM1136JF-S processor implements the Fast Context Switch
Extension (FCSE) and high vectors extension that are required to run
Microsoft WindowsCE." Given this popular user, it is highly unlikely
that a feature comparable to FCSE is going to be removed from the ARM
architecture - at least as long as its cache is located at such an
unpleasant place.

Jan


--------------enigEBBAED9F16BD91EBCE00C68E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG+A9HniDOoMHTA+kRAhXEAJ9tTpOgfKY68bx23rfy3REnBmlbDQCfQHOP
qoqWqJih78bJbfHHFX6G9cU=
=UA5E
-----END PGP SIGNATURE-----

--------------enigEBBAED9F16BD91EBCE00C68E--

