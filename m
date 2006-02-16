Message-ID: <43F4AB33.5080904@domain.hid>
Date: Thu, 16 Feb 2006 17:41:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C019E68B.23F6%steve@domain.hid>
In-Reply-To: <C019E68B.23F6%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99B33476CD1D1F73D83A566E"
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
--------------enig99B33476CD1D1F73D83A566E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> I have a xenomai userspace application that does the following:
>=20
> A thread of priority 90 toggles a bit (outb) to move a stepper motor.
>=20
> A thread of priority 10 updates the display once a second.
>=20
> The motor thread is periodic and uses rt_task_wait_period(). The displa=
y
> thread just uses sleep(1).
>=20
> My question is this: the priority 90 thread is higher priority, and doe=
sn't
> do anything relating to linux system calls. Whenever the display thread=

> updates the display, the motor thread stalls momentarily.
>=20
> Any idea why this is?

If your motor thread really looks like

while (1) {
	toggle_bit();
	rt_task_wait_period();
}

you may suffer from contentions of the related bus towards your motor
(what kind of interface do you use?).

To test this, just put some instrumentation around the toggle_bit()
(take timestamps and look for abnormal delays). What frequency is your
motor thread running at?

If there is more code in your loop, please post the program (or a
simplified but still failing version).

Jan


--------------enig99B33476CD1D1F73D83A566E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFD9KszniDOoMHTA+kRAudyAJ9GFMIv9Ng5P3LE2Ri5agvq7AjIYwCY2197
5t2opFb27oGkOj1H15OMEw==
=AePK
-----END PGP SIGNATURE-----

--------------enig99B33476CD1D1F73D83A566E--

