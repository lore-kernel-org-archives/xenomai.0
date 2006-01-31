Message-ID: <43DF31EC.9030009@domain.hid>
Date: Tue, 31 Jan 2006 10:46:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM timing problems
References: <200601301611.53089.lbocseg@domain.hid> <43DE5E05.1030302@domain.hid>
	<fd6a47a90601301517q77732fabm@domain.hid>
In-Reply-To: <fd6a47a90601301517q77732fabm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A1F939B091FEBD1F10795E7"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A1F939B091FEBD1F10795E7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>  Jan,
>=20
> Can't you start it with a short Linux user-space app upon startup ? Doe=
sn't
> even need to go realtime.
>=20
> I'm planning to try this as I want to start two unrelated Xenomai proce=
sses
> which need the timer for timeouts (obviously in a perpetual effort to t=
est
> the Xenomai kernel ;-))
>=20

Of course, you can. And this is also what we are doing in our software
so far. Anyway, the point is that this step is superfluous if only
aperiodic mode is available. Moreover, it's inconsistent compared to
other skin's interfaces. But there is hope we will overcome it one day. :=
)

Jan


--------------enig9A1F939B091FEBD1F10795E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3zHsniDOoMHTA+kRAheqAJ0Ytn7aMBK0ETc7pGd5gXAAG/xy5ACdGyGG
wPeCyadABI1y9GSezmY1raI=
=Rlzi
-----END PGP SIGNATURE-----

--------------enig9A1F939B091FEBD1F10795E7--

