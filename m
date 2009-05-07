From: Raistlin <raistlin@domain.hid>
In-Reply-To: <4A02D609.2010202@domain.hid>
References: <1043994168.4085071240493189508.JavaMail.root@domain.hid>
	<49F06D77.7050103@domain.hid> <1241695394.6157.7.camel@domain.hid>
	<4A02D4C2.3060009@domain.hid>  <4A02D609.2010202@domain.hid>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-h+6YUAr0Cok66f7uwhiA"
Date: Thu, 07 May 2009 14:47:20 +0200
Message-Id: <1241700440.6157.15.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>


--=-h+6YUAr0Cok66f7uwhiA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-07 at 14:37 +0200, Gilles Chanteperdrix wrote:
> > As usual, please send us /proc/interrupts, /proc/xenomai/irq, your
> > .config, and the version of the I-pipe patch you use.
> >=20
I will.

> > Run the latency and switchtest tests, and tell us if you have the freez=
e
> > with them too.
>=20
It has happened once during a test (latency I think), but I've also been
(next times, after reboot) able to run both of them without any issue.

Anyway, as soon as I reboot I'll run all the tests again.

> Also, Benoit's problem was not in fact due to xenomai but to gnome power
> management.=20
I see... Well, of course, all is possible... I'm using
gnome-power-manager too, but while running plain Ubuntu kernel no freeze
happens, but... I mean... Who knows?!?!

> This shows that the notion of "freeze" is very vague, and
> without further information, we can not tell you more.
I know, and I'm sorry of being able to be more specific since now. :-(
I'll test it deeper and let you know in detail.

For now, thanks a lot for your support! :-)

Regards,
Dario

--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
----------------------------------------------------------------------
Dario Faggioli, ReTiS Lab, Scuola Superiore Sant'Anna, Pisa  (Italy)

http://blog.linux.it/raistlin / raistlin@domain.hid /
dario.faggioli@domain.hid

--=-h+6YUAr0Cok66f7uwhiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoC2FgACgkQk4XaBE3IOsQojACbBlao5NWOOc8ZV5Lk1EyqoNOd
leQAnA/2QOol6piF2Q0ZL4R4pHVaFrGt
=6Q+a
-----END PGP SIGNATURE-----

--=-h+6YUAr0Cok66f7uwhiA--


