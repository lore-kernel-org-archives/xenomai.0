Message-ID: <43E50233.8020807@domain.hid>
Date: Sat, 04 Feb 2006 20:36:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] SMI-doc improvement / RTDM paper
References: <43E4F63C.4090200@domain.hid> <43E4F739.90204@domain.hid>
In-Reply-To: <43E4F739.90204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6690816D01D99194014CE1A"
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
--------------enigF6690816D01D99194014CE1A
Content-Type: multipart/mixed; boundary="------------040004010103090006040902"

This is a multi-part message in MIME format.
--------------040004010103090006040902
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> this patch tries to clarify where to solve SMI-related latencies. Or
>> should we even mention the kconfig path?
>>
>=20
> The name of the config switch involved should be enough, I guess.

What about this? Please apply if it's ok.

Jan

--------------040004010103090006040902
Content-Type: text/x-patch;
 name="smi-doc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="smi-doc.patch"

Index: ksrc/arch/i386/smi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/smi.c	(Revision 539)
+++ ksrc/arch/i386/smi.c	(Arbeitskopie)
@@ -209,8 +209,9 @@
=20
 #else /* ! CONFIG_XENO_HW_SMI_WORKAROUND */
=20
-    printk("Xenomai: Intel chipset found and SMI workaround not enabled,=
\n"
-           "       you may encounter high interrupt latencies.\n");
+    printk("Xenomai: Intel chipset found but SMI workaround not enabled =
(check\n"
+           "         CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter h=
igh\n"
+           "         interrupt latencies!\n");
     pci_dev_put(dev);
=20
 #endif /* ! CONFIG_XENO_HW_SMI_WORKAROUND */

--------------040004010103090006040902--

--------------enigF6690816D01D99194014CE1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5QIzniDOoMHTA+kRAs2rAJ44n83M63qQAkS1wGF4+Y6Che4F3gCdFjRv
aaSxZNTXtD5T8MVDfrg28NE=
=T4Kd
-----END PGP SIGNATURE-----

--------------enigF6690816D01D99194014CE1A--

