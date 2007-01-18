Message-ID: <45AEBEA9.6030801@domain.hid>
Date: Thu, 18 Jan 2007 01:26:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PPC405: DMA-Problem with OCM (interrupt-example)
References: <200701172333.25574.niklaus.giger@domain.hid>
In-Reply-To: <200701172333.25574.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD203F6A96968328386127B2"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD203F6A96968328386127B2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> ...
> Is the example code otherwise good enough to be accepted as an example =
how to=20
> attach a interrupt?

Can't help with your core issue, but I can comment on the IRQ code:

Please use RTDM for in-kernel demos like this. Unless you embed the IRQ
handling into an application directly, RTDM is the preferred way to go -
as you are then designing a driver.

When porting to RTDM, watch out for the latest change I just checked in:
there is now no need to enable an IRQ line explicitly after requesting it=
=2E

Jan


--------------enigAD203F6A96968328386127B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFrr6sniDOoMHTA+kRAsDyAJ98S8t7wDbi9wg1/bWJijE3qoIiPwCdGW4c
sUt9gOzbPgUFBlAodPPibxo=
=CfQb
-----END PGP SIGNATURE-----

--------------enigAD203F6A96968328386127B2--

