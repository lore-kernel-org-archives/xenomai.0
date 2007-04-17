Message-ID: <4624D71E.3040008@domain.hid>
Date: Tue, 17 Apr 2007 16:18:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA327C38E917FD6E639BDBD2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Perfs and rt alarms questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA327C38E917FD6E639BDBD2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
> Hello everybody.
>=20
> I managed to compile a stable kernel (the Scalability O(1) scheduler op=
tions seems to make my system freeze)

That's not good. What precisely did you do? Applied the .config you
posted, just enabling CONFIG_XENO_OPT_SCALABLE_SCHED? And what test
case, latency?

> xenomai 2.3.1 and vanilla 2.6.20.4, gcc 4.1.1 on FC6.
>=20
> I'm programming and testing a xenomai support for a timer library using=
 rt_alarm. The test program
> lauches the timer periodically and calculate the precision (difference =
between theoretical and practical results).
>=20
> When I launch the latency test, the max latency I have doesn't exceed 1=
0us. So I supposed the precision shouldn't=20

Using what load for the system? Keep in mind that unloaded benchmark
numbers are practically meaningless.

> exceed 10 to 20us as well, No ? But sometimes, the precision exceed 30 =
to 60us. Is it normal ?

Depending on your hardware (CPU, chipset, peripherals), this can be very
well a worst-case latency of the loaded system. Try to capture such a
result with the tracer (you may put your own xntrace_user_freeze() calls
into your timer lib).

> Something wrong in the way I use rt alarms ? in the kernel configuratio=
n ?
>=20
> I attach :=20
> 	- .config
> 	- tests results with overtime with this actual config
> 	- tests results without overtime I had with an old config (unfortunate=
ly I cannot restore it). The precision was less than=20
> 		8us, I didn't enable xeno debug option. I haven't managed to get such=
 high precision since I recompiled my kernel.
> 	- test program test_stability_trace.c
> 	- xenomai timer library support implementation support_xenomai.c
>=20
> Thanks in advance.
>=20
> Niry.
>=20

Jan


--------------enigFA327C38E917FD6E639BDBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJNcjniDOoMHTA+kRAmf3AJ46yVh7dNXWFUkwjc45cC93b5sVFgCfRWYu
i3IpyghMaWLJMlG+FySSNts=
=jy74
-----END PGP SIGNATURE-----

--------------enigFA327C38E917FD6E639BDBD2--

