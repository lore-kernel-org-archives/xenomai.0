Message-ID: <456DC054.9040803@domain.hid>
Date: Wed, 29 Nov 2006 18:16:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Draft for a RTDM I2C driver, V2
References: <456D5705.1000902@domain.hid>
In-Reply-To: <456D5705.1000902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1CE6D1A25BFF5B7F59CB5B2"
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1CE6D1A25BFF5B7F59CB5B2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> Hello,
>=20
> I did some redesigning on my first draft.
> - Now we have some kind of profile in include/rti2c.h.
> - I got rid of some chunks of code that were not really needed.
> - Linux kernel dependencies have been removed (I hope I catched all of
> them)

Hmm, I would rather suggest the opposite: Unless you have to deviate
from the original Linux API (which seems to exist in kernel 2.4 as
well), I would prefer to keep structure and constant names identical. I
see no technically problem ATM in including the original I2C Linux
header, both in kernel and user space.

Then I'm curious what /real-time/ application scenarios are behind the
SMBus wrapping functions. Are you driving time-critical hardware via
such a protocol? May other users do the same, or is this a special use
case? Sorry, my knowledge about the SMBus is quite limited. The question
for me is simply, if those helpers should become part of the official
API specification or not.

There are still some duplications in the headers /rti2c.h and
/include/rti2c.h (I assume rti2c-api.h is just a copy of
/include/rti2c.h without profile comments). Please avoid this.
Everything the user needs to see should be in the profile header, and
that can then be included by the driver header.

And I think I found a bug (you may want to try
CONFIG_XENO_OPT_DEBUG_RTDM): rti2c_adapter_register, e.g., uses an RTDM
mutex, but I strongly suspect it (only?) runs in Linux context. Please
check your locking in this regard, also the other way around (non-RT
services in RT context - we currently lack automated checking for this).

Another remark while cross-reading (which means: no guarantee I found
all issues): correct error code for wrong context is EPERM
(rti2c_ioctl_rt, RTI2C_RDWR).

So far for now.

Jan


--------------enigB1CE6D1A25BFF5B7F59CB5B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbcBUniDOoMHTA+kRAhW7AJwIfzWlYjnN+Q7PqdPcm7LAT4rUAwCeO0A/
/ANfBWzL3EgMnYm5dbRWebM=
=Qdob
-----END PGP SIGNATURE-----

--------------enigB1CE6D1A25BFF5B7F59CB5B2--

