Message-ID: <468CDB6E.7060605@domain.hid>
Date: Thu, 05 Jul 2007 13:52:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e2ceda030707050324je992c01lfb97592b00ef317a@domain.hid>
In-Reply-To: <e2ceda030707050324je992c01lfb97592b00ef317a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA22CCF52F33EC720A70DD8B2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] request_region from rtdm_task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maciek Godek <pstrychuj@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA22CCF52F33EC720A70DD8B2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Maciek Godek wrote:
> Hi,
>=20
> is it OK to call function request_region from kernel rtdm task?

Generally, you have to review each Linux service you call from RT
context /wrt determinism and locking issues. And often this analysis is
kernel release-dependent. So, better avoid this. This is even more
unneeded when service like this one aim at the driver initialisation,
not at its operation mode.

>=20
> or, should there be any problems when using io ports in rtdm task from
> range requested in non-rt kernel thread?

request_region does not track the calling process implicitly. All it
saves is the arbitrary name you passed. So, yes, you can call it safely
during the usual, non-RT driver initialisation and simply use the ports
later on in RT context. You could even play roulette and skin
request_region, but that would be error-prone or at least bad style (for
any kind of Linux driver).

Jan


--------------enigA22CCF52F33EC720A70DD8B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGjNtuniDOoMHTA+kRAnb/AKCEBYialkiHHC00OaSCDiHGLXtvLQCeNU+l
smTfucVshNioJM1ym+BYUQk=
=tUXc
-----END PGP SIGNATURE-----

--------------enigA22CCF52F33EC720A70DD8B2--

