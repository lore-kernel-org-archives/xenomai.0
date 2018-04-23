Date: Mon, 23 Apr 2018 14:05:23 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <230952296.1345023.1524481523878.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <jg9c8gjocr5dp5ka6o3io0nf.1524481217306@embeddedgreg.com>
References: <jg9c8gjocr5dp5ka6o3io0nf.1524481217306@embeddedgreg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

thanks Ive missing rtnet
Now tring to insert it

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: =CF=EE=ED=E5=E4=E5=EB=FC=ED=E8=EA, 23 =C0=EF=F0=E5=EB=FC 2018 =E3 14:=
00:17
Subject: Re: Unknown symbol in module

This usually happens because a driver that your driver depends on is missin=
g or not built into the kernel. Use modprobe to install your module instead=
 of insmod. Modprobe will load dependencies. You may also want to make sure=
 you've enabled RTNET in your config.=20

Greg

=A0 Original Message =A0
From: shevchenko.taras@triolcorp.com.ua
Sent: April 23, 2018 2:24 AM
To: greg@embeddedgreg.com
Cc: xenomai@xenomai.org
Subject: Re: Unknown symbol in module

yeti@yeti-UDOO-x86:~$ uname -r
4.9.90-xenomai

yeti@yeti-UDOO-x86:~$ dmesg|grep Xenomai
[=A0=A0 12.917420] [Xenomai] scheduling class idle registered.
[=A0=A0 12.917422] [Xenomai] scheduling class rt registered.
[=A0=A0 12.917480] [Xenomai] SMI-enabled chipset found, but SMI workaround =
disabled
[=A0=A0 12.918467] I-pipe: head domain Xenomai registered.
[=A0=A0 12.920801] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)=20



yeti@yeti-UDOO-x86:~$ dmesg
[=A0=A0=A0 0.000000] Linux version 4.9.90-xenomai (root@yeti-UDOO-x86) (gcc=
 version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9) ) #2 SMP Thu Apr 5 =
11:18:52 EEST 2018
[=A0=A0=A0 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-4.9.90-xenoma=
i root=3DUUID=3Dca0244c5-d957-4ab6-8632-01fd821fcc06 ro quiet splash vt.han=
doff=3D7
[=A0=A0=A0 0.000000] KERNEL supported cpus:
[=A0=A0=A0 0.000000]=A0=A0 Intel GenuineIntel
[=A0=A0=A0 0.000000]=A0=A0 AMD AuthenticAMD
[=A0=A0=A0 0.000000]=A0=A0 Centaur CentaurHauls
[=A0=A0=A0 0.000000] x86/fpu: Legacy x87 FPU detected.
[=A0=A0=A0 0.000000] x86/fpu: Using 'lazy' FPU context switches.
[=A0=A0=A0 0.000000] e820: BIOS-provided physical RAM map:
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff]=
 usable
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a4befff]=
 usable
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000007a4bf000-0x000000007aebefff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000007aebf000-0x000000007bfbefff]=
 ACPI NVS
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000007bfbf000-0x000000007bffefff]=
 ACPI data
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000007bfff000-0x000000007bffffff]=
 usable
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x000000007c400000-0x000000007fffffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]=
 reserved
[=A0=A0=A0 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff]=
 usable
