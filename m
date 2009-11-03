Message-ID: <4AEFEAB5.4050007@domain.hid>
Date: Tue, 03 Nov 2009 09:32:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AED83C0.8050002@domain.hid> <4AEE9067.5050904@domain.hid>
	<4AEF0E04.3070902@domain.hid>
In-Reply-To: <4AEF0E04.3070902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA3EA555DF2FE8A606995159"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Two real time NICs in same PC? (RTnet)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA3EA555DF2FE8A606995159
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Benjamin Biegel wrote:
> Thanks!
>=20
> I can see in the source that the capture stamping uses the rtdm_clock_r=
ead().
>=20
> When several PCs are on the same RTnet, they get synchronized due to th=
e TDMA.=20
> But what clock is it that is synchronized on the PCs? How do I read and=
 use this=20
> clock? What file can i see this in?

Check examples/xenomai/native/tdma-api.c.

>=20
> Would it be possible to stamp received frames through this synchronized=
 clock=20
> instead of the system clock?

No, but you could do the calculation afterwards.

Jan


--------------enigFA3EA555DF2FE8A606995159
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrv6rUACgkQitSsb3rl5xQouACguJrB3u3UvdzqTjzcFmc1nzPU
eCQAn2CvvXJlbbXfIUI9OCPCQrvJCpO6
=ZMiA
-----END PGP SIGNATURE-----

--------------enigFA3EA555DF2FE8A606995159--

