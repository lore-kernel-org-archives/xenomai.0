Message-ID: <46684CCB.8010806@domain.hid>
Date: Thu, 07 Jun 2007 20:22:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200706071049.32906.ngustavson@domain.hid>	<1181235786.4998.108.camel@domain.hid>	<1181236746.4998.122.camel@domain.hid>
	<200706071311.09891.ngustavson@domain.hid>
In-Reply-To: <200706071311.09891.ngustavson@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig417F696C1244AF16DCC9B0A7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot allocate
 memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417F696C1244AF16DCC9B0A7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

NZG wrote:
> Write does stop throwing errors with a pool of 16384.

Just repeating for confirmation: rt_pipe_create with smaller, but
non-zero pool sizes doesn't report some error? Actually, the
rt_pipe_create code looks like it tries to round up appropriately. Then
something's still fishy.

>=20
> Still not receiving in the real time task though,=20
> I'll bang on it for a while to make sure it's not a PBKAC.

Pipes are asymmetric: RT<->NRT only. Use rt_queue for inter-RT
communication.

Jan


--------------enig417F696C1244AF16DCC9B0A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaEzLniDOoMHTA+kRAqmuAJ0VGOR5agCFRYgnwUbRqitaP2acXwCeLSmf
uQabtCm0LWrhhlO82BvNK7s=
=sd4u
-----END PGP SIGNATURE-----

--------------enig417F696C1244AF16DCC9B0A7--

