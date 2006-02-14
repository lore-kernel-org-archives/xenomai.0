Message-ID: <43F2131F.4010508@domain.hid>
Date: Tue, 14 Feb 2006 18:27:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kconfig inconsistencies
References: <43F08392.3000403@domain.hid> <43F20E47.1070908@domain.hid>
In-Reply-To: <43F20E47.1070908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B09D3551D0ECA9A0F34A94C"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B09D3551D0ECA9A0F34A94C
Content-Type: multipart/mixed; boundary="------------000709000206060907000209"

This is a multi-part message in MIME format.
--------------000709000206060907000209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>>
>> I haven't worked out any patch for those issues. Actually, I only want=
ed
>> to put this patch forward when stumbling over the other:
>>
>> --- ksrc/skins/native/Kconfig   (revision 564)
>> +++ ksrc/skins/native/Kconfig   (working copy)
>> @@ -127,7 +127,6 @@
>>
>>  config XENO_OPT_NATIVE_INTR
>>      bool "Interrupts"
>> -    default y
>>      help
>>
>>      This option provides a simple API to deal with interrupts,
>>
>> Rationale: the /default/ way of handling IRQs should be via RTDM-based=

>> drivers. Only users who know what they are doing should leave this pat=
h
>> and will have to switch on this feature explicitly. If this view can b=
e
>> commonly accepted, I will add some lines to the feature's help text as=

>> well.
>>
>=20
> Agreed.
>=20

Then apply this one, please. I noticed that 2.4 does not know default
values for bool options, correct?

Jan

--------------000709000206060907000209
Content-Type: text/plain;
 name="nat_intr_default.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="nat_intr_default.patch"

Index: ksrc/skins/native/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/Kconfig	(revision 568)
+++ ksrc/skins/native/Kconfig	(working copy)
@@ -128,11 +128,11 @@
=20
 config XENO_OPT_NATIVE_INTR
 	bool "Interrupts"
-	default y
 	help
 =09
 	This option provides a simple API to deal with interrupts,
-	both in kernel and user-space contexts. Registry support is
-	required.
+	both in kernel and user-space contexts. Note that the preferred
+	way of implementing generic drivers usable across all Xenomai
+	interfaces is defined by the Real-Time Driver Model (RTDM).
=20
 endif

--------------000709000206060907000209--

--------------enig8B09D3551D0ECA9A0F34A94C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8hMfniDOoMHTA+kRAmgpAJ9lf+UcJwUIT0cX2S40Aac1c9PXqQCdHgVC
M7F/PJwTKznfVhiCuSaC5wE=
=AIXg
-----END PGP SIGNATURE-----

--------------enig8B09D3551D0ECA9A0F34A94C--

