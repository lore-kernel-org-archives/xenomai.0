Message-ID: <45DC509B.7040403@domain.hid>
Date: Wed, 21 Feb 2007 15:00:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>
	<45DC4281.8030903@domain.hid> <45DC44FA.6050703@domain.hid>
In-Reply-To: <45DC44FA.6050703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5153D2B51B2AE5EE5AEF559F"
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5153D2B51B2AE5EE5AEF559F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
> depending on advice on my email on the tsc problem I am having I will
> now try and find out how the user-space side of xenomai is to be used.
> Make a simple structure as a Qt thread (in which I intend to write the
> application) and then dig into the CAN stuff.
>=20
> So in regard to this:
>>> Yeah, maybe already a link (README) from the examples repos would be
>>> enough to point beginners to them. Or maybe we should ask some beginn=
ers
>>> what they expect, what they didn't understand... (Roland?)
> I will comment on as soon as I have enough insight in xenomai's typical=

> usage. Before then my opinion will probably not be worth much.
>=20
> Besides we are only now going to order the PEAKCAN dongle so I will onl=
y
> be able to test something next week.

xeno_can_virt may help to do some testing even without hardware. It
emulates a local virtual CAN bus between 2 or more nodes.

Jan


--------------enig5153D2B51B2AE5EE5AEF559F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3FCbniDOoMHTA+kRAvhhAJ9/hrooPYLDxpU82jcszjaqj6dqrwCfXSBH
/iFswScIX4+rE8IbXD1DCMI=
=lb6C
-----END PGP SIGNATURE-----

--------------enig5153D2B51B2AE5EE5AEF559F--

