Message-ID: <44B35346.2070200@domain.hid>
Date: Tue, 11 Jul 2006 09:29:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B1FDBD.4060600@domain.hid>	
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>	
	<44B218C5.9000804@domain.hid>	
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>	
	<44B2216A.1060904@domain.hid>	
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>	
	<44B341E2.9040506@domain.hid>	
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
In-Reply-To: <4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E2934D9CAC81064117E886A"
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
--------------enig7E2934D9CAC81064117E886A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Sorry that the email was cut off by Gmail (not sure why).
>=20
> Continue with last mail:
>=20
> From the code, it looks rtdm_lock_get_irqsave() will "stalls" Xenomai
> domain
> and implicitly Linux domain, right?

Yep.

>=20
> Yesterday I was thinking if a Linux task  uses spin_lock_irqsave() woul=
d
> disable HW interrupt. So the Linux task can
> be protected from being preempted by Xenomai task. But it turns out tha=
t
> spin_lock_irqsave() will stalls Linux domain only.

True.

Jan


--------------enig7E2934D9CAC81064117E886A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs1NHniDOoMHTA+kRAuXrAKCE3guWOuyFIHAIGNsHXhPlt3YYPACfbseF
ODldUMOr1KO0izkUIiaGx9c=
=5iXn
-----END PGP SIGNATURE-----

--------------enig7E2934D9CAC81064117E886A--