[=A0=A0=A0 0.000000] NX (Execute Disable) protection: active
[=A0=A0=A0 0.000000] SMBIOS 2.8 present.
[=A0=A0=A0 0.000000] DMI: SECO UDOO x86/UDOO x86, BIOS 1.03 08/04/2017
[=A0=A0=A0 0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D=
> reserved
[=A0=A0=A0 0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[=A0=A0=A0 0.000000] e820: last_pfn =3D 0x280000 max_arch_pfn =3D 0x4000000=
00
[=A0=A0=A0 0.000000] MTRR default type: uncachable
[=A0=A0=A0 0.000000] MTRR fixed ranges enabled:
[=A0=A0=A0 0.000000]=A0=A0 00000-9FFFF write-back
[=A0=A0=A0 0.000000]=A0=A0 A0000-BFFFF uncachable
[=A0=A0=A0 0.000000]=A0=A0 C0000-FFFFF write-protect
[=A0=A0=A0 0.000000] MTRR variable ranges enabled:
[=A0=A0=A0 0.000000]=A0=A0 0 base 0FFC00000 mask FFFC00000 write-protect
[=A0=A0=A0 0.000000]=A0=A0 1 base 000000000 mask F80000000 write-back
[=A0=A0=A0 0.000000]=A0=A0 2 base 07E000000 mask FFE000000 uncachable
[=A0=A0=A0 0.000000]=A0=A0 3 base 07D000000 mask FFF000000 uncachable
[=A0=A0=A0 0.000000]=A0=A0 4 base 07C800000 mask FFF800000 uncachable
[=A0=A0=A0 0.000000]=A0=A0 5 base 07C400000 mask FFFC00000 uncachable
[=A0=A0=A0 0.000000]=A0=A0 6 base 100000000 mask F00000000 write-back
[=A0=A0=A0 0.000000]=A0=A0 7 base 200000000 mask F80000000 write-back
[=A0=A0=A0 0.000000] x86/PAT: Configuration [0-7]: WB=A0 WC=A0 UC- UC=A0 WB=
=A0 WC=A0 UC- WT=A0=20
[=A0=A0=A0 0.000000] e820: last_pfn =3D 0x7c000 max_arch_pfn =3D 0x40000000=
0
[=A0=A0=A0 0.000000] Scanning 1 areas for low memory corruption
[=A0=A0=A0 0.000000] Base memory trampoline at [ffff93fd40098000] 98000 siz=
e 24576
[=A0=A0=A0 0.000000] BRK [0x2295b4000, 0x2295b4fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295b5000, 0x2295b5fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295b6000, 0x2295b6fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295b7000, 0x2295b7fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295b8000, 0x2295b8fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295b9000, 0x2295b9fff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295ba000, 0x2295bafff] PGTABLE
[=A0=A0=A0 0.000000] BRK [0x2295bb000, 0x2295bbfff] PGTABLE
[=A0=A0=A0 0.000000] RAMDISK: [mem 0x10102000-0x24078fff]
[=A0=A0=A0 0.000000] ACPI: Early table checksum verification disabled
[=A0=A0=A0 0.000000] ACPI: RSDP 0x00000000000FE020 000024 (v02 INSYDE)
[=A0=A0=A0 0.000000] ACPI: XSDT 0x000000007BFFE120 00009C (v01 INSYDE INSYD=
E=A0=A0 00000003=A0=A0=A0=A0=A0 01000013)
[=A0=A0=A0 0.000000] ACPI: FACP 0x000000007BFF9000 00010C (v05 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: DSDT 0x000000007BFEB000 008BA4 (v02 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: FACS 0x000000007BFAB000 000040
[=A0=A0=A0 0.000000] ACPI: UEFI 0x000000007BFFD000 000236 (v01 INSYDE INSYD=
E=A0=A0 00000001 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: TCPA 0x000000007BFFC000 000032 (v02 INSYDE INSYD=
E=A0=A0 00000000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: UEFI 0x000000007BFFA000 000042 (v01 INSYDE INSYD=
E=A0=A0 00000000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: APIC 0x000000007BFF8000 000084 (v03 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: MCFG 0x000000007BFF7000 00003C (v01 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: SLIC 0x000000007BFF6000 000176 (v01 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: WDAT 0x000000007BFF5000 0001C4 (v01 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: WDRT 0x000000007BFF4000 000047 (v01 INSYDE INSYD=
E=A0=A0 00000003 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: SSDT 0x000000007BFEA000 0007A1 (v01 INSYDE CpuPm=
=A0=A0=A0 00003000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: SSDT 0x000000007BFE9000 0002B5 (v01 INSYDE Cpu0T=
st=A0 00003000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: SSDT 0x000000007BFE8000 0001DE (v01 INSYDE ApTst=
=A0=A0=A0 00003000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: SSDT 0x000000007BFE7000 000469 (v01 INSYDE Tpm2T=
abl 00001000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: TPM2 0x000000007BFE6000 000034 (v03 INSYDE INSYD=
E=A0=A0 00000000 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: FPDT 0x000000007BFE5000 000044 (v01 INSYDE INSYD=
E=A0=A0 00000002 ACPI 00040000)
[=A0=A0=A0 0.000000] ACPI: Local APIC address 0xfee00000
[=A0=A0=A0 0.000000] No NUMA configuration found
[=A0=A0=A0 0.000000] Faking a node at [mem 0x0000000000000000-0x000000027ff=
fffff]
[=A0=A0=A0 0.000000] NODE_DATA(0) allocated [mem 0x27ffd9000-0x27fffafff]
[=A0=A0=A0 0.000000] Zone ranges:
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0 [mem 0x0000000000001000-0x000=
0000000ffffff]
[=A0=A0=A0 0.000000]=A0=A0 DMA32=A0=A0=A0 [mem 0x0000000001000000-0x0000000=
0ffffffff]
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0 [mem 0x0000000100000000-0x000000027=
fffffff]
[=A0=A0=A0 0.000000] Movable zone start for each node
[=A0=A0=A0 0.000000] Early memory node ranges
[=A0=A0=A0 0.000000]=A0=A0 node=A0=A0 0: [mem 0x0000000000001000-0x00000000=
0009dfff]
[=A0=A0=A0 0.000000]=A0=A0 node=A0=A0 0: [mem 0x0000000000100000-0x00000000=
7a4befff]
[=A0=A0=A0 0.000000]=A0=A0 node=A0=A0 0: [mem 0x000000007bfff000-0x00000000=
7bffffff]
[=A0=A0=A0 0.000000]=A0=A0 node=A0=A0 0: [mem 0x0000000100000000-0x00000002=
7fffffff]
[=A0=A0=A0 0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000=
27fffffff]
[=A0=A0=A0 0.000000] On node 0 totalpages: 2073693
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 64 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 21 pages reserved
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 3997 pages, LIFO batch:0
[=A0=A0=A0 0.000000]=A0=A0 DMA32 zone: 7763 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 DMA32 zone: 496832 pages, LIFO batch:31
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 24576 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 1572864 pages, LIFO batch:31
[=A0=A0=A0 0.000000] Reserving Intel graphics memory at 0x000000007cc00000-=
0x000000007ebfffff
[=A0=A0=A0 0.000000] ACPI: PM-Timer IO Port: 0x408
[=A0=A0=A0 0.000000] ACPI: Local APIC address 0xfee00000
[=A0=A0=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[=A0=A0=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[=A0=A0=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[=A0=A0=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[=A0=A0=A0 0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, =
GSI 0-114
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl df=
l)
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high l=
evel)
[=A0=A0=A0 0.000000] ACPI: IRQ0 used by override.
[=A0=A0=A0 0.000000] ACPI: IRQ9 used by override.
[=A0=A0=A0 0.000000] Using ACPI (MADT) for SMP configuration information
[=A0=A0=A0 0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ef=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x7a4bf000-0x7aebef=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x7aebf000-0x7bfbef=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x7bfbf000-0x7bffef=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x7c000000-0x7c3fff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x7c400000-0x7fffff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0x80000000-0xdfffff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xe3ffff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfe9fff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfeafff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfebfff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed00f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed01f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed02000-0xfed02f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed03000-0xfed03f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed07f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed09f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed0a000-0xfed1bf=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1cf=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed1d000-0xfed7ff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfedbff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfedc0000-0xfedfff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00f=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfff=
ff]
[=A0=A0=A0 0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffff=
ff]
[=A0=A0=A0 0.000000] e820: [mem 0x80000000-0xdfffffff] available for PCI de=
vices
[=A0=A0=A0 0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cyc=
les: 0xffffffff, max_idle_ns: 1910969940391419 ns
[=A0=A0=A0 0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_i=
ds:4 nr_node_ids:1
[=A0=A0=A0 0.000000] percpu: Embedded 171 pages/cpu @ffff93ffb7200000 s6598=
64 r8192 d32360 u1048576
[=A0=A0=A0 0.000000] pcpu-alloc: s659864 r8192 d32360 u1048576 alloc=3D1*20=
97152
[=A0=A0=A0 0.000000] pcpu-alloc: [0] 0 1 [0] 2 3=20
[=A0=A0=A0 0.000000] Built 1 zonelists in Node order, mobility grouping on.=
=A0 Total pages: 2041269
[=A0=A0=A0 0.000000] Policy zone: Normal
[=A0=A0=A0 0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-4.9.90=
-xenomai root=3DUUID=3Dca0244c5-d957-4ab6-8632-01fd821fcc06 ro quiet splash=
 vt.handoff=3D7
[=A0=A0=A0 0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[=A0=A0=A0 0.000000] Calgary: detecting Calgary via BIOS EBDA area
[=A0=A0=A0 0.000000] Calgary: Unable to locate Rio Grande table in EBDA - b=
ailing!
[=A0=A0=A0 0.000000] Memory: 7741208K/8294772K available (8560K kernel code=
, 1458K rwdata, 3504K rodata, 2328K init, 8152K bss, 553564K reserved, 0K c=
ma-reserved)
[=A0=A0=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=
=3D4, Nodes=3D1
[=A0=A0=A0 0.000000] Kernel/User page tables isolation: enabled
[=A0=A0=A0 0.000000] Hierarchical RCU implementation.
[=A0=A0=A0 0.000000] Build-time adjustment of leaf fanout to 64.
[=A0=A0=A0 0.000000] RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D4.
[=A0=A0=A0 0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_c=
pu_ids=3D4
[=A0=A0=A0 0.000000] NR_IRQS:33024 nr_irqs:1024 16
[=A0=A0=A0 0.000000] Interrupt pipeline (release #6)
[=A0=A0=A0 0.000000] Console: colour dummy device 80x25
[=A0=A0=A0 0.000000] console [tty0] enabled
[=A0=A0=A0 0.000000] tsc: Detected 1600.000 MHz processor
[=A0=A0=A0 0.000046] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 3200.00 BogoMIPS (lpj=3D1600000)
[=A0=A0=A0 0.000053] pid_max: default: 32768 minimum: 301
[=A0=A0=A0 0.000084] ACPI: Core revision 20160831
[=A0=A0=A0 0.016946] ACPI: 5 ACPI AML tables successfully acquired and load=
ed
[=A0=A0=A0 0.017040] Security Framework initialized
[=A0=A0=A0 0.017044] Yama: becoming mindful.
[=A0=A0=A0 0.017052] SELinux:=A0 Disabled at boot.
[=A0=A0=A0 0.017056] AppArmor: AppArmor disabled by boot time parameter
[=A0=A0=A0 0.018321] Dentry cache hash table entries: 1048576 (order: 11, 8=
388608 bytes)
[=A0=A0=A0 0.022840] Inode-cache hash table entries: 524288 (order: 10, 419=
4304 bytes)
[=A0=A0=A0 0.024863] Mount-cache hash table entries: 16384 (order: 5, 13107=
2 bytes)
[=A0=A0=A0 0.024886] Mountpoint-cache hash table entries: 16384 (order: 5, =
131072 bytes)
[=A0=A0=A0 0.025532] CPU: Physical Processor ID: 0
[=A0=A0=A0 0.025535] CPU: Processor Core ID: 0
[=A0=A0=A0 0.025542] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[=A0=A0=A0 0.025543] ENERGY_PERF_BIAS: View and update with x86_energy_perf=
_policy(8)
[=A0=A0=A0 0.025554] mce: CPU supports 6 MCE banks
[=A0=A0=A0 0.025567] CPU0: Thermal monitoring enabled (TM1)
[=A0=A0=A0 0.025576] process: using mwait in idle threads
[=A0=A0=A0 0.025583] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[=A0=A0=A0 0.025585] Last level dTLB entries: 4KB 256, 2MB 16, 4MB 16, 1GB =
0
[=A0=A0=A0 0.025589] Spectre V2 : Mitigation: Full generic retpoline
[=A0=A0=A0 0.026487] Freeing SMP alternatives memory: 32K
[=A0=A0=A0 0.026872] smpboot: Max logical packages: 1
[=A0=A0=A0 0.028942] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 p=
in2=3D-1
[=A0=A0=A0 0.038979] TSC deadline timer enabled
[=A0=A0=A0 0.038985] smpboot: CPU0: Intel(R) Pentium(R) CPU=A0 N3710=A0 @ 1=
.60GHz (family: 0x6, model: 0x4c, stepping: 0x4)
[=A0=A0=A0 0.038996] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont=
 events, 8-deep LBR, full-width counters, Intel PMU driver.
[=A0=A0=A0 0.039034] ... version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 3
[=A0=A0=A0 0.039036] ... bit width:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
40
[=A0=A0=A0 0.039038] ... generic registers:=A0=A0=A0=A0=A0 2
[=A0=A0=A0 0.039040] ... value mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
0000ffffffffff
[=A0=A0=A0 0.039042] ... max period:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
00007fffffffff
[=A0=A0=A0 0.039044] ... fixed-purpose events:=A0=A0 3
[=A0=A0=A0 0.039046] ... event mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
00000700000003
[=A0=A0=A0 0.040927] NMI watchdog: enabled on all CPUs, permanently consume=
s one hw-PMU counter.
[=A0=A0=A0 0.041357] x86: Booting SMP configuration:
[=A0=A0=A0 0.041361] .... node=A0 #0, CPUs:=A0=A0=A0=A0=A0 #1 #2 #3
[=A0=A0=A0 0.048959] x86: Booted up 1 node, 4 CPUs
[=A0=A0=A0 0.048964] smpboot: Total of 4 processors activated (12800.00 Bog=
oMIPS)
[=A0=A0=A0 0.051299] devtmpfs: initialized
[=A0=A0=A0 0.051489] x86/mm: Memory block size: 128MB
[=A0=A0=A0 0.061416] evm: security.selinux
[=A0=A0=A0 0.061418] evm: security.SMACK64
[=A0=A0=A0 0.061420] evm: security.SMACK64EXEC
[=A0=A0=A0 0.061421] evm: security.SMACK64TRANSMUTE
[=A0=A0=A0 0.061423] evm: security.SMACK64MMAP
[=A0=A0=A0 0.061425] evm: security.ima
[=A0=A0=A0 0.061426] evm: security.capability
[=A0=A0=A0 0.061593] PM: Registering ACPI NVS region [mem 0x7aebf000-0x7bfb=
efff] (17825792 bytes)
[=A0=A0=A0 0.062505] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 1911260446275000 ns
[=A0=A0=A0 0.062529] futex hash table entries: 1024 (order: 4, 65536 bytes)
[=A0=A0=A0 0.062661] pinctrl core: initialized pinctrl subsystem
[=A0=A0=A0 0.062967] RTC time:=A0 6:19:44, date: 04/23/18
[=A0=A0=A0 0.063196] NET: Registered protocol family 16
[=A0=A0=A0 0.063894] PCCT header not found.
[=A0=A0=A0 0.063997] ACPI: bus type PCI registered
[=A0=A0=A0 0.064001] acpiphp: ACPI Hot Plug PCI Controller Driver version: =
0.5
[=A0=A0=A0 0.064189] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0=
000000-0xe3ffffff] (base 0xe0000000)
[=A0=A0=A0 0.064194] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved =
in E820
[=A0=A0=A0 0.064209] PCI: Using configuration type 1 for base access
[=A0=A0=A0 0.072338] HugeTLB registered 2 MB page size, pre-allocated 0 pag=
es
[=A0=A0=A0 0.073030] ACPI: Added _OSI(Module Device)
[=A0=A0=A0 0.073033] ACPI: Added _OSI(Processor Device)
[=A0=A0=A0 0.073036] ACPI: Added _OSI(3.0 _SCP Extensions)
[=A0=A0=A0 0.073038] ACPI: Added _OSI(Processor Aggregator Device)
[=A0=A0=A0 0.073432] ACPI: Executed 5 blocks of module-level executable AML=
 code
[=A0=A0=A0 0.092668] ACPI: Dynamic OEM Table Load:
[=A0=A0=A0 0.092688] ACPI: SSDT 0xFFFF93FFB597B800 0006FD (v01 PmRef=A0 Cpu=
0Ist=A0 00003000 INTL 20160527)
[=A0=A0=A0 0.093012] ACPI: Executed 1 blocks of module-level executable AML=
 code
[=A0=A0=A0 0.093359] ACPI: Dynamic OEM Table Load:
[=A0=A0=A0 0.093375] ACPI: SSDT 0xFFFF93FFB59BF800 0003CA (v01 PmRef=A0 Cpu=
0Cst=A0 00003001 INTL 20160527)
[=A0=A0=A0 0.093851] ACPI: Executed 1 blocks of module-level executable AML=
 code
[=A0=A0=A0 0.094728] ACPI: Dynamic OEM Table Load:
[=A0=A0=A0 0.094744] ACPI: SSDT 0xFFFF93FFB59FDE00 0001E0 (v01 PmRef=A0 ApI=
st=A0=A0=A0 00003000 INTL 20160527)
[=A0=A0=A0 0.095061] ACPI: Executed 1 blocks of module-level executable AML=
 code
[=A0=A0=A0 0.095347] ACPI: Dynamic OEM Table Load:
[=A0=A0=A0 0.095361] ACPI: SSDT 0xFFFF93FFB59ECE00 0000C9 (v01 PmRef=A0 ApC=
st=A0=A0=A0 00003000 INTL 20160527)
[=A0=A0=A0 0.095570] ACPI: Executed 1 blocks of module-level executable AML=
 code
[=A0=A0=A0 0.098797] ACPI: Interpreter enabled
[=A0=A0=A0 0.098866] ACPI: (supports S0 S3 S4 S5)
[=A0=A0=A0 0.098869] ACPI: Using IOAPIC for interrupt routing
[=A0=A0=A0 0.098973] PCI: Using host bridge windows from ACPI; if necessary=
, use "pci=3Dnocrs" and report a bug
[=A0=A0=A0 0.099086] platform wdat_wdt: failed to claim resource 4
[=A0=A0=A0 0.099101] ACPI: watchdog: Failed to create platform device
[=A0=A0=A0 0.101997] ACPI: Power Resource [USBC] (on)
[=A0=A0=A0 0.114858] ACPI: Power Resource [ID3C] (off)
[=A0=A0=A0 0.124663] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[=A0=A0=A0 0.124676] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASP=
M ClockPM Segments MSI]
[=A0=A0=A0 0.124846] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASP=
M
[=A0=A0=A0 0.124878] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain =
0000 [bus 00-3f] only partially covers this bridge
[=A0=A0=A0 0.125241] acpi PNP0A08:00: host bridge window expanded to [mem 0=
x80000000-0xdfffffff window]; [mem 0x80000000-0xdfffffff window] ignored
[=A0=A0=A0 0.125905] PCI host bridge to bus 0000:00
[=A0=A0=A0 0.125911] pci_bus 0000:00: root bus resource [io=A0 0x0070-0x007=
7]
[=A0=A0=A0 0.125915] pci_bus 0000:00: root bus resource [io=A0 0x0000-0x006=
f window]
[=A0=A0=A0 0.125918] pci_bus 0000:00: root bus resource [io=A0 0x0078-0x0cf=
7 window]
[=A0=A0=A0 0.125922] pci_bus 0000:00: root bus resource [io=A0 0x0d00-0xfff=
f window]
[=A0=A0=A0 0.125926] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x0=
00bffff window]
[=A0=A0=A0 0.125930] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x0=
00dffff window]
[=A0=A0=A0 0.125933] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x0=
00fffff window]
[=A0=A0=A0 0.125937] pci_bus 0000:00: root bus resource [mem 0x80000000-0xd=
fffffff window]
[=A0=A0=A0 0.125941] pci_bus 0000:00: root bus resource [bus 00-ff]
[=A0=A0=A0 0.125958] pci 0000:00:00.0: [8086:2280] type 00 class 0x060000
[=A0=A0=A0 0.126371] pci 0000:00:02.0: [8086:22b1] type 00 class 0x030000
[=A0=A0=A0 0.126411] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x90ffffff=
 64bit]
[=A0=A0=A0 0.126435] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff=
 64bit pref]
[=A0=A0=A0 0.126452] pci 0000:00:02.0: reg 0x20: [io=A0 0x2000-0x203f]
[=A0=A0=A0 0.126834] pci 0000:00:13.0: [8086:22a3] type 00 class 0x010601
[=A0=A0=A0 0.126916] pci 0000:00:13.0: reg 0x20: [io=A0 0x2060-0x207f]
[=A0=A0=A0 0.126933] pci 0000:00:13.0: reg 0x24: [mem 0x9141e000-0x9141e7ff=
]
[=A0=A0=A0 0.127019] pci 0000:00:13.0: PME# supported from D3hot
[=A0=A0=A0 0.127310] pci 0000:00:14.0: [8086:22b5] type 00 class 0x0c0330
[=A0=A0=A0 0.127347] pci 0000:00:14.0: reg 0x10: [mem 0x91400000-0x9140ffff=
 64bit]
[=A0=A0=A0 0.127480] pci 0000:00:14.0: PME# supported from D3hot D3cold
[=A0=A0=A0 0.127696] pci 0000:00:14.0: System wakeup disabled by ACPI
[=A0=A0=A0 0.127827] pci 0000:00:1a.0: [8086:2298] type 00 class 0x108000
[=A0=A0=A0 0.127856] pci 0000:00:1a.0: reg 0x10: [mem 0x91300000-0x913fffff=
]
[=A0=A0=A0 0.127873] pci 0000:00:1a.0: reg 0x14: [mem 0x91200000-0x912fffff=
]
[=A0=A0=A0 0.128003] pci 0000:00:1a.0: PME# supported from D0 D3hot
[=A0=A0=A0 0.128393] pci 0000:00:1b.0: [8086:2284] type 00 class 0x040300
[=A0=A0=A0 0.128431] pci 0000:00:1b.0: reg 0x10: [mem 0x91410000-0x91413fff=
 64bit]
[=A0=A0=A0 0.128562] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 0.128746] pci 0000:00:1b.0: System wakeup disabled by ACPI
[=A0=A0=A0 0.128865] pci 0000:00:1c.0: [8086:22c8] type 01 class 0x060400
[=A0=A0=A0 0.129007] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 0.129196] pci 0000:00:1c.0: System wakeup disabled by ACPI
[=A0=A0=A0 0.129318] pci 0000:00:1c.2: [8086:22cc] type 01 class 0x060400
[=A0=A0=A0 0.129462] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 0.129638] pci 0000:00:1c.2: System wakeup disabled by ACPI
[=A0=A0=A0 0.129772] pci 0000:00:1f.0: [8086:229c] type 00 class 0x060100
[=A0=A0=A0 0.130194] pci 0000:00:1f.3: [8086:2292] type 00 class 0x0c0500
[=A0=A0=A0 0.130253] pci 0000:00:1f.3: reg 0x10: [mem 0x91418000-0x9141801f=
]
[=A0=A0=A0 0.130380] pci 0000:00:1f.3: reg 0x20: [io=A0 0x2040-0x205f]
[=A0=A0=A0 0.130929] pci 0000:00:1c.0: PCI bridge to [bus 01]
[=A0=A0=A0 0.131120] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[=A0=A0=A0 0.131152] pci 0000:02:00.0: reg 0x10: [io=A0 0x1000-0x10ff]
[=A0=A0=A0 0.131198] pci 0000:02:00.0: reg 0x18: [mem 0x91100000-0x91100fff=
 64bit]
[=A0=A0=A0 0.131226] pci 0000:02:00.0: reg 0x20: [mem 0x91000000-0x91003fff=
 64bit pref]
[=A0=A0=A0 0.131384] pci 0000:02:00.0: supports D1 D2
[=A0=A0=A0 0.131388] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D=
3cold
[=A0=A0=A0 0.131493] pci 0000:02:00.0: System wakeup disabled by ACPI
[=A0=A0=A0 0.135119] pci 0000:00:1c.2: PCI bridge to [bus 02]
[=A0=A0=A0 0.135127] pci 0000:00:1c.2:=A0=A0 bridge window [io=A0 0x1000-0x=
1fff]
[=A0=A0=A0 0.135134] pci 0000:00:1c.2:=A0=A0 bridge window [mem 0x91100000-=
0x911fffff]
[=A0=A0=A0 0.135145] pci 0000:00:1c.2:=A0=A0 bridge window [mem 0x91000000-=
0x910fffff 64bit pref]
[=A0=A0=A0 1.198132] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12=
 14 15) *7
[=A0=A0=A0 1.198345] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12=
 14 15) *0, disabled.
[=A0=A0=A0 1.198558] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 1=
2 14 15)
[=A0=A0=A0 1.198768] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 1=
2 14 15)
[=A0=A0=A0 1.198977] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 1=
2 14 15)
[=A0=A0=A0 1.199198] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 1=
2 14 15)
[=A0=A0=A0 1.199408] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12=
 14 15) *7
[=A0=A0=A0 1.199618] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12=
 14 15) *0, disabled.
[=A0=A0=A0 1.211378] ACPI: Enabled 6 GPEs in block 00 to 3F
[=A0=A0=A0 1.211669] vgaarb: setting as boot device: PCI:0000:00:02.0
[=A0=A0=A0 1.211673] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+me=
m,owns=3Dio+mem,locks=3Dnone
[=A0=A0=A0 1.211680] vgaarb: loaded
[=A0=A0=A0 1.211683] vgaarb: bridge control possible 0000:00:02.0
[=A0=A0=A0 1.212268] SCSI subsystem initialized
[=A0=A0=A0 1.212406] libata version 3.00 loaded.
[=A0=A0=A0 1.212463] ACPI: bus type USB registered
[=A0=A0=A0 1.212520] usbcore: registered new interface driver usbfs
[=A0=A0=A0 1.212552] usbcore: registered new interface driver hub
[=A0=A0=A0 1.212601] usbcore: registered new device driver usb
[=A0=A0=A0 1.212995] PCI: Using ACPI for IRQ routing
[=A0=A0=A0 1.215881] PCI: pci_cache_line_size set to 64 bytes
[=A0=A0=A0 1.215958] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[=A0=A0=A0 1.215963] e820: reserve RAM buffer [mem 0x7a4bf000-0x7bffffff]
[=A0=A0=A0 1.216262] NetLabel: Initializing
[=A0=A0=A0 1.216265] NetLabel:=A0 domain hash size =3D 128
[=A0=A0=A0 1.216267] NetLabel:=A0 protocols =3D UNLABELED CIPSOv4
[=A0=A0=A0 1.216294] NetLabel:=A0 unlabeled traffic allowed by default
[=A0=A0=A0 1.216510] clocksource: Switched to clocksource refined-jiffies
[=A0=A0=A0 1.239625] VFS: Disk quotas dquot_6.6.0
[=A0=A0=A0 1.239675] VFS: Dquot-cache hash table entries: 512 (order 0, 409=
6 bytes)
[=A0=A0=A0 1.239929] pnp: PnP ACPI init
[=A0=A0=A0 1.240177] system 00:00: [io=A0 0x0680-0x069f] has been reserved
[=A0=A0=A0 1.240182] system 00:00: [io=A0 0x0400-0x047f] has been reserved
[=A0=A0=A0 1.240187] system 00:00: [io=A0 0x0500-0x05fe] has been reserved
[=A0=A0=A0 1.240197] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (=
active)
[=A0=A0=A0 1.243759] system 00:01: [mem 0x91421000-0x91421fff] has been res=
erved
[=A0=A0=A0 1.243764] system 00:01: [mem 0x9141f000-0x9141ffff] has been res=
erved
[=A0=A0=A0 1.243769] system 00:01: [mem 0x9141d000-0x9141dfff] has been res=
erved
[=A0=A0=A0 1.243773] system 00:01: [mem 0x9141b000-0x9141bfff] has been res=
erved
[=A0=A0=A0 1.243778] system 00:01: [mem 0x91419000-0x91419fff] has been res=
erved
[=A0=A0=A0 1.243787] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (=
active)
[=A0=A0=A0 1.244070] system 00:02: [mem 0xe0000000-0xefffffff] could not be=
 reserved
[=A0=A0=A0 1.244075] system 00:02: [mem 0xfea00000-0xfeafffff] has been res=
erved
[=A0=A0=A0 1.244080] system 00:02: [mem 0xfed01000-0xfed01fff] has been res=
erved
[=A0=A0=A0 1.244084] system 00:02: [mem 0xfed03000-0xfed03fff] has been res=
erved
[=A0=A0=A0 1.244088] system 00:02: [mem 0xfed06000-0xfed06fff] has been res=
erved
[=A0=A0=A0 1.244092] system 00:02: [mem 0xfed08000-0xfed09fff] has been res=
erved
[=A0=A0=A0 1.244097] system 00:02: [mem 0xfed80000-0xfedbffff] could not be=
 reserved
[=A0=A0=A0 1.244101] system 00:02: [mem 0xfed1c000-0xfed1cfff] has been res=
erved
[=A0=A0=A0 1.244106] system 00:02: [mem 0xfee00000-0xfeefffff] could not be=
 reserved
[=A0=A0=A0 1.244114] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (=
active)
[=A0=A0=A0 1.244557] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (act=
ive)
[=A0=A0=A0 1.245059] pnp: PnP ACPI: found 4 devices
[=A0=A0=A0 1.255463] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xfff=
fff, max_idle_ns: 2085701024 ns
[=A0=A0=A0 1.255495] clocksource: Switched to clocksource acpi_pm
[=A0=A0=A0 1.255527] pci 0000:00:1c.0: bridge window [io=A0 0x1000-0x0fff] =
to [bus 01] add_size 1000
[=A0=A0=A0 1.255534] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000f=
ffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[=A0=A0=A0 1.255540] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000f=
ffff] to [bus 01] add_size 200000 add_align 100000
[=A0=A0=A0 1.255563] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff=
] res_to_dev_res add_size 200000 min_align 100000
[=A0=A0=A0 1.255567] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x002fffff=
] res_to_dev_res add_size 200000 min_align 100000
[=A0=A0=A0 1.255572] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x000fffff=
 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[=A0=A0=A0 1.255577] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x002fffff=
 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[=A0=A0=A0 1.255581] pci 0000:00:1c.0: res[13]=3D[io=A0 0x1000-0x0fff] res_=
to_dev_res add_size 1000 min_align 1000
[=A0=A0=A0 1.255586] pci 0000:00:1c.0: res[13]=3D[io=A0 0x1000-0x1fff] res_=
to_dev_res add_size 1000 min_align 1000
[=A0=A0=A0 1.255600] pci 0000:00:1c.0: BAR 14: assigned [mem 0x91500000-0x9=
16fffff]
[=A0=A0=A0 1.255612] pci 0000:00:1c.0: BAR 15: assigned [mem 0x91700000-0x9=
18fffff 64bit pref]
[=A0=A0=A0 1.255620] pci 0000:00:1c.0: BAR 13: assigned [io=A0 0x3000-0x3ff=
f]
[=A0=A0=A0 1.255626] pci 0000:00:1c.0: PCI bridge to [bus 01]
[=A0=A0=A0 1.255632] pci 0000:00:1c.0:=A0=A0 bridge window [io=A0 0x3000-0x=
3fff]
[=A0=A0=A0 1.255642] pci 0000:00:1c.0:=A0=A0 bridge window [mem 0x91500000-=
0x916fffff]
[=A0=A0=A0 1.255650] pci 0000:00:1c.0:=A0=A0 bridge window [mem 0x91700000-=
0x918fffff 64bit pref]
[=A0=A0=A0 1.255662] pci 0000:00:1c.2: PCI bridge to [bus 02]
[=A0=A0=A0 1.255667] pci 0000:00:1c.2:=A0=A0 bridge window [io=A0 0x1000-0x=
1fff]
[=A0=A0=A0 1.255676] pci 0000:00:1c.2:=A0=A0 bridge window [mem 0x91100000-=
0x911fffff]
[=A0=A0=A0 1.255684] pci 0000:00:1c.2:=A0=A0 bridge window [mem 0x91000000-=
0x910fffff 64bit pref]
[=A0=A0=A0 1.255696] pci_bus 0000:00: resource 4 [io=A0 0x0070-0x0077]
[=A0=A0=A0 1.255701] pci_bus 0000:00: resource 5 [io=A0 0x0000-0x006f windo=
w]
[=A0=A0=A0 1.255724] pci_bus 0000:00: resource 6 [io=A0 0x0078-0x0cf7 windo=
w]
[=A0=A0=A0 1.255728] pci_bus 0000:00: resource 7 [io=A0 0x0d00-0xffff windo=
w]
[=A0=A0=A0 1.255732] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff=
 window]
[=A0=A0=A0 1.255735] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff=
 window]
[=A0=A0=A0 1.255739] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000ffff=
f window]
[=A0=A0=A0 1.255743] pci_bus 0000:00: resource 11 [mem 0x80000000-0xdffffff=
f window]
[=A0=A0=A0 1.255747] pci_bus 0000:01: resource 0 [io=A0 0x3000-0x3fff]
[=A0=A0=A0 1.255751] pci_bus 0000:01: resource 1 [mem 0x91500000-0x916fffff=
]
[=A0=A0=A0 1.255755] pci_bus 0000:01: resource 2 [mem 0x91700000-0x918fffff=
 64bit pref]
[=A0=A0=A0 1.255759] pci_bus 0000:02: resource 0 [io=A0 0x1000-0x1fff]
[=A0=A0=A0 1.255763] pci_bus 0000:02: resource 1 [mem 0x91100000-0x911fffff=
]
[=A0=A0=A0 1.255767] pci_bus 0000:02: resource 2 [mem 0x91000000-0x910fffff=
 64bit pref]
[=A0=A0=A0 1.256066] NET: Registered protocol family 2
[=A0=A0=A0 1.256531] TCP established hash table entries: 65536 (order: 7, 5=
24288 bytes)
[=A0=A0=A0 1.256901] TCP bind hash table entries: 65536 (order: 8, 1048576 =
bytes)
[=A0=A0=A0 1.257295] TCP: Hash tables configured (established 65536 bind 65=
536)
[=A0=A0=A0 1.257403] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[=A0=A0=A0 1.257542] UDP-Lite hash table entries: 4096 (order: 5, 131072 by=
tes)
[=A0=A0=A0 1.257758] NET: Registered protocol family 1
[=A0=A0=A0 1.257798] pci 0000:00:02.0: Video device with shadowed ROM at [m=
em 0x000c0000-0x000dffff]
[=A0=A0=A0 1.259838] PCI: CLS 64 bytes, default 64
[=A0=A0=A0 1.259984] Unpacking initramfs...
[=A0=A0 12.915288] Freeing initrd memory: 327132K
[=A0=A0 12.915297] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[=A0=A0 12.915304] software IO TLB [mem 0x764bf000-0x7a4bf000] (64MB) mappe=
d at [ffff93fdb64bf000-ffff93fdba4befff]
[=A0=A0 12.915594] Scanning for low memory corruption every 60 seconds
[=A0=A0 12.916679] audit: initializing netlink subsys (disabled)
[=A0=A0 12.916729] audit: type=3D2000 audit(1524464396.904:1): initialized
[=A0=A0 12.917420] [Xenomai] scheduling class idle registered.
[=A0=A0 12.917422] [Xenomai] scheduling class rt registered.
[=A0=A0 12.917480] [Xenomai] SMI-enabled chipset found, but SMI workaround =
disabled
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (s=
ee xenomai.smi parameter). You might encounter
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hi=
gh latencies!
[=A0=A0 12.918467] I-pipe: head domain Xenomai registered.
[=A0=A0 12.920801] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)=20
[=A0=A0 12.920805] Initialise system trusted keyrings
[=A0=A0 12.921039] workingset: timestamp_bits=3D36 max_order=3D21 bucket_or=
der=3D0
[=A0=A0 12.926710] zbud: loaded
[=A0=A0 12.928280] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[=A0=A0 12.928809] fuse init (API version 7.26)
[=A0=A0 12.932995] Key type asymmetric registered
[=A0=A0 12.932998] Asymmetric key parser 'x509' registered
[=A0=A0 12.933141] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 246)
[=A0=A0 12.933237] io scheduler noop registered
[=A0=A0 12.933240] io scheduler deadline registered
[=A0=A0 12.933338] io scheduler cfq registered (default)
[=A0=A0 12.934073] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[=A0=A0 12.934088] pciehp: PCI Express Hot Plug Controller Driver version: =
0.4
[=A0=A0 12.934212] efifb: probing for efifb
[=A0=A0 12.934218] efifb: framebuffer at 0xa0000, using 64k, total 64k
[=A0=A0 12.934221] efifb: mode is 640x480x1, linelength=3D80, pages=3D1
[=A0=A0 12.934222] efifb: scrolling: redraw
[=A0=A0 12.934226] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[=A0=A0 12.937678] Console: switching to colour frame buffer device 80x30
[=A0=A0 12.940872] fb0: EFI VGA frame buffer device
[=A0=A0 12.941098] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0C:01/input/input0
[=A0=A0 12.941104] ACPI: Power Button [PWR2]
[=A0=A0 12.941244] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0E:00/input/input1
[=A0=A0 12.941250] ACPI: Sleep Button [SLPB]
[=A0=A0 12.941368] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/=
input/input2
[=A0=A0 12.941374] ACPI: Power Button [PWRF]
[=A0=A0 12.941496] GHES: HEST is not enabled!
[=A0=A0 12.941696] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[=A0=A0 12.946589] Linux agpgart interface v0.103
[=A0=A0 12.951755] loop: module loaded
[=A0=A0 12.952318] libphy: Fixed MDIO Bus: probed
[=A0=A0 12.952321] tun: Universal TUN/TAP device driver, 1.6
[=A0=A0 12.952323] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[=A0=A0 12.952427] PPP generic driver version 2.4.2
[=A0=A0 12.952563] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[=A0=A0 12.952572] ehci-pci: EHCI PCI platform driver
[=A0=A0 12.952604] ehci-platform: EHCI generic platform driver
[=A0=A0 12.952639] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[=A0=A0 12.952645] ohci-pci: OHCI PCI platform driver
[=A0=A0 12.952668] ohci-platform: OHCI generic platform driver
[=A0=A0 12.952688] uhci_hcd: USB Universal Host Controller Interface driver
[=A0=A0 12.953162] xhci_hcd 0000:00:14.0: xHCI Host Controller
[=A0=A0 12.953177] xhci_hcd 0000:00:14.0: new USB bus registered, assigned =
bus number 1
[=A0=A0 12.954354] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version=
 0x100 quirks 0x01509810
[=A0=A0 12.954368] xhci_hcd 0000:00:14.0: cache line size of 64 is not supp=
orted
[=A0=A0 12.954619] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[=A0=A0 12.954623] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[=A0=A0 12.954627] usb usb1: Product: xHCI Host Controller
[=A0=A0 12.954630] usb usb1: Manufacturer: Linux 4.9.90-xenomai xhci-hcd
[=A0=A0 12.954633] usb usb1: SerialNumber: 0000:00:14.0
[=A0=A0 12.954981] hub 1-0:1.0: USB hub found
[=A0=A0 12.955016] hub 1-0:1.0: 7 ports detected
[=A0=A0 12.956601] xhci_hcd 0000:00:14.0: xHCI Host Controller
[=A0=A0 12.956614] xhci_hcd 0000:00:14.0: new USB bus registered, assigned =
bus number 2
[=A0=A0 12.956731] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003
[=A0=A0 12.956735] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[=A0=A0 12.956739] usb usb2: Product: xHCI Host Controller
[=A0=A0 12.956742] usb usb2: Manufacturer: Linux 4.9.90-xenomai xhci-hcd
[=A0=A0 12.956745] usb usb2: SerialNumber: 0000:00:14.0
[=A0=A0 12.957068] hub 2-0:1.0: USB hub found
[=A0=A0 12.957097] hub 2-0:1.0: 6 ports detected
[=A0=A0 12.958783] i8042: PNP: No PS/2 controller found. Probing ports dire=
ctly.
[=A0=A0 13.930145] tsc: Refined TSC clocksource calibration: 1599.948 MHz
[=A0=A0 13.930162] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0=
x170ff3c37d3, max_idle_ns: 440795211487 ns
[=A0=A0 14.022145] i8042: No controller found
[=A0=A0 14.022413] mousedev: PS/2 mouse device common for all mice
[=A0=A0 14.022940] rtc_cmos 00:03: RTC can wake from S4
[=A0=A0 14.023281] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[=A0=A0 14.023331] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes n=
vram
[=A0=A0 14.023348] i2c /dev entries driver
[=A0=A0 14.023535] device-mapper: uevent: version 1.0.3
[=A0=A0 14.023761] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initiali=
sed: dm-devel@redhat.com
[=A0=A0 14.023862] ledtrig-cpu: registered to indicate activity on CPUs
[=A0=A0 14.024761] NET: Registered protocol family 17
[=A0=A0 14.024794] Key type dns_resolver registered
[=A0=A0 14.025501] microcode: sig=3D0x406c4, pf=3D0x1, revision=3D0x40a
[=A0=A0 14.025643] microcode: Microcode Update Driver: v2.01 <tigran@aivazi=
an.fsnet.co.uk>, Peter Oruba
[=A0=A0 14.026151] registered taskstats version 1
[=A0=A0 14.026174] Loading compiled-in X.509 certificates
[=A0=A0 14.035654] Loaded X.509 cert 'Build time autogenerated kernel key: =
c49296fd12ce3f0ef222c034ec5e95a3df70daee'
[=A0=A0 14.035712] zswap: loaded using pool lzo/zbud
[=A0=A0 14.049683] Key type big_key registered
[=A0=A0 14.056572] Key type trusted registered
[=A0=A0 14.070181] Key type encrypted registered
[=A0=A0 14.070190] ima: No TPM chip found, activating TPM-bypass!
[=A0=A0 14.070271] evm: HMAC attrs: 0x1
[=A0=A0 14.071285]=A0=A0 Magic number: 14:620:317
[=A0=A0 14.071368] tty tty42: hash matches
[=A0=A0 14.071447] reg-dummy reg-dummy: hash matches
[=A0=A0 14.071571] rtc_cmos 00:03: setting system clock to 2018-04-23 06:19=
:58 UTC (1524464398)
[=A0=A0 14.071720] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[=A0=A0 14.071722] EDD information not available.
[=A0=A0 14.071961] PM: Hibernation image not present or could not be loaded=
.
[=A0=A0 14.078053] Freeing unused kernel memory: 2328K
[=A0=A0 14.078117] Write protecting the kernel read-only data: 14336k
[=A0=A0 14.079515] Freeing unused kernel memory: 1660K
[=A0=A0 14.083520] Freeing unused kernel memory: 592K
[=A0=A0 14.115312] x86/mm: Checked W+X mappings: passed, no W+X pages found=
.
[=A0=A0 14.153109] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.153429] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.153492] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.155238] random: udevadm: uninitialized urandom read (16 bytes re=
ad)
[=A0=A0 14.155320] random: udevadm: uninitialized urandom read (16 bytes re=
ad)
[=A0=A0 14.178119] usb 1-2: new low-speed USB device number 2 using xhci_hc=
d
[=A0=A0 14.191967] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.192091] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.192124] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.192889] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.192959] random: systemd-udevd: uninitialized urandom read (16 by=
tes read)
[=A0=A0 14.361336] sdhci: Secure Digital Host Controller Interface driver
[=A0=A0 14.361339] sdhci: Copyright(c) Pierre Ossman
[=A0=A0 14.372529] usb 1-2: New USB device found, idVendor=3D1a2c, idProduc=
t=3D0c21
[=A0=A0 14.372535] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[=A0=A0 14.372538] usb 1-2: Product: USB Keyboard
[=A0=A0 14.372541] usb 1-2: Manufacturer: USB
[=A0=A0 14.390355] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[=A0=A0 14.399502] FUJITSU Extended Socket Network Device Driver - version =
1.1 - Copyright (c) 2015 FUJITSU LIMITED
[=A0=A0 14.484761] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[=A0=A0 14.484788] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have =
ASPM control
[=A0=A0 14.489404] r8169 0000:02:00.0 eth0: RTL8168g/8111g at 0xffffa18c40d=
05000, 00:c0:08:92:44:62, XID 0c000800 IRQ 310
[=A0=A0 14.489409] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200 by=
tes, tx checksumming: ko]
[=A0=A0 14.533108] usb 1-3: new low-speed USB device number 3 using xhci_hc=
d
[=A0=A0 14.662195] [drm] Initialized
[=A0=A0 14.706523] usb 1-3: New USB device found, idVendor=3D046d, idProduc=
t=3Dc05a
[=A0=A0 14.706529] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[=A0=A0 14.706532] usb 1-3: Product: USB Optical Mouse
[=A0=A0 14.706536] usb 1-3: Manufacturer: Logitech
[=A0=A0 14.712467] mmc0: new HS200 MMC card at address 0001
[=A0=A0 14.821163] hidraw: raw HID events driver (C) Jiri Kosina
[=A0=A0 14.853592] usbcore: registered new interface driver usbhid
[=A0=A0 14.853595] usbhid: USB HID core driver
[=A0=A0 14.857654] r8169 0000:02:00.0 enp2s0: renamed from eth0
[=A0=A0 14.871624] input: USB USB Keyboard as /devices/pci0000:00/0000:00:1=
4.0/usb1/1-2/1-2:1.0/0003:1A2C:0C21.0001/input/input3
[=A0=A0 14.923377] hid-generic 0003:1A2C:0C21.0001: input,hidraw0: USB HID =
v1.10 Keyboard [USB USB Keyboard] on usb-0000:00:14.0-2/input0
[=A0=A0 14.923922] input: USB USB Keyboard as /devices/pci0000:00/0000:00:1=
4.0/usb1/1-2/1-2:1.1/0003:1A2C:0C21.0002/input/input4
[=A0=A0 15.567083] clocksource: Switched to clocksource tsc
[=A0=A0 15.567654] hid-generic 0003:1A2C:0C21.0002: input,hidraw1: USB HID =
v1.10 Mouse [USB USB Keyboard] on usb-0000:00:14.0-2/input1
[=A0=A0 15.568251] input: Logitech USB Optical Mouse as /devices/pci0000:00=
/0000:00:14.0/usb1/1-3/1-3:1.0/0003:046D:C05A.0003/input/input5
[=A0=A0 15.568550] hid-generic 0003:046D:C05A.0003: input,hidraw2: USB HID =
v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-3/input0
[=A0=A0 15.574224] mmc1: SDHCI controller on ACPI [80860F14:01] using ADMA
[=A0=A0 15.574609] ahci 0000:00:13.0: version 3.0
[=A0=A0 15.575226] ahci 0000:00:13.0: AHCI 0001.0301 32 slots 2 ports 6 Gbp=
s 0x3 impl SATA mode
[=A0=A0 15.575234] ahci 0000:00:13.0: flags: 64bit ncq led clo only pio slu=
m part deso sadm sds apst=20
[=A0=A0 15.576264] scsi host0: ahci
[=A0=A0 15.576622] scsi host1: ahci
[=A0=A0 15.576809] ata1: SATA max UDMA/133 abar m2048@0x9141e000 port 0x914=
1e100 irq 311
[=A0=A0 15.576815] ata2: SATA max UDMA/133 abar m2048@0x9141e000 port 0x914=
1e180 irq 311
[=A0=A0 15.581813] [drm] Memory usable by graphics device =3D 2048M
[=A0=A0 15.581819] checking generic (a0000 10000) vs hw (80000000 10000000)
[=A0=A0 15.581822] fb: switching to inteldrmfb from EFI VGA
[=A0=A0 15.581893] Console: switching to colour dummy device 80x25
[=A0=A0 15.582107] [drm] Replacing VGA console driver
[=A0=A0 15.582375] [drm] Supports vblank timestamp caching Rev 2 (21.10.201=
3).
[=A0=A0 15.582377] [drm] Driver supports precise vblank timestamp query.
[=A0=A0 15.595253] mmcblk0: mmc0:0001 DF4032 29.1 GiB=20
[=A0=A0 15.595532] mmcblk0boot0: mmc0:0001 DF4032 partition 1 4.00 MiB
[=A0=A0 15.595798] mmcblk0boot1: mmc0:0001 DF4032 partition 2 4.00 MiB
[=A0=A0 15.596175] mmcblk0rpmb: mmc0:0001 DF4032 partition 3 4.00 MiB
[=A0=A0 15.597963] vgaarb: device changed decodes: PCI:0000:00:02.0,olddeco=
des=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[=A0=A0 15.616792]=A0 mmcblk0: p1
[=A0=A0 15.630617] random: fast init done
[=A0=A0 15.716852] ACPI: Video Device [GFX0] (multi-head: yes=A0 rom: no=A0=
 post: no)
