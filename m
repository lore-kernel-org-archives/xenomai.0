Message-ID: <438D6D70.80502@domain.hid>
Date: Wed, 30 Nov 2005 10:14:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix SMI and proc cleanup
References: <438D61CD.7000701@domain.hid>
In-Reply-To: <438D61CD.7000701@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
>=20
> the smaller the bug is, the longer it takes to track. The first one in
> this patch was such an issue. It prevented the SMI workaround to do its
> job because the related PCI ID table got "optimised" away (SVN trunk on=
ly).

Good catch. Fact is that this table must survive free_initmem() now=20
since we want to enable the SMI watchdog only when the nucleus is=20
actually running a real-time interface.

>=20
> The second one is also SVN-only. It fixes the proc-fs cleanup of the
> nucleus when being used as a module.
>=20
> I also removed some special character from a name in the ChangeLog.
>=20
> Please apply!
>=20

Applied, thanks.

> Jan
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ChangeLog	(Revision 208)
> +++ ChangeLog	(Arbeitskopie)
> @@ -1,3 +1,11 @@
> +2005-11-30  Jan Kiszka <jan.kiszka@domain.hid>
> +
> +	* ksrc/arch/i386/smi.c: Remove __initdata from rthal_smi_pci_tbl
> +	to make table persistent.
> +
> +	* ksrc/nucleus/module.c (__xeno_sys_exit): Reorder proc-fs
> +	cleanup to avoid stalled entries.
> +
>  2005-11-29  Philippe Gerum  <rpm@xenomai.org>
> =20
>  	* ksrc/nucleus/pipe.c (xnpipe_recv): Remove superfluous timeout
> @@ -623,7 +631,7 @@
> =20
>  	* nucleus/module.c: Revamp /proc/xenomai/{sched,stat} output format.
> =20
> -2005-08-31  St=E9phane Fillod  <stephane.fillod@domain.hid>
> +2005-08-31  Stephane Fillod  <stephane.fillod@domain.hid>
> =20
>  	* skins/rtai/fifo.c (__fifo_pkg_init): fix missing init of flush
>  	queue handles.
> Index: ksrc/arch/i386/smi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/arch/i386/smi.c	(Revision 208)
> +++ ksrc/arch/i386/smi.c	(Arbeitskopie)
> @@ -31,7 +31,7 @@
>  #include <linux/reboot.h>
>  #include <asm/xenomai/smi.h>
> =20
> -static struct pci_device_id rthal_smi_pci_tbl[] __initdata =3D {
> +static struct pci_device_id rthal_smi_pci_tbl[] =3D {
>  { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0) },
>  { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0) },
>  { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0) },
> Index: ksrc/nucleus/module.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/module.c	(Revision 208)
> +++ ksrc/nucleus/module.c	(Arbeitskopie)
> @@ -817,6 +817,10 @@
>  {
>      xnpod_shutdown(XNPOD_NORMAL_EXIT);
> =20
> +#if defined(__KERNEL__) && defined(CONFIG_PROC_FS)
> +    xnpod_delete_proc();
> +#endif /* __KERNEL__ && CONFIG_PROC_FS */
> +
>      xnarch_exit();
> =20
>  #ifdef __KERNEL__
> @@ -830,9 +834,6 @@
>  #ifdef CONFIG_LTT
>      xnltt_umount();
>  #endif /* CONFIG_LTT */
> -#ifdef CONFIG_PROC_FS
> -    xnpod_delete_proc();
> -#endif /* CONFIG_PROC_FS */
>  #endif /* __KERNEL__ */
> =20
>      if (nkmsgbuf)
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

