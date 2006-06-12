Message-ID: <448DCF9F.807@domain.hid>
Date: Mon, 12 Jun 2006 22:33:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
	<44770814.5040009@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
	<4485E647.7010205@domain.hid>
In-Reply-To: <4485E647.7010205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig278740BFB0405BDA5E7E07DE"
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig278740BFB0405BDA5E7E07DE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> Niklaus Giger wrote:
>> Am Freitag, 26. Mai 2006 15:52 schrieb Jan Kiszka:
>> =20
>>> Niklaus Giger wrote:    ...
>>> If anybody has a working target with a Xenomai + BusyBox combination =
and
>>> would be willing to test drive my changes, I would appreciate a feedb=
ack
>>> enormously.
>>>  =20
>=20
> I hope this isnt waiting on my 'approval'.
> I think its a great idea, and has been on my (way too stagnant) list fo=
r
> a while.
> Your work has at least urged me to install busybox on my xeno-box. ;-)
>=20
> My only concern is whether we've sufficiently distinguished the issues:=

>=20
> 1 - ash vs bash
>=20
> Its not entirely clear to me which flavors of sh busybox has:
>     ash / dash / not-bash
> I gather u worked with ash, and it seems most valuable sh features
> work there just fine ( shell-functions, even 'job-control' of a fashion=
)
>=20
> 2 - busybox 'executables' only
>=20
> I coded in a lot of 'full linux' gimme's, like zgrep, script, etc.
> Niklaus has repaired many of these.  I think a more thorough cleanup is=

> possible,
> esp if things like 'script' are jettisoned for a simpler shell-function=
s
> or helper scripts.
> This all implies a re-write, which is on my list...
> (esp the job-control testing and repair)

Just stumbled over this again while cleaning up my mailbox. What's the
status? Waiting for improvements, or waiting for /someone/ to type svn
ci (and improve the topics above later)?

Jan


--------------enig278740BFB0405BDA5E7E07DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjc+fniDOoMHTA+kRAuXIAJ4xDkTqzvpaqcFj1CP5yLYzaFrKSwCbB1Oq
6TqHOTxlyoYLXxxZzh94maQ=
=fDlc
-----END PGP SIGNATURE-----

--------------enig278740BFB0405BDA5E7E07DE--

