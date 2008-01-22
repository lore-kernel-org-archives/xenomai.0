Message-ID: <4796458F.4060501@domain.hid>
Date: Tue, 22 Jan 2008 20:35:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C4101746604@domain.hid>
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C4101746604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95DB232FCF5486DD8247CCF0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95DB232FCF5486DD8247CCF0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Kyle Howell wrote:
> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an x86_64 (Core2)
> system. I'm finding that all of my CPU cycles are being accounted as
> kernel time rather than user time. The correct processes are still
> billed, but the system is always 0% user. I'm wondering if this problem=

> is specific to my setup, or if it is a real bug. Can anyone else out
> there running x86_64 confirm or deny this behavior?

That bug should have been fixed by [1]. Already updated your ipipe=20
patch? This one [2] also includes your recently posted fix.

Jan

[1]http://www.denx.de/cgi-bin/gitweb.cgi?p=3Dipipe-2.6.git;a=3Dcommit;h=3D=
4c032019077eb75cb6c4ec13dfc9dcc7cd000430
[2]http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.23-x=
86_64-1.4-02.patch


--------------enig95DB232FCF5486DD8247CCF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHlkWQniDOoMHTA+kRAjrGAJ0fNKJZLmTvs7gSnju1+Cf1/IfezQCggVYk
VKihBd9ucWNAhgP49+S0wvc=
=h22i
-----END PGP SIGNATURE-----

--------------enig95DB232FCF5486DD8247CCF0--

