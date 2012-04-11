Message-ID: <4F85479F.1060305@domain.hid>
Date: Wed, 11 Apr 2012 10:58:07 +0200
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070208050501010408080902"
Subject: [Xenomai-help] kernel panic unload xeno_nucleus module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--------------070208050501010408080902
Content-Type: multipart/alternative;
	boundary="------------020403050903090408070203"

--------------020403050903090408070203
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi all,

when I try to unload xeno_nucleus module I get a kernel panic and on the=20
next power on the bios system date is reset.
when configure xenomai nucleus built into the kernel I can reboot correctly.

In the bios I disabled HPET and most of the things regarding PM and ACPI.

Here attached same info about system and kernel config.

If possible, I prefer have xenomai configured as modules, is there=20
anything wrong about my system configuration ?

TIA
Alessio

--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova=20
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The=20
information is intended for the use of the addressee only. If you are=20
not the addressee we would appreciate your notification in this respect.=20
Please note that any disclosure, copy, distribution or use of the=20
contents of this message is prohibited and may be unlawful. We have=20
taken every reasonable precaution to ensure that any kind of attachment=20
to this e-mail has been swept for viruses. However, we cannot accept=20
liability for any damage sustained as a result of software viruses and=20
would advise you to carry out your own virus checks before opening any=20
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai=20
soli destinatari. Qualora  veniate in possesso di tali informazioni=20
senza essere definito come destinatario vi reghiamo di leggere le=20
seguenti note. Ogni apertura, copia, distribuzione del contenuto del=20
messaggio e dei suoi allegati =E8 proibito e potrebbe violare le presenti=20
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per=20
assicurare che gli allegati non contengano virus. Comunque non=20
assumeremo alcuna responsabilit=E0 per ogni eventuale danno causato da=20
virus software e simili in quanto =E8 onere del destinatario verificarne=20
l'assenza in ogni allegato attuando propri indipendenti controlli.


--------------020403050903090408070203
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Hi all,<br>
    <br>
    when I try to unload xeno_nucleus module I get a kernel panic and on
    the next power on the bios system date is reset.<br>
    when configure xenomai nucleus built into the kernel I can reboot
    correctly.<br>
    <br>
    In the bios I disabled HPET and most of the things regarding PM and
    ACPI.&nbsp; <br>
    <br>
    Here attached same info about system and kernel config.<br>
    <br>
    If possible, I prefer have xenomai configured as modules, is there
    anything wrong about my system configuration ?<br>
    <br>
    TIA<br>
    Alessio &nbsp; <br>
    <br>
    <div class="moz-signature">-- <br>
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <title>Untitled Document</title>
      <style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12pt;
}
.style8 {
	font-size: 11px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style10 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
}
.style12 {font-size: 14px}
.style15 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
      <p><span class="style8">ISTITUTO ITALIANO<br>
          DI TECNOLOGIA</span></p>
      <p class="style10">Alessio Margan<br>
        <em>Senior Technician</em><br>
        <a href="mailto:alessio.margan@domain.hid">mail me</a></p>
      <p class="style10"><a
