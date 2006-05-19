Message-ID: <446D7DE6.10402@domain.hid>
Date: Fri, 19 May 2006 10:12:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
References: 446C264A.7040206@domain.hid>
	<200605181426.8240@domain.hid>	<446C6C1C.2010902@domain.hid>
	<200605190943.31667@domain.hid>
In-Reply-To: <200605190943.31667@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39EBA3C861ACFC26463FB7D5"
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39EBA3C861ACFC26463FB7D5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> Hi,
> When I try to run realtime application under lesser than root rights, I=
 get this strange error:
> Xenomai: binding failed: Operation not permitted.
>=20
> Error showed after kernel update 2.6.15.6 -> 2.6.16.16 and xenomai upda=
te 2.1.1 -> daily snapshot (2006/05/18)
> Changing of the rights of the /dev/rt* dousn't help.
>=20
> Any suggestions?
>=20

That's intended. Real-time means real power, so all skin syscalls now
require root privileges (more precisely CAP_SYS_NICE). This can be
switched off, but standard syscalls like mlockall may still demand root
power (mlock'ing is at least size-limited for normal users on recent
kernels). And with current real-time APIs, it makes no sense anyway to
restrict the real-time user's permission by turning his account into a
non-root one.

Jan


--------------enig39EBA3C861ACFC26463FB7D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbX3mniDOoMHTA+kRAsaGAJ4m8Bzw8qQI/IoiXdSHj7kXv1z9SwCfVbVA
G3hSNCDIKtlg3rMSkNpcKjI=
=58nj
-----END PGP SIGNATURE-----

--------------enig39EBA3C861ACFC26463FB7D5--

