Message-ID: <44E41C7C.4010008@domain.hid>
Date: Thu, 17 Aug 2006 09:36:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with installation
References: <20060816190510.20935.qmail@domain.hid>	<44E36F6A.7060004@domain.hid>	<200608162137.09103.nicola17@domain.hid>
	<44E37823.8080407@domain.hid>
	<33646.155.98.4.150.1155767832.squirrel@domain.hid>
In-Reply-To: <33646.155.98.4.150.1155767832.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAFCDD6BD31CCBB6E8CFBD94D"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFCDD6BD31CCBB6E8CFBD94D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
> So, perhaps I spoke too soon.  The system does boot, but I just looked =
in
> the syslog and found this:
>=20
> 16 16:08:49 dewback kernel: [4294670.201000] I-pipe: Domain Xenomai
> registered.
> Aug 16 16:08:49 dewback kernel: [4294670.201000] Xenomai: hal/x86 start=
ed.
> Aug 16 16:08:49 dewback kernel: [4294670.231000] Xenomai: real-time
> nucleus v2.2 (Engines Of Creation) loaded.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting nati=
ve
> API services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting POSI=
X
> services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting RTDM=

> services.
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: incompatible
> timer mode (aperiodic found, need periodic).
> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: VxWorks skin
> init failed, code -16.
>=20
> my .config is attached.  As far as I can tell, my timer is periodic and=

> not aperiodic.  My kernel is 2.6.16 patched with xenomai-2.2.0 from the=

> download page and not the trunk.

Are you sure the attached config matches the real system? It has the
timer tick set to 1 ns(!), so your box should rather lock up on boot.

Jan


--------------enigAFCDD6BD31CCBB6E8CFBD94D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5Bx/niDOoMHTA+kRAj/mAJ9Pt13JLyjeCOBph5n3UnhpE2BXLwCcDeC6
6b7BnrOeJRqUTopA+WJfTnQ=
=qtyx
-----END PGP SIGNATURE-----

--------------enigAFCDD6BD31CCBB6E8CFBD94D--

