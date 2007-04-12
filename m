Message-ID: <461DE3D3.90405@domain.hid>
Date: Thu, 12 Apr 2007 09:46:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <489168738@domain.hid> <E1HbtnE-0003o2-NP@mailer.emlix.com>
In-Reply-To: <E1HbtnE-0003o2-NP@mailer.emlix.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD84D914B3FEB7E6B6332CE50"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] how to release file descriptor after application
 crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD84D914B3FEB7E6B6332CE50
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jochen Behnke wrote:
>> Hello,
>>
>> is there any way to release a file descriptor associated with a rtdm d=
evice
>> after an application crash ? The reason I'm asking this is the followi=
ng:
>> My application uses a rtdm device that can only be used in exclusive m=
ode.
>> When the application crashes while the device was opened, I have to re=
boot
>> the system in order be able to use the device again. Is there a way to=

>> release the file descriptor or to close the device without rebooting.
>=20
> See the note to the description of rt_dev_close in the RTDM API documen=
tation.
> (http://www.xenomai.org/documentation/trunk/html/api/group__userapi.htm=
l#ga34c1ddf4e2deb727a1ab3cd648ce5d9)
>=20

For trunk, the paragraph about stalled descriptors need to be removed
(good that you referred to it). RTDM of upcoming Xenomai 2.4 performs
automatic file descriptor cleanup now.

Jan


--------------enigD84D914B3FEB7E6B6332CE50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGHePZniDOoMHTA+kRAqyrAJ4306I2pHdqdA7xGDz4Y97/JqtA4wCeKEO8
Pc+p9l2vPE/l9Lv2VExPyCg=
=fttp
-----END PGP SIGNATURE-----

--------------enigD84D914B3FEB7E6B6332CE50--