[=A0=A0 15.718657] acpi device:2b: registered as cooling_device0
[=A0=A0 15.718877] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0A08:00/LNXVIDEO:00/input/input6
[=A0=A0 15.719193] [drm] Initialized i915 1.6.0 20160919 for 0000:00:02.0 o=
n minor 0
[=A0=A0 15.822557] fbcon: inteldrmfb (fb0) is primary device
[=A0=A0 15.891359] ata1: SATA link down (SStatus 0 SControl 300)
[=A0=A0 15.891398] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[=A0=A0 15.957074] Console: switching to colour frame buffer device 210x65
[=A0=A0 15.983112] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[=A0=A0 20.969889] ata2.00: qc timeout (cmd 0x47)
[=A0=A0 20.970918] ata2.00: READ LOG DMA EXT failed, trying unqueued
[=A0=A0 20.970923] ata2.00: failed to get Log Directory Emask 0x40
[=A0=A0 20.970926] ata2.00: ATA-10: GOODRAM, V3.3, max UDMA/133
[=A0=A0 20.970930] ata2.00: 468862128 sectors, multi 0: LBA48 NCQ (depth 31=
/32), AA
[=A0=A0 20.970941] ata2.00: failed to set xfermode (err_mask=3D0x40)
[=A0=A0 21.283167] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[=A0=A0 21.283496] ata2.00: NCQ Send/Recv Log not supported
[=A0=A0 21.283866] ata2.00: NCQ Send/Recv Log not supported
[=A0=A0 21.283875] ata2.00: configured for UDMA/133
[=A0=A0 21.284332] scsi 1:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=A0=
=A0 GOODRAM=A0=A0=A0=A0=A0=A0=A0=A0=A0 V3.3 PQ: 0 ANSI: 5
[=A0=A0 21.310310] sd 1:0:0:0: [sda] 468862128 512-byte logical blocks: (24=
0 GB/224 GiB)
[=A0=A0 21.310395] sd 1:0:0:0: Attached scsi generic sg0 type 0
[=A0=A0 21.310516] sd 1:0:0:0: [sda] Write Protect is off
[=A0=A0 21.310528] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[=A0=A0 21.310596] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[=A0=A0 21.311686]=A0 sda: sda1
[=A0=A0 21.312563] sd 1:0:0:0: [sda] Attached SCSI disk
[=A0=A0 21.460968] EXT4-fs (mmcblk0p1): mounted filesystem with ordered dat=
a mode. Opts: (null)
[=A0=A0 22.078969] systemd[1]: systemd 229 running in system mode. (+PAM +A=
UDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[=A0=A0 22.079457] systemd[1]: Detected architecture x86-64.
[=A0=A0 22.079993] systemd[1]: Set hostname to <yeti-UDOO-x86>.
[=A0=A0 22.264970] systemd[1]: Created slice System Slice.
[=A0=A0 22.265126] systemd[1]: Reached target User and Group Name Lookups.
[=A0=A0 22.265160] systemd[1]: Reached target Remote File Systems (Pre).
[=A0=A0 22.265202] systemd[1]: Reached target Encrypted Volumes.
[=A0=A0 22.265429] systemd[1]: Created slice User and Session Slice.
[=A0=A0 22.265559] systemd[1]: Listening on Syslog Socket.
[=A0=A0 22.265652] systemd[1]: Listening on fsck to fsckd communication Soc=
ket.
[=A0=A0 22.420503] lp: driver loaded but no devices found
[=A0=A0 22.439570] ppdev: user-space parallel port driver
[=A0=A0 22.648902] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=3Dremount-=
ro
[=A0=A0 22.728593] systemd-journald[265]: Received request to flush runtime=
 journal from PID 1
[=A0=A0 23.425581] 8086228A:00: ttyS4 at MMIO 0x9141c000 (irq =3D 39, base_=
baud =3D 2764800) is a 16550A
[=A0=A0 23.433308] 8086228A:01: ttyS5 at MMIO 0x9141a000 (irq =3D 40, base_=
baud =3D 2764800) is a 16550A
[=A0=A0 23.465013] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channe=
ls
[=A0=A0 23.571008] lpc_ich 0000:00:1f.0: No MFD cells added
[=A0=A0 23.655258] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
[=A0=A0 24.098428] r8169 0000:02:00.0 enp2s0: link down
[=A0=A0 24.100825] r8169 0000:02:00.0 enp2s0: link down
[=A0=A0 24.196362] SSE version of gcm_enc/dec engaged.
[=A0=A0 24.920491] intel_rapl: Found RAPL domain package
[=A0=A0 24.920498] intel_rapl: Found RAPL domain core
[=A0=A0 25.034743] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915=
_audio_component_bind_ops [i915])
[=A0=A0 25.143032] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC283=
: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[=A0=A0 25.143039] snd_hda_codec_realtek hdaudioC0D0:=A0=A0=A0 speaker_outs=
=3D0 (0x0/0x0/0x0/0x0/0x0)
[=A0=A0 25.143043] snd_hda_codec_realtek hdaudioC0D0:=A0=A0=A0 hp_outs=3D1 =
(0x21/0x0/0x0/0x0/0x0)
[=A0=A0 25.143046] snd_hda_codec_realtek hdaudioC0D0:=A0=A0=A0 mono: mono_o=
ut=3D0x0
[=A0=A0 25.143049] snd_hda_codec_realtek hdaudioC0D0:=A0=A0=A0 inputs:
[=A0=A0 25.143053] snd_hda_codec_realtek hdaudioC0D0:=A0=A0=A0=A0=A0 Mic=3D=
0x19
[=A0=A0 25.326332] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:=
1b.0/sound/card0/input7
[=A0=A0 25.326800] input: HDA Intel PCH Headphone as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input8
[=A0=A0 25.327118] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000=
:00/0000:00:1b.0/sound/card0/input9
[=A0=A0 25.327423] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000=
:00/0000:00:1b.0/sound/card0/input10
[=A0=A0 25.327789] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000=
:00/0000:00:1b.0/sound/card0/input11
[=A0=A0 26.683024] r8169 0000:02:00.0 enp2s0: link up
[=A0=A0 27.157079] random: crng init done
[=A0=A0 54.701688] mm/pgtable-generic.c:21: bad pgd ffff93ffb26f8140(0276da=
6067000000)



