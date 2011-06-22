From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid>
References: <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Jun 2011 11:32:52 +0200
Message-ID: <1308735172.2159.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, 2011-06-22 at 10:55 +0200, VEYSSIERE Nicolas wrote:
> Same thing here, I tried to patch linux 2.6.38 with the latest adeos
> patch
> (http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-=
2.10-00.patch) but the kernel compilation failed :
>=20
> =20

Support for latency watchdog is discontinued starting from 2.6.38.

diff --git a/ksrc/arch/x86/hal_32.c b/ksrc/arch/x86/hal_32.c
index 5f5ff2c..de21c90 100644
--- a/ksrc/arch/x86/hal_32.c
+++ b/ksrc/arch/x86/hal_32.c
@@ -337,7 +337,7 @@ int rthal_arch_init(void)
 		rthal_smi_restore();
 		return -ENODEV;
 	}
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38) && defined(CONFIG_GENERIC_=
CLOCKEVENTS)
 	if (nmi_watchdog =3D=3D NMI_IO_APIC) {
 		printk("Xenomai: NMI kernel watchdog set to NMI_IO_APIC (nmi_watchdog=3D=
1).\n"
 		       "         This will disable the LAPIC as a clock device, and\n"
>=20
> =20
>=20
> =E2=80=A6=E2=80=A6
>=20
>   LD      arch/x86/pci/built-in.o
>=20
>   CC      arch/x86/power/cpu.o
>=20
>   CC      arch/x86/power/hibernate_32.o
>=20
>   AS      arch/x86/power/hibernate_asm_32.o
>=20
>   LD      arch/x86/power/built-in.o
>=20
>   CC      arch/x86/video/fbdev.o
>=20
>   LD      arch/x86/video/built-in.o
>=20
>   CC      arch/x86/xenomai/hal_32.o
>=20
> arch/x86/xenomai/hal_32.c: In function 'rthal_arch_init':
>=20
> arch/x86/xenomai/hal_32.c:341: error: 'nmi_watchdog' undeclared (first
> use in this function)
>=20
> arch/x86/xenomai/hal_32.c:341: error: (Each undeclared identifier is
> reported only once
>=20
> arch/x86/xenomai/hal_32.c:341: error: for each function it appears
> in.)
>=20
> arch/x86/xenomai/hal_32.c:341: error: 'NMI_IO_APIC' undeclared (first
> use in this function)
>=20
> At top level:
>=20
> cc1: warning: unrecognized command line option
> "-Wno-unused-but-set-variable"
>=20
> make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
>=20
> make: *** [arch/x86/xenomai] Error 2
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> Can someone tell me what to do ?
>=20
> =20
>=20
> Thanks.
>=20
> =20
>=20
> Regards,
>=20
> =20
>=20
> --=20
>=20
> Nicolas VEYSSIERE
>=20
> =20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



