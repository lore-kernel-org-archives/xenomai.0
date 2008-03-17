Message-ID: <47DEB97C.6090705@domain.hid>
Date: Mon, 17 Mar 2008 19:33:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.129.1205578873.27060.xenomai@xenomai.org>
	<000001c887bb$dc7999d0$956ccd70$@edu>
In-Reply-To: <000001c887bb$dc7999d0$956ccd70$@edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1BD53CF9DC1534264D0E9846"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RT-FireWire] Was RT-FireWire project finished?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ??? <lordpark@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BD53CF9DC1534264D0E9846
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

??? wrote:
> Hello.
>=20
> I want to communicating two systems via ieee1394.
> So, I tried to install RT-FireWire-0.1 on my system, but I couldn't.
> Because the xeno-config file's option was changed after xenomai-2.0.
> RT-FireWire-0.1 didn't update after that, it makes problem.
> To solve this problem, I have to change configure file.
> But, I don't know where I have to change exactly.
> Please, help me ^^.

The code you find in RT-Firewire's SVN repository may behave a bit=20
better, but will still break when loading rt_serv. Known issue, someone=20
has to fix it. :-/

>=20
> Ah, one more thing..
> RTnet support Ethernet over RT-Firewire.=20
> If I want to this function, do I have to install RT-Firewire first?
> Or Does RTnet provide RT-Firewire driver in their package?

Nope, RTnet only provides the rt_ieee1394 high-level driver on top of=20
RT-Firewire.

Jan


--------------enig1BD53CF9DC1534264D0E9846
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH3rl9niDOoMHTA+kRAvF4AJ0Sa1vU7q8N0fhkwGo9MpVZdsCQCACffSSc
PIELnQDhDh3+8JhzB/MJnjY=
=cki+
-----END PGP SIGNATURE-----

--------------enig1BD53CF9DC1534264D0E9846--

