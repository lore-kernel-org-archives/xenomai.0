Message-ID: <455B916F.3060104@domain.hid>
Date: Wed, 15 Nov 2006 23:15:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange problem with multiport serail board
References: <BAY101-F7AE73C8953CF7C39ABE00E2F40@domain.hid>
In-Reply-To: <BAY101-F7AE73C8953CF7C39ABE00E2F40@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB9BE77A20B3DD34251408C10"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marco Rossi <cicciobombo123@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9BE77A20B3DD34251408C10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marco Rossi wrote:
> Hi every body,  I'have a strange problem using a multiport serial board=

> connected with the PCI bus: when I read from the ports all work  ok but=

> I can't write in anyone of the extension port. The problem occurs only
> with the ports of the extension board, whith standard serial port all
> works ok.  The problem occurs both with RTDM driver of Xenomai and
> standard linux drivers.
> The operanting system used is Debian sarge 3.1, kernel 2.6.17,
> Xenomai-2.2.4. The PC is an EPIA TC Mini-ITX and the multiport board is=

> a NetMos Technology PCI 9835 Multi-I/O.
> Had someone similar probles or any idea to resolve the problem?

If the problem exists with the original Linux driver as well (which one
is it precisely?), you may discuss this on the Linux kernel mailing list
or (if it exists) on the related subsystem list first (see
linux/MAINTAINERS for who's behind that driver and where to post to).

Anyway, also worth a try is to check the card in some different PC.
Maybe it's the combination what causes troubles here.

Jan


--------------enigB9BE77A20B3DD34251408C10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFW5FvniDOoMHTA+kRAhBwAKCE9ti1Q1ZxMOIAd9lILNAiFmcEfQCfeywZ
UcGAC2zP2SSRmpRvDQqEL9Y=
=U/RL
-----END PGP SIGNATURE-----

--------------enigB9BE77A20B3DD34251408C10--

