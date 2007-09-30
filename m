Message-ID: <46FFC6AD.8010301@domain.hid>
Date: Sun, 30 Sep 2007 17:54:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46FED989.6000402@domain.hid> <46FEE3D6.1090003@domain.hid>
In-Reply-To: <46FEE3D6.1090003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig69E2C86561B6D67CA5CD1784"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Functional difference between tty and xterm?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brian Zenowich <bz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69E2C86561B6D67CA5CD1784
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brian Zenowich wrote:
> Nevermind. Adding "Option NoAccel True" to xorg.conf (i810 driver) fixe=
d=20
> it. I thought this was just to reduce latencies. I didn't realize I=20
> couldn't even access my CAN card without it!

That it avoids crashes is new to me as well. If you have a bit time,
please try to attach a serial console (see
linux/Documentation/serial-console.txt) and check if you get some oopses
when you leave the option out. That may help us to find the underlying
reason.

Thanks,
Jan


--------------enig69E2C86561B6D67CA5CD1784
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/8atniDOoMHTA+kRAnFyAJ9Wn2QaNXKec+jwEFSa0qHwgrdG3gCfTG9j
Jfs9bG2T7w7KqQVjZx4WalE=
=gEud
-----END PGP SIGNATURE-----

--------------enig69E2C86561B6D67CA5CD1784--

