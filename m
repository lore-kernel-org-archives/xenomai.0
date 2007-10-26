Message-ID: <47222C0E.50203@domain.hid>
Date: Fri, 26 Oct 2007 20:03:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47220255.4040309@domain.hid> <472220AD.6080402@domain.hid>
	<472229DF.4060700@domain.hid>
In-Reply-To: <472229DF.4060700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFCF54A3B8A6EBA99A5BB3833"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFCF54A3B8A6EBA99A5BB3833
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven A. Falco wrote:
> Hmmm.  IRQ4 is "PCI ExternalCommand Write"?  But I'm not using PCI.=20
> Here is the output:
>=20
> # ./irqloop
> NULL ->unmask handler, IRQ 4, chip <NULL>
> Test mode:    user-space task
> Port type:    serial
> Port address: 0x3f8
> Port IRQ:     4

Well, irqloop is preconfigured for boring x86 PCs, not thrilling PowerPC
platforms :). It assumes there is a 16550-based UART at the given
address using the given IRQ, but I would bet this doesn't apply to your
board. Please check doc/txt/irqbench.txt on the requirements.

What interface do you plan to use for the IRQ latency test? Maybe it is
possible to extend the benchmark driver.

Jan


--------------enigFCF54A3B8A6EBA99A5BB3833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIiwXniDOoMHTA+kRApE+AJsF5NXstpItgGGfeqdV5On1dXdR2gCfRgk0
2psgEb4FzxHTNUIF6eK0onw=
=JLo1
-----END PGP SIGNATURE-----

--------------enigFCF54A3B8A6EBA99A5BB3833--

