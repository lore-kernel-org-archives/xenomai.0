Message-ID: <4723122D.3070002@domain.hid>
Date: Sat, 27 Oct 2007 12:25:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472112E2.90008@domain.hid>
In-Reply-To: <472112E2.90008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4D8BF302F10498258F4C99D9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-test failed to open benchmark device,
 code -19 at t1 and t2 # latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D8BF302F10498258F4C99D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> Hi,
>=20
> I built 2.6.22.10 linux kernel -i386 with xenomai 2.4-rc4 and
> adeos-ipipe-2.6.22-i386-1.10-09.patch.
>=20
> I checked enable SMI workaround, uncheck frequency scaling, uncheck ACP=
I
> and uncheck APM.
>=20
> I ran xeno-test and get the following failed message:
>=20
> Thu Oct 25 13:17:02 PDT 2007
> running: ./run -- -sh -T 120 -t1 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> latency: failed to open benchmark device, code -19
> (modprobe xeno_timerbench?)
>=20
> Thu Oct 25 13:17:04 PDT 2007
> running: ./run -- -sh -T 120 -t2 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> latency: failed to open benchmark device, code -19
> (modprobe xeno_timerbench?)
>=20
> Could you help me to solve the issue?

What does the kernel log say (=3D>dmesg) when you manually insert the
module (=3D>modprobe xeno_timerbench)? Do you still have versioning
conflicts with your modules (as reported on rtnet-users)?

Jan


--------------enig4D8BF302F10498258F4C99D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIxItniDOoMHTA+kRAlrjAJ0UlqafBrwdI+M/niJHe1PficF/oQCePa9h
GrBhLXnNgLbwSfZ1ZTARM5Y=
=U66M
-----END PGP SIGNATURE-----

--------------enig4D8BF302F10498258F4C99D9--

