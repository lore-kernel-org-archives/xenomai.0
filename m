Message-ID: <4536A144.1040603@domain.hid>
Date: Wed, 18 Oct 2006 23:48:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/3] Migrate and enhance IRQ statistics
References: <452E9ADB.6000700@domain.hid>
In-Reply-To: <452E9ADB.6000700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA605A47D04AF9EEDD9F999AA"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA605A47D04AF9EEDD9F999AA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> This patch migrates the xnintr hits statistics to the new xnstat
> subsystem and introduces per-CPU runtime statistics to xnintr entities.=

> The latter allows to differentiate between ISR and thread activity unde=
r
> /proc/xenomai/stat.
>=20
> For querying the xnintr statistics, a scalable service based on IRQ lis=
t
> revisions is introduced (xnintr_query), just like it already exists for=

> threads.
>=20
> Accounting model:
>  - hits are only counted if the ISR returns XN_ISR_HANDLED
>  - runtime is accounted over each ISR invocation, independent of its
>    return value
>=20
> As a hopefully not critical side effect, the native intr services now
> only reports non-zero hit counters if XENO_OPT_STATS in enabled. This
> fact is documented in the rt_intr_info structure.
>=20

This patch causes an oops on process cleanup here - I'm still
investigating (likely an outdated xnstat_runtime reference)...

Jan



--------------enigA605A47D04AF9EEDD9F999AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNqFEniDOoMHTA+kRAhAXAJ9w0+e0LZjefB8q0v54V+OHP9jrIwCeMJyC
GQnw3TJNv5CD/ddq7smqUYs=
=rjYs
-----END PGP SIGNATURE-----

--------------enigA605A47D04AF9EEDD9F999AA--

