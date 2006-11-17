Message-ID: <455D6F83.40008@domain.hid>
Date: Fri, 17 Nov 2006 09:14:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <455D674E.2020300@domain.hid>
In-Reply-To: <455D674E.2020300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5BE4FFBDC1A714A4D93B0602"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Draft for a RTDM I2C driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BE4FFBDC1A714A4D93B0602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> Hello,
>=20
> I have spent some time designing a RTDM I2C driver based on the linux
> i2c driver. It's stripped down in some aspects but porting existing
> clients and adapters should be fairly easy.
> For this draft I have ported the IBM PPC4xx driver, because that is wha=
t
> I have here for testing.
>=20
> It's my first RTDM project, so I hope I haven't messed things up too mu=
ch.
>=20
> Any comments welcome!
>=20

Great! I almost forgot this topic as it was quiet after my reply, but
now we even have code to discuss.

Before I start looking into implementation details, it would be nice if
you could sketch the basic idea of your API proposal and the typical use
cases. Code is more explicit, I know, but it's also a bit more tricky to
grab an overview from it. Do you also have some simple demo to show how
one should use your interface?

What I grabbed so far:
 - for each I2C interface, a RTDM device is registered
 - rti2c-api.h is ought to become the RTDM I2C device profile
 - we have read/write and a bunch of IOCTLs as API

What I didn't grabbed:
 - is transfer synchronous or asynchronous?
 - can applications access an adapter concurrently?
 - what are the major differences to the Linux model?

I'm looking forward to see some nice generic RTI2C in Xenomai soon(er or
later)!

Jan


--------------enig5BE4FFBDC1A714A4D93B0602
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXW+DniDOoMHTA+kRAmv7AJ4s9hld7zw8c8nE3xpjlv89MCyxdgCdHb34
aIJJxEvMJQiKnLWsWDReo5U=
=Lq/v
-----END PGP SIGNATURE-----

--------------enig5BE4FFBDC1A714A4D93B0602--

