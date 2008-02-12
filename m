Message-ID: <47B14FF9.8010207@domain.hid>
Date: Tue, 12 Feb 2008 08:51:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF71DB867E9F4E78081DBDAD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] pit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF71DB867E9F4E78081DBDAD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> I compiled the kernel for 586 and am running the PIT timer. I still get=

> the 17000-18000 context switches per second, and now the irq0 handler i=
s
> taking up 11% of the CPU instead of only 5% when the two 8000Hz tasks
> are loaded but delayed on events. I think that the problem isn't with
> pit, but with the tasks being periodic even though they are blocked.=20

That makes sense: Periodic timers keep on firing. That would explain up=20
to 16000 IRQ invocations per second. And the other 1000-2000 come from=20
Linux?

As suggested earlier: you can reduce the number of IRQ events by basing=20
your periodic tasks on the same start date. Then both will be woken up=20
at the same times and their priority will decide about the execution orde=
r.

>=20
> Running in PIT mode with periodic timing on uses only 9.5% of the CPU. =
I
> show about 9000 context switches per second. (the 2 8000 hz tasks and
> the 1000 hz linux interrupt.)

Do you need Linux at 1 KHz? You may even want to try NO_HZ.

>=20
> With periodic timing, it's 5.4% when the tasks idle and about 9000
> context switches a second. When one of them becomes active, the irq0
> handler is using 10% of the CPU and the sound task is using about 8%.
> These are two kernel tasks.
>=20
> =20
>=20
> Userspace stack size is set to 64k. I forgot to mention this to Philipp=
e
> earlier.
>=20
> =20
>=20
> Perhaps the problem is the overhead that the timer handler introduces
> being able to support multiple skins with individual timebases. It
> sounds like in order to save some cpu cycles, I may want to turn off
> periodicity while threads are idle and also avoid setting threads
> periodic when they can be driven some other way.=20

I'm still wondering with what older numbers you compare all the nice=20
stats you now generate. Neither older Xenomai nor RTAI provide=20
comparable statistics. Are we doing fair comparisons here?

Jan


--------------enigBF71DB867E9F4E78081DBDAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsU/5niDOoMHTA+kRAn9iAJ4umUzkX7fls5cENiUVFJN5/fpo+ACfZnBj
qn8yHJdzCNan1OsyzH/ihoA=
=xOJM
-----END PGP SIGNATURE-----

--------------enigBF71DB867E9F4E78081DBDAD--

