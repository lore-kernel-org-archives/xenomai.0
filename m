Message-ID: <4B6AF2D5.1000908@domain.hid>
Date: Thu, 04 Feb 2010 17:16:21 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
In-Reply-To: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB63F94361CFBDB36E395831B"
Subject: Re: [Xenomai-help] User interrupt handling in Xenomai running into
 probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, sarans1987@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB63F94361CFBDB36E395831B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Am 04.02.2010 16:51, schrieb Saravanan S:
> Hi,
>=20
>     I tried to implement the hardware interrupt handling feature of
> xenomai in user space.I read the native-api document and ran the
> user_irq.c program with one change ,i tried to intercept the eth0
> interrupt on my system(using interrupt number from cat
> /proc/interrupts).When i ran the program the system froze!!!!!

The rt_intr_* interface is disabled by default in the kernel configuratio=
n, please check.
That would mean that rt_intr_wait returns immediately, now look at this l=
oop from user_irq.c:
    for (;;) {

       /* Wait for the next interrupt on channel #7. */
       err =3D rt_intr_wait(&intr_desc,TM_INFINITE);

       if (!err) {
           /* Process interrupt. */
       }

> What am i doing wrong??
>=20
> What  is the purpose of this feature of allowing user space handling of=

> interrupts.Can a user space driver be written using this???

You should use the rtdm interface for drivers.

Regards Stefan


--------------enigB63F94361CFBDB36E395831B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLavLZIPTw9rIdn6oRAifyAJ9wfOK9cp0gqYX+wl9enltrCkww9QCggFJ+
y+VkAbpItp68fRBq2jGE4gc=
=o3bz
-----END PGP SIGNATURE-----

--------------enigB63F94361CFBDB36E395831B--

