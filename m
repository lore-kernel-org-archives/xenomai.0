Message-ID: <44B35797.1030406@domain.hid>
Date: Tue, 11 Jul 2006 09:47:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>	
	<44B218C5.9000804@domain.hid>	
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>	
	<44B2216A.1060904@domain.hid>	
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>	
	<44B341E2.9040506@domain.hid>	
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>	
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>	
	<44B35346.2070200@domain.hid>
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>
In-Reply-To: <4546494d0607110043x45804030td009ed790040420b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B765062FDA865608CA0C5A5"
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
--------------enig8B765062FDA865608CA0C5A5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Jan,
>=20
> Sorry but could you help to confirm the other question in my last (last=
)
> mail:
>=20
> "Do you mean in a "normal Linux driver", I can use
>=20
> rtdm_lock_get_irqsave() to protect my Linux task from being preempted b=
y
> Xenomai task? "
>=20

Do I have to sign somewhere? ;)

Yes, you can, and it's actually done in many existing RTDM drivers -
init/cleanup handlers that need to sync with RT users or IRQs typically
uses this mechanism (see the 16550A driver e.g.). And init/cleanup is
mostly performed from standard Linux context.

Jan


--------------enig8B765062FDA865608CA0C5A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs1eXniDOoMHTA+kRAu4RAJ0U/ijlvyWM75s7PwNWNOsGCUdH6wCdGFdF
XG61LM6wu4M+F3gL7hK/x10=
=yReU
-----END PGP SIGNATURE-----

--------------enig8B765062FDA865608CA0C5A5--

