Message-ID: <45E7F6CE.5060102@domain.hid>
Date: Fri, 02 Mar 2007 11:05:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] can getstate
References: <45E80379.6000502@domain.hid>
In-Reply-To: <45E80379.6000502@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04C25E3420C58D4071B075CE"
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
To: =?ISO-8859-15?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04C25E3420C58D4071B075CE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

St=E9phane ANCELOT wrote:
> Hi,
> Can somebody provide me with a programming example on how to retrieve
> state using rt_dev_ioctl .

What state? The state of a CAN controller, ie. the following IOCTL?

http://www.rts.uni-hannover.de/xenomai/lxr/source/include/rtdm/rtcan.h?a=3D=
i386#824

Jan


--------------enig04C25E3420C58D4071B075CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5/bRniDOoMHTA+kRAk6dAJ4pMnQqQPXiwAz80gnjhUhQ9sv+fQCfTx2p
ZNVZEABP18fgZOWkHH+8i9U=
=UxSF
-----END PGP SIGNATURE-----

--------------enig04C25E3420C58D4071B075CE--

