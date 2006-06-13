Message-ID: <448E5A2B.9060606@domain.hid>
Date: Tue, 13 Jun 2006 08:24:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strange periodic behavior
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
In-Reply-To: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8758501BEDD26C2E3D24B162"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8758501BEDD26C2E3D24B162
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
> Hey all,
> I've been experimenting with writing a simple timer program using the
> native API.  Basically, each loop, it writes the current timestamp into=

> shared memory which then gets read by a slower loop and written to disk=
=2E=20
> The weird thing is, the period I get seems to always be half of what I'=
ve
> commanded.  That is, if I set the frequency to 1000 Hz, the difference
> between each timestamp is a little over 2 ms (500 Hz).  It works the sa=
me
> way for 10000 Hz and 20000 Hz.  Does anyone know what causes this or ho=
w
> to fix it?  Thanks.
> -Brandt

[FAQ] ;)
Is powersaving via CPU frequency scaling activated (my notebook, e.g.,
scales by 2 in that mode)? Make sure it's not. Also compare your
findings with the output of the latency test tool. Does it suffer too?

Jan


--------------enig8758501BEDD26C2E3D24B162
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEjlouniDOoMHTA+kRAsxKAJ4xXt05ZyVEYF4i42wFCA+OCbzX5ACdGvBA
clsGa5yIyxmP49pZdMl/YYQ=
=JRs0
-----END PGP SIGNATURE-----

--------------enig8758501BEDD26C2E3D24B162--

