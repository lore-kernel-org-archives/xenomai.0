Message-ID: <45C9BA26.1040205@domain.hid>
Date: Wed, 07 Feb 2007 12:38:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>	<17864.63903.244809.994959@domain.hid>	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>
	<45C9B7C4.8050705@domain.hid>
In-Reply-To: <45C9B7C4.8050705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE19B14F37678FA1B9B75C3C"
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE19B14F37678FA1B9B75C3C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Eric Noulard wrote:
>> 2007/2/6, Jan Kiszka <jan.kiszka@domain.hid>:
>>>  o check if you have MSI enabled, if yes, try to disable it
>> Sorry but I don't know what MSI is?
>> Could you tell me how to check (and may be some
>> pointer to valuable information which explains what it is)?
>=20
> Your /proc/interrupts output already suggests it: CONFIG_PCI_MSI is set=

> in your config. It's worth trying the disable it, because even plain
> Linux has problems with certain board/device combinations. But I don't
> recall if tg3 was recently involved in such, it may still be an ipipe
> bug here.

On the other hand, CONFIG_ACPI is not set which may cause problems on
modern systems as well. You only need to disable CONFIG_ACPI_PROCESSOR
for hard RT, the rest of ACPI can safely be enabled. Or is it disabled
in your vanilla setup as well?

Jan


>=20
> Jan
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enigEE19B14F37678FA1B9B75C3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFybomniDOoMHTA+kRAqKgAJ93hL7BU/3a9pxfG9/0NRzaBO5gZACfXzXa
XsRH+iI4ppTCZMjq7vY+vtA=
=HUt0
-----END PGP SIGNATURE-----

--------------enigEE19B14F37678FA1B9B75C3C--

