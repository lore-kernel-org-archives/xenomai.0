Message-ID: <43F21ED7.3030501@domain.hid>
Date: Tue, 14 Feb 2006 19:17:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
In-Reply-To: <fd6a47a90602141007g7830d31fu@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD48A3A652551F733E9BBD77E"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD48A3A652551F733E9BBD77E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
> One moment. I'm trying to locate rthal_disable_irq()...
>=20
>=20
>> Does calling rthal_disable_irq() instead of returning RTDM_IRQ_ENABLE,=
 but
>> rather
>> 0, prevents the freeze?
>>

Disable or enable (I guess the latter one)?

In either case, there are equivalent wrappers in RTDM:
rtdm_irq_enable/disable.

Jan


--------------enigD48A3A652551F733E9BBD77E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8h7XniDOoMHTA+kRAiRmAJ9Sbs2g1JVtytQUjfvb8yg5aQklngCaA1ur
aSgqnX5so2A8qehyT9At1AU=
=UfSY
-----END PGP SIGNATURE-----

--------------enigD48A3A652551F733E9BBD77E--

