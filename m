Message-ID: <46F60EF1.9030009@domain.hid>
Date: Sun, 23 Sep 2007 09:00:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46F0E315.10306@domain.hid> <1190235866.9745.21.camel@domain.hid>
In-Reply-To: <1190235866.9745.21.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4988897945BDAFF735EA7024"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] fix irq statistics
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4988897945BDAFF735EA7024
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2007-09-19 at 10:51 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> IRQ hit counters are broken in latest I-pipe 1.10-x for the wired path=
=2E=20
>> This patch moves the counter maintenance out of __ipipe_set_irq_pendin=
g=20
>> and instead makes it explicit at the required spots.
>=20
> I would rather add the missing accounting code as below. Marking an
> interrupt as pending using the __ipipe_set_irq_pending() interface
> should implicitely be paired with proper accounting.

My original intention was to keep __ipipe_dispatch_wired compact.

But thinking about this again, I wonder if the whole thing makes sense
as it is implemented right now: Given that I-pipe users like Xenomai now
use this irqall counter as high-level hit counter, I'm not that sure we
should also account for IRQ events on locked lines or in case of stalled
receiver domains. Only _delivery_, ie. handler invocation, should be
counted IMO (=3D>__ipipe_run_isr). What do you think?

Jan


--------------enig4988897945BDAFF735EA7024
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG9g7yniDOoMHTA+kRAgcTAJ0UTMfSmfOZsRgaSb0zyVVGHqK4ygCfahdX
skMv1KN1pO7S6mpGi+ez0t0=
=8OSL
-----END PGP SIGNATURE-----

--------------enig4988897945BDAFF735EA7024--

