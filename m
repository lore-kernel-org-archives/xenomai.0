Message-ID: <44B2216A.1060904@domain.hid>
Date: Mon, 10 Jul 2006 11:44:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B1FDBD.4060600@domain.hid>	
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>	
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
In-Reply-To: <4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4ED7B0333582CFBE1D6A6F0D"
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4ED7B0333582CFBE1D6A6F0D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> I searched the web and find these RTDM sample drivers (Thanks for the
> contributors):
>=20
> In Xenomai src tree: ksrc/drivers/16550A/16550A.c

Also check the drivers/testing in recent Xenomai.

> http://www.captain.at/xenomai-real-time-driver-example.php
> http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/
> http://www.captain.at/xenomai-serial-port-example.php

The last two are usage examples, not drivers. But RTnet is indeed
another, more complex example, see these parts:

http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/packet/af_packet.c
http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/ipv4
http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/rtmac/tdma/tdma_dev=
=2Ec

>=20
> Just wondering are there more samples?

http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver
http://www.rts.uni-hannover.de/rtaddon
http://developer.berlios.de/projects/usb4rt
http://developer.berlios.de/projects/rtfirewire (only as API user, not
    as RTDM device provider)

And a full CAN stack is on the way, may show up on the list this week.
Hope I'm not forgetting anything right now.

Jan


--------------enig4ED7B0333582CFBE1D6A6F0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsiFqniDOoMHTA+kRAq92AJ4juP/c3oku4b3vjbpqArgeePtT8gCeNaiG
iG1sm9+lSBBUzIJovfZaFLU=
=7njo
-----END PGP SIGNATURE-----

--------------enig4ED7B0333582CFBE1D6A6F0D--

