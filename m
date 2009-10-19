Message-ID: <4ADCB9BF.5090604@domain.hid>
Date: Mon, 19 Oct 2009 21:10:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>	<20091019171611.3332.58812.stgit@domain.hid>
	<4ADCAB36.8080103@domain.hid>
In-Reply-To: <4ADCAB36.8080103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig56A0D8C2130B3E045A53277A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v2 1/3] nucleus: Use Linux spin lock for
	heap list management
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56A0D8C2130B3E045A53277A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> No need for hard nklock protection of kheapq and the map counter, a
>> normal spin lock suffices as all users must run over the root thread
>> anyway.
>=20
> At the very least, this should use rthal_spin_lock, in order to seem to=

> respect the layering.

Then the conversion would make no sense (hard interrupt lock again).
Given that we are fiddling with Linux mm directly here, there is no hal
involved.

>=20
> Anyway, do we really want to change this now?
>=20

That's a different question. The patch alone does not buy us that much
when we cannot reuse the lock for the heapq.

Jan

PS: More invasive changes will come anyway to plug cleanup races in the
heap code.


--------------enig56A0D8C2130B3E045A53277A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrcub8ACgkQitSsb3rl5xQ55ACfQ8O3TVQNCFXFghewQpZKryWY
IGIAn3Ie2diXeUoCCZokqrK5AldbDG+P
=k+/A
-----END PGP SIGNATURE-----

--------------enig56A0D8C2130B3E045A53277A--

