Message-ID: <45DF720B.9020701@domain.hid>
Date: Sat, 24 Feb 2007 00:00:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Catch HPET conflict
References: <45DB66B4.6050700@domain.hid> <1172257069.26738.102.camel@domain.hid>
	<1172269936.26738.106.camel@domain.hid>
In-Reply-To: <1172269936.26738.106.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7B2F8A8A0510AA1DAB3EFEC0"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B2F8A8A0510AA1DAB3EFEC0
Content-Type: multipart/mixed; boundary="------------040304010903010608040506"

This is a multi-part message in MIME format.
--------------040304010903010608040506
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-02-23 at 19:57 +0100, Philippe Gerum wrote:
>> On Tue, 2007-02-20 at 22:23 +0100, Jan Kiszka wrote:
>>> As long as there is obviously a conflict, catch it during kernel
>>> configuration and urge the user to disable CONFIG_HPET_TIMER.
>>>
>> Applied, thanks.
>>
>=20
> Reverted from the trunk/ though, since this won't work as is for x86_64=
=2E
>=20

Yeah, noticed this as well. The attached version works, but... could you
explain to me what I'm patching here? What is different about our HPET
issue on x86_64 so that we are not being bitten there?

Jan

--------------040304010903010608040506
Content-Type: text/plain;
 name="hpet-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hpet-v2.patch"

Index: scripts/Kconfig.frag
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/Kconfig.frag	(Revision 2238)
+++ scripts/Kconfig.frag	(Arbeitskopie)
@@ -12,12 +12,12 @@ comment "(menu Device Drivers/Input devi
 	depends on !X86_TSC && X86 && INPUT_PCSPKR
=20
 comment "NOTE: Xenomai currently conflicts with HPET support."
-       depends on HPET_TIMER
+	depends on HPET_TIMER && !X86_64
 comment "(menu Processor type and features)"
-       depends on HPET_TIMER
+	depends on HPET_TIMER && !X86_64
=20
 config XENOMAI
-       depends on (X86_TSC || !X86 || !INPUT_PCSPKR) && !HPET_TIMER
+	depends on (X86_TSC || !X86 || !INPUT_PCSPKR) && (!HPET_TIMER || X86_64=
)
 	bool "Xenomai"
 	default y
         select IPIPE

--------------040304010903010608040506--

--------------enig7B2F8A8A0510AA1DAB3EFEC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF33IQniDOoMHTA+kRAnV6AJ9GX3K5tXizrjBd8+dhYZ0GrqTNEwCeOVJH
eHoH8jcNgwHLKTDHjIwGFvc=
=geUc
-----END PGP SIGNATURE-----

--------------enig7B2F8A8A0510AA1DAB3EFEC0--

