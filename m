Message-ID: <4410911F.4070507@domain.hid>
Date: Thu, 09 Mar 2006 21:33:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
In-Reply-To: <200603091443.25714.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD0534B202E7301BF3CE8442"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD0534B202E7301BF3CE8442
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan,
>=20
> I'm still concerned about the future of RTDM and timer functions. I thi=
nk=20
> there should be some function for starting the timer manually, since th=
e=20
> automatic feature don't work great for RTDM drivers.
>=20
> It is not nice to have to run the latency (or any other) program for st=
arting=20
> the timer before I can load my driver. And it is not suffice to run it =
once I=20
> booted. After I open/close my rtdm device and reload my driver the prob=
lem=20
> will occur again and I'll have to re-run the latency program.
>=20

Sorry I don't see the problem here.

# modprobe xeno_nucleus; cat /proc/xenomai/timer
status=3Doff:setup=3D1392:tickval=3D0:jiffies=3D0

# modprobe xeno_rtdm; cat /proc/xenomai/timer
status=3Doneshot:setup=3D1392:tickval=3D1:jiffies=3D8113917792696

So the timer is running right since when rtdm is loaded?!

And that simple heartbeat rtdm example on my rt-addon homepage now
cleanly runs even without any further helper to start some timer.

> Do you have any plans to correct this undesirable behaviour?
>=20
> I don't even have an idea why the timer stops once it is started... Act=
ually=20
> I'm not sure why does rtdm_clock_read should depend on the xenomai time=
r. At=20
> least, I think there should be a note in the rtdm_clock_read documentat=
ion=20
> stating that it only works after the timer has been started.
>=20
> Best Regards,
>=20
> Rodrigo.
>=20

Jan


--------------enigAD0534B202E7301BF3CE8442
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEJEfniDOoMHTA+kRAlzsAJ9BFor2R1rz6Rx3JyKGJ9C4bafy+QCfbuuI
wsUrsbogkhn1vZdyhiRZYnc=
=Yple
-----END PGP SIGNATURE-----

--------------enigAD0534B202E7301BF3CE8442--

