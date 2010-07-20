Message-ID: <4C45A7A2.3080401@domain.hid>
Date: Tue, 20 Jul 2010 15:41:54 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C3B07A2.4020606@domain.hid> <4C3B0CEB.7040906@domain.hid>
	<4C3B1149.90309@domain.hid>
In-Reply-To: <4C3B1149.90309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig837204D1B78B24701C1ADBE7"
Subject: [Xenomai-help] [PATCH] x86: add Intel ICH10_1 to rthal_smi_pci_tbl
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig837204D1B78B24701C1ADBE7
Content-Type: multipart/mixed;
 boundary="------------070802000504070400000904"

This is a multi-part message in MIME format.
--------------070802000504070400000904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

patch attached.

On 12.07.2010 14:57, Theo Veenker wrote:
> Jan Kiszka wrote:
>  =20
>> Theo Veenker wrote:
>>    =20
>>> Hi,
>>>
>>> About a year ago when installing Xenomai on a new box it appeared thi=
s
>>> particular system required an addition to the PDI IDs table in arch/x=
86/smi.c.
>>> See this thread: https://mail.gna.org/public/xenomai-help/2009-08/msg=
00031.html
>>> Gilles said he would make the change to smi.c. That was with 2.4.8.
>>>
>>> Now I'm trying 2.5.3 but again the same PCI ID is missing. Is there a=

>>> particular reason not to include this ID? On this system the SMI dete=
ction
>>> stuff doesn't work without it.
>>>
>>> It requires adding this line to rthal_smi_pci_tbl[]:
>>> {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},
>>>      =20
>> Does the SMI disabling actually work, ie. do you _measure_ any
>> difference? I'm asking as I think to remember that recent (but older
>> than ICH10) Intel chipset no longer provide the required interface or =
at
>> least changed it in an incompatible way.
>>    =20
> Yes it does. First I got high latencies (~1800us). Then I remembered th=
at I had to
> disable SMI on this platform, so I recompiled with SMI disabled, to fin=
d out it
> didn't make a difference. In the messages log I saw it didn't say anyth=
ing about
> SMI so I looked into it and found out the PCI ID I had in before was go=
ne. I added
> it and now the SMI workaround works and the high latencies are gone.
>
> Theo
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>  =20


--------------070802000504070400000904
Content-Type: text/x-patch;
 name="0001-x86-add-Intel-ICH10_1-to-rthal_smi_pci_tbl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-x86-add-Intel-ICH10_1-to-rthal_smi_pci_tbl.patch"

=46rom 79a579bdd8c79d4160733f046b0bc89a9c3ff283 Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Mon, 19 Jul 2010 10:45:45 +0200
Subject: [PATCH] x86: add Intel ICH10_1 to rthal_smi_pci_tbl

---
 ksrc/arch/x86/smi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ksrc/arch/x86/smi.c b/ksrc/arch/x86/smi.c
index 2116899..93b5585 100644
--- a/ksrc/arch/x86/smi.c
+++ b/ksrc/arch/x86/smi.c
@@ -49,6 +49,7 @@ static struct pci_device_id rthal_smi_pci_tbl[] =3D {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_4)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},
 	{0,},
 };
=20
--=20
1.7.1


--------------070802000504070400000904--

--------------enig837204D1B78B24701C1ADBE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxFp64ACgkQIPTw9rIdn6qeTwCfWlC6yytbyHINu6zMCl+j4azP
C5YAn37wCJfbJOVaPBcyAXM0R0u6USSR
=nnun
-----END PGP SIGNATURE-----

--------------enig837204D1B78B24701C1ADBE7--