href="http://maps.google.com/maps?f=q&amp;hl=en&amp;geocode=&amp;q=via+morego,+30+genova&amp;sll=37.0625,-95.677068&amp;sspn=85.420533,191.601563&amp;ie=UTF8&amp;ll=44.474913,8.907037&amp;spn=0.004685,0.011652&amp;t=h&amp;z=17&amp;iwloc=addr">Via
          Morego, 30 16163 Genova</a><br>
      </p>
      <p class="style1"><span class="style12"><a
            href="http://www.iit.it">www.iit.it</a></span></p>
      <p class="style15"><strong>Legal Disclaimer</strong><br>
        This electronic message contains information that is
        confidential. The information is intended for the use of the
        addressee only. If you are not the addressee we would appreciate
        your notification in this respect. Please note that any
        disclosure, copy, distribution or use of the contents of this
        message is prohibited and may be unlawful. We have taken every
        reasonable precaution to ensure that any kind of attachment to
        this e-mail has been swept for viruses. However, we cannot
        accept liability for any damage sustained as a result of
        software viruses and would advise you to carry out your own
        virus checks before opening any attachment.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
        <strong>Avvertenza legale</strong><br>
        Questo messaggio Email contiene informazioni confidenziali
        riservate ai soli destinatari. Qualora&nbsp; veniate in possesso di
        tali informazioni senza essere definito come destinatario vi
        reghiamo di leggere le seguenti note. Ogni apertura, copia,
        distribuzione del contenuto del messaggio e dei suoi allegati &egrave;
        proibito e potrebbe violare le presenti leggi. Abbiamo attivato
        ogni possibile e ragionevole precauzione per assicurare che gli
        allegati non contengano virus. Comunque non assumeremo alcuna
        responsabilit&agrave; per ogni eventuale danno causato da virus
        software e simili in quanto &egrave; onere del destinatario verificarne
        l&#8217;assenza in ogni allegato attuando propri indipendenti
        controlli.</p>
    </div>
  </body>
</html>

--------------020403050903090408070203--

--------------070208050501010408080902
Content-Type: text/plain; name="sys_info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sys_info.txt"

 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     L7400  @ 1.50GHz
stepping	: 11
cpu MHz		: 1499.992
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 2999.98
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     L7400  @ 1.50GHz
stepping	: 11
cpu MHz		: 1499.992
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 2999.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

Linux ccub-embedded 2.6.38.8_xenomai-2.6.0 #6 SMP PREEMPT Wed Apr 11 10:05:24 CEST 2012 i686 GNU/Linux
 
Gnu C                  4.4.3-4ubuntu5.1)
Gnu make               3.81
util-linux             ng 2.17.2)
mount                  ng 2.17.2 (with libblkid and selinux support)
module-init-tools      3.11.1
e2fsprogs              1.41.11
Linux C Library        2.11.1
Dynamic linker (ldd)   2.11.1
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               7.4
Modules Loaded         evdev usbhid sg e1000e uhci_hcd e100 rng_core usbcore 8250 serial_core



--------------070208050501010408080902
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.38.8_xenomai-2.6.0 (root@domain.hid) (gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5.1) ) #6 SMP PREEMPT Wed Apr 11 10:05:24 CEST 2012
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bf7c0000 (usable)
 BIOS-e820: 00000000bf7c0000 - 00000000bf7ce000 (ACPI data)
 BIOS-e820: 00000000bf7ce000 - 00000000bf800000 (ACPI NVS)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
DMI present.
DMI: Kontron SMX945/SMX945, BIOS KCC.01.27 08/30/2010
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
last_pfn = 0xbf7c0 max_arch_pfn = 0x100000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-DFFFF uncachable
  E0000-E3FFF write-protect
  E4000-EFFFF write-through
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask F80000000 write-back
  1 base 080000000 mask FC0000000 write-back
  2 base 0BF800000 mask FFF800000 uncachable
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
found SMP MP-table at [c00ff780] ff780
initial memory mapped : 0 - 01800000
init_memory_mapping: 0000000000000000-00000000377fe000
 0000000000 - 0000400000 page 4k
 0000400000 - 0037400000 page 2M
 0037400000 - 00377fe000 page 4k
kernel direct mapping tables up to 377fe000 @ 17fb000-1800000
2175MB HIGHMEM available.
887MB LOWMEM available.
  mapped low ram: 0 - 377fe000
  low ram: 0 - 377fe000
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  Normal   0x00001000 -> 0x000377fe
  HighMem  0x000377fe -> 0x000bf7c0
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x000bf7c0
On node 0 totalpages: 784207
free_area_init_node: node 0, pgdat c134ea00, node_mem_map f600d200
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3951 pages, LIFO batch:0
  Normal zone: 1744 pages used for memmap
  Normal zone: 221486 pages, LIFO batch:31
  HighMem zone: 4352 pages used for memmap
  HighMem zone: 552642 pages, LIFO batch:31
