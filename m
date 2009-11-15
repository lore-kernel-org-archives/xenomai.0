Message-ID: <4B002B59.90402@domain.hid>
Date: Sun, 15 Nov 2009 17:24:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid> <4AFD4C7F.1000106@domain.hid>
	<4AFD6013.9020608@domain.hid> <4AFE90A8.7090403@domain.hid>
	<4AFF363D.6020206@domain.hid>
In-Reply-To: <4AFF363D.6020206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDB1678A226133E5C47C641B9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB1678A226133E5C47C641B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Benjamin Biegel wrote:
> Again thanks!
>=20
> I will look into the RTnet isolation. How would you suggest I obtain kn=
owledge=20
> about multicore box etc?

linux/Documentation/cgroups/cpusets.txt and
linux/Documentation/IRQ-affinity.txt for the beginning. Xenomai manages
affinity via explicit API calls (not done by RTnet, though) or
/proc/xenomai/affinity.

>=20
> Just to explain the use of two NICs, if I can. The reason is that our g=
oal is to=20
> measure travel times on any Ethernet, without altering this Ethernet. T=
o do this=20
> we plug in two transparent y-splitters the two places we want to measur=
e at=20
> ravel time between (e.g. on either side of a switch). These two y-split=
ter=20
> outputs are fed to two NICs on each PC. They cannot be plugged into the=
 same NIC=20
> as the TDMA is on, then it would be through a switch, which would incre=
ase=20
> further delay as I see it...

I see, they are attached to quasi different Ethernets.

Jan


--------------enigDB1678A226133E5C47C641B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksAK2EACgkQitSsb3rl5xSV0ACgwQRmhRo0Li1M+lmKbR7HcWsU
sswAoNpM3J/kjIaKn9utMdhJQIS0n248
=KPq3
-----END PGP SIGNATURE-----

--------------enigDB1678A226133E5C47C641B9--

