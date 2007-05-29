Message-ID: <465C6268.1090704@domain.hid>
Date: Tue, 29 May 2007 19:27:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465ADB44.2070705@domain.hid>
	<1180360288.4727.50.camel@domain.hid>	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>	<465BE777.7010204@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
In-Reply-To: <7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBC9C26BA5B8E20979E72AE7D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] =?iso-8859-15?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC9C26BA5B8E20979E72AE7D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
=2E..
> -Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,m=
map
> -Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mutex_rt.o
> -lpthread_rt -lpthread -lrt -o essai_mutex_rt

I think to remember the ordering makes a difference here: Try to put
essai_mutex_rt.o after the libs. That's also what happens when using the
Xenomai provided flags.

Apropos: Use `<xenomai-installation-path>/xeno-config --posix-ldflags`
(also for --posix-cflags) to make your life easier. There is generally
no need to maintain all the flags on your own - and it's error-prone.

Jan


--------------enigBC9C26BA5B8E20979E72AE7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXGJoniDOoMHTA+kRAgEhAKCAPu9h2xWS+AhQ0TPP2fjTUJCj3wCeKBGx
AvsqZ/4eBjmEw2+/EgAInfs=
=vhQw
-----END PGP SIGNATURE-----

--------------enigBC9C26BA5B8E20979E72AE7D--

