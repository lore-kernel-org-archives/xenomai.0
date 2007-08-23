Message-ID: <46CDEF25.2090400@domain.hid>
Date: Thu, 23 Aug 2007 22:33:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80708170409p7946b48fw4a18553d5e51da43@domain.hid>	
	<2ff1a98a0708170507u6906399dxfa47c704a12080cf@domain.hid>	
	<46C59858.7080309@domain.hid>
	<2862c2c80708230100n72fd7079u6fca56392c8bf284@domain.hid>
In-Reply-To: <2862c2c80708230100n72fd7079u6fca56392c8bf284@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2A5A8EEDBC52327737BCB13"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] I-pipe: Detected illicit call from domain
	'Xenomai'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>, rtnet-users <rtnet-users@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2A5A8EEDBC52327737BCB13
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yeoh Chun Yeow wrote:
> Dear all,
>=20
> I have ported the at91ether and it now works under RTnet. I would like =
to

Do you plan to post your changes? Would be great.

> use the networking stack in Linux, instead of RTnet stack. However, I h=
ave
> problem configure the VNIC with following errors:
>=20
> [root@domain.hid] ./rtping 172.16.6.174
> Real-time PING 172.16.6.174 56(84) bytes of data.
> 64 bytes from 172.16.6.174: icmp_seq=3D1 time=3D1186.7 us
> 64 bytes from 172.16.6.174: icmp_seq=3D2 time=3D1218.7 us
> 64 bytes from 172.16.6.174: icmp_seq=3D3 time=3D1178.7 us
> 64 bytes from 172.16.6.174: icmp_seq=3D4 time=3D1210.1 us
> 64 bytes from 172.16.6.174: icmp_seq=3D5 time=3D1182.4 us

Are these numbers over plain RTnet or with RTmac/TDMA active?

>=20
> --- 172.16.6.174 rtping statistics ---
> 5 packets transmitted, 5 received, 0% packet loss
> worst case rtt =3D 1218.7 us
> [root@domain.hid] ./rtifconfig
> rtlo      Medium: Local Loopback
>           IP address: 127.0.0.1
>           UP LOOPBACK RUNNING  MTU: 1500
>=20
> rteth0    Medium: Ethernet  Hardware address: 14:09:07:05:05:02
>           IP address: 172.16.6.203  Broadcast address: 172.16.6.255
>           UP BROADCAST RUNNING  MTU: 1500
>=20
> [root@domain.hid] ifconfig vnic0 up 172.16.6.203
> SIOCGIFFLAGS: No such device
> SIOCSIFADDR: No such device

See question above. How did you configure RTnet, only manually?

>=20
> Please help. Thanks.
>=20
> Regards,
> Chun Yeow
> P.S: Sorry for posting the RTnet issue here.

I added rtnet-users to CC. Please drop Xenomai on reply unless there is
some Xenomai-specific topic covered.

Jan


--------------enigA2A5A8EEDBC52327737BCB13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGze8lniDOoMHTA+kRAiZeAJ9TAdAuL7yWvkwWaRtfmQgI6SComQCfWcKE
bsmjc5cYWY/lc7jQ4f/TUwg=
=OJqp
-----END PGP SIGNATURE-----

--------------enigA2A5A8EEDBC52327737BCB13--

