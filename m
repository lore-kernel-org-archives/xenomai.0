Message-ID: <44B218C5.9000804@domain.hid>
Date: Mon, 10 Jul 2006 11:07:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
In-Reply-To: <4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF854CA3A269AC61C3A704FA1"
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
--------------enigF854CA3A269AC61C3A704FA1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Thanks Jan.
>=20
> You mentioned:
> "Depends on what you have to protect. The easiest way for short code
> passages are still spinlocks with hard IRQ protection (under RTDM:
> rtdm_lock_xxx). "
>=20
> I read the code of rtdm_lock_xxx and find it mapped to spin_lock. If I
> understand correctly,
>=20
> a RTDM driver using:
> rtdm_lock_get(&my_lock);
>=20
> a normal linux driver using
> spin_lock(&my_lock);
>=20
> Can be used to protect some shared data structure between RTDM real-tim=
e
> driver in Xenomai Domain
> and a normal Linux driver, right?

Yep. See also real-world examples in existing RTDM drivers.

>=20
> I just started to write a RTDM driver, and I am not sure what existing
> linux
> kernel services
> I can use in the RTDM driver, e.g, wait queue, semaphores, request_dma(=
),
> free_dma(), etc.
> I have concern that the RTDM driver may not synchronize with linux kern=
el,
> since it will
> preempt Linux kernel whenever the HW interrupt is not masked.
> Is there any guideline there?

Keep in mind that Linux may have been preempted AT ANY POINT when your
driver executes some code in hard real-time mode. Therefore, calling
almost all Linux services from RT context must be considered unsafe
(unfortunately, it often works fine in practice, just fails/crashes
"magically" from time to time).

But it's usually not required to do so as most of Linux interaction can
be performed during init/cleanup. Just register your open/socket and
close handler as "_nrt" so that they are only executed in pure Linux or
secondary mode, and you can run whatever Linux service you like.

If you encounter any Linux service that you have to call for your driver
from IRQ or RT context, please report.

Jan


--------------enigF854CA3A269AC61C3A704FA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEshjFniDOoMHTA+kRAv69AJ92m3LrYGwzZnvgZEyf2nZiqztDNgCfSVRT
IjHrjPEg6Kn6DkOczUVYVLQ=
=LUSs
-----END PGP SIGNATURE-----

--------------enigF854CA3A269AC61C3A704FA1--

