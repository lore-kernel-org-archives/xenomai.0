Message-ID: <43FE48FA.8000206@domain.hid>
Date: Fri, 24 Feb 2006 00:44:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems solved
References: <C0237ECB.24E3%steve@domain.hid>
In-Reply-To: <C0237ECB.24E3%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DA5EB2AA054C05C76912296"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DA5EB2AA054C05C76912296
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> Well, I solved my problems by getting rid of the geode. On a 400 mhz ce=
leron
> board, everything works great. My software used 100% of the CPU on the =
geode
> and locked up the Linux side when the stepper motor would run, but on t=
he
> celeron it uses a negligible amount of the CPU. This is good for me to =
see
> that the problem isn't with my code probably, but bad that Xenomai seem=
s to
> have issues on the Geode that RTAI/fusion did not.
>=20
> Just giving you all a heads up. The geode sucks anyway.
>=20

Well, this "it used to work" doesn't satisfy me. Maybe Geode is
revealing some subtle bug that only triggers under certain load
scenarios. That's why it would be really great if you could try to nail
the issue a bit more down with the suggested steps. When e.g. the tracer
then shows that your code "hangs" on some inb/outb for too long, we can
be sure that this is a hardware-related issue.

Thanks,
Jan


--------------enig5DA5EB2AA054C05C76912296
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/kj6niDOoMHTA+kRAnKuAJ9FmRaGDlWCjlguVsCGjT3oIUuA9gCfbU/D
Owu4mz41WbSAbLpZ/4Re5qg=
=suIh
-----END PGP SIGNATURE-----

--------------enig5DA5EB2AA054C05C76912296--

