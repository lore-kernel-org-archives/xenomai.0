Message-ID: <44F33C91.50505@domain.hid>
Date: Mon, 28 Aug 2006 20:57:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Access to a pci device mem and io address
References: <44F33AF2.80208@domain.hid>
In-Reply-To: <44F33AF2.80208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F9506B68F7CB9A102C72B94"
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
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F9506B68F7CB9A102C72B94
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Hi!
>=20
>=20
> I'm using RTDM to develop a Real-Time driver. In this driver i need to
> access a certain I/O address of the pci card. Is this done by the
> rtdm_dev_register or should i use the linux pci_register way?
>=20

So far you have to use the normal Linux services for this, RTDM does not
abstract this interface (yet).

>=20
> Thanks for the help!
> DISCLAIMER: This message may contain confidential information or
> privileged material and is intended only for the individual(s) named. I=
f
> you are not a named addressee and mistakenly received this message you
> should not copy or otherwise disseminate it: please delete this e-mail
> from your system and notify the sender immediately. E-mail transmission=
s
> are not guaranteed to be secure or error-free as information could be
> intercepted, corrupted, lost, destroyed, arrive late or incomplete or
> contain viruses. Therefore, the sender does not accept liability for an=
y
> errors or omissions in the contents of this message that arise as a
> result of e-mail transmissions. Please request a hard copy version if
> verification is required. Critical Software, SA.
>=20

[Mmh, this footer gets even more annoying when it's larger than the rest
of the mail...]

Jan


--------------enig6F9506B68F7CB9A102C72B94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE8zyRniDOoMHTA+kRAjs5AJ4/0ncByWdC0SKu1ts5uFtw7PG44ACfdJzl
GJWKZDPXyn2kHDBIyL1jRvk=
=1NMh
-----END PGP SIGNATURE-----

--------------enig6F9506B68F7CB9A102C72B94--

