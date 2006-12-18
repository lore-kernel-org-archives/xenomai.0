Message-ID: <4586A506.7050906@domain.hid>
Date: Mon, 18 Dec 2006 15:26:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai: Kernel 2.6.19.1
References: <10606813.1166451623805.JavaMail.ngmail@domain.hid>
In-Reply-To: <10606813.1166451623805.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A55D2F1BF039C558902CC7D"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A55D2F1BF039C558902CC7D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I tried disabling SMP - but no success...

Means the problem persists under UP?

> Unfortuantely, the SMI watchdog does not work on my machine.
> After booting the PC, dmesg shows me the line
> Xenomai: NMI watchdog not available.
>=20
> Is the NMI watchdog support somehow configurable or is this a real hard=
ware issue?

nmi_watchdog=3D1, a kernel parameter. You should also find Linux related
messages regard the NMI watchdog in your log.

>=20
> For patching the kernel, I used the adeos-ipipe-2.6.19-i386-1.6-02.patc=
h which is
> part of Xenomai.
>=20
> As I do not see an easy way to get the 2.6.19.* running,  I think, I wi=
ll switch back to=20
> the latest 2.6.17.* kernel (2.6.17.14) which works fine.

Well, I can understand stand you are looking for a stable version now.
But please also understand that we are highly interested in nailing down
this potential bug, specifically as Xenomai 2.3 with .19 support is
waiting at the door.

Jan


--------------enig0A55D2F1BF039C558902CC7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhqUGniDOoMHTA+kRAk6rAKCEACybju9Re0cv5rGf0fMD/0hMqQCeLCf5
sblVoTmBeoy2G8HAVigf7MA=
=hUbS
-----END PGP SIGNATURE-----

--------------enig0A55D2F1BF039C558902CC7D--

