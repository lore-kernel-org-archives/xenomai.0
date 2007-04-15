Message-ID: <462220DF.7050107@domain.hid>
Date: Sun, 15 Apr 2007 14:55:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20070411170158.89634.qmail@domain.hid>
In-Reply-To: <20070411170158.89634.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE84FC5930BAAAB3D3BD05044"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] First version for PCI framegrabber skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org, jlpamart@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE84FC5930BAAAB3D3BD05044
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> First of all I would like to state I'm glad to write to this list once =
more :)
>=20
> Secondly, I would like to apologize for the late that I'm sending you t=
his first version of the
> old promised skeleton for the real-time PCI framegrabber I've developed=
 last year...
>=20
> Thirdly, I would like to apologize for it being not organized nor docum=
ented, but I'll explain the
> reasons for that.
>=20
> Since I've finished my Master Thesis, I have been in a hurry and at thi=
s moment I'm working from
> 8h to 22h from monday to thursday and from 8h to 18h at friday in three=
 different jobs... So, it
> is true... I do not have time at the moment for writing the skeleton th=
e way I want. But since I
> received the message below yesterday (actually it was sent a week befor=
e but I didn't have time to
> check my other mail), I tried to help him.
>=20
> I tried to get some free time at my job today for organizing a bit and =
mainly for removing the
> specific DataTranslation code from the skeleton because I do not have p=
ermission yet to send the
> full code. I cannot assure the attached code will even compile, since I=
 work on a Windows box at
> work... Since I'm going to S=E3o Paulo tomorrow morning (6 am), in a bu=
siness trip, I hope some of
> you could assist him for any doubts due to code desorganization and lac=
k of documentation...
>=20
> Hope I can help with this code. Sorry, but I cannot do more than that u=
ntil monday, when I come
> back.

Your effort toward an RT framegrabbing driver interface is very welcome,
and I hope it can lay the ground for further work in this domain, also
via different media like FireWire or USB.

Just one issue remains as you already apologised for: this code needs a
/little/ bit cleanup. I tried to get an impression by browsing through
it, but it's fairly hard to read even for someone who thinks to know
what to look for. Too much experimental or dead code.

Maybe, once time permits, you can start the cleanup by reducing the
driver to a level that only leaves the removed HW access as markers,
killing everything that is not used right now in your real driver.

Jan


--------------enigE84FC5930BAAAB3D3BD05044
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIiDfniDOoMHTA+kRApgvAJwNvKyawOChIHwl8UqC73Kg2epSFgCfTUw6
xpeYh3mHQuhECax/f0Zh+Co=
=c8Zq
-----END PGP SIGNATURE-----

--------------enigE84FC5930BAAAB3D3BD05044--

