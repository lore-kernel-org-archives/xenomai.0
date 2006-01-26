Message-ID: <43D8F462.2090100@domain.hid>
Date: Thu, 26 Jan 2006 17:10:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Sigevent, sigaction
References: <353F6272FE0A6544AA97D47F761F486B01707E91@domain.hid>
In-Reply-To: <353F6272FE0A6544AA97D47F761F486B01707E91@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB921B1184C6C07B0F74DF860"
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
To: "Doyle, Alan" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB921B1184C6C07B0F74DF860
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Doyle, Alan wrote:
> I've downloaded Xenomai-2.0.3 and have been lookingh into signal
> handling. Structs sigevent & sigaction are used in the code but I can't=

> find where they are declared. Can anyone help ?

Maybe browsing for them (identifier or full-text search) on this site
helps you (I do not understand yet what you are precisely looking for):

http://www.rts.uni-hannover.de/xenomai/lxr

Note that hart-RT signals are not yet supported in user space. RT user
space threads can only receive Linux signals, which will switch the
threads to secondary (non-deterministic) mode.

Jan


--------------enigB921B1184C6C07B0F74DF860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD2PRiniDOoMHTA+kRAn9sAJ9fIJJyy3eVDCghvvde/D85KerMvgCdFlwz
jPPbnVGxp7WGr0g1CwVcAp0=
=txo+
-----END PGP SIGNATURE-----

--------------enigB921B1184C6C07B0F74DF860--

