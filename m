Message-ID: <44B28193.3090408@domain.hid>
Date: Mon, 10 Jul 2006 18:34:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai beginner problem.
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>	
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>	
	<17583.47182.991802.118974@domain.hid>	
	<e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>	
	<1152371904.5004.2.camel@domain.hid>	
	<e325d110607081156n42b7d8f1m892949b16dc2e9f@domain.hid>	
	<17584.4915.679135.575538@domain.hid>	
	<44B02B69.9050903@domain.hid>	
	<e325d110607090646m6fe877c7sc33777a370648d99@domain.hid>	
	<44B13745.300@domain.hid>
	<e325d110607100838q4955cfa3p3ef1386f38e3e599@domain.hid>
In-Reply-To: <e325d110607100838q4955cfa3p3ef1386f38e3e599@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig059E77F29EADFA94734144E5"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig059E77F29EADFA94734144E5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi all,
>=20
> I managed to install Xenomai into another of my machine.
> I am able to run all the test program without any problem.

Hmm, while it's nice to hear that this works, there remains the
uncomfortable feeling that something might be broken on your first box.
When time allows, we would welcome further investigations, specifically
a capture of that infamous oops.

>=20
> I am interested with the hard real time serial port example from..
> http://www.captain.at/xenomai-serial-port-example.php
>=20
> The following is the error message i received when i try to run the
> program..
> ./rt_serial_uprog
> rt_serial_uprog: PRESS CTRL-C to EXIT
> rt_serial_uprog: timer started
> rt_serial_uprog: can't open rtser0
> rt_serial_uprog: stop timer
>=20
> May i know which device is "rtser0"?
> shall i just change it to /dev/ttyS0?

Check Hannes' doku: you have to load the xeno_16550A driver.

Jan


--------------enig059E77F29EADFA94734144E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsoGTniDOoMHTA+kRAmi3AJ9VvpxvOPtcU6YmatZeSBdlPI5cLACdFvVG
L6fTeAiTvL1n+mbCaRb7K44=
=uN6U
-----END PGP SIGNATURE-----

--------------enig059E77F29EADFA94734144E5--

