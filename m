Message-ID: <4ADCBB59.5020308@domain.hid>
Date: Mon, 19 Oct 2009 21:17:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>	<20091019171611.3332.58812.stgit@domain.hid>
	<4ADCAB36.8080103@domain.hid> <4ADCB9BF.5090604@domain.hid>
In-Reply-To: <4ADCB9BF.5090604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig18E847220A92F33C5EF1107F"
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
--------------enig18E847220A92F33C5EF1107F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> No need for hard nklock protection of kheapq and the map counter, a
>>> normal spin lock suffices as all users must run over the root thread
>>> anyway.
>> At the very least, this should use rthal_spin_lock, in order to seem t=
o
>> respect the layering.
>=20
> Then the conversion would make no sense (hard interrupt lock again).
> Given that we are fiddling with Linux mm directly here, there is no hal=

> involved.
>=20
>> Anyway, do we really want to change this now?
>>
>=20
> That's a different question. The patch alone does not buy us that much
> when we cannot reuse the lock for the heapq.

Wait, there is one advantage: We no longer have to walk kheapq under
nklock in __validate_heap_addr. I think that makes this patch
worthwhile. Will adapt it to avoid conflicts with the simulator.

>=20
> Jan
>=20
> PS: More invasive changes will come anyway to plug cleanup races in the=

> heap code.
>=20

Jan


--------------enig18E847220A92F33C5EF1107F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrcu1kACgkQitSsb3rl5xR7RACfYw9ujXjNFNWecq7UrVSkr3vo
h6cAoIBILMpgLlLdpJySl5TFMqj2KN/Y
=k00R
-----END PGP SIGNATURE-----

--------------enig18E847220A92F33C5EF1107F--

