Message-ID: <46ADD7D7.8070901@domain.hid>
Date: Mon, 30 Jul 2007 14:21:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1185718809.11350.110.camel@domain.hid>
In-Reply-To: <1185718809.11350.110.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig81AC0941DDB2E62316AB4F2E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Xenomai v2.4-rc1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81AC0941DDB2E62316AB4F2E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> 	[rtdm]
>=20
> 	* Various fixes and updates.

A bit more details:
	* Automatic file descriptor cleanup on process termination
	* RTDM API revision 6:
	  - Timer abstraction
	  - Monotonic time base support
	  - IOCTL prototype fix for 64-bit platforms
	  - Enhancements/changes of rtdm_irq_request, rtdm_nrtsig
	    handler, and more (see ksrc/skins/rtdm/API.CHANGES)

Jan


--------------enig81AC0941DDB2E62316AB4F2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrdfXniDOoMHTA+kRApy+AJ91tYu71/G+3lkj9AqIFMeTo5epOQCfejCc
OwkHTjOWlCg6yQYYXnNrxwI=
=KrAR
-----END PGP SIGNATURE-----

--------------enig81AC0941DDB2E62316AB4F2E--

