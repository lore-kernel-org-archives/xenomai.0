Message-ID: <440AF8EF.3010707@domain.hid>
Date: Sun, 05 Mar 2006 15:42:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1-rc4 RTDM bug
References: <4409E37A.6090300@domain.hid> <4409E59E.50305@domain.hid>
In-Reply-To: <4409E59E.50305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEBEB1F95F1D7A4715FC862C6"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBEB1F95F1D7A4715FC862C6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Hannes Mayer wrote:
>> Ciao Jan!
>>
>> It doesn't seem to make a difference if one uses
>> RTDM_IRQ_NONE or RTDM_IRQ_HANDLED.
>> With RTDM_IRQ_NONE the IRQ should be passed to linux,
>> right ? But it doesn't seem to happen - this brought
>> up the "top" problem I've posted a few days ago.
>=20
> Returning XN_ISR_PROPAGATE passes the grabbed timer
> interrupt to Linux and "top" works again.
>=20

As forwarding interrupts to the non-realtime domain is not a common
use-case of realtime device drivers, I decided to drop the propagation
support at RTDM level. So if you are including this mechanism in your
demo, please mark this pattern as something RTDM drivers should normally
NOT do (and explain what's reason for it here).

Jan


--------------enigEBEB1F95F1D7A4715FC862C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFECvjzniDOoMHTA+kRAvFXAJwMZ7/tQbGaQQc5ZEG+YAM0plwX7ACdHbt2
vqte3RHywVZvo3HQNM/RfDw=
=+sUD
-----END PGP SIGNATURE-----

--------------enigEBEB1F95F1D7A4715FC862C6--

