Message-ID: <44488A37.80700@domain.hid>
Date: Fri, 21 Apr 2006 09:31:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: RE : [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
References: <FDBBB5CC70676540B3EF7CFE83FD94E0043151@domain.hid>	<44478FFE.2050608@domain.hid>
	<4447AA62.6080506@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0043154@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0043154@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD38563B3F3F7616744C645C8"
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD38563B3F3F7616744C645C8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Hi Marco,
>=20
> Two of our soft/hard engineers (S=E9bastien Gerber & Guillaume
> Boutillier) have worked quite a lot over these last 6 months for this
> port.
> These last weeks, they spent much work on measuring the response time
> (by means of a digital analyzer) and trying to move some piece of
> code and re-work out a bit the current patch in order to make the IRQ
> virtualization as clean as possible and to get very low latency.
> Thanks to them :-)
>=20

I guess this significant effort was related to the fact that you were
hunting nanoseconds, aren't you? Well, that's great! Can we hire you for
other archs as well? ;) [I also have some weird ideas regarding
micro-optimisations of the user space interface.]

Jan


--------------enigD38563B3F3F7616744C645C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESIo3niDOoMHTA+kRAtnwAJ46LlO6+K7cUvg+rae+LBhl8UDspQCdFixA
V0XU75sNMTD48QfjqseJQgE=
=F0OD
-----END PGP SIGNATURE-----

--------------enigD38563B3F3F7616744C645C8--

