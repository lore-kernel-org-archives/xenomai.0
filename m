Message-ID: <4729B0F8.5020704@domain.hid>
Date: Thu, 01 Nov 2007 11:56:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C3@domain.hid>
In-Reply-To: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1EFE221DE691EA86AD73DC24"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] task rate control with alarm and semaphore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: MEYLAN Jean-philippe <Jean-philippe.Meylan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1EFE221DE691EA86AD73DC24
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

MEYLAN Jean-philippe wrote:
> Hello,
>=20
> I'm working on the creation of a Xenomai target for Mathwork's
> Real Time Workshop. In order to achieve this, I would like to=20
> control the execution rate of a task with a semaphore periodically
> released by an alarm handler. The tasks does nothing else but waiting
> (in a loop) on the semaphore. If the task can immediately take=20
> the sempahore, it means that the rate is too fast for it because
> the semaphore has been released before the end of its current iteration=
=2E

Some more efficient way is to let the thread monitor its execution time
and derive the next wakeup date from it. Think of:

next_wakeup =3D now();
do_forever
	next_wakeup +=3D period;
	do_some_rt_job();
	if next_wakeup >=3D now() then
		handle_overload()
	sleep_until(next_wakeup)

Jan


--------------enig1EFE221DE691EA86AD73DC24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHKbD4niDOoMHTA+kRAkq0AJ49nCdz37d/45aW2KeNnoKGIK3trACfbHEg
PdJe4Q/GivGlpQdWJQb6Gok=
=gLS8
-----END PGP SIGNATURE-----

--------------enig1EFE221DE691EA86AD73DC24--

