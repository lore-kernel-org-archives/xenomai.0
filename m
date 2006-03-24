Message-ID: <4424264F.7090401@domain.hid>
Date: Fri, 24 Mar 2006 18:03:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Crashing at boot with 2.6.15.4
References: <440DA975.50002@domain.hid> <440DAC21.9030801@domain.hid>
	<44241F36.40201@domain.hid>
In-Reply-To: <44241F36.40201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3C7AE89634C2B82ECF1098C"
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3C7AE89634C2B82ECF1098C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> FYI,
>=20
> Just following up on my crash issue from a couple weeks ago. It appears=
 that=20
> disabling the local APIC in the kernel fixed my crash. I have a complet=
e dump of=20
> the console messages before the crash and two kernel config files attac=
hed. The=20
> only difference in the config files is the APIC settings.
>=20
> My test system is an older PII 350MHz with 512M. The vanilla kernel boo=
ts fine=20
> with APIC support enabled, but when the Xenomai patches are applied I g=
et the crash.
>=20
> Also, this may be in the release notes but I wanted to mention it anywa=
y. I=20
> noticed that the valid return values for an RTDM interrupt handler have=
 changed=20
> between Xenomai 2.0 and 2.1. I have a driver I wrote in 2.0.92 that fai=
ls to=20
> compile under 2.1. It looks like the valid return code have changed as =
follows:
>=20
> Xenomai 2.0.92
> RTDM_IRQ_PROPAGATE
> RTDM_IRQ_ENABLE
>=20
> Xenomai 2.1
> RTDM_IRQ_NONE
> RTDM_IRQ_HANDLED
>=20
> When an interrupt handler now returns RTDM_IRQ_HANDLED I assume it will=
 be=20
> re-enabled, is this true?

That's true, and it should be described, see RTDM API docs and
ksrc/skins/rtdm/API.CHANGES. The upgrade is straightforward:

old			-> new

0			-> RTDM_IRQ_NONE
RTDM_IRQ_ENABLE		-> RTDM_IRQ_HANDLED
RTDM_IRQ_PROPAGATE	-> -unsupported-

> Linux version 2.6.15.6-ipipe (smm@domain.hid) (gcc version 4.0.2 20051125=
 (Red Hat 4.0.2-8)) #3 Thu Mar 23 11:45:02 EST 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
>  BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
>  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 511MB LOWMEM available.
> DMI 2.0 present.
> Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
> Built 1 zonelists
> Kernel command line: ro root=3DLABEL=3D/ console=3DttyS0,115200n8
> Local APIC disabled by BIOS -- you can enable it with "lapic"

You may either follow this suggestion or actually leave local APIC off
at compile time.

> Initializing CPU#0
> CPU 0 irqstacks, hard=3Dc0414000 soft=3Dc0413000
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 350.905 MHz processor.
> Using tsc for high-res timesource
> I-pipe 1.2-01: pipeline enabled.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 514088k/524276k available (2222k kernel code, 9656k reserved, 7=
30k data, 168k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode..=
=2E Ok.
> Calibrating delay using timer specific routine.. 702.33 BogoMIPS (lpj=3D=
351169)
> Security Framework v1.0.0 initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 512
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> mtrr: v2.0 (20020519)
> CPU: Intel Pentium II (Deschutes) stepping 02
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> checking if image is initramfs... it is
> Freeing initrd memory: 1070k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=3D1
> PCI: Using configuration type 1
> Linux Plug and Play Support v0.97 (c) Adam Belay
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Probing PCI hardware
> PCI quirk: region e400-e43f claimed by PIIX4 ACPI
> PCI quirk: region e800-e80f claimed by PIIX4 SMB
> PIIX4 devres B PIO at 0290-0297
> PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
> PCI: IRQ 0 for device 0000:00:04.2 doesn't match PIRQ mask - try pci=3D=
usepirqmask
> PCI: Bridge: 0000:00:01.0
>   IO window: disabled.
>   MEM window: e0000000-e1dfffff
>   PREFETCH window: e1f00000-e3ffffff
> audit: initializing netlink socket (disabled)
> audit(1143117255.879:1): initialized
> Xenomai: Local APIC absent or disabled!
>          Disable APIC support or pass "lapic=3D1" as bootparam.
> Xenomai: system init failed, code -19.

This is normal, given the lacking "lapic=3D1".

> divide error: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c014243a>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.15.6-ipipe)
> EIP is at xntimer_get_jiffies_aperiodic+0x5a/0xf0

This is not ok, but should be easy to fix.

> eax: eb54cd11   ebx: 00000000   ecx: 3b9aca00   edx: 00000000
> esi: 08a61400   edi: c0465aa0   ebp: 00000000   esp: c14d7ef8
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=3Dc14d7000 task=3Dc14d8a70)
> Stack: f2bd7342 00000003 eb54cd11 00000000 00000000 00000000 c0465aa0 0=
0000000
>        c01401a8 c0140115 768acda8 0fdd2b16 00000000 00000000 768acda8 0=
fdd2b16
>        c0140718 c0140810 00000000 00000000 0fdd2b16 c045c800 00000000 4=
42295c7
> Call Trace:
>  [<c01401a8>] xnpod_get_time+0x8/0x20
>  [<c0140115>] xnpod_set_time+0x45/0xd0
>  [<c0140718>] xnpod_start_timer+0x1e8/0x260
>  [<c0140810>] xnpod_announce_tick+0x0/0x120
>  [<c013cf77>] xnpod_init+0x487/0x4b0
>  [<c0117a00>] printk+0x30/0xd0
>  [<c01451d5>] xncore_attach+0x35/0x60
>  [<c01483f9>] __native_skin_init+0x9/0xe0
>  [<c03e4909>] do_initcalls+0x29/0xc0
>  [<c0100280>] init+0x0/0x150
>  [<c0100280>] init+0x0/0x150
>  [<c01002aa>] init+0x2a/0x150
>  [<c0100fb4>] kernel_thread_helper+0x0/0xc
>  [<c0100fb9>] kernel_thread_helper+0x5/0xc
> Code: e3 89 d7 8b 54 24 04 89 c6 89 d0 f7 e3 31 db 89 44 24 08 01 7c 24=
 08 8b 7c 24 18 89 54 24 0c 11 5c 24 0c 8b 44 24 08 8b 54 24 0c <f7> f5 8=
9 c1 89 f0 8b 74 24 14 f7 f5 89 ca 8b 6c 24 1c 89 d3 89
>  <0>Kernel panic - not syncing: Attempted to kill init!
>=20

Jan


--------------enigC3C7AE89634C2B82ECF1098C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJCZPniDOoMHTA+kRAkn1AJ0VQXcXYM1ua6+vIZEG6Hdxd6RKSwCfWZRs
z1QT+JUinCfuXfXNgGQrXjw=
=3kVe
-----END PGP SIGNATURE-----

--------------enigC3C7AE89634C2B82ECF1098C--

