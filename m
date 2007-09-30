Message-ID: <46FFC413.2090708@domain.hid>
Date: Sun, 30 Sep 2007 17:43:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <14637422.1190889662020.JavaMail.ngmail@domain.hid>
In-Reply-To: <14637422.1190889662020.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC54E8E34C52D8C6F221D76D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai maintenance and latest kernel versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC54E8E34C52D8C6F221D76D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mathias,

M. Koehrer wrote:
> Hi everybody,
>=20
> I have a question concerning the maintenance versions of Xenomai.
> Currently, the maintenance releases (e.g. 2.3.3) contain fixes of Xenom=
ai and no new features.
> That is fine so far. However, I wonder if it could possible to support =
the latest kernel series
> (now 2.6.22) with the maintenance version aswell. That means, no new fe=
atures, just a new=20
> adeos patch that fits to kernel 2.6.22 and Xenomai 2.3.x.
> Something like a adeos-ipipe-2.6.22-i386-1.8-06.patch.
> In our use case, we use always the latest PC technology for high speed =
real time simulation systems.
> For some PC components (e.g. ACPI stuff, some onboard NICs etc.) we sho=
uld use the latest
> kernel.
> I am very happy with the functional state we have with Xenomai 2.3.3, b=
ut I want to use this
> functionality with the latest kernel.
> Is there any way to get that?!?

Philippe explained this before: Technical changes between 2.6.20 and
=2E22, namely the introduction of hrtimers/tick-less mode in 2.6.21,
required significant changes to the Xenomai timer subsystem. Luckily,
those changes were developed for 2.4 already so that adopting latest
kernel version was feasible for trunk. Now porting those changes back to
the 2.3 series would simply pervert the idea of a stable maintenance seri=
es!

BTW, 2.6.22 + xeno 2.4 is currently causing some headaches, at least to
me. So if you want to move forward with your platform to kernel 2.6.22
and later, you are welcome to help us testing and maturing the latest
version. Keep in mind, resources - specifically unpaid ones - are finite.=


Jan


--------------enigDC54E8E34C52D8C6F221D76D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/8QTniDOoMHTA+kRAsr7AJ9tRpLyYmHKninuIDrf1+jlXjHffACeMCQE
XAbjlvedIPtYGLFx6scFHnQ=
=w56+
-----END PGP SIGNATURE-----

--------------enigDC54E8E34C52D8C6F221D76D--

