Message-ID: <45D9E59B.8040002@domain.hid>
Date: Mon, 19 Feb 2007 18:59:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D9DF65.9000300@domain.hid>
In-Reply-To: <45D9DF65.9000300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB2ADA28354739136F6993C21"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: RT-Socket-CAN versioning
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB2ADA28354739136F6993C21
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> currently the RT-Socket-CAN drivers maintains it's own version or
> release number. As RT-Socket-CAN is part of Xenomai, I do not see the
> need for it (and so far I did not update it). What is the intended use
> of "driver_version" in "struct rtdm_device"?

Actually, I was thinking about this too yesterday. The idea of the
separate versioning for RTDM drivers is to signal the users if something
in the driver really changed. It's fairly obvious what to do with it for
out-of-tree drivers, but for in-tree it might be worth considering the
policy.

The current model, maintained more or less properly for the existing
drivers, is to increment independently of Xenomai according to major or
minor changes. One may ease this burden for the driver developer by
simply filling in Xenomai's version here. That would just let the
revisions increase on every Xenomai release, even if the driver remained
untouched. The tag would still have a meaning for out-of-tree drivers,
but for in-tree it would be fairly meaningless.

Well, whatever is commonly preferred, it should then be applied
consistently on all RTDM drivers in Xenomai. What are the opinions on
this list (I will comment afterwards)?

> Furthermore, there is also
> "profile_version" (which does not show up n the Doxygen docu for some
> strange reason).

The automatic update from the latest SVN must be broken on
www.xenomai.org, there is more stuff missing.

> The latter one seems suitable to reflect CAN API changes.

Exactly. That's why I incremented that in SVN trunk's rtcan.h. A correct
profile version is definitely a must to let applications handle relevant
changes.

Jan


--------------enigB2ADA28354739136F6993C21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2eWbniDOoMHTA+kRAtxRAJ4pLMEdebcyZytQzlBPaxJyvHDxsgCfTzag
/b4KOJZC7JEhk9zmkkSgidA=
=ROpH
-----END PGP SIGNATURE-----

--------------enigB2ADA28354739136F6993C21--

