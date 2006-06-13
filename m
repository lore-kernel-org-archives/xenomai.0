Message-ID: <448EEF1A.8070300@domain.hid>
Date: Tue, 13 Jun 2006 19:00:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strange periodic behavior
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
	<448E5A2B.9060606@domain.hid>
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>
	<448EDECA.7030302@domain.hid>
	<36429.155.98.4.39.1150216385.squirrel@domain.hid>
	<448EE9C3.4060706@domain.hid>
	<40729.155.98.4.39.1150217383.squirrel@domain.hid>
In-Reply-To: <40729.155.98.4.39.1150217383.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D418A124576F20334A3BBF8"
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
--------------enig6D418A124576F20334A3BBF8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
>  > Grmbl, my fault. Your test looks ok, but I was rather referring to y=
our
>> *code*.
>=20
> Sorry, here's a small portion of what it outputs.  The first column is =
the
> timestamp and the second is the overrun value from rt_task_wait_period.=
=20
> In this case, the "control loop" is supposed to be running at 10 KHz.
>=20

Let's try this again :): Could you post your test program or better a
reduced version of it that demonstrate the wrong timing? We can then
analyse and/or compile and run it on some of our test systems.

Jan


--------------enig6D418A124576F20334A3BBF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEju8aniDOoMHTA+kRAsB2AJ4oxersHQXyPSjUzAW1Vp8WNJ1qggCeOJ15
LoFnwaR/BkBDLG6lGh6oH10=
=tN9e
-----END PGP SIGNATURE-----

--------------enig6D418A124576F20334A3BBF8--

