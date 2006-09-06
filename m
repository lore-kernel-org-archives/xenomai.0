Message-ID: <44FE943F.9000803@domain.hid>
Date: Wed, 06 Sep 2006 11:26:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>	
	<44FD9F92.4050802@domain.hid>	
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>	
	<44FE6C55.1030900@domain.hid>
	<b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
In-Reply-To: <b647ffbd0609060159q7677cd30y80208afc58caf17@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig76F1E645209A39A0527A7893"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76F1E645209A39A0527A7893
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Sharing itself is no problem: if your request an IRQ with XN_ISR_SHARED=

>> set but the nucleus is not able to actually assign it to more than one=

>> driver, the second request will simply fail. I see no need to deny the=

>> first request or even break the driver build.
>>
> Problematic is only the handling of edge-triggered shared IRQs with the=

>>
> level-triggered handler (can cause lost IRQs). Probably a runtime check=

>> is best as we cannot control the configuration of, e.g., external RTDM=

>> drivers. What about the attached patch?
>=20
>=20
> It's ok with me.
>=20
> I just thought maybe it's better to break a build and alert a user earl=
ier
> (although, it's kind of inderect alert indeed) when the host environmen=
t
> (Xeno) doesn't support a requested mode (e.g. SHARED_EDGE).
>=20
> If such a driver (that requires EDGE_SHARED) is a part of the mainline,=

> then
> we may use Kconfig features either (1) to make it "selectable" only whe=
n
> XENO_OPT_SHIRQ_EDGE is on or (2) select XENO_OPT_SHIRQ_EDGE automatical=
ly
> when the driver has been choosen.
>=20

Let's do both, the runtime check + some Kconfig magic for mainline driver=
s.

For the latter we should reorganise the config options slightly.
XENO_OPT_SHIRQ_* may better depend on a new switch XENO_OPT_SHIRQ. Thus,
when the user enables IRQ sharing and some in-tree driver requires
edge-triggering support, XENO_OPT_SHIRQ_EDGE will be selected by the
driver's Kconfig: select XENO_OPT_SHIRQ_EDGE if XENO_OPT_SHIRQ. With the
current layout it would look like this: select XENO_OPT_SHIRQ_EDGE if
XENO_OPT_SHIRQ_LEVEL. That may appear illogical to the user.

Jan


--------------enig76F1E645209A39A0527A7893
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/pRDniDOoMHTA+kRAmxhAJ45UNQ0T2PIhQm8aDvZ2sbmFY5IlgCeOSbd
AEGx/ZtAUTFL/98myEUtIdw=
=t/nt
-----END PGP SIGNATURE-----

--------------enig76F1E645209A39A0527A7893--

