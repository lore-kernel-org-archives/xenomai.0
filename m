Message-ID: <44F454F7.6010707@domain.hid>
Date: Tue, 29 Aug 2006 16:53:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_dev_ioctl serialization
References: <75975c320608290736r52e642fcrc2e9c5edb1551d03@domain.hid>
In-Reply-To: <75975c320608290736r52e642fcrc2e9c5edb1551d03@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5BE0F18D3CD58E8B076932B9"
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BE0F18D3CD58E8B076932B9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul Ianna wrote:
> Greetings,
>=20
> Background:
>=20
> I have not (yet) studied or written a linux or rtdm device driver.  I
> am, however, using one whose source with which I am unfamiliar.  My
> particular scenario involves a communications device driver written to
> by many asynchronous tasks with varying priorities.  I am concerned
> that I may need to provide protections in front of the rt_dev_ioctl
> call to ensure coherency.
>=20
>=20
> Question:
>=20
> Does a call to rt_dev_ioctl implicitly handle serialization or is it
> each driver's  (or application's) responsibility to take care of
> serialization/reentrancy issues?

It's first of all the driver's responsibility. There are so many
different usages even of basic services (read/write/recv/send) that a
common solution makes no sense. Depending on the usage model of the
driver, the degree of protection against concurrency may vary.

An example for this are the read and write handlers of xeno_16550A:
Writing concurrently is considered a potential valid scenario (though
rare), thus it is ensured via a blocking mutex that a data chunk can be
written atomically. In contrast, reading is not considered to happen
concurrently, and the applied protection against wrong usage is a simple
flag set on entry and reset on exit of the read handler. If a concurrent
read occurs, this will be rejected and the user will be warned via an
error code. The same protection is applied on RTSER_RTIOC_WAIT_EVENT.

That said, your particular driver (which one?) may behave differently.
Either this is documented somewhere, our you actually have to study the
sources to understand its characteristics.

HTH,
Jan


--------------enig5BE0F18D3CD58E8B076932B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9FT4niDOoMHTA+kRAhPRAKCCd950A0cvKQfNU6A3Ja5zdE4u2wCffzpO
ELzXZWIetVhVG4MdukXXOEY=
=CKw8
-----END PGP SIGNATURE-----

--------------enig5BE0F18D3CD58E8B076932B9--

