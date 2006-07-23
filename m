Message-ID: <44C3D55F.20802@domain.hid>
Date: Sun, 23 Jul 2006 22:00:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>	<44BE8ECF.2050608@domain.hid>	<44BE943E.80302@domain.hid>	<44BEA974.40708@domain.hid>
	<44BFC5FA.6080608@domain.hid> <44BFFC62.8030601@domain.hid>
	<44C21AF8.3000906@domain.hid> <44C25DA7.6020302@domain.hid>
	<44C287C4.30209@domain.hid> <44C3AEB9.5070905@domain.hid>
	<44C3BEB5.2070001@domain.hid>
In-Reply-To: <44C3BEB5.2070001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCD3B1EBD6ED5108A2A34D46F"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD3B1EBD6ED5108A2A34D46F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Ciao Jan!
>=20
> Jan Kiszka wrote:
> [...]
>> Please try "make clean" before rebuilding your 2.4 kernel with a
>=20
> Indeed, make clean does a wonder :-)

Good, no further bugs hidden. :)

> BTW, is there any way to reconfigure the periodic timer ?
> Not that I wanna use it - I'm fine with the more accurate aperiodic
> timer, but just curious.

E.g. via rt_timer_set_mode(tick_period) (native skin). If you enable the
periodic mode at compile time, you can use this call from your app to
tweak it during runtime. Additionally, there is the tick_arg module
parameter (or the xeno_nucleus.tick_arg kernel parameter) to set the
timer at startup.

>=20
>> This digging in 2.4 over x86 was "worthwhile": Two further corner-case=

>> bugs found, though not all fixed yet.
>=20
> First, I'm sorry that I didn't consider make clean, but then this
> issue led to find two previously unknown bugs.
> From your last email to the list I guess the TSC thingie is one,
> what is the other one ? Anything serious ?

Not really. Try to compile the native skin as module under 2.4...

Jan


--------------enigCD3B1EBD6ED5108A2A34D46F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEw9VjniDOoMHTA+kRArtKAJ0YAW4Rxk7O1Ues+Dlq5KjJsrEIOwCdE0B6
dM/9HXe8MFokvUfpO/ybC10=
=GfWd
-----END PGP SIGNATURE-----

--------------enigCD3B1EBD6ED5108A2A34D46F--