Using APIC driver default
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
MPTABLE: OEM ID: KCC     
MPTABLE: Product ID: SMX945      
MPTABLE: APIC at: 0xFEE00000
Processor #0 (Bootup-CPU)
Processor #1
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Processors: 2
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
Allocating PCI resources starting at bf800000 (gap: bf800000:3f600000)
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Embedded 14 pages/cpu @f5800000 s33536 r0 d23808 u2097152
pcpu-alloc: s33536 r0 d23808 u2097152 alloc=1*4194304
pcpu-alloc: [0] 0 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 778079
Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.38.8_xenomai-2.6.0 root=/dev/sda1 ro nosplash
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Initializing CPU#0
Initializing HighMem for node 0 (000377fe:000bf7c0)
Memory: 3106824k/3137280k available (2396k kernel code, 30004k reserved, 999k data, 328k init, 2227976k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff18000 - 0xfffff000   ( 924 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
      .init : 0xc1351000 - 0xc13a3000   ( 328 kB)
      .data : 0xc1257189 - 0xc1350f00   ( 999 kB)
      .text : 0xc1000000 - 0xc1257189   (2396 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Preemptable hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:512
CPU 0 irqstacks, hard=f540c000 soft=f540e000
I-pipe 2.10-01: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Fast TSC calibration using PIT
Detected 1499.992 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 2999.98 BogoMIPS (lpj=1499992)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 16k freed
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ExtINT not setup in hardware but reported by MP table
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found apic 0 pin 0) ...
....... works.
CPU0: Intel(R) Core(TM)2 Duo CPU     L7400  @ 1.50GHz stepping 0b
Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
PEBS disabled due to CPU errata.
... version:                2
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
CPU 1 irqstacks, hard=f5478000 soft=f547a000
Booting Node   0, Processors  #1 Ok.
Initializing CPU#1
Brought up 2 CPUs
Total of 2 processors activated (5998.99 BogoMIPS).
devtmpfs: initialized
NET: Registered protocol family 16
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=3
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
pci 0000:00:00.0: [8086:27ac] type 0 class 0x000600
pci 0000:00:02.0: [8086:27ae] type 0 class 0x000300
pci 0000:00:02.0: reg 10: [mem 0xfe980000-0xfe9fffff]
pci 0000:00:02.0: reg 14: [io  0xcc80-0xcc87]
pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff pref]
pci 0000:00:02.0: reg 1c: [mem 0xfe940000-0xfe97ffff]
pci 0000:00:02.1: [8086:27a6] type 0 class 0x000380
pci 0000:00:02.1: reg 10: [mem 0xfe880000-0xfe8fffff]
pci 0000:00:1b.0: [8086:27d8] type 0 class 0x000403
pci 0000:00:1b.0: reg 10: [mem 0xfe938000-0xfe93bfff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: [8086:27d0] type 1 class 0x000604
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.3: [8086:27d6] type 1 class 0x000604
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1d.0: [8086:27c8] type 0 class 0x000c03
pci 0000:00:1d.0: reg 20: [io  0xcc00-0xcc1f]
pci 0000:00:1d.1: [8086:27c9] type 0 class 0x000c03
pci 0000:00:1d.1: reg 20: [io  0xc880-0xc89f]
pci 0000:00:1d.2: [8086:27ca] type 0 class 0x000c03
pci 0000:00:1d.2: reg 20: [io  0xc800-0xc81f]
pci 0000:00:1d.3: [8086:27cb] type 0 class 0x000c03
pci 0000:00:1d.3: reg 20: [io  0xc480-0xc49f]
pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
pci 0000:00:1f.0: [8086:27bd] type 0 class 0x000601
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00 (mask 000f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 03e8 (mask 000f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 02e8 (mask 000f)
pci 0000:00:1f.2: [8086:27c4] type 0 class 0x000101
pci 0000:00:1f.2: reg 10: [io  0x0000-0x0007]
pci 0000:00:1f.2: reg 14: [io  0x0000-0x0003]
pci 0000:00:1f.2: reg 18: [io  0x0000-0x0007]
pci 0000:00:1f.2: reg 1c: [io  0x0000-0x0003]
pci 0000:00:1f.2: reg 20: [io  0xffa0-0xffaf]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: [8086:27da] type 0 class 0x000c05
pci 0000:00:1f.3: reg 20: [io  0x0400-0x041f]
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:02:00.0: [8086:109a] type 0 class 0x000200
pci 0000:02:00.0: reg 10: [mem 0xfeae0000-0xfeafffff]
pci 0000:02:00.0: reg 18: [io  0xdc80-0xdc9f]
pci 0000:02:00.0: PME# supported from D0 D3hot
pci 0000:02:00.0: PME# disabled
pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.3: PCI bridge to [bus 02-02]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xfea00000-0xfeafffff]
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:03:08.0: [8086:1093] type 0 class 0x000200
pci 0000:03:08.0: reg 10: [mem 0xfebff000-0xfebfffff]
pci 0000:03:08.0: reg 14: [io  0xec80-0xecbf]
pci 0000:03:08.0: supports D1 D2
pci 0000:03:08.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:08.0: PME# disabled
pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:27bd]
PCI: pci_cache_line_size set to 64 bytes
reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
reserve RAM buffer: 00000000bf7c0000 - 00000000bfffffff 
pci 0000:00:1c.0: BAR 8: assigned [mem 0xc0000000-0xc01fffff]
pci 0000:00:1c.0: BAR 9: assigned [mem 0xc0200000-0xc03fffff 64bit pref]
pci 0000:00:1c.3: BAR 9: assigned [mem 0xc0400000-0xc05fffff 64bit pref]
pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03fffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 02-02]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xfea00000-0xfeafffff]
pci 0000:00:1c.3:   bridge window [mem 0xc0400000-0xc05fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 03-03]
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem pref disabled]
pci 0000:00:1c.0: enabling device (0104 -> 0107)
pci 0000:00:1c.0: PCI->APIC IRQ transform: INT A -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.3: PCI->APIC IRQ transform: INT D -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffff]
pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:01: resource 1 [mem 0xc0000000-0xc01fffff]
pci_bus 0000:01: resource 2 [mem 0xc0200000-0xc03fffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc05fffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
pci_bus 0000:03: resource 1 [mem 0xfeb00000-0xfebfffff]
pci_bus 0000:03: resource 4 [io  0x0000-0xffff]
pci_bus 0000:03: resource 5 [mem 0x00000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:00:02.0: Boot video device
pci 0000:03:08.0: Firmware left e100 interrupts enabled; disabling
PCI: CLS 32 bytes, default 64
platform rtc_cmos: registered platform RTC device (no PNP device found)
highmem bounce pool size: 64 pages
msgmni has been set to 1716
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 945GME Chipset
agpgart-intel 0000:00:00.0: detected gtt size: 262144K total, 262144K mappable
agpgart-intel 0000:00:00.0: detected 8192K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.1.0 20060810
pci 0000:00:02.0: PCI->APIC IRQ transform: INT A -> IRQ 16
pci 0000:00:02.0: setting latency timer to 64
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
[drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
ata_piix 0000:00:1f.2: version 2.13
ata_piix 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
i801_smbus 0000:00:1f.3: PCI->APIC IRQ transform: INT B -> IRQ 19
device-mapper: ioctl: 4.19.1-ioctl (2011-01-07) initialised: dm-devel@domain.hid
TCP cubic registered
NET: Registered protocol family 17
Using IPI Shortcut mode
ata2.00: ATA-7: TS32GSSD25-M, V090331, max UDMA/133
ata2.00: 62586880 sectors, multi 1: LBA48 
ata2.00: limited to UDMA/33 due to 40-wire cable
ata2.00: configured for UDMA/33
scsi 1:0:0:0: Direct-Access     ATA      TS32GSSD25-M     V090 PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 62586880 512-byte logical blocks: (32.0 GB/29.8 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 1:0:0:0: [sda] Attached SCSI disk
EXT3-fs (sda1): recovery required on readonly filesystem
EXT3-fs (sda1): write access will be enabled during recovery
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): recovery complete
EXT3-fs (sda1): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel memory: 328k freed
Switching to clocksource tsc
udev: starting version 151
udevd (474): /proc/474/oom_adj is deprecated, please use /proc/474/oom_score_adj instead.
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e100 0000:03:08.0: PCI->APIC IRQ transform: INT A -> IRQ 20
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000cc00
intel_rng: FWH not detected
e1000e: Intel(R) PRO/1000 Network Driver - 1.2.20-k2
e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
e1000e 0000:02:00.0: Disabling ASPM  L1
e1000e 0000:02:00.0: PCI->APIC IRQ transform: INT A -> IRQ 19
e1000e 0000:02:00.0: setting latency timer to 64
e1000e 0000:02:00.0: (unregistered net_device): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
e1000e 0000:02:00.0: Disabling ASPM L0s 
e100 0000:03:08.0: PME# disabled
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI->APIC IRQ transform: INT B -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000c880
sd 1:0:0:0: Attached scsi generic sg0 type 0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI->APIC IRQ transform: INT C -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000c800
e100 0000:03:08.0: eth0: addr 0xfebff000, irq 20, MAC addr 00:30:59:06:39:49
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI->APIC IRQ transform: INT D -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000c480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
udev: renamed network interface eth0 to eth1
e1000e 0000:02:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:30:59:05:4d:5f
e1000e 0000:02:00.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:02:00.0: eth0: MAC: 2, PHY: 2, PBA No: FFFFFF-0FF
Adding 1052252k swap on /dev/sda3.  Priority:-1 extents:1 across:1052252k SS
usb 4-1: new low speed USB device using uhci_hcd and address 2
EXT3-fs (sda1): using internal journal
EXT4-fs (sda4): mounted filesystem with ordered data mode. Opts: errors=remount-ro
input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:1d.3/usb4/4-1/4-1:1.0/input/input0
generic-usb 0003:046D:C315.0001: input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.3-1/input0
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
e1000e 0000:02:00.0: eth0: 10/100 speed: disabling TSO
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
Xenomai: debug mode enabled.

--------------070208050501010408080902
Content-Type: text/plain; name="config-2.6.38.8_xenomai-2.6.0"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-2.6.38.8_xenomai-2.6.0"

#
# Automatically generated make config: don't edit
# Linux/i386 2.6.38.8 Kernel Configuration
# Wed Apr 11 09:49:51 2012
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
# CONFIG_X86_64 is not set
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
# CONFIG_NEED_DMA_MAP_STATE is not set
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_DEFAULT_IDLE=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-ecx -fcall-saved-edx"
CONFIG_KTIME_SCALAR=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_HAVE_IRQ_WORK=y
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION="_xenomai-2.6.0"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_GENERIC_HARDIRQS=y

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=y
# CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED is not set
CONFIG_HAVE_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
# CONFIG_AUTO_IRQ_AFFINITY is not set
# CONFIG_IRQ_PER_CPU is not set
# CONFIG_HARDIRQS_SW_RESEND is not set
# CONFIG_SPARSE_IRQ is not set

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EXPERT is not set
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_PERF_COUNTERS is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PCI_QUIRKS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y

#
# GCOV-based kernel profiling
#
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
# CONFIG_INLINE_SPIN_UNLOCK is not set
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
CONFIG_MUTEX_SPIN_ON_OWNER=y

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=m
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_DEBUG_NUCLEUS=y
CONFIG_XENO_OPT_DEBUG_XNLOCK=y
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
CONFIG_XENO_OPT_DEBUG_REGISTRY=y
CONFIG_XENO_OPT_DEBUG_TIMERS=y
# CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX is not set
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
# CONFIG_XENO_OPT_SHIRQ is not set
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=y

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_HW_SMI_WORKAROUND=y
CONFIG_XENO_HW_SMI_ALL=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=m
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=y
CONFIG_XENO_SKIN_POSIX=m
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_POSIX_SELECT=y
# CONFIG_XENO_OPT_DEBUG_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=m
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=y

#
# Drivers
#

#
# Serial drivers
#
CONFIG_XENO_DRIVERS_16550A=m
CONFIG_XENO_DRIVERS_16550A_PIO=y
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set
# CONFIG_XENO_DRIVERS_16550A_ANY is not set
# CONFIG_XENO_DRIVERS_16550A_PCI is not set

#
# Testing drivers
#
CONFIG_XENO_DRIVERS_TIMERBENCH=m
# CONFIG_XENO_DRIVERS_KLATENCY is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=m
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

#
# CAN drivers
#
CONFIG_XENO_DRIVERS_CAN=m
CONFIG_XENO_DRIVERS_CAN_DEBUG=y
# CONFIG_XENO_DRIVERS_CAN_LOOPBACK is not set
CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
CONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS=16
CONFIG_XENO_DRIVERS_CAN_BUS_ERR=y
CONFIG_XENO_DRIVERS_CAN_VIRT=m
CONFIG_XENO_DRIVERS_CAN_SJA1000=m
CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA=m
# CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_PLX_PCI is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI is not set
# CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG is not set

#
# ANALOGY drivers
#
CONFIG_XENO_DRIVERS_ANALOGY=m
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
# CONFIG_XENO_DRIVERS_ANALOGY_FAKE is not set
CONFIG_XENO_DRIVERS_ANALOGY_8255=m
CONFIG_XENO_DRIVERS_ANALOGY_PARPORT=m
# CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE is not set
# CONFIG_XENO_DRIVERS_ANALOGY_NI_TIO is not set
# CONFIG_XENO_DRIVERS_ANALOGY_NI_PCIMIO is not set
# CONFIG_XENO_DRIVERS_ANALOGY_NI_670x is not set
# CONFIG_XENO_DRIVERS_ANALOGY_NI_660x is not set
CONFIG_XENO_DRIVERS_ANALOGY_S526=m

#
# Real-time IPC drivers
#
CONFIG_XENO_DRIVERS_RTIPC=m
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_OPT_IDDP_NRPORT=32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
CONFIG_XENO_OPT_BUFP_NRPORT=32
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_SMP=y
CONFIG_X86_MPPARSE=y
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_32_IRIS is not set
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MEMTEST is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_CMPXCHG=y
CONFIG_CMPXCHG_LOCAL=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_XADD=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_HPET_TIMER is not set
CONFIG_DMI=y
# CONFIG_IOMMU_HELPER is not set
# CONFIG_IOMMU_API is not set
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
CONFIG_HAVE_IPIPE_HOSTRT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_SECCOMP is not set
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_PM is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_ARCH_SUPPORTS_MSI=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_STUB is not set
# CONFIG_HT_IRQ is not set
# CONFIG_PCI_IOV is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_OLPC_OPENFIRMWARE is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_TEXT_POKE_SMP=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_LRO=y
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
CONFIG_RPS=y
CONFIG_XPS=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_CALC_BITTIMING is not set
# CONFIG_PCH_CAN is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PLX_PCI is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=y
CONFIG_WIRELESS_EXT_SYSFS=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m

#
# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
CONFIG_MII=y
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_ETHOC is not set
# CONFIG_DNET is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_KSZ884X_PCI is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R6040 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC9420 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
# CONFIG_ATL2 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=m
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_JME is not set
# CONFIG_STMMAC_ETH is not set
# CONFIG_PCH_GBE is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set
CONFIG_WLAN=y
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_AIRO is not set
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_ADM8211 is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_MWL8K is not set
# CONFIG_ATH_COMMON is not set
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_HOSTAP is not set
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWM is not set
# CONFIG_LIBERTAS is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_RT2X00=m
# CONFIG_RT2400PCI is not set
# CONFIG_RT2500PCI is not set
# CONFIG_RT61PCI is not set
# CONFIG_RT2800PCI is not set
# CONFIG_RT2500USB is not set
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
# CONFIG_RT2800USB_RT33XX is not set
# CONFIG_RT2800USB_RT35XX is not set
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_HT=y
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_DEBUG=y
# CONFIG_RTL8192CE is not set
# CONFIG_WL1251 is not set
# CONFIG_WL12XX_MENU is not set
# CONFIG_ZD1211RW is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_WAN is not set

#
# CAIF transport drivers
#
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_DEVKMEM is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=m
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_RAMOOPS is not set
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
# CONFIG_I2C_SMBUS is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_INTEL_MID is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_EG20T is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
# CONFIG_MFD_SUPPORT is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_DRM=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_KMS is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_STUB_POULSBO is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_WMT_GE_ROPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HIDRAW is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# Special HID drivers
#
# CONFIG_HID_3M_PCT is not set
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_CANDO is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_EGALAX is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LOGITECH=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWII_FF is not set
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MOSART is not set
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTRIG=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_QUANTA is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_ROCCAT_KONE is not set
# CONFIG_HID_ROCCAT_KONEPLUS is not set
# CONFIG_HID_ROCCAT_PYRA is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_HID_STANTUM is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# Enable Host or Gadget support to see Inventra options
#

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_UAS is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_UWB is not set
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_UNSAFE_RESUME is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_MMC_BLOCK_BOUNCE is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_NFC_DEVICES is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_STAGING=y
# CONFIG_STAGING_EXCLUDE_BUILD is not set
# CONFIG_ET131X is not set
# CONFIG_SLICOSS is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_IP_COMMON is not set
# CONFIG_W35UND is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_ECHO is not set
# CONFIG_BRCM80211 is not set
CONFIG_RT2860=m
CONFIG_RT2870=m
# CONFIG_COMEDI is not set
# CONFIG_ASUS_OLED is not set
# CONFIG_R8187SE is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTL8192E is not set
# CONFIG_R8712U is not set
# CONFIG_TRANZPORT is not set
# CONFIG_POHMELFS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_IDE_PHISON is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_NOUVEAU is not set

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_HYPERV is not set
# CONFIG_VME_BUS is not set
# CONFIG_DX_SEP is not set
# CONFIG_IIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_ZRAM is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_CRYSTALHD is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_FB_XGI is not set
# CONFIG_SMB_FS is not set
CONFIG_MACH_NO_WESTBRIDGE=y
# CONFIG_ATH6K_LEGACY is not set
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_X86_PLATFORM_DEVICES is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_XATTR=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=y
CONFIG_JBD2=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=m
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
CONFIG_NFSD_DEPRECATED=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_BKL=y
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_SYSCTL_SYSCALL_CHECK is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_STRICT_DEVMEM is not set
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_OPTIMIZE_INLINING is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=m

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=m
CONFIG_CRYPTO_ALGAPI2=m
CONFIG_CRYPTO_AEAD2=m
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_BLKCIPHER2=m
CONFIG_CRYPTO_HASH=m
CONFIG_CRYPTO_HASH2=m
CONFIG_CRYPTO_RNG2=m
CONFIG_CRYPTO_PCOMP2=m
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_MANAGER2=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=m
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=m
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_FIND_LAST_BIT=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
CONFIG_AVERAGE=y

--------------070208050501010408080902--