=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: =C2=EE=F1=EA=F0=E5=F1=E5=ED=FC=E5, 22 =C0=EF=F0=E5=EB=FC 2018 =E3 4:1=
9:30
Subject: Re: Unknown symbol in module

Can you show the output of uname -r and possibly show your boot messages.

On Sat, Apr 21, 2018 at 7:51 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =
=C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
<shevchenko.taras@triolcorp.com.ua> wrote:
> Hi, Greg
> I try to compile modified RTnet driver , and include "rtnet_port.h"
> I succesfully get module=A0 r8169_2015_1.ko file but if i try to load it =
in a system by sudo insmod r8169_2015_1.ko
>
> I get following errors
>
> yeti@yeti-UDOO-x86:~/eth$ sudo insmod r8169_2015_1.ko
> insmod: ERROR: could not insert module r8169_2015_1.ko: Unknown symbol in=
 module
>
>
> logs=A0 dmesg
>
> [101391.334742] r8169_2015: Unknown symbol __rt_alloc_etherdev (err 0)
> [101391.334791] r8169_2015: Unknown symbol rtnetdev_alloc_rtskb (err 0)
> [101391.334858] r8169_2015: Unknown symbol kfree_rtskb (err 0)
> [101391.334918] r8169_2015: Unknown symbol rtdev_free (err 0)
> [101391.334982] r8169_2015: Unknown symbol rt_register_rtnetdev (err 0)
> [101391.335028] r8169_2015: Unknown symbol STACK_manager (err 0)
> [101391.335528] r8169_2015: Unknown symbol RTDEV_manager (err 0)
> [101391.335566] r8169_2015: Unknown symbol rt_stack_connect (err 0)
> [101391.335609] r8169_2015: Unknown symbol rt_stack_disconnect (err 0)
> [101391.335651] r8169_2015: Unknown symbol rt_rtdev_connect (err 0)
> [101391.335683] r8169_2015: Unknown symbol rtskb_pool_release (err 0)
> [101391.335720] r8169_2015: Unknown symbol rtnetif_rx (err 0)
> [101391.335766] r8169_2015: Unknown symbol rt_eth_type_trans (err 0)
> [101391.335802] r8169_2015: Unknown symbol rt_unregister_rtnetdev (err 0)
> [101391.335849] r8169_2015: Unknown symbol rtdev_alloc_name (err 0)
> [101391.335882] r8169_2015: Unknown symbol rt_rtdev_disconnect (err 0)
>
> How i can fix this ?
>
> =D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=
=EE=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
> =D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.
>
> ----- =C8=F1=F5=EE=E4=ED=EE=E5 =F1=EE=EE=E1=F9=E5=ED=E8=E5 -----
> =CE=F2: "Greg Gallagher" <greg@embeddedgreg.com>
> =CA=EE=EC=F3: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=
=F0=FC=E5=E2=E8=F7" <shevchenko.taras@triolcorp.com.ua>
> =CA=EE=EF=E8=FF: "xenomai" <xenomai@xenomai.org>
> =CE=F2=EF=F0=E0=E2=EB=E5=ED=ED=FB=E5: =C2=F2=EE=F0=ED=E8=EA, 17 =C0=EF=F0=
=E5=EB=FC 2018 =E3 19:40:47
> =D2=E5=EC=E0: Re: [Xenomai] PCIe driver to communicate
>
> There no official documentation for doing this but if you google
> 'Xenomai PCI driver', you should find some third party example on how
> to do this.
>
> -Greg
>
> On Tue, Apr 17, 2018 at 9:56 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1=
 =C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> Hi!
>> I have to write PCIe driver to interchange with FPGA
>> Posiible someone do it before ? pls share with me or point me where to s=
tart ?
>> Thanks
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

