Message-ID: <4D2379EF.5@domain.hid>
Date: Tue, 04 Jan 2011 14:50:07 -0500
From: Tamas Szklenar <tszklenar@domain.hid>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid> <4D23785B.5050108@domain.hid>
In-Reply-To: <4D23785B.5050108@domain.hid>
Content-Type: multipart/mixed; boundary="------------020705070708090306000603"
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020705070708090306000603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Here is the kern.log, I made some kernel configurations because of the 
used hardware parts, but the main systems config was unchanged...

Thanks for the help!

Tamas

--------------020705070708090306000603
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kern.log"

Jan  3 13:07:48 cfhat12 kernel: [320189.776297] NTFS driver 2.1.29 [Flags: R/W MODULE].
Jan  3 13:07:53 cfhat12 kernel: [320194.522309] md: md7 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522345] md: md6 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522379] md: md5 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522415] md: md3 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522450] md: md2 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522483] md: md1 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522580] md: md7 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522624] md: md6 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522655] md: md5 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522685] md: md3 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522716] md: md2 still in use.
Jan  3 13:07:53 cfhat12 kernel: [320194.522748] md: md1 still in use.
Jan  3 13:07:54 cfhat12 kernel: [320195.421058] fuse exit
Jan  3 13:07:59 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 13:12:01 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Linux version 2.6.35.7-xeno3 (hatuser@domain.hid) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Mon Jan 3 13:04:23 EST 2011
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] NX (Execute Disable) protection: active
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   6 disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   7 disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] RAMDISK: 37cc4000 - 37ff0000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880002200000-ffff880008bfffff] on node 0
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]     0: 0x00000001 -> 0x0000009f
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965454
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA zone: 0 pages reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA zone: 3942 pages, LIFO batch:0
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 40
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] early_res array is doubled to 64 at [3000 - 37ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880001a00000 s101760 r8192 d21120 u262144
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] pcpu-alloc: s101760 r8192 d21120 u262144 alloc=1*2097152
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935886
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Node 0: aperture @ d90000000 size 32 MB
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] early_res array is doubled to 128 at [3800 - 47ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Subtract (58 early reservations)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #1 [0001000000 - 000188d234]   TEXT DATA BSS
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #2 [0037cc4000 - 0037ff0000]         RAMDISK
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #3 [000188e000 - 000188e0fe]             BRK
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #4 [00000f4420 - 0000100000]   BIOS reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #5 [00000f4410 - 00000f4420]    MP-table mpf
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #6 [000009f800 - 00000f1aa4]   BIOS reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #7 [00000f1c88 - 00000f4410]   BIOS reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #8 [00000f1aa4 - 00000f1c88]    MP-table mpc
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #10 [0000008000 - 000000a000]         PGTABLE
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #11 [000000a000 - 000000b000]         PGTABLE
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #12 [000188e100 - 000188f100]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #13 [000188d240 - 000188d7e0]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #14 [0002090000 - 0002091000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #15 [0002091000 - 0002092000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #16 [0002200000 - 0008c00000]        MEMMAP 0
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #17 [000188d800 - 000188d980]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #18 [000188f100 - 00018a7100]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #19 [00018a7100 - 00018bf100]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #20 [00018c0000 - 00018c1000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #21 [000188d980 - 000188d9c3]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #22 [000188da00 - 000188dc68]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #23 [000188dc80 - 000188dce8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #24 [000188dd00 - 000188dd68]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #25 [000188dd80 - 000188dde8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #26 [000188de00 - 000188de68]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #27 [000188de80 - 000188dee8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #28 [000188df00 - 000188df68]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #29 [000188df80 - 000188dfe8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #30 [00018bf100 - 00018bf168]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #31 [00018bf180 - 00018bf1e8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #32 [00018bf200 - 00018bf268]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #33 [00018bf280 - 00018bf2db]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #34 [00018bf300 - 00018bf35b]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #35 [0001a00000 - 0001a20000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #36 [0001a40000 - 0001a60000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #37 [0001a80000 - 0001aa0000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #38 [0001ac0000 - 0001ae0000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #39 [0001b00000 - 0001b20000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #40 [0001b40000 - 0001b60000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #41 [0001b80000 - 0001ba0000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #42 [0001bc0000 - 0001be0000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #43 [00018bf380 - 00018bf388]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #44 [00018bf3c0 - 00018bf3c8]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #45 [00018bf400 - 00018bf420]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #46 [00018bf440 - 00018bf480]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #47 [00018bf480 - 00018bf5a0]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #48 [00018bf5c0 - 00018bf608]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #49 [00018bf640 - 00018bf688]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #50 [00018c1000 - 00018c9000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #51 [0008c00000 - 0009400000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #52 [0001be0000 - 0001fe0000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #54 [0009400000 - 000d400000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #55 [00018c9000 - 00018e9000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #56 [00018e9000 - 0001929000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000]   #57 [000000b000 - 0000013000]         BOOTMEM
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Memory: 7596200k/8650752k available (4645k kernel code, 788936k absent, 265616k reserved, 2462k data, 488k init)
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] NR_IRQS:512
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] I-pipe 2.7-04: pipeline enabled.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  3 13:12:01 cfhat12 kernel: [    0.000000] Detected 3415.113 MHz processor.
Jan  3 13:12:01 cfhat12 kernel: [    0.012006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6830.21 BogoMIPS (lpj=13660436)
Jan  3 13:12:01 cfhat12 kernel: [    0.012009] pid_max: default: 32768 minimum: 301
Jan  3 13:12:01 cfhat12 kernel: [    0.012040] Security Framework initialized
Jan  3 13:12:01 cfhat12 kernel: [    0.012043] SELinux:  Initializing.
Jan  3 13:12:01 cfhat12 kernel: [    0.012050] SELinux:  Starting in permissive mode
Jan  3 13:12:01 cfhat12 kernel: [    0.012062] Mount-cache hash table entries: 256
Jan  3 13:12:01 cfhat12 kernel: [    0.012140] Initializing cgroup subsys ns
Jan  3 13:12:01 cfhat12 kernel: [    0.012142] Initializing cgroup subsys cpuacct
Jan  3 13:12:01 cfhat12 kernel: [    0.012145] Initializing cgroup subsys devices
Jan  3 13:12:01 cfhat12 kernel: [    0.012161] tseg: 00cff00000
Jan  3 13:12:01 cfhat12 kernel: [    0.012162] CPU: Physical Processor ID: 0
Jan  3 13:12:01 cfhat12 kernel: [    0.012163] CPU: Processor Core ID: 0
Jan  3 13:12:01 cfhat12 kernel: [    0.012165] mce: CPU supports 6 MCE banks
Jan  3 13:12:01 cfhat12 kernel: [    0.012171] using C1E aware idle routine
Jan  3 13:12:01 cfhat12 kernel: [    0.012172] Performance Events: AMD PMU driver.
Jan  3 13:12:01 cfhat12 kernel: [    0.012175] ... version:                0
Jan  3 13:12:01 cfhat12 kernel: [    0.012176] ... bit width:              48
Jan  3 13:12:01 cfhat12 kernel: [    0.012177] ... generic registers:      4
Jan  3 13:12:01 cfhat12 kernel: [    0.012179] ... value mask:             0000ffffffffffff
Jan  3 13:12:01 cfhat12 kernel: [    0.012180] ... max period:             00007fffffffffff
Jan  3 13:12:01 cfhat12 kernel: [    0.012181] ... fixed-purpose events:   0
Jan  3 13:12:01 cfhat12 kernel: [    0.012182] ... event mask:             000000000000000f
Jan  3 13:12:01 cfhat12 kernel: [    0.012233] ACPI: Core revision 20100428
Jan  3 13:12:01 cfhat12 kernel: [    0.024056] Setting APIC routing to flat
Jan  3 13:12:01 cfhat12 kernel: [    0.024444] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  3 13:12:01 cfhat12 kernel: [    0.028000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jan  3 13:12:01 cfhat12 kernel: [    0.028000] ...trying to set up timer (IRQ0) through the 8259A ...
Jan  3 13:12:01 cfhat12 kernel: [    0.028000] ..... (found apic 0 pin 2) ...
Jan  3 13:12:01 cfhat12 kernel: [    0.068201] ....... works.
Jan  3 13:12:01 cfhat12 kernel: [    0.068202] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:12:01 cfhat12 kernel: [    0.072000] Booting Node   0, Processors  #1
Jan  3 13:12:01 cfhat12 kernel: [    0.016000] System has AMD C1E enabled
Jan  3 13:12:01 cfhat12 kernel: [    0.160009] Switch to broadcast mode on CPU1
Jan  3 13:12:01 cfhat12 kernel: [    0.160090]  #2
Jan  3 13:12:01 cfhat12 kernel: [    0.252008] Switch to broadcast mode on CPU2
Jan  3 13:12:01 cfhat12 kernel: [    0.252052]  #3
Jan  3 13:12:01 cfhat12 kernel: [    0.016000] Switch to broadcast mode on CPU3
Jan  3 13:12:01 cfhat12 kernel: [    0.344033] Brought up 4 CPUs
Jan  3 13:12:01 cfhat12 kernel: [    0.344037] Total of 4 processors activated (27322.12 BogoMIPS).
Jan  3 13:12:01 cfhat12 kernel: [    0.345670] Switch to broadcast mode on CPU0
Jan  3 13:12:01 cfhat12 kernel: [    0.345812] devtmpfs: initialized
Jan  3 13:12:01 cfhat12 kernel: [    0.346069] xor: automatically using best checksumming function: generic_sse
Jan  3 13:12:01 cfhat12 kernel: [    0.364001]    generic_sse: 13683.000 MB/sec
Jan  3 13:12:01 cfhat12 kernel: [    0.364006] xor: using function: generic_sse (13683.000 MB/sec)
Jan  3 13:12:01 cfhat12 kernel: [    0.364041] NET: Registered protocol family 16
Jan  3 13:12:01 cfhat12 kernel: [    0.364333] node 0 link 0: io port [8000, ffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364335] TOM: 00000000d0000000 aka 3328M
Jan  3 13:12:01 cfhat12 kernel: [    0.364337] Fam 10h mmconf [e0000000, e00fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364339] node 0 link 0: mmio [a0000, bffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364341] node 0 link 0: mmio [d0000000, dfffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364343] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364345] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364348] TOM2: 0000000230000000 aka 8960M
Jan  3 13:12:01 cfhat12 kernel: [    0.364350] bus: [00, 08] on node 0 link 0
Jan  3 13:12:01 cfhat12 kernel: [    0.364352] bus: 00 index 0 [io  0x0000-0xffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364354] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364355] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364357] bus: 00 index 3 [mem 0xe0900000-0xffffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364358] bus: 00 index 4 [mem 0xe0100000-0xe08fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364360] bus: 00 index 5 [mem 0x230000000-0xfcffffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.364368] ACPI: bus type pci registered
Jan  3 13:12:01 cfhat12 kernel: [    0.364429] PCI: Using configuration type 1 for base access
Jan  3 13:12:01 cfhat12 kernel: [    0.364430] PCI: Using configuration type 1 for extended access
Jan  3 13:12:01 cfhat12 kernel: [    0.368218] bio: create slab <bio-0> at 0
Jan  3 13:12:01 cfhat12 kernel: [    0.368896] ACPI: EC: Look up EC in DSDT
Jan  3 13:12:01 cfhat12 kernel: [    0.375408] ACPI: Interpreter enabled
Jan  3 13:12:01 cfhat12 kernel: [    0.375410] ACPI: (supports S0 S5)
Jan  3 13:12:01 cfhat12 kernel: [    0.375420] ACPI: Using IOAPIC for interrupt routing
Jan  3 13:12:01 cfhat12 kernel: [    0.380511] ACPI Warning: Incorrect checksum in table [TAMG] - 0x81, should be 0x80 (20100428/tbutils-314)
Jan  3 13:12:01 cfhat12 kernel: [    0.380585] ACPI: No dock devices found.
Jan  3 13:12:01 cfhat12 kernel: [    0.380587] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan  3 13:12:01 cfhat12 kernel: [    0.380682] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jan  3 13:12:01 cfhat12 kernel: [    0.380861] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
Jan  3 13:12:01 cfhat12 kernel: [    0.380863] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.380865] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.380867] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.380869] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xfebfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.380887] pci 0000:00:00.0: reg 1c: [mem 0xe0000000-0xffffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.380954] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.380956] pci 0000:00:07.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.380983] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.380985] pci 0000:00:09.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.381011] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.381014] pci 0000:00:0a.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.381045] pci 0000:00:11.0: reg 10: [io  0xff00-0xff07]
Jan  3 13:12:01 cfhat12 kernel: [    0.381050] pci 0000:00:11.0: reg 14: [io  0xfe00-0xfe03]
Jan  3 13:12:01 cfhat12 kernel: [    0.381055] pci 0000:00:11.0: reg 18: [io  0xfd00-0xfd07]
Jan  3 13:12:01 cfhat12 kernel: [    0.381060] pci 0000:00:11.0: reg 1c: [io  0xfc00-0xfc03]
Jan  3 13:12:01 cfhat12 kernel: [    0.381064] pci 0000:00:11.0: reg 20: [io  0xfb00-0xfb0f]
Jan  3 13:12:01 cfhat12 kernel: [    0.381069] pci 0000:00:11.0: reg 24: [mem 0xfe02f000-0xfe02f3ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381082] pci 0000:00:11.0: set SATA to AHCI mode
Jan  3 13:12:01 cfhat12 kernel: [    0.381120] pci 0000:00:12.0: reg 10: [mem 0xfe02e000-0xfe02efff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381165] pci 0000:00:12.2: reg 10: [mem 0xfe02d000-0xfe02d0ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381201] pci 0000:00:12.2: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381202] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:12:01 cfhat12 kernel: [    0.381205] pci 0000:00:12.2: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.381226] pci 0000:00:13.0: reg 10: [mem 0xfe02c000-0xfe02cfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381271] pci 0000:00:13.2: reg 10: [mem 0xfe02b000-0xfe02b0ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381307] pci 0000:00:13.2: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381308] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:12:01 cfhat12 kernel: [    0.381311] pci 0000:00:13.2: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.381365] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
Jan  3 13:12:01 cfhat12 kernel: [    0.381370] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
Jan  3 13:12:01 cfhat12 kernel: [    0.381375] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
Jan  3 13:12:01 cfhat12 kernel: [    0.381379] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
Jan  3 13:12:01 cfhat12 kernel: [    0.381384] pci 0000:00:14.1: reg 20: [io  0xfa00-0xfa0f]
Jan  3 13:12:01 cfhat12 kernel: [    0.381466] pci 0000:00:14.5: reg 10: [mem 0xfe02a000-0xfe02afff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381532] pci 0000:00:15.0: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381581] pci 0000:00:15.1: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381605] pci 0000:00:16.0: reg 10: [mem 0xfe029000-0xfe029fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381651] pci 0000:00:16.2: reg 10: [mem 0xfe028000-0xfe0280ff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381686] pci 0000:00:16.2: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381688] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:12:01 cfhat12 kernel: [    0.381691] pci 0000:00:16.2: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.381776] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.381779] pci 0000:01:05.0: reg 14: [io  0xce00-0xceff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381782] pci 0000:01:05.0: reg 18: [mem 0xfd3e0000-0xfd3effff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381788] pci 0000:01:05.0: reg 24: [mem 0xfd200000-0xfd2fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381797] pci 0000:01:05.0: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381809] pci 0000:01:05.1: reg 10: [mem 0xfd3fc000-0xfd3fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381824] pci 0000:01:05.1: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.381851] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 13:12:01 cfhat12 kernel: [    0.381854] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381856] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381859] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.381910] pci 0000:02:00.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381919] pci 0000:02:00.0: reg 14: [mem 0xfdf00000-0xfdf7ffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381927] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
Jan  3 13:12:01 cfhat12 kernel: [    0.381935] pci 0000:02:00.0: reg 1c: [mem 0xfdffc000-0xfdffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.381958] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.381999] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.382004] pci 0000:02:00.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.382026] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 13:12:01 cfhat12 kernel: [    0.382029] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382031] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382034] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382074] pci 0000:03:00.0: reg 10: [mem 0xfddfe000-0xfddfffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.382113] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.382116] pci 0000:03:00.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.382129] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 13:12:01 cfhat12 kernel: [    0.382132] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382134] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382137] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382174] pci 0000:04:00.0: reg 10: [io  0xde00-0xdeff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382188] pci 0000:04:00.0: reg 18: [mem 0xfd4ff000-0xfd4fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382197] pci 0000:04:00.0: reg 20: [mem 0xfd4f8000-0xfd4fbfff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382203] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382229] pci 0000:04:00.0: supports D1 D2
Jan  3 13:12:01 cfhat12 kernel: [    0.382230] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  3 13:12:01 cfhat12 kernel: [    0.382234] pci 0000:04:00.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.382249] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 13:12:01 cfhat12 kernel: [    0.382252] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382254] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382257] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382288] pci 0000:05:06.0: reg 10: [io  0xaf00-0xaf07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382294] pci 0000:05:06.0: reg 14: [io  0xae00-0xae07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382301] pci 0000:05:06.0: reg 18: [io  0xad00-0xad07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382307] pci 0000:05:06.0: reg 1c: [io  0xac00-0xac07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382347] pci 0000:05:06.1: reg 10: [io  0xab00-0xab07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382354] pci 0000:05:06.1: reg 14: [io  0xaa00-0xaa07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382360] pci 0000:05:06.1: reg 18: [io  0xa900-0xa907]
Jan  3 13:12:01 cfhat12 kernel: [    0.382367] pci 0000:05:06.1: reg 1c: [io  0xa800-0xa807]
Jan  3 13:12:01 cfhat12 kernel: [    0.382412] pci 0000:05:08.0: reg 10: [io  0xa700-0xa707]
Jan  3 13:12:01 cfhat12 kernel: [    0.382475] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382478] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382482] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382485] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382487] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382489] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382491] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382493] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382495] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 13:12:01 cfhat12 kernel: [    0.382595] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382629] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 13:12:01 cfhat12 kernel: [    0.382633] pci 0000:06:00.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.382673] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382680] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 13:12:01 cfhat12 kernel: [    0.382688] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 13:12:01 cfhat12 kernel: [    0.382696] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 13:12:01 cfhat12 kernel: [    0.382703] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 13:12:01 cfhat12 kernel: [    0.382756] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 13:12:01 cfhat12 kernel: [    0.382760] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382763] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382767] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.382909] pci 0000:07:00.0: supports D1
Jan  3 13:12:01 cfhat12 kernel: [    0.382911] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 13:12:01 cfhat12 kernel: [    0.382916] pci 0000:07:00.0: PME# disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.382935] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 13:12:01 cfhat12 kernel: [    0.382940] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382942] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.382947] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.383046] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 13:12:01 cfhat12 kernel: [    0.383056] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 13:12:01 cfhat12 kernel: [    0.383066] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 13:12:01 cfhat12 kernel: [    0.383077] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 13:12:01 cfhat12 kernel: [    0.383087] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 13:12:01 cfhat12 kernel: [    0.383097] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 13:12:01 cfhat12 kernel: [    0.383185] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 13:12:01 cfhat12 kernel: [    0.383190] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.383196] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.383201] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.383227] pci_bus 0000:00: on NUMA node 0
Jan  3 13:12:01 cfhat12 kernel: [    0.383230] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383461] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383498] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383543] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383624] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383660] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383696] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.383736] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] vgaarb: loaded
Jan  3 13:12:01 cfhat12 kernel: [    0.399663] SCSI subsystem initialized
Jan  3 13:12:01 cfhat12 kernel: [    0.401818] libata version 3.00 loaded.
Jan  3 13:12:01 cfhat12 kernel: [    0.401973] usbcore: registered new interface driver usbfs
Jan  3 13:12:01 cfhat12 kernel: [    0.402003] usbcore: registered new interface driver hub
Jan  3 13:12:01 cfhat12 kernel: [    0.402038] usbcore: registered new device driver usb
Jan  3 13:12:01 cfhat12 kernel: [    0.464038] raid6: int64x1   2963 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.532020] raid6: int64x2   3408 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.600037] raid6: int64x4   2627 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.668034] raid6: int64x8   2471 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.736018] raid6: sse2x1    4623 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.804028] raid6: sse2x2    7634 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.872026] raid6: sse2x4    8458 MB/s
Jan  3 13:12:01 cfhat12 kernel: [    0.872027] raid6: using algorithm sse2x4 (8458 MB/s)
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] Advanced Linux Sound Architecture Driver Version 1.0.23.
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] PCI: Using ACPI for IRQ routing
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] PCI: pci_cache_line_size set to 64 bytes
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 13:12:01 cfhat12 kernel: [    0.876096] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 13:12:01 cfhat12 kernel: [    0.876304] NetLabel: Initializing
Jan  3 13:12:01 cfhat12 kernel: [    0.876304] NetLabel:  domain hash size = 128
Jan  3 13:12:01 cfhat12 kernel: [    0.876304] NetLabel:  protocols = UNLABELED CIPSOv4
Jan  3 13:12:01 cfhat12 kernel: [    0.876304] NetLabel:  unlabeled traffic allowed by default
Jan  3 13:12:01 cfhat12 kernel: [    0.876393] Switching to clocksource tsc
Jan  3 13:12:01 cfhat12 kernel: [    0.876394] pnp: PnP ACPI init
Jan  3 13:12:01 cfhat12 kernel: [    0.876394] ACPI: bus type pnp registered
Jan  3 13:12:01 cfhat12 kernel: [    0.878682] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.878682] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.878682] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879971] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:12:01 cfhat12 kernel: [    0.879986] pnp: PnP ACPI: found 11 devices
Jan  3 13:12:01 cfhat12 kernel: [    0.879988] ACPI: ACPI bus type pnp unregistered
Jan  3 13:12:01 cfhat12 kernel: [    0.879994] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.879996] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.879998] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880002] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880004] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880005] system 00:02: [io  0x040b] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880007] system 00:02: [io  0x04d6] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880009] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880011] system 00:02: [io  0x0c14] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880013] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880015] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880017] system 00:02: [io  0x0c6f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880019] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880021] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880023] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880025] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880027] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880029] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880031] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880033] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880035] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880039] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880043] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880045] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880047] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880049] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880051] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880054] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.880056] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 13:12:01 cfhat12 kernel: [    0.886780] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 13:12:01 cfhat12 kernel: [    0.886782] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886785] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886787] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886791] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886793] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 13:12:01 cfhat12 kernel: [    0.886795] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886798] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886800] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886803] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 13:12:01 cfhat12 kernel: [    0.886805] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886808] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886810] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886813] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886815] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 13:12:01 cfhat12 kernel: [    0.886817] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886819] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886822] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886825] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 13:12:01 cfhat12 kernel: [    0.886827] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886831] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886834] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886840] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 13:12:01 cfhat12 kernel: [    0.886842] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886845] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886848] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886852] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 13:12:01 cfhat12 kernel: [    0.886856] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886863] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886869] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886879] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 13:12:01 cfhat12 kernel: [    0.886881] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886884] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886887] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886902] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:12:01 cfhat12 kernel: [    0.886905] pci 0000:00:07.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886912] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    0.886914] pci 0000:00:09.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886921] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    0.886923] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886932] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    0.886934] pci 0000:00:15.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886940] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    0.886942] pci 0000:00:15.1: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886953] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    0.886958] pci 0000:07:00.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    0.886962] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 13:12:01 cfhat12 kernel: [    0.886964] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886966] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886967] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886969] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886971] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886972] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886974] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886976] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886977] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886979] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886981] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886983] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886984] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886986] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886988] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886989] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886991] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886993] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886994] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.886996] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 13:12:01 cfhat12 kernel: [    0.886998] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.886999] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887001] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887003] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887004] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887006] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887008] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.887009] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887011] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887013] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.887015] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887016] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 13:12:01 cfhat12 kernel: [    0.887018] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:12:01 cfhat12 kernel: [    0.887069] NET: Registered protocol family 2
Jan  3 13:12:01 cfhat12 kernel: [    0.887113] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.887593] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.888547] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.888783] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 13:12:01 cfhat12 kernel: [    0.888785] TCP reno registered
Jan  3 13:12:01 cfhat12 kernel: [    0.888788] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.888825] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    0.888959] NET: Registered protocol family 1
Jan  3 13:12:01 cfhat12 kernel: [    0.889071] RPC: Registered udp transport module.
Jan  3 13:12:01 cfhat12 kernel: [    0.889072] RPC: Registered tcp transport module.
Jan  3 13:12:01 cfhat12 kernel: [    0.889073] RPC: Registered tcp NFSv4.1 backchannel transport module.
Jan  3 13:12:01 cfhat12 kernel: [    0.889081] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 13:12:01 cfhat12 kernel: [    0.967618] pci 0000:01:05.0: Boot video device
Jan  3 13:12:01 cfhat12 kernel: [    0.967656] PCI: CLS 4 bytes, default 64
Jan  3 13:12:01 cfhat12 kernel: [    0.967700] Trying to unpack rootfs image as initramfs...
Jan  3 13:12:01 cfhat12 kernel: [    1.012871] Freeing initrd memory: 3248k freed
Jan  3 13:12:01 cfhat12 kernel: [    1.013488] PCI-DMA: Disabling AGP.
Jan  3 13:12:01 cfhat12 kernel: [    1.013650] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 13:12:01 cfhat12 kernel: [    1.013651] PCI-DMA: using GART IOMMU.
Jan  3 13:12:01 cfhat12 kernel: [    1.013653] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 13:12:01 cfhat12 kernel: [    1.017766] audit: initializing netlink socket (disabled)
Jan  3 13:12:01 cfhat12 kernel: [    1.017775] type=2000 audit(1294078311.012:1): initialized
Jan  3 13:12:01 cfhat12 kernel: [    1.017807] I-pipe: Domain Xenomai registered.
Jan  3 13:12:01 cfhat12 kernel: [    1.017872] Xenomai: hal/x86_64 started.
Jan  3 13:12:01 cfhat12 kernel: [    1.017882] Xenomai: scheduling class idle registered.
Jan  3 13:12:01 cfhat12 kernel: [    1.017883] Xenomai: scheduling class rt registered.
Jan  3 13:12:01 cfhat12 kernel: [    1.019021] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 13:12:01 cfhat12 kernel: [    1.215627] Xenomai: native skin init failed, code -19.
Jan  3 13:12:01 cfhat12 kernel: [    1.215978] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  3 13:12:01 cfhat12 kernel: [    1.216117] VFS: Disk quotas dquot_6.5.2
Jan  3 13:12:01 cfhat12 kernel: [    1.216138] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 13:12:01 cfhat12 kernel: [    1.216314] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, debug enabled
Jan  3 13:12:01 cfhat12 kernel: [    1.216559] SGI XFS Quota Management subsystem
Jan  3 13:12:01 cfhat12 kernel: [    1.216564] msgmni has been set to 14971
Jan  3 13:12:01 cfhat12 kernel: [    1.216592] SELinux:  Registering netfilter hooks
Jan  3 13:12:01 cfhat12 kernel: [    1.216816] alg: No test for stdrng (krng)
Jan  3 13:12:01 cfhat12 kernel: [    1.216860] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  3 13:12:01 cfhat12 kernel: [    1.216862] io scheduler noop registered
Jan  3 13:12:01 cfhat12 kernel: [    1.216863] io scheduler deadline registered
Jan  3 13:12:01 cfhat12 kernel: [    1.216875] io scheduler cfq registered (default)
Jan  3 13:12:01 cfhat12 kernel: [    1.216960] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.216980] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.217051] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.217067] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.217135] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.217151] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.217219] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.217249] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.217329] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.217359] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.217813] Non-volatile memory driver v1.3
Jan  3 13:12:01 cfhat12 kernel: [    1.217816] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  3 13:12:01 cfhat12 kernel: [    1.471767] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:12:01 cfhat12 kernel: [    1.472110] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:12:01 cfhat12 kernel: [    1.472206] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:12:01 cfhat12 kernel: [    1.472291] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 13:12:01 cfhat12 kernel: [    1.472403] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 13:12:01 cfhat12 kernel: [    1.472516] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 13:12:01 cfhat12 kernel: [    1.472547] Couldn't register serial port 0000:05:06.0: -28
Jan  3 13:12:01 cfhat12 kernel: [    1.472554] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:12:01 cfhat12 kernel: [    1.472556] Couldn't register serial port 0000:05:06.1: -28
Jan  3 13:12:01 cfhat12 kernel: [    1.473681] brd: module loaded
Jan  3 13:12:01 cfhat12 kernel: [    1.473845] ahci 0000:00:11.0: version 3.0
Jan  3 13:12:01 cfhat12 kernel: [    1.473852] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:12:01 cfhat12 kernel: [    1.473886] ahci 0000:00:11.0: irq 45 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    1.473950] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 13:12:01 cfhat12 kernel: [    1.473953] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 13:12:01 cfhat12 kernel: [    1.474120] scsi0 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.474191] scsi1 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.474237] scsi2 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.474285] scsi3 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.474378] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 45
Jan  3 13:12:01 cfhat12 kernel: [    1.474381] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 45
Jan  3 13:12:01 cfhat12 kernel: [    1.474384] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 45
Jan  3 13:12:01 cfhat12 kernel: [    1.474386] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 45
Jan  3 13:12:01 cfhat12 kernel: [    1.474412] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.487642] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 13:12:01 cfhat12 kernel: [    1.487645] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 13:12:01 cfhat12 kernel: [    1.487650] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.487766] scsi4 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.487836] scsi5 : ahci
Jan  3 13:12:01 cfhat12 kernel: [    1.487873] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 13:12:01 cfhat12 kernel: [    1.487876] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 13:12:01 cfhat12 kernel: [    1.488065] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.488136] scsi6 : pata_atiixp
Jan  3 13:12:01 cfhat12 kernel: [    1.488191] scsi7 : pata_atiixp
Jan  3 13:12:01 cfhat12 kernel: [    1.488920] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 13:12:01 cfhat12 kernel: [    1.488922] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 13:12:01 cfhat12 kernel: [    1.489096] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 13:12:01 cfhat12 kernel: [    1.489100] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.489120] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.489157] scsi8 : pata_jmicron
Jan  3 13:12:01 cfhat12 kernel: [    1.489222] scsi9 : pata_jmicron
Jan  3 13:12:01 cfhat12 kernel: [    1.489253] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 13:12:01 cfhat12 kernel: [    1.489254] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 13:12:01 cfhat12 kernel: [    1.489398] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Jan  3 13:12:01 cfhat12 kernel: [    1.489400] e100: Copyright(c) 1999-2006 Intel Corporation
Jan  3 13:12:01 cfhat12 kernel: [    1.489487] console [netcon0] enabled
Jan  3 13:12:01 cfhat12 kernel: [    1.489488] netconsole: network logging started
Jan  3 13:12:01 cfhat12 kernel: [    1.489498] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 13:12:01 cfhat12 kernel: [    1.489509] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.489520] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.489536] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 13:12:01 cfhat12 kernel: [    1.489557] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 13:12:01 cfhat12 kernel: [    1.489567] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 13:12:01 cfhat12 kernel: [    1.499624] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 13:12:01 cfhat12 kernel: [    1.499754] hub 1-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.499757] hub 1-0:1.0: 5 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.499795] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.499805] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.499810] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 13:12:01 cfhat12 kernel: [    1.499831] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 13:12:01 cfhat12 kernel: [    1.499841] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 13:12:01 cfhat12 kernel: [    1.511623] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 13:12:01 cfhat12 kernel: [    1.511744] hub 2-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.511747] hub 2-0:1.0: 5 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.511783] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.511794] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.511798] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 13:12:01 cfhat12 kernel: [    1.511819] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 13:12:01 cfhat12 kernel: [    1.511829] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 13:12:01 cfhat12 kernel: [    1.523625] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 13:12:01 cfhat12 kernel: [    1.523743] hub 3-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.523746] hub 3-0:1.0: 4 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.523799] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 13:12:01 cfhat12 kernel: [    1.523808] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    1.523820] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.523825] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 13:12:01 cfhat12 kernel: [    1.523848] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 13:12:01 cfhat12 kernel: [    1.583724] hub 4-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.583729] hub 4-0:1.0: 5 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.583763] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    1.583774] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.583778] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 13:12:01 cfhat12 kernel: [    1.583791] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 13:12:01 cfhat12 kernel: [    1.643742] hub 5-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.643750] hub 5-0:1.0: 5 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.643795] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    1.643806] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.643811] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 13:12:01 cfhat12 kernel: [    1.643827] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 13:12:01 cfhat12 kernel: [    1.658613] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 13:12:01 cfhat12 kernel: [    1.658625] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  3 13:12:01 cfhat12 kernel: [    1.671894] ata7.00: configured for UDMA/33
Jan  3 13:12:01 cfhat12 kernel: [    1.707735] hub 6-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.707741] hub 6-0:1.0: 2 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.707771] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    1.707782] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.707787] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 13:12:01 cfhat12 kernel: [    1.707800] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 13:12:01 cfhat12 kernel: [    1.767735] hub 7-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.767740] hub 7-0:1.0: 4 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.767791] uhci_hcd: USB Universal Host Controller Interface driver
Jan  3 13:12:01 cfhat12 kernel: [    1.767840] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    1.767852] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.767854] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 13:12:01 cfhat12 kernel: [    1.767860] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 13:12:01 cfhat12 kernel: [    1.767958] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 13:12:01 cfhat12 kernel: [    1.771321] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 13:12:01 cfhat12 kernel: [    1.771429] xHCI xhci_add_endpoint called for root hub
Jan  3 13:12:01 cfhat12 kernel: [    1.771431] xHCI xhci_check_bandwidth called for root hub
Jan  3 13:12:01 cfhat12 kernel: [    1.771465] hub 8-0:1.0: USB hub found
Jan  3 13:12:01 cfhat12 kernel: [    1.771468] hub 8-0:1.0: 4 ports detected
Jan  3 13:12:01 cfhat12 kernel: [    1.771565] usbcore: registered new interface driver usblp
Jan  3 13:12:01 cfhat12 kernel: [    1.771567] Initializing USB Mass Storage driver...
Jan  3 13:12:01 cfhat12 kernel: [    1.771627] usbcore: registered new interface driver usb-storage
Jan  3 13:12:01 cfhat12 kernel: [    1.771628] USB Mass Storage support registered.
Jan  3 13:12:01 cfhat12 kernel: [    1.771688] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 13:12:01 cfhat12 kernel: [    1.771690] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 13:12:01 cfhat12 kernel: [    1.771815] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 13:12:01 cfhat12 kernel: [    1.771904] mice: PS/2 mouse device common for all mice
Jan  3 13:12:01 cfhat12 kernel: [    1.771950] rtc_cmos 00:04: RTC can wake from S4
Jan  3 13:12:01 cfhat12 kernel: [    1.771992] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 13:12:01 cfhat12 kernel: [    1.772011] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 13:12:01 cfhat12 kernel: [    1.772036] md: linear personality registered for level -1
Jan  3 13:12:01 cfhat12 kernel: [    1.772037] md: raid0 personality registered for level 0
Jan  3 13:12:01 cfhat12 kernel: [    1.772039] md: raid1 personality registered for level 1
Jan  3 13:12:01 cfhat12 kernel: [    1.772040] md: raid10 personality registered for level 10
Jan  3 13:12:01 cfhat12 kernel: [    1.772042] md: raid6 personality registered for level 6
Jan  3 13:12:01 cfhat12 kernel: [    1.772043] md: raid5 personality registered for level 5
Jan  3 13:12:01 cfhat12 kernel: [    1.772045] md: raid4 personality registered for level 4
Jan  3 13:12:01 cfhat12 kernel: [    1.772129] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid
Jan  3 13:12:01 cfhat12 kernel: [    1.772137] cpuidle: using governor ladder
Jan  3 13:12:01 cfhat12 kernel: [    1.773027] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:12:01 cfhat12 kernel: [    1.773055] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    1.788125] ALSA device list:
Jan  3 13:12:01 cfhat12 kernel: [    1.788126]   #0: HDA ATI HDMI at 0xfd3fc000 irq 19
Jan  3 13:12:01 cfhat12 kernel: [    1.788155] Netfilter messages via NETLINK v0.30.
Jan  3 13:12:01 cfhat12 kernel: [    1.788164] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jan  3 13:12:01 cfhat12 kernel: [    1.788242] ctnetlink v0.93: registering with nfnetlink.
Jan  3 13:12:01 cfhat12 kernel: [    1.788524] ip_tables: (C) 2000-2006 Netfilter Core Team
Jan  3 13:12:01 cfhat12 kernel: [    1.788553] TCP bic registered
Jan  3 13:12:01 cfhat12 kernel: [    1.788554] TCP cubic registered
Jan  3 13:12:01 cfhat12 kernel: [    1.788556] NET: Registered protocol family 17
Jan  3 13:12:01 cfhat12 kernel: [    1.788674] registered taskstats version 1
Jan  3 13:12:01 cfhat12 kernel: [    1.795648] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    1.803651] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    1.811673] ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    1.811677] ata5: SATA link down (SStatus 0 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    1.827713] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 13:12:01 cfhat12 kernel: [    1.975645] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 13:12:01 cfhat12 kernel: [    1.983655] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    1.984996] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 13:12:01 cfhat12 kernel: [    1.984998] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 13:12:01 cfhat12 kernel: [    1.986555] ata1.00: configured for UDMA/133
Jan  3 13:12:01 cfhat12 kernel: [    2.003740] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 13:12:01 cfhat12 kernel: [    2.003913] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:12:01 cfhat12 kernel: [    2.003939] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 13:12:01 cfhat12 kernel: [    2.003941] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 13:12:01 cfhat12 kernel: [    2.003944] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  3 13:12:01 cfhat12 kernel: [    2.003953] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:12:01 cfhat12 kernel: [    2.004032]  sda: sda1 sda2 sda3 sda4 < sda5
Jan  3 13:12:01 cfhat12 kernel: [    2.031651] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:12:01 cfhat12 kernel: [    2.032635]  sda6
Jan  3 13:12:01 cfhat12 kernel: [    2.034571] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 13:12:01 cfhat12 kernel: [    2.034573] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 13:12:01 cfhat12 kernel: [    2.037640] ata2.00: configured for UDMA/133
Jan  3 13:12:01 cfhat12 kernel: [    2.041675]  sda7 >
Jan  3 13:12:01 cfhat12 kernel: [    2.042077] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 13:12:01 cfhat12 kernel: [    2.055719] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 13:12:01 cfhat12 kernel: [    2.055837] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:12:01 cfhat12 kernel: [    2.055863] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 13:12:01 cfhat12 kernel: [    2.055865] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 13:12:01 cfhat12 kernel: [    2.055875] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:12:01 cfhat12 kernel: [    2.055920] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  3 13:12:01 cfhat12 kernel: [    2.055950]  sdb:
Jan  3 13:12:01 cfhat12 kernel: [    2.056737] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 13:12:01 cfhat12 kernel: [    2.060876] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 13:12:01 cfhat12 kernel: [    2.060879] Uniform CD-ROM driver Revision: 3.20
Jan  3 13:12:01 cfhat12 kernel: [    2.061005] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  3 13:12:01 cfhat12 kernel: [    2.061077] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  3 13:12:01 cfhat12 kernel: [    2.065765]  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jan  3 13:12:01 cfhat12 kernel: [    2.095536] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 13:12:01 cfhat12 kernel: [    2.227121] Freeing unused kernel memory: 488k freed
Jan  3 13:12:01 cfhat12 kernel: [    2.236767] udev[808]: starting version 164
Jan  3 13:12:01 cfhat12 kernel: [    2.255107] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 13:12:01 cfhat12 kernel: [    2.255110] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 13:12:01 cfhat12 kernel: [    2.255145] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:12:01 cfhat12 kernel: [    2.255160] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    2.255317] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    2.255319] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    2.255322] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    2.255815] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 13:12:01 cfhat12 kernel: [    2.257778] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 13:12:01 cfhat12 kernel: [    2.257791] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:12:01 cfhat12 kernel: [    2.257823] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 13:12:01 cfhat12 kernel: [    2.257858] r8169 0000:04:00.0: irq 49 for MSI/MSI-X
Jan  3 13:12:01 cfhat12 kernel: [    2.258048] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000070000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 49
Jan  3 13:12:01 cfhat12 kernel: [    2.274708] usbcore: registered new interface driver hiddev
Jan  3 13:12:01 cfhat12 kernel: [    2.278793] input: USBPS2 as /class/input/input1
Jan  3 13:12:01 cfhat12 kernel: [    2.278803] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 13:12:01 cfhat12 kernel: [    2.285859] input: USBPS2 as /class/input/input2
Jan  3 13:12:01 cfhat12 kernel: [    2.285898] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 13:12:01 cfhat12 kernel: [    2.285908] usbcore: registered new interface driver usbhid
Jan  3 13:12:01 cfhat12 kernel: [    2.285910] usbhid: USB HID core driver
Jan  3 13:12:01 cfhat12 kernel: [    2.376792] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 13:12:01 cfhat12 kernel: [    2.376794] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 13:12:01 cfhat12 kernel: [    2.376806] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 13:12:01 cfhat12 kernel: [    2.527474] md: md1 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    2.528265] md: bind<sdb1>
Jan  3 13:12:01 cfhat12 kernel: [    2.528441] md: bind<sda1>
Jan  3 13:12:01 cfhat12 kernel: [    2.529141] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    2.529154] md1: detected capacity change from 0 to 254791680
Jan  3 13:12:01 cfhat12 kernel: [    2.529670]  md1: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    2.744035] md: md2 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    2.744775] md: bind<sdb2>
Jan  3 13:12:01 cfhat12 kernel: [    2.744915] md: bind<sda2>
Jan  3 13:12:01 cfhat12 kernel: [    2.745591] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    2.745604] md2: detected capacity change from 0 to 19998367744
Jan  3 13:12:01 cfhat12 kernel: [    2.746115]  md2: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    2.959826] md: md3 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    2.960609] md: bind<sdb3>
Jan  3 13:12:01 cfhat12 kernel: [    2.960765] md: bind<sda3>
Jan  3 13:12:01 cfhat12 kernel: [    2.961442] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    2.961456] md3: detected capacity change from 0 to 1998573568
Jan  3 13:12:01 cfhat12 kernel: [    2.961961]  md3: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    3.189172] md: md5 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    3.189956] md: bind<sdb5>
Jan  3 13:12:01 cfhat12 kernel: [    3.190139] md: bind<sda5>
Jan  3 13:12:01 cfhat12 kernel: [    3.190818] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    3.190831] md5: detected capacity change from 0 to 19997319168
Jan  3 13:12:01 cfhat12 kernel: [    3.191336]  md5: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    3.421947] md: md6 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    3.422778] md: bind<sdb6>
Jan  3 13:12:01 cfhat12 kernel: [    3.422955] md: bind<sda6>
Jan  3 13:12:01 cfhat12 kernel: [    3.423638] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    3.423651] md6: detected capacity change from 0 to 19997319168
Jan  3 13:12:01 cfhat12 kernel: [    3.424171]  md6: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    3.647978] md: md7 stopped.
Jan  3 13:12:01 cfhat12 kernel: [    3.648980] md: bind<sdb7>
Jan  3 13:12:01 cfhat12 kernel: [    3.649179] md: bind<sda7>
Jan  3 13:12:01 cfhat12 kernel: [    3.649861] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 13:12:01 cfhat12 kernel: [    3.649874] md7: detected capacity change from 0 to 97784881152
Jan  3 13:12:01 cfhat12 kernel: [    3.650377]  md7: unknown partition table
Jan  3 13:12:01 cfhat12 kernel: [    3.922072] XFS mounting filesystem md2
Jan  3 13:12:01 cfhat12 kernel: [    4.219245] Ending clean XFS mount for filesystem: md2
Jan  3 13:12:01 cfhat12 kernel: [    5.552145] udev[1085]: starting version 164
Jan  3 13:12:01 cfhat12 kernel: [    6.164546] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f]
Jan  3 13:12:01 cfhat12 kernel: [    6.164549] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 13:12:01 cfhat12 kernel: [    6.199407] input: Power Button as /class/input/input3
Jan  3 13:12:01 cfhat12 kernel: [    6.199439] ACPI: Power Button [PWRB]
Jan  3 13:12:01 cfhat12 kernel: [    6.199487] input: Power Button as /class/input/input4
Jan  3 13:12:01 cfhat12 kernel: [    6.199505] ACPI: Power Button [PWRF]
Jan  3 13:12:01 cfhat12 kernel: [    6.225528] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    6.225532] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    6.225608] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 13:12:01 cfhat12 kernel: [    6.233518] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 13:12:01 cfhat12 kernel: [    6.237542] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 13:12:01 cfhat12 kernel: [    6.237544] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 13:12:01 cfhat12 kernel: [    6.237545] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 13:12:01 cfhat12 kernel: [    6.238594] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 13:12:01 cfhat12 kernel: [    6.319920] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 13:12:01 cfhat12 kernel: [    6.320018] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 13:12:01 cfhat12 kernel: [    7.536809] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 13:12:01 cfhat12 kernel: [    7.881066] loop: module loaded
Jan  3 13:12:01 cfhat12 kernel: [    8.554344] EXT3-fs: barriers not enabled
Jan  3 13:12:01 cfhat12 kernel: [    8.564173] kjournald starting.  Commit interval 5 seconds
Jan  3 13:12:01 cfhat12 kernel: [    8.579013] EXT3-fs (md1): using internal journal
Jan  3 13:12:01 cfhat12 kernel: [    8.579017] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 13:12:01 cfhat12 kernel: [    8.652496] XFS mounting filesystem md7
Jan  3 13:12:01 cfhat12 kernel: [    9.011344] Ending clean XFS mount for filesystem: md7
Jan  3 13:12:01 cfhat12 kernel: [    9.068982] XFS mounting filesystem md5
Jan  3 13:12:01 cfhat12 kernel: [    9.359427] Ending clean XFS mount for filesystem: md5
Jan  3 13:12:01 cfhat12 kernel: [    9.375692] EXT3-fs: barriers not enabled
Jan  3 13:12:01 cfhat12 kernel: [    9.382758] kjournald starting.  Commit interval 5 seconds
Jan  3 13:12:01 cfhat12 kernel: [    9.398440] EXT3-fs (md6): using internal journal
Jan  3 13:12:01 cfhat12 kernel: [    9.398444] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 13:12:01 cfhat12 kernel: [   10.111611] r8169 0000:04:00.0: eth0: link up
Jan  3 13:12:01 cfhat12 kernel: [   10.111617] r8169 0000:04:00.0: eth0: link up
Jan  3 13:12:01 cfhat12 kernel: [   10.617707] fuse init (API version 7.14)
Jan  3 13:12:01 cfhat12 kernel: [   10.884276] NET: Registered protocol family 10
Jan  3 13:12:11 cfhat12 kernel: [   21.116481] eth0: no IPv6 routers present
Jan  3 13:17:47 cfhat12 kernel: [  357.661878] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:17:48 cfhat12 kernel: [  358.117223] [drm] Initialized drm 1.1.0 20060810
Jan  3 13:17:48 cfhat12 kernel: [  358.178759] [drm] radeon kernel modesetting enabled.
Jan  3 13:17:48 cfhat12 kernel: [  358.178800] radeon 0000:01:05.0: setting latency timer to 64
Jan  3 13:17:48 cfhat12 kernel: [  358.179907] [drm] initializing kernel modesetting (RS880 0x1002:0x9715).
Jan  3 13:17:48 cfhat12 kernel: [  358.180052] [drm] register mmio base: 0xFD3E0000
Jan  3 13:17:48 cfhat12 kernel: [  358.180054] [drm] register mmio size: 65536
Jan  3 13:17:48 cfhat12 kernel: [  358.182157] ATOM BIOS: B43106_DVI
Jan  3 13:17:48 cfhat12 kernel: [  358.182167] [drm] Clocks initialized !
Jan  3 13:17:48 cfhat12 kernel: [  358.182174] radeon 0000:01:05.0: VRAM: 512M 0xC0000000 - 0xDFFFFFFF (512M used)
Jan  3 13:17:48 cfhat12 kernel: [  358.182176] radeon 0000:01:05.0: GTT: 512M 0xA0000000 - 0xBFFFFFFF
Jan  3 13:17:48 cfhat12 kernel: [  358.184207] [drm] Detected VRAM RAM=512M, BAR=256M
Jan  3 13:17:48 cfhat12 kernel: [  358.184210] [drm] RAM width 32bits DDR
Jan  3 13:17:48 cfhat12 kernel: [  358.184282] [TTM] Zone  kernel: Available graphics memory: 3832944 kiB.
Jan  3 13:17:48 cfhat12 kernel: [  358.184284] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
Jan  3 13:17:48 cfhat12 kernel: [  358.184285] [TTM] Initializing pool allocator.
Jan  3 13:17:48 cfhat12 kernel: [  358.184300] [drm] radeon: 512M of VRAM memory ready
Jan  3 13:17:48 cfhat12 kernel: [  358.184302] [drm] radeon: 512M of GTT memory ready.
Jan  3 13:17:48 cfhat12 kernel: [  358.184333] [drm] radeon: irq initialized.
Jan  3 13:17:48 cfhat12 kernel: [  358.184335] [drm] GART: num cpu pages 131072, num gpu pages 131072
Jan  3 13:17:48 cfhat12 kernel: [  358.184842] [drm] Loading RS780 Microcode
Jan  3 13:17:48 cfhat12 kernel: [  358.219766] r600_cp: Failed to load firmware "radeon/R600_rlc.bin"
Jan  3 13:17:48 cfhat12 kernel: [  358.219772] [drm:r600_startup] *ERROR* Failed to load firmware!
Jan  3 13:17:48 cfhat12 kernel: [  358.219774] radeon 0000:01:05.0: disabling GPU acceleration
Jan  3 13:17:48 cfhat12 kernel: [  358.220776] radeon 0000:01:05.0: ffff88020dec0a00 unpin not necessary
Jan  3 13:17:48 cfhat12 kernel: [  358.220778] radeon 0000:01:05.0: ffff88020dec0a00 unpin not necessary
Jan  3 13:17:48 cfhat12 kernel: [  358.220781] [drm] Enabling audio support
Jan  3 13:17:48 cfhat12 kernel: [  358.220802] [drm] Unknown TV standard; defaulting to NTSC
Jan  3 13:17:48 cfhat12 kernel: [  358.220868] [drm] Radeon Display Connectors
Jan  3 13:17:48 cfhat12 kernel: [  358.220870] [drm] Connector 0:
Jan  3 13:17:48 cfhat12 kernel: [  358.220871] [drm]   VGA
Jan  3 13:17:48 cfhat12 kernel: [  358.220872] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
Jan  3 13:17:48 cfhat12 kernel: [  358.220873] [drm]   Encoders:
Jan  3 13:17:48 cfhat12 kernel: [  358.220874] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Jan  3 13:17:48 cfhat12 kernel: [  358.220876] [drm] Connector 1:
Jan  3 13:17:48 cfhat12 kernel: [  358.220877] [drm]   DVI-D
Jan  3 13:17:48 cfhat12 kernel: [  358.220878] [drm]   HPD1
Jan  3 13:17:48 cfhat12 kernel: [  358.220879] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
Jan  3 13:17:48 cfhat12 kernel: [  358.220880] [drm]   Encoders:
Jan  3 13:17:48 cfhat12 kernel: [  358.220881] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
Jan  3 13:17:48 cfhat12 kernel: [  358.274427] [drm] radeon: power management initialized
Jan  3 13:17:48 cfhat12 kernel: [  358.342360] [drm] fb mappable at 0xD0040000
Jan  3 13:17:48 cfhat12 kernel: [  358.342362] [drm] vram apper at 0xD0000000
Jan  3 13:17:48 cfhat12 kernel: [  358.342363] [drm] size 7680000
Jan  3 13:17:48 cfhat12 kernel: [  358.342364] [drm] fb depth is 24
Jan  3 13:17:48 cfhat12 kernel: [  358.342365] [drm]    pitch is 6400
Jan  3 13:17:48 cfhat12 kernel: [  358.342580] Console: switching to colour frame buffer device 200x75
Jan  3 13:17:48 cfhat12 kernel: [  358.342586] fb0: radeondrmfb frame buffer device
Jan  3 13:17:48 cfhat12 kernel: [  358.342587] drm: registered panic notifier
Jan  3 13:17:48 cfhat12 kernel: [  358.342589] Slow work thread pool: Starting up
Jan  3 13:17:48 cfhat12 kernel: [  358.342630] Slow work thread pool: Ready
Jan  3 13:17:48 cfhat12 kernel: [  358.342634] [drm] Initialized radeon 2.5.0 20080528 for 0000:01:05.0 on minor 0
Jan  3 13:22:37 cfhat12 kernel: [  647.833542] md: md7 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833571] md: md6 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833598] md: md5 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833629] md: md3 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833660] md: md2 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833689] md: md1 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833767] md: md7 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833804] md: md6 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833829] md: md5 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833857] md: md3 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833883] md: md2 still in use.
Jan  3 13:22:37 cfhat12 kernel: [  647.833907] md: md1 still in use.
Jan  3 13:22:38 cfhat12 kernel: [  648.733946] fuse exit
Jan  3 13:22:43 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 13:24:13 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Linux version 2.6.35.7-xeno3 (hatuser@domain.hid) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Mon Jan 3 13:04:23 EST 2011
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] NX (Execute Disable) protection: active
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   6 disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   7 disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] RAMDISK: 37cc4000 - 37ff0000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880002200000-ffff880008bfffff] on node 0
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]     0: 0x00000001 -> 0x0000009f
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965454
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA zone: 0 pages reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA zone: 3942 pages, LIFO batch:0
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 40
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] early_res array is doubled to 64 at [3000 - 37ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880001a00000 s101760 r8192 d21120 u262144
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] pcpu-alloc: s101760 r8192 d21120 u262144 alloc=1*2097152
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935886
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Node 0: aperture @ f90000000 size 32 MB
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] early_res array is doubled to 128 at [3800 - 47ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Subtract (58 early reservations)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #1 [0001000000 - 000188d234]   TEXT DATA BSS
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #2 [0037cc4000 - 0037ff0000]         RAMDISK
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #3 [000188e000 - 000188e0fe]             BRK
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #4 [00000f4420 - 0000100000]   BIOS reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #5 [00000f4410 - 00000f4420]    MP-table mpf
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #6 [000009f800 - 00000f1aa4]   BIOS reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #7 [00000f1c88 - 00000f4410]   BIOS reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #8 [00000f1aa4 - 00000f1c88]    MP-table mpc
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #10 [0000008000 - 000000a000]         PGTABLE
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #11 [000000a000 - 000000b000]         PGTABLE
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #12 [000188e100 - 000188f100]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #13 [000188d240 - 000188d7e0]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #14 [0002090000 - 0002091000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #15 [0002091000 - 0002092000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #16 [0002200000 - 0008c00000]        MEMMAP 0
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #17 [000188d800 - 000188d980]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #18 [000188f100 - 00018a7100]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #19 [00018a7100 - 00018bf100]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #20 [00018c0000 - 00018c1000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #21 [000188d980 - 000188d9c3]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #22 [000188da00 - 000188dc68]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #23 [000188dc80 - 000188dce8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #24 [000188dd00 - 000188dd68]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #25 [000188dd80 - 000188dde8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #26 [000188de00 - 000188de68]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #27 [000188de80 - 000188dee8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #28 [000188df00 - 000188df68]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #29 [000188df80 - 000188dfe8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #30 [00018bf100 - 00018bf168]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #31 [00018bf180 - 00018bf1e8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #32 [00018bf200 - 00018bf268]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #33 [00018bf280 - 00018bf2db]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #34 [00018bf300 - 00018bf35b]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #35 [0001a00000 - 0001a20000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #36 [0001a40000 - 0001a60000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #37 [0001a80000 - 0001aa0000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #38 [0001ac0000 - 0001ae0000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #39 [0001b00000 - 0001b20000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #40 [0001b40000 - 0001b60000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #41 [0001b80000 - 0001ba0000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #42 [0001bc0000 - 0001be0000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #43 [00018bf380 - 00018bf388]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #44 [00018bf3c0 - 00018bf3c8]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #45 [00018bf400 - 00018bf420]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #46 [00018bf440 - 00018bf480]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #47 [00018bf480 - 00018bf5a0]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #48 [00018bf5c0 - 00018bf608]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #49 [00018bf640 - 00018bf688]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #50 [00018c1000 - 00018c9000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #51 [0008c00000 - 0009400000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #52 [0001be0000 - 0001fe0000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #54 [0009400000 - 000d400000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #55 [00018c9000 - 00018e9000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #56 [00018e9000 - 0001929000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000]   #57 [000000b000 - 0000013000]         BOOTMEM
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Memory: 7596200k/8650752k available (4645k kernel code, 788936k absent, 265616k reserved, 2462k data, 488k init)
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] NR_IRQS:512
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] I-pipe 2.7-04: pipeline enabled.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  3 13:24:13 cfhat12 kernel: [    0.000000] Detected 3414.402 MHz processor.
Jan  3 13:24:13 cfhat12 kernel: [    0.008006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6828.79 BogoMIPS (lpj=13657592)
Jan  3 13:24:13 cfhat12 kernel: [    0.008009] pid_max: default: 32768 minimum: 301
Jan  3 13:24:13 cfhat12 kernel: [    0.008041] Security Framework initialized
Jan  3 13:24:13 cfhat12 kernel: [    0.008043] SELinux:  Initializing.
Jan  3 13:24:13 cfhat12 kernel: [    0.008051] SELinux:  Starting in permissive mode
Jan  3 13:24:13 cfhat12 kernel: [    0.008063] Mount-cache hash table entries: 256
Jan  3 13:24:13 cfhat12 kernel: [    0.008140] Initializing cgroup subsys ns
Jan  3 13:24:13 cfhat12 kernel: [    0.008143] Initializing cgroup subsys cpuacct
Jan  3 13:24:13 cfhat12 kernel: [    0.008146] Initializing cgroup subsys devices
Jan  3 13:24:13 cfhat12 kernel: [    0.008162] tseg: 00cff00000
Jan  3 13:24:13 cfhat12 kernel: [    0.008163] CPU: Physical Processor ID: 0
Jan  3 13:24:13 cfhat12 kernel: [    0.008164] CPU: Processor Core ID: 0
Jan  3 13:24:13 cfhat12 kernel: [    0.008166] mce: CPU supports 6 MCE banks
Jan  3 13:24:13 cfhat12 kernel: [    0.008172] using C1E aware idle routine
Jan  3 13:24:13 cfhat12 kernel: [    0.008173] Performance Events: AMD PMU driver.
Jan  3 13:24:13 cfhat12 kernel: [    0.008176] ... version:                0
Jan  3 13:24:13 cfhat12 kernel: [    0.008177] ... bit width:              48
Jan  3 13:24:13 cfhat12 kernel: [    0.008178] ... generic registers:      4
Jan  3 13:24:13 cfhat12 kernel: [    0.008179] ... value mask:             0000ffffffffffff
Jan  3 13:24:13 cfhat12 kernel: [    0.008180] ... max period:             00007fffffffffff
Jan  3 13:24:13 cfhat12 kernel: [    0.008182] ... fixed-purpose events:   0
Jan  3 13:24:13 cfhat12 kernel: [    0.008183] ... event mask:             000000000000000f
Jan  3 13:24:13 cfhat12 kernel: [    0.008232] ACPI: Core revision 20100428
Jan  3 13:24:13 cfhat12 kernel: [    0.016056] Setting APIC routing to flat
Jan  3 13:24:13 cfhat12 kernel: [    0.016444] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  3 13:24:13 cfhat12 kernel: [    0.020000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jan  3 13:24:13 cfhat12 kernel: [    0.020000] ...trying to set up timer (IRQ0) through the 8259A ...
Jan  3 13:24:13 cfhat12 kernel: [    0.020000] ..... (found apic 0 pin 2) ...
Jan  3 13:24:13 cfhat12 kernel: [    0.060924] ....... works.
Jan  3 13:24:13 cfhat12 kernel: [    0.060925] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:24:13 cfhat12 kernel: [    0.064000] Booting Node   0, Processors  #1
Jan  3 13:24:13 cfhat12 kernel: [    0.152005] System has AMD C1E enabled
Jan  3 13:24:13 cfhat12 kernel: [    0.152005] Switch to broadcast mode on CPU1
Jan  3 13:24:13 cfhat12 kernel: [    0.152053]  #2
Jan  3 13:24:13 cfhat12 kernel: [    0.244008] Switch to broadcast mode on CPU2
Jan  3 13:24:13 cfhat12 kernel: [    0.244054]  #3
Jan  3 13:24:13 cfhat12 kernel: [    0.012000] Switch to broadcast mode on CPU3
Jan  3 13:24:13 cfhat12 kernel: [    0.336027] Brought up 4 CPUs
Jan  3 13:24:13 cfhat12 kernel: [    0.336030] Total of 4 processors activated (27321.00 BogoMIPS).
Jan  3 13:24:13 cfhat12 kernel: [    0.337662] Switch to broadcast mode on CPU0
Jan  3 13:24:13 cfhat12 kernel: [    0.337803] devtmpfs: initialized
Jan  3 13:24:13 cfhat12 kernel: [    0.338059] xor: automatically using best checksumming function: generic_sse
Jan  3 13:24:13 cfhat12 kernel: [    0.356005]    generic_sse: 13684.000 MB/sec
Jan  3 13:24:13 cfhat12 kernel: [    0.356007] xor: using function: generic_sse (13684.000 MB/sec)
Jan  3 13:24:13 cfhat12 kernel: [    0.356042] NET: Registered protocol family 16
Jan  3 13:24:13 cfhat12 kernel: [    0.356334] node 0 link 0: io port [8000, ffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356337] TOM: 00000000d0000000 aka 3328M
Jan  3 13:24:13 cfhat12 kernel: [    0.356338] Fam 10h mmconf [e0000000, e00fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356340] node 0 link 0: mmio [a0000, bffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356342] node 0 link 0: mmio [d0000000, dfffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356344] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356346] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356349] TOM2: 0000000230000000 aka 8960M
Jan  3 13:24:13 cfhat12 kernel: [    0.356351] bus: [00, 08] on node 0 link 0
Jan  3 13:24:13 cfhat12 kernel: [    0.356353] bus: 00 index 0 [io  0x0000-0xffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356355] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356357] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356358] bus: 00 index 3 [mem 0xe0900000-0xffffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356360] bus: 00 index 4 [mem 0xe0100000-0xe08fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356361] bus: 00 index 5 [mem 0x230000000-0xfcffffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.356369] ACPI: bus type pci registered
Jan  3 13:24:13 cfhat12 kernel: [    0.356430] PCI: Using configuration type 1 for base access
Jan  3 13:24:13 cfhat12 kernel: [    0.356431] PCI: Using configuration type 1 for extended access
Jan  3 13:24:13 cfhat12 kernel: [    0.360219] bio: create slab <bio-0> at 0
Jan  3 13:24:13 cfhat12 kernel: [    0.360898] ACPI: EC: Look up EC in DSDT
Jan  3 13:24:13 cfhat12 kernel: [    0.367422] ACPI: Interpreter enabled
Jan  3 13:24:13 cfhat12 kernel: [    0.367425] ACPI: (supports S0 S5)
Jan  3 13:24:13 cfhat12 kernel: [    0.367435] ACPI: Using IOAPIC for interrupt routing
Jan  3 13:24:13 cfhat12 kernel: [    0.372665] ACPI Warning: Incorrect checksum in table [TAMG] - 0x97, should be 0x96 (20100428/tbutils-314)
Jan  3 13:24:13 cfhat12 kernel: [    0.372739] ACPI: No dock devices found.
Jan  3 13:24:13 cfhat12 kernel: [    0.372742] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan  3 13:24:13 cfhat12 kernel: [    0.372831] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jan  3 13:24:13 cfhat12 kernel: [    0.373011] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
Jan  3 13:24:13 cfhat12 kernel: [    0.373013] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373015] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373017] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373019] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xfebfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373037] pci 0000:00:00.0: reg 1c: [mem 0xe0000000-0xffffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.373104] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.373107] pci 0000:00:07.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373133] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.373136] pci 0000:00:09.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373161] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.373164] pci 0000:00:0a.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373196] pci 0000:00:11.0: reg 10: [io  0xff00-0xff07]
Jan  3 13:24:13 cfhat12 kernel: [    0.373201] pci 0000:00:11.0: reg 14: [io  0xfe00-0xfe03]
Jan  3 13:24:13 cfhat12 kernel: [    0.373205] pci 0000:00:11.0: reg 18: [io  0xfd00-0xfd07]
Jan  3 13:24:13 cfhat12 kernel: [    0.373210] pci 0000:00:11.0: reg 1c: [io  0xfc00-0xfc03]
Jan  3 13:24:13 cfhat12 kernel: [    0.373215] pci 0000:00:11.0: reg 20: [io  0xfb00-0xfb0f]
Jan  3 13:24:13 cfhat12 kernel: [    0.373219] pci 0000:00:11.0: reg 24: [mem 0xfe02f000-0xfe02f3ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373232] pci 0000:00:11.0: set SATA to AHCI mode
Jan  3 13:24:13 cfhat12 kernel: [    0.373270] pci 0000:00:12.0: reg 10: [mem 0xfe02e000-0xfe02efff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373315] pci 0000:00:12.2: reg 10: [mem 0xfe02d000-0xfe02d0ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373351] pci 0000:00:12.2: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373352] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:24:13 cfhat12 kernel: [    0.373355] pci 0000:00:12.2: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373376] pci 0000:00:13.0: reg 10: [mem 0xfe02c000-0xfe02cfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373421] pci 0000:00:13.2: reg 10: [mem 0xfe02b000-0xfe02b0ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373457] pci 0000:00:13.2: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373458] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:24:13 cfhat12 kernel: [    0.373461] pci 0000:00:13.2: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373515] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
Jan  3 13:24:13 cfhat12 kernel: [    0.373520] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
Jan  3 13:24:13 cfhat12 kernel: [    0.373524] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
Jan  3 13:24:13 cfhat12 kernel: [    0.373529] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
Jan  3 13:24:13 cfhat12 kernel: [    0.373533] pci 0000:00:14.1: reg 20: [io  0xfa00-0xfa0f]
Jan  3 13:24:13 cfhat12 kernel: [    0.373613] pci 0000:00:14.5: reg 10: [mem 0xfe02a000-0xfe02afff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373679] pci 0000:00:15.0: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373727] pci 0000:00:15.1: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373752] pci 0000:00:16.0: reg 10: [mem 0xfe029000-0xfe029fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373797] pci 0000:00:16.2: reg 10: [mem 0xfe028000-0xfe0280ff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373832] pci 0000:00:16.2: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373834] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:24:13 cfhat12 kernel: [    0.373837] pci 0000:00:16.2: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.373922] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.373925] pci 0000:01:05.0: reg 14: [io  0xce00-0xceff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373928] pci 0000:01:05.0: reg 18: [mem 0xfd3e0000-0xfd3effff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373934] pci 0000:01:05.0: reg 24: [mem 0xfd200000-0xfd2fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373943] pci 0000:01:05.0: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373954] pci 0000:01:05.1: reg 10: [mem 0xfd3fc000-0xfd3fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.373970] pci 0000:01:05.1: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.373996] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 13:24:13 cfhat12 kernel: [    0.373999] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374001] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374005] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374056] pci 0000:02:00.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374064] pci 0000:02:00.0: reg 14: [mem 0xfdf00000-0xfdf7ffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374073] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
Jan  3 13:24:13 cfhat12 kernel: [    0.374081] pci 0000:02:00.0: reg 1c: [mem 0xfdffc000-0xfdffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374103] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374144] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.374149] pci 0000:02:00.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.374171] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 13:24:13 cfhat12 kernel: [    0.374174] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374176] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374179] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374219] pci 0000:03:00.0: reg 10: [mem 0xfddfe000-0xfddfffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.374259] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.374262] pci 0000:03:00.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.374274] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 13:24:13 cfhat12 kernel: [    0.374277] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374279] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374282] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374319] pci 0000:04:00.0: reg 10: [io  0xde00-0xdeff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374332] pci 0000:04:00.0: reg 18: [mem 0xfd4ff000-0xfd4fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374342] pci 0000:04:00.0: reg 20: [mem 0xfd4f8000-0xfd4fbfff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374348] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374374] pci 0000:04:00.0: supports D1 D2
Jan  3 13:24:13 cfhat12 kernel: [    0.374375] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  3 13:24:13 cfhat12 kernel: [    0.374378] pci 0000:04:00.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.374394] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 13:24:13 cfhat12 kernel: [    0.374397] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374399] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374402] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374433] pci 0000:05:06.0: reg 10: [io  0xaf00-0xaf07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374440] pci 0000:05:06.0: reg 14: [io  0xae00-0xae07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374446] pci 0000:05:06.0: reg 18: [io  0xad00-0xad07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374453] pci 0000:05:06.0: reg 1c: [io  0xac00-0xac07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374492] pci 0000:05:06.1: reg 10: [io  0xab00-0xab07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374499] pci 0000:05:06.1: reg 14: [io  0xaa00-0xaa07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374505] pci 0000:05:06.1: reg 18: [io  0xa900-0xa907]
Jan  3 13:24:13 cfhat12 kernel: [    0.374512] pci 0000:05:06.1: reg 1c: [io  0xa800-0xa807]
Jan  3 13:24:13 cfhat12 kernel: [    0.374557] pci 0000:05:08.0: reg 10: [io  0xa700-0xa707]
Jan  3 13:24:13 cfhat12 kernel: [    0.374620] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374623] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374627] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374630] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.374632] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374634] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374636] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374638] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374640] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 13:24:13 cfhat12 kernel: [    0.374739] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374773] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 13:24:13 cfhat12 kernel: [    0.374777] pci 0000:06:00.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.374817] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374824] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 13:24:13 cfhat12 kernel: [    0.374832] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 13:24:13 cfhat12 kernel: [    0.374839] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 13:24:13 cfhat12 kernel: [    0.374847] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 13:24:13 cfhat12 kernel: [    0.374899] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 13:24:13 cfhat12 kernel: [    0.374903] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374906] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.374911] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.375052] pci 0000:07:00.0: supports D1
Jan  3 13:24:13 cfhat12 kernel: [    0.375053] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 13:24:13 cfhat12 kernel: [    0.375059] pci 0000:07:00.0: PME# disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.375078] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 13:24:13 cfhat12 kernel: [    0.375082] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.375085] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.375090] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.375188] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 13:24:13 cfhat12 kernel: [    0.375199] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 13:24:13 cfhat12 kernel: [    0.375209] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 13:24:13 cfhat12 kernel: [    0.375219] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 13:24:13 cfhat12 kernel: [    0.375229] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 13:24:13 cfhat12 kernel: [    0.375240] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 13:24:13 cfhat12 kernel: [    0.375327] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 13:24:13 cfhat12 kernel: [    0.375332] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.375338] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.375344] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.375370] pci_bus 0000:00: on NUMA node 0
Jan  3 13:24:13 cfhat12 kernel: [    0.375373] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375595] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375633] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375677] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375758] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375794] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375830] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.375870] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 13:24:13 cfhat12 kernel: [    0.393540] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393609] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393676] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393742] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393808] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393875] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.393943] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.394009] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:24:13 cfhat12 kernel: [    0.394186] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 13:24:13 cfhat12 kernel: [    0.394190] vgaarb: loaded
Jan  3 13:24:13 cfhat12 kernel: [    0.394329] SCSI subsystem initialized
Jan  3 13:24:13 cfhat12 kernel: [    0.394415] libata version 3.00 loaded.
Jan  3 13:24:13 cfhat12 kernel: [    0.394532] usbcore: registered new interface driver usbfs
Jan  3 13:24:13 cfhat12 kernel: [    0.394561] usbcore: registered new interface driver hub
Jan  3 13:24:13 cfhat12 kernel: [    0.394595] usbcore: registered new device driver usb
Jan  3 13:24:13 cfhat12 kernel: [    0.460015] raid6: int64x1   2979 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.528005] raid6: int64x2   3416 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.596019] raid6: int64x4   2615 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.664029] raid6: int64x8   2466 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.732007] raid6: sse2x1    4588 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.800014] raid6: sse2x2    7255 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.868014] raid6: sse2x4    8886 MB/s
Jan  3 13:24:13 cfhat12 kernel: [    0.868016] raid6: using algorithm sse2x4 (8886 MB/s)
Jan  3 13:24:13 cfhat12 kernel: [    0.868141] Advanced Linux Sound Architecture Driver Version 1.0.23.
Jan  3 13:24:13 cfhat12 kernel: [    0.868142] PCI: Using ACPI for IRQ routing
Jan  3 13:24:13 cfhat12 kernel: [    0.868145] PCI: pci_cache_line_size set to 64 bytes
Jan  3 13:24:13 cfhat12 kernel: [    0.868156] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.868247] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 13:24:13 cfhat12 kernel: [    0.868250] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 13:24:13 cfhat12 kernel: [    0.868368] NetLabel: Initializing
Jan  3 13:24:13 cfhat12 kernel: [    0.868370] NetLabel:  domain hash size = 128
Jan  3 13:24:13 cfhat12 kernel: [    0.868371] NetLabel:  protocols = UNLABELED CIPSOv4
Jan  3 13:24:13 cfhat12 kernel: [    0.868380] NetLabel:  unlabeled traffic allowed by default
Jan  3 13:24:13 cfhat12 kernel: [    0.868465] Switching to clocksource tsc
Jan  3 13:24:13 cfhat12 kernel: [    0.870454] pnp: PnP ACPI init
Jan  3 13:24:13 cfhat12 kernel: [    0.870461] ACPI: bus type pnp registered
Jan  3 13:24:13 cfhat12 kernel: [    0.871093] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871119] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.871124] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.871936] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 13:24:13 cfhat12 kernel: [    0.872005] pnp: PnP ACPI: found 11 devices
Jan  3 13:24:13 cfhat12 kernel: [    0.872007] ACPI: ACPI bus type pnp unregistered
Jan  3 13:24:13 cfhat12 kernel: [    0.872014] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872016] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872019] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872022] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872024] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872026] system 00:02: [io  0x040b] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872028] system 00:02: [io  0x04d6] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872030] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872032] system 00:02: [io  0x0c14] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872034] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872036] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872038] system 00:02: [io  0x0c6f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872040] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872041] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872043] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872045] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872047] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872049] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872051] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872053] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872056] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872060] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872063] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872066] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872068] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872070] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872072] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872074] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.872077] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 13:24:13 cfhat12 kernel: [    0.878830] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 13:24:13 cfhat12 kernel: [    0.878833] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878835] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878838] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878842] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878844] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 13:24:13 cfhat12 kernel: [    0.878846] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878848] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878851] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878854] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 13:24:13 cfhat12 kernel: [    0.878855] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878858] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878860] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878864] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878865] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 13:24:13 cfhat12 kernel: [    0.878867] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878870] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878872] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878875] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 13:24:13 cfhat12 kernel: [    0.878878] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878881] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878885] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878890] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 13:24:13 cfhat12 kernel: [    0.878892] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878895] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878898] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878903] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 13:24:13 cfhat12 kernel: [    0.878906] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878914] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878919] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878929] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 13:24:13 cfhat12 kernel: [    0.878931] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878934] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.878937] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.878952] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:24:13 cfhat12 kernel: [    0.878955] pci 0000:00:07.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.878962] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    0.878964] pci 0000:00:09.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.878972] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    0.878974] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.878982] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    0.878985] pci 0000:00:15.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.878990] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    0.878993] pci 0000:00:15.1: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.879004] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    0.879009] pci 0000:07:00.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    0.879013] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 13:24:13 cfhat12 kernel: [    0.879015] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879016] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879018] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879019] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879021] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879023] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879025] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879027] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879028] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879030] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879032] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879033] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879035] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879037] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879038] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879040] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879042] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879043] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879045] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879047] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 13:24:13 cfhat12 kernel: [    0.879048] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879050] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879052] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879053] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879055] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879057] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879058] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879060] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879062] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879063] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879065] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879067] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 13:24:13 cfhat12 kernel: [    0.879068] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 13:24:13 cfhat12 kernel: [    0.879121] NET: Registered protocol family 2
Jan  3 13:24:13 cfhat12 kernel: [    0.879165] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.879635] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.880588] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.880827] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 13:24:13 cfhat12 kernel: [    0.880829] TCP reno registered
Jan  3 13:24:13 cfhat12 kernel: [    0.880832] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.880870] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    0.881003] NET: Registered protocol family 1
Jan  3 13:24:13 cfhat12 kernel: [    0.881122] RPC: Registered udp transport module.
Jan  3 13:24:13 cfhat12 kernel: [    0.881124] RPC: Registered tcp transport module.
Jan  3 13:24:13 cfhat12 kernel: [    0.881125] RPC: Registered tcp NFSv4.1 backchannel transport module.
Jan  3 13:24:13 cfhat12 kernel: [    0.881133] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 13:24:13 cfhat12 kernel: [    0.943605] pci 0000:01:05.0: Boot video device
Jan  3 13:24:13 cfhat12 kernel: [    0.943643] PCI: CLS 4 bytes, default 64
Jan  3 13:24:13 cfhat12 kernel: [    0.943687] Trying to unpack rootfs image as initramfs...
Jan  3 13:24:13 cfhat12 kernel: [    0.988801] Freeing initrd memory: 3248k freed
Jan  3 13:24:13 cfhat12 kernel: [    0.989426] PCI-DMA: Disabling AGP.
Jan  3 13:24:13 cfhat12 kernel: [    0.989585] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 13:24:13 cfhat12 kernel: [    0.989586] PCI-DMA: using GART IOMMU.
Jan  3 13:24:13 cfhat12 kernel: [    0.989589] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 13:24:13 cfhat12 kernel: [    0.993743] audit: initializing netlink socket (disabled)
Jan  3 13:24:13 cfhat12 kernel: [    0.993754] type=2000 audit(1294079041.988:1): initialized
Jan  3 13:24:13 cfhat12 kernel: [    0.993786] I-pipe: Domain Xenomai registered.
Jan  3 13:24:13 cfhat12 kernel: [    0.993854] Xenomai: hal/x86_64 started.
Jan  3 13:24:13 cfhat12 kernel: [    0.993864] Xenomai: scheduling class idle registered.
Jan  3 13:24:13 cfhat12 kernel: [    0.993865] Xenomai: scheduling class rt registered.
Jan  3 13:24:13 cfhat12 kernel: [    0.994969] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 13:24:13 cfhat12 kernel: [    1.191652] Xenomai: native skin init failed, code -19.
Jan  3 13:24:13 cfhat12 kernel: [    1.192041] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  3 13:24:13 cfhat12 kernel: [    1.192187] VFS: Disk quotas dquot_6.5.2
Jan  3 13:24:13 cfhat12 kernel: [    1.192208] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 13:24:13 cfhat12 kernel: [    1.192388] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, debug enabled
Jan  3 13:24:13 cfhat12 kernel: [    1.192651] SGI XFS Quota Management subsystem
Jan  3 13:24:13 cfhat12 kernel: [    1.192656] msgmni has been set to 14971
Jan  3 13:24:13 cfhat12 kernel: [    1.192686] SELinux:  Registering netfilter hooks
Jan  3 13:24:13 cfhat12 kernel: [    1.192942] alg: No test for stdrng (krng)
Jan  3 13:24:13 cfhat12 kernel: [    1.193012] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  3 13:24:13 cfhat12 kernel: [    1.193015] io scheduler noop registered
Jan  3 13:24:13 cfhat12 kernel: [    1.193016] io scheduler deadline registered
Jan  3 13:24:13 cfhat12 kernel: [    1.193029] io scheduler cfq registered (default)
Jan  3 13:24:13 cfhat12 kernel: [    1.193122] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.193142] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.193212] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.193228] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.193294] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.193310] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.193380] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.193409] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.193489] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.193519] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.193978] Non-volatile memory driver v1.3
Jan  3 13:24:13 cfhat12 kernel: [    1.193981] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  3 13:24:13 cfhat12 kernel: [    1.447836] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:24:13 cfhat12 kernel: [    1.448182] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:24:13 cfhat12 kernel: [    1.448278] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:24:13 cfhat12 kernel: [    1.448364] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 13:24:13 cfhat12 kernel: [    1.448476] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 13:24:13 cfhat12 kernel: [    1.448587] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 13:24:13 cfhat12 kernel: [    1.448618] Couldn't register serial port 0000:05:06.0: -28
Jan  3 13:24:13 cfhat12 kernel: [    1.448625] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:24:13 cfhat12 kernel: [    1.448627] Couldn't register serial port 0000:05:06.1: -28
Jan  3 13:24:13 cfhat12 kernel: [    1.449750] brd: module loaded
Jan  3 13:24:13 cfhat12 kernel: [    1.449910] ahci 0000:00:11.0: version 3.0
Jan  3 13:24:13 cfhat12 kernel: [    1.449916] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:24:13 cfhat12 kernel: [    1.449951] ahci 0000:00:11.0: irq 45 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    1.450014] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 13:24:13 cfhat12 kernel: [    1.450017] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 13:24:13 cfhat12 kernel: [    1.450184] scsi0 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.450253] scsi1 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.450301] scsi2 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.450347] scsi3 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.450439] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 45
Jan  3 13:24:13 cfhat12 kernel: [    1.450441] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 45
Jan  3 13:24:13 cfhat12 kernel: [    1.450444] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 45
Jan  3 13:24:13 cfhat12 kernel: [    1.450446] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 45
Jan  3 13:24:13 cfhat12 kernel: [    1.450472] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.463723] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 13:24:13 cfhat12 kernel: [    1.463726] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 13:24:13 cfhat12 kernel: [    1.463731] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.463846] scsi4 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.463920] scsi5 : ahci
Jan  3 13:24:13 cfhat12 kernel: [    1.463958] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 13:24:13 cfhat12 kernel: [    1.463961] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 13:24:13 cfhat12 kernel: [    1.464144] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.464207] scsi6 : pata_atiixp
Jan  3 13:24:13 cfhat12 kernel: [    1.464253] scsi7 : pata_atiixp
Jan  3 13:24:13 cfhat12 kernel: [    1.464986] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 13:24:13 cfhat12 kernel: [    1.464988] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 13:24:13 cfhat12 kernel: [    1.465062] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 13:24:13 cfhat12 kernel: [    1.465066] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.465092] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.465150] scsi8 : pata_jmicron
Jan  3 13:24:13 cfhat12 kernel: [    1.465211] scsi9 : pata_jmicron
Jan  3 13:24:13 cfhat12 kernel: [    1.465253] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 13:24:13 cfhat12 kernel: [    1.465255] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 13:24:13 cfhat12 kernel: [    1.465402] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Jan  3 13:24:13 cfhat12 kernel: [    1.465403] e100: Copyright(c) 1999-2006 Intel Corporation
Jan  3 13:24:13 cfhat12 kernel: [    1.465488] console [netcon0] enabled
Jan  3 13:24:13 cfhat12 kernel: [    1.465489] netconsole: network logging started
Jan  3 13:24:13 cfhat12 kernel: [    1.465499] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 13:24:13 cfhat12 kernel: [    1.465513] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.465525] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.465541] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 13:24:13 cfhat12 kernel: [    1.465563] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 13:24:13 cfhat12 kernel: [    1.465573] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 13:24:13 cfhat12 kernel: [    1.475707] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 13:24:13 cfhat12 kernel: [    1.475834] hub 1-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.475838] hub 1-0:1.0: 5 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.475874] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.475885] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.475890] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 13:24:13 cfhat12 kernel: [    1.475911] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 13:24:13 cfhat12 kernel: [    1.475921] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 13:24:13 cfhat12 kernel: [    1.487708] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 13:24:13 cfhat12 kernel: [    1.487828] hub 2-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.487831] hub 2-0:1.0: 5 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.487868] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.487878] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.487883] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 13:24:13 cfhat12 kernel: [    1.487904] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 13:24:13 cfhat12 kernel: [    1.487914] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 13:24:13 cfhat12 kernel: [    1.499705] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 13:24:13 cfhat12 kernel: [    1.499823] hub 3-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.499826] hub 3-0:1.0: 4 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.499880] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 13:24:13 cfhat12 kernel: [    1.499890] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    1.499901] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.499909] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 13:24:13 cfhat12 kernel: [    1.499932] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 13:24:13 cfhat12 kernel: [    1.559822] hub 4-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.559827] hub 4-0:1.0: 5 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.559862] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    1.559873] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.559878] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 13:24:13 cfhat12 kernel: [    1.559891] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 13:24:13 cfhat12 kernel: [    1.619824] hub 5-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.619829] hub 5-0:1.0: 5 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.619864] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    1.619875] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.619880] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 13:24:13 cfhat12 kernel: [    1.619893] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 13:24:13 cfhat12 kernel: [    1.639989] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 13:24:13 cfhat12 kernel: [    1.640002] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  3 13:24:13 cfhat12 kernel: [    1.656012] ata7.00: configured for UDMA/33
Jan  3 13:24:13 cfhat12 kernel: [    1.683862] hub 6-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.683867] hub 6-0:1.0: 2 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.683897] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    1.683907] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.683912] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 13:24:13 cfhat12 kernel: [    1.683925] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 13:24:13 cfhat12 kernel: [    1.743869] hub 7-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.743874] hub 7-0:1.0: 4 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.743928] uhci_hcd: USB Universal Host Controller Interface driver
Jan  3 13:24:13 cfhat12 kernel: [    1.743977] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    1.743988] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.743990] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 13:24:13 cfhat12 kernel: [    1.743996] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 13:24:13 cfhat12 kernel: [    1.744095] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 13:24:13 cfhat12 kernel: [    1.747459] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 13:24:13 cfhat12 kernel: [    1.747546] xHCI xhci_add_endpoint called for root hub
Jan  3 13:24:13 cfhat12 kernel: [    1.747548] xHCI xhci_check_bandwidth called for root hub
Jan  3 13:24:13 cfhat12 kernel: [    1.747581] hub 8-0:1.0: USB hub found
Jan  3 13:24:13 cfhat12 kernel: [    1.747584] hub 8-0:1.0: 4 ports detected
Jan  3 13:24:13 cfhat12 kernel: [    1.747681] usbcore: registered new interface driver usblp
Jan  3 13:24:13 cfhat12 kernel: [    1.747683] Initializing USB Mass Storage driver...
Jan  3 13:24:13 cfhat12 kernel: [    1.747722] usbcore: registered new interface driver usb-storage
Jan  3 13:24:13 cfhat12 kernel: [    1.747742] USB Mass Storage support registered.
Jan  3 13:24:13 cfhat12 kernel: [    1.747807] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 13:24:13 cfhat12 kernel: [    1.747808] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 13:24:13 cfhat12 kernel: [    1.747934] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 13:24:13 cfhat12 kernel: [    1.748030] mice: PS/2 mouse device common for all mice
Jan  3 13:24:13 cfhat12 kernel: [    1.748071] rtc_cmos 00:04: RTC can wake from S4
Jan  3 13:24:13 cfhat12 kernel: [    1.748113] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 13:24:13 cfhat12 kernel: [    1.748132] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 13:24:13 cfhat12 kernel: [    1.748156] md: linear personality registered for level -1
Jan  3 13:24:13 cfhat12 kernel: [    1.748158] md: raid0 personality registered for level 0
Jan  3 13:24:13 cfhat12 kernel: [    1.748159] md: raid1 personality registered for level 1
Jan  3 13:24:13 cfhat12 kernel: [    1.748161] md: raid10 personality registered for level 10
Jan  3 13:24:13 cfhat12 kernel: [    1.748162] md: raid6 personality registered for level 6
Jan  3 13:24:13 cfhat12 kernel: [    1.748164] md: raid5 personality registered for level 5
Jan  3 13:24:13 cfhat12 kernel: [    1.748165] md: raid4 personality registered for level 4
Jan  3 13:24:13 cfhat12 kernel: [    1.748251] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid
Jan  3 13:24:13 cfhat12 kernel: [    1.748259] cpuidle: using governor ladder
Jan  3 13:24:13 cfhat12 kernel: [    1.749147] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:24:13 cfhat12 kernel: [    1.749175] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    1.764260] ALSA device list:
Jan  3 13:24:13 cfhat12 kernel: [    1.764262]   #0: HDA ATI HDMI at 0xfd3fc000 irq 19
Jan  3 13:24:13 cfhat12 kernel: [    1.764290] Netfilter messages via NETLINK v0.30.
Jan  3 13:24:13 cfhat12 kernel: [    1.764300] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jan  3 13:24:13 cfhat12 kernel: [    1.764377] ctnetlink v0.93: registering with nfnetlink.
Jan  3 13:24:13 cfhat12 kernel: [    1.764660] ip_tables: (C) 2000-2006 Netfilter Core Team
Jan  3 13:24:13 cfhat12 kernel: [    1.764686] TCP bic registered
Jan  3 13:24:13 cfhat12 kernel: [    1.764687] TCP cubic registered
Jan  3 13:24:13 cfhat12 kernel: [    1.764689] NET: Registered protocol family 17
Jan  3 13:24:13 cfhat12 kernel: [    1.764804] registered taskstats version 1
Jan  3 13:24:13 cfhat12 kernel: [    1.775806] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    1.775810] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    1.787802] ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    1.791805] ata5: SATA link down (SStatus 0 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    1.802597] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 13:24:13 cfhat12 kernel: [    1.943838] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    1.945114] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 13:24:13 cfhat12 kernel: [    1.945116] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 13:24:13 cfhat12 kernel: [    1.946673] ata1.00: configured for UDMA/133
Jan  3 13:24:13 cfhat12 kernel: [    1.963820] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 13:24:13 cfhat12 kernel: [    1.963890] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 13:24:13 cfhat12 kernel: [    1.964064] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:24:13 cfhat12 kernel: [    1.964090] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 13:24:13 cfhat12 kernel: [    1.964092] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 13:24:13 cfhat12 kernel: [    1.964094] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  3 13:24:13 cfhat12 kernel: [    1.964107] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:24:13 cfhat12 kernel: [    1.964183]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Jan  3 13:24:13 cfhat12 kernel: [    1.999052] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 13:24:13 cfhat12 kernel: [    1.999854] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:24:13 cfhat12 kernel: [    2.002811] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 13:24:13 cfhat12 kernel: [    2.002813] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 13:24:13 cfhat12 kernel: [    2.005891] ata2.00: configured for UDMA/133
Jan  3 13:24:13 cfhat12 kernel: [    2.023905] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 13:24:13 cfhat12 kernel: [    2.024031] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:24:13 cfhat12 kernel: [    2.024088] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 13:24:13 cfhat12 kernel: [    2.024090] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 13:24:13 cfhat12 kernel: [    2.024096] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  3 13:24:13 cfhat12 kernel: [    2.024114] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:24:13 cfhat12 kernel: [    2.024238]  sdb:
Jan  3 13:24:13 cfhat12 kernel: [    2.024932] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 13:24:13 cfhat12 kernel: [    2.029030] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 13:24:13 cfhat12 kernel: [    2.029032] Uniform CD-ROM driver Revision: 3.20
Jan  3 13:24:13 cfhat12 kernel: [    2.029149] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  3 13:24:13 cfhat12 kernel: [    2.029214] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  3 13:24:13 cfhat12 kernel: [    2.032963]  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jan  3 13:24:13 cfhat12 kernel: [    2.062769] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 13:24:13 cfhat12 kernel: [    2.195344] Freeing unused kernel memory: 488k freed
Jan  3 13:24:13 cfhat12 kernel: [    2.204856] udev[808]: starting version 164
Jan  3 13:24:13 cfhat12 kernel: [    2.220872] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 13:24:13 cfhat12 kernel: [    2.220874] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 13:24:13 cfhat12 kernel: [    2.220907] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:24:13 cfhat12 kernel: [    2.220921] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    2.221070] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    2.221072] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    2.221075] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    2.221553] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 13:24:13 cfhat12 kernel: [    2.226621] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 13:24:13 cfhat12 kernel: [    2.226641] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:24:13 cfhat12 kernel: [    2.226683] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 13:24:13 cfhat12 kernel: [    2.226720] r8169 0000:04:00.0: irq 49 for MSI/MSI-X
Jan  3 13:24:13 cfhat12 kernel: [    2.226912] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000070000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 49
Jan  3 13:24:13 cfhat12 kernel: [    2.240401] usbcore: registered new interface driver hiddev
Jan  3 13:24:13 cfhat12 kernel: [    2.244034] input: USBPS2 as /class/input/input1
Jan  3 13:24:13 cfhat12 kernel: [    2.244044] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 13:24:13 cfhat12 kernel: [    2.251097] input: USBPS2 as /class/input/input2
Jan  3 13:24:13 cfhat12 kernel: [    2.251140] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 13:24:13 cfhat12 kernel: [    2.251151] usbcore: registered new interface driver usbhid
Jan  3 13:24:13 cfhat12 kernel: [    2.251152] usbhid: USB HID core driver
Jan  3 13:24:13 cfhat12 kernel: [    2.337045] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 13:24:13 cfhat12 kernel: [    2.337047] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 13:24:13 cfhat12 kernel: [    2.337059] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 13:24:13 cfhat12 kernel: [    2.509631] md: md1 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    2.510419] md: bind<sdb1>
Jan  3 13:24:13 cfhat12 kernel: [    2.510575] md: bind<sda1>
Jan  3 13:24:13 cfhat12 kernel: [    2.511270] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    2.511285] md1: detected capacity change from 0 to 254791680
Jan  3 13:24:13 cfhat12 kernel: [    2.511789]  md1: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    2.716410] md: md2 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    2.717334] md: bind<sdb2>
Jan  3 13:24:13 cfhat12 kernel: [    2.717485] md: bind<sda2>
Jan  3 13:24:13 cfhat12 kernel: [    2.718150] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    2.718166] md2: detected capacity change from 0 to 19998367744
Jan  3 13:24:13 cfhat12 kernel: [    2.718669]  md2: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    2.924622] md: md3 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    2.925557] md: bind<sdb3>
Jan  3 13:24:13 cfhat12 kernel: [    2.925715] md: bind<sda3>
Jan  3 13:24:13 cfhat12 kernel: [    2.926386] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    2.926400] md3: detected capacity change from 0 to 1998573568
Jan  3 13:24:13 cfhat12 kernel: [    2.926897]  md3: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    3.138191] md: md5 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    3.138997] md: bind<sdb5>
Jan  3 13:24:13 cfhat12 kernel: [    3.139168] md: bind<sda5>
Jan  3 13:24:13 cfhat12 kernel: [    3.139839] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    3.139852] md5: detected capacity change from 0 to 19997319168
Jan  3 13:24:13 cfhat12 kernel: [    3.140368]  md5: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    3.362312] md: md6 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    3.363198] md: bind<sdb6>
Jan  3 13:24:13 cfhat12 kernel: [    3.363399] md: bind<sda6>
Jan  3 13:24:13 cfhat12 kernel: [    3.364062] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    3.364077] md6: detected capacity change from 0 to 19997319168
Jan  3 13:24:13 cfhat12 kernel: [    3.364600]  md6: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    3.588537] md: md7 stopped.
Jan  3 13:24:13 cfhat12 kernel: [    3.589541] md: bind<sdb7>
Jan  3 13:24:13 cfhat12 kernel: [    3.589725] md: bind<sda7>
Jan  3 13:24:13 cfhat12 kernel: [    3.590395] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 13:24:13 cfhat12 kernel: [    3.590409] md7: detected capacity change from 0 to 97784881152
Jan  3 13:24:13 cfhat12 kernel: [    3.590908]  md7: unknown partition table
Jan  3 13:24:13 cfhat12 kernel: [    3.862747] XFS mounting filesystem md2
Jan  3 13:24:13 cfhat12 kernel: [    4.549631] Ending clean XFS mount for filesystem: md2
Jan  3 13:24:13 cfhat12 kernel: [    5.928582] udev[1091]: starting version 164
Jan  3 13:24:13 cfhat12 kernel: [    6.514504] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f]
Jan  3 13:24:13 cfhat12 kernel: [    6.514506] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 13:24:13 cfhat12 kernel: [    6.645373] input: Power Button as /class/input/input3
Jan  3 13:24:13 cfhat12 kernel: [    6.645406] ACPI: Power Button [PWRB]
Jan  3 13:24:13 cfhat12 kernel: [    6.645457] input: Power Button as /class/input/input4
Jan  3 13:24:13 cfhat12 kernel: [    6.645475] ACPI: Power Button [PWRF]
Jan  3 13:24:13 cfhat12 kernel: [    6.662120] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 13:24:13 cfhat12 kernel: [    6.666147] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 13:24:13 cfhat12 kernel: [    6.666148] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 13:24:13 cfhat12 kernel: [    6.666150] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 13:24:13 cfhat12 kernel: [    6.667198] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 13:24:13 cfhat12 kernel: [    6.691846] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    6.691849] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    6.691925] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 13:24:13 cfhat12 kernel: [    6.789130] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 13:24:13 cfhat12 kernel: [    6.789514] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 13:24:13 cfhat12 kernel: [    7.865862] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 13:24:13 cfhat12 kernel: [    8.356345] loop: module loaded
Jan  3 13:24:13 cfhat12 kernel: [    9.081312] EXT3-fs: barriers not enabled
Jan  3 13:24:13 cfhat12 kernel: [    9.090336] kjournald starting.  Commit interval 5 seconds
Jan  3 13:24:13 cfhat12 kernel: [    9.105058] EXT3-fs (md1): using internal journal
Jan  3 13:24:13 cfhat12 kernel: [    9.105062] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 13:24:13 cfhat12 kernel: [    9.178645] XFS mounting filesystem md7
Jan  3 13:24:13 cfhat12 kernel: [    9.480102] Ending clean XFS mount for filesystem: md7
Jan  3 13:24:13 cfhat12 kernel: [    9.570186] XFS mounting filesystem md5
Jan  3 13:24:13 cfhat12 kernel: [    9.902453] Ending clean XFS mount for filesystem: md5
Jan  3 13:24:13 cfhat12 kernel: [    9.927072] EXT3-fs: barriers not enabled
Jan  3 13:24:13 cfhat12 kernel: [    9.934923] kjournald starting.  Commit interval 5 seconds
Jan  3 13:24:13 cfhat12 kernel: [    9.949647] EXT3-fs (md6): using internal journal
Jan  3 13:24:13 cfhat12 kernel: [    9.949651] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 13:24:13 cfhat12 kernel: [   10.616368] r8169 0000:04:00.0: eth0: link up
Jan  3 13:24:13 cfhat12 kernel: [   10.616373] r8169 0000:04:00.0: eth0: link up
Jan  3 13:24:13 cfhat12 kernel: [   11.278474] fuse init (API version 7.14)
Jan  3 13:24:13 cfhat12 kernel: [   11.486705] NET: Registered protocol family 10
Jan  3 13:24:22 cfhat12 kernel: [   21.988964] eth0: no IPv6 routers present
Jan  3 13:28:01 cfhat12 kernel: [  239.810016] pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:28:01 cfhat12 kernel: [  240.271807] [drm] Initialized drm 1.1.0 20060810
Jan  3 13:28:01 cfhat12 kernel: [  240.334659] [drm] radeon kernel modesetting enabled.
Jan  3 13:28:01 cfhat12 kernel: [  240.334701] radeon 0000:01:05.0: setting latency timer to 64
Jan  3 13:28:01 cfhat12 kernel: [  240.335781] [drm] initializing kernel modesetting (RS880 0x1002:0x9715).
Jan  3 13:28:01 cfhat12 kernel: [  240.335926] [drm] register mmio base: 0xFD3E0000
Jan  3 13:28:01 cfhat12 kernel: [  240.335928] [drm] register mmio size: 65536
Jan  3 13:28:01 cfhat12 kernel: [  240.338055] ATOM BIOS: B43106_DVI
Jan  3 13:28:01 cfhat12 kernel: [  240.338067] [drm] Clocks initialized !
Jan  3 13:28:01 cfhat12 kernel: [  240.338079] radeon 0000:01:05.0: VRAM: 512M 0xC0000000 - 0xDFFFFFFF (512M used)
Jan  3 13:28:01 cfhat12 kernel: [  240.338081] radeon 0000:01:05.0: GTT: 512M 0xA0000000 - 0xBFFFFFFF
Jan  3 13:28:01 cfhat12 kernel: [  240.340120] [drm] Detected VRAM RAM=512M, BAR=256M
Jan  3 13:28:01 cfhat12 kernel: [  240.340123] [drm] RAM width 32bits DDR
Jan  3 13:28:01 cfhat12 kernel: [  240.340198] [TTM] Zone  kernel: Available graphics memory: 3832944 kiB.
Jan  3 13:28:01 cfhat12 kernel: [  240.340201] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
Jan  3 13:28:01 cfhat12 kernel: [  240.340202] [TTM] Initializing pool allocator.
Jan  3 13:28:01 cfhat12 kernel: [  240.340220] [drm] radeon: 512M of VRAM memory ready
Jan  3 13:28:01 cfhat12 kernel: [  240.340221] [drm] radeon: 512M of GTT memory ready.
Jan  3 13:28:01 cfhat12 kernel: [  240.340252] [drm] radeon: irq initialized.
Jan  3 13:28:01 cfhat12 kernel: [  240.340254] [drm] GART: num cpu pages 131072, num gpu pages 131072
Jan  3 13:28:01 cfhat12 kernel: [  240.340757] [drm] Loading RS780 Microcode
Jan  3 13:28:01 cfhat12 kernel: [  240.384232] r600_cp: Failed to load firmware "radeon/R600_rlc.bin"
Jan  3 13:28:01 cfhat12 kernel: [  240.384238] [drm:r600_startup] *ERROR* Failed to load firmware!
Jan  3 13:28:01 cfhat12 kernel: [  240.384240] radeon 0000:01:05.0: disabling GPU acceleration
Jan  3 13:28:01 cfhat12 kernel: [  240.385255] radeon 0000:01:05.0: ffff88020e46fe00 unpin not necessary
Jan  3 13:28:01 cfhat12 kernel: [  240.385257] radeon 0000:01:05.0: ffff88020e46fe00 unpin not necessary
Jan  3 13:28:01 cfhat12 kernel: [  240.385260] [drm] Enabling audio support
Jan  3 13:28:01 cfhat12 kernel: [  240.385279] [drm] Unknown TV standard; defaulting to NTSC
Jan  3 13:28:01 cfhat12 kernel: [  240.385347] [drm] Radeon Display Connectors
Jan  3 13:28:01 cfhat12 kernel: [  240.385348] [drm] Connector 0:
Jan  3 13:28:01 cfhat12 kernel: [  240.385349] [drm]   VGA
Jan  3 13:28:01 cfhat12 kernel: [  240.385351] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
Jan  3 13:28:01 cfhat12 kernel: [  240.385352] [drm]   Encoders:
Jan  3 13:28:01 cfhat12 kernel: [  240.385353] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Jan  3 13:28:01 cfhat12 kernel: [  240.385354] [drm] Connector 1:
Jan  3 13:28:01 cfhat12 kernel: [  240.385355] [drm]   DVI-D
Jan  3 13:28:01 cfhat12 kernel: [  240.385356] [drm]   HPD1
Jan  3 13:28:01 cfhat12 kernel: [  240.385358] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
Jan  3 13:28:01 cfhat12 kernel: [  240.385359] [drm]   Encoders:
Jan  3 13:28:01 cfhat12 kernel: [  240.385360] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
Jan  3 13:28:01 cfhat12 kernel: [  240.438909] [drm] radeon: power management initialized
Jan  3 13:28:01 cfhat12 kernel: [  240.497944] [drm] fb mappable at 0xD0040000
Jan  3 13:28:01 cfhat12 kernel: [  240.497946] [drm] vram apper at 0xD0000000
Jan  3 13:28:01 cfhat12 kernel: [  240.497947] [drm] size 7680000
Jan  3 13:28:01 cfhat12 kernel: [  240.497948] [drm] fb depth is 24
Jan  3 13:28:01 cfhat12 kernel: [  240.497949] [drm]    pitch is 6400
Jan  3 13:28:01 cfhat12 kernel: [  240.498168] Console: switching to colour frame buffer device 200x75
Jan  3 13:28:01 cfhat12 kernel: [  240.498173] fb0: radeondrmfb frame buffer device
Jan  3 13:28:01 cfhat12 kernel: [  240.498174] drm: registered panic notifier
Jan  3 13:28:01 cfhat12 kernel: [  240.498176] Slow work thread pool: Starting up
Jan  3 13:28:01 cfhat12 kernel: [  240.498217] Slow work thread pool: Ready
Jan  3 13:28:01 cfhat12 kernel: [  240.498223] [drm] Initialized radeon 2.5.0 20080528 for 0000:01:05.0 on minor 0
Jan  3 13:37:59 cfhat12 kernel: [  838.415164] md: md7 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415194] md: md6 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415224] md: md5 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415254] md: md3 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415284] md: md2 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415317] md: md1 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415405] md: md7 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415447] md: md6 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415474] md: md5 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415499] md: md3 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415523] md: md2 still in use.
Jan  3 13:37:59 cfhat12 kernel: [  838.415548] md: md1 still in use.
Jan  3 13:38:00 cfhat12 kernel: [  839.226504] fuse exit
Jan  3 13:38:01 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 13:38:48 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Linux version 2.6.32-5-amd64 (Debian 2.6.32-29) (ben@domain.hid) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Fri Dec 10 15:35:08 UTC 2010
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] KERNEL supported cpus:
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   Intel GenuineIntel
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   AMD AuthenticAMD
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   Centaur CentaurHauls
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   6 disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   7 disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] RAMDISK: 376ee000 - 37feff7b
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Scanning NUMA topology in Northbridge 24
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] No NUMA configuration found
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Faking a node at 0000000000000000-0000000210000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Bootmem setup node 0 0000000000000000-0000000210000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   NODE_DATA [000000000000b000 - 0000000000012fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   bootmap [0000000000013000 -  0000000000054fff] pages 42
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0210000000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #2 [0001000000 - 000168a414]    TEXT DATA BSS ==> [0001000000 - 000168a414]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #3 [00376ee000 - 0037feff7b]          RAMDISK ==> [00376ee000 - 0037feff7b]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #5 [000168b000 - 000168b0fe]              BRK ==> [000168b000 - 000168b0fe]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   #7 [000000a000 - 000000b000]          PGTABLE ==> [000000a000 - 000000b000]
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880001800000-ffff8800081fffff] on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA      0x00000000 -> 0x00001000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]     0: 0x00000000 -> 0x0000009f
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965455
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA zone: 102 pages reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA zone: 3841 pages, LIFO batch:0
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  3 13:38:48 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 24
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf0000 - 00000000cfdf1000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf1000 - 00000000cfe00000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfe00000 - 00000000cff00000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cff00000 - 00000000e0000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000fec00000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000fec00000 - 0000000100000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Booting paravirtualized kernel on bare hardware
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880008400000 s90328 r8192 d24360 u262144
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] pcpu-alloc: s90328 r8192 d24360 u262144 alloc=1*2097152
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935785
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Policy zone: Normal
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Initializing CPU#0
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Node 0: aperture @ 20000000 size 32 MB
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Aperture pointing to e820 RAM. Ignoring.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000024000000
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Memory: 7670416k/8650752k available (3078k kernel code, 788932k absent, 191404k reserved, 1892k data, 592k init)
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] NR_IRQS:4352 nr_irqs:472
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  3 13:38:48 cfhat12 kernel: [    0.000000] Detected 3414.669 MHz processor.
Jan  3 13:38:48 cfhat12 kernel: [    0.008004] Calibrating delay loop (skipped), value calculated using timer frequency.. 6829.32 BogoMIPS (lpj=13658656)
Jan  3 13:38:48 cfhat12 kernel: [    0.008017] Security Framework initialized
Jan  3 13:38:48 cfhat12 kernel: [    0.008020] SELinux:  Disabled at boot.
Jan  3 13:38:48 cfhat12 kernel: [    0.008372] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.012045] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.012955] Mount-cache hash table entries: 256
Jan  3 13:38:48 cfhat12 kernel: [    0.013042] Initializing cgroup subsys ns
Jan  3 13:38:48 cfhat12 kernel: [    0.013044] Initializing cgroup subsys cpuacct
Jan  3 13:38:48 cfhat12 kernel: [    0.013047] Initializing cgroup subsys devices
Jan  3 13:38:48 cfhat12 kernel: [    0.013048] Initializing cgroup subsys freezer
Jan  3 13:38:48 cfhat12 kernel: [    0.013049] Initializing cgroup subsys net_cls
Jan  3 13:38:48 cfhat12 kernel: [    0.013063] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.013065] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.013066] CPU 0/0x0 -> Node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.013068] tseg: 00cff00000
Jan  3 13:38:48 cfhat12 kernel: [    0.013070] CPU: Physical Processor ID: 0
Jan  3 13:38:48 cfhat12 kernel: [    0.013070] CPU: Processor Core ID: 0
Jan  3 13:38:48 cfhat12 kernel: [    0.013072] mce: CPU supports 6 MCE banks
Jan  3 13:38:48 cfhat12 kernel: [    0.013078] using C1E aware idle routine
Jan  3 13:38:48 cfhat12 kernel: [    0.013079] Performance Events: AMD PMU driver.
Jan  3 13:38:48 cfhat12 kernel: [    0.013082] ... version:                0
Jan  3 13:38:48 cfhat12 kernel: [    0.013083] ... bit width:              48
Jan  3 13:38:48 cfhat12 kernel: [    0.013084] ... generic registers:      4
Jan  3 13:38:48 cfhat12 kernel: [    0.013085] ... value mask:             0000ffffffffffff
Jan  3 13:38:48 cfhat12 kernel: [    0.013086] ... max period:             00007fffffffffff
Jan  3 13:38:48 cfhat12 kernel: [    0.013087] ... fixed-purpose events:   0
Jan  3 13:38:48 cfhat12 kernel: [    0.013088] ... event mask:             000000000000000f
Jan  3 13:38:48 cfhat12 kernel: [    0.013576] ACPI: Core revision 20090903
Jan  3 13:38:48 cfhat12 kernel: [    0.020063] Setting APIC routing to flat
Jan  3 13:38:48 cfhat12 kernel: [    0.020435] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  3 13:38:48 cfhat12 kernel: [    0.059899] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:38:48 cfhat12 kernel: [    0.060001] Booting processor 1 APIC 0x1 ip 0x6000
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] Initializing CPU#1
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU 1/0x1 -> Node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 1
Jan  3 13:38:48 cfhat12 kernel: [    0.144058] CPU1: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:38:48 cfhat12 kernel: [    0.144063] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Jan  3 13:38:48 cfhat12 kernel: [    0.148014] System has AMD C1E enabled
Jan  3 13:38:48 cfhat12 kernel: [    0.148022] Switch to broadcast mode on CPU1
Jan  3 13:38:48 cfhat12 kernel: [    0.148043] Booting processor 2 APIC 0x2 ip 0x6000
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] Initializing CPU#2
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU 2/0x2 -> Node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 2
Jan  3 13:38:48 cfhat12 kernel: [    0.236041] CPU2: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:38:48 cfhat12 kernel: [    0.236045] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Jan  3 13:38:48 cfhat12 kernel: [    0.240016] Switch to broadcast mode on CPU2
Jan  3 13:38:48 cfhat12 kernel: [    0.240044] Booting processor 3 APIC 0x3 ip 0x6000
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] Initializing CPU#3
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU 3/0x3 -> Node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 13:38:48 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 3
Jan  3 13:38:48 cfhat12 kernel: [    0.328036] CPU3: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 13:38:48 cfhat12 kernel: [    0.328042] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Jan  3 13:38:48 cfhat12 kernel: [    0.332029] Switch to broadcast mode on CPU3
Jan  3 13:38:48 cfhat12 kernel: [    0.332033] Brought up 4 CPUs
Jan  3 13:38:48 cfhat12 kernel: [    0.332035] Total of 4 processors activated (27321.19 BogoMIPS).
Jan  3 13:38:48 cfhat12 kernel: [    0.333723] CPU0 attaching sched-domain:
Jan  3 13:38:48 cfhat12 kernel: [    0.333724]  domain 0: span 0-3 level MC
Jan  3 13:38:48 cfhat12 kernel: [    0.333726]   groups: 0 1 2 3
Jan  3 13:38:48 cfhat12 kernel: [    0.333730] CPU1 attaching sched-domain:
Jan  3 13:38:48 cfhat12 kernel: [    0.333731]  domain 0: span 0-3 level MC
Jan  3 13:38:48 cfhat12 kernel: [    0.333732]   groups: 1 2 3 0
Jan  3 13:38:48 cfhat12 kernel: [    0.333735] CPU2 attaching sched-domain:
Jan  3 13:38:48 cfhat12 kernel: [    0.333736]  domain 0: span 0-3 level MC
Jan  3 13:38:48 cfhat12 kernel: [    0.333737]   groups: 2 3 0 1
Jan  3 13:38:48 cfhat12 kernel: [    0.333740] CPU3 attaching sched-domain:
Jan  3 13:38:48 cfhat12 kernel: [    0.333741]  domain 0: span 0-3 level MC
Jan  3 13:38:48 cfhat12 kernel: [    0.333742]   groups: 3 0 1 2
Jan  3 13:38:48 cfhat12 kernel: [    0.333807] Switch to broadcast mode on CPU0
Jan  3 13:38:48 cfhat12 kernel: [    0.333807] devtmpfs: initialized
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] regulator: core version 0.5
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] NET: Registered protocol family 16
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] node 0 link 0: io port [8000, ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] TOM: 00000000d0000000 aka 3328M
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] Fam 10h mmconf [e0000000, e00fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] node 0 link 0: mmio [a0000, bffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] node 0 link 0: mmio [d0000000, dfffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] TOM2: 0000000230000000 aka 8960M
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: [00,08] on node 0 link 0
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 0 io port: [0, ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 1 mmio: [a0000, bffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 2 mmio: [d0000000, dfffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 3 mmio: [e0900000, ffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 4 mmio: [e0100000, e08fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336116] bus: 00 index 5 mmio: [230000000, fcffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.336118] ACPI: bus type pci registered
Jan  3 13:38:48 cfhat12 kernel: [    0.336160] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
Jan  3 13:38:48 cfhat12 kernel: [    0.336162] PCI: MCFG area at e0000000 reserved in E820
Jan  3 13:38:48 cfhat12 kernel: [    0.340811] PCI: Using MMCONFIG at e0000000 - efffffff
Jan  3 13:38:48 cfhat12 kernel: [    0.340813] PCI: Using configuration type 1 for base access
Jan  3 13:38:48 cfhat12 kernel: [    0.341056] bio: create slab <bio-0> at 0
Jan  3 13:38:48 cfhat12 kernel: [    0.341056] ACPI: EC: Look up EC in DSDT
Jan  3 13:38:48 cfhat12 kernel: [    0.348128] ACPI: Interpreter enabled
Jan  3 13:38:48 cfhat12 kernel: [    0.348131] ACPI: (supports S0 S3 S4 S5)
Jan  3 13:38:48 cfhat12 kernel: [    0.348146] ACPI: Using IOAPIC for interrupt routing
Jan  3 13:38:48 cfhat12 kernel: [    0.351012] ACPI Warning: Incorrect checksum in table [TAMG] - 97, should be 96 (20090903/tbutils-314)
Jan  3 13:38:48 cfhat12 kernel: [    0.351080] ACPI: No dock devices found.
Jan  3 13:38:48 cfhat12 kernel: [    0.351162] ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  3 13:38:48 cfhat12 kernel: [    0.351192] pci 0000:00:00.0: reg 1c 64bit mmio: [0xe0000000-0xffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351257] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.351259] pci 0000:00:07.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.351284] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.351286] pci 0000:00:09.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.351310] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.351311] pci 0000:00:0a.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.351349] pci 0000:00:11.0: reg 10 io port: [0xff00-0xff07]
Jan  3 13:38:48 cfhat12 kernel: [    0.351353] pci 0000:00:11.0: reg 14 io port: [0xfe00-0xfe03]
Jan  3 13:38:48 cfhat12 kernel: [    0.351358] pci 0000:00:11.0: reg 18 io port: [0xfd00-0xfd07]
Jan  3 13:38:48 cfhat12 kernel: [    0.351362] pci 0000:00:11.0: reg 1c io port: [0xfc00-0xfc03]
Jan  3 13:38:48 cfhat12 kernel: [    0.351366] pci 0000:00:11.0: reg 20 io port: [0xfb00-0xfb0f]
Jan  3 13:38:48 cfhat12 kernel: [    0.351371] pci 0000:00:11.0: reg 24 32bit mmio: [0xfe02f000-0xfe02f3ff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351382] pci 0000:00:11.0: set SATA to AHCI mode
Jan  3 13:38:48 cfhat12 kernel: [    0.351420] pci 0000:00:12.0: reg 10 32bit mmio: [0xfe02e000-0xfe02efff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351469] pci 0000:00:12.2: reg 10 32bit mmio: [0xfe02d000-0xfe02d0ff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351503] pci 0000:00:12.2: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.351505] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:38:48 cfhat12 kernel: [    0.351507] pci 0000:00:12.2: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.351528] pci 0000:00:13.0: reg 10 32bit mmio: [0xfe02c000-0xfe02cfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351577] pci 0000:00:13.2: reg 10 32bit mmio: [0xfe02b000-0xfe02b0ff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351612] pci 0000:00:13.2: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.351613] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:38:48 cfhat12 kernel: [    0.351615] pci 0000:00:13.2: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.351669] pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
Jan  3 13:38:48 cfhat12 kernel: [    0.351674] pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
Jan  3 13:38:48 cfhat12 kernel: [    0.351678] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
Jan  3 13:38:48 cfhat12 kernel: [    0.351682] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
Jan  3 13:38:48 cfhat12 kernel: [    0.351686] pci 0000:00:14.1: reg 20 io port: [0xfa00-0xfa0f]
Jan  3 13:38:48 cfhat12 kernel: [    0.351767] pci 0000:00:14.5: reg 10 32bit mmio: [0xfe02a000-0xfe02afff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351830] pci 0000:00:15.0: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.351876] pci 0000:00:15.1: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.351902] pci 0000:00:16.0: reg 10 32bit mmio: [0xfe029000-0xfe029fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.351950] pci 0000:00:16.2: reg 10 32bit mmio: [0xfe028000-0xfe0280ff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352005] pci 0000:00:16.2: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.352006] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  3 13:38:48 cfhat12 kernel: [    0.352009] pci 0000:00:16.2: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.352088] pci 0000:01:05.0: reg 10 32bit mmio pref: [0xd0000000-0xdfffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352091] pci 0000:01:05.0: reg 14 io port: [0xce00-0xceff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352093] pci 0000:01:05.0: reg 18 32bit mmio: [0xfd3e0000-0xfd3effff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352098] pci 0000:01:05.0: reg 24 32bit mmio: [0xfd200000-0xfd2fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352106] pci 0000:01:05.0: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.352120] pci 0000:01:05.1: reg 10 32bit mmio: [0xfd3fc000-0xfd3fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352134] pci 0000:01:05.1: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.352163] pci 0000:00:01.0: bridge io port: [0xc000-0xcfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352165] pci 0000:00:01.0: bridge 32bit mmio: [0xfd200000-0xfd3fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352168] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352216] pci 0000:02:00.0: reg 10 32bit mmio: [0xfdfc0000-0xfdfdffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352224] pci 0000:02:00.0: reg 14 32bit mmio: [0xfdf00000-0xfdf7ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352232] pci 0000:02:00.0: reg 18 io port: [0xbf00-0xbf1f]
Jan  3 13:38:48 cfhat12 kernel: [    0.352240] pci 0000:02:00.0: reg 1c 32bit mmio: [0xfdffc000-0xfdffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352262] pci 0000:02:00.0: reg 30 32bit mmio pref: [0x000000-0x03ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.352303] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.352308] pci 0000:02:00.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.360087] pci 0000:00:07.0: bridge io port: [0xb000-0xbfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.360090] pci 0000:00:07.0: bridge 32bit mmio: [0xfdf00000-0xfdffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.360092] pci 0000:00:07.0: bridge 64bit mmio pref: [0xfde00000-0xfdefffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.360127] pci 0000:03:00.0: reg 10 64bit mmio: [0xfddfe000-0xfddfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.360167] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.360170] pci 0000:03:00.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.368071] pci 0000:00:09.0: bridge io port: [0xe000-0xefff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368073] pci 0000:00:09.0: bridge 32bit mmio: [0xfdd00000-0xfddfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368076] pci 0000:00:09.0: bridge 64bit mmio pref: [0xfdc00000-0xfdcfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368107] pci 0000:04:00.0: reg 10 io port: [0xde00-0xdeff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368120] pci 0000:04:00.0: reg 18 64bit mmio pref: [0xfd4ff000-0xfd4fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368129] pci 0000:04:00.0: reg 20 64bit mmio pref: [0xfd4f8000-0xfd4fbfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368134] pci 0000:04:00.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.368160] pci 0000:04:00.0: supports D1 D2
Jan  3 13:38:48 cfhat12 kernel: [    0.368161] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  3 13:38:48 cfhat12 kernel: [    0.368164] pci 0000:04:00.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.376067] pci 0000:00:0a.0: bridge io port: [0xd000-0xdfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376070] pci 0000:00:0a.0: bridge 32bit mmio: [0xfd900000-0xfd9fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376072] pci 0000:00:0a.0: bridge 64bit mmio pref: [0xfd400000-0xfd4fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376103] pci 0000:05:06.0: reg 10 io port: [0xaf00-0xaf07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376110] pci 0000:05:06.0: reg 14 io port: [0xae00-0xae07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376116] pci 0000:05:06.0: reg 18 io port: [0xad00-0xad07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376122] pci 0000:05:06.0: reg 1c io port: [0xac00-0xac07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376163] pci 0000:05:06.1: reg 10 io port: [0xab00-0xab07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376169] pci 0000:05:06.1: reg 14 io port: [0xaa00-0xaa07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376176] pci 0000:05:06.1: reg 18 io port: [0xa900-0xa907]
Jan  3 13:38:48 cfhat12 kernel: [    0.376182] pci 0000:05:06.1: reg 1c io port: [0xa800-0xa807]
Jan  3 13:38:48 cfhat12 kernel: [    0.376228] pci 0000:05:08.0: reg 10 io port: [0xa700-0xa707]
Jan  3 13:38:48 cfhat12 kernel: [    0.376291] pci 0000:00:14.4: transparent bridge
Jan  3 13:38:48 cfhat12 kernel: [    0.376293] pci 0000:00:14.4: bridge io port: [0xa000-0xafff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376296] pci 0000:00:14.4: bridge 32bit mmio: [0xfdb00000-0xfdbfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376299] pci 0000:00:14.4: bridge 32bit mmio pref: [0xfda00000-0xfdafffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376376] pci 0000:06:00.0: reg 24 32bit mmio: [0xfd8fe000-0xfd8fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376409] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 13:38:48 cfhat12 kernel: [    0.376413] pci 0000:06:00.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.376463] pci 0000:06:00.1: reg 10 io port: [0x9f00-0x9f07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376470] pci 0000:06:00.1: reg 14 io port: [0x9e00-0x9e03]
Jan  3 13:38:48 cfhat12 kernel: [    0.376477] pci 0000:06:00.1: reg 18 io port: [0x9d00-0x9d07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376484] pci 0000:06:00.1: reg 1c io port: [0x9c00-0x9c03]
Jan  3 13:38:48 cfhat12 kernel: [    0.376491] pci 0000:06:00.1: reg 20 io port: [0x9b00-0x9b0f]
Jan  3 13:38:48 cfhat12 kernel: [    0.376551] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  3 13:38:48 cfhat12 kernel: [    0.376613] pci 0000:00:15.0: bridge io port: [0x9000-0x9fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376615] pci 0000:00:15.0: bridge 32bit mmio: [0xfd800000-0xfd8fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376619] pci 0000:00:15.0: bridge 64bit mmio pref: [0xfd700000-0xfd7fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376743] pci 0000:07:00.0: supports D1
Jan  3 13:38:48 cfhat12 kernel: [    0.376744] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 13:38:48 cfhat12 kernel: [    0.376749] pci 0000:07:00.0: PME# disabled
Jan  3 13:38:48 cfhat12 kernel: [    0.376785] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  3 13:38:48 cfhat12 kernel: [    0.376852] pci 0000:00:15.1: bridge io port: [0x8000-0x8fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376854] pci 0000:00:15.1: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376858] pci 0000:00:15.1: bridge 64bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.376894] pci 0000:08:00.0: reg 10 io port: [0x8f00-0x8f07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376904] pci 0000:08:00.0: reg 14 io port: [0x8e00-0x8e07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376914] pci 0000:08:00.0: reg 18 io port: [0x8d00-0x8d07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376924] pci 0000:08:00.0: reg 1c io port: [0x8c00-0x8c07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376933] pci 0000:08:00.0: reg 20 io port: [0x8b00-0x8b07]
Jan  3 13:38:48 cfhat12 kernel: [    0.376943] pci 0000:08:00.0: reg 24 io port: [0x8a00-0x8a0f]
Jan  3 13:38:48 cfhat12 kernel: [    0.377036] pci 0000:07:00.0: bridge io port: [0x8000-0x8fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.377041] pci 0000:07:00.0: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.377047] pci 0000:07:00.0: bridge 32bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.377075] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377280] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377314] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377352] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377422] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377454] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377485] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.377520] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 13:38:48 cfhat12 kernel: [    0.391724] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.391787] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.391850] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.391910] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.391970] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.392053] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.392113] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.392174] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 13:38:48 cfhat12 kernel: [    0.392235] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 13:38:48 cfhat12 kernel: [    0.392239] vgaarb: loaded
Jan  3 13:38:48 cfhat12 kernel: [    0.392253] PCI: Using ACPI for IRQ routing
Jan  3 13:38:48 cfhat12 kernel: [    0.392253] pci 0000:00:00.0: BAR 3: address space collision on of device [0xe0000000-0xffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.392253] pci 0000:00:00.0: BAR 3: can't allocate resource
Jan  3 13:38:48 cfhat12 kernel: [    0.392253] Switching to clocksource tsc
Jan  3 13:38:48 cfhat12 kernel: [    0.392598] pnp: PnP ACPI init
Jan  3 13:38:48 cfhat12 kernel: [    0.392605] ACPI: bus type pnp registered
Jan  3 13:38:48 cfhat12 kernel: [    0.394121] pnp 00:0a: mem resource (0xd1000-0xd3fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394123] pnp 00:0a: mem resource (0xf0000-0xf7fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394126] pnp 00:0a: mem resource (0xf8000-0xfbfff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394128] pnp 00:0a: mem resource (0xfc000-0xfffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394130] pnp 00:0a: mem resource (0x0-0x9ffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394132] pnp 00:0a: mem resource (0x100000-0xcfdeffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 13:38:48 cfhat12 kernel: [    0.394194] pnp: PnP ACPI: found 11 devices
Jan  3 13:38:48 cfhat12 kernel: [    0.394195] ACPI: ACPI bus type pnp unregistered
Jan  3 13:38:48 cfhat12 kernel: [    0.394201] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394202] system 00:01: ioport range 0x220-0x225 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394204] system 00:01: ioport range 0x290-0x294 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394207] system 00:02: ioport range 0x4100-0x411f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394209] system 00:02: ioport range 0x228-0x22f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394210] system 00:02: ioport range 0x40b-0x40b has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394212] system 00:02: ioport range 0x4d6-0x4d6 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394213] system 00:02: ioport range 0xc00-0xc01 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394215] system 00:02: ioport range 0xc14-0xc14 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394216] system 00:02: ioport range 0xc50-0xc52 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394218] system 00:02: ioport range 0xc6c-0xc6d has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394220] system 00:02: ioport range 0xc6f-0xc6f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394221] system 00:02: ioport range 0xcd0-0xcd1 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394223] system 00:02: ioport range 0xcd2-0xcd3 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394224] system 00:02: ioport range 0xcd4-0xcdf has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394226] system 00:02: ioport range 0x4000-0x40fe has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394228] system 00:02: ioport range 0x4210-0x4217 has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394229] system 00:02: ioport range 0xb00-0xb0f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394231] system 00:02: ioport range 0xb10-0xb1f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394232] system 00:02: ioport range 0xb20-0xb3f has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394236] system 00:09: iomem range 0xe0000000-0xefffffff has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394240] system 00:0a: iomem range 0xcfdf0000-0xcfdfffff could not be reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394242] system 00:0a: iomem range 0xffff0000-0xffffffff has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394243] system 00:0a: iomem range 0xcfe00000-0xcfefffff has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394245] system 00:0a: iomem range 0xcff00000-0xcfffffff could not be reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394247] system 00:0a: iomem range 0xfec00000-0xfec00fff could not be reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394249] system 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.394250] system 00:0a: iomem range 0xfff80000-0xfffeffff has been reserved
Jan  3 13:38:48 cfhat12 kernel: [    0.398928] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
Jan  3 13:38:48 cfhat12 kernel: [    0.398930] pci 0000:00:01.0:   IO window: 0xc000-0xcfff
Jan  3 13:38:48 cfhat12 kernel: [    0.398932] pci 0000:00:01.0:   MEM window: 0xfd200000-0xfd3fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398934] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398938] pci 0000:00:07.0: PCI bridge, secondary bus 0000:02
Jan  3 13:38:48 cfhat12 kernel: [    0.398940] pci 0000:00:07.0:   IO window: 0xb000-0xbfff
Jan  3 13:38:48 cfhat12 kernel: [    0.398942] pci 0000:00:07.0:   MEM window: 0xfdf00000-0xfdffffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398943] pci 0000:00:07.0:   PREFETCH window: 0x000000fde00000-0x000000fdefffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398946] pci 0000:00:09.0: PCI bridge, secondary bus 0000:03
Jan  3 13:38:48 cfhat12 kernel: [    0.398947] pci 0000:00:09.0:   IO window: 0xe000-0xefff
Jan  3 13:38:48 cfhat12 kernel: [    0.398949] pci 0000:00:09.0:   MEM window: 0xfdd00000-0xfddfffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398951] pci 0000:00:09.0:   PREFETCH window: 0x000000fdc00000-0x000000fdcfffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398954] pci 0000:00:0a.0: PCI bridge, secondary bus 0000:04
Jan  3 13:38:48 cfhat12 kernel: [    0.398955] pci 0000:00:0a.0:   IO window: 0xd000-0xdfff
Jan  3 13:38:48 cfhat12 kernel: [    0.398957] pci 0000:00:0a.0:   MEM window: 0xfd900000-0xfd9fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398959] pci 0000:00:0a.0:   PREFETCH window: 0x000000fd400000-0x000000fd4fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398962] pci 0000:00:14.4: PCI bridge, secondary bus 0000:05
Jan  3 13:38:48 cfhat12 kernel: [    0.398964] pci 0000:00:14.4:   IO window: 0xa000-0xafff
Jan  3 13:38:48 cfhat12 kernel: [    0.398967] pci 0000:00:14.4:   MEM window: 0xfdb00000-0xfdbfffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398970] pci 0000:00:14.4:   PREFETCH window: 0xfda00000-0xfdafffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398975] pci 0000:00:15.0: PCI bridge, secondary bus 0000:06
Jan  3 13:38:48 cfhat12 kernel: [    0.398976] pci 0000:00:15.0:   IO window: 0x9000-0x9fff
Jan  3 13:38:48 cfhat12 kernel: [    0.398979] pci 0000:00:15.0:   MEM window: 0xfd800000-0xfd8fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398982] pci 0000:00:15.0:   PREFETCH window: 0x000000fd700000-0x000000fd7fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.398986] pci 0000:07:00.0: PCI bridge, secondary bus 0000:08
Jan  3 13:38:48 cfhat12 kernel: [    0.398989] pci 0000:07:00.0:   IO window: 0x8000-0x8fff
Jan  3 13:38:48 cfhat12 kernel: [    0.398996] pci 0000:07:00.0:   MEM window: 0xfd600000-0xfd6fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.399001] pci 0000:07:00.0:   PREFETCH window: 0xfd500000-0xfd5fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.399010] pci 0000:00:15.1: PCI bridge, secondary bus 0000:07
Jan  3 13:38:48 cfhat12 kernel: [    0.399012] pci 0000:00:15.1:   IO window: 0x8000-0x8fff
Jan  3 13:38:48 cfhat12 kernel: [    0.399015] pci 0000:00:15.1:   MEM window: 0xfd600000-0xfd6fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.399017] pci 0000:00:15.1:   PREFETCH window: 0x000000fd500000-0x000000fd5fffff
Jan  3 13:38:48 cfhat12 kernel: [    0.399027]   alloc irq_desc for 19 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399028]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399034] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:38:48 cfhat12 kernel: [    0.399036] pci 0000:00:07.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399039]   alloc irq_desc for 17 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399040]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399045] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.399046] pci 0000:00:09.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399049]   alloc irq_desc for 18 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399050]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.399055] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.399057] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399064] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.399067] pci 0000:00:15.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399071] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.399074] pci 0000:00:15.1: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399084] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.399089] pci 0000:07:00.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.399093] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399095] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399096] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399098] pci_bus 0000:01: resource 1 mem: [0xfd200000-0xfd3fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399099] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399100] pci_bus 0000:02: resource 0 io:  [0xb000-0xbfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399102] pci_bus 0000:02: resource 1 mem: [0xfdf00000-0xfdffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399103] pci_bus 0000:02: resource 2 pref mem [0xfde00000-0xfdefffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399105] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399106] pci_bus 0000:03: resource 1 mem: [0xfdd00000-0xfddfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399107] pci_bus 0000:03: resource 2 pref mem [0xfdc00000-0xfdcfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399109] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399110] pci_bus 0000:04: resource 1 mem: [0xfd900000-0xfd9fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399111] pci_bus 0000:04: resource 2 pref mem [0xfd400000-0xfd4fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399113] pci_bus 0000:05: resource 0 io:  [0xa000-0xafff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399114] pci_bus 0000:05: resource 1 mem: [0xfdb00000-0xfdbfffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399115] pci_bus 0000:05: resource 2 pref mem [0xfda00000-0xfdafffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399117] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399118] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399119] pci_bus 0000:06: resource 0 io:  [0x9000-0x9fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399121] pci_bus 0000:06: resource 1 mem: [0xfd800000-0xfd8fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399122] pci_bus 0000:06: resource 2 pref mem [0xfd700000-0xfd7fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399124] pci_bus 0000:07: resource 0 io:  [0x8000-0x8fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399125] pci_bus 0000:07: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399126] pci_bus 0000:07: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399128] pci_bus 0000:08: resource 0 io:  [0x8000-0x8fff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399129] pci_bus 0000:08: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399130] pci_bus 0000:08: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  3 13:38:48 cfhat12 kernel: [    0.399149] NET: Registered protocol family 2
Jan  3 13:38:48 cfhat12 kernel: [    0.399293] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.400111] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.402139] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.402413] TCP: Hash tables configured (established 524288 bind 65536)
Jan  3 13:38:48 cfhat12 kernel: [    0.402415] TCP reno registered
Jan  3 13:38:48 cfhat12 kernel: [    0.402495] NET: Registered protocol family 1
Jan  3 13:38:48 cfhat12 kernel: [    0.463542] pci 0000:01:05.0: Boot video device
Jan  3 13:38:48 cfhat12 kernel: [    0.463600] Unpacking initramfs...
Jan  3 13:38:48 cfhat12 kernel: [    0.588551] Freeing initrd memory: 9223k freed
Jan  3 13:38:48 cfhat12 kernel: [    0.591450] PCI-DMA: Disabling AGP.
Jan  3 13:38:48 cfhat12 kernel: [    0.591534] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 13:38:48 cfhat12 kernel: [    0.591535] PCI-DMA: using GART IOMMU.
Jan  3 13:38:48 cfhat12 kernel: [    0.591537] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 13:38:48 cfhat12 kernel: [    0.593313] audit: initializing netlink socket (disabled)
Jan  3 13:38:48 cfhat12 kernel: [    0.593326] type=2000 audit(1294079917.591:1): initialized
Jan  3 13:38:48 cfhat12 kernel: [    0.595522] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  3 13:38:48 cfhat12 kernel: [    0.596354] VFS: Disk quotas dquot_6.5.2
Jan  3 13:38:48 cfhat12 kernel: [    0.596384] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 13:38:48 cfhat12 kernel: [    0.596428] msgmni has been set to 14999
Jan  3 13:38:48 cfhat12 kernel: [    0.596592] alg: No test for stdrng (krng)
Jan  3 13:38:48 cfhat12 kernel: [    0.596622] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  3 13:38:48 cfhat12 kernel: [    0.596623] io scheduler noop registered
Jan  3 13:38:48 cfhat12 kernel: [    0.596624] io scheduler anticipatory registered
Jan  3 13:38:48 cfhat12 kernel: [    0.596625] io scheduler deadline registered
Jan  3 13:38:48 cfhat12 kernel: [    0.596644] io scheduler cfq registered (default)
Jan  3 13:38:48 cfhat12 kernel: [    0.596763]   alloc irq_desc for 24 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596764]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596770] pcieport 0000:00:07.0: irq 24 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.596774] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.596845]   alloc irq_desc for 25 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596846]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596849] pcieport 0000:00:09.0: irq 25 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.596852] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.596917]   alloc irq_desc for 26 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596918]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.596921] pcieport 0000:00:0a.0: irq 26 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.596924] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.597009]   alloc irq_desc for 27 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.597010]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.597015] pcieport 0000:00:15.0: irq 27 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.597020] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.597116]   alloc irq_desc for 28 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.597117]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.597122] pcieport 0000:00:15.1: irq 28 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.597127] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.597875] Linux agpgart interface v0.103
Jan  3 13:38:48 cfhat12 kernel: [    0.597901] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  3 13:38:48 cfhat12 kernel: [    0.597982] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:38:48 cfhat12 kernel: [    0.598175] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 13:38:48 cfhat12 kernel: [    0.598270]   alloc irq_desc for 20 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.598272]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.598279] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:38:48 cfhat12 kernel: [    0.598379] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 13:38:48 cfhat12 kernel: [    0.598464] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 13:38:48 cfhat12 kernel: [    0.598541] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 13:38:48 cfhat12 kernel: [    0.598553] Couldn't register serial port 0000:05:06.0: -28
Jan  3 13:38:48 cfhat12 kernel: [    0.598616] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 13:38:48 cfhat12 kernel: [    0.598618] Couldn't register serial port 0000:05:06.1: -28
Jan  3 13:38:48 cfhat12 kernel: [    0.598667] input: Macintosh mouse button emulation as /devices/virtual/input/input0
Jan  3 13:38:48 cfhat12 kernel: [    0.598695] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 13:38:48 cfhat12 kernel: [    0.598696] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 13:38:48 cfhat12 kernel: [    0.598806] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 13:38:48 cfhat12 kernel: [    0.598852] mice: PS/2 mouse device common for all mice
Jan  3 13:38:48 cfhat12 kernel: [    0.598878] rtc_cmos 00:04: RTC can wake from S4
Jan  3 13:38:48 cfhat12 kernel: [    0.598897] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 13:38:48 cfhat12 kernel: [    0.598917] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 13:38:48 cfhat12 kernel: [    0.598923] cpuidle: using governor ladder
Jan  3 13:38:48 cfhat12 kernel: [    0.598925] cpuidle: using governor menu
Jan  3 13:38:48 cfhat12 kernel: [    0.598928] No iBFT detected.
Jan  3 13:38:48 cfhat12 kernel: [    0.599108] TCP cubic registered
Jan  3 13:38:48 cfhat12 kernel: [    0.599168] NET: Registered protocol family 10
Jan  3 13:38:48 cfhat12 kernel: [    0.599437] lo: Disabled Privacy Extensions
Jan  3 13:38:48 cfhat12 kernel: [    0.599607] Mobile IPv6
Jan  3 13:38:48 cfhat12 kernel: [    0.599609] NET: Registered protocol family 17
Jan  3 13:38:48 cfhat12 kernel: [    0.599658] PM: Resume from disk failed.
Jan  3 13:38:48 cfhat12 kernel: [    0.599663] registered taskstats version 1
Jan  3 13:38:48 cfhat12 kernel: [    0.600089] rtc_cmos 00:04: setting system clock to 2011-01-03 18:38:38 UTC (1294079918)
Jan  3 13:38:48 cfhat12 kernel: [    0.600106] Initalizing network drop monitor service
Jan  3 13:38:48 cfhat12 kernel: [    0.600121] Freeing unused kernel memory: 592k freed
Jan  3 13:38:48 cfhat12 kernel: [    0.600220] Write protecting the kernel read-only data: 4232k
Jan  3 13:38:48 cfhat12 kernel: [    0.610188] udev[121]: starting version 164
Jan  3 13:38:48 cfhat12 kernel: [    0.621508] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
Jan  3 13:38:48 cfhat12 kernel: [    0.621510] e1000e: Copyright (c) 1999-2008 Intel Corporation.
Jan  3 13:38:48 cfhat12 kernel: [    0.637211] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:38:48 cfhat12 kernel: [    0.637238] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.637393]   alloc irq_desc for 29 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637395]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637400] e1000e 0000:02:00.0: irq 29 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.637401]   alloc irq_desc for 30 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637402]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637404] e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.637405]   alloc irq_desc for 31 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637406]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.637408] e1000e 0000:02:00.0: irq 31 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.644055] usbcore: registered new interface driver usbfs
Jan  3 13:38:48 cfhat12 kernel: [    0.644108] usbcore: registered new interface driver hub
Jan  3 13:38:48 cfhat12 kernel: [    0.644233] usbcore: registered new device driver usb
Jan  3 13:38:48 cfhat12 kernel: [    0.651457] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 13:38:48 cfhat12 kernel: [    0.651576] SCSI subsystem initialized
Jan  3 13:38:48 cfhat12 kernel: [    0.653734] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Jan  3 13:38:48 cfhat12 kernel: [    0.654801] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.654825] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.654840] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 13:38:48 cfhat12 kernel: [    0.654866] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 13:38:48 cfhat12 kernel: [    0.654888] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 13:38:48 cfhat12 kernel: [    0.659313] libata version 3.00 loaded.
Jan  3 13:38:48 cfhat12 kernel: [    0.659984] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 13:38:48 cfhat12 kernel: [    0.662194] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 13:38:48 cfhat12 kernel: [    0.662207] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.662241] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.662270]   alloc irq_desc for 32 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.662272]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.662281] r8169 0000:04:00.0: irq 32 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.662641] eth0: RTL8168d/8111d at 0xffffc90000c66000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 32
Jan  3 13:38:48 cfhat12 kernel: [    0.667581] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 13:38:48 cfhat12 kernel: [    0.667594] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 13:38:48 cfhat12 kernel: [    0.667596] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.667597] usb usb1: Product: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.667599] usb usb1: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.667600] usb usb1: SerialNumber: 0000:00:12.2
Jan  3 13:38:48 cfhat12 kernel: [    0.667646] usb usb1: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.667663] hub 1-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.667668] hub 1-0:1.0: 5 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.667714] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 13:38:48 cfhat12 kernel: [    0.667718] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.667739] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.667770] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.667787] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.667795] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 2
Jan  3 13:38:48 cfhat12 kernel: [    0.667816] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 13:38:48 cfhat12 kernel: [    0.667824] scsi0 : pata_jmicron
Jan  3 13:38:48 cfhat12 kernel: [    0.667863] r8169 0000:04:00.0: firmware: requesting rtl8168d-2.fw
Jan  3 13:38:48 cfhat12 kernel: [    0.667878] scsi1 : pata_jmicron
Jan  3 13:38:48 cfhat12 kernel: [    0.667898] ata1: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 13:38:48 cfhat12 kernel: [    0.667899] ata2: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 13:38:48 cfhat12 kernel: [    0.669169] eth0: unable to apply firmware patch
Jan  3 13:38:48 cfhat12 kernel: [    0.727528] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 13:38:48 cfhat12 kernel: [    0.727531] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.727532] usb usb2: Product: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.727533] usb usb2: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.727534] usb usb2: SerialNumber: 0000:00:12.0
Jan  3 13:38:48 cfhat12 kernel: [    0.727579] usb usb2: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.727595] hub 2-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.727601] hub 2-0:1.0: 5 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.727775] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.727841] scsi2 : pata_atiixp
Jan  3 13:38:48 cfhat12 kernel: [    0.727884] scsi3 : pata_atiixp
Jan  3 13:38:48 cfhat12 kernel: [    0.728572] ata3: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 13:38:48 cfhat12 kernel: [    0.728573] ata4: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 13:38:48 cfhat12 kernel: [    0.728657] ahci 0000:00:11.0: version 3.0
Jan  3 13:38:48 cfhat12 kernel: [    0.728661] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:38:48 cfhat12 kernel: [    0.728686]   alloc irq_desc for 33 on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.728687]   alloc kstat_irqs on node 0
Jan  3 13:38:48 cfhat12 kernel: [    0.728694] ahci 0000:00:11.0: irq 33 for MSI/MSI-X
Jan  3 13:38:48 cfhat12 kernel: [    0.728752] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 13:38:48 cfhat12 kernel: [    0.728755] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 13:38:48 cfhat12 kernel: [    0.728921] scsi4 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.728962] scsi5 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.728997] scsi6 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.729034] scsi7 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.729097] ata5: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 33
Jan  3 13:38:48 cfhat12 kernel: [    0.729100] ata6: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 33
Jan  3 13:38:48 cfhat12 kernel: [    0.729102] ata7: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 33
Jan  3 13:38:48 cfhat12 kernel: [    0.729104] ata8: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 33
Jan  3 13:38:48 cfhat12 kernel: [    0.729165] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.729176] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.729185] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
Jan  3 13:38:48 cfhat12 kernel: [    0.729206] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 13:38:48 cfhat12 kernel: [    0.729219] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 13:38:48 cfhat12 kernel: [    0.729237] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.739541] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 13:38:48 cfhat12 kernel: [    0.739553] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 13:38:48 cfhat12 kernel: [    0.739555] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.739556] usb usb3: Product: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.739557] usb usb3: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.739558] usb usb3: SerialNumber: 0000:00:13.2
Jan  3 13:38:48 cfhat12 kernel: [    0.739603] usb usb3: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.739618] hub 3-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.739622] hub 3-0:1.0: 5 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.739688] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.739699] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.739705] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 4
Jan  3 13:38:48 cfhat12 kernel: [    0.739717] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 13:38:48 cfhat12 kernel: [    0.743712] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 13:38:48 cfhat12 kernel: [    0.743715] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 13:38:48 cfhat12 kernel: [    0.743719] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.743823] scsi8 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.743872] scsi9 : ahci
Jan  3 13:38:48 cfhat12 kernel: [    0.743898] ata9: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 13:38:48 cfhat12 kernel: [    0.743900] ata10: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 13:38:48 cfhat12 kernel: [    0.753597] 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 13:38:48 cfhat12 kernel: [    0.753598] 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 13:38:48 cfhat12 kernel: [    0.753609] 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 13:38:48 cfhat12 kernel: [    0.753628] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.753653] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    0.753655] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.753663] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 5
Jan  3 13:38:48 cfhat12 kernel: [    0.753760] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 13:38:48 cfhat12 kernel: [    0.757136] usb usb5: config 1 interface 0 altsetting 0 endpoint 0x81 has no SuperSpeed companion descriptor
Jan  3 13:38:48 cfhat12 kernel: [    0.757141] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003
Jan  3 13:38:48 cfhat12 kernel: [    0.757142] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.757143] usb usb5: Product: xHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.757144] usb usb5: Manufacturer: Linux 2.6.32-5-amd64 xhci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.757146] usb usb5: SerialNumber: 0000:03:00.0
Jan  3 13:38:48 cfhat12 kernel: [    0.757187] usb usb5: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.757190] xHCI xhci_add_endpoint called for root hub
Jan  3 13:38:48 cfhat12 kernel: [    0.757191] xHCI xhci_check_bandwidth called for root hub
Jan  3 13:38:48 cfhat12 kernel: [    0.757206] hub 5-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.757210] hub 5-0:1.0: 4 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.799665] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 13:38:48 cfhat12 kernel: [    0.799667] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.799668] usb usb4: Product: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.799669] usb usb4: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.799670] usb usb4: SerialNumber: 0000:00:13.0
Jan  3 13:38:48 cfhat12 kernel: [    0.799712] usb usb4: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.799726] hub 4-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.799732] hub 4-0:1.0: 5 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.799806] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    0.799817] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.799823] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 6
Jan  3 13:38:48 cfhat12 kernel: [    0.799844] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 13:38:48 cfhat12 kernel: [    0.799854] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 13:38:48 cfhat12 kernel: [    0.811553] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 13:38:48 cfhat12 kernel: [    0.811565] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 13:38:48 cfhat12 kernel: [    0.811567] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.811568] usb usb6: Product: EHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.811569] usb usb6: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.811570] usb usb6: SerialNumber: 0000:00:16.2
Jan  3 13:38:48 cfhat12 kernel: [    0.811609] usb usb6: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.811624] hub 6-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.811628] hub 6-0:1.0: 4 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.811692] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.811702] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.811708] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
Jan  3 13:38:48 cfhat12 kernel: [    0.811720] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 13:38:48 cfhat12 kernel: [    0.871687] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 13:38:48 cfhat12 kernel: [    0.871688] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.871690] usb usb7: Product: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.871691] usb usb7: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.871692] usb usb7: SerialNumber: 0000:00:14.5
Jan  3 13:38:48 cfhat12 kernel: [    0.871735] usb usb7: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.871751] hub 7-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.871756] hub 7-0:1.0: 2 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.871814] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    0.871825] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.871831] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 8
Jan  3 13:38:48 cfhat12 kernel: [    0.871843] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 13:38:48 cfhat12 kernel: [    0.891829] ata3.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 13:38:48 cfhat12 kernel: [    0.891842] ata3.00: limited to UDMA/33 due to 40-wire cable
Jan  3 13:38:48 cfhat12 kernel: [    0.907839] ata3.00: configured for UDMA/33
Jan  3 13:38:48 cfhat12 kernel: [    0.931689] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 13:38:48 cfhat12 kernel: [    0.931691] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 13:38:48 cfhat12 kernel: [    0.931692] usb usb8: Product: OHCI Host Controller
Jan  3 13:38:48 cfhat12 kernel: [    0.931693] usb usb8: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 13:38:48 cfhat12 kernel: [    0.931694] usb usb8: SerialNumber: 0000:00:16.0
Jan  3 13:38:48 cfhat12 kernel: [    0.931735] usb usb8: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    0.931750] hub 8-0:1.0: USB hub found
Jan  3 13:38:48 cfhat12 kernel: [    0.931755] hub 8-0:1.0: 4 ports detected
Jan  3 13:38:48 cfhat12 kernel: [    0.991861] scsi 2:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 13:38:48 cfhat12 kernel: [    1.047614] ata8: SATA link down (SStatus 0 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.059641] ata7: SATA link down (SStatus 0 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.067640] ata10: SATA link down (SStatus 0 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.067642] ata9: SATA link down (SStatus 0 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.235638] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.237211] ata5.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 13:38:48 cfhat12 kernel: [    1.237213] ata5.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 13:38:48 cfhat12 kernel: [    1.238775] ata5.00: configured for UDMA/133
Jan  3 13:38:48 cfhat12 kernel: [    1.255702] scsi 4:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 13:38:48 cfhat12 kernel: [    1.267643] usb 4-1: new low speed USB device using ohci_hcd and address 2
Jan  3 13:38:48 cfhat12 kernel: [    1.283653] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 13:38:48 cfhat12 kernel: [    1.286487] ata6.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 13:38:48 cfhat12 kernel: [    1.286489] ata6.00: 312581808 sectors, multi 16: LBA48 
Jan  3 13:38:48 cfhat12 kernel: [    1.289532] ata6.00: configured for UDMA/133
Jan  3 13:38:48 cfhat12 kernel: [    1.303728] scsi 5:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 13:38:48 cfhat12 kernel: [    1.307815] sd 4:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:38:48 cfhat12 kernel: [    1.307847] sd 4:0:0:0: [sda] Write Protect is off
Jan  3 13:38:48 cfhat12 kernel: [    1.307849] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 13:38:48 cfhat12 kernel: [    1.307880] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:38:48 cfhat12 kernel: [    1.307931] sd 5:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 13:38:48 cfhat12 kernel: [    1.307962] sd 5:0:0:0: [sdb] Write Protect is off
Jan  3 13:38:48 cfhat12 kernel: [    1.307963] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 13:38:48 cfhat12 kernel: [    1.307992] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 13:38:48 cfhat12 kernel: [    1.308115]  sdb:
Jan  3 13:38:48 cfhat12 kernel: [    1.308267]  sda: sdb1 sdb2 sdb3 sdb4 < sdb5 sda1 sda2 sda3 sda4 < sdb6 sda5 sda6 sdb7 >
Jan  3 13:38:48 cfhat12 kernel: [    1.345505] sd 5:0:0:0: [sdb] Attached SCSI disk
Jan  3 13:38:48 cfhat12 kernel: [    1.353153]  sda7 >
Jan  3 13:38:48 cfhat12 kernel: [    1.353437] sd 4:0:0:0: [sda] Attached SCSI disk
Jan  3 13:38:48 cfhat12 kernel: [    1.358907] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 13:38:48 cfhat12 kernel: [    1.358909] Uniform CD-ROM driver Revision: 3.20
Jan  3 13:38:48 cfhat12 kernel: [    1.358961] sr 2:0:0:0: Attached scsi CD-ROM sr0
Jan  3 13:38:48 cfhat12 kernel: [    1.360973] sr 2:0:0:0: Attached scsi generic sg0 type 5
Jan  3 13:38:48 cfhat12 kernel: [    1.360996] sd 4:0:0:0: Attached scsi generic sg1 type 0
Jan  3 13:38:48 cfhat12 kernel: [    1.361015] sd 5:0:0:0: Attached scsi generic sg2 type 0
Jan  3 13:38:48 cfhat12 kernel: [    1.434668] usb 4-1: New USB device found, idVendor=0d3d, idProduct=0001
Jan  3 13:38:48 cfhat12 kernel: [    1.434670] usb 4-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
Jan  3 13:38:48 cfhat12 kernel: [    1.434672] usb 4-1: Product: USBPS2
Jan  3 13:38:48 cfhat12 kernel: [    1.434725] usb 4-1: configuration #1 chosen from 1 choice
Jan  3 13:38:48 cfhat12 kernel: [    1.448407] usbcore: registered new interface driver hiddev
Jan  3 13:38:48 cfhat12 kernel: [    1.452832] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb4/4-1/4-1:1.0/input/input2
Jan  3 13:38:48 cfhat12 kernel: [    1.452864] generic-usb 0003:0D3D:0001.0001: input,hidraw0: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 13:38:48 cfhat12 kernel: [    1.459887] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb4/4-1/4-1:1.1/input/input3
Jan  3 13:38:48 cfhat12 kernel: [    1.459927] generic-usb 0003:0D3D:0001.0002: input,hidraw1: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 13:38:48 cfhat12 kernel: [    1.459940] usbcore: registered new interface driver usbhid
Jan  3 13:38:48 cfhat12 kernel: [    1.459942] usbhid: v2.6:USB HID core driver
Jan  3 13:38:48 cfhat12 kernel: [    1.623654] md: raid1 personality registered for level 1
Jan  3 13:38:48 cfhat12 kernel: [    1.629402] md: md1 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    1.630406] md: bind<sdb1>
Jan  3 13:38:48 cfhat12 kernel: [    1.630598] md: bind<sda1>
Jan  3 13:38:48 cfhat12 kernel: [    1.631351] raid1: raid set md1 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    1.631367] md1: detected capacity change from 0 to 254791680
Jan  3 13:38:48 cfhat12 kernel: [    1.631875]  md1: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    1.835752] md: md2 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    1.836635] md: bind<sdb2>
Jan  3 13:38:48 cfhat12 kernel: [    1.836792] md: bind<sda2>
Jan  3 13:38:48 cfhat12 kernel: [    1.837534] raid1: raid set md2 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    1.837549] md2: detected capacity change from 0 to 19998367744
Jan  3 13:38:48 cfhat12 kernel: [    1.838072]  md2: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    2.049515] md: md3 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    2.050571] md: bind<sdb3>
Jan  3 13:38:48 cfhat12 kernel: [    2.050768] md: bind<sda3>
Jan  3 13:38:48 cfhat12 kernel: [    2.051548] raid1: raid set md3 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    2.051566] md3: detected capacity change from 0 to 1998573568
Jan  3 13:38:48 cfhat12 kernel: [    2.052077]  md3: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    2.255704] md: md5 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    2.256618] md: bind<sdb5>
Jan  3 13:38:48 cfhat12 kernel: [    2.256776] md: bind<sda5>
Jan  3 13:38:48 cfhat12 kernel: [    2.257530] raid1: raid set md5 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    2.257542] md5: detected capacity change from 0 to 19997319168
Jan  3 13:38:48 cfhat12 kernel: [    2.258046]  md5: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    2.474938] md: md6 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    2.475731] md: bind<sdb6>
Jan  3 13:38:48 cfhat12 kernel: [    2.475907] md: bind<sda6>
Jan  3 13:38:48 cfhat12 kernel: [    2.476648] raid1: raid set md6 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    2.476665] md6: detected capacity change from 0 to 19997319168
Jan  3 13:38:48 cfhat12 kernel: [    2.477155]  md6: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    2.709725] md: md7 stopped.
Jan  3 13:38:48 cfhat12 kernel: [    2.710556] md: bind<sdb7>
Jan  3 13:38:48 cfhat12 kernel: [    2.710812] md: bind<sda7>
Jan  3 13:38:48 cfhat12 kernel: [    2.711551] raid1: raid set md7 active with 2 out of 2 mirrors
Jan  3 13:38:48 cfhat12 kernel: [    2.711565] md7: detected capacity change from 0 to 97784881152
Jan  3 13:38:48 cfhat12 kernel: [    2.712076]  md7: unknown partition table
Jan  3 13:38:48 cfhat12 kernel: [    2.915854] PM: Starting manual resume from disk
Jan  3 13:38:48 cfhat12 kernel: [    2.915856] PM: Resume from partition 9:3
Jan  3 13:38:48 cfhat12 kernel: [    2.915857] PM: Checking hibernation image.
Jan  3 13:38:48 cfhat12 kernel: [    2.936058] PM: Error -22 checking image file
Jan  3 13:38:48 cfhat12 kernel: [    2.936060] PM: Resume from disk failed.
Jan  3 13:38:48 cfhat12 kernel: [    2.941050] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  3 13:38:48 cfhat12 kernel: [    2.941619] SGI XFS Quota Management subsystem
Jan  3 13:38:48 cfhat12 kernel: [    2.983327] XFS mounting filesystem md2
Jan  3 13:38:48 cfhat12 kernel: [    3.237546] Ending clean XFS mount for filesystem: md2
Jan  3 13:38:48 cfhat12 kernel: [    4.708814] udev[542]: starting version 164
Jan  3 13:38:48 cfhat12 kernel: [    5.170763] input: PC Speaker as /devices/platform/pcspkr/input/input4
Jan  3 13:38:48 cfhat12 kernel: [    5.177213] processor LNXCPU:00: registered as cooling_device0
Jan  3 13:38:48 cfhat12 kernel: [    5.177242] processor LNXCPU:01: registered as cooling_device1
Jan  3 13:38:48 cfhat12 kernel: [    5.177267] processor LNXCPU:02: registered as cooling_device2
Jan  3 13:38:48 cfhat12 kernel: [    5.177290] processor LNXCPU:03: registered as cooling_device3
Jan  3 13:38:48 cfhat12 kernel: [    5.194738] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan  3 13:38:48 cfhat12 kernel: [    5.196408] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 9602 ss_vid 0 ss_did 0
Jan  3 13:38:48 cfhat12 kernel: [    5.196411] shpchp 0000:00:01.0: Cannot reserve MMIO region
Jan  3 13:38:48 cfhat12 kernel: [    5.196510] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jan  3 13:38:48 cfhat12 kernel: [    5.202579] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
Jan  3 13:38:48 cfhat12 kernel: [    5.202583] ACPI: Power Button [PWRB]
Jan  3 13:38:48 cfhat12 kernel: [    5.202625] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
Jan  3 13:38:48 cfhat12 kernel: [    5.202626] ACPI: Power Button [PWRF]
Jan  3 13:38:48 cfhat12 kernel: [    5.221669] EDAC MC: Ver: 2.1.0 Dec 10 2010
Jan  3 13:38:48 cfhat12 kernel: [    5.223282] EDAC amd64_edac:  Ver: 3.2.0 Dec 10 2010
Jan  3 13:38:48 cfhat12 kernel: [    5.223342] EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:18.3).
Jan  3 13:38:48 cfhat12 kernel: [    5.223349] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
Jan  3 13:38:48 cfhat12 kernel: [    5.223349]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
Jan  3 13:38:48 cfhat12 kernel: [    5.223350]  (Note that use of the override may cause unknown side effects.)
Jan  3 13:38:48 cfhat12 kernel: [    5.223363] amd64_edac: probe of 0000:00:18.2 failed with error -22
Jan  3 13:38:48 cfhat12 kernel: [    5.384201] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 13:38:48 cfhat12 kernel: [    5.388226] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 13:38:48 cfhat12 kernel: [    5.388228] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 13:38:48 cfhat12 kernel: [    5.388229] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 13:38:48 cfhat12 kernel: [    5.389281] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 13:38:48 cfhat12 kernel: [    5.466621] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    5.466624] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    5.466703] parport0: PC-style at 0x8f00 (0x8e00), irq 17 [PCSPP,TRISTATE]
Jan  3 13:38:48 cfhat12 kernel: [    5.564088] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 13:38:48 cfhat12 kernel: [    5.564188] parport1: PC-style at 0x8d00 (0x8c00), irq 17 [PCSPP,TRISTATE]
Jan  3 13:38:48 cfhat12 kernel: [    5.659545] ACPI: I/O resource piix4_smbus [0xb00-0xb07] conflicts with ACPI region SOR1 [0xb00-0xb0f]
Jan  3 13:38:48 cfhat12 kernel: [    5.659576] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 13:38:48 cfhat12 kernel: [    5.679208] [drm] Initialized drm 1.1.0 20060810
Jan  3 13:38:48 cfhat12 kernel: [    5.797401] [drm] radeon kernel modesetting enabled.
Jan  3 13:38:48 cfhat12 kernel: [    5.797482] radeon 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 13:38:48 cfhat12 kernel: [    5.797486] radeon 0000:01:05.0: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    5.798636] [drm] radeon: Initializing kernel modesetting.
Jan  3 13:38:48 cfhat12 kernel: [    5.798796] [drm] register mmio base: 0xFD3E0000
Jan  3 13:38:48 cfhat12 kernel: [    5.798797] [drm] register mmio size: 65536
Jan  3 13:38:48 cfhat12 kernel: [    5.800765] ATOM BIOS: B43106_DVI
Jan  3 13:38:48 cfhat12 kernel: [    5.800775] [drm] Clocks initialized !
Jan  3 13:38:48 cfhat12 kernel: [    5.802845] [drm] Detected VRAM RAM=256M, BAR=256M
Jan  3 13:38:48 cfhat12 kernel: [    5.802848] [drm] RAM width 32bits DDR
Jan  3 13:38:48 cfhat12 kernel: [    5.802937] [TTM] Zone  kernel: Available graphics memory: 3840116 kiB.
Jan  3 13:38:48 cfhat12 kernel: [    5.802938] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
Jan  3 13:38:48 cfhat12 kernel: [    5.802953] [drm] radeon: 256M of VRAM memory ready
Jan  3 13:38:48 cfhat12 kernel: [    5.802954] [drm] radeon: 512M of GTT memory ready.
Jan  3 13:38:48 cfhat12 kernel: [    5.802978] [drm] radeon: irq initialized.
Jan  3 13:38:48 cfhat12 kernel: [    5.802980] [drm] GART: num cpu pages 131072, num gpu pages 131072
Jan  3 13:38:48 cfhat12 kernel: [    5.803327] [drm] Loading RS780 Microcode
Jan  3 13:38:48 cfhat12 kernel: [    5.803329] platform radeon_cp.0: firmware: requesting radeon/RS780_pfp.bin
Jan  3 13:38:48 cfhat12 kernel: [    5.848776] platform radeon_cp.0: firmware: requesting radeon/RS780_me.bin
Jan  3 13:38:48 cfhat12 kernel: [    5.865853] platform radeon_cp.0: firmware: requesting radeon/R600_rlc.bin
Jan  3 13:38:48 cfhat12 kernel: [    5.981647] r600_cp: Failed to load firmware "radeon/R600_rlc.bin"
Jan  3 13:38:48 cfhat12 kernel: [    5.981683] [drm:r600_startup] *ERROR* Failed to load firmware!
Jan  3 13:38:48 cfhat12 kernel: [    5.981709] radeon 0000:01:05.0: disabling GPU acceleration
Jan  3 13:38:48 cfhat12 kernel: [    5.981743] radeon 0000:01:05.0: ffff88020bfa3600 unpin not necessary
Jan  3 13:38:48 cfhat12 kernel: [    5.981745] radeon 0000:01:05.0: ffff88020bfa3600 unpin not necessary
Jan  3 13:38:48 cfhat12 kernel: [    5.981754] [drm] Enabling audio support
Jan  3 13:38:48 cfhat12 kernel: [    5.981833] [drm] Radeon Display Connectors
Jan  3 13:38:48 cfhat12 kernel: [    5.981834] [drm] Connector 0:
Jan  3 13:38:48 cfhat12 kernel: [    5.981835] [drm]   VGA
Jan  3 13:38:48 cfhat12 kernel: [    5.981837] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
Jan  3 13:38:48 cfhat12 kernel: [    5.981838] [drm]   Encoders:
Jan  3 13:38:48 cfhat12 kernel: [    5.981838] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Jan  3 13:38:48 cfhat12 kernel: [    5.981840] [drm] Connector 1:
Jan  3 13:38:48 cfhat12 kernel: [    5.981840] [drm]   DVI-D
Jan  3 13:38:48 cfhat12 kernel: [    5.981841] [drm]   HPD1
Jan  3 13:38:48 cfhat12 kernel: [    5.981842] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
Jan  3 13:38:48 cfhat12 kernel: [    5.981843] [drm]   Encoders:
Jan  3 13:38:48 cfhat12 kernel: [    5.981844] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
Jan  3 13:38:48 cfhat12 kernel: [    6.089200] [drm] fb mappable at 0xD0040000
Jan  3 13:38:48 cfhat12 kernel: [    6.089202] [drm] vram apper at 0xD0000000
Jan  3 13:38:48 cfhat12 kernel: [    6.089202] [drm] size 7680000
Jan  3 13:38:48 cfhat12 kernel: [    6.089203] [drm] fb depth is 24
Jan  3 13:38:48 cfhat12 kernel: [    6.089204] [drm]    pitch is 6400
Jan  3 13:38:48 cfhat12 kernel: [    6.104533] Console: switching to colour frame buffer device 200x75
Jan  3 13:38:48 cfhat12 kernel: [    6.108923] fb0: radeondrmfb frame buffer device
Jan  3 13:38:48 cfhat12 kernel: [    6.108924] registered panic notifier
Jan  3 13:38:48 cfhat12 kernel: [    6.108927] [drm] Initialized radeon 2.0.0 20080528 for 0000:01:05.0 on minor 0
Jan  3 13:38:48 cfhat12 kernel: [    6.303094] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  3 13:38:48 cfhat12 kernel: [    6.303137] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  3 13:38:48 cfhat12 kernel: [    7.622598] Adding 1951668k swap on /dev/md3.  Priority:-1 extents:1 across:1951668k 
Jan  3 13:38:48 cfhat12 kernel: [    7.893211] loop: module loaded
Jan  3 13:38:48 cfhat12 kernel: [    8.528602] kjournald starting.  Commit interval 5 seconds
Jan  3 13:38:48 cfhat12 kernel: [    8.534129] EXT3 FS on md1, internal journal
Jan  3 13:38:48 cfhat12 kernel: [    8.534132] EXT3-fs: mounted filesystem with ordered data mode.
Jan  3 13:38:48 cfhat12 kernel: [    8.628146] XFS mounting filesystem md7
Jan  3 13:38:48 cfhat12 kernel: [    8.779097] Ending clean XFS mount for filesystem: md7
Jan  3 13:38:48 cfhat12 kernel: [    8.858196] XFS mounting filesystem md5
Jan  3 13:38:48 cfhat12 kernel: [    9.012563] Ending clean XFS mount for filesystem: md5
Jan  3 13:38:48 cfhat12 kernel: [    9.055039] kjournald starting.  Commit interval 5 seconds
Jan  3 13:38:48 cfhat12 kernel: [    9.069894] EXT3 FS on md6, internal journal
Jan  3 13:38:48 cfhat12 kernel: [    9.069897] EXT3-fs: mounted filesystem with ordered data mode.
Jan  3 13:38:48 cfhat12 kernel: [    9.672912] r8169: eth0: link up
Jan  3 13:38:48 cfhat12 kernel: [    9.672918] r8169: eth0: link up
Jan  3 13:38:48 cfhat12 kernel: [   10.216939] fuse init (API version 7.13)
Jan  3 13:38:50 cfhat12 kernel: [   13.006081] ADDRCONF(NETDEV_UP): eth1: link is not ready
Jan  3 13:38:51 cfhat12 kernel: [   13.219165] Bluetooth: Core ver 2.15
Jan  3 13:38:51 cfhat12 kernel: [   13.219232] NET: Registered protocol family 31
Jan  3 13:38:51 cfhat12 kernel: [   13.219234] Bluetooth: HCI device and connection manager initialized
Jan  3 13:38:51 cfhat12 kernel: [   13.219236] Bluetooth: HCI socket layer initialized
Jan  3 13:38:51 cfhat12 kernel: [   13.230575] Bluetooth: L2CAP ver 2.14
Jan  3 13:38:51 cfhat12 kernel: [   13.230576] Bluetooth: L2CAP socket layer initialized
Jan  3 13:38:51 cfhat12 kernel: [   13.249374] Bluetooth: RFCOMM TTY layer initialized
Jan  3 13:38:51 cfhat12 kernel: [   13.249376] Bluetooth: RFCOMM socket layer initialized
Jan  3 13:38:51 cfhat12 kernel: [   13.249378] Bluetooth: RFCOMM ver 1.11
Jan  3 13:38:51 cfhat12 kernel: [   13.250247] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jan  3 13:38:51 cfhat12 kernel: [   13.250248] Bluetooth: BNEP filters: protocol multicast
Jan  3 13:38:51 cfhat12 kernel: [   13.262166] Bridge firewalling registered
Jan  3 13:38:51 cfhat12 kernel: [   13.290002] Bluetooth: SCO (Voice Link) ver 0.6
Jan  3 13:38:51 cfhat12 kernel: [   13.290004] Bluetooth: SCO socket layer initialized
Jan  3 13:38:52 cfhat12 kernel: [   14.101029] powernow-k8: Found 1 AMD Phenom(tm) II X4 965 Processor processors (4 cpu cores) (version 2.20.00)
Jan  3 13:38:52 cfhat12 kernel: [   14.101062] powernow-k8:    0 : pstate 0 (3400 MHz)
Jan  3 13:38:52 cfhat12 kernel: [   14.101064] powernow-k8:    1 : pstate 1 (2700 MHz)
Jan  3 13:38:52 cfhat12 kernel: [   14.101065] powernow-k8:    2 : pstate 2 (2200 MHz)
Jan  3 13:38:52 cfhat12 kernel: [   14.101066] powernow-k8:    3 : pstate 3 (800 MHz)
Jan  3 13:38:57 cfhat12 kernel: [   19.840069] eth0: no IPv6 routers present
Jan  3 16:07:10 cfhat12 kernel: [ 8913.303575] JFS: nTxBlock = 8192, nTxLock = 65536
Jan  3 16:07:10 cfhat12 kernel: [ 8913.378058] NTFS driver 2.1.29 [Flags: R/W MODULE].
Jan  3 16:07:10 cfhat12 kernel: [ 8913.433595] QNX4 filesystem 0.2.3 registered.
Jan  3 16:07:11 cfhat12 kernel: [ 8913.541277] Btrfs loaded
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095800] md: md7 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095827] md: md6 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095850] md: md5 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095872] md: md3 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095894] md: md2 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095917] md: md1 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.095990] md: md7 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.096021] md: md6 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.096044] md: md5 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.096076] md: md3 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.096105] md: md2 still in use.
Jan  3 16:07:22 cfhat12 kernel: [ 8925.096132] md: md1 still in use.
Jan  3 16:07:23 cfhat12 kernel: [ 8926.216926] fuse exit
Jan  3 16:07:29 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 16:16:57 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Linux version 2.6.35.7-xeno3 (hatuser@domain.hid) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Mon Jan 3 13:04:23 EST 2011
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] NX (Execute Disable) protection: active
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   6 disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   7 disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] RAMDISK: 37cc4000 - 37ff0000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880002200000-ffff880008bfffff] on node 0
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]     0: 0x00000001 -> 0x0000009f
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965454
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA zone: 0 pages reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA zone: 3942 pages, LIFO batch:0
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 40
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] early_res array is doubled to 64 at [3000 - 37ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880001a00000 s101760 r8192 d21120 u262144
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] pcpu-alloc: s101760 r8192 d21120 u262144 alloc=1*2097152
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935886
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno3 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Node 0: aperture @ f90000000 size 32 MB
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] early_res array is doubled to 128 at [3800 - 47ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Subtract (58 early reservations)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #1 [0001000000 - 000188d234]   TEXT DATA BSS
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #2 [0037cc4000 - 0037ff0000]         RAMDISK
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #3 [000188e000 - 000188e0fe]             BRK
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #4 [00000f4420 - 0000100000]   BIOS reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #5 [00000f4410 - 00000f4420]    MP-table mpf
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #6 [000009f800 - 00000f1aa4]   BIOS reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #7 [00000f1c88 - 00000f4410]   BIOS reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #8 [00000f1aa4 - 00000f1c88]    MP-table mpc
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #10 [0000008000 - 000000a000]         PGTABLE
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #11 [000000a000 - 000000b000]         PGTABLE
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #12 [000188e100 - 000188f100]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #13 [000188d240 - 000188d7e0]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #14 [0002090000 - 0002091000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #15 [0002091000 - 0002092000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #16 [0002200000 - 0008c00000]        MEMMAP 0
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #17 [000188d800 - 000188d980]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #18 [000188f100 - 00018a7100]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #19 [00018a7100 - 00018bf100]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #20 [00018c0000 - 00018c1000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #21 [000188d980 - 000188d9c3]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #22 [000188da00 - 000188dc68]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #23 [000188dc80 - 000188dce8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #24 [000188dd00 - 000188dd68]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #25 [000188dd80 - 000188dde8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #26 [000188de00 - 000188de68]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #27 [000188de80 - 000188dee8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #28 [000188df00 - 000188df68]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #29 [000188df80 - 000188dfe8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #30 [00018bf100 - 00018bf168]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #31 [00018bf180 - 00018bf1e8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #32 [00018bf200 - 00018bf268]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #33 [00018bf280 - 00018bf2db]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #34 [00018bf300 - 00018bf35b]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #35 [0001a00000 - 0001a20000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #36 [0001a40000 - 0001a60000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #37 [0001a80000 - 0001aa0000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #38 [0001ac0000 - 0001ae0000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #39 [0001b00000 - 0001b20000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #40 [0001b40000 - 0001b60000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #41 [0001b80000 - 0001ba0000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #42 [0001bc0000 - 0001be0000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #43 [00018bf380 - 00018bf388]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #44 [00018bf3c0 - 00018bf3c8]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #45 [00018bf400 - 00018bf420]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #46 [00018bf440 - 00018bf480]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #47 [00018bf480 - 00018bf5a0]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #48 [00018bf5c0 - 00018bf608]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #49 [00018bf640 - 00018bf688]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #50 [00018c1000 - 00018c9000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #51 [0008c00000 - 0009400000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #52 [0001be0000 - 0001fe0000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #54 [0009400000 - 000d400000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #55 [00018c9000 - 00018e9000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #56 [00018e9000 - 0001929000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000]   #57 [000000b000 - 0000013000]         BOOTMEM
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Memory: 7596200k/8650752k available (4645k kernel code, 788936k absent, 265616k reserved, 2462k data, 488k init)
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] NR_IRQS:512
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] I-pipe 2.7-04: pipeline enabled.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  3 16:16:57 cfhat12 kernel: [    0.000000] Detected 3414.847 MHz processor.
Jan  3 16:16:57 cfhat12 kernel: [    0.008006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6829.68 BogoMIPS (lpj=13659372)
Jan  3 16:16:57 cfhat12 kernel: [    0.008009] pid_max: default: 32768 minimum: 301
Jan  3 16:16:57 cfhat12 kernel: [    0.008040] Security Framework initialized
Jan  3 16:16:57 cfhat12 kernel: [    0.008043] SELinux:  Initializing.
Jan  3 16:16:57 cfhat12 kernel: [    0.008050] SELinux:  Starting in permissive mode
Jan  3 16:16:57 cfhat12 kernel: [    0.008062] Mount-cache hash table entries: 256
Jan  3 16:16:57 cfhat12 kernel: [    0.008139] Initializing cgroup subsys ns
Jan  3 16:16:57 cfhat12 kernel: [    0.008141] Initializing cgroup subsys cpuacct
Jan  3 16:16:57 cfhat12 kernel: [    0.008144] Initializing cgroup subsys devices
Jan  3 16:16:57 cfhat12 kernel: [    0.008160] tseg: 00cff00000
Jan  3 16:16:57 cfhat12 kernel: [    0.008161] CPU: Physical Processor ID: 0
Jan  3 16:16:57 cfhat12 kernel: [    0.008162] CPU: Processor Core ID: 0
Jan  3 16:16:57 cfhat12 kernel: [    0.008164] mce: CPU supports 6 MCE banks
Jan  3 16:16:57 cfhat12 kernel: [    0.008169] using C1E aware idle routine
Jan  3 16:16:57 cfhat12 kernel: [    0.008170] Performance Events: AMD PMU driver.
Jan  3 16:16:57 cfhat12 kernel: [    0.008174] ... version:                0
Jan  3 16:16:57 cfhat12 kernel: [    0.008175] ... bit width:              48
Jan  3 16:16:57 cfhat12 kernel: [    0.008176] ... generic registers:      4
Jan  3 16:16:57 cfhat12 kernel: [    0.008177] ... value mask:             0000ffffffffffff
Jan  3 16:16:57 cfhat12 kernel: [    0.008178] ... max period:             00007fffffffffff
Jan  3 16:16:57 cfhat12 kernel: [    0.008179] ... fixed-purpose events:   0
Jan  3 16:16:57 cfhat12 kernel: [    0.008180] ... event mask:             000000000000000f
Jan  3 16:16:57 cfhat12 kernel: [    0.008230] ACPI: Core revision 20100428
Jan  3 16:16:57 cfhat12 kernel: [    0.016057] Setting APIC routing to flat
Jan  3 16:16:57 cfhat12 kernel: [    0.016445] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  3 16:16:57 cfhat12 kernel: [    0.020000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jan  3 16:16:57 cfhat12 kernel: [    0.020000] ...trying to set up timer (IRQ0) through the 8259A ...
Jan  3 16:16:57 cfhat12 kernel: [    0.020000] ..... (found apic 0 pin 2) ...
Jan  3 16:16:57 cfhat12 kernel: [    0.060768] ....... works.
Jan  3 16:16:57 cfhat12 kernel: [    0.060769] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 16:16:57 cfhat12 kernel: [    0.064000] Booting Node   0, Processors  #1
Jan  3 16:16:57 cfhat12 kernel: [    0.152005] System has AMD C1E enabled
Jan  3 16:16:57 cfhat12 kernel: [    0.152005] Switch to broadcast mode on CPU1
Jan  3 16:16:57 cfhat12 kernel: [    0.152053]  #2
Jan  3 16:16:57 cfhat12 kernel: [    0.244011] Switch to broadcast mode on CPU2
Jan  3 16:16:57 cfhat12 kernel: [    0.244096]  #3
Jan  3 16:16:57 cfhat12 kernel: [    0.336014] Brought up 4 CPUs
Jan  3 16:16:57 cfhat12 kernel: [    0.336016] Total of 4 processors activated (27292.38 BogoMIPS).
Jan  3 16:16:57 cfhat12 kernel: [    0.336012] Switch to broadcast mode on CPU3
Jan  3 16:16:57 cfhat12 kernel: [    0.337642] Switch to broadcast mode on CPU0
Jan  3 16:16:57 cfhat12 kernel: [    0.337779] devtmpfs: initialized
Jan  3 16:16:57 cfhat12 kernel: [    0.338033] xor: automatically using best checksumming function: generic_sse
Jan  3 16:16:57 cfhat12 kernel: [    0.356005]    generic_sse: 13684.000 MB/sec
Jan  3 16:16:57 cfhat12 kernel: [    0.356007] xor: using function: generic_sse (13684.000 MB/sec)
Jan  3 16:16:57 cfhat12 kernel: [    0.356040] NET: Registered protocol family 16
Jan  3 16:16:57 cfhat12 kernel: [    0.356332] node 0 link 0: io port [8000, ffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356334] TOM: 00000000d0000000 aka 3328M
Jan  3 16:16:57 cfhat12 kernel: [    0.356336] Fam 10h mmconf [e0000000, e00fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356337] node 0 link 0: mmio [a0000, bffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356339] node 0 link 0: mmio [d0000000, dfffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356342] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356344] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356346] TOM2: 0000000230000000 aka 8960M
Jan  3 16:16:57 cfhat12 kernel: [    0.356348] bus: [00, 08] on node 0 link 0
Jan  3 16:16:57 cfhat12 kernel: [    0.356350] bus: 00 index 0 [io  0x0000-0xffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356352] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356354] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356355] bus: 00 index 3 [mem 0xe0900000-0xffffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356357] bus: 00 index 4 [mem 0xe0100000-0xe08fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356358] bus: 00 index 5 [mem 0x230000000-0xfcffffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.356366] ACPI: bus type pci registered
Jan  3 16:16:57 cfhat12 kernel: [    0.356427] PCI: Using configuration type 1 for base access
Jan  3 16:16:57 cfhat12 kernel: [    0.356428] PCI: Using configuration type 1 for extended access
Jan  3 16:16:57 cfhat12 kernel: [    0.360210] bio: create slab <bio-0> at 0
Jan  3 16:16:57 cfhat12 kernel: [    0.360887] ACPI: EC: Look up EC in DSDT
Jan  3 16:16:57 cfhat12 kernel: [    0.367408] ACPI: Interpreter enabled
Jan  3 16:16:57 cfhat12 kernel: [    0.367410] ACPI: (supports S0 S5)
Jan  3 16:16:57 cfhat12 kernel: [    0.367420] ACPI: Using IOAPIC for interrupt routing
Jan  3 16:16:57 cfhat12 kernel: [    0.372669] ACPI Warning: Incorrect checksum in table [TAMG] - 0x8C, should be 0x8B (20100428/tbutils-314)
Jan  3 16:16:57 cfhat12 kernel: [    0.372743] ACPI: No dock devices found.
Jan  3 16:16:57 cfhat12 kernel: [    0.372746] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan  3 16:16:57 cfhat12 kernel: [    0.372836] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jan  3 16:16:57 cfhat12 kernel: [    0.373015] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
Jan  3 16:16:57 cfhat12 kernel: [    0.373018] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373020] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373021] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373023] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xfebfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373041] pci 0000:00:00.0: reg 1c: [mem 0xe0000000-0xffffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.373108] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.373111] pci 0000:00:07.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373138] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.373140] pci 0000:00:09.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373166] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.373168] pci 0000:00:0a.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373201] pci 0000:00:11.0: reg 10: [io  0xff00-0xff07]
Jan  3 16:16:57 cfhat12 kernel: [    0.373205] pci 0000:00:11.0: reg 14: [io  0xfe00-0xfe03]
Jan  3 16:16:57 cfhat12 kernel: [    0.373210] pci 0000:00:11.0: reg 18: [io  0xfd00-0xfd07]
Jan  3 16:16:57 cfhat12 kernel: [    0.373215] pci 0000:00:11.0: reg 1c: [io  0xfc00-0xfc03]
Jan  3 16:16:57 cfhat12 kernel: [    0.373219] pci 0000:00:11.0: reg 20: [io  0xfb00-0xfb0f]
Jan  3 16:16:57 cfhat12 kernel: [    0.373224] pci 0000:00:11.0: reg 24: [mem 0xfe02f000-0xfe02f3ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373237] pci 0000:00:11.0: set SATA to AHCI mode
Jan  3 16:16:57 cfhat12 kernel: [    0.373275] pci 0000:00:12.0: reg 10: [mem 0xfe02e000-0xfe02efff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373320] pci 0000:00:12.2: reg 10: [mem 0xfe02d000-0xfe02d0ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373356] pci 0000:00:12.2: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373357] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:16:57 cfhat12 kernel: [    0.373360] pci 0000:00:12.2: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373381] pci 0000:00:13.0: reg 10: [mem 0xfe02c000-0xfe02cfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373426] pci 0000:00:13.2: reg 10: [mem 0xfe02b000-0xfe02b0ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373461] pci 0000:00:13.2: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373463] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:16:57 cfhat12 kernel: [    0.373466] pci 0000:00:13.2: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373520] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
Jan  3 16:16:57 cfhat12 kernel: [    0.373524] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
Jan  3 16:16:57 cfhat12 kernel: [    0.373529] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
Jan  3 16:16:57 cfhat12 kernel: [    0.373534] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
Jan  3 16:16:57 cfhat12 kernel: [    0.373538] pci 0000:00:14.1: reg 20: [io  0xfa00-0xfa0f]
Jan  3 16:16:57 cfhat12 kernel: [    0.373618] pci 0000:00:14.5: reg 10: [mem 0xfe02a000-0xfe02afff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373684] pci 0000:00:15.0: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373732] pci 0000:00:15.1: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373757] pci 0000:00:16.0: reg 10: [mem 0xfe029000-0xfe029fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373802] pci 0000:00:16.2: reg 10: [mem 0xfe028000-0xfe0280ff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373837] pci 0000:00:16.2: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373839] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:16:57 cfhat12 kernel: [    0.373842] pci 0000:00:16.2: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.373927] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.373930] pci 0000:01:05.0: reg 14: [io  0xce00-0xceff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373933] pci 0000:01:05.0: reg 18: [mem 0xfd3e0000-0xfd3effff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373938] pci 0000:01:05.0: reg 24: [mem 0xfd200000-0xfd2fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373947] pci 0000:01:05.0: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.373959] pci 0000:01:05.1: reg 10: [mem 0xfd3fc000-0xfd3fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.373974] pci 0000:01:05.1: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.374001] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 16:16:57 cfhat12 kernel: [    0.374004] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374006] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374009] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374061] pci 0000:02:00.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374069] pci 0000:02:00.0: reg 14: [mem 0xfdf00000-0xfdf7ffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374078] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
Jan  3 16:16:57 cfhat12 kernel: [    0.374086] pci 0000:02:00.0: reg 1c: [mem 0xfdffc000-0xfdffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374108] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374150] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.374154] pci 0000:02:00.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.374177] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 16:16:57 cfhat12 kernel: [    0.374179] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374182] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374185] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374224] pci 0000:03:00.0: reg 10: [mem 0xfddfe000-0xfddfffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.374264] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.374267] pci 0000:03:00.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.374280] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 16:16:57 cfhat12 kernel: [    0.374283] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374285] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374288] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374325] pci 0000:04:00.0: reg 10: [io  0xde00-0xdeff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374338] pci 0000:04:00.0: reg 18: [mem 0xfd4ff000-0xfd4fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374348] pci 0000:04:00.0: reg 20: [mem 0xfd4f8000-0xfd4fbfff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374353] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374379] pci 0000:04:00.0: supports D1 D2
Jan  3 16:16:57 cfhat12 kernel: [    0.374381] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  3 16:16:57 cfhat12 kernel: [    0.374384] pci 0000:04:00.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.374400] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 16:16:57 cfhat12 kernel: [    0.374402] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374405] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374408] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374439] pci 0000:05:06.0: reg 10: [io  0xaf00-0xaf07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374445] pci 0000:05:06.0: reg 14: [io  0xae00-0xae07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374452] pci 0000:05:06.0: reg 18: [io  0xad00-0xad07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374458] pci 0000:05:06.0: reg 1c: [io  0xac00-0xac07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374498] pci 0000:05:06.1: reg 10: [io  0xab00-0xab07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374505] pci 0000:05:06.1: reg 14: [io  0xaa00-0xaa07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374511] pci 0000:05:06.1: reg 18: [io  0xa900-0xa907]
Jan  3 16:16:57 cfhat12 kernel: [    0.374518] pci 0000:05:06.1: reg 1c: [io  0xa800-0xa807]
Jan  3 16:16:57 cfhat12 kernel: [    0.374563] pci 0000:05:08.0: reg 10: [io  0xa700-0xa707]
Jan  3 16:16:57 cfhat12 kernel: [    0.374626] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374629] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374632] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374636] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.374638] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374640] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374642] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374644] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374646] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 16:16:57 cfhat12 kernel: [    0.374746] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374780] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 16:16:57 cfhat12 kernel: [    0.374785] pci 0000:06:00.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.374824] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374832] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 16:16:57 cfhat12 kernel: [    0.374839] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 16:16:57 cfhat12 kernel: [    0.374847] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 16:16:57 cfhat12 kernel: [    0.374855] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 16:16:57 cfhat12 kernel: [    0.374907] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 16:16:57 cfhat12 kernel: [    0.374911] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374914] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.374919] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.375060] pci 0000:07:00.0: supports D1
Jan  3 16:16:57 cfhat12 kernel: [    0.375061] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 16:16:57 cfhat12 kernel: [    0.375067] pci 0000:07:00.0: PME# disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.375086] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 16:16:57 cfhat12 kernel: [    0.375090] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.375093] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.375097] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.375196] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 16:16:57 cfhat12 kernel: [    0.375206] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 16:16:57 cfhat12 kernel: [    0.375217] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 16:16:57 cfhat12 kernel: [    0.375227] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 16:16:57 cfhat12 kernel: [    0.375237] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 16:16:57 cfhat12 kernel: [    0.375248] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 16:16:57 cfhat12 kernel: [    0.375335] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 16:16:57 cfhat12 kernel: [    0.375340] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.375346] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.375352] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.375378] pci_bus 0000:00: on NUMA node 0
Jan  3 16:16:57 cfhat12 kernel: [    0.375381] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375604] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375642] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375685] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375767] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375802] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375839] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.375878] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 16:16:57 cfhat12 kernel: [    0.393513] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393582] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393648] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393714] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393781] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393847] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393915] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.393981] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:16:57 cfhat12 kernel: [    0.394159] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 16:16:57 cfhat12 kernel: [    0.394163] vgaarb: loaded
Jan  3 16:16:57 cfhat12 kernel: [    0.394304] SCSI subsystem initialized
Jan  3 16:16:57 cfhat12 kernel: [    0.394391] libata version 3.00 loaded.
Jan  3 16:16:57 cfhat12 kernel: [    0.394508] usbcore: registered new interface driver usbfs
Jan  3 16:16:57 cfhat12 kernel: [    0.394537] usbcore: registered new interface driver hub
Jan  3 16:16:57 cfhat12 kernel: [    0.394572] usbcore: registered new device driver usb
Jan  3 16:16:57 cfhat12 kernel: [    0.460014] raid6: int64x1   2789 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.528015] raid6: int64x2   3407 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.596006] raid6: int64x4   2791 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.664024] raid6: int64x8   2481 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.732009] raid6: sse2x1    4303 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.800011] raid6: sse2x2    7601 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.868007] raid6: sse2x4    8870 MB/s
Jan  3 16:16:57 cfhat12 kernel: [    0.868008] raid6: using algorithm sse2x4 (8870 MB/s)
Jan  3 16:16:57 cfhat12 kernel: [    0.868133] Advanced Linux Sound Architecture Driver Version 1.0.23.
Jan  3 16:16:57 cfhat12 kernel: [    0.868135] PCI: Using ACPI for IRQ routing
Jan  3 16:16:57 cfhat12 kernel: [    0.868137] PCI: pci_cache_line_size set to 64 bytes
Jan  3 16:16:57 cfhat12 kernel: [    0.868149] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.868242] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 16:16:57 cfhat12 kernel: [    0.868244] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 16:16:57 cfhat12 kernel: [    0.868363] NetLabel: Initializing
Jan  3 16:16:57 cfhat12 kernel: [    0.868365] NetLabel:  domain hash size = 128
Jan  3 16:16:57 cfhat12 kernel: [    0.868366] NetLabel:  protocols = UNLABELED CIPSOv4
Jan  3 16:16:57 cfhat12 kernel: [    0.868375] NetLabel:  unlabeled traffic allowed by default
Jan  3 16:16:57 cfhat12 kernel: [    0.868458] Switching to clocksource tsc
Jan  3 16:16:57 cfhat12 kernel: [    0.870450] pnp: PnP ACPI init
Jan  3 16:16:57 cfhat12 kernel: [    0.870457] ACPI: bus type pnp registered
Jan  3 16:16:57 cfhat12 kernel: [    0.871088] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871114] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.871119] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.871930] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 16:16:57 cfhat12 kernel: [    0.872004] pnp: PnP ACPI: found 11 devices
Jan  3 16:16:57 cfhat12 kernel: [    0.872005] ACPI: ACPI bus type pnp unregistered
Jan  3 16:16:57 cfhat12 kernel: [    0.872013] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872015] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872018] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872021] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872023] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872025] system 00:02: [io  0x040b] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872027] system 00:02: [io  0x04d6] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872029] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872031] system 00:02: [io  0x0c14] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872033] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872034] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872036] system 00:02: [io  0x0c6f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872038] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872040] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872042] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872044] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872046] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872048] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872050] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872052] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872054] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872058] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872062] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872064] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872066] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872069] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872071] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872073] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.872075] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 16:16:57 cfhat12 kernel: [    0.878818] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 16:16:57 cfhat12 kernel: [    0.878821] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878823] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878826] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878830] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878832] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 16:16:57 cfhat12 kernel: [    0.878834] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878836] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878839] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878842] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 16:16:57 cfhat12 kernel: [    0.878844] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878846] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878848] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878852] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878854] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 16:16:57 cfhat12 kernel: [    0.878855] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878858] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878860] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878864] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 16:16:57 cfhat12 kernel: [    0.878866] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878870] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878873] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878878] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 16:16:57 cfhat12 kernel: [    0.878880] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878884] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878887] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878891] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 16:16:57 cfhat12 kernel: [    0.878895] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878902] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878908] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878917] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 16:16:57 cfhat12 kernel: [    0.878919] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878923] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.878926] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.878941] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:16:57 cfhat12 kernel: [    0.878943] pci 0000:00:07.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.878951] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    0.878953] pci 0000:00:09.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.878960] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    0.878962] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.878970] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    0.878973] pci 0000:00:15.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.878979] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    0.878981] pci 0000:00:15.1: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.878992] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    0.878997] pci 0000:07:00.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    0.879001] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 16:16:57 cfhat12 kernel: [    0.879003] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879005] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879006] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879008] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879010] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879011] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879013] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879015] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879017] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879018] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879020] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879022] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879023] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879025] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879027] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879029] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879030] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879032] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879034] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879035] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 16:16:57 cfhat12 kernel: [    0.879037] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879039] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879040] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879042] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879044] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879045] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879047] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879049] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879050] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879052] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879054] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879056] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 16:16:57 cfhat12 kernel: [    0.879057] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 16:16:57 cfhat12 kernel: [    0.879109] NET: Registered protocol family 2
Jan  3 16:16:57 cfhat12 kernel: [    0.879154] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.879618] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.880562] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.880804] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 16:16:57 cfhat12 kernel: [    0.880806] TCP reno registered
Jan  3 16:16:57 cfhat12 kernel: [    0.880809] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.880848] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    0.880981] NET: Registered protocol family 1
Jan  3 16:16:57 cfhat12 kernel: [    0.881097] RPC: Registered udp transport module.
Jan  3 16:16:57 cfhat12 kernel: [    0.881099] RPC: Registered tcp transport module.
Jan  3 16:16:57 cfhat12 kernel: [    0.881100] RPC: Registered tcp NFSv4.1 backchannel transport module.
Jan  3 16:16:57 cfhat12 kernel: [    0.881107] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 16:16:57 cfhat12 kernel: [    0.943607] pci 0000:01:05.0: Boot video device
Jan  3 16:16:57 cfhat12 kernel: [    0.943645] PCI: CLS 4 bytes, default 64
Jan  3 16:16:57 cfhat12 kernel: [    0.943689] Trying to unpack rootfs image as initramfs...
Jan  3 16:16:57 cfhat12 kernel: [    0.988807] Freeing initrd memory: 3248k freed
Jan  3 16:16:57 cfhat12 kernel: [    0.989427] PCI-DMA: Disabling AGP.
Jan  3 16:16:57 cfhat12 kernel: [    0.989585] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 16:16:57 cfhat12 kernel: [    0.989586] PCI-DMA: using GART IOMMU.
Jan  3 16:16:57 cfhat12 kernel: [    0.989588] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 16:16:57 cfhat12 kernel: [    0.993740] audit: initializing netlink socket (disabled)
Jan  3 16:16:57 cfhat12 kernel: [    0.993750] type=2000 audit(1294089406.988:1): initialized
Jan  3 16:16:57 cfhat12 kernel: [    0.993783] I-pipe: Domain Xenomai registered.
Jan  3 16:16:57 cfhat12 kernel: [    0.993849] Xenomai: hal/x86_64 started.
Jan  3 16:16:57 cfhat12 kernel: [    0.993859] Xenomai: scheduling class idle registered.
Jan  3 16:16:57 cfhat12 kernel: [    0.993860] Xenomai: scheduling class rt registered.
Jan  3 16:16:57 cfhat12 kernel: [    0.994958] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 16:16:57 cfhat12 kernel: [    1.191615] Xenomai: native skin init failed, code -19.
Jan  3 16:16:57 cfhat12 kernel: [    1.191969] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  3 16:16:57 cfhat12 kernel: [    1.192111] VFS: Disk quotas dquot_6.5.2
Jan  3 16:16:57 cfhat12 kernel: [    1.192131] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 16:16:57 cfhat12 kernel: [    1.192307] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, debug enabled
Jan  3 16:16:57 cfhat12 kernel: [    1.192559] SGI XFS Quota Management subsystem
Jan  3 16:16:57 cfhat12 kernel: [    1.192565] msgmni has been set to 14971
Jan  3 16:16:57 cfhat12 kernel: [    1.192594] SELinux:  Registering netfilter hooks
Jan  3 16:16:57 cfhat12 kernel: [    1.192830] alg: No test for stdrng (krng)
Jan  3 16:16:57 cfhat12 kernel: [    1.192901] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  3 16:16:57 cfhat12 kernel: [    1.192904] io scheduler noop registered
Jan  3 16:16:57 cfhat12 kernel: [    1.192905] io scheduler deadline registered
Jan  3 16:16:57 cfhat12 kernel: [    1.192917] io scheduler cfq registered (default)
Jan  3 16:16:57 cfhat12 kernel: [    1.193007] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.193026] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.193096] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.193112] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.193178] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.193194] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.193263] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.193293] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.193373] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.193403] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.193865] Non-volatile memory driver v1.3
Jan  3 16:16:57 cfhat12 kernel: [    1.193868] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  3 16:16:57 cfhat12 kernel: [    1.447774] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 16:16:57 cfhat12 kernel: [    1.448122] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 16:16:57 cfhat12 kernel: [    1.448217] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 16:16:57 cfhat12 kernel: [    1.448303] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 16:16:57 cfhat12 kernel: [    1.448415] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 16:16:57 cfhat12 kernel: [    1.448526] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 16:16:57 cfhat12 kernel: [    1.448558] Couldn't register serial port 0000:05:06.0: -28
Jan  3 16:16:57 cfhat12 kernel: [    1.448565] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 16:16:57 cfhat12 kernel: [    1.448567] Couldn't register serial port 0000:05:06.1: -28
Jan  3 16:16:57 cfhat12 kernel: [    1.449680] brd: module loaded
Jan  3 16:16:57 cfhat12 kernel: [    1.449839] ahci 0000:00:11.0: version 3.0
Jan  3 16:16:57 cfhat12 kernel: [    1.449845] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:16:57 cfhat12 kernel: [    1.449880] ahci 0000:00:11.0: irq 45 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    1.449944] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 16:16:57 cfhat12 kernel: [    1.449946] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 16:16:57 cfhat12 kernel: [    1.450113] scsi0 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450181] scsi1 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450229] scsi2 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450277] scsi3 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450368] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 45
Jan  3 16:16:57 cfhat12 kernel: [    1.450371] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 45
Jan  3 16:16:57 cfhat12 kernel: [    1.450374] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 45
Jan  3 16:16:57 cfhat12 kernel: [    1.450376] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 45
Jan  3 16:16:57 cfhat12 kernel: [    1.450402] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.450484] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 16:16:57 cfhat12 kernel: [    1.450487] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 16:16:57 cfhat12 kernel: [    1.450491] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.450594] scsi4 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450648] scsi5 : ahci
Jan  3 16:16:57 cfhat12 kernel: [    1.450684] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 16:16:57 cfhat12 kernel: [    1.450687] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 16:16:57 cfhat12 kernel: [    1.450879] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.450941] scsi6 : pata_atiixp
Jan  3 16:16:57 cfhat12 kernel: [    1.450985] scsi7 : pata_atiixp
Jan  3 16:16:57 cfhat12 kernel: [    1.451740] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 16:16:57 cfhat12 kernel: [    1.451743] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 16:16:57 cfhat12 kernel: [    1.451907] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 16:16:57 cfhat12 kernel: [    1.451912] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.451930] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.451968] scsi8 : pata_jmicron
Jan  3 16:16:57 cfhat12 kernel: [    1.452029] scsi9 : pata_jmicron
Jan  3 16:16:57 cfhat12 kernel: [    1.452063] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 16:16:57 cfhat12 kernel: [    1.452065] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 16:16:57 cfhat12 kernel: [    1.452213] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Jan  3 16:16:57 cfhat12 kernel: [    1.452215] e100: Copyright(c) 1999-2006 Intel Corporation
Jan  3 16:16:57 cfhat12 kernel: [    1.452299] console [netcon0] enabled
Jan  3 16:16:57 cfhat12 kernel: [    1.452301] netconsole: network logging started
Jan  3 16:16:57 cfhat12 kernel: [    1.452311] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 16:16:57 cfhat12 kernel: [    1.452325] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.452339] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.452356] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 16:16:57 cfhat12 kernel: [    1.452381] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 16:16:57 cfhat12 kernel: [    1.452392] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 16:16:57 cfhat12 kernel: [    1.463632] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 16:16:57 cfhat12 kernel: [    1.463765] hub 1-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.463768] hub 1-0:1.0: 5 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.463806] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.463815] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.463821] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 16:16:57 cfhat12 kernel: [    1.463841] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 16:16:57 cfhat12 kernel: [    1.463852] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 16:16:57 cfhat12 kernel: [    1.475626] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 16:16:57 cfhat12 kernel: [    1.475746] hub 2-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.475749] hub 2-0:1.0: 5 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.475786] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.475796] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.475800] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 16:16:57 cfhat12 kernel: [    1.475822] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 16:16:57 cfhat12 kernel: [    1.475832] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 16:16:57 cfhat12 kernel: [    1.487631] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 16:16:57 cfhat12 kernel: [    1.487750] hub 3-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.487753] hub 3-0:1.0: 4 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.487804] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 16:16:57 cfhat12 kernel: [    1.487814] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    1.487824] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.487830] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 16:16:57 cfhat12 kernel: [    1.487854] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 16:16:57 cfhat12 kernel: [    1.547737] hub 4-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.547742] hub 4-0:1.0: 5 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.547776] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    1.547786] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.547791] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 16:16:57 cfhat12 kernel: [    1.547804] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] hub 5-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] hub 5-0:1.0: 5 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 16:16:57 cfhat12 kernel: [    1.607762] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 16:16:57 cfhat12 kernel: [    1.627910] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 16:16:57 cfhat12 kernel: [    1.627923] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  3 16:16:57 cfhat12 kernel: [    1.643919] ata7.00: configured for UDMA/33
Jan  3 16:16:57 cfhat12 kernel: [    1.675759] hub 6-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.675764] hub 6-0:1.0: 2 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.675796] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    1.675807] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.675815] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 16:16:57 cfhat12 kernel: [    1.675830] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 16:16:57 cfhat12 kernel: [    1.735763] hub 7-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.735768] hub 7-0:1.0: 4 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.735822] uhci_hcd: USB Universal Host Controller Interface driver
Jan  3 16:16:57 cfhat12 kernel: [    1.735871] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    1.735882] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.735884] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 16:16:57 cfhat12 kernel: [    1.735889] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 16:16:57 cfhat12 kernel: [    1.735989] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 16:16:57 cfhat12 kernel: [    1.739351] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 16:16:57 cfhat12 kernel: [    1.739444] xHCI xhci_add_endpoint called for root hub
Jan  3 16:16:57 cfhat12 kernel: [    1.739445] xHCI xhci_check_bandwidth called for root hub
Jan  3 16:16:57 cfhat12 kernel: [    1.739481] hub 8-0:1.0: USB hub found
Jan  3 16:16:57 cfhat12 kernel: [    1.739484] hub 8-0:1.0: 4 ports detected
Jan  3 16:16:57 cfhat12 kernel: [    1.739582] usbcore: registered new interface driver usblp
Jan  3 16:16:57 cfhat12 kernel: [    1.739583] Initializing USB Mass Storage driver...
Jan  3 16:16:57 cfhat12 kernel: [    1.739640] usbcore: registered new interface driver usb-storage
Jan  3 16:16:57 cfhat12 kernel: [    1.739642] USB Mass Storage support registered.
Jan  3 16:16:57 cfhat12 kernel: [    1.739705] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 16:16:57 cfhat12 kernel: [    1.739707] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 16:16:57 cfhat12 kernel: [    1.739833] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 16:16:57 cfhat12 kernel: [    1.739933] mice: PS/2 mouse device common for all mice
Jan  3 16:16:57 cfhat12 kernel: [    1.739975] rtc_cmos 00:04: RTC can wake from S4
Jan  3 16:16:57 cfhat12 kernel: [    1.740015] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 16:16:57 cfhat12 kernel: [    1.740035] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 16:16:57 cfhat12 kernel: [    1.740060] md: linear personality registered for level -1
Jan  3 16:16:57 cfhat12 kernel: [    1.740062] md: raid0 personality registered for level 0
Jan  3 16:16:57 cfhat12 kernel: [    1.740063] md: raid1 personality registered for level 1
Jan  3 16:16:57 cfhat12 kernel: [    1.740065] md: raid10 personality registered for level 10
Jan  3 16:16:57 cfhat12 kernel: [    1.740067] md: raid6 personality registered for level 6
Jan  3 16:16:57 cfhat12 kernel: [    1.740068] md: raid5 personality registered for level 5
Jan  3 16:16:57 cfhat12 kernel: [    1.740069] md: raid4 personality registered for level 4
Jan  3 16:16:57 cfhat12 kernel: [    1.740155] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid
Jan  3 16:16:57 cfhat12 kernel: [    1.740163] cpuidle: using governor ladder
Jan  3 16:16:57 cfhat12 kernel: [    1.741049] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:16:57 cfhat12 kernel: [    1.741076] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    1.756156] ALSA device list:
Jan  3 16:16:57 cfhat12 kernel: [    1.756158]   #0: HDA ATI HDMI at 0xfd3fc000 irq 19
Jan  3 16:16:57 cfhat12 kernel: [    1.756180] Netfilter messages via NETLINK v0.30.
Jan  3 16:16:57 cfhat12 kernel: [    1.756190] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jan  3 16:16:57 cfhat12 kernel: [    1.756269] ctnetlink v0.93: registering with nfnetlink.
Jan  3 16:16:57 cfhat12 kernel: [    1.756552] ip_tables: (C) 2000-2006 Netfilter Core Team
Jan  3 16:16:57 cfhat12 kernel: [    1.756580] TCP bic registered
Jan  3 16:16:57 cfhat12 kernel: [    1.756581] TCP cubic registered
Jan  3 16:16:57 cfhat12 kernel: [    1.756583] NET: Registered protocol family 17
Jan  3 16:16:57 cfhat12 kernel: [    1.756700] registered taskstats version 1
Jan  3 16:16:57 cfhat12 kernel: [    1.771691] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.771696] ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.755685] ata5: SATA link down (SStatus 0 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.755685] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.795557] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 16:16:57 cfhat12 kernel: [    1.947698] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 16:16:57 cfhat12 kernel: [    1.955698] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.819677] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 16:16:57 cfhat12 kernel: [    1.819677] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 16:16:57 cfhat12 kernel: [    1.819677] ata1.00: configured for UDMA/133
Jan  3 16:16:57 cfhat12 kernel: [    1.975790] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 16:16:57 cfhat12 kernel: [    1.975947] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 16:16:57 cfhat12 kernel: [    1.975973] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 16:16:57 cfhat12 kernel: [    1.975975] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 16:16:57 cfhat12 kernel: [    1.975986] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 16:16:57 cfhat12 kernel: [    1.975995] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  3 16:16:57 cfhat12 kernel: [    1.976072]  sda: sda1 sda2 sda3 sda4 < sda5
Jan  3 16:16:57 cfhat12 kernel: [    1.999710] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 16:16:57 cfhat12 kernel: [    1.976059] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 16:16:57 cfhat12 kernel: [    1.976059] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 16:16:57 cfhat12 kernel: [    1.976059]  sda6
Jan  3 16:16:57 cfhat12 kernel: [    1.976059] ata2.00: configured for UDMA/133
Jan  3 16:16:57 cfhat12 kernel: [    1.976059]  sda7 >
Jan  3 16:16:57 cfhat12 kernel: [    2.014896] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 16:16:57 cfhat12 kernel: [    2.023770] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 16:16:57 cfhat12 kernel: [    2.023855] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 16:16:57 cfhat12 kernel: [    2.023855] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 16:16:57 cfhat12 kernel: [    2.023855] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 16:16:57 cfhat12 kernel: [    2.023855] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 16:16:57 cfhat12 kernel: [    2.023936] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  3 16:16:57 cfhat12 kernel: [    2.023855]  sdb:
Jan  3 16:16:57 cfhat12 kernel: [    2.024024] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 16:16:57 cfhat12 kernel: [    2.026421] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 16:16:57 cfhat12 kernel: [    2.026421] Uniform CD-ROM driver Revision: 3.20
Jan  3 16:16:57 cfhat12 kernel: [    2.028966] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  3 16:16:57 cfhat12 kernel: [    2.029032] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  3 16:16:57 cfhat12 kernel: [    2.029092]  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jan  3 16:16:57 cfhat12 kernel: [    2.064814] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 16:16:57 cfhat12 kernel: [    2.195186] Freeing unused kernel memory: 488k freed
Jan  3 16:16:57 cfhat12 kernel: [    2.204662] udev[808]: starting version 164
Jan  3 16:16:57 cfhat12 kernel: [    2.220972] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 16:16:57 cfhat12 kernel: [    2.220974] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 16:16:57 cfhat12 kernel: [    2.221005] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:16:57 cfhat12 kernel: [    2.221020] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    2.221170] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    2.221172] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    2.221174] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    2.221651] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 16:16:57 cfhat12 kernel: [    2.222810] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 16:16:57 cfhat12 kernel: [    2.222823] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:16:57 cfhat12 kernel: [    2.222854] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 16:16:57 cfhat12 kernel: [    2.222888] r8169 0000:04:00.0: irq 49 for MSI/MSI-X
Jan  3 16:16:57 cfhat12 kernel: [    2.223075] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000070000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 49
Jan  3 16:16:57 cfhat12 kernel: [    2.241345] usbcore: registered new interface driver hiddev
Jan  3 16:16:57 cfhat12 kernel: [    2.244851] input: USBPS2 as /class/input/input1
Jan  3 16:16:57 cfhat12 kernel: [    2.244863] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 16:16:57 cfhat12 kernel: [    2.251715] input: USBPS2 as /class/input/input2
Jan  3 16:16:57 cfhat12 kernel: [    2.251715] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 16:16:57 cfhat12 kernel: [    2.251715] usbcore: registered new interface driver usbhid
Jan  3 16:16:57 cfhat12 kernel: [    2.251715] usbhid: USB HID core driver
Jan  3 16:16:57 cfhat12 kernel: [    2.328846] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 16:16:57 cfhat12 kernel: [    2.328848] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 16:16:57 cfhat12 kernel: [    2.328859] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 16:16:57 cfhat12 kernel: [    2.499747] md: md1 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    2.499747] md: bind<sdb1>
Jan  3 16:16:57 cfhat12 kernel: [    2.499747] md: bind<sda1>
Jan  3 16:16:57 cfhat12 kernel: [    2.502188] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    2.502203] md1: detected capacity change from 0 to 254791680
Jan  3 16:16:57 cfhat12 kernel: [    2.502691]  md1: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    2.712154] md: md2 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    2.712852] md: bind<sdb2>
Jan  3 16:16:57 cfhat12 kernel: [    2.712992] md: bind<sda2>
Jan  3 16:16:57 cfhat12 kernel: [    2.713680] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    2.713694] md2: detected capacity change from 0 to 19998367744
Jan  3 16:16:57 cfhat12 kernel: [    2.714176]  md2: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    2.924219] md: md3 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    2.924978] md: bind<sdb3>
Jan  3 16:16:57 cfhat12 kernel: [    2.925141] md: bind<sda3>
Jan  3 16:16:57 cfhat12 kernel: [    2.925829] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    2.925843] md3: detected capacity change from 0 to 1998573568
Jan  3 16:16:57 cfhat12 kernel: [    2.926324]  md3: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    3.145616] md: md5 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    3.146420] md: bind<sdb5>
Jan  3 16:16:57 cfhat12 kernel: [    3.146601] md: bind<sda5>
Jan  3 16:16:57 cfhat12 kernel: [    3.147287] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    3.147302] md5: detected capacity change from 0 to 19997319168
Jan  3 16:16:57 cfhat12 kernel: [    3.147784]  md5: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    3.370160] md: md6 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    3.382445] md: bind<sdb6>
Jan  3 16:16:57 cfhat12 kernel: [    3.382586] md: bind<sda6>
Jan  3 16:16:57 cfhat12 kernel: [    3.383280] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    3.383293] md6: detected capacity change from 0 to 19997319168
Jan  3 16:16:57 cfhat12 kernel: [    3.383775]  md6: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    3.612650] md: md7 stopped.
Jan  3 16:16:57 cfhat12 kernel: [    3.613557] md: bind<sdb7>
Jan  3 16:16:57 cfhat12 kernel: [    3.613757] md: bind<sda7>
Jan  3 16:16:57 cfhat12 kernel: [    3.614441] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 16:16:57 cfhat12 kernel: [    3.614454] md7: detected capacity change from 0 to 97784881152
Jan  3 16:16:57 cfhat12 kernel: [    3.614933]  md7: unknown partition table
Jan  3 16:16:57 cfhat12 kernel: [    3.870049] XFS mounting filesystem md2
Jan  3 16:16:57 cfhat12 kernel: [    4.200133] Ending clean XFS mount for filesystem: md2
Jan  3 16:16:57 cfhat12 kernel: [    5.570397] udev[1085]: starting version 164
Jan  3 16:16:57 cfhat12 kernel: [    6.232716] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f]
Jan  3 16:16:57 cfhat12 kernel: [    6.232719] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 16:16:57 cfhat12 kernel: [    6.270885] input: Power Button as /class/input/input3
Jan  3 16:16:57 cfhat12 kernel: [    6.270919] ACPI: Power Button [PWRB]
Jan  3 16:16:57 cfhat12 kernel: [    6.270967] input: Power Button as /class/input/input4
Jan  3 16:16:57 cfhat12 kernel: [    6.270983] ACPI: Power Button [PWRF]
Jan  3 16:16:57 cfhat12 kernel: [    6.291050] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    6.291053] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    6.291139] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 16:16:57 cfhat12 kernel: [    6.294880] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 16:16:57 cfhat12 kernel: [    6.298904] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 16:16:57 cfhat12 kernel: [    6.298906] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 16:16:57 cfhat12 kernel: [    6.298908] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 16:16:57 cfhat12 kernel: [    6.299978] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 16:16:57 cfhat12 kernel: [    6.388320] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 16:16:57 cfhat12 kernel: [    6.388418] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 16:16:57 cfhat12 kernel: [    7.425397] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 16:16:57 cfhat12 kernel: [    7.911261] loop: module loaded
Jan  3 16:16:57 cfhat12 kernel: [    8.590834] EXT3-fs: barriers not enabled
Jan  3 16:16:57 cfhat12 kernel: [    8.596024] kjournald starting.  Commit interval 5 seconds
Jan  3 16:16:57 cfhat12 kernel: [    8.610887] EXT3-fs (md1): using internal journal
Jan  3 16:16:57 cfhat12 kernel: [    8.610891] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 16:16:57 cfhat12 kernel: [    8.684306] XFS mounting filesystem md7
Jan  3 16:16:57 cfhat12 kernel: [    8.997919] Ending clean XFS mount for filesystem: md7
Jan  3 16:16:57 cfhat12 kernel: [    9.050766] XFS mounting filesystem md5
Jan  3 16:16:57 cfhat12 kernel: [    9.491501] Ending clean XFS mount for filesystem: md5
Jan  3 16:16:57 cfhat12 kernel: [    9.516118] EXT3-fs: barriers not enabled
Jan  3 16:16:57 cfhat12 kernel: [    9.527688] kjournald starting.  Commit interval 5 seconds
Jan  3 16:16:57 cfhat12 kernel: [    9.605492] EXT3-fs (md6): using internal journal
Jan  3 16:16:57 cfhat12 kernel: [    9.605495] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 16:16:57 cfhat12 kernel: [   10.646055] fuse init (API version 7.14)
Jan  3 16:16:57 cfhat12 kernel: [   11.076995] r8169 0000:04:00.0: eth0: link up
Jan  3 16:16:57 cfhat12 kernel: [   11.077000] r8169 0000:04:00.0: eth0: link up
Jan  3 16:16:58 cfhat12 kernel: [   12.187660] NET: Registered protocol family 10
Jan  3 16:17:08 cfhat12 kernel: [   22.449225] eth0: no IPv6 routers present
Jan  3 16:19:12 cfhat12 kernel: [  146.195136] md: md7 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195169] md: md6 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195211] md: md5 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195240] md: md3 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195269] md: md2 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195298] md: md1 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195385] md: md7 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195424] md: md6 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195449] md: md5 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195474] md: md3 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195499] md: md2 still in use.
Jan  3 16:19:12 cfhat12 kernel: [  146.195523] md: md1 still in use.
Jan  3 16:19:13 cfhat12 kernel: [  147.545913] fuse exit
Jan  3 16:19:14 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 16:20:41 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Linux version 2.6.32-5-amd64 (Debian 2.6.32-29) (ben@domain.hid) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Fri Dec 10 15:35:08 UTC 2010
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] KERNEL supported cpus:
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   Intel GenuineIntel
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   AMD AuthenticAMD
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   Centaur CentaurHauls
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   6 disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   7 disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] RAMDISK: 376ee000 - 37feff7b
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Scanning NUMA topology in Northbridge 24
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] No NUMA configuration found
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Faking a node at 0000000000000000-0000000210000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Bootmem setup node 0 0000000000000000-0000000210000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   NODE_DATA [000000000000b000 - 0000000000012fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   bootmap [0000000000013000 -  0000000000054fff] pages 42
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0210000000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #2 [0001000000 - 000168a414]    TEXT DATA BSS ==> [0001000000 - 000168a414]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #3 [00376ee000 - 0037feff7b]          RAMDISK ==> [00376ee000 - 0037feff7b]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #5 [000168b000 - 000168b0fe]              BRK ==> [000168b000 - 000168b0fe]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   #7 [000000a000 - 000000b000]          PGTABLE ==> [000000a000 - 000000b000]
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880001800000-ffff8800081fffff] on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA      0x00000000 -> 0x00001000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]     0: 0x00000000 -> 0x0000009f
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965455
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA zone: 102 pages reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA zone: 3841 pages, LIFO batch:0
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  3 16:20:41 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 24
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf0000 - 00000000cfdf1000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf1000 - 00000000cfe00000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfe00000 - 00000000cff00000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cff00000 - 00000000e0000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000fec00000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000fec00000 - 0000000100000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Booting paravirtualized kernel on bare hardware
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880008400000 s90328 r8192 d24360 u262144
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] pcpu-alloc: s90328 r8192 d24360 u262144 alloc=1*2097152
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935785
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Policy zone: Normal
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Initializing CPU#0
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Node 0: aperture @ 20000000 size 32 MB
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Aperture pointing to e820 RAM. Ignoring.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000024000000
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Memory: 7670416k/8650752k available (3078k kernel code, 788932k absent, 191404k reserved, 1892k data, 592k init)
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] NR_IRQS:4352 nr_irqs:472
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  3 16:20:41 cfhat12 kernel: [    0.000000] Detected 3414.784 MHz processor.
Jan  3 16:20:41 cfhat12 kernel: [    0.008004] Calibrating delay loop (skipped), value calculated using timer frequency.. 6829.55 BogoMIPS (lpj=13659116)
Jan  3 16:20:41 cfhat12 kernel: [    0.008017] Security Framework initialized
Jan  3 16:20:41 cfhat12 kernel: [    0.008020] SELinux:  Disabled at boot.
Jan  3 16:20:41 cfhat12 kernel: [    0.008372] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.012044] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.012955] Mount-cache hash table entries: 256
Jan  3 16:20:41 cfhat12 kernel: [    0.013042] Initializing cgroup subsys ns
Jan  3 16:20:41 cfhat12 kernel: [    0.013044] Initializing cgroup subsys cpuacct
Jan  3 16:20:41 cfhat12 kernel: [    0.013046] Initializing cgroup subsys devices
Jan  3 16:20:41 cfhat12 kernel: [    0.013048] Initializing cgroup subsys freezer
Jan  3 16:20:41 cfhat12 kernel: [    0.013049] Initializing cgroup subsys net_cls
Jan  3 16:20:41 cfhat12 kernel: [    0.013063] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.013064] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.013066] CPU 0/0x0 -> Node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.013068] tseg: 00cff00000
Jan  3 16:20:41 cfhat12 kernel: [    0.013069] CPU: Physical Processor ID: 0
Jan  3 16:20:41 cfhat12 kernel: [    0.013070] CPU: Processor Core ID: 0
Jan  3 16:20:41 cfhat12 kernel: [    0.013072] mce: CPU supports 6 MCE banks
Jan  3 16:20:41 cfhat12 kernel: [    0.013078] using C1E aware idle routine
Jan  3 16:20:41 cfhat12 kernel: [    0.013079] Performance Events: AMD PMU driver.
Jan  3 16:20:41 cfhat12 kernel: [    0.013081] ... version:                0
Jan  3 16:20:41 cfhat12 kernel: [    0.013082] ... bit width:              48
Jan  3 16:20:41 cfhat12 kernel: [    0.013083] ... generic registers:      4
Jan  3 16:20:41 cfhat12 kernel: [    0.013084] ... value mask:             0000ffffffffffff
Jan  3 16:20:41 cfhat12 kernel: [    0.013085] ... max period:             00007fffffffffff
Jan  3 16:20:41 cfhat12 kernel: [    0.013086] ... fixed-purpose events:   0
Jan  3 16:20:41 cfhat12 kernel: [    0.013087] ... event mask:             000000000000000f
Jan  3 16:20:41 cfhat12 kernel: [    0.013575] ACPI: Core revision 20090903
Jan  3 16:20:41 cfhat12 kernel: [    0.020062] Setting APIC routing to flat
Jan  3 16:20:41 cfhat12 kernel: [    0.020438] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  3 16:20:41 cfhat12 kernel: [    0.060568] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 16:20:41 cfhat12 kernel: [    0.064001] Booting processor 1 APIC 0x1 ip 0x6000
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] Initializing CPU#1
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU 1/0x1 -> Node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 1
Jan  3 16:20:41 cfhat12 kernel: [    0.148060] CPU1: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 16:20:41 cfhat12 kernel: [    0.148065] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Jan  3 16:20:41 cfhat12 kernel: [    0.152014] System has AMD C1E enabled
Jan  3 16:20:41 cfhat12 kernel: [    0.152023] Switch to broadcast mode on CPU1
Jan  3 16:20:41 cfhat12 kernel: [    0.152045] Booting processor 2 APIC 0x2 ip 0x6000
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] Initializing CPU#2
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU 2/0x2 -> Node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 2
Jan  3 16:20:41 cfhat12 kernel: [    0.240045] CPU2: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 16:20:41 cfhat12 kernel: [    0.240049] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Jan  3 16:20:41 cfhat12 kernel: [    0.244015] Switch to broadcast mode on CPU2
Jan  3 16:20:41 cfhat12 kernel: [    0.244044] Booting processor 3 APIC 0x3 ip 0x6000
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] Initializing CPU#3
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU 3/0x3 -> Node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  3 16:20:41 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 3
Jan  3 16:20:41 cfhat12 kernel: [    0.332043] CPU3: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  3 16:20:41 cfhat12 kernel: [    0.332050] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Jan  3 16:20:41 cfhat12 kernel: [    0.336029] Switch to broadcast mode on CPU3
Jan  3 16:20:41 cfhat12 kernel: [    0.336033] Brought up 4 CPUs
Jan  3 16:20:41 cfhat12 kernel: [    0.336035] Total of 4 processors activated (27321.70 BogoMIPS).
Jan  3 16:20:41 cfhat12 kernel: [    0.337718] CPU0 attaching sched-domain:
Jan  3 16:20:41 cfhat12 kernel: [    0.337720]  domain 0: span 0-3 level MC
Jan  3 16:20:41 cfhat12 kernel: [    0.337721]   groups: 0 1 2 3
Jan  3 16:20:41 cfhat12 kernel: [    0.337725] CPU1 attaching sched-domain:
Jan  3 16:20:41 cfhat12 kernel: [    0.337727]  domain 0: span 0-3 level MC
Jan  3 16:20:41 cfhat12 kernel: [    0.337728]   groups: 1 2 3 0
Jan  3 16:20:41 cfhat12 kernel: [    0.337731] CPU2 attaching sched-domain:
Jan  3 16:20:41 cfhat12 kernel: [    0.337732]  domain 0: span 0-3 level MC
Jan  3 16:20:41 cfhat12 kernel: [    0.337733]   groups: 2 3 0 1
Jan  3 16:20:41 cfhat12 kernel: [    0.337736] CPU3 attaching sched-domain:
Jan  3 16:20:41 cfhat12 kernel: [    0.337737]  domain 0: span 0-3 level MC
Jan  3 16:20:41 cfhat12 kernel: [    0.337738]   groups: 3 0 1 2
Jan  3 16:20:41 cfhat12 kernel: [    0.337802] Switch to broadcast mode on CPU0
Jan  3 16:20:41 cfhat12 kernel: [    0.337802] devtmpfs: initialized
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] regulator: core version 0.5
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] NET: Registered protocol family 16
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] node 0 link 0: io port [8000, ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] TOM: 00000000d0000000 aka 3328M
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] Fam 10h mmconf [e0000000, e00fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] node 0 link 0: mmio [a0000, bffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] node 0 link 0: mmio [d0000000, dfffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] TOM2: 0000000230000000 aka 8960M
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: [00,08] on node 0 link 0
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 0 io port: [0, ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 1 mmio: [a0000, bffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 2 mmio: [d0000000, dfffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 3 mmio: [e0900000, ffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 4 mmio: [e0100000, e08fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340116] bus: 00 index 5 mmio: [230000000, fcffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.340117] ACPI: bus type pci registered
Jan  3 16:20:41 cfhat12 kernel: [    0.340160] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
Jan  3 16:20:41 cfhat12 kernel: [    0.340162] PCI: MCFG area at e0000000 reserved in E820
Jan  3 16:20:41 cfhat12 kernel: [    0.344821] PCI: Using MMCONFIG at e0000000 - efffffff
Jan  3 16:20:41 cfhat12 kernel: [    0.344822] PCI: Using configuration type 1 for base access
Jan  3 16:20:41 cfhat12 kernel: [    0.345068] bio: create slab <bio-0> at 0
Jan  3 16:20:41 cfhat12 kernel: [    0.345068] ACPI: EC: Look up EC in DSDT
Jan  3 16:20:41 cfhat12 kernel: [    0.352179] ACPI: Interpreter enabled
Jan  3 16:20:41 cfhat12 kernel: [    0.352182] ACPI: (supports S0 S3 S4 S5)
Jan  3 16:20:41 cfhat12 kernel: [    0.352198] ACPI: Using IOAPIC for interrupt routing
Jan  3 16:20:41 cfhat12 kernel: [    0.355062] ACPI Warning: Incorrect checksum in table [TAMG] - 93, should be 92 (20090903/tbutils-314)
Jan  3 16:20:41 cfhat12 kernel: [    0.355129] ACPI: No dock devices found.
Jan  3 16:20:41 cfhat12 kernel: [    0.355211] ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  3 16:20:41 cfhat12 kernel: [    0.355242] pci 0000:00:00.0: reg 1c 64bit mmio: [0xe0000000-0xffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355307] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.355309] pci 0000:00:07.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.355335] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.355336] pci 0000:00:09.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.355360] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.355362] pci 0000:00:0a.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.355400] pci 0000:00:11.0: reg 10 io port: [0xff00-0xff07]
Jan  3 16:20:41 cfhat12 kernel: [    0.355404] pci 0000:00:11.0: reg 14 io port: [0xfe00-0xfe03]
Jan  3 16:20:41 cfhat12 kernel: [    0.355409] pci 0000:00:11.0: reg 18 io port: [0xfd00-0xfd07]
Jan  3 16:20:41 cfhat12 kernel: [    0.355413] pci 0000:00:11.0: reg 1c io port: [0xfc00-0xfc03]
Jan  3 16:20:41 cfhat12 kernel: [    0.355417] pci 0000:00:11.0: reg 20 io port: [0xfb00-0xfb0f]
Jan  3 16:20:41 cfhat12 kernel: [    0.355422] pci 0000:00:11.0: reg 24 32bit mmio: [0xfe02f000-0xfe02f3ff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355433] pci 0000:00:11.0: set SATA to AHCI mode
Jan  3 16:20:41 cfhat12 kernel: [    0.355471] pci 0000:00:12.0: reg 10 32bit mmio: [0xfe02e000-0xfe02efff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355520] pci 0000:00:12.2: reg 10 32bit mmio: [0xfe02d000-0xfe02d0ff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355555] pci 0000:00:12.2: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.355556] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:20:41 cfhat12 kernel: [    0.355558] pci 0000:00:12.2: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.355579] pci 0000:00:13.0: reg 10 32bit mmio: [0xfe02c000-0xfe02cfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355629] pci 0000:00:13.2: reg 10 32bit mmio: [0xfe02b000-0xfe02b0ff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355663] pci 0000:00:13.2: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.355664] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:20:41 cfhat12 kernel: [    0.355667] pci 0000:00:13.2: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.355721] pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
Jan  3 16:20:41 cfhat12 kernel: [    0.355725] pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
Jan  3 16:20:41 cfhat12 kernel: [    0.355729] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
Jan  3 16:20:41 cfhat12 kernel: [    0.355734] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
Jan  3 16:20:41 cfhat12 kernel: [    0.355738] pci 0000:00:14.1: reg 20 io port: [0xfa00-0xfa0f]
Jan  3 16:20:41 cfhat12 kernel: [    0.355818] pci 0000:00:14.5: reg 10 32bit mmio: [0xfe02a000-0xfe02afff]
Jan  3 16:20:41 cfhat12 kernel: [    0.355882] pci 0000:00:15.0: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.355928] pci 0000:00:15.1: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.355954] pci 0000:00:16.0: reg 10 32bit mmio: [0xfe029000-0xfe029fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356032] pci 0000:00:16.2: reg 10 32bit mmio: [0xfe028000-0xfe0280ff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356067] pci 0000:00:16.2: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.356068] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  3 16:20:41 cfhat12 kernel: [    0.356070] pci 0000:00:16.2: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.356145] pci 0000:01:05.0: reg 10 32bit mmio pref: [0xd0000000-0xdfffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356147] pci 0000:01:05.0: reg 14 io port: [0xce00-0xceff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356150] pci 0000:01:05.0: reg 18 32bit mmio: [0xfd3e0000-0xfd3effff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356155] pci 0000:01:05.0: reg 24 32bit mmio: [0xfd200000-0xfd2fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356163] pci 0000:01:05.0: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.356177] pci 0000:01:05.1: reg 10 32bit mmio: [0xfd3fc000-0xfd3fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356191] pci 0000:01:05.1: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.356220] pci 0000:00:01.0: bridge io port: [0xc000-0xcfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356222] pci 0000:00:01.0: bridge 32bit mmio: [0xfd200000-0xfd3fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356224] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356272] pci 0000:02:00.0: reg 10 32bit mmio: [0xfdfc0000-0xfdfdffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356280] pci 0000:02:00.0: reg 14 32bit mmio: [0xfdf00000-0xfdf7ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356289] pci 0000:02:00.0: reg 18 io port: [0xbf00-0xbf1f]
Jan  3 16:20:41 cfhat12 kernel: [    0.356297] pci 0000:02:00.0: reg 1c 32bit mmio: [0xfdffc000-0xfdffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356319] pci 0000:02:00.0: reg 30 32bit mmio pref: [0x000000-0x03ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.356359] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.356364] pci 0000:02:00.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.364087] pci 0000:00:07.0: bridge io port: [0xb000-0xbfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.364090] pci 0000:00:07.0: bridge 32bit mmio: [0xfdf00000-0xfdffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.364093] pci 0000:00:07.0: bridge 64bit mmio pref: [0xfde00000-0xfdefffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.364128] pci 0000:03:00.0: reg 10 64bit mmio: [0xfddfe000-0xfddfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.364168] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.364171] pci 0000:03:00.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.372071] pci 0000:00:09.0: bridge io port: [0xe000-0xefff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372073] pci 0000:00:09.0: bridge 32bit mmio: [0xfdd00000-0xfddfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372076] pci 0000:00:09.0: bridge 64bit mmio pref: [0xfdc00000-0xfdcfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372107] pci 0000:04:00.0: reg 10 io port: [0xde00-0xdeff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372120] pci 0000:04:00.0: reg 18 64bit mmio pref: [0xfd4ff000-0xfd4fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372129] pci 0000:04:00.0: reg 20 64bit mmio pref: [0xfd4f8000-0xfd4fbfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372134] pci 0000:04:00.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.372160] pci 0000:04:00.0: supports D1 D2
Jan  3 16:20:41 cfhat12 kernel: [    0.372161] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  3 16:20:41 cfhat12 kernel: [    0.372164] pci 0000:04:00.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.380068] pci 0000:00:0a.0: bridge io port: [0xd000-0xdfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380071] pci 0000:00:0a.0: bridge 32bit mmio: [0xfd900000-0xfd9fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380073] pci 0000:00:0a.0: bridge 64bit mmio pref: [0xfd400000-0xfd4fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380104] pci 0000:05:06.0: reg 10 io port: [0xaf00-0xaf07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380110] pci 0000:05:06.0: reg 14 io port: [0xae00-0xae07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380117] pci 0000:05:06.0: reg 18 io port: [0xad00-0xad07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380123] pci 0000:05:06.0: reg 1c io port: [0xac00-0xac07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380164] pci 0000:05:06.1: reg 10 io port: [0xab00-0xab07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380170] pci 0000:05:06.1: reg 14 io port: [0xaa00-0xaa07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380177] pci 0000:05:06.1: reg 18 io port: [0xa900-0xa907]
Jan  3 16:20:41 cfhat12 kernel: [    0.380183] pci 0000:05:06.1: reg 1c io port: [0xa800-0xa807]
Jan  3 16:20:41 cfhat12 kernel: [    0.380229] pci 0000:05:08.0: reg 10 io port: [0xa700-0xa707]
Jan  3 16:20:41 cfhat12 kernel: [    0.380292] pci 0000:00:14.4: transparent bridge
Jan  3 16:20:41 cfhat12 kernel: [    0.380294] pci 0000:00:14.4: bridge io port: [0xa000-0xafff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380297] pci 0000:00:14.4: bridge 32bit mmio: [0xfdb00000-0xfdbfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380300] pci 0000:00:14.4: bridge 32bit mmio pref: [0xfda00000-0xfdafffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380378] pci 0000:06:00.0: reg 24 32bit mmio: [0xfd8fe000-0xfd8fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380411] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 16:20:41 cfhat12 kernel: [    0.380415] pci 0000:06:00.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.380465] pci 0000:06:00.1: reg 10 io port: [0x9f00-0x9f07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380472] pci 0000:06:00.1: reg 14 io port: [0x9e00-0x9e03]
Jan  3 16:20:41 cfhat12 kernel: [    0.380480] pci 0000:06:00.1: reg 18 io port: [0x9d00-0x9d07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380487] pci 0000:06:00.1: reg 1c io port: [0x9c00-0x9c03]
Jan  3 16:20:41 cfhat12 kernel: [    0.380494] pci 0000:06:00.1: reg 20 io port: [0x9b00-0x9b0f]
Jan  3 16:20:41 cfhat12 kernel: [    0.380555] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  3 16:20:41 cfhat12 kernel: [    0.380617] pci 0000:00:15.0: bridge io port: [0x9000-0x9fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380619] pci 0000:00:15.0: bridge 32bit mmio: [0xfd800000-0xfd8fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380623] pci 0000:00:15.0: bridge 64bit mmio pref: [0xfd700000-0xfd7fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380747] pci 0000:07:00.0: supports D1
Jan  3 16:20:41 cfhat12 kernel: [    0.380748] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 16:20:41 cfhat12 kernel: [    0.380753] pci 0000:07:00.0: PME# disabled
Jan  3 16:20:41 cfhat12 kernel: [    0.380789] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  3 16:20:41 cfhat12 kernel: [    0.380855] pci 0000:00:15.1: bridge io port: [0x8000-0x8fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380857] pci 0000:00:15.1: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380861] pci 0000:00:15.1: bridge 64bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.380897] pci 0000:08:00.0: reg 10 io port: [0x8f00-0x8f07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380906] pci 0000:08:00.0: reg 14 io port: [0x8e00-0x8e07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380916] pci 0000:08:00.0: reg 18 io port: [0x8d00-0x8d07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380926] pci 0000:08:00.0: reg 1c io port: [0x8c00-0x8c07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380936] pci 0000:08:00.0: reg 20 io port: [0x8b00-0x8b07]
Jan  3 16:20:41 cfhat12 kernel: [    0.380946] pci 0000:08:00.0: reg 24 io port: [0x8a00-0x8a0f]
Jan  3 16:20:41 cfhat12 kernel: [    0.381039] pci 0000:07:00.0: bridge io port: [0x8000-0x8fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.381044] pci 0000:07:00.0: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.381049] pci 0000:07:00.0: bridge 32bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.381077] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381281] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381316] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381424] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381456] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381487] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.381522] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 16:20:41 cfhat12 kernel: [    0.395718] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.395782] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.395844] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.395904] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.395965] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.396046] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.396107] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.396168] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 16:20:41 cfhat12 kernel: [    0.396229] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 16:20:41 cfhat12 kernel: [    0.396233] vgaarb: loaded
Jan  3 16:20:41 cfhat12 kernel: [    0.396246] PCI: Using ACPI for IRQ routing
Jan  3 16:20:41 cfhat12 kernel: [    0.396246] pci 0000:00:00.0: BAR 3: address space collision on of device [0xe0000000-0xffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.396246] pci 0000:00:00.0: BAR 3: can't allocate resource
Jan  3 16:20:41 cfhat12 kernel: [    0.396246] Switching to clocksource tsc
Jan  3 16:20:41 cfhat12 kernel: [    0.396598] pnp: PnP ACPI init
Jan  3 16:20:41 cfhat12 kernel: [    0.396605] ACPI: bus type pnp registered
Jan  3 16:20:41 cfhat12 kernel: [    0.398124] pnp 00:0a: mem resource (0xd1000-0xd3fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398126] pnp 00:0a: mem resource (0xf0000-0xf7fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398128] pnp 00:0a: mem resource (0xf8000-0xfbfff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398130] pnp 00:0a: mem resource (0xfc000-0xfffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398132] pnp 00:0a: mem resource (0x0-0x9ffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398134] pnp 00:0a: mem resource (0x100000-0xcfdeffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  3 16:20:41 cfhat12 kernel: [    0.398196] pnp: PnP ACPI: found 11 devices
Jan  3 16:20:41 cfhat12 kernel: [    0.398197] ACPI: ACPI bus type pnp unregistered
Jan  3 16:20:41 cfhat12 kernel: [    0.398203] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398204] system 00:01: ioport range 0x220-0x225 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398206] system 00:01: ioport range 0x290-0x294 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398209] system 00:02: ioport range 0x4100-0x411f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398210] system 00:02: ioport range 0x228-0x22f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398212] system 00:02: ioport range 0x40b-0x40b has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398213] system 00:02: ioport range 0x4d6-0x4d6 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398215] system 00:02: ioport range 0xc00-0xc01 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398216] system 00:02: ioport range 0xc14-0xc14 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398218] system 00:02: ioport range 0xc50-0xc52 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398219] system 00:02: ioport range 0xc6c-0xc6d has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398221] system 00:02: ioport range 0xc6f-0xc6f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398222] system 00:02: ioport range 0xcd0-0xcd1 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398224] system 00:02: ioport range 0xcd2-0xcd3 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398225] system 00:02: ioport range 0xcd4-0xcdf has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398227] system 00:02: ioport range 0x4000-0x40fe has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398229] system 00:02: ioport range 0x4210-0x4217 has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398230] system 00:02: ioport range 0xb00-0xb0f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398232] system 00:02: ioport range 0xb10-0xb1f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398233] system 00:02: ioport range 0xb20-0xb3f has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398237] system 00:09: iomem range 0xe0000000-0xefffffff has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398240] system 00:0a: iomem range 0xcfdf0000-0xcfdfffff could not be reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398242] system 00:0a: iomem range 0xffff0000-0xffffffff has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398244] system 00:0a: iomem range 0xcfe00000-0xcfefffff has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398246] system 00:0a: iomem range 0xcff00000-0xcfffffff could not be reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398247] system 00:0a: iomem range 0xfec00000-0xfec00fff could not be reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398249] system 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.398251] system 00:0a: iomem range 0xfff80000-0xfffeffff has been reserved
Jan  3 16:20:41 cfhat12 kernel: [    0.402928] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
Jan  3 16:20:41 cfhat12 kernel: [    0.402930] pci 0000:00:01.0:   IO window: 0xc000-0xcfff
Jan  3 16:20:41 cfhat12 kernel: [    0.402932] pci 0000:00:01.0:   MEM window: 0xfd200000-0xfd3fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402934] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402938] pci 0000:00:07.0: PCI bridge, secondary bus 0000:02
Jan  3 16:20:41 cfhat12 kernel: [    0.402940] pci 0000:00:07.0:   IO window: 0xb000-0xbfff
Jan  3 16:20:41 cfhat12 kernel: [    0.402942] pci 0000:00:07.0:   MEM window: 0xfdf00000-0xfdffffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402944] pci 0000:00:07.0:   PREFETCH window: 0x000000fde00000-0x000000fdefffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402946] pci 0000:00:09.0: PCI bridge, secondary bus 0000:03
Jan  3 16:20:41 cfhat12 kernel: [    0.402948] pci 0000:00:09.0:   IO window: 0xe000-0xefff
Jan  3 16:20:41 cfhat12 kernel: [    0.402950] pci 0000:00:09.0:   MEM window: 0xfdd00000-0xfddfffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402951] pci 0000:00:09.0:   PREFETCH window: 0x000000fdc00000-0x000000fdcfffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402954] pci 0000:00:0a.0: PCI bridge, secondary bus 0000:04
Jan  3 16:20:41 cfhat12 kernel: [    0.402955] pci 0000:00:0a.0:   IO window: 0xd000-0xdfff
Jan  3 16:20:41 cfhat12 kernel: [    0.402957] pci 0000:00:0a.0:   MEM window: 0xfd900000-0xfd9fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402959] pci 0000:00:0a.0:   PREFETCH window: 0x000000fd400000-0x000000fd4fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402962] pci 0000:00:14.4: PCI bridge, secondary bus 0000:05
Jan  3 16:20:41 cfhat12 kernel: [    0.402964] pci 0000:00:14.4:   IO window: 0xa000-0xafff
Jan  3 16:20:41 cfhat12 kernel: [    0.402967] pci 0000:00:14.4:   MEM window: 0xfdb00000-0xfdbfffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402970] pci 0000:00:14.4:   PREFETCH window: 0xfda00000-0xfdafffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402974] pci 0000:00:15.0: PCI bridge, secondary bus 0000:06
Jan  3 16:20:41 cfhat12 kernel: [    0.402976] pci 0000:00:15.0:   IO window: 0x9000-0x9fff
Jan  3 16:20:41 cfhat12 kernel: [    0.402979] pci 0000:00:15.0:   MEM window: 0xfd800000-0xfd8fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402981] pci 0000:00:15.0:   PREFETCH window: 0x000000fd700000-0x000000fd7fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.402985] pci 0000:07:00.0: PCI bridge, secondary bus 0000:08
Jan  3 16:20:41 cfhat12 kernel: [    0.402988] pci 0000:07:00.0:   IO window: 0x8000-0x8fff
Jan  3 16:20:41 cfhat12 kernel: [    0.402995] pci 0000:07:00.0:   MEM window: 0xfd600000-0xfd6fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.403000] pci 0000:07:00.0:   PREFETCH window: 0xfd500000-0xfd5fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.403009] pci 0000:00:15.1: PCI bridge, secondary bus 0000:07
Jan  3 16:20:41 cfhat12 kernel: [    0.403011] pci 0000:00:15.1:   IO window: 0x8000-0x8fff
Jan  3 16:20:41 cfhat12 kernel: [    0.403014] pci 0000:00:15.1:   MEM window: 0xfd600000-0xfd6fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.403016] pci 0000:00:15.1:   PREFETCH window: 0x000000fd500000-0x000000fd5fffff
Jan  3 16:20:41 cfhat12 kernel: [    0.403025]   alloc irq_desc for 19 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403027]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403033] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:20:41 cfhat12 kernel: [    0.403034] pci 0000:00:07.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403038]   alloc irq_desc for 17 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403039]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403043] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.403045] pci 0000:00:09.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403048]   alloc irq_desc for 18 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403049]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.403053] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.403055] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403063] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.403065] pci 0000:00:15.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403070] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.403072] pci 0000:00:15.1: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403083] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.403088] pci 0000:07:00.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.403091] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403093] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403094] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403095] pci_bus 0000:01: resource 1 mem: [0xfd200000-0xfd3fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403097] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403098] pci_bus 0000:02: resource 0 io:  [0xb000-0xbfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403100] pci_bus 0000:02: resource 1 mem: [0xfdf00000-0xfdffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403101] pci_bus 0000:02: resource 2 pref mem [0xfde00000-0xfdefffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403102] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403104] pci_bus 0000:03: resource 1 mem: [0xfdd00000-0xfddfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403105] pci_bus 0000:03: resource 2 pref mem [0xfdc00000-0xfdcfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403106] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403107] pci_bus 0000:04: resource 1 mem: [0xfd900000-0xfd9fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403109] pci_bus 0000:04: resource 2 pref mem [0xfd400000-0xfd4fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403110] pci_bus 0000:05: resource 0 io:  [0xa000-0xafff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403111] pci_bus 0000:05: resource 1 mem: [0xfdb00000-0xfdbfffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403113] pci_bus 0000:05: resource 2 pref mem [0xfda00000-0xfdafffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403114] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403115] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403117] pci_bus 0000:06: resource 0 io:  [0x9000-0x9fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403118] pci_bus 0000:06: resource 1 mem: [0xfd800000-0xfd8fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403119] pci_bus 0000:06: resource 2 pref mem [0xfd700000-0xfd7fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403121] pci_bus 0000:07: resource 0 io:  [0x8000-0x8fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403122] pci_bus 0000:07: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403123] pci_bus 0000:07: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403125] pci_bus 0000:08: resource 0 io:  [0x8000-0x8fff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403126] pci_bus 0000:08: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403127] pci_bus 0000:08: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  3 16:20:41 cfhat12 kernel: [    0.403146] NET: Registered protocol family 2
Jan  3 16:20:41 cfhat12 kernel: [    0.403286] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.404104] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.405917] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.406152] TCP: Hash tables configured (established 524288 bind 65536)
Jan  3 16:20:41 cfhat12 kernel: [    0.406154] TCP reno registered
Jan  3 16:20:41 cfhat12 kernel: [    0.406228] NET: Registered protocol family 1
Jan  3 16:20:41 cfhat12 kernel: [    0.467547] pci 0000:01:05.0: Boot video device
Jan  3 16:20:41 cfhat12 kernel: [    0.467605] Unpacking initramfs...
Jan  3 16:20:41 cfhat12 kernel: [    0.592639] Freeing initrd memory: 9223k freed
Jan  3 16:20:41 cfhat12 kernel: [    0.595571] PCI-DMA: Disabling AGP.
Jan  3 16:20:41 cfhat12 kernel: [    0.595636] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 16:20:41 cfhat12 kernel: [    0.595637] PCI-DMA: using GART IOMMU.
Jan  3 16:20:41 cfhat12 kernel: [    0.595639] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 16:20:41 cfhat12 kernel: [    0.597414] audit: initializing netlink socket (disabled)
Jan  3 16:20:41 cfhat12 kernel: [    0.597427] type=2000 audit(1294089629.595:1): initialized
Jan  3 16:20:41 cfhat12 kernel: [    0.599668] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  3 16:20:41 cfhat12 kernel: [    0.600497] VFS: Disk quotas dquot_6.5.2
Jan  3 16:20:41 cfhat12 kernel: [    0.600527] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 16:20:41 cfhat12 kernel: [    0.600570] msgmni has been set to 14999
Jan  3 16:20:41 cfhat12 kernel: [    0.600734] alg: No test for stdrng (krng)
Jan  3 16:20:41 cfhat12 kernel: [    0.600762] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  3 16:20:41 cfhat12 kernel: [    0.600763] io scheduler noop registered
Jan  3 16:20:41 cfhat12 kernel: [    0.600764] io scheduler anticipatory registered
Jan  3 16:20:41 cfhat12 kernel: [    0.600765] io scheduler deadline registered
Jan  3 16:20:41 cfhat12 kernel: [    0.600784] io scheduler cfq registered (default)
Jan  3 16:20:41 cfhat12 kernel: [    0.600903]   alloc irq_desc for 24 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.600905]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.600911] pcieport 0000:00:07.0: irq 24 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.600915] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.600985]   alloc irq_desc for 25 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.600986]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.600989] pcieport 0000:00:09.0: irq 25 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.600992] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.601058]   alloc irq_desc for 26 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601059]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601062] pcieport 0000:00:0a.0: irq 26 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.601064] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.601149]   alloc irq_desc for 27 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601150]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601155] pcieport 0000:00:15.0: irq 27 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.601160] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.601255]   alloc irq_desc for 28 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601256]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.601261] pcieport 0000:00:15.1: irq 28 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.601266] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.602012] Linux agpgart interface v0.103
Jan  3 16:20:41 cfhat12 kernel: [    0.602039] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  3 16:20:41 cfhat12 kernel: [    0.602119] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 16:20:41 cfhat12 kernel: [    0.602313] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 16:20:41 cfhat12 kernel: [    0.602408]   alloc irq_desc for 20 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.602410]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.602417] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 16:20:41 cfhat12 kernel: [    0.602519] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 16:20:41 cfhat12 kernel: [    0.602605] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 16:20:41 cfhat12 kernel: [    0.602682] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 16:20:41 cfhat12 kernel: [    0.602694] Couldn't register serial port 0000:05:06.0: -28
Jan  3 16:20:41 cfhat12 kernel: [    0.602720] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 16:20:41 cfhat12 kernel: [    0.602722] Couldn't register serial port 0000:05:06.1: -28
Jan  3 16:20:41 cfhat12 kernel: [    0.602771] input: Macintosh mouse button emulation as /devices/virtual/input/input0
Jan  3 16:20:41 cfhat12 kernel: [    0.602798] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 16:20:41 cfhat12 kernel: [    0.602799] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 16:20:41 cfhat12 kernel: [    0.602909] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 16:20:41 cfhat12 kernel: [    0.602953] mice: PS/2 mouse device common for all mice
Jan  3 16:20:41 cfhat12 kernel: [    0.602980] rtc_cmos 00:04: RTC can wake from S4
Jan  3 16:20:41 cfhat12 kernel: [    0.602999] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 16:20:41 cfhat12 kernel: [    0.603018] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 16:20:41 cfhat12 kernel: [    0.603025] cpuidle: using governor ladder
Jan  3 16:20:41 cfhat12 kernel: [    0.603026] cpuidle: using governor menu
Jan  3 16:20:41 cfhat12 kernel: [    0.603029] No iBFT detected.
Jan  3 16:20:41 cfhat12 kernel: [    0.603211] TCP cubic registered
Jan  3 16:20:41 cfhat12 kernel: [    0.603270] NET: Registered protocol family 10
Jan  3 16:20:41 cfhat12 kernel: [    0.603557] lo: Disabled Privacy Extensions
Jan  3 16:20:41 cfhat12 kernel: [    0.603713] Mobile IPv6
Jan  3 16:20:41 cfhat12 kernel: [    0.603714] NET: Registered protocol family 17
Jan  3 16:20:41 cfhat12 kernel: [    0.603764] PM: Resume from disk failed.
Jan  3 16:20:41 cfhat12 kernel: [    0.603769] registered taskstats version 1
Jan  3 16:20:41 cfhat12 kernel: [    0.604195] rtc_cmos 00:04: setting system clock to 2011-01-03 21:20:30 UTC (1294089630)
Jan  3 16:20:41 cfhat12 kernel: [    0.604212] Initalizing network drop monitor service
Jan  3 16:20:41 cfhat12 kernel: [    0.604227] Freeing unused kernel memory: 592k freed
Jan  3 16:20:41 cfhat12 kernel: [    0.604327] Write protecting the kernel read-only data: 4232k
Jan  3 16:20:41 cfhat12 kernel: [    0.614234] udev[121]: starting version 164
Jan  3 16:20:41 cfhat12 kernel: [    0.646864] usbcore: registered new interface driver usbfs
Jan  3 16:20:41 cfhat12 kernel: [    0.646882] usbcore: registered new interface driver hub
Jan  3 16:20:41 cfhat12 kernel: [    0.647001] usbcore: registered new device driver usb
Jan  3 16:20:41 cfhat12 kernel: [    0.648860] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 16:20:41 cfhat12 kernel: [    0.648878] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.648918] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.648947]   alloc irq_desc for 29 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.648949]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.648960] r8169 0000:04:00.0: irq 29 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.649302] eth0: RTL8168d/8111d at 0xffffc90000c6c000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 29
Jan  3 16:20:41 cfhat12 kernel: [    0.650051] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
Jan  3 16:20:41 cfhat12 kernel: [    0.650053] e1000e: Copyright (c) 1999-2008 Intel Corporation.
Jan  3 16:20:41 cfhat12 kernel: [    0.654237] r8169 0000:04:00.0: firmware: requesting rtl8168d-2.fw
Jan  3 16:20:41 cfhat12 kernel: [    0.654279] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:20:41 cfhat12 kernel: [    0.654302] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.654438]   alloc irq_desc for 30 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654438]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654441] e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.654442]   alloc irq_desc for 31 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654443]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654445] e1000e 0000:02:00.0: irq 31 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.654446]   alloc irq_desc for 32 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654447]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.654449] e1000e 0000:02:00.0: irq 32 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.655545] SCSI subsystem initialized
Jan  3 16:20:41 cfhat12 kernel: [    0.655732] eth0: unable to apply firmware patch
Jan  3 16:20:41 cfhat12 kernel: [    0.659547] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Jan  3 16:20:41 cfhat12 kernel: [    0.663378] libata version 3.00 loaded.
Jan  3 16:20:41 cfhat12 kernel: [    0.665341] ahci 0000:00:11.0: version 3.0
Jan  3 16:20:41 cfhat12 kernel: [    0.665350] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:20:41 cfhat12 kernel: [    0.665388]   alloc irq_desc for 33 on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.665389]   alloc kstat_irqs on node 0
Jan  3 16:20:41 cfhat12 kernel: [    0.665397] ahci 0000:00:11.0: irq 33 for MSI/MSI-X
Jan  3 16:20:41 cfhat12 kernel: [    0.665457] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 16:20:41 cfhat12 kernel: [    0.665459] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 16:20:41 cfhat12 kernel: [    0.665631] scsi0 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.665692] scsi1 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.665727] scsi2 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.665762] scsi3 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.665833] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 33
Jan  3 16:20:41 cfhat12 kernel: [    0.665835] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 33
Jan  3 16:20:41 cfhat12 kernel: [    0.665837] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 33
Jan  3 16:20:41 cfhat12 kernel: [    0.665840] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 33
Jan  3 16:20:41 cfhat12 kernel: [    0.665914] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.666032] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.666095] scsi4 : pata_atiixp
Jan  3 16:20:41 cfhat12 kernel: [    0.666136] scsi5 : pata_atiixp
Jan  3 16:20:41 cfhat12 kernel: [    0.666823] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 16:20:41 cfhat12 kernel: [    0.666825] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 16:20:41 cfhat12 kernel: [    0.667112] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 16:20:41 cfhat12 kernel: [    0.667856] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.667875] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.667891] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 16:20:41 cfhat12 kernel: [    0.667913] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 16:20:41 cfhat12 kernel: [    0.667932] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 16:20:41 cfhat12 kernel: [    0.668531] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.668546] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.668548] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.668557] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
Jan  3 16:20:41 cfhat12 kernel: [    0.668653] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 16:20:41 cfhat12 kernel: [    0.669242] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 16:20:41 cfhat12 kernel: [    0.672155] usb usb2: config 1 interface 0 altsetting 0 endpoint 0x81 has no SuperSpeed companion descriptor
Jan  3 16:20:41 cfhat12 kernel: [    0.672161] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
Jan  3 16:20:41 cfhat12 kernel: [    0.672162] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.672164] usb usb2: Product: xHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.672165] usb usb2: Manufacturer: Linux 2.6.32-5-amd64 xhci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.672166] usb usb2: SerialNumber: 0000:03:00.0
Jan  3 16:20:41 cfhat12 kernel: [    0.672220] usb usb2: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.672222] xHCI xhci_add_endpoint called for root hub
Jan  3 16:20:41 cfhat12 kernel: [    0.672223] xHCI xhci_check_bandwidth called for root hub
Jan  3 16:20:41 cfhat12 kernel: [    0.672243] hub 2-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.672247] hub 2-0:1.0: 4 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.679551] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 16:20:41 cfhat12 kernel: [    0.679554] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 16:20:41 cfhat12 kernel: [    0.679559] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.679643] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 16:20:41 cfhat12 kernel: [    0.679653] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 16:20:41 cfhat12 kernel: [    0.679655] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.679656] usb usb1: Product: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.679658] usb usb1: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.679659] usb usb1: SerialNumber: 0000:00:12.2
Jan  3 16:20:41 cfhat12 kernel: [    0.679699] usb usb1: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.679717] hub 1-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.679720] hub 1-0:1.0: 5 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.679882] scsi6 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.679917] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.679924] scsi7 : ahci
Jan  3 16:20:41 cfhat12 kernel: [    0.679950] ata7: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 16:20:41 cfhat12 kernel: [    0.679952] ata8: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 16:20:41 cfhat12 kernel: [    0.679996] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.680004] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 3
Jan  3 16:20:41 cfhat12 kernel: [    0.680025] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 16:20:41 cfhat12 kernel: [    0.680042] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 16:20:41 cfhat12 kernel: [    0.680047] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.680067] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    0.680125] scsi8 : pata_jmicron
Jan  3 16:20:41 cfhat12 kernel: [    0.680167] scsi9 : pata_jmicron
Jan  3 16:20:41 cfhat12 kernel: [    0.680188] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 16:20:41 cfhat12 kernel: [    0.680189] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 16:20:41 cfhat12 kernel: [    0.739524] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 16:20:41 cfhat12 kernel: [    0.739526] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.739528] usb usb3: Product: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.739529] usb usb3: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.739530] usb usb3: SerialNumber: 0000:00:12.0
Jan  3 16:20:41 cfhat12 kernel: [    0.739570] usb usb3: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.739587] hub 3-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.739593] hub 3-0:1.0: 5 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.739760] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.739770] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.739776] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
Jan  3 16:20:41 cfhat12 kernel: [    0.739796] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 16:20:41 cfhat12 kernel: [    0.739806] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 16:20:41 cfhat12 kernel: [    0.751538] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 16:20:41 cfhat12 kernel: [    0.751549] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 16:20:41 cfhat12 kernel: [    0.751551] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.751552] usb usb4: Product: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.751553] usb usb4: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.751554] usb usb4: SerialNumber: 0000:00:13.2
Jan  3 16:20:41 cfhat12 kernel: [    0.751594] usb usb4: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.751608] hub 4-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.751612] hub 4-0:1.0: 5 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.751677] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.751688] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.751693] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 16:20:41 cfhat12 kernel: [    0.751707] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 16:20:41 cfhat12 kernel: [    0.768833] 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 16:20:41 cfhat12 kernel: [    0.768835] 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 16:20:41 cfhat12 kernel: [    0.768846] 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 16:20:41 cfhat12 kernel: [    0.811660] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 16:20:41 cfhat12 kernel: [    0.811661] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.811663] usb usb5: Product: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.811664] usb usb5: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.811665] usb usb5: SerialNumber: 0000:00:13.0
Jan  3 16:20:41 cfhat12 kernel: [    0.811707] usb usb5: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.811722] hub 5-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.811728] hub 5-0:1.0: 5 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.811801] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    0.811812] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.811817] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 6
Jan  3 16:20:41 cfhat12 kernel: [    0.811837] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 16:20:41 cfhat12 kernel: [    0.811848] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 16:20:41 cfhat12 kernel: [    0.823673] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 16:20:41 cfhat12 kernel: [    0.823687] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
Jan  3 16:20:41 cfhat12 kernel: [    0.823689] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.823690] usb usb6: Product: EHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.823691] usb usb6: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.823692] usb usb6: SerialNumber: 0000:00:16.2
Jan  3 16:20:41 cfhat12 kernel: [    0.823730] usb usb6: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.823745] hub 6-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.823749] hub 6-0:1.0: 4 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.823843] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.823854] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.823860] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
Jan  3 16:20:41 cfhat12 kernel: [    0.823872] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 16:20:41 cfhat12 kernel: [    0.835849] ata5.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 16:20:41 cfhat12 kernel: [    0.835862] ata5.00: limited to UDMA/33 due to 40-wire cable
Jan  3 16:20:41 cfhat12 kernel: [    0.851818] ata5.00: configured for UDMA/33
Jan  3 16:20:41 cfhat12 kernel: [    0.883673] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 16:20:41 cfhat12 kernel: [    0.883675] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.883677] usb usb7: Product: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.883678] usb usb7: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.883679] usb usb7: SerialNumber: 0000:00:14.5
Jan  3 16:20:41 cfhat12 kernel: [    0.883724] usb usb7: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.883739] hub 7-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.883745] hub 7-0:1.0: 2 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.883809] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    0.883821] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.883827] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 8
Jan  3 16:20:41 cfhat12 kernel: [    0.883840] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 16:20:41 cfhat12 kernel: [    0.943680] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Jan  3 16:20:41 cfhat12 kernel: [    0.943682] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  3 16:20:41 cfhat12 kernel: [    0.943683] usb usb8: Product: OHCI Host Controller
Jan  3 16:20:41 cfhat12 kernel: [    0.943684] usb usb8: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  3 16:20:41 cfhat12 kernel: [    0.943685] usb usb8: SerialNumber: 0000:00:16.0
Jan  3 16:20:41 cfhat12 kernel: [    0.943724] usb usb8: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    0.943741] hub 8-0:1.0: USB hub found
Jan  3 16:20:41 cfhat12 kernel: [    0.943747] hub 8-0:1.0: 4 ports detected
Jan  3 16:20:41 cfhat12 kernel: [    0.983596] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    0.983624] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    0.999598] ata7: SATA link down (SStatus 0 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    0.999623] ata8: SATA link down (SStatus 0 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    1.147607] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    1.148937] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 16:20:41 cfhat12 kernel: [    1.148939] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 16:20:41 cfhat12 kernel: [    1.150500] ata1.00: configured for UDMA/133
Jan  3 16:20:41 cfhat12 kernel: [    1.167665] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 16:20:41 cfhat12 kernel: [    1.203629] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 16:20:41 cfhat12 kernel: [    1.206479] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 16:20:41 cfhat12 kernel: [    1.206481] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 16:20:41 cfhat12 kernel: [    1.209557] ata2.00: configured for UDMA/133
Jan  3 16:20:41 cfhat12 kernel: [    1.227670] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 16:20:41 cfhat12 kernel: [    1.228515] scsi 4:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 16:20:41 cfhat12 kernel: [    1.230223] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 16:20:41 cfhat12 kernel: [    1.230272] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 16:20:41 cfhat12 kernel: [    1.230275] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 16:20:41 cfhat12 kernel: [    1.230291] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 16:20:41 cfhat12 kernel: [    1.230311] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 16:20:41 cfhat12 kernel: [    1.230345] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 16:20:41 cfhat12 kernel: [    1.230347] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 16:20:41 cfhat12 kernel: [    1.230378] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 16:20:41 cfhat12 kernel: [    1.230472]  sda:
Jan  3 16:20:41 cfhat12 kernel: [    1.230524]  sdb: sda1 sda2 sda3 sda4 < sdb1 sdb2 sdb3 sdb4 < sda5 sdb5 sda6 sdb6 sda7 >
Jan  3 16:20:41 cfhat12 kernel: [    1.266440] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 16:20:41 cfhat12 kernel: [    1.273923]  sdb7 >
Jan  3 16:20:41 cfhat12 kernel: [    1.274201] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 16:20:41 cfhat12 kernel: [    1.279623] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 16:20:41 cfhat12 kernel: [    1.449790] usb 5-1: New USB device found, idVendor=0d3d, idProduct=0001
Jan  3 16:20:41 cfhat12 kernel: [    1.449792] usb 5-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
Jan  3 16:20:41 cfhat12 kernel: [    1.449794] usb 5-1: Product: USBPS2
Jan  3 16:20:41 cfhat12 kernel: [    1.449839] usb 5-1: configuration #1 chosen from 1 choice
Jan  3 16:20:41 cfhat12 kernel: [    1.463378] usbcore: registered new interface driver hiddev
Jan  3 16:20:41 cfhat12 kernel: [    1.466925] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb5/5-1/5-1:1.0/input/input2
Jan  3 16:20:41 cfhat12 kernel: [    1.466951] generic-usb 0003:0D3D:0001.0001: input,hidraw0: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 16:20:41 cfhat12 kernel: [    1.473978] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb5/5-1/5-1:1.1/input/input3
Jan  3 16:20:41 cfhat12 kernel: [    1.474012] generic-usb 0003:0D3D:0001.0002: input,hidraw1: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 16:20:41 cfhat12 kernel: [    1.474023] usbcore: registered new interface driver usbhid
Jan  3 16:20:41 cfhat12 kernel: [    1.474024] usbhid: v2.6:USB HID core driver
Jan  3 16:20:41 cfhat12 kernel: [    1.569044] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 16:20:41 cfhat12 kernel: [    1.569047] Uniform CD-ROM driver Revision: 3.20
Jan  3 16:20:41 cfhat12 kernel: [    1.569111] sr 4:0:0:0: Attached scsi CD-ROM sr0
Jan  3 16:20:41 cfhat12 kernel: [    1.571094] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  3 16:20:41 cfhat12 kernel: [    1.571115] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  3 16:20:41 cfhat12 kernel: [    1.571136] sr 4:0:0:0: Attached scsi generic sg2 type 5
Jan  3 16:20:41 cfhat12 kernel: [    1.819900] md: raid1 personality registered for level 1
Jan  3 16:20:41 cfhat12 kernel: [    1.825903] md: md1 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    1.826854] md: bind<sdb1>
Jan  3 16:20:41 cfhat12 kernel: [    1.827045] md: bind<sda1>
Jan  3 16:20:41 cfhat12 kernel: [    1.827802] raid1: raid set md1 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    1.827820] md1: detected capacity change from 0 to 254791680
Jan  3 16:20:41 cfhat12 kernel: [    1.828357]  md1: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    2.032206] md: md2 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    2.032986] md: bind<sdb2>
Jan  3 16:20:41 cfhat12 kernel: [    2.033159] md: bind<sda2>
Jan  3 16:20:41 cfhat12 kernel: [    2.033894] raid1: raid set md2 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    2.033909] md2: detected capacity change from 0 to 19998367744
Jan  3 16:20:41 cfhat12 kernel: [    2.034391]  md2: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    2.238249] md: md3 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    2.239136] md: bind<sdb3>
Jan  3 16:20:41 cfhat12 kernel: [    2.239281] md: bind<sda3>
Jan  3 16:20:41 cfhat12 kernel: [    2.240023] raid1: raid set md3 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    2.240039] md3: detected capacity change from 0 to 1998573568
Jan  3 16:20:41 cfhat12 kernel: [    2.240531]  md3: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    2.444061] md: md5 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    2.444776] md: bind<sdb5>
Jan  3 16:20:41 cfhat12 kernel: [    2.444938] md: bind<sda5>
Jan  3 16:20:41 cfhat12 kernel: [    2.445680] raid1: raid set md5 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    2.445697] md5: detected capacity change from 0 to 19997319168
Jan  3 16:20:41 cfhat12 kernel: [    2.446208]  md5: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    2.662893] md: md6 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    2.663628] md: bind<sdb6>
Jan  3 16:20:41 cfhat12 kernel: [    2.663799] md: bind<sda6>
Jan  3 16:20:41 cfhat12 kernel: [    2.664514] raid1: raid set md6 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    2.664529] md6: detected capacity change from 0 to 19997319168
Jan  3 16:20:41 cfhat12 kernel: [    2.665017]  md6: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    2.880710] md: md7 stopped.
Jan  3 16:20:41 cfhat12 kernel: [    2.881444] md: bind<sdb7>
Jan  3 16:20:41 cfhat12 kernel: [    2.881621] md: bind<sda7>
Jan  3 16:20:41 cfhat12 kernel: [    2.882352] raid1: raid set md7 active with 2 out of 2 mirrors
Jan  3 16:20:41 cfhat12 kernel: [    2.882368] md7: detected capacity change from 0 to 97784881152
Jan  3 16:20:41 cfhat12 kernel: [    2.882860]  md7: unknown partition table
Jan  3 16:20:41 cfhat12 kernel: [    3.086526] PM: Starting manual resume from disk
Jan  3 16:20:41 cfhat12 kernel: [    3.086528] PM: Resume from partition 9:3
Jan  3 16:20:41 cfhat12 kernel: [    3.086529] PM: Checking hibernation image.
Jan  3 16:20:41 cfhat12 kernel: [    3.107829] PM: Error -22 checking image file
Jan  3 16:20:41 cfhat12 kernel: [    3.107831] PM: Resume from disk failed.
Jan  3 16:20:41 cfhat12 kernel: [    3.112844] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  3 16:20:41 cfhat12 kernel: [    3.113406] SGI XFS Quota Management subsystem
Jan  3 16:20:41 cfhat12 kernel: [    3.163423] XFS mounting filesystem md2
Jan  3 16:20:41 cfhat12 kernel: [    3.739974] Ending clean XFS mount for filesystem: md2
Jan  3 16:20:41 cfhat12 kernel: [    5.272916] udev[555]: starting version 164
Jan  3 16:20:41 cfhat12 kernel: [    5.565910] processor LNXCPU:00: registered as cooling_device0
Jan  3 16:20:41 cfhat12 kernel: [    5.565940] processor LNXCPU:01: registered as cooling_device1
Jan  3 16:20:41 cfhat12 kernel: [    5.565964] processor LNXCPU:02: registered as cooling_device2
Jan  3 16:20:41 cfhat12 kernel: [    5.565986] processor LNXCPU:03: registered as cooling_device3
Jan  3 16:20:41 cfhat12 kernel: [    5.566548] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
Jan  3 16:20:41 cfhat12 kernel: [    5.566554] ACPI: Power Button [PWRB]
Jan  3 16:20:41 cfhat12 kernel: [    5.566600] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
Jan  3 16:20:41 cfhat12 kernel: [    5.566602] ACPI: Power Button [PWRF]
Jan  3 16:20:41 cfhat12 kernel: [    5.583481] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan  3 16:20:41 cfhat12 kernel: [    5.585107] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 9602 ss_vid 0 ss_did 0
Jan  3 16:20:41 cfhat12 kernel: [    5.585109] shpchp 0000:00:01.0: Cannot reserve MMIO region
Jan  3 16:20:41 cfhat12 kernel: [    5.585218] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jan  3 16:20:41 cfhat12 kernel: [    5.639423] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 16:20:41 cfhat12 kernel: [    5.643440] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 16:20:41 cfhat12 kernel: [    5.643442] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 16:20:41 cfhat12 kernel: [    5.643443] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 16:20:41 cfhat12 kernel: [    5.643636] input: PC Speaker as /devices/platform/pcspkr/input/input6
Jan  3 16:20:41 cfhat12 kernel: [    5.644598] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 16:20:41 cfhat12 kernel: [    5.801679] ACPI: I/O resource piix4_smbus [0xb00-0xb07] conflicts with ACPI region SOR1 [0xb00-0xb0f]
Jan  3 16:20:41 cfhat12 kernel: [    5.801710] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 16:20:41 cfhat12 kernel: [    5.808694] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    5.808697] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    5.808775] parport0: PC-style at 0x8f00 (0x8e00), irq 17 [PCSPP,TRISTATE]
Jan  3 16:20:41 cfhat12 kernel: [    5.904091] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 16:20:41 cfhat12 kernel: [    5.904192] parport1: PC-style at 0x8d00 (0x8c00), irq 17 [PCSPP,TRISTATE]
Jan  3 16:20:41 cfhat12 kernel: [    5.916986] EDAC MC: Ver: 2.1.0 Dec 10 2010
Jan  3 16:20:41 cfhat12 kernel: [    6.134593] EDAC amd64_edac:  Ver: 3.2.0 Dec 10 2010
Jan  3 16:20:41 cfhat12 kernel: [    6.134660] EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:18.3).
Jan  3 16:20:41 cfhat12 kernel: [    6.134667] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
Jan  3 16:20:41 cfhat12 kernel: [    6.134668]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
Jan  3 16:20:41 cfhat12 kernel: [    6.134669]  (Note that use of the override may cause unknown side effects.)
Jan  3 16:20:41 cfhat12 kernel: [    6.134676] amd64_edac: probe of 0000:00:18.2 failed with error -22
Jan  3 16:20:41 cfhat12 kernel: [    6.147602] [drm] Initialized drm 1.1.0 20060810
Jan  3 16:20:41 cfhat12 kernel: [    6.362615] [drm] radeon kernel modesetting enabled.
Jan  3 16:20:41 cfhat12 kernel: [    6.362703] radeon 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 16:20:41 cfhat12 kernel: [    6.362706] radeon 0000:01:05.0: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    6.363845] [drm] radeon: Initializing kernel modesetting.
Jan  3 16:20:41 cfhat12 kernel: [    6.364022] [drm] register mmio base: 0xFD3E0000
Jan  3 16:20:41 cfhat12 kernel: [    6.364023] [drm] register mmio size: 65536
Jan  3 16:20:41 cfhat12 kernel: [    6.365973] ATOM BIOS: B43106_DVI
Jan  3 16:20:41 cfhat12 kernel: [    6.365983] [drm] Clocks initialized !
Jan  3 16:20:41 cfhat12 kernel: [    6.368081] [drm] Detected VRAM RAM=256M, BAR=256M
Jan  3 16:20:41 cfhat12 kernel: [    6.368083] [drm] RAM width 32bits DDR
Jan  3 16:20:41 cfhat12 kernel: [    6.368162] [TTM] Zone  kernel: Available graphics memory: 3840116 kiB.
Jan  3 16:20:41 cfhat12 kernel: [    6.368164] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
Jan  3 16:20:41 cfhat12 kernel: [    6.368178] [drm] radeon: 256M of VRAM memory ready
Jan  3 16:20:41 cfhat12 kernel: [    6.368179] [drm] radeon: 512M of GTT memory ready.
Jan  3 16:20:41 cfhat12 kernel: [    6.368202] [drm] radeon: irq initialized.
Jan  3 16:20:41 cfhat12 kernel: [    6.368204] [drm] GART: num cpu pages 131072, num gpu pages 131072
Jan  3 16:20:41 cfhat12 kernel: [    6.368548] [drm] Loading RS780 Microcode
Jan  3 16:20:41 cfhat12 kernel: [    6.368550] platform radeon_cp.0: firmware: requesting radeon/RS780_pfp.bin
Jan  3 16:20:41 cfhat12 kernel: [    6.410003] platform radeon_cp.0: firmware: requesting radeon/RS780_me.bin
Jan  3 16:20:41 cfhat12 kernel: [    6.460348] platform radeon_cp.0: firmware: requesting radeon/R600_rlc.bin
Jan  3 16:20:41 cfhat12 kernel: [    6.597573] r600_cp: Failed to load firmware "radeon/R600_rlc.bin"
Jan  3 16:20:41 cfhat12 kernel: [    6.597604] [drm:r600_startup] *ERROR* Failed to load firmware!
Jan  3 16:20:41 cfhat12 kernel: [    6.597631] radeon 0000:01:05.0: disabling GPU acceleration
Jan  3 16:20:41 cfhat12 kernel: [    6.597665] radeon 0000:01:05.0: ffff88020b7a8c00 unpin not necessary
Jan  3 16:20:41 cfhat12 kernel: [    6.597667] radeon 0000:01:05.0: ffff88020b7a8c00 unpin not necessary
Jan  3 16:20:41 cfhat12 kernel: [    6.597674] [drm] Enabling audio support
Jan  3 16:20:41 cfhat12 kernel: [    6.597749] [drm] Radeon Display Connectors
Jan  3 16:20:41 cfhat12 kernel: [    6.597750] [drm] Connector 0:
Jan  3 16:20:41 cfhat12 kernel: [    6.597751] [drm]   VGA
Jan  3 16:20:41 cfhat12 kernel: [    6.597753] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
Jan  3 16:20:41 cfhat12 kernel: [    6.597754] [drm]   Encoders:
Jan  3 16:20:41 cfhat12 kernel: [    6.597754] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Jan  3 16:20:41 cfhat12 kernel: [    6.597756] [drm] Connector 1:
Jan  3 16:20:41 cfhat12 kernel: [    6.597756] [drm]   DVI-D
Jan  3 16:20:41 cfhat12 kernel: [    6.597757] [drm]   HPD1
Jan  3 16:20:41 cfhat12 kernel: [    6.597758] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
Jan  3 16:20:41 cfhat12 kernel: [    6.597759] [drm]   Encoders:
Jan  3 16:20:41 cfhat12 kernel: [    6.597760] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
Jan  3 16:20:41 cfhat12 kernel: [    6.705946] [drm] fb mappable at 0xD0040000
Jan  3 16:20:41 cfhat12 kernel: [    6.705947] [drm] vram apper at 0xD0000000
Jan  3 16:20:41 cfhat12 kernel: [    6.705948] [drm] size 7680000
Jan  3 16:20:41 cfhat12 kernel: [    6.705949] [drm] fb depth is 24
Jan  3 16:20:41 cfhat12 kernel: [    6.705949] [drm]    pitch is 6400
Jan  3 16:20:41 cfhat12 kernel: [    6.720538] Console: switching to colour frame buffer device 200x75
Jan  3 16:20:41 cfhat12 kernel: [    6.724929] fb0: radeondrmfb frame buffer device
Jan  3 16:20:41 cfhat12 kernel: [    6.724930] registered panic notifier
Jan  3 16:20:41 cfhat12 kernel: [    6.724933] [drm] Initialized radeon 2.0.0 20080528 for 0000:01:05.0 on minor 0
Jan  3 16:20:41 cfhat12 kernel: [    6.725041] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  3 16:20:41 cfhat12 kernel: [    6.725074] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  3 16:20:41 cfhat12 kernel: [    8.206761] Adding 1951668k swap on /dev/md3.  Priority:-1 extents:1 across:1951668k 
Jan  3 16:20:41 cfhat12 kernel: [    8.467898] loop: module loaded
Jan  3 16:20:41 cfhat12 kernel: [    9.190460] kjournald starting.  Commit interval 5 seconds
Jan  3 16:20:41 cfhat12 kernel: [    9.206784] EXT3 FS on md1, internal journal
Jan  3 16:20:41 cfhat12 kernel: [    9.206787] EXT3-fs: mounted filesystem with ordered data mode.
Jan  3 16:20:41 cfhat12 kernel: [    9.348306] XFS mounting filesystem md7
Jan  3 16:20:41 cfhat12 kernel: [    9.671085] Ending clean XFS mount for filesystem: md7
Jan  3 16:20:41 cfhat12 kernel: [    9.720038] XFS mounting filesystem md5
Jan  3 16:20:41 cfhat12 kernel: [   10.224392] Ending clean XFS mount for filesystem: md5
Jan  3 16:20:41 cfhat12 kernel: [   10.261881] kjournald starting.  Commit interval 5 seconds
Jan  3 16:20:41 cfhat12 kernel: [   10.276596] EXT3 FS on md6, internal journal
Jan  3 16:20:41 cfhat12 kernel: [   10.276599] EXT3-fs: mounted filesystem with ordered data mode.
Jan  3 16:20:41 cfhat12 kernel: [   11.253766] r8169: eth0: link up
Jan  3 16:20:41 cfhat12 kernel: [   11.253775] r8169: eth0: link up
Jan  3 16:20:41 cfhat12 kernel: [   11.345384] fuse init (API version 7.13)
Jan  3 16:20:44 cfhat12 kernel: [   14.130063] ADDRCONF(NETDEV_UP): eth1: link is not ready
Jan  3 16:20:44 cfhat12 kernel: [   14.417206] Bluetooth: Core ver 2.15
Jan  3 16:20:44 cfhat12 kernel: [   14.417265] NET: Registered protocol family 31
Jan  3 16:20:44 cfhat12 kernel: [   14.417267] Bluetooth: HCI device and connection manager initialized
Jan  3 16:20:44 cfhat12 kernel: [   14.417269] Bluetooth: HCI socket layer initialized
Jan  3 16:20:44 cfhat12 kernel: [   14.434279] Bluetooth: L2CAP ver 2.14
Jan  3 16:20:44 cfhat12 kernel: [   14.434280] Bluetooth: L2CAP socket layer initialized
Jan  3 16:20:44 cfhat12 kernel: [   14.448095] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jan  3 16:20:44 cfhat12 kernel: [   14.448097] Bluetooth: BNEP filters: protocol multicast
Jan  3 16:20:44 cfhat12 kernel: [   14.452714] Bluetooth: RFCOMM TTY layer initialized
Jan  3 16:20:44 cfhat12 kernel: [   14.452718] Bluetooth: RFCOMM socket layer initialized
Jan  3 16:20:44 cfhat12 kernel: [   14.452719] Bluetooth: RFCOMM ver 1.11
Jan  3 16:20:44 cfhat12 kernel: [   14.463471] Bridge firewalling registered
Jan  3 16:20:44 cfhat12 kernel: [   14.474952] Bluetooth: SCO (Voice Link) ver 0.6
Jan  3 16:20:44 cfhat12 kernel: [   14.474954] Bluetooth: SCO socket layer initialized
Jan  3 16:20:45 cfhat12 kernel: [   15.411039] powernow-k8: Found 1 AMD Phenom(tm) II X4 965 Processor processors (4 cpu cores) (version 2.20.00)
Jan  3 16:20:45 cfhat12 kernel: [   15.411072] powernow-k8:    0 : pstate 0 (3400 MHz)
Jan  3 16:20:45 cfhat12 kernel: [   15.411073] powernow-k8:    1 : pstate 1 (2700 MHz)
Jan  3 16:20:45 cfhat12 kernel: [   15.411074] powernow-k8:    2 : pstate 2 (2200 MHz)
Jan  3 16:20:45 cfhat12 kernel: [   15.411075] powernow-k8:    3 : pstate 3 (800 MHz)
Jan  3 16:20:51 cfhat12 kernel: [   21.748043] eth0: no IPv6 routers present
Jan  3 17:30:58 cfhat12 kernel: [ 4229.020026] JFS: nTxBlock = 8192, nTxLock = 65536
Jan  3 17:30:58 cfhat12 kernel: [ 4229.094479] NTFS driver 2.1.29 [Flags: R/W MODULE].
Jan  3 17:30:59 cfhat12 kernel: [ 4229.159317] QNX4 filesystem 0.2.3 registered.
Jan  3 17:30:59 cfhat12 kernel: [ 4229.266820] Btrfs loaded
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901526] md: md7 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901561] md: md6 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901592] md: md5 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901621] md: md3 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901652] md: md2 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901687] md: md1 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901790] md: md7 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901837] md: md6 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901868] md: md5 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901898] md: md3 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901933] md: md2 still in use.
Jan  3 17:33:35 cfhat12 kernel: [ 4385.901963] md: md1 still in use.
Jan  3 17:33:36 cfhat12 kernel: [ 4386.993622] fuse exit
Jan  3 17:33:39 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 17:37:07 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 17:37:07 cfhat12 kernel: 00a0000-0x000bffff] (subtractive decode)
Jan  3 17:37:07 cfhat12 kernel: [    0.353143] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 17:37:07 cfhat12 kernel: [    0.353145] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 17:37:07 cfhat12 kernel: [    0.353248] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353283] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 17:37:07 cfhat12 kernel: [    0.353288] pci 0000:06:00.0: PME# disabled
Jan  3 17:37:07 cfhat12 kernel: [    0.353329] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353337] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 17:37:07 cfhat12 kernel: [    0.353345] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353352] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 17:37:07 cfhat12 kernel: [    0.353360] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 17:37:07 cfhat12 kernel: [    0.353414] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:37:07 cfhat12 kernel: [    0.353419] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353422] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353426] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.353573] pci 0000:07:00.0: supports D1
Jan  3 17:37:07 cfhat12 kernel: [    0.353575] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 17:37:07 cfhat12 kernel: [    0.353580] pci 0000:07:00.0: PME# disabled
Jan  3 17:37:07 cfhat12 kernel: [    0.353600] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:37:07 cfhat12 kernel: [    0.353604] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353607] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353612] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.353715] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353725] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353736] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353747] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353757] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 17:37:07 cfhat12 kernel: [    0.353768] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 17:37:07 cfhat12 kernel: [    0.353860] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:37:07 cfhat12 kernel: [    0.353865] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353871] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.353877] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.353904] pci_bus 0000:00: on NUMA node 0
Jan  3 17:37:07 cfhat12 kernel: [    0.353907] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354136] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354175] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354219] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354301] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354339] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354375] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.354416] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 17:37:07 cfhat12 kernel: [    0.371439] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371510] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371579] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371647] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371716] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371783] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371852] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.371919] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:37:07 cfhat12 kernel: [    0.372000] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 17:37:07 cfhat12 kernel: [    0.372000] vgaarb: loaded
Jan  3 17:37:07 cfhat12 kernel: [    0.372041] PCI: Using ACPI for IRQ routing
Jan  3 17:37:07 cfhat12 kernel: [    0.372043] PCI: pci_cache_line_size set to 64 bytes
Jan  3 17:37:07 cfhat12 kernel: [    0.372050] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.372138] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 17:37:07 cfhat12 kernel: [    0.372140] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 17:37:07 cfhat12 kernel: [    0.372266] Switching to clocksource tsc
Jan  3 17:37:07 cfhat12 kernel: [    0.372308] pnp: PnP ACPI init
Jan  3 17:37:07 cfhat12 kernel: [    0.372312] ACPI: bus type pnp registered
Jan  3 17:37:07 cfhat12 kernel: [    0.372871] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.372898] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.372903] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.374150] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374154] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374156] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374159] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374162] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374165] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:37:07 cfhat12 kernel: [    0.374257] pnp: PnP ACPI: found 11 devices
Jan  3 17:37:07 cfhat12 kernel: [    0.374258] ACPI: ACPI bus type pnp unregistered
Jan  3 17:37:07 cfhat12 kernel: [    0.374264] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374266] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374268] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374271] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374274] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374276] system 00:02: [io  0x040b] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374278] system 00:02: [io  0x04d6] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374279] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374281] system 00:02: [io  0x0c14] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374283] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374285] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374286] system 00:02: [io  0x0c6f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374288] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374290] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374292] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374294] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374295] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374297] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374299] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374301] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374303] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374307] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374311] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374313] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374315] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374317] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374319] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374321] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.374323] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 17:37:07 cfhat12 kernel: [    0.380397] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 17:37:07 cfhat12 kernel: [    0.380399] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380402] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380404] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380408] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380410] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 17:37:07 cfhat12 kernel: [    0.380412] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380414] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380417] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380420] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 17:37:07 cfhat12 kernel: [    0.380422] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380424] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380426] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380430] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380431] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 17:37:07 cfhat12 kernel: [    0.380433] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380436] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380438] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380441] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 17:37:07 cfhat12 kernel: [    0.380443] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380447] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380451] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380456] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:37:07 cfhat12 kernel: [    0.380458] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380461] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380464] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380469] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:37:07 cfhat12 kernel: [    0.380472] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380480] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380486] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380495] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:37:07 cfhat12 kernel: [    0.380498] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380501] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380504] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380519] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:37:07 cfhat12 kernel: [    0.380521] pci 0000:00:07.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380529] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.380531] pci 0000:00:09.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380539] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.380541] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380549] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.380552] pci 0000:00:15.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380557] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.380560] pci 0000:00:15.1: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380571] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.380576] pci 0000:07:00.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.380580] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:37:07 cfhat12 kernel: [    0.380582] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380583] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380585] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380587] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380588] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380590] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380592] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380593] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380595] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380596] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380598] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380600] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380601] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380603] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380605] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380606] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380608] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380609] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380611] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380613] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:37:07 cfhat12 kernel: [    0.380614] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380616] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380617] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380619] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380620] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380622] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380624] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380625] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380627] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380628] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380630] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380632] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:37:07 cfhat12 kernel: [    0.380633] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:37:07 cfhat12 kernel: [    0.380686] NET: Registered protocol family 2
Jan  3 17:37:07 cfhat12 kernel: [    0.380732] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.381174] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.382084] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.382332] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 17:37:07 cfhat12 kernel: [    0.382334] TCP reno registered
Jan  3 17:37:07 cfhat12 kernel: [    0.382336] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.382373] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.382511] NET: Registered protocol family 1
Jan  3 17:37:07 cfhat12 kernel: [    0.382520] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 17:37:07 cfhat12 kernel: [    0.443831] pci 0000:01:05.0: Boot video device
Jan  3 17:37:07 cfhat12 kernel: [    0.443871] PCI: CLS 4 bytes, default 64
Jan  3 17:37:07 cfhat12 kernel: [    0.443911] Unpacking initramfs...
Jan  3 17:37:07 cfhat12 kernel: [    0.506104] Freeing initrd memory: 4404k freed
Jan  3 17:37:07 cfhat12 kernel: [    0.507391] PCI-DMA: Disabling AGP.
Jan  3 17:37:07 cfhat12 kernel: [    0.507495] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 17:37:07 cfhat12 kernel: [    0.507497] PCI-DMA: using GART IOMMU.
Jan  3 17:37:07 cfhat12 kernel: [    0.507499] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 17:37:07 cfhat12 kernel: [    0.511434] I-pipe: Domain Xenomai registered.
Jan  3 17:37:07 cfhat12 kernel: [    0.511501] Xenomai: hal/x86_64 started.
Jan  3 17:37:07 cfhat12 kernel: [    0.511512] Xenomai: scheduling class idle registered.
Jan  3 17:37:07 cfhat12 kernel: [    0.511513] Xenomai: scheduling class rt registered.
Jan  3 17:37:07 cfhat12 kernel: [    0.512330] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 17:37:07 cfhat12 kernel: [    0.512658] VFS: Disk quotas dquot_6.5.2
Jan  3 17:37:07 cfhat12 kernel: [    0.512679] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 17:37:07 cfhat12 kernel: [    0.512731] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  3 17:37:07 cfhat12 kernel: [    0.512991] SGI XFS Quota Management subsystem
Jan  3 17:37:07 cfhat12 kernel: [    0.512996] msgmni has been set to 14978
Jan  3 17:37:07 cfhat12 kernel: [    0.513126] alg: No test for stdrng (krng)
Jan  3 17:37:07 cfhat12 kernel: [    0.513133] io scheduler noop registered
Jan  3 17:37:07 cfhat12 kernel: [    0.513135] io scheduler deadline registered
Jan  3 17:37:07 cfhat12 kernel: [    0.513146] io scheduler cfq registered (default)
Jan  3 17:37:07 cfhat12 kernel: [    0.513236] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.513257] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.513327] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.513344] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.513412] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.513429] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.513500] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.513532] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.513614] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.513646] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.514817] Linux agpgart interface v0.103
Jan  3 17:37:07 cfhat12 kernel: [    0.514888] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 17:37:07 cfhat12 kernel: [    0.514890] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 17:37:07 cfhat12 kernel: [    0.515018] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 17:37:07 cfhat12 kernel: [    0.515131] mice: PS/2 mouse device common for all mice
Jan  3 17:37:07 cfhat12 kernel: [    0.515158] Driver for 1-wire Dallas network protocol.
Jan  3 17:37:07 cfhat12 kernel: [    0.515229] cpuidle: using governor ladder
Jan  3 17:37:07 cfhat12 kernel: [    0.515366] TCP bic registered
Jan  3 17:37:07 cfhat12 kernel: [    0.515368] NET: Registered protocol family 17
Jan  3 17:37:07 cfhat12 kernel: [    0.515747] Freeing unused kernel memory: 408k freed
Jan  3 17:37:07 cfhat12 kernel: [    0.567746] usbcore: registered new interface driver usbfs
Jan  3 17:37:07 cfhat12 kernel: [    0.569082] usbcore: registered new interface driver hub
Jan  3 17:37:07 cfhat12 kernel: [    0.569941] usbcore: registered new device driver usb
Jan  3 17:37:07 cfhat12 kernel: [    0.571748] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 17:37:07 cfhat12 kernel: [    0.574780] Uniform Multi-Platform E-IDE driver
Jan  3 17:37:07 cfhat12 kernel: [    0.575753] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 17:37:07 cfhat12 kernel: [    0.575773] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.575807] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.575822] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 17:37:07 cfhat12 kernel: [    0.575849] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 17:37:07 cfhat12 kernel: [    0.575871] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 17:37:07 cfhat12 kernel: [    0.576409] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 17:37:07 cfhat12 kernel: [    0.576424] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.576458] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.576496] r8169 0000:04:00.0: irq 45 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.576632] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000032000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 45
Jan  3 17:37:07 cfhat12 kernel: [    0.578198] SCSI subsystem initialized
Jan  3 17:37:07 cfhat12 kernel: [    0.587546] libata version 3.00 loaded.
Jan  3 17:37:07 cfhat12 kernel: [    0.590340] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 17:37:07 cfhat12 kernel: [    0.590342] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 17:37:07 cfhat12 kernel: [    0.590372] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:37:07 cfhat12 kernel: [    0.590387] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.590546] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.590548] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.590550] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.591051] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 17:37:07 cfhat12 kernel: [    0.591812] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 17:37:07 cfhat12 kernel: [    0.591885] hub 1-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.591889] hub 1-0:1.0: 5 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.591930] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.591940] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.591945] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 17:37:07 cfhat12 kernel: [    0.591968] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 17:37:07 cfhat12 kernel: [    0.591979] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 17:37:07 cfhat12 kernel: [    0.607775] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 17:37:07 cfhat12 kernel: [    0.607851] hub 2-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.607853] hub 2-0:1.0: 5 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.607893] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.607912] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.607918] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 17:37:07 cfhat12 kernel: [    0.607941] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 17:37:07 cfhat12 kernel: [    0.607951] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 17:37:07 cfhat12 kernel: [    0.623786] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 17:37:07 cfhat12 kernel: [    0.623844] hub 3-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.623846] hub 3-0:1.0: 4 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.623880] ahci 0000:00:11.0: version 3.0
Jan  3 17:37:07 cfhat12 kernel: [    0.623888] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:37:07 cfhat12 kernel: [    0.623926] ahci 0000:00:11.0: irq 49 for MSI/MSI-X
Jan  3 17:37:07 cfhat12 kernel: [    0.623991] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 17:37:07 cfhat12 kernel: [    0.623994] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 17:37:07 cfhat12 kernel: [    0.624180] scsi0 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.624254] scsi1 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.624292] scsi2 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.624411] scsi3 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.624493] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 49
Jan  3 17:37:07 cfhat12 kernel: [    0.624496] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 49
Jan  3 17:37:07 cfhat12 kernel: [    0.624498] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 49
Jan  3 17:37:07 cfhat12 kernel: [    0.624501] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 49
Jan  3 17:37:07 cfhat12 kernel: [    0.624528] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.632803] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 17:37:07 cfhat12 kernel: [    0.632815] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.632848] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.632856] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 17:37:07 cfhat12 kernel: [    0.632881] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 17:37:07 cfhat12 kernel: [    0.643861] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 17:37:07 cfhat12 kernel: [    0.643864] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 17:37:07 cfhat12 kernel: [    0.643873] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.643997] scsi4 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.644043] scsi5 : ahci
Jan  3 17:37:07 cfhat12 kernel: [    0.644077] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 17:37:07 cfhat12 kernel: [    0.644082] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 17:37:07 cfhat12 kernel: [    0.644163] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 17:37:07 cfhat12 kernel: [    0.644171] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.644194] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    0.644235] scsi6 : pata_jmicron
Jan  3 17:37:07 cfhat12 kernel: [    0.644269] scsi7 : pata_jmicron
Jan  3 17:37:07 cfhat12 kernel: [    0.644289] ata7: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 17:37:07 cfhat12 kernel: [    0.644291] ata8: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 17:37:07 cfhat12 kernel: [    0.691841] hub 4-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.691846] hub 4-0:1.0: 5 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.691884] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.691908] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.691913] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 17:37:07 cfhat12 kernel: [    0.691927] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 17:37:07 cfhat12 kernel: [    0.704910] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 17:37:07 cfhat12 kernel: [    0.704912] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 17:37:07 cfhat12 kernel: [    0.704924] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 17:37:07 cfhat12 kernel: [    0.751836] hub 5-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.751841] hub 5-0:1.0: 5 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.751879] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.751892] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.751898] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 17:37:07 cfhat12 kernel: [    0.751910] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 17:37:07 cfhat12 kernel: [    0.811840] hub 6-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.811845] hub 6-0:1.0: 2 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.811879] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:37:07 cfhat12 kernel: [    0.811893] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    0.811897] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 17:37:07 cfhat12 kernel: [    0.811910] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 17:37:07 cfhat12 kernel: [    0.871845] hub 7-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    0.871850] hub 7-0:1.0: 4 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    0.871891] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    0.871962] scsi8 : pata_atiixp
Jan  3 17:37:07 cfhat12 kernel: [    0.872008] scsi9 : pata_atiixp
Jan  3 17:37:07 cfhat12 kernel: [    0.872763] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 17:37:07 cfhat12 kernel: [    0.872765] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 17:37:07 cfhat12 kernel: [    0.943826] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    0.951837] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    0.967855] ata5: SATA link down (SStatus 0 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    0.967858] ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    1.048077] ata9.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 17:37:07 cfhat12 kernel: [    1.048092] ata9.00: limited to UDMA/33 due to 40-wire cable
Jan  3 17:37:07 cfhat12 kernel: [    1.064097] ata9.00: configured for UDMA/33
Jan  3 17:37:07 cfhat12 kernel: [    1.079827] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 17:37:07 cfhat12 kernel: [    1.119831] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    1.121487] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 17:37:07 cfhat12 kernel: [    1.121490] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 17:37:07 cfhat12 kernel: [    1.123107] ata1.00: configured for UDMA/133
Jan  3 17:37:07 cfhat12 kernel: [    1.139908] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 17:37:07 cfhat12 kernel: [    1.167836] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:37:07 cfhat12 kernel: [    1.170903] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 17:37:07 cfhat12 kernel: [    1.170906] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 17:37:07 cfhat12 kernel: [    1.173946] ata2.00: configured for UDMA/133
Jan  3 17:37:07 cfhat12 kernel: [    1.191892] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 17:37:07 cfhat12 kernel: [    1.360056] scsi 8:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 17:37:07 cfhat12 kernel: [    1.365464] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:37:07 cfhat12 kernel: [    1.365504] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:37:07 cfhat12 kernel: [    1.365526] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 17:37:07 cfhat12 kernel: [    1.365528] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 17:37:07 cfhat12 kernel: [    1.365543] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:37:07 cfhat12 kernel: [    1.365546] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 17:37:07 cfhat12 kernel: [    1.365549] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 17:37:07 cfhat12 kernel: [    1.365562] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:37:07 cfhat12 kernel: [    1.365640]  sda:
Jan  3 17:37:07 cfhat12 kernel: [    1.365706]  sdb: sda1 sda2 sda3 sda4 <sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 17:37:07 cfhat12 kernel: [    1.371010] Uniform CD-ROM driver Revision: 3.20
Jan  3 17:37:07 cfhat12 kernel: [    1.371062] sr 8:0:0:0: Attached scsi CD-ROM sr0
Jan  3 17:37:07 cfhat12 kernel: [    1.376297]  sdb1 sdb2 sdb3 sdb4 < sda5 sda6
Jan  3 17:37:07 cfhat12 kernel: [    1.385762] usbcore: registered new interface driver hiddev
Jan  3 17:37:07 cfhat12 kernel: [    1.386345]  sdb5
Jan  3 17:37:07 cfhat12 kernel: [    1.390076] input: USBPS2 as /class/input/input1
Jan  3 17:37:07 cfhat12 kernel: [    1.390084] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 17:37:07 cfhat12 kernel: [    1.394857]  sda7 >
Jan  3 17:37:07 cfhat12 kernel: [    1.395104] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 17:37:07 cfhat12 kernel: [    1.395577]  sdb6
Jan  3 17:37:07 cfhat12 kernel: [    1.397082] input: USBPS2 as /class/input/input2
Jan  3 17:37:07 cfhat12 kernel: [    1.397106] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 17:37:07 cfhat12 kernel: [    1.397115] usbcore: registered new interface driver usbhid
Jan  3 17:37:07 cfhat12 kernel: [    1.397116] usbhid: USB HID core driver
Jan  3 17:37:07 cfhat12 kernel: [    1.405722]  sdb7 >
Jan  3 17:37:07 cfhat12 kernel: [    1.405971] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 17:37:07 cfhat12 kernel: [    1.603835] md: raid1 personality registered for level 1
Jan  3 17:37:07 cfhat12 kernel: [    1.609387] md: md1 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    1.610410] md: bind<sdb1>
Jan  3 17:37:07 cfhat12 kernel: [    1.610617] md: bind<sda1>
Jan  3 17:37:07 cfhat12 kernel: [    1.611440] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    1.611456] md1: detected capacity change from 0 to 254791680
Jan  3 17:37:07 cfhat12 kernel: [    1.611851]  md1: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    1.819901] md: md2 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    1.820721] md: bind<sdb2>
Jan  3 17:37:07 cfhat12 kernel: [    1.820855] md: bind<sda2>
Jan  3 17:37:07 cfhat12 kernel: [    1.821618] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    1.821634] md2: detected capacity change from 0 to 19998367744
Jan  3 17:37:07 cfhat12 kernel: [    1.822125]  md2: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    2.031898] md: md3 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    2.032780] md: bind<sdb3>
Jan  3 17:37:07 cfhat12 kernel: [    2.032955] md: bind<sda3>
Jan  3 17:37:07 cfhat12 kernel: [    2.033689] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    2.033705] md3: detected capacity change from 0 to 1998573568
Jan  3 17:37:07 cfhat12 kernel: [    2.034359]  md3: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    2.243856] md: md5 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    2.244396] md: bind<sdb5>
Jan  3 17:37:07 cfhat12 kernel: [    2.244537] md: bind<sda5>
Jan  3 17:37:07 cfhat12 kernel: [    2.245274] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    2.245288] md5: detected capacity change from 0 to 19997319168
Jan  3 17:37:07 cfhat12 kernel: [    2.245793]  md5: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    2.465847] md: md6 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    2.466634] md: bind<sdb6>
Jan  3 17:37:07 cfhat12 kernel: [    2.466854] md: bind<sda6>
Jan  3 17:37:07 cfhat12 kernel: [    2.467566] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    2.467578] md6: detected capacity change from 0 to 19997319168
Jan  3 17:37:07 cfhat12 kernel: [    2.467931]  md6: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    2.692053] md: md7 stopped.
Jan  3 17:37:07 cfhat12 kernel: [    2.692840] md: bind<sdb7>
Jan  3 17:37:07 cfhat12 kernel: [    2.693057] md: bind<sda7>
Jan  3 17:37:07 cfhat12 kernel: [    2.693789] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 17:37:07 cfhat12 kernel: [    2.693804] md7: detected capacity change from 0 to 97784881152
Jan  3 17:37:07 cfhat12 kernel: [    2.694285]  md7: unknown partition table
Jan  3 17:37:07 cfhat12 kernel: [    2.958012] XFS mounting filesystem md2
Jan  3 17:37:07 cfhat12 kernel: [    3.510962] Ending clean XFS mount for filesystem: md2
Jan  3 17:37:07 cfhat12 kernel: [    4.996207] udev[887]: starting version 164
Jan  3 17:37:07 cfhat12 kernel: [    5.237006] input: Power Button as /class/input/input3
Jan  3 17:37:07 cfhat12 kernel: [    5.237011] ACPI: Power Button [PWRB]
Jan  3 17:37:07 cfhat12 kernel: [    5.237064] input: Power Button as /class/input/input4
Jan  3 17:37:07 cfhat12 kernel: [    5.237066] ACPI: Power Button [PWRF]
Jan  3 17:37:07 cfhat12 kernel: [    5.296010] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
Jan  3 17:37:07 cfhat12 kernel: [    5.296102] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.297321] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.328106] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    5.328148] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 17:37:07 cfhat12 kernel: [    5.328148] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 17:37:07 cfhat12 kernel: [    5.328148] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 17:37:07 cfhat12 kernel: [    5.328167] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 17:37:07 cfhat12 kernel: [    5.328965] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:37:07 cfhat12 kernel: [    5.329078] 0000:05:06.0: ttyS4 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.329193] 0000:05:06.0: ttyS5 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.329351] 0000:05:06.0: ttyS1 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.329506] 0000:05:06.0: ttyS2 at I/O 0xac00 (irq = 20) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.329537] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:37:07 cfhat12 kernel: [    5.329638] 0000:05:06.1: ttyS3 at I/O 0xab00 (irq = 20) is a 16550A
Jan  3 17:37:07 cfhat12 kernel: [    5.329656] Couldn't register serial port 0000:05:06.1: -28
Jan  3 17:37:07 cfhat12 kernel: [    5.331634] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 17:37:07 cfhat12 kernel: [    5.331706] xHCI xhci_add_endpoint called for root hub
Jan  3 17:37:07 cfhat12 kernel: [    5.331708] xHCI xhci_check_bandwidth called for root hub
Jan  3 17:37:07 cfhat12 kernel: [    5.331726] hub 8-0:1.0: USB hub found
Jan  3 17:37:07 cfhat12 kernel: [    5.331729] hub 8-0:1.0: 4 ports detected
Jan  3 17:37:07 cfhat12 kernel: [    5.362688] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [mem 0x00000b00-0x00000b0f window]
Jan  3 17:37:07 cfhat12 kernel: [    5.362691] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 17:37:07 cfhat12 kernel: [    5.378221] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 17:37:07 cfhat12 kernel: [    5.382245] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 17:37:07 cfhat12 kernel: [    5.382247] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 17:37:07 cfhat12 kernel: [    5.382248] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 17:37:07 cfhat12 kernel: [    5.383331] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 17:37:07 cfhat12 kernel: [    5.389476] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    5.389479] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    5.389559] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:37:07 cfhat12 kernel: [    5.406528] rtc_cmos 00:04: RTC can wake from S4
Jan  3 17:37:07 cfhat12 kernel: [    5.406565] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 17:37:07 cfhat12 kernel: [    5.406587] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 17:37:07 cfhat12 kernel: [    5.476221] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 17:37:07 cfhat12 kernel: [    5.476302] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:37:07 cfhat12 kernel: [    6.729350] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 17:37:07 cfhat12 kernel: [    7.148302] loop: module loaded
Jan  3 17:37:07 cfhat12 kernel: [   10.798405] EXT3-fs: barriers not enabled
Jan  3 17:37:07 cfhat12 kernel: [   10.806080] kjournald starting.  Commit interval 5 seconds
Jan  3 17:37:07 cfhat12 kernel: [   10.820757] EXT3-fs (md1): using internal journal
Jan  3 17:37:07 cfhat12 kernel: [   10.820761] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 17:37:07 cfhat12 kernel: [   10.952747] XFS mounting filesystem md7
Jan  3 17:37:07 cfhat12 kernel: [   11.285120] Ending clean XFS mount for filesystem: md7
Jan  3 17:37:07 cfhat12 kernel: [   11.344370] XFS mounting filesystem md5
Jan  3 17:37:07 cfhat12 kernel: [   11.659841] Ending clean XFS mount for filesystem: md5
Jan  3 17:37:07 cfhat12 kernel: [   11.684489] EXT3-fs: barriers not enabled
Jan  3 17:37:07 cfhat12 kernel: [   11.693499] kjournald starting.  Commit interval 5 seconds
Jan  3 17:37:07 cfhat12 kernel: [   11.707059] EXT3-fs (md6): using internal journal
Jan  3 17:37:07 cfhat12 kernel: [   11.707063] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 17:37:07 cfhat12 kernel: [   12.526347] r8169 0000:04:00.0: eth0: link up
Jan  3 17:37:07 cfhat12 kernel: [   12.526352] r8169 0000:04:00.0: eth0: link up
Jan  3 17:37:07 cfhat12 kernel: [   12.862769] fuse init (API version 7.14)
Jan  3 17:40:14 cfhat12 kernel: [  200.298208] md: md7 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298236] md: md6 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298260] md: md5 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298282] md: md3 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298310] md: md2 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298347] md: md1 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298430] md: md7 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298475] md: md6 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298497] md: md5 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298521] md: md3 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298540] md: md2 still in use.
Jan  3 17:40:14 cfhat12 kernel: [  200.298560] md: md1 still in use.
Jan  3 17:40:35 cfhat12 kernel: [  221.063241] fuse exit
Jan  3 17:40:45 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 17:41:30 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 17:41:30 cfhat12 kernel: 0a0000-0x000bffff] (subtractive decode)
Jan  3 17:41:30 cfhat12 kernel: [    0.357105] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 17:41:30 cfhat12 kernel: [    0.357107] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 17:41:30 cfhat12 kernel: [    0.357206] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357240] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 17:41:30 cfhat12 kernel: [    0.357245] pci 0000:06:00.0: PME# disabled
Jan  3 17:41:30 cfhat12 kernel: [    0.357284] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357292] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 17:41:30 cfhat12 kernel: [    0.357299] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357307] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 17:41:30 cfhat12 kernel: [    0.357314] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 17:41:30 cfhat12 kernel: [    0.357367] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:41:30 cfhat12 kernel: [    0.357371] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357374] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357378] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.357520] pci 0000:07:00.0: supports D1
Jan  3 17:41:30 cfhat12 kernel: [    0.357521] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 17:41:30 cfhat12 kernel: [    0.357527] pci 0000:07:00.0: PME# disabled
Jan  3 17:41:30 cfhat12 kernel: [    0.357546] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:41:30 cfhat12 kernel: [    0.357550] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357553] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357557] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.357656] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357666] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357677] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357687] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357697] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 17:41:30 cfhat12 kernel: [    0.357707] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 17:41:30 cfhat12 kernel: [    0.357795] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:41:30 cfhat12 kernel: [    0.357800] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357806] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.357811] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.357837] pci_bus 0000:00: on NUMA node 0
Jan  3 17:41:30 cfhat12 kernel: [    0.357840] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358059] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358096] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358139] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358217] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358252] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358287] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.358326] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 17:41:30 cfhat12 kernel: [    0.375412] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375481] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375546] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375612] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375678] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375743] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375809] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.375874] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:41:30 cfhat12 kernel: [    0.376049] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 17:41:30 cfhat12 kernel: [    0.376054] vgaarb: loaded
Jan  3 17:41:30 cfhat12 kernel: [    0.376158] PCI: Using ACPI for IRQ routing
Jan  3 17:41:30 cfhat12 kernel: [    0.376160] PCI: pci_cache_line_size set to 64 bytes
Jan  3 17:41:30 cfhat12 kernel: [    0.376166] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.376251] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 17:41:30 cfhat12 kernel: [    0.376253] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 17:41:30 cfhat12 kernel: [    0.376374] Switching to clocksource tsc
Jan  3 17:41:30 cfhat12 kernel: [    0.376415] pnp: PnP ACPI init
Jan  3 17:41:30 cfhat12 kernel: [    0.376419] ACPI: bus type pnp registered
Jan  3 17:41:30 cfhat12 kernel: [    0.376955] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.376980] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.376985] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.378180] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378183] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378186] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378189] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378191] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378194] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:41:30 cfhat12 kernel: [    0.378281] pnp: PnP ACPI: found 11 devices
Jan  3 17:41:30 cfhat12 kernel: [    0.378282] ACPI: ACPI bus type pnp unregistered
Jan  3 17:41:30 cfhat12 kernel: [    0.378288] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378290] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378292] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378295] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378298] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378299] system 00:02: [io  0x040b] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378301] system 00:02: [io  0x04d6] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378303] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378305] system 00:02: [io  0x0c14] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378306] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378308] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378310] system 00:02: [io  0x0c6f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378311] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378313] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378315] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378316] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378318] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378320] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378322] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378323] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378325] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378330] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378333] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378335] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378337] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378338] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378340] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378342] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.378344] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 17:41:30 cfhat12 kernel: [    0.384347] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 17:41:30 cfhat12 kernel: [    0.384349] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384352] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384354] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384358] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384360] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 17:41:30 cfhat12 kernel: [    0.384362] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384364] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384366] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384369] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 17:41:30 cfhat12 kernel: [    0.384371] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384373] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384375] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384379] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384380] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 17:41:30 cfhat12 kernel: [    0.384382] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384384] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384386] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384389] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 17:41:30 cfhat12 kernel: [    0.384392] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384395] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384398] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384403] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:41:30 cfhat12 kernel: [    0.384405] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384408] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384411] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384415] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:41:30 cfhat12 kernel: [    0.384419] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384426] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384432] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384441] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:41:30 cfhat12 kernel: [    0.384443] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384446] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384449] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384463] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:41:30 cfhat12 kernel: [    0.384466] pci 0000:00:07.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384473] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.384475] pci 0000:00:09.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384482] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.384484] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384492] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.384495] pci 0000:00:15.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384500] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.384503] pci 0000:00:15.1: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384513] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.384519] pci 0000:07:00.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.384522] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:41:30 cfhat12 kernel: [    0.384524] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384525] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384527] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384528] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384530] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384531] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384533] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384535] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384536] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384538] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384539] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384541] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384542] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384544] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384546] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384547] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384549] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384550] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384552] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384553] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:41:30 cfhat12 kernel: [    0.384555] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384556] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384558] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384559] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384561] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384562] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384564] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384565] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384567] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384568] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384570] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384571] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:41:30 cfhat12 kernel: [    0.384573] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:41:30 cfhat12 kernel: [    0.384622] NET: Registered protocol family 2
Jan  3 17:41:30 cfhat12 kernel: [    0.384667] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.385091] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.385958] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.386189] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 17:41:30 cfhat12 kernel: [    0.386191] TCP reno registered
Jan  3 17:41:30 cfhat12 kernel: [    0.386193] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.386229] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.386362] NET: Registered protocol family 1
Jan  3 17:41:30 cfhat12 kernel: [    0.386371] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 17:41:30 cfhat12 kernel: [    0.447714] pci 0000:01:05.0: Boot video device
Jan  3 17:41:30 cfhat12 kernel: [    0.447752] PCI: CLS 4 bytes, default 64
Jan  3 17:41:30 cfhat12 kernel: [    0.447788] Unpacking initramfs...
Jan  3 17:41:30 cfhat12 kernel: [    0.509852] Freeing initrd memory: 4404k freed
Jan  3 17:41:30 cfhat12 kernel: [    0.511078] PCI-DMA: Disabling AGP.
Jan  3 17:41:30 cfhat12 kernel: [    0.511177] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 17:41:30 cfhat12 kernel: [    0.511178] PCI-DMA: using GART IOMMU.
Jan  3 17:41:30 cfhat12 kernel: [    0.511181] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 17:41:30 cfhat12 kernel: [    0.515140] I-pipe: Domain Xenomai registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.515203] Xenomai: hal/x86_64 started.
Jan  3 17:41:30 cfhat12 kernel: [    0.515213] Xenomai: scheduling class idle registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.515214] Xenomai: scheduling class rt registered.
Jan  3 17:41:30 cfhat12 kernel: [    0.516146] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 17:41:30 cfhat12 kernel: [    0.516459] VFS: Disk quotas dquot_6.5.2
Jan  3 17:41:30 cfhat12 kernel: [    0.516478] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 17:41:30 cfhat12 kernel: [    0.516527] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  3 17:41:30 cfhat12 kernel: [    0.516770] SGI XFS Quota Management subsystem
Jan  3 17:41:30 cfhat12 kernel: [    0.516775] msgmni has been set to 14978
Jan  3 17:41:30 cfhat12 kernel: [    0.516899] alg: No test for stdrng (krng)
Jan  3 17:41:30 cfhat12 kernel: [    0.516906] io scheduler noop registered
Jan  3 17:41:30 cfhat12 kernel: [    0.516908] io scheduler deadline registered
Jan  3 17:41:30 cfhat12 kernel: [    0.516919] io scheduler cfq registered (default)
Jan  3 17:41:30 cfhat12 kernel: [    0.517004] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.517024] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.517091] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.517108] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.517172] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.517188] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.517255] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.517285] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.517365] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.517395] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.518525] Linux agpgart interface v0.103
Jan  3 17:41:30 cfhat12 kernel: [    0.518592] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 17:41:30 cfhat12 kernel: [    0.518594] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 17:41:30 cfhat12 kernel: [    0.518718] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 17:41:30 cfhat12 kernel: [    0.518827] mice: PS/2 mouse device common for all mice
Jan  3 17:41:30 cfhat12 kernel: [    0.518853] Driver for 1-wire Dallas network protocol.
Jan  3 17:41:30 cfhat12 kernel: [    0.518921] cpuidle: using governor ladder
Jan  3 17:41:30 cfhat12 kernel: [    0.519043] TCP bic registered
Jan  3 17:41:30 cfhat12 kernel: [    0.519045] NET: Registered protocol family 17
Jan  3 17:41:30 cfhat12 kernel: [    0.519474] Freeing unused kernel memory: 408k freed
Jan  3 17:41:30 cfhat12 kernel: [    0.544040] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 17:41:30 cfhat12 kernel: [    0.544043] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 17:41:30 cfhat12 kernel: [    0.544074] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:41:30 cfhat12 kernel: [    0.544090] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.544243] e1000e 0000:02:00.0: irq 45 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.544245] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.544247] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.544720] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 17:41:30 cfhat12 kernel: [    0.566471] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 17:41:30 cfhat12 kernel: [    0.566489] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.566529] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.566565] r8169 0000:04:00.0: irq 48 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.566719] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000072000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 48
Jan  3 17:41:30 cfhat12 kernel: [    0.573992] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 17:41:30 cfhat12 kernel: [    0.574215] SCSI subsystem initialized
Jan  3 17:41:30 cfhat12 kernel: [    0.586434] usbcore: registered new interface driver usbfs
Jan  3 17:41:30 cfhat12 kernel: [    0.586510] usbcore: registered new interface driver hub
Jan  3 17:41:30 cfhat12 kernel: [    0.586529] usbcore: registered new device driver usb
Jan  3 17:41:30 cfhat12 kernel: [    0.587497] libata version 3.00 loaded.
Jan  3 17:41:30 cfhat12 kernel: [    0.587682] Uniform Multi-Platform E-IDE driver
Jan  3 17:41:30 cfhat12 kernel: [    0.588533] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 17:41:30 cfhat12 kernel: [    0.588553] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.588582] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.588595] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 17:41:30 cfhat12 kernel: [    0.588621] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 17:41:30 cfhat12 kernel: [    0.588643] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 17:41:30 cfhat12 kernel: [    0.600128] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 17:41:30 cfhat12 kernel: [    0.600205] hub 1-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.600209] hub 1-0:1.0: 5 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.600253] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.600272] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.600277] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 17:41:30 cfhat12 kernel: [    0.600299] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 17:41:30 cfhat12 kernel: [    0.600309] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 17:41:30 cfhat12 kernel: [    0.611822] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 17:41:30 cfhat12 kernel: [    0.611879] hub 2-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.611881] hub 2-0:1.0: 5 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.611927] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.611945] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.611954] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 17:41:30 cfhat12 kernel: [    0.611976] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 17:41:30 cfhat12 kernel: [    0.611985] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 17:41:30 cfhat12 kernel: [    0.623702] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 17:41:30 cfhat12 kernel: [    0.623760] hub 3-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.623763] hub 3-0:1.0: 4 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.623797] ahci 0000:00:11.0: version 3.0
Jan  3 17:41:30 cfhat12 kernel: [    0.623805] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:41:30 cfhat12 kernel: [    0.623849] ahci 0000:00:11.0: irq 49 for MSI/MSI-X
Jan  3 17:41:30 cfhat12 kernel: [    0.623913] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 17:41:30 cfhat12 kernel: [    0.623916] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 17:41:30 cfhat12 kernel: [    0.624089] scsi0 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.624185] scsi1 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.624347] scsi2 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.624375] scsi3 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.624411] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 17:41:30 cfhat12 kernel: [    0.624417] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.624440] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.624462] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 49
Jan  3 17:41:30 cfhat12 kernel: [    0.624465] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 49
Jan  3 17:41:30 cfhat12 kernel: [    0.624467] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 49
Jan  3 17:41:30 cfhat12 kernel: [    0.624470] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 49
Jan  3 17:41:30 cfhat12 kernel: [    0.624483] scsi4 : pata_jmicron
Jan  3 17:41:30 cfhat12 kernel: [    0.624530] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.624587] scsi6 : pata_atiixp
Jan  3 17:41:30 cfhat12 kernel: [    0.624628] scsi7 : pata_atiixp
Jan  3 17:41:30 cfhat12 kernel: [    0.624738] scsi5 : pata_jmicron
Jan  3 17:41:30 cfhat12 kernel: [    0.624756] ata5: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 17:41:30 cfhat12 kernel: [    0.624758] ata6: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 17:41:30 cfhat12 kernel: [    0.624799] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    0.625160] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 17:41:30 cfhat12 kernel: [    0.625358] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 17:41:30 cfhat12 kernel: [    0.625360] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 17:41:30 cfhat12 kernel: [    0.625389] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.625407] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.625413] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 17:41:30 cfhat12 kernel: [    0.625447] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 17:41:30 cfhat12 kernel: [    0.639715] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 17:41:30 cfhat12 kernel: [    0.639718] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 17:41:30 cfhat12 kernel: [    0.639723] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    0.639823] scsi8 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.639866] scsi9 : ahci
Jan  3 17:41:30 cfhat12 kernel: [    0.639891] ata9: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 17:41:30 cfhat12 kernel: [    0.639894] ata10: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 17:41:30 cfhat12 kernel: [    0.652711] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 17:41:30 cfhat12 kernel: [    0.652713] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 17:41:30 cfhat12 kernel: [    0.652725] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 17:41:30 cfhat12 kernel: [    0.683696] hub 4-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.683701] hub 4-0:1.0: 5 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.683735] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.683747] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.683751] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 17:41:30 cfhat12 kernel: [    0.683764] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 17:41:30 cfhat12 kernel: [    0.743698] hub 5-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.743703] hub 5-0:1.0: 5 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.743737] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.743750] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.743758] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 17:41:30 cfhat12 kernel: [    0.743770] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 17:41:30 cfhat12 kernel: [    0.791976] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 17:41:30 cfhat12 kernel: [    0.791990] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  3 17:41:30 cfhat12 kernel: [    0.807708] hub 6-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.807712] hub 6-0:1.0: 2 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.807746] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:41:30 cfhat12 kernel: [    0.807759] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    0.807763] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 17:41:30 cfhat12 kernel: [    0.807777] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 17:41:30 cfhat12 kernel: [    0.807988] ata7.00: configured for UDMA/33
Jan  3 17:41:30 cfhat12 kernel: [    0.867776] hub 7-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    0.867781] hub 7-0:1.0: 4 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    0.947773] ata3: SATA link down (SStatus 0 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    0.947776] ata4: SATA link down (SStatus 0 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    0.963771] ata9: SATA link down (SStatus 0 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    0.967775] ata10: SATA link down (SStatus 0 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    1.087766] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 17:41:30 cfhat12 kernel: [    1.119792] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    1.121301] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 17:41:30 cfhat12 kernel: [    1.121304] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 17:41:30 cfhat12 kernel: [    1.122869] ata1.00: configured for UDMA/133
Jan  3 17:41:30 cfhat12 kernel: [    1.139868] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 17:41:30 cfhat12 kernel: [    1.183796] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:41:30 cfhat12 kernel: [    1.186726] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 17:41:30 cfhat12 kernel: [    1.186729] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  3 17:41:30 cfhat12 kernel: [    1.189803] ata2.00: configured for UDMA/133
Jan  3 17:41:30 cfhat12 kernel: [    1.207856] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 17:41:30 cfhat12 kernel: [    1.380020] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 17:41:30 cfhat12 kernel: [    1.384910] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:41:30 cfhat12 kernel: [    1.384935] sd 0:0:0:0: [sda] Write Protect is off
Jan  3 17:41:30 cfhat12 kernel: [    1.384937] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 17:41:30 cfhat12 kernel: [    1.384948] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:41:30 cfhat12 kernel: [    1.385031]  sda:
Jan  3 17:41:30 cfhat12 kernel: [    1.385083] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:41:30 cfhat12 kernel: [    1.385111] sd 1:0:0:0: [sdb] Write Protect is off
Jan  3 17:41:30 cfhat12 kernel: [    1.385113] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 17:41:30 cfhat12 kernel: [    1.385128] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:41:30 cfhat12 kernel: [    1.385208]  sdb: sdb1 sdb2 sdb3 sdb4 < sda1 sda2 sda3 sda4 < sdb5
Jan  3 17:41:30 cfhat12 kernel: [    1.409652] usbcore: registered new interface driver hiddev
Jan  3 17:41:30 cfhat12 kernel: [    1.410958]  sda5 sdb6
Jan  3 17:41:30 cfhat12 kernel: [    1.413985] input: USBPS2 as /class/input/input1
Jan  3 17:41:30 cfhat12 kernel: [    1.413993] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 17:41:30 cfhat12 kernel: [    1.418681]  sda6
Jan  3 17:41:30 cfhat12 kernel: [    1.421021] input: USBPS2 as /class/input/input2
Jan  3 17:41:30 cfhat12 kernel: [    1.421044] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 17:41:30 cfhat12 kernel: [    1.421052] usbcore: registered new interface driver usbhid
Jan  3 17:41:30 cfhat12 kernel: [    1.421053] usbhid: USB HID core driver
Jan  3 17:41:30 cfhat12 kernel: [    1.424039]  sdb7 >
Jan  3 17:41:30 cfhat12 kernel: [    1.424262] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  3 17:41:30 cfhat12 kernel: [    1.427743]  sda7 >
Jan  3 17:41:30 cfhat12 kernel: [    1.427999] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  3 17:41:30 cfhat12 kernel: [    1.433572] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 17:41:30 cfhat12 kernel: [    1.433574] Uniform CD-ROM driver Revision: 3.20
Jan  3 17:41:30 cfhat12 kernel: [    1.433619] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  3 17:41:30 cfhat12 kernel: [    1.675676] md: raid1 personality registered for level 1
Jan  3 17:41:30 cfhat12 kernel: [    1.681605] md: md1 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    1.682602] md: bind<sdb1>
Jan  3 17:41:30 cfhat12 kernel: [    1.682791] md: bind<sda1>
Jan  3 17:41:30 cfhat12 kernel: [    1.683697] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    1.683712] md1: detected capacity change from 0 to 254791680
Jan  3 17:41:30 cfhat12 kernel: [    1.684218]  md1: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    1.892005] md: md2 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    1.892756] md: bind<sdb2>
Jan  3 17:41:30 cfhat12 kernel: [    1.892900] md: bind<sda2>
Jan  3 17:41:30 cfhat12 kernel: [    1.893631] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    1.893646] md2: detected capacity change from 0 to 19998367744
Jan  3 17:41:30 cfhat12 kernel: [    1.894142]  md2: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    2.104253] md: md3 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    2.105075] md: bind<sdb3>
Jan  3 17:41:30 cfhat12 kernel: [    2.105241] md: bind<sda3>
Jan  3 17:41:30 cfhat12 kernel: [    2.105948] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    2.105963] md3: detected capacity change from 0 to 1998573568
Jan  3 17:41:30 cfhat12 kernel: [    2.106450]  md3: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    2.316123] md: md5 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    2.317033] md: bind<sdb5>
Jan  3 17:41:30 cfhat12 kernel: [    2.317162] md: bind<sda5>
Jan  3 17:41:30 cfhat12 kernel: [    2.317855] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    2.317870] md5: detected capacity change from 0 to 19997319168
Jan  3 17:41:30 cfhat12 kernel: [    2.318337]  md5: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    2.532832] md: md6 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    2.533631] md: bind<sdb6>
Jan  3 17:41:30 cfhat12 kernel: [    2.533793] md: bind<sda6>
Jan  3 17:41:30 cfhat12 kernel: [    2.534488] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    2.534502] md6: detected capacity change from 0 to 19997319168
Jan  3 17:41:30 cfhat12 kernel: [    2.534977]  md6: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    2.766806] md: md7 stopped.
Jan  3 17:41:30 cfhat12 kernel: [    2.767538] md: bind<sdb7>
Jan  3 17:41:30 cfhat12 kernel: [    2.767709] md: bind<sda7>
Jan  3 17:41:30 cfhat12 kernel: [    2.768399] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 17:41:30 cfhat12 kernel: [    2.768415] md7: detected capacity change from 0 to 97784881152
Jan  3 17:41:30 cfhat12 kernel: [    2.768886]  md7: unknown partition table
Jan  3 17:41:30 cfhat12 kernel: [    3.007800] XFS mounting filesystem md2
Jan  3 17:41:30 cfhat12 kernel: [    3.121025] Ending clean XFS mount for filesystem: md2
Jan  3 17:41:30 cfhat12 kernel: [    4.731446] udev[880]: starting version 164
Jan  3 17:41:30 cfhat12 kernel: [    5.034927] input: Power Button as /class/input/input3
Jan  3 17:41:30 cfhat12 kernel: [    5.034955] ACPI: Power Button [PWRB]
Jan  3 17:41:30 cfhat12 kernel: [    5.035004] input: Power Button as /class/input/input4
Jan  3 17:41:30 cfhat12 kernel: [    5.035019] ACPI: Power Button [PWRF]
Jan  3 17:41:30 cfhat12 kernel: [    5.045164] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
Jan  3 17:41:30 cfhat12 kernel: [    5.045250] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.046956] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:41:30 cfhat12 kernel: [    5.047044] 0000:05:06.0: ttyS4 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.047128] 0000:05:06.0: ttyS5 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.047209] 0000:05:06.0: ttyS1 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.047292] 0000:05:06.0: ttyS2 at I/O 0xac00 (irq = 20) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.047315] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:41:30 cfhat12 kernel: [    5.047382] 0000:05:06.1: ttyS3 at I/O 0xab00 (irq = 20) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.047397] Couldn't register serial port 0000:05:06.1: -28
Jan  3 17:41:30 cfhat12 kernel: [    5.073254] rtc_cmos 00:04: RTC can wake from S4
Jan  3 17:41:30 cfhat12 kernel: [    5.073287] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 17:41:30 cfhat12 kernel: [    5.073309] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 17:41:30 cfhat12 kernel: [    5.074582] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:41:30 cfhat12 kernel: [    5.113471] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 17:41:30 cfhat12 kernel: [    5.117502] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 17:41:30 cfhat12 kernel: [    5.117503] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 17:41:30 cfhat12 kernel: [    5.117505] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 17:41:30 cfhat12 kernel: [    5.118541] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 17:41:30 cfhat12 kernel: [    5.126269] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    5.126272] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    5.126348] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:41:30 cfhat12 kernel: [    5.139253] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    5.139331] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 17:41:30 cfhat12 kernel: [    5.139334] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 17:41:30 cfhat12 kernel: [    5.139343] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 17:41:30 cfhat12 kernel: [    5.139442] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 17:41:30 cfhat12 kernel: [    5.142822] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 17:41:30 cfhat12 kernel: [    5.142888] xHCI xhci_add_endpoint called for root hub
Jan  3 17:41:30 cfhat12 kernel: [    5.142890] xHCI xhci_check_bandwidth called for root hub
Jan  3 17:41:30 cfhat12 kernel: [    5.142907] hub 8-0:1.0: USB hub found
Jan  3 17:41:30 cfhat12 kernel: [    5.142910] hub 8-0:1.0: 4 ports detected
Jan  3 17:41:30 cfhat12 kernel: [    5.148914] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [mem 0x00000b00-0x00000b0f window]
Jan  3 17:41:30 cfhat12 kernel: [    5.148917] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 17:41:30 cfhat12 kernel: [    5.212553] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 17:41:30 cfhat12 kernel: [    5.212630] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:41:30 cfhat12 kernel: [    6.419516] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 17:41:30 cfhat12 kernel: [    6.722300] loop: module loaded
Jan  3 17:41:30 cfhat12 kernel: [    7.375687] EXT3-fs: barriers not enabled
Jan  3 17:41:30 cfhat12 kernel: [    7.383313] kjournald starting.  Commit interval 5 seconds
Jan  3 17:41:30 cfhat12 kernel: [    7.389657] EXT3-fs (md1): using internal journal
Jan  3 17:41:30 cfhat12 kernel: [    7.389661] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 17:41:30 cfhat12 kernel: [    7.454910] XFS mounting filesystem md7
Jan  3 17:41:30 cfhat12 kernel: [    7.620312] Ending clean XFS mount for filesystem: md7
Jan  3 17:41:30 cfhat12 kernel: [    7.679454] XFS mounting filesystem md5
Jan  3 17:41:30 cfhat12 kernel: [    7.866183] Ending clean XFS mount for filesystem: md5
Jan  3 17:41:30 cfhat12 kernel: [    7.936097] EXT3-fs: barriers not enabled
Jan  3 17:41:30 cfhat12 kernel: [    7.945869] kjournald starting.  Commit interval 5 seconds
Jan  3 17:41:30 cfhat12 kernel: [    7.959381] EXT3-fs (md6): using internal journal
Jan  3 17:41:30 cfhat12 kernel: [    7.959385] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 17:41:30 cfhat12 kernel: [    9.014642] fuse init (API version 7.14)
Jan  3 17:41:30 cfhat12 kernel: [    9.304816] r8169 0000:04:00.0: eth0: link up
Jan  3 17:41:30 cfhat12 kernel: [    9.304822] r8169 0000:04:00.0: eth0: link up
Jan  3 17:42:57 cfhat12 kernel: [   95.590293] Xenomai: native skin init failed, code -19.
Jan  3 17:44:00 cfhat12 kernel: [  158.228673] Xenomai: starting POSIX services.
Jan  3 17:44:00 cfhat12 kernel: [  158.430504] Xenomai: POSIX skin init failed, code -19.
Jan  3 17:44:03 cfhat12 kernel: [  161.982511] Xenomai: RTDM skin init failed, code -19.
Jan  3 17:45:59 cfhat12 kernel: [  277.621716] md: md7 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621743] md: md6 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621768] md: md5 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621791] md: md3 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621815] md: md2 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621841] md: md1 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621922] md: md7 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621961] md: md6 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.621983] md: md5 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.622006] md: md3 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.622033] md: md2 still in use.
Jan  3 17:45:59 cfhat12 kernel: [  277.622052] md: md1 still in use.
Jan  3 17:46:00 cfhat12 kernel: [  278.256271] fuse exit
Jan  3 17:46:02 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  3 17:46:55 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  3 17:46:55 cfhat12 kernel:    0.353052] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  3 17:46:55 cfhat12 kernel: [    0.353054] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  3 17:46:55 cfhat12 kernel: [    0.353055] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  3 17:46:55 cfhat12 kernel: [    0.353155] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353188] pci 0000:06:00.0: PME# supported from D3hot
Jan  3 17:46:55 cfhat12 kernel: [    0.353193] pci 0000:06:00.0: PME# disabled
Jan  3 17:46:55 cfhat12 kernel: [    0.353232] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353240] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  3 17:46:55 cfhat12 kernel: [    0.353247] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353255] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  3 17:46:55 cfhat12 kernel: [    0.353262] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  3 17:46:55 cfhat12 kernel: [    0.353315] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:46:55 cfhat12 kernel: [    0.353319] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353322] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353326] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.353468] pci 0000:07:00.0: supports D1
Jan  3 17:46:55 cfhat12 kernel: [    0.353470] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  3 17:46:55 cfhat12 kernel: [    0.353475] pci 0000:07:00.0: PME# disabled
Jan  3 17:46:55 cfhat12 kernel: [    0.353494] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:46:55 cfhat12 kernel: [    0.353498] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353501] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353505] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.353605] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353616] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353626] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353636] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353646] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  3 17:46:55 cfhat12 kernel: [    0.353657] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  3 17:46:55 cfhat12 kernel: [    0.353745] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:46:55 cfhat12 kernel: [    0.353750] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353756] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.353761] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.353787] pci_bus 0000:00: on NUMA node 0
Jan  3 17:46:55 cfhat12 kernel: [    0.353790] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354011] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354048] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354091] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354169] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354205] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354240] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.354279] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  3 17:46:55 cfhat12 kernel: [    0.371236] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371303] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371369] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371434] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371500] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371564] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371630] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371695] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  3 17:46:55 cfhat12 kernel: [    0.371844] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  3 17:46:55 cfhat12 kernel: [    0.371849] vgaarb: loaded
Jan  3 17:46:55 cfhat12 kernel: [    0.371960] PCI: Using ACPI for IRQ routing
Jan  3 17:46:55 cfhat12 kernel: [    0.371963] PCI: pci_cache_line_size set to 64 bytes
Jan  3 17:46:55 cfhat12 kernel: [    0.371969] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.372072] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  3 17:46:55 cfhat12 kernel: [    0.372073] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  3 17:46:55 cfhat12 kernel: [    0.372195] Switching to clocksource tsc
Jan  3 17:46:55 cfhat12 kernel: [    0.372236] pnp: PnP ACPI init
Jan  3 17:46:55 cfhat12 kernel: [    0.372240] ACPI: bus type pnp registered
Jan  3 17:46:55 cfhat12 kernel: [    0.372776] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.372802] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.372806] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.373999] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374002] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374005] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374008] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374010] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374013] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  3 17:46:55 cfhat12 kernel: [    0.374101] pnp: PnP ACPI: found 11 devices
Jan  3 17:46:55 cfhat12 kernel: [    0.374102] ACPI: ACPI bus type pnp unregistered
Jan  3 17:46:55 cfhat12 kernel: [    0.374108] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374110] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374112] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374115] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374118] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374119] system 00:02: [io  0x040b] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374121] system 00:02: [io  0x04d6] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374123] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374124] system 00:02: [io  0x0c14] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374126] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374128] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374129] system 00:02: [io  0x0c6f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374131] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374133] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374135] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374136] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374138] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374140] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374141] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374143] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374145] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374149] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374153] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374155] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374156] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374158] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374160] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374162] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.374164] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  3 17:46:55 cfhat12 kernel: [    0.380364] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  3 17:46:55 cfhat12 kernel: [    0.380366] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380368] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380370] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380374] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380376] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  3 17:46:55 cfhat12 kernel: [    0.380378] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380380] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380382] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380385] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  3 17:46:55 cfhat12 kernel: [    0.380387] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380389] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380392] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380395] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380396] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  3 17:46:55 cfhat12 kernel: [    0.380398] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380400] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380403] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380406] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  3 17:46:55 cfhat12 kernel: [    0.380408] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380412] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380415] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380419] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  3 17:46:55 cfhat12 kernel: [    0.380422] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380425] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380428] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380432] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  3 17:46:55 cfhat12 kernel: [    0.380435] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380443] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380448] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380458] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  3 17:46:55 cfhat12 kernel: [    0.380460] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380463] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380466] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380480] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:46:55 cfhat12 kernel: [    0.380482] pci 0000:00:07.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380490] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.380492] pci 0000:00:09.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380499] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.380501] pci 0000:00:0a.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380509] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.380511] pci 0000:00:15.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380517] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.380519] pci 0000:00:15.1: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380530] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.380535] pci 0000:07:00.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.380539] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:46:55 cfhat12 kernel: [    0.380540] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380542] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380543] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380545] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380546] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380548] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380549] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380551] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380553] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380554] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380556] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380557] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380559] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380560] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380562] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380563] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380565] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380567] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380568] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380570] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  3 17:46:55 cfhat12 kernel: [    0.380571] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380573] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380574] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380575] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380577] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380578] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380580] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380582] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380583] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380585] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380586] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380588] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  3 17:46:55 cfhat12 kernel: [    0.380589] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  3 17:46:55 cfhat12 kernel: [    0.380639] NET: Registered protocol family 2
Jan  3 17:46:55 cfhat12 kernel: [    0.380683] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.381108] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.381982] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.382221] TCP: Hash tables configured (established 262144 bind 65536)
Jan  3 17:46:55 cfhat12 kernel: [    0.382222] TCP reno registered
Jan  3 17:46:55 cfhat12 kernel: [    0.382225] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.382261] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.382393] NET: Registered protocol family 1
Jan  3 17:46:55 cfhat12 kernel: [    0.382402] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  3 17:46:55 cfhat12 kernel: [    0.443876] pci 0000:01:05.0: Boot video device
Jan  3 17:46:55 cfhat12 kernel: [    0.443915] PCI: CLS 4 bytes, default 64
Jan  3 17:46:55 cfhat12 kernel: [    0.443951] Unpacking initramfs...
Jan  3 17:46:55 cfhat12 kernel: [    0.506034] Freeing initrd memory: 4404k freed
Jan  3 17:46:55 cfhat12 kernel: [    0.507257] PCI-DMA: Disabling AGP.
Jan  3 17:46:55 cfhat12 kernel: [    0.507357] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  3 17:46:55 cfhat12 kernel: [    0.507358] PCI-DMA: using GART IOMMU.
Jan  3 17:46:55 cfhat12 kernel: [    0.507360] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  3 17:46:55 cfhat12 kernel: [    0.511332] I-pipe: Domain Xenomai registered.
Jan  3 17:46:55 cfhat12 kernel: [    0.511397] Xenomai: hal/x86_64 started.
Jan  3 17:46:55 cfhat12 kernel: [    0.511407] Xenomai: scheduling class idle registered.
Jan  3 17:46:55 cfhat12 kernel: [    0.511409] Xenomai: scheduling class rt registered.
Jan  3 17:46:55 cfhat12 kernel: [    0.512350] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  3 17:46:55 cfhat12 kernel: [    0.512663] VFS: Disk quotas dquot_6.5.2
Jan  3 17:46:55 cfhat12 kernel: [    0.512682] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  3 17:46:55 cfhat12 kernel: [    0.512732] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  3 17:46:55 cfhat12 kernel: [    0.512977] SGI XFS Quota Management subsystem
Jan  3 17:46:55 cfhat12 kernel: [    0.512982] msgmni has been set to 14978
Jan  3 17:46:55 cfhat12 kernel: [    0.513107] alg: No test for stdrng (krng)
Jan  3 17:46:55 cfhat12 kernel: [    0.513114] io scheduler noop registered
Jan  3 17:46:55 cfhat12 kernel: [    0.513116] io scheduler deadline registered
Jan  3 17:46:55 cfhat12 kernel: [    0.513127] io scheduler cfq registered (default)
Jan  3 17:46:55 cfhat12 kernel: [    0.513213] pcieport 0000:00:07.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.513234] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.513301] pcieport 0000:00:09.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.513318] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.513382] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.513398] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.513466] pcieport 0000:00:15.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.513496] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.513575] pcieport 0000:00:15.1: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.513605] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.514737] Linux agpgart interface v0.103
Jan  3 17:46:55 cfhat12 kernel: [    0.514806] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  3 17:46:55 cfhat12 kernel: [    0.514808] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  3 17:46:55 cfhat12 kernel: [    0.514931] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  3 17:46:55 cfhat12 kernel: [    0.515039] mice: PS/2 mouse device common for all mice
Jan  3 17:46:55 cfhat12 kernel: [    0.515066] Driver for 1-wire Dallas network protocol.
Jan  3 17:46:55 cfhat12 kernel: [    0.515135] cpuidle: using governor ladder
Jan  3 17:46:55 cfhat12 kernel: [    0.515257] TCP bic registered
Jan  3 17:46:55 cfhat12 kernel: [    0.515259] NET: Registered protocol family 17
Jan  3 17:46:55 cfhat12 kernel: [    0.515686] Freeing unused kernel memory: 408k freed
Jan  3 17:46:55 cfhat12 kernel: [    0.539962] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  3 17:46:55 cfhat12 kernel: [    0.539964] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  3 17:46:55 cfhat12 kernel: [    0.539997] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:46:55 cfhat12 kernel: [    0.540013] e1000e 0000:02:00.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.540161] e1000e 0000:02:00.0: irq 45 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.540163] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.540165] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.540653] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  3 17:46:55 cfhat12 kernel: [    0.543557] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  3 17:46:55 cfhat12 kernel: [    0.543577] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.543620] r8169 0000:04:00.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.543656] r8169 0000:04:00.0: irq 48 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.543791] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc9000004a000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 48
Jan  3 17:46:55 cfhat12 kernel: [    0.571448] Uniform Multi-Platform E-IDE driver
Jan  3 17:46:55 cfhat12 kernel: [    0.571897] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  3 17:46:55 cfhat12 kernel: [    0.572866] usbcore: registered new interface driver usbfs
Jan  3 17:46:55 cfhat12 kernel: [    0.572881] usbcore: registered new interface driver hub
Jan  3 17:46:55 cfhat12 kernel: [    0.573697] SCSI subsystem initialized
Jan  3 17:46:55 cfhat12 kernel: [    0.583193] usbcore: registered new device driver usb
Jan  3 17:46:55 cfhat12 kernel: [    0.584517] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  3 17:46:55 cfhat12 kernel: [    0.584537] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.584564] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.584577] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  3 17:46:55 cfhat12 kernel: [    0.584602] ehci_hcd 0000:00:12.2: debug port 1
Jan  3 17:46:55 cfhat12 kernel: [    0.584623] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  3 17:46:55 cfhat12 kernel: [    0.585590] libata version 3.00 loaded.
Jan  3 17:46:55 cfhat12 kernel: [    0.599844] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  3 17:46:55 cfhat12 kernel: [    0.599942] hub 1-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.599945] hub 1-0:1.0: 5 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.599985] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.600004] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.600010] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  3 17:46:55 cfhat12 kernel: [    0.600030] ehci_hcd 0000:00:13.2: debug port 1
Jan  3 17:46:55 cfhat12 kernel: [    0.600040] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  3 17:46:55 cfhat12 kernel: [    0.605342] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  3 17:46:55 cfhat12 kernel: [    0.605348] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.605372] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.605420] scsi0 : pata_jmicron
Jan  3 17:46:55 cfhat12 kernel: [    0.605490] scsi1 : pata_jmicron
Jan  3 17:46:55 cfhat12 kernel: [    0.605511] ata1: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  3 17:46:55 cfhat12 kernel: [    0.605513] ata2: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  3 17:46:55 cfhat12 kernel: [    0.615839] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  3 17:46:55 cfhat12 kernel: [    0.615899] hub 2-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.615902] hub 2-0:1.0: 5 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.615937] ahci 0000:00:11.0: version 3.0
Jan  3 17:46:55 cfhat12 kernel: [    0.615944] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  3 17:46:55 cfhat12 kernel: [    0.615989] ahci 0000:00:11.0: irq 49 for MSI/MSI-X
Jan  3 17:46:55 cfhat12 kernel: [    0.616050] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  3 17:46:55 cfhat12 kernel: [    0.616052] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  3 17:46:55 cfhat12 kernel: [    0.616228] scsi2 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.616266] scsi3 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.616301] scsi4 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.616337] scsi5 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.616434] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 49
Jan  3 17:46:55 cfhat12 kernel: [    0.616437] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 49
Jan  3 17:46:55 cfhat12 kernel: [    0.616439] ata5: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 49
Jan  3 17:46:55 cfhat12 kernel: [    0.616441] ata6: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 49
Jan  3 17:46:55 cfhat12 kernel: [    0.616475] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.616510] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.616556] scsi6 : pata_atiixp
Jan  3 17:46:55 cfhat12 kernel: [    0.616587] scsi7 : pata_atiixp
Jan  3 17:46:55 cfhat12 kernel: [    0.617320] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  3 17:46:55 cfhat12 kernel: [    0.617322] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  3 17:46:55 cfhat12 kernel: [    0.617371] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    0.617385] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.617396] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  3 17:46:55 cfhat12 kernel: [    0.617425] ehci_hcd 0000:00:16.2: debug port 1
Jan  3 17:46:55 cfhat12 kernel: [    0.617435] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  3 17:46:55 cfhat12 kernel: [    0.627848] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  3 17:46:55 cfhat12 kernel: [    0.627903] hub 3-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.627906] hub 3-0:1.0: 4 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.631865] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  3 17:46:55 cfhat12 kernel: [    0.631868] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  3 17:46:55 cfhat12 kernel: [    0.631872] ahci 0000:06:00.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    0.631975] scsi8 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.632020] scsi9 : ahci
Jan  3 17:46:55 cfhat12 kernel: [    0.632044] ata9: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  3 17:46:55 cfhat12 kernel: [    0.632047] ata10: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  3 17:46:55 cfhat12 kernel: [    0.657005] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  3 17:46:55 cfhat12 kernel: [    0.657007] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  3 17:46:55 cfhat12 kernel: [    0.657019] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  3 17:46:55 cfhat12 kernel: [    0.696831] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  3 17:46:55 cfhat12 kernel: [    0.696845] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.696862] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.696869] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  3 17:46:55 cfhat12 kernel: [    0.696893] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  3 17:46:55 cfhat12 kernel: [    0.755887] hub 4-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.755892] hub 4-0:1.0: 5 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.755927] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.755945] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.755950] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  3 17:46:55 cfhat12 kernel: [    0.755962] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  3 17:46:55 cfhat12 kernel: [    0.788114] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  3 17:46:55 cfhat12 kernel: [    0.788127] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  3 17:46:55 cfhat12 kernel: [    0.804112] ata7.00: configured for UDMA/33
Jan  3 17:46:55 cfhat12 kernel: [    0.815895] hub 5-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.815902] hub 5-0:1.0: 5 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.815942] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.815956] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.815960] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  3 17:46:55 cfhat12 kernel: [    0.815972] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  3 17:46:55 cfhat12 kernel: [    0.875894] hub 6-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.875898] hub 6-0:1.0: 2 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.875928] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  3 17:46:55 cfhat12 kernel: [    0.875942] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    0.875946] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  3 17:46:55 cfhat12 kernel: [    0.875958] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  3 17:46:55 cfhat12 kernel: [    0.939866] ata5: SATA link down (SStatus 0 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    0.939896] hub 7-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    0.939901] hub 7-0:1.0: 4 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    0.947877] ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    0.955877] ata10: SATA link down (SStatus 0 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    0.959876] ata9: SATA link down (SStatus 0 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    1.123889] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    1.125383] ata3.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  3 17:46:55 cfhat12 kernel: [    1.125386] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  3 17:46:55 cfhat12 kernel: [    1.126918] ata3.00: configured for UDMA/133
Jan  3 17:46:55 cfhat12 kernel: [    1.143953] scsi 2:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  3 17:46:55 cfhat12 kernel: [    1.151877] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  3 17:46:55 cfhat12 kernel: [    1.167886] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:46:55 cfhat12 kernel: [    1.170843] ata4.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  3 17:46:55 cfhat12 kernel: [    1.170845] ata4.00: 312581808 sectors, multi 16: LBA48 
Jan  3 17:46:55 cfhat12 kernel: [    1.173926] ata4.00: configured for UDMA/133
Jan  3 17:46:55 cfhat12 kernel: [    1.191927] scsi 3:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  3 17:46:55 cfhat12 kernel: [    1.192709] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  3 17:46:55 cfhat12 kernel: [    1.195900] sd 2:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:46:55 cfhat12 kernel: [    1.195927] sd 3:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  3 17:46:55 cfhat12 kernel: [    1.195930] sd 2:0:0:0: [sda] Write Protect is off
Jan  3 17:46:55 cfhat12 kernel: [    1.195932] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  3 17:46:55 cfhat12 kernel: [    1.195945] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:46:55 cfhat12 kernel: [    1.195957] sd 3:0:0:0: [sdb] Write Protect is off
Jan  3 17:46:55 cfhat12 kernel: [    1.195959] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  3 17:46:55 cfhat12 kernel: [    1.195970] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  3 17:46:55 cfhat12 kernel: [    1.196043]  sda:
Jan  3 17:46:55 cfhat12 kernel: [    1.196128]  sdb: sda1 sda2 sda3 sda4 < sdb1 sdb2 sdb3 sdb4 < sda5 sdb5 sda6 sdb6 sda7 >
Jan  3 17:46:55 cfhat12 kernel: [    1.232617] sd 2:0:0:0: [sda] Attached SCSI disk
Jan  3 17:46:55 cfhat12 kernel: [    1.236481]  sdb7 >
Jan  3 17:46:55 cfhat12 kernel: [    1.236719] sd 3:0:0:0: [sdb] Attached SCSI disk
Jan  3 17:46:55 cfhat12 kernel: [    1.242297] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  3 17:46:55 cfhat12 kernel: [    1.242299] Uniform CD-ROM driver Revision: 3.20
Jan  3 17:46:55 cfhat12 kernel: [    1.242344] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  3 17:46:55 cfhat12 kernel: [    1.341183] usbcore: registered new interface driver hiddev
Jan  3 17:46:55 cfhat12 kernel: [    1.345019] input: USBPS2 as /class/input/input1
Jan  3 17:46:55 cfhat12 kernel: [    1.345027] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  3 17:46:55 cfhat12 kernel: [    1.352077] input: USBPS2 as /class/input/input2
Jan  3 17:46:55 cfhat12 kernel: [    1.352099] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  3 17:46:55 cfhat12 kernel: [    1.352107] usbcore: registered new interface driver usbhid
Jan  3 17:46:55 cfhat12 kernel: [    1.352108] usbhid: USB HID core driver
Jan  3 17:46:55 cfhat12 kernel: [    1.515681] md: raid1 personality registered for level 1
Jan  3 17:46:55 cfhat12 kernel: [    1.521695] md: md1 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    1.522674] md: bind<sdb1>
Jan  3 17:46:55 cfhat12 kernel: [    1.522861] md: bind<sda1>
Jan  3 17:46:55 cfhat12 kernel: [    1.523917] md/raid1:md1: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    1.523931] md1: detected capacity change from 0 to 254791680
Jan  3 17:46:55 cfhat12 kernel: [    1.524418]  md1: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    1.736112] md: md2 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    1.736851] md: bind<sdb2>
Jan  3 17:46:55 cfhat12 kernel: [    1.736975] md: bind<sda2>
Jan  3 17:46:55 cfhat12 kernel: [    1.737684] md/raid1:md2: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    1.737700] md2: detected capacity change from 0 to 19998367744
Jan  3 17:46:55 cfhat12 kernel: [    1.738186]  md2: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    1.948012] md: md3 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    1.948873] md: bind<sdb3>
Jan  3 17:46:55 cfhat12 kernel: [    1.948998] md: bind<sda3>
Jan  3 17:46:55 cfhat12 kernel: [    1.949705] md/raid1:md3: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    1.949720] md3: detected capacity change from 0 to 1998573568
Jan  3 17:46:55 cfhat12 kernel: [    1.950179]  md3: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    2.171077] md: md5 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    2.172047] md: bind<sdb5>
Jan  3 17:46:55 cfhat12 kernel: [    2.172270] md: bind<sda5>
Jan  3 17:46:55 cfhat12 kernel: [    2.172987] md/raid1:md5: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    2.173002] md5: detected capacity change from 0 to 19997319168
Jan  3 17:46:55 cfhat12 kernel: [    2.173483]  md5: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    2.403614] md: md6 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    2.404633] md: bind<sdb6>
Jan  3 17:46:55 cfhat12 kernel: [    2.404849] md: bind<sda6>
Jan  3 17:46:55 cfhat12 kernel: [    2.405583] md/raid1:md6: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    2.405596] md6: detected capacity change from 0 to 19997319168
Jan  3 17:46:55 cfhat12 kernel: [    2.406065]  md6: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    2.629790] md: md7 stopped.
Jan  3 17:46:55 cfhat12 kernel: [    2.630521] md: bind<sdb7>
Jan  3 17:46:55 cfhat12 kernel: [    2.630733] md: bind<sda7>
Jan  3 17:46:55 cfhat12 kernel: [    2.631450] md/raid1:md7: active with 2 out of 2 mirrors
Jan  3 17:46:55 cfhat12 kernel: [    2.631464] md7: detected capacity change from 0 to 97784881152
Jan  3 17:46:55 cfhat12 kernel: [    2.631964]  md7: unknown partition table
Jan  3 17:46:55 cfhat12 kernel: [    2.870598] XFS mounting filesystem md2
Jan  3 17:46:55 cfhat12 kernel: [    3.027406] Ending clean XFS mount for filesystem: md2
Jan  3 17:46:55 cfhat12 kernel: [    4.593502] udev[890]: starting version 164
Jan  3 17:46:55 cfhat12 kernel: [    4.855385] input: Power Button as /class/input/input3
Jan  3 17:46:55 cfhat12 kernel: [    4.855389] ACPI: Power Button [PWRB]
Jan  3 17:46:55 cfhat12 kernel: [    4.855441] input: Power Button as /class/input/input4
Jan  3 17:46:55 cfhat12 kernel: [    4.855443] ACPI: Power Button [PWRF]
Jan  3 17:46:55 cfhat12 kernel: [    4.882838] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
Jan  3 17:46:55 cfhat12 kernel: [    4.882926] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.884071] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902125] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:46:55 cfhat12 kernel: [    4.902214] 0000:05:06.0: ttyS4 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902301] 0000:05:06.0: ttyS5 at I/O 0xae00 (irq = 20) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902388] 0000:05:06.0: ttyS1 at I/O 0xad00 (irq = 20) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902564] 0000:05:06.0: ttyS2 at I/O 0xac00 (irq = 20) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902589] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  3 17:46:55 cfhat12 kernel: [    4.902663] 0000:05:06.1: ttyS3 at I/O 0xab00 (irq = 20) is a 16550A
Jan  3 17:46:55 cfhat12 kernel: [    4.902680] Couldn't register serial port 0000:05:06.1: -28
Jan  3 17:46:55 cfhat12 kernel: [    4.967132] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  3 17:46:55 cfhat12 kernel: [    4.971156] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  3 17:46:55 cfhat12 kernel: [    4.971158] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  3 17:46:55 cfhat12 kernel: [    4.971159] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  3 17:46:55 cfhat12 kernel: [    4.973219] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  3 17:46:55 cfhat12 kernel: [    4.980111] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    4.980114] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    4.980191] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:46:55 cfhat12 kernel: [    5.001776] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    5.001850] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  3 17:46:55 cfhat12 kernel: [    5.001852] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  3 17:46:55 cfhat12 kernel: [    5.001861] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  3 17:46:55 cfhat12 kernel: [    5.001960] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  3 17:46:55 cfhat12 kernel: [    5.005338] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  3 17:46:55 cfhat12 kernel: [    5.005409] xHCI xhci_add_endpoint called for root hub
Jan  3 17:46:55 cfhat12 kernel: [    5.005411] xHCI xhci_check_bandwidth called for root hub
Jan  3 17:46:55 cfhat12 kernel: [    5.005429] hub 8-0:1.0: USB hub found
Jan  3 17:46:55 cfhat12 kernel: [    5.005432] hub 8-0:1.0: 4 ports detected
Jan  3 17:46:55 cfhat12 kernel: [    5.019801] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [mem 0x00000b00-0x00000b0f window]
Jan  3 17:46:55 cfhat12 kernel: [    5.019804] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  3 17:46:55 cfhat12 kernel: [    5.024763] rtc_cmos 00:04: RTC can wake from S4
Jan  3 17:46:55 cfhat12 kernel: [    5.024794] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  3 17:46:55 cfhat12 kernel: [    5.024815] rtc0: alarms up to one month, 242 bytes nvram
Jan  3 17:46:55 cfhat12 kernel: [    5.076147] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  3 17:46:55 cfhat12 kernel: [    5.076224] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  3 17:46:55 cfhat12 kernel: [    6.211443] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  3 17:46:55 cfhat12 kernel: [    6.726712] loop: module loaded
Jan  3 17:46:55 cfhat12 kernel: [   21.445316] EXT3-fs: barriers not enabled
Jan  3 17:46:55 cfhat12 kernel: [   21.454563] kjournald starting.  Commit interval 5 seconds
Jan  3 17:46:55 cfhat12 kernel: [   21.460898] EXT3-fs (md1): using internal journal
Jan  3 17:46:55 cfhat12 kernel: [   21.460901] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  3 17:46:55 cfhat12 kernel: [   21.551199] XFS mounting filesystem md7
Jan  3 17:46:55 cfhat12 kernel: [   21.660794] Ending clean XFS mount for filesystem: md7
Jan  3 17:46:55 cfhat12 kernel: [   21.784065] XFS mounting filesystem md5
Jan  3 17:46:55 cfhat12 kernel: [   21.965961] Ending clean XFS mount for filesystem: md5
Jan  3 17:46:55 cfhat12 kernel: [   21.998932] EXT3-fs: barriers not enabled
Jan  3 17:46:55 cfhat12 kernel: [   22.007107] kjournald starting.  Commit interval 5 seconds
Jan  3 17:46:55 cfhat12 kernel: [   22.029941] EXT3-fs (md6): using internal journal
Jan  3 17:46:55 cfhat12 kernel: [   22.029945] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  3 17:46:55 cfhat12 kernel: [   23.035573] fuse init (API version 7.14)
Jan  3 17:46:55 cfhat12 kernel: [   23.225588] r8169 0000:04:00.0: eth0: link up
Jan  3 17:46:55 cfhat12 kernel: [   23.225593] r8169 0000:04:00.0: eth0: link up
Jan  4 10:17:59 cfhat12 kernel: [59487.912052] Xenomai: native skin init failed, code -19.
Jan  4 13:22:33 cfhat12 kernel: [70561.748818] md: md7 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.748843] md: md6 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.748864] md: md5 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.748886] md: md3 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.748910] md: md2 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.748934] md: md1 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749010] md: md7 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749046] md: md6 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749066] md: md5 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749086] md: md3 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749105] md: md2 still in use.
Jan  4 13:22:33 cfhat12 kernel: [70561.749124] md: md1 still in use.
Jan  4 13:22:34 cfhat12 kernel: [70562.782301] fuse exit
Jan  4 13:22:39 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  4 13:28:21 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Linux version 2.6.32-5-amd64 (Debian 2.6.32-29) (ben@domain.hid) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Fri Dec 10 15:35:08 UTC 2010
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] KERNEL supported cpus:
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   Intel GenuineIntel
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   AMD AuthenticAMD
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   Centaur CentaurHauls
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   6 disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   7 disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] RAMDISK: 376ee000 - 37feff7b
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Scanning NUMA topology in Northbridge 24
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] No NUMA configuration found
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Faking a node at 0000000000000000-0000000210000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Bootmem setup node 0 0000000000000000-0000000210000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   NODE_DATA [000000000000b000 - 0000000000012fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   bootmap [0000000000013000 -  0000000000054fff] pages 42
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0210000000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #2 [0001000000 - 000168a414]    TEXT DATA BSS ==> [0001000000 - 000168a414]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #3 [00376ee000 - 0037feff7b]          RAMDISK ==> [00376ee000 - 0037feff7b]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #5 [000168b000 - 000168b0fe]              BRK ==> [000168b000 - 000168b0fe]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   #7 [000000a000 - 000000b000]          PGTABLE ==> [000000a000 - 000000b000]
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880001800000-ffff8800081fffff] on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA      0x00000000 -> 0x00001000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]     0: 0x00000000 -> 0x0000009f
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965455
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA zone: 102 pages reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA zone: 3841 pages, LIFO batch:0
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  4 13:28:21 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 24
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf0000 - 00000000cfdf1000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfdf1000 - 00000000cfe00000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cfe00000 - 00000000cff00000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000cff00000 - 00000000e0000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000fec00000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 00000000fec00000 - 0000000100000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Booting paravirtualized kernel on bare hardware
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880008400000 s90328 r8192 d24360 u262144
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] pcpu-alloc: s90328 r8192 d24360 u262144 alloc=1*2097152
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935785
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Policy zone: Normal
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.32-5-amd64 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Initializing CPU#0
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Node 0: aperture @ d90000000 size 32 MB
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000024000000
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Memory: 7670416k/8650752k available (3078k kernel code, 788932k absent, 191404k reserved, 1892k data, 592k init)
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] NR_IRQS:4352 nr_irqs:472
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  4 13:28:21 cfhat12 kernel: [    0.000000] Detected 3277.195 MHz processor.
Jan  4 13:28:21 cfhat12 kernel: [    0.008005] Calibrating delay loop (skipped), value calculated using timer frequency.. 6829.63 BogoMIPS (lpj=13659268)
Jan  4 13:28:21 cfhat12 kernel: [    0.008029] Security Framework initialized
Jan  4 13:28:21 cfhat12 kernel: [    0.008032] SELinux:  Disabled at boot.
Jan  4 13:28:21 cfhat12 kernel: [    0.008420] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.012965] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.013914] Mount-cache hash table entries: 256
Jan  4 13:28:21 cfhat12 kernel: [    0.014006] Initializing cgroup subsys ns
Jan  4 13:28:21 cfhat12 kernel: [    0.014008] Initializing cgroup subsys cpuacct
Jan  4 13:28:21 cfhat12 kernel: [    0.014011] Initializing cgroup subsys devices
Jan  4 13:28:21 cfhat12 kernel: [    0.014012] Initializing cgroup subsys freezer
Jan  4 13:28:21 cfhat12 kernel: [    0.014013] Initializing cgroup subsys net_cls
Jan  4 13:28:21 cfhat12 kernel: [    0.014028] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.014029] CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.014030] CPU 0/0x0 -> Node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.014033] tseg: 00cff00000
Jan  4 13:28:21 cfhat12 kernel: [    0.014034] CPU: Physical Processor ID: 0
Jan  4 13:28:21 cfhat12 kernel: [    0.014035] CPU: Processor Core ID: 0
Jan  4 13:28:21 cfhat12 kernel: [    0.014036] mce: CPU supports 6 MCE banks
Jan  4 13:28:21 cfhat12 kernel: [    0.014043] using C1E aware idle routine
Jan  4 13:28:21 cfhat12 kernel: [    0.014044] Performance Events: AMD PMU driver.
Jan  4 13:28:21 cfhat12 kernel: [    0.014047] ... version:                0
Jan  4 13:28:21 cfhat12 kernel: [    0.014048] ... bit width:              48
Jan  4 13:28:21 cfhat12 kernel: [    0.014049] ... generic registers:      4
Jan  4 13:28:21 cfhat12 kernel: [    0.014050] ... value mask:             0000ffffffffffff
Jan  4 13:28:21 cfhat12 kernel: [    0.014051] ... max period:             00007fffffffffff
Jan  4 13:28:21 cfhat12 kernel: [    0.014052] ... fixed-purpose events:   0
Jan  4 13:28:21 cfhat12 kernel: [    0.014052] ... event mask:             000000000000000f
Jan  4 13:28:21 cfhat12 kernel: [    0.014560] ACPI: Core revision 20090903
Jan  4 13:28:21 cfhat12 kernel: [    0.020066] Setting APIC routing to flat
Jan  4 13:28:21 cfhat12 kernel: [    0.020457] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  4 13:28:21 cfhat12 kernel: [    0.061498] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:28:21 cfhat12 kernel: [    0.064001] Booting processor 1 APIC 0x1 ip 0x6000
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] Initializing CPU#1
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU 1/0x1 -> Node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 1
Jan  4 13:28:21 cfhat12 kernel: [    0.148024] CPU1: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:28:21 cfhat12 kernel: [    0.148031] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Jan  4 13:28:21 cfhat12 kernel: [    0.152020] System has AMD C1E enabled
Jan  4 13:28:21 cfhat12 kernel: [    0.152026] Switch to broadcast mode on CPU1
Jan  4 13:28:21 cfhat12 kernel: [    0.152090] Booting processor 2 APIC 0x2 ip 0x6000
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] Initializing CPU#2
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU 2/0x2 -> Node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 3
Jan  4 13:28:21 cfhat12 kernel: [    0.240065] CPU2: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:28:21 cfhat12 kernel: [    0.240069] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Jan  4 13:28:21 cfhat12 kernel: [    0.244016] Switch to broadcast mode on CPU2
Jan  4 13:28:21 cfhat12 kernel: [    0.244047] Booting processor 3 APIC 0x3 ip 0x6000
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] Initializing CPU#3
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU 3/0x3 -> Node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Physical Processor ID: 0
Jan  4 13:28:21 cfhat12 kernel: [    0.012000] CPU: Processor Core ID: 2
Jan  4 13:28:21 cfhat12 kernel: [    0.332022] CPU3: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:28:21 cfhat12 kernel: [    0.332026] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Jan  4 13:28:21 cfhat12 kernel: [    0.336020] Brought up 4 CPUs
Jan  4 13:28:21 cfhat12 kernel: [    0.336022] Total of 4 processors activated (27321.83 BogoMIPS).
Jan  4 13:28:21 cfhat12 kernel: [    0.336019] Switch to broadcast mode on CPU3
Jan  4 13:28:21 cfhat12 kernel: [    0.337770] CPU0 attaching sched-domain:
Jan  4 13:28:21 cfhat12 kernel: [    0.337771]  domain 0: span 0-3 level MC
Jan  4 13:28:21 cfhat12 kernel: [    0.337773]   groups: 0 1 2 3
Jan  4 13:28:21 cfhat12 kernel: [    0.337777] CPU1 attaching sched-domain:
Jan  4 13:28:21 cfhat12 kernel: [    0.337779]  domain 0: span 0-3 level MC
Jan  4 13:28:21 cfhat12 kernel: [    0.337780]   groups: 1 2 3 0
Jan  4 13:28:21 cfhat12 kernel: [    0.337783] CPU2 attaching sched-domain:
Jan  4 13:28:21 cfhat12 kernel: [    0.337784]  domain 0: span 0-3 level MC
Jan  4 13:28:21 cfhat12 kernel: [    0.337785]   groups: 2 3 0 1
Jan  4 13:28:21 cfhat12 kernel: [    0.337789] CPU3 attaching sched-domain:
Jan  4 13:28:21 cfhat12 kernel: [    0.337790]  domain 0: span 0-3 level MC
Jan  4 13:28:21 cfhat12 kernel: [    0.337791]   groups: 3 0 1 2
Jan  4 13:28:21 cfhat12 kernel: [    0.337853] Switch to broadcast mode on CPU0
Jan  4 13:28:21 cfhat12 kernel: [    0.337853] devtmpfs: initialized
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] regulator: core version 0.5
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] NET: Registered protocol family 16
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] node 0 link 0: io port [8000, ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] TOM: 00000000d0000000 aka 3328M
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] Fam 10h mmconf [e0000000, e00fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] node 0 link 0: mmio [a0000, bffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] node 0 link 0: mmio [d0000000, dfffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] TOM2: 0000000230000000 aka 8960M
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] bus: [00,08] on node 0 link 0
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] bus: 00 index 0 io port: [0, ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] bus: 00 index 1 mmio: [a0000, bffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] bus: 00 index 2 mmio: [d0000000, dfffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340112] bus: 00 index 3 mmio: [e0900000, ffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340113] bus: 00 index 4 mmio: [e0100000, e08fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340114] bus: 00 index 5 mmio: [230000000, fcffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.340122] ACPI: bus type pci registered
Jan  4 13:28:21 cfhat12 kernel: [    0.340167] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
Jan  4 13:28:21 cfhat12 kernel: [    0.340169] PCI: MCFG area at e0000000 reserved in E820
Jan  4 13:28:21 cfhat12 kernel: [    0.346005] PCI: Using MMCONFIG at e0000000 - efffffff
Jan  4 13:28:21 cfhat12 kernel: [    0.346008] PCI: Using configuration type 1 for base access
Jan  4 13:28:21 cfhat12 kernel: [    0.346285] bio: create slab <bio-0> at 0
Jan  4 13:28:21 cfhat12 kernel: [    0.348264] ACPI: EC: Look up EC in DSDT
Jan  4 13:28:21 cfhat12 kernel: [    0.356042] ACPI: Interpreter enabled
Jan  4 13:28:21 cfhat12 kernel: [    0.356046] ACPI: (supports S0 S3 S4 S5)
Jan  4 13:28:21 cfhat12 kernel: [    0.356063] ACPI: Using IOAPIC for interrupt routing
Jan  4 13:28:21 cfhat12 kernel: [    0.359071] ACPI Warning: Incorrect checksum in table [TAMG] - 6A, should be 69 (20090903/tbutils-314)
Jan  4 13:28:21 cfhat12 kernel: [    0.359144] ACPI: No dock devices found.
Jan  4 13:28:21 cfhat12 kernel: [    0.359236] ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  4 13:28:21 cfhat12 kernel: [    0.359268] pci 0000:00:00.0: reg 1c 64bit mmio: [0xe0000000-0xffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359336] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.359339] pci 0000:00:07.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.359366] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.359368] pci 0000:00:09.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.359393] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.359395] pci 0000:00:0a.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.359435] pci 0000:00:11.0: reg 10 io port: [0xff00-0xff07]
Jan  4 13:28:21 cfhat12 kernel: [    0.359440] pci 0000:00:11.0: reg 14 io port: [0xfe00-0xfe03]
Jan  4 13:28:21 cfhat12 kernel: [    0.359444] pci 0000:00:11.0: reg 18 io port: [0xfd00-0xfd07]
Jan  4 13:28:21 cfhat12 kernel: [    0.359449] pci 0000:00:11.0: reg 1c io port: [0xfc00-0xfc03]
Jan  4 13:28:21 cfhat12 kernel: [    0.359453] pci 0000:00:11.0: reg 20 io port: [0xfb00-0xfb0f]
Jan  4 13:28:21 cfhat12 kernel: [    0.359458] pci 0000:00:11.0: reg 24 32bit mmio: [0xfe02f000-0xfe02f3ff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359470] pci 0000:00:11.0: set SATA to AHCI mode
Jan  4 13:28:21 cfhat12 kernel: [    0.359510] pci 0000:00:12.0: reg 10 32bit mmio: [0xfe02e000-0xfe02efff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359561] pci 0000:00:12.2: reg 10 32bit mmio: [0xfe02d000-0xfe02d0ff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359597] pci 0000:00:12.2: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.359599] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:28:21 cfhat12 kernel: [    0.359601] pci 0000:00:12.2: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.359624] pci 0000:00:13.0: reg 10 32bit mmio: [0xfe02c000-0xfe02cfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359675] pci 0000:00:13.2: reg 10 32bit mmio: [0xfe02b000-0xfe02b0ff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359712] pci 0000:00:13.2: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.359713] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:28:21 cfhat12 kernel: [    0.359715] pci 0000:00:13.2: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.359772] pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
Jan  4 13:28:21 cfhat12 kernel: [    0.359777] pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
Jan  4 13:28:21 cfhat12 kernel: [    0.359782] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
Jan  4 13:28:21 cfhat12 kernel: [    0.359786] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
Jan  4 13:28:21 cfhat12 kernel: [    0.359791] pci 0000:00:14.1: reg 20 io port: [0xfa00-0xfa0f]
Jan  4 13:28:21 cfhat12 kernel: [    0.359875] pci 0000:00:14.5: reg 10 32bit mmio: [0xfe02a000-0xfe02afff]
Jan  4 13:28:21 cfhat12 kernel: [    0.359942] pci 0000:00:15.0: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.359990] pci 0000:00:15.1: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.360001] pci 0000:00:16.0: reg 10 32bit mmio: [0xfe029000-0xfe029fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360001] pci 0000:00:16.2: reg 10 32bit mmio: [0xfe028000-0xfe0280ff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360001] pci 0000:00:16.2: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.360001] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:28:21 cfhat12 kernel: [    0.360001] pci 0000:00:16.2: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.360040] pci 0000:01:05.0: reg 10 32bit mmio pref: [0xd0000000-0xdfffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360043] pci 0000:01:05.0: reg 14 io port: [0xce00-0xceff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360045] pci 0000:01:05.0: reg 18 32bit mmio: [0xfd3e0000-0xfd3effff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360051] pci 0000:01:05.0: reg 24 32bit mmio: [0xfd200000-0xfd2fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360059] pci 0000:01:05.0: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.360074] pci 0000:01:05.1: reg 10 32bit mmio: [0xfd3fc000-0xfd3fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360089] pci 0000:01:05.1: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.360119] pci 0000:00:01.0: bridge io port: [0xc000-0xcfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360121] pci 0000:00:01.0: bridge 32bit mmio: [0xfd200000-0xfd3fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360124] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360174] pci 0000:02:00.0: reg 10 32bit mmio: [0xfdfc0000-0xfdfdffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360183] pci 0000:02:00.0: reg 14 32bit mmio: [0xfdf00000-0xfdf7ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360191] pci 0000:02:00.0: reg 18 io port: [0xbf00-0xbf1f]
Jan  4 13:28:21 cfhat12 kernel: [    0.360200] pci 0000:02:00.0: reg 1c 32bit mmio: [0xfdffc000-0xfdffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360223] pci 0000:02:00.0: reg 30 32bit mmio pref: [0x000000-0x03ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.360265] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.360270] pci 0000:02:00.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.368092] pci 0000:00:07.0: bridge io port: [0xb000-0xbfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.368095] pci 0000:00:07.0: bridge 32bit mmio: [0xfdf00000-0xfdffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.368097] pci 0000:00:07.0: bridge 64bit mmio pref: [0xfde00000-0xfdefffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.368134] pci 0000:03:00.0: reg 10 64bit mmio: [0xfddfe000-0xfddfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.368175] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.368178] pci 0000:03:00.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.376072] pci 0000:00:09.0: bridge io port: [0xe000-0xefff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376075] pci 0000:00:09.0: bridge 32bit mmio: [0xfdd00000-0xfddfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376077] pci 0000:00:09.0: bridge 64bit mmio pref: [0xfdc00000-0xfdcfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376110] pci 0000:04:00.0: reg 10 io port: [0xde00-0xdeff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376123] pci 0000:04:00.0: reg 18 64bit mmio pref: [0xfd4ff000-0xfd4fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376133] pci 0000:04:00.0: reg 20 64bit mmio pref: [0xfd4f8000-0xfd4fbfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376138] pci 0000:04:00.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.376165] pci 0000:04:00.0: supports D1 D2
Jan  4 13:28:21 cfhat12 kernel: [    0.376167] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  4 13:28:21 cfhat12 kernel: [    0.376170] pci 0000:04:00.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.384070] pci 0000:00:0a.0: bridge io port: [0xd000-0xdfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384072] pci 0000:00:0a.0: bridge 32bit mmio: [0xfd900000-0xfd9fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384075] pci 0000:00:0a.0: bridge 64bit mmio pref: [0xfd400000-0xfd4fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384107] pci 0000:05:06.0: reg 10 io port: [0xaf00-0xaf07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384114] pci 0000:05:06.0: reg 14 io port: [0xae00-0xae07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384120] pci 0000:05:06.0: reg 18 io port: [0xad00-0xad07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384127] pci 0000:05:06.0: reg 1c io port: [0xac00-0xac07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384170] pci 0000:05:06.1: reg 10 io port: [0xab00-0xab07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384176] pci 0000:05:06.1: reg 14 io port: [0xaa00-0xaa07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384183] pci 0000:05:06.1: reg 18 io port: [0xa900-0xa907]
Jan  4 13:28:21 cfhat12 kernel: [    0.384189] pci 0000:05:06.1: reg 1c io port: [0xa800-0xa807]
Jan  4 13:28:21 cfhat12 kernel: [    0.384238] pci 0000:05:08.0: reg 10 io port: [0xa700-0xa707]
Jan  4 13:28:21 cfhat12 kernel: [    0.384303] pci 0000:00:14.4: transparent bridge
Jan  4 13:28:21 cfhat12 kernel: [    0.384306] pci 0000:00:14.4: bridge io port: [0xa000-0xafff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384309] pci 0000:00:14.4: bridge 32bit mmio: [0xfdb00000-0xfdbfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384312] pci 0000:00:14.4: bridge 32bit mmio pref: [0xfda00000-0xfdafffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384392] pci 0000:06:00.0: reg 24 32bit mmio: [0xfd8fe000-0xfd8fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384427] pci 0000:06:00.0: PME# supported from D3hot
Jan  4 13:28:21 cfhat12 kernel: [    0.384431] pci 0000:06:00.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.384483] pci 0000:06:00.1: reg 10 io port: [0x9f00-0x9f07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384491] pci 0000:06:00.1: reg 14 io port: [0x9e00-0x9e03]
Jan  4 13:28:21 cfhat12 kernel: [    0.384498] pci 0000:06:00.1: reg 18 io port: [0x9d00-0x9d07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384506] pci 0000:06:00.1: reg 1c io port: [0x9c00-0x9c03]
Jan  4 13:28:21 cfhat12 kernel: [    0.384513] pci 0000:06:00.1: reg 20 io port: [0x9b00-0x9b0f]
Jan  4 13:28:21 cfhat12 kernel: [    0.384576] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  4 13:28:21 cfhat12 kernel: [    0.384641] pci 0000:00:15.0: bridge io port: [0x9000-0x9fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384644] pci 0000:00:15.0: bridge 32bit mmio: [0xfd800000-0xfd8fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384648] pci 0000:00:15.0: bridge 64bit mmio pref: [0xfd700000-0xfd7fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384778] pci 0000:07:00.0: supports D1
Jan  4 13:28:21 cfhat12 kernel: [    0.384779] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  4 13:28:21 cfhat12 kernel: [    0.384784] pci 0000:07:00.0: PME# disabled
Jan  4 13:28:21 cfhat12 kernel: [    0.384822] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Jan  4 13:28:21 cfhat12 kernel: [    0.384892] pci 0000:00:15.1: bridge io port: [0x8000-0x8fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384894] pci 0000:00:15.1: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384898] pci 0000:00:15.1: bridge 64bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.384935] pci 0000:08:00.0: reg 10 io port: [0x8f00-0x8f07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384946] pci 0000:08:00.0: reg 14 io port: [0x8e00-0x8e07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384956] pci 0000:08:00.0: reg 18 io port: [0x8d00-0x8d07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384967] pci 0000:08:00.0: reg 1c io port: [0x8c00-0x8c07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384977] pci 0000:08:00.0: reg 20 io port: [0x8b00-0x8b07]
Jan  4 13:28:21 cfhat12 kernel: [    0.384987] pci 0000:08:00.0: reg 24 io port: [0x8a00-0x8a0f]
Jan  4 13:28:21 cfhat12 kernel: [    0.385084] pci 0000:07:00.0: bridge io port: [0x8000-0x8fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.385090] pci 0000:07:00.0: bridge 32bit mmio: [0xfd600000-0xfd6fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.385095] pci 0000:07:00.0: bridge 32bit mmio pref: [0xfd500000-0xfd5fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.385125] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385338] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385373] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385414] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385486] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385519] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385553] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.385589] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  4 13:28:21 cfhat12 kernel: [    0.399890] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.399957] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400001] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400001] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400001] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400064] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400126] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400189] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:28:21 cfhat12 kernel: [    0.400253] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  4 13:28:21 cfhat12 kernel: [    0.400257] vgaarb: loaded
Jan  4 13:28:21 cfhat12 kernel: [    0.400270] PCI: Using ACPI for IRQ routing
Jan  4 13:28:21 cfhat12 kernel: [    0.400270] pci 0000:00:00.0: BAR 3: address space collision on of device [0xe0000000-0xffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.400270] pci 0000:00:00.0: BAR 3: can't allocate resource
Jan  4 13:28:21 cfhat12 kernel: [    0.400270] Switching to clocksource tsc
Jan  4 13:28:21 cfhat12 kernel: [    0.400635] pnp: PnP ACPI init
Jan  4 13:28:21 cfhat12 kernel: [    0.400642] ACPI: bus type pnp registered
Jan  4 13:28:21 cfhat12 kernel: [    0.402262] pnp 00:0a: mem resource (0xd1000-0xd3fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402265] pnp 00:0a: mem resource (0xf0000-0xf7fff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402267] pnp 00:0a: mem resource (0xf8000-0xfbfff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402269] pnp 00:0a: mem resource (0xfc000-0xfffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402271] pnp 00:0a: mem resource (0x0-0x9ffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402273] pnp 00:0a: mem resource (0x100000-0xcfdeffff) overlaps 0000:00:00.0 BAR 3 (0x0-0x1fffffff), disabling
Jan  4 13:28:21 cfhat12 kernel: [    0.402339] pnp: PnP ACPI: found 11 devices
Jan  4 13:28:21 cfhat12 kernel: [    0.402341] ACPI: ACPI bus type pnp unregistered
Jan  4 13:28:21 cfhat12 kernel: [    0.402347] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402349] system 00:01: ioport range 0x220-0x225 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402350] system 00:01: ioport range 0x290-0x294 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402353] system 00:02: ioport range 0x4100-0x411f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402355] system 00:02: ioport range 0x228-0x22f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402356] system 00:02: ioport range 0x40b-0x40b has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402358] system 00:02: ioport range 0x4d6-0x4d6 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402359] system 00:02: ioport range 0xc00-0xc01 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402361] system 00:02: ioport range 0xc14-0xc14 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402363] system 00:02: ioport range 0xc50-0xc52 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402364] system 00:02: ioport range 0xc6c-0xc6d has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402366] system 00:02: ioport range 0xc6f-0xc6f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402367] system 00:02: ioport range 0xcd0-0xcd1 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402369] system 00:02: ioport range 0xcd2-0xcd3 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402370] system 00:02: ioport range 0xcd4-0xcdf has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402372] system 00:02: ioport range 0x4000-0x40fe has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402374] system 00:02: ioport range 0x4210-0x4217 has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402375] system 00:02: ioport range 0xb00-0xb0f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402377] system 00:02: ioport range 0xb10-0xb1f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402378] system 00:02: ioport range 0xb20-0xb3f has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402382] system 00:09: iomem range 0xe0000000-0xefffffff has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402386] system 00:0a: iomem range 0xcfdf0000-0xcfdfffff could not be reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402388] system 00:0a: iomem range 0xffff0000-0xffffffff has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402389] system 00:0a: iomem range 0xcfe00000-0xcfefffff has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402391] system 00:0a: iomem range 0xcff00000-0xcfffffff could not be reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402393] system 00:0a: iomem range 0xfec00000-0xfec00fff could not be reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402395] system 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.402397] system 00:0a: iomem range 0xfff80000-0xfffeffff has been reserved
Jan  4 13:28:21 cfhat12 kernel: [    0.407133] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
Jan  4 13:28:21 cfhat12 kernel: [    0.407135] pci 0000:00:01.0:   IO window: 0xc000-0xcfff
Jan  4 13:28:21 cfhat12 kernel: [    0.407137] pci 0000:00:01.0:   MEM window: 0xfd200000-0xfd3fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407140] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407144] pci 0000:00:07.0: PCI bridge, secondary bus 0000:02
Jan  4 13:28:21 cfhat12 kernel: [    0.407145] pci 0000:00:07.0:   IO window: 0xb000-0xbfff
Jan  4 13:28:21 cfhat12 kernel: [    0.407147] pci 0000:00:07.0:   MEM window: 0xfdf00000-0xfdffffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407149] pci 0000:00:07.0:   PREFETCH window: 0x000000fde00000-0x000000fdefffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407152] pci 0000:00:09.0: PCI bridge, secondary bus 0000:03
Jan  4 13:28:21 cfhat12 kernel: [    0.407153] pci 0000:00:09.0:   IO window: 0xe000-0xefff
Jan  4 13:28:21 cfhat12 kernel: [    0.407155] pci 0000:00:09.0:   MEM window: 0xfdd00000-0xfddfffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407157] pci 0000:00:09.0:   PREFETCH window: 0x000000fdc00000-0x000000fdcfffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407160] pci 0000:00:0a.0: PCI bridge, secondary bus 0000:04
Jan  4 13:28:21 cfhat12 kernel: [    0.407162] pci 0000:00:0a.0:   IO window: 0xd000-0xdfff
Jan  4 13:28:21 cfhat12 kernel: [    0.407164] pci 0000:00:0a.0:   MEM window: 0xfd900000-0xfd9fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407166] pci 0000:00:0a.0:   PREFETCH window: 0x000000fd400000-0x000000fd4fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407169] pci 0000:00:14.4: PCI bridge, secondary bus 0000:05
Jan  4 13:28:21 cfhat12 kernel: [    0.407171] pci 0000:00:14.4:   IO window: 0xa000-0xafff
Jan  4 13:28:21 cfhat12 kernel: [    0.407174] pci 0000:00:14.4:   MEM window: 0xfdb00000-0xfdbfffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407177] pci 0000:00:14.4:   PREFETCH window: 0xfda00000-0xfdafffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407182] pci 0000:00:15.0: PCI bridge, secondary bus 0000:06
Jan  4 13:28:21 cfhat12 kernel: [    0.407183] pci 0000:00:15.0:   IO window: 0x9000-0x9fff
Jan  4 13:28:21 cfhat12 kernel: [    0.407186] pci 0000:00:15.0:   MEM window: 0xfd800000-0xfd8fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407189] pci 0000:00:15.0:   PREFETCH window: 0x000000fd700000-0x000000fd7fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407193] pci 0000:07:00.0: PCI bridge, secondary bus 0000:08
Jan  4 13:28:21 cfhat12 kernel: [    0.407196] pci 0000:07:00.0:   IO window: 0x8000-0x8fff
Jan  4 13:28:21 cfhat12 kernel: [    0.407204] pci 0000:07:00.0:   MEM window: 0xfd600000-0xfd6fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407209] pci 0000:07:00.0:   PREFETCH window: 0xfd500000-0xfd5fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407219] pci 0000:00:15.1: PCI bridge, secondary bus 0000:07
Jan  4 13:28:21 cfhat12 kernel: [    0.407221] pci 0000:00:15.1:   IO window: 0x8000-0x8fff
Jan  4 13:28:21 cfhat12 kernel: [    0.407224] pci 0000:00:15.1:   MEM window: 0xfd600000-0xfd6fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407226] pci 0000:00:15.1:   PREFETCH window: 0x000000fd500000-0x000000fd5fffff
Jan  4 13:28:21 cfhat12 kernel: [    0.407236]   alloc irq_desc for 19 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407237]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407243] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:28:21 cfhat12 kernel: [    0.407245] pci 0000:00:07.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407248]   alloc irq_desc for 17 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407249]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407254] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.407256] pci 0000:00:09.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407259]   alloc irq_desc for 18 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407260]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.407265] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.407267] pci 0000:00:0a.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407275] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.407277] pci 0000:00:15.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407282] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.407285] pci 0000:00:15.1: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407296] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.407301] pci 0000:07:00.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.407305] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407307] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407308] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407310] pci_bus 0000:01: resource 1 mem: [0xfd200000-0xfd3fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407311] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407313] pci_bus 0000:02: resource 0 io:  [0xb000-0xbfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407314] pci_bus 0000:02: resource 1 mem: [0xfdf00000-0xfdffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407316] pci_bus 0000:02: resource 2 pref mem [0xfde00000-0xfdefffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407317] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407318] pci_bus 0000:03: resource 1 mem: [0xfdd00000-0xfddfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407320] pci_bus 0000:03: resource 2 pref mem [0xfdc00000-0xfdcfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407321] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407323] pci_bus 0000:04: resource 1 mem: [0xfd900000-0xfd9fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407324] pci_bus 0000:04: resource 2 pref mem [0xfd400000-0xfd4fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407326] pci_bus 0000:05: resource 0 io:  [0xa000-0xafff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407327] pci_bus 0000:05: resource 1 mem: [0xfdb00000-0xfdbfffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407328] pci_bus 0000:05: resource 2 pref mem [0xfda00000-0xfdafffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407330] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407331] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407333] pci_bus 0000:06: resource 0 io:  [0x9000-0x9fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407334] pci_bus 0000:06: resource 1 mem: [0xfd800000-0xfd8fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407335] pci_bus 0000:06: resource 2 pref mem [0xfd700000-0xfd7fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407337] pci_bus 0000:07: resource 0 io:  [0x8000-0x8fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407338] pci_bus 0000:07: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407340] pci_bus 0000:07: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407341] pci_bus 0000:08: resource 0 io:  [0x8000-0x8fff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407342] pci_bus 0000:08: resource 1 mem: [0xfd600000-0xfd6fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407344] pci_bus 0000:08: resource 2 pref mem [0xfd500000-0xfd5fffff]
Jan  4 13:28:21 cfhat12 kernel: [    0.407363] NET: Registered protocol family 2
Jan  4 13:28:21 cfhat12 kernel: [    0.407436] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.408184] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.410071] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.410319] TCP: Hash tables configured (established 524288 bind 65536)
Jan  4 13:28:21 cfhat12 kernel: [    0.410321] TCP reno registered
Jan  4 13:28:21 cfhat12 kernel: [    0.410398] NET: Registered protocol family 1
Jan  4 13:28:21 cfhat12 kernel: [    0.471547] pci 0000:01:05.0: Boot video device
Jan  4 13:28:21 cfhat12 kernel: [    0.471608] Unpacking initramfs...
Jan  4 13:28:21 cfhat12 kernel: [    0.596584] Freeing initrd memory: 9223k freed
Jan  4 13:28:21 cfhat12 kernel: [    0.599431] PCI-DMA: Disabling AGP.
Jan  4 13:28:21 cfhat12 kernel: [    0.599520] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  4 13:28:21 cfhat12 kernel: [    0.599521] PCI-DMA: using GART IOMMU.
Jan  4 13:28:21 cfhat12 kernel: [    0.599524] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  4 13:28:21 cfhat12 kernel: [    0.601368] audit: initializing netlink socket (disabled)
Jan  4 13:28:21 cfhat12 kernel: [    0.601381] type=2000 audit(1294165689.599:1): initialized
Jan  4 13:28:21 cfhat12 kernel: [    0.603495] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  4 13:28:21 cfhat12 kernel: [    0.604330] VFS: Disk quotas dquot_6.5.2
Jan  4 13:28:21 cfhat12 kernel: [    0.604361] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  4 13:28:21 cfhat12 kernel: [    0.604405] msgmni has been set to 14999
Jan  4 13:28:21 cfhat12 kernel: [    0.604566] alg: No test for stdrng (krng)
Jan  4 13:28:21 cfhat12 kernel: [    0.604595] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  4 13:28:21 cfhat12 kernel: [    0.604597] io scheduler noop registered
Jan  4 13:28:21 cfhat12 kernel: [    0.604598] io scheduler anticipatory registered
Jan  4 13:28:21 cfhat12 kernel: [    0.604599] io scheduler deadline registered
Jan  4 13:28:21 cfhat12 kernel: [    0.604619] io scheduler cfq registered (default)
Jan  4 13:28:21 cfhat12 kernel: [    0.604739]   alloc irq_desc for 24 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604740]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604746] pcieport 0000:00:07.0: irq 24 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.604750] pcieport 0000:00:07.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.604821]   alloc irq_desc for 25 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604822]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604826] pcieport 0000:00:09.0: irq 25 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.604829] pcieport 0000:00:09.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.604894]   alloc irq_desc for 26 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604895]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604898] pcieport 0000:00:0a.0: irq 26 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.604901] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.604988]   alloc irq_desc for 27 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604989]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.604994] pcieport 0000:00:15.0: irq 27 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.604999] pcieport 0000:00:15.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.605095]   alloc irq_desc for 28 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.605096]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.605101] pcieport 0000:00:15.1: irq 28 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.605106] pcieport 0000:00:15.1: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.605879] Linux agpgart interface v0.103
Jan  4 13:28:21 cfhat12 kernel: [    0.605907] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  4 13:28:21 cfhat12 kernel: [    0.605991] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:28:21 cfhat12 kernel: [    0.606194] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:28:21 cfhat12 kernel: [    0.606258]   alloc irq_desc for 20 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.606260]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.606267] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:28:21 cfhat12 kernel: [    0.606372] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  4 13:28:21 cfhat12 kernel: [    0.606463] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  4 13:28:21 cfhat12 kernel: [    0.606543] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  4 13:28:21 cfhat12 kernel: [    0.606555] Couldn't register serial port 0000:05:06.0: -28
Jan  4 13:28:21 cfhat12 kernel: [    0.606581] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:28:21 cfhat12 kernel: [    0.606583] Couldn't register serial port 0000:05:06.1: -28
Jan  4 13:28:21 cfhat12 kernel: [    0.606648] input: Macintosh mouse button emulation as /devices/virtual/input/input0
Jan  4 13:28:21 cfhat12 kernel: [    0.606683] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  4 13:28:21 cfhat12 kernel: [    0.606685] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  4 13:28:21 cfhat12 kernel: [    0.606803] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 13:28:21 cfhat12 kernel: [    0.606857] mice: PS/2 mouse device common for all mice
Jan  4 13:28:21 cfhat12 kernel: [    0.606884] rtc_cmos 00:04: RTC can wake from S4
Jan  4 13:28:21 cfhat12 kernel: [    0.606906] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  4 13:28:21 cfhat12 kernel: [    0.606926] rtc0: alarms up to one month, 242 bytes nvram
Jan  4 13:28:21 cfhat12 kernel: [    0.606932] cpuidle: using governor ladder
Jan  4 13:28:21 cfhat12 kernel: [    0.606933] cpuidle: using governor menu
Jan  4 13:28:21 cfhat12 kernel: [    0.606936] No iBFT detected.
Jan  4 13:28:21 cfhat12 kernel: [    0.607120] TCP cubic registered
Jan  4 13:28:21 cfhat12 kernel: [    0.607184] NET: Registered protocol family 10
Jan  4 13:28:21 cfhat12 kernel: [    0.607468] lo: Disabled Privacy Extensions
Jan  4 13:28:21 cfhat12 kernel: [    0.607627] Mobile IPv6
Jan  4 13:28:21 cfhat12 kernel: [    0.607628] NET: Registered protocol family 17
Jan  4 13:28:21 cfhat12 kernel: [    0.607676] PM: Resume from disk failed.
Jan  4 13:28:21 cfhat12 kernel: [    0.607682] registered taskstats version 1
Jan  4 13:28:21 cfhat12 kernel: [    0.608129] rtc_cmos 00:04: setting system clock to 2011-01-04 18:28:10 UTC (1294165690)
Jan  4 13:28:21 cfhat12 kernel: [    0.608147] Initalizing network drop monitor service
Jan  4 13:28:21 cfhat12 kernel: [    0.608163] Freeing unused kernel memory: 592k freed
Jan  4 13:28:21 cfhat12 kernel: [    0.608267] Write protecting the kernel read-only data: 4232k
Jan  4 13:28:21 cfhat12 kernel: [    0.618062] udev[121]: starting version 164
Jan  4 13:28:21 cfhat12 kernel: [    0.656031] usbcore: registered new interface driver usbfs
Jan  4 13:28:21 cfhat12 kernel: [    0.656050] usbcore: registered new interface driver hub
Jan  4 13:28:21 cfhat12 kernel: [    0.656073] usbcore: registered new device driver usb
Jan  4 13:28:21 cfhat12 kernel: [    0.657453] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  4 13:28:21 cfhat12 kernel: [    0.657528] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.657529] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.657551] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  4 13:28:21 cfhat12 kernel: [    0.657583] ehci_hcd 0000:00:12.2: debug port 1
Jan  4 13:28:21 cfhat12 kernel: [    0.657587] SCSI subsystem initialized
Jan  4 13:28:21 cfhat12 kernel: [    0.657608] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  4 13:28:21 cfhat12 kernel: [    0.662067] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Jan  4 13:28:21 cfhat12 kernel: [    0.665438] libata version 3.00 loaded.
Jan  4 13:28:21 cfhat12 kernel: [    0.667512] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
Jan  4 13:28:21 cfhat12 kernel: [    0.667514] e1000e: Copyright (c) 1999-2008 Intel Corporation.
Jan  4 13:28:21 cfhat12 kernel: [    0.667555] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  4 13:28:21 cfhat12 kernel: [    0.667569] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jan  4 13:28:21 cfhat12 kernel: [    0.667571] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.667572] usb usb1: Product: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.667573] usb usb1: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.667575] usb usb1: SerialNumber: 0000:00:12.2
Jan  4 13:28:21 cfhat12 kernel: [    0.667626] usb usb1: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.667645] hub 1-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.667650] hub 1-0:1.0: 5 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.667721] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:28:21 cfhat12 kernel: [    0.667746] e1000e 0000:02:00.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.667895]   alloc irq_desc for 29 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667896]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667901] e1000e 0000:02:00.0: irq 29 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.667902]   alloc irq_desc for 30 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667903]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667905] e1000e 0000:02:00.0: irq 30 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.667907]   alloc irq_desc for 31 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667907]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.667909] e1000e 0000:02:00.0: irq 31 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.668555] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.668561] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.668569] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  4 13:28:21 cfhat12 kernel: [    0.668589] ehci_hcd 0000:00:13.2: debug port 1
Jan  4 13:28:21 cfhat12 kernel: [    0.668600] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  4 13:28:21 cfhat12 kernel: [    0.668613] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.668619] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.668621] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.668626] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
Jan  4 13:28:21 cfhat12 kernel: [    0.668727] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  4 13:28:21 cfhat12 kernel: [    0.672082] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  4 13:28:21 cfhat12 kernel: [    0.672085] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.672109] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.672141] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  4 13:28:21 cfhat12 kernel: [    0.672150] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.672160] scsi0 : pata_jmicron
Jan  4 13:28:21 cfhat12 kernel: [    0.672226] r8169 0000:04:00.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.672258] scsi1 : pata_jmicron
Jan  4 13:28:21 cfhat12 kernel: [    0.672280] ata1: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  4 13:28:21 cfhat12 kernel: [    0.672282] ata2: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  4 13:28:21 cfhat12 kernel: [    0.672295]   alloc irq_desc for 32 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.672296]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.672304] r8169 0000:04:00.0: irq 32 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.672647] eth0: RTL8168d/8111d at 0xffffc90000c74000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 32
Jan  4 13:28:21 cfhat12 kernel: [    0.677621] r8169 0000:04:00.0: firmware: requesting rtl8168d-2.fw
Jan  4 13:28:21 cfhat12 kernel: [    0.677646] usb usb3: config 1 interface 0 altsetting 0 endpoint 0x81 has no SuperSpeed companion descriptor
Jan  4 13:28:21 cfhat12 kernel: [    0.677651] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
Jan  4 13:28:21 cfhat12 kernel: [    0.677652] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.677654] usb usb3: Product: xHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.677655] usb usb3: Manufacturer: Linux 2.6.32-5-amd64 xhci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.677656] usb usb3: SerialNumber: 0000:03:00.0
Jan  4 13:28:21 cfhat12 kernel: [    0.677702] usb usb3: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.677704] xHCI xhci_add_endpoint called for root hub
Jan  4 13:28:21 cfhat12 kernel: [    0.677706] xHCI xhci_check_bandwidth called for root hub
Jan  4 13:28:21 cfhat12 kernel: [    0.677725] hub 3-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.677729] hub 3-0:1.0: 4 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.678929] eth0: unable to apply firmware patch
Jan  4 13:28:21 cfhat12 kernel: [    0.679480] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  4 13:28:21 cfhat12 kernel: [    0.679492] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
Jan  4 13:28:21 cfhat12 kernel: [    0.679493] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.679495] usb usb2: Product: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.679496] usb usb2: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.679497] usb usb2: SerialNumber: 0000:00:13.2
Jan  4 13:28:21 cfhat12 kernel: [    0.679536] usb usb2: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.679553] hub 2-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.679557] hub 2-0:1.0: 5 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.679615] ahci 0000:00:11.0: version 3.0
Jan  4 13:28:21 cfhat12 kernel: [    0.679622] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:28:21 cfhat12 kernel: [    0.679646]   alloc irq_desc for 33 on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.679647]   alloc kstat_irqs on node 0
Jan  4 13:28:21 cfhat12 kernel: [    0.679655] ahci 0000:00:11.0: irq 33 for MSI/MSI-X
Jan  4 13:28:21 cfhat12 kernel: [    0.679715] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  4 13:28:21 cfhat12 kernel: [    0.679717] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  4 13:28:21 cfhat12 kernel: [    0.679880] scsi2 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.680009] scsi3 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.680052] scsi4 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.680091] scsi5 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.680164] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 33
Jan  4 13:28:21 cfhat12 kernel: [    0.680166] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 33
Jan  4 13:28:21 cfhat12 kernel: [    0.680169] ata5: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 33
Jan  4 13:28:21 cfhat12 kernel: [    0.680171] ata6: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 33
Jan  4 13:28:21 cfhat12 kernel: [    0.680239] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.680306] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.680354] scsi6 : pata_atiixp
Jan  4 13:28:21 cfhat12 kernel: [    0.680384] scsi7 : pata_atiixp
Jan  4 13:28:21 cfhat12 kernel: [    0.681100] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  4 13:28:21 cfhat12 kernel: [    0.681102] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  4 13:28:21 cfhat12 kernel: [    0.681194] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    0.681202] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.681208] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 4
Jan  4 13:28:21 cfhat12 kernel: [    0.681232] ehci_hcd 0000:00:16.2: debug port 1
Jan  4 13:28:21 cfhat12 kernel: [    0.681243] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  4 13:28:21 cfhat12 kernel: [    0.691653] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  4 13:28:21 cfhat12 kernel: [    0.691665] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
Jan  4 13:28:21 cfhat12 kernel: [    0.691667] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.691668] usb usb4: Product: EHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.691669] usb usb4: Manufacturer: Linux 2.6.32-5-amd64 ehci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.691670] usb usb4: SerialNumber: 0000:00:16.2
Jan  4 13:28:21 cfhat12 kernel: [    0.691715] usb usb4: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.691731] hub 4-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.691735] hub 4-0:1.0: 4 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.695538] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  4 13:28:21 cfhat12 kernel: [    0.695540] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  4 13:28:21 cfhat12 kernel: [    0.695545] ahci 0000:06:00.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    0.695642] scsi8 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.695683] scsi9 : ahci
Jan  4 13:28:21 cfhat12 kernel: [    0.695708] ata9: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  4 13:28:21 cfhat12 kernel: [    0.695711] ata10: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  4 13:28:21 cfhat12 kernel: [    0.756489] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  4 13:28:21 cfhat12 kernel: [    0.756508] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.756524] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.756534] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 5
Jan  4 13:28:21 cfhat12 kernel: [    0.756561] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  4 13:28:21 cfhat12 kernel: [    0.784871] 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  4 13:28:21 cfhat12 kernel: [    0.784873] 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  4 13:28:21 cfhat12 kernel: [    0.784884] 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  4 13:28:21 cfhat12 kernel: [    0.815650] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Jan  4 13:28:21 cfhat12 kernel: [    0.815652] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.815653] usb usb5: Product: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.815655] usb usb5: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.815656] usb usb5: SerialNumber: 0000:00:12.0
Jan  4 13:28:21 cfhat12 kernel: [    0.815700] usb usb5: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.815718] hub 5-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.815724] hub 5-0:1.0: 5 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.815782] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.815793] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.815800] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 6
Jan  4 13:28:21 cfhat12 kernel: [    0.815813] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  4 13:28:21 cfhat12 kernel: [    0.851790] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  4 13:28:21 cfhat12 kernel: [    0.851803] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  4 13:28:21 cfhat12 kernel: [    0.867804] ata7.00: configured for UDMA/33
Jan  4 13:28:21 cfhat12 kernel: [    0.875657] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Jan  4 13:28:21 cfhat12 kernel: [    0.875659] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.875661] usb usb6: Product: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.875662] usb usb6: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.875663] usb usb6: SerialNumber: 0000:00:13.0
Jan  4 13:28:21 cfhat12 kernel: [    0.875709] usb usb6: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.875724] hub 6-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.875730] hub 6-0:1.0: 5 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.875786] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.875797] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.875803] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
Jan  4 13:28:21 cfhat12 kernel: [    0.875816] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  4 13:28:21 cfhat12 kernel: [    0.935665] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Jan  4 13:28:21 cfhat12 kernel: [    0.935667] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.935668] usb usb7: Product: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.935669] usb usb7: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.935670] usb usb7: SerialNumber: 0000:00:14.5
Jan  4 13:28:21 cfhat12 kernel: [    0.935713] usb usb7: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.935728] hub 7-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.935733] hub 7-0:1.0: 2 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    0.935783] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    0.935793] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.935799] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 8
Jan  4 13:28:21 cfhat12 kernel: [    0.935812] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  4 13:28:21 cfhat12 kernel: [    0.995544] ata6: SATA link down (SStatus 0 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    0.995654] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Jan  4 13:28:21 cfhat12 kernel: [    0.995656] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan  4 13:28:21 cfhat12 kernel: [    0.995657] usb usb8: Product: OHCI Host Controller
Jan  4 13:28:21 cfhat12 kernel: [    0.995659] usb usb8: Manufacturer: Linux 2.6.32-5-amd64 ohci_hcd
Jan  4 13:28:21 cfhat12 kernel: [    0.995660] usb usb8: SerialNumber: 0000:00:16.0
Jan  4 13:28:21 cfhat12 kernel: [    0.995701] usb usb8: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    0.995717] hub 8-0:1.0: USB hub found
Jan  4 13:28:21 cfhat12 kernel: [    0.995723] hub 8-0:1.0: 4 ports detected
Jan  4 13:28:21 cfhat12 kernel: [    1.003580] ata5: SATA link down (SStatus 0 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    1.019591] ata10: SATA link down (SStatus 0 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    1.019594] ata9: SATA link down (SStatus 0 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    1.159603] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    1.161015] ata3.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  4 13:28:21 cfhat12 kernel: [    1.161017] ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  4 13:28:21 cfhat12 kernel: [    1.162593] ata3.00: configured for UDMA/133
Jan  4 13:28:21 cfhat12 kernel: [    1.179668] scsi 2:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  4 13:28:21 cfhat12 kernel: [    1.215590] usb 6-1: new low speed USB device using ohci_hcd and address 2
Jan  4 13:28:21 cfhat12 kernel: [    1.223597] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:28:21 cfhat12 kernel: [    1.226529] ata4.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  4 13:28:21 cfhat12 kernel: [    1.226531] ata4.00: 312581808 sectors, multi 16: LBA48 
Jan  4 13:28:21 cfhat12 kernel: [    1.229608] ata4.00: configured for UDMA/133
Jan  4 13:28:21 cfhat12 kernel: [    1.247663] scsi 3:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  4 13:28:21 cfhat12 kernel: [    1.248495] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  4 13:28:21 cfhat12 kernel: [    1.390764] usb 6-1: New USB device found, idVendor=0d3d, idProduct=0001
Jan  4 13:28:21 cfhat12 kernel: [    1.390766] usb 6-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
Jan  4 13:28:21 cfhat12 kernel: [    1.390768] usb 6-1: Product: USBPS2
Jan  4 13:28:21 cfhat12 kernel: [    1.390814] usb 6-1: configuration #1 chosen from 1 choice
Jan  4 13:28:21 cfhat12 kernel: [    1.405005] usbcore: registered new interface driver hiddev
Jan  4 13:28:21 cfhat12 kernel: [    1.408876] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb6/6-1/6-1:1.0/input/input2
Jan  4 13:28:21 cfhat12 kernel: [    1.408903] generic-usb 0003:0D3D:0001.0001: input,hidraw0: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  4 13:28:21 cfhat12 kernel: [    1.417112] input: USBPS2 as /devices/pci0000:00/0000:00:13.0/usb6/6-1/6-1:1.1/input/input3
Jan  4 13:28:21 cfhat12 kernel: [    1.417154] generic-usb 0003:0D3D:0001.0002: input,hidraw1: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  4 13:28:21 cfhat12 kernel: [    1.417166] usbcore: registered new interface driver usbhid
Jan  4 13:28:21 cfhat12 kernel: [    1.417169] usbhid: v2.6:USB HID core driver
Jan  4 13:28:21 cfhat12 kernel: [    1.420591] sd 2:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:28:21 cfhat12 kernel: [    1.420665] sd 2:0:0:0: [sda] Write Protect is off
Jan  4 13:28:21 cfhat12 kernel: [    1.420665] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  4 13:28:21 cfhat12 kernel: [    1.420669] sd 3:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:28:21 cfhat12 kernel: [    1.420665] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:28:21 cfhat12 kernel: [    1.420669] sd 3:0:0:0: [sdb] Write Protect is off
Jan  4 13:28:21 cfhat12 kernel: [    1.420669] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  4 13:28:21 cfhat12 kernel: [    1.420742] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:28:21 cfhat12 kernel: [    1.420780]  sdb:
Jan  4 13:28:21 cfhat12 kernel: [    1.420802]  sda: sda1 sda2 sda3 sda4 < sdb1 sdb2 sdb3 sdb4 < sda5 sdb5 sda6 sdb6 sda7 >
Jan  4 13:28:21 cfhat12 kernel: [    1.454986] sd 2:0:0:0: [sda] Attached SCSI disk
Jan  4 13:28:21 cfhat12 kernel: [    1.460273]  sdb7 >
Jan  4 13:28:21 cfhat12 kernel: [    1.460535] sd 3:0:0:0: [sdb] Attached SCSI disk
Jan  4 13:28:21 cfhat12 kernel: [    1.465978] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  4 13:28:21 cfhat12 kernel: [    1.465978] Uniform CD-ROM driver Revision: 3.20
Jan  4 13:28:21 cfhat12 kernel: [    1.466030] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  4 13:28:21 cfhat12 kernel: [    1.468024] sd 2:0:0:0: Attached scsi generic sg0 type 0
Jan  4 13:28:21 cfhat12 kernel: [    1.468043] sd 3:0:0:0: Attached scsi generic sg1 type 0
Jan  4 13:28:21 cfhat12 kernel: [    1.468064] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  4 13:28:21 cfhat12 kernel: [    1.783772] md: raid1 personality registered for level 1
Jan  4 13:28:21 cfhat12 kernel: [    1.789352] md: md1 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    1.790375] md: bind<sdb1>
Jan  4 13:28:21 cfhat12 kernel: [    1.790588] md: bind<sda1>
Jan  4 13:28:21 cfhat12 kernel: [    1.791645] raid1: raid set md1 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    1.791662] md1: detected capacity change from 0 to 254791680
Jan  4 13:28:21 cfhat12 kernel: [    1.792184]  md1: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    1.996219] md: md2 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    1.996960] md: bind<sdb2>
Jan  4 13:28:21 cfhat12 kernel: [    1.997091] md: bind<sda2>
Jan  4 13:28:21 cfhat12 kernel: [    1.997828] raid1: raid set md2 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    1.997844] md2: detected capacity change from 0 to 19998367744
Jan  4 13:28:21 cfhat12 kernel: [    1.998376]  md2: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    2.202195] md: md3 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    2.202995] md: bind<sdb3>
Jan  4 13:28:21 cfhat12 kernel: [    2.203165] md: bind<sda3>
Jan  4 13:28:21 cfhat12 kernel: [    2.203900] raid1: raid set md3 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    2.203916] md3: detected capacity change from 0 to 1998573568
Jan  4 13:28:21 cfhat12 kernel: [    2.204424]  md3: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    2.408045] md: md5 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    2.408987] md: bind<sdb5>
Jan  4 13:28:21 cfhat12 kernel: [    2.409119] md: bind<sda5>
Jan  4 13:28:21 cfhat12 kernel: [    2.409842] raid1: raid set md5 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    2.409857] md5: detected capacity change from 0 to 19997319168
Jan  4 13:28:21 cfhat12 kernel: [    2.410358]  md5: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    2.634613] md: md6 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    2.635625] md: bind<sdb6>
Jan  4 13:28:21 cfhat12 kernel: [    2.635827] md: bind<sda6>
Jan  4 13:28:21 cfhat12 kernel: [    2.636570] raid1: raid set md6 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    2.636586] md6: detected capacity change from 0 to 19997319168
Jan  4 13:28:21 cfhat12 kernel: [    2.637108]  md6: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    2.840649] md: md7 stopped.
Jan  4 13:28:21 cfhat12 kernel: [    2.841344] md: bind<sdb7>
Jan  4 13:28:21 cfhat12 kernel: [    2.841480] md: bind<sda7>
Jan  4 13:28:21 cfhat12 kernel: [    2.842210] raid1: raid set md7 active with 2 out of 2 mirrors
Jan  4 13:28:21 cfhat12 kernel: [    2.842226] md7: detected capacity change from 0 to 97784881152
Jan  4 13:28:21 cfhat12 kernel: [    2.842740]  md7: unknown partition table
Jan  4 13:28:21 cfhat12 kernel: [    3.046265] PM: Starting manual resume from disk
Jan  4 13:28:21 cfhat12 kernel: [    3.046267] PM: Resume from partition 9:3
Jan  4 13:28:21 cfhat12 kernel: [    3.046268] PM: Checking hibernation image.
Jan  4 13:28:21 cfhat12 kernel: [    3.062593] PM: Error -22 checking image file
Jan  4 13:28:21 cfhat12 kernel: [    3.062594] PM: Resume from disk failed.
Jan  4 13:28:21 cfhat12 kernel: [    3.067707] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jan  4 13:28:21 cfhat12 kernel: [    3.068193] SGI XFS Quota Management subsystem
Jan  4 13:28:21 cfhat12 kernel: [    3.118185] XFS mounting filesystem md2
Jan  4 13:28:21 cfhat12 kernel: [    3.368652] Ending clean XFS mount for filesystem: md2
Jan  4 13:28:21 cfhat12 kernel: [    4.877022] udev[572]: starting version 164
Jan  4 13:28:21 cfhat12 kernel: [    5.203634] processor LNXCPU:00: registered as cooling_device0
Jan  4 13:28:21 cfhat12 kernel: [    5.203787] processor LNXCPU:01: registered as cooling_device1
Jan  4 13:28:21 cfhat12 kernel: [    5.203871] processor LNXCPU:02: registered as cooling_device2
Jan  4 13:28:21 cfhat12 kernel: [    5.204056] processor LNXCPU:03: registered as cooling_device3
Jan  4 13:28:21 cfhat12 kernel: [    5.204675] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
Jan  4 13:28:21 cfhat12 kernel: [    5.204680] ACPI: Power Button [PWRB]
Jan  4 13:28:21 cfhat12 kernel: [    5.204728] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
Jan  4 13:28:21 cfhat12 kernel: [    5.204730] ACPI: Power Button [PWRF]
Jan  4 13:28:21 cfhat12 kernel: [    5.287827] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan  4 13:28:21 cfhat12 kernel: [    5.534944] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 9602 ss_vid 0 ss_did 0
Jan  4 13:28:21 cfhat12 kernel: [    5.534947] shpchp 0000:00:01.0: Cannot reserve MMIO region
Jan  4 13:28:21 cfhat12 kernel: [    5.535063] ACPI: I/O resource piix4_smbus [0xb00-0xb07] conflicts with ACPI region SOR1 [0xb00-0xb0f]
Jan  4 13:28:21 cfhat12 kernel: [    5.535098] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  4 13:28:21 cfhat12 kernel: [    5.535175] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jan  4 13:28:21 cfhat12 kernel: [    5.564449] EDAC MC: Ver: 2.1.0 Dec 10 2010
Jan  4 13:28:21 cfhat12 kernel: [    5.602426] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  4 13:28:21 cfhat12 kernel: [    5.606550] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  4 13:28:21 cfhat12 kernel: [    5.606552] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  4 13:28:21 cfhat12 kernel: [    5.606553] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  4 13:28:21 cfhat12 kernel: [    5.607655] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  4 13:28:21 cfhat12 kernel: [    5.616837] EDAC amd64_edac:  Ver: 3.2.0 Dec 10 2010
Jan  4 13:28:21 cfhat12 kernel: [    5.616936] EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:18.3).
Jan  4 13:28:21 cfhat12 kernel: [    5.616943] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
Jan  4 13:28:21 cfhat12 kernel: [    5.616944]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
Jan  4 13:28:21 cfhat12 kernel: [    5.616945]  (Note that use of the override may cause unknown side effects.)
Jan  4 13:28:21 cfhat12 kernel: [    5.616956] amd64_edac: probe of 0000:00:18.2 failed with error -22
Jan  4 13:28:21 cfhat12 kernel: [    5.796123] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    5.796127] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    5.796209] parport0: PC-style at 0x8f00 (0x8e00), irq 17 [PCSPP,TRISTATE]
Jan  4 13:28:21 cfhat12 kernel: [    5.823819] input: PC Speaker as /devices/platform/pcspkr/input/input6
Jan  4 13:28:21 cfhat12 kernel: [    5.892087] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  4 13:28:21 cfhat12 kernel: [    5.892168] parport1: PC-style at 0x8d00 (0x8c00), irq 17 [PCSPP,TRISTATE]
Jan  4 13:28:21 cfhat12 kernel: [    6.085933] [drm] Initialized drm 1.1.0 20060810
Jan  4 13:28:21 cfhat12 kernel: [    6.170643] [drm] radeon kernel modesetting enabled.
Jan  4 13:28:21 cfhat12 kernel: [    6.170686] radeon 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:28:21 cfhat12 kernel: [    6.170686] radeon 0000:01:05.0: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    6.171860] [drm] radeon: Initializing kernel modesetting.
Jan  4 13:28:21 cfhat12 kernel: [    6.171972] [drm] register mmio base: 0xFD3E0000
Jan  4 13:28:21 cfhat12 kernel: [    6.171974] [drm] register mmio size: 65536
Jan  4 13:28:21 cfhat12 kernel: [    6.174009] ATOM BIOS: B43106_DVI
Jan  4 13:28:21 cfhat12 kernel: [    6.174019] [drm] Clocks initialized !
Jan  4 13:28:21 cfhat12 kernel: [    6.176048] [drm] Detected VRAM RAM=256M, BAR=256M
Jan  4 13:28:21 cfhat12 kernel: [    6.176050] [drm] RAM width 32bits DDR
Jan  4 13:28:21 cfhat12 kernel: [    6.176132] [TTM] Zone  kernel: Available graphics memory: 3840116 kiB.
Jan  4 13:28:21 cfhat12 kernel: [    6.176134] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
Jan  4 13:28:21 cfhat12 kernel: [    6.176146] [drm] radeon: 256M of VRAM memory ready
Jan  4 13:28:21 cfhat12 kernel: [    6.176147] [drm] radeon: 512M of GTT memory ready.
Jan  4 13:28:21 cfhat12 kernel: [    6.176173] [drm] radeon: irq initialized.
Jan  4 13:28:21 cfhat12 kernel: [    6.176175] [drm] GART: num cpu pages 131072, num gpu pages 131072
Jan  4 13:28:21 cfhat12 kernel: [    6.176536] [drm] Loading RS780 Microcode
Jan  4 13:28:21 cfhat12 kernel: [    6.176538] platform radeon_cp.0: firmware: requesting radeon/RS780_pfp.bin
Jan  4 13:28:21 cfhat12 kernel: [    6.436661] platform radeon_cp.0: firmware: requesting radeon/RS780_me.bin
Jan  4 13:28:21 cfhat12 kernel: [    6.438702] platform radeon_cp.0: firmware: requesting radeon/R600_rlc.bin
Jan  4 13:28:21 cfhat12 kernel: [    6.458856] r600_cp: Failed to load firmware "radeon/R600_rlc.bin"
Jan  4 13:28:21 cfhat12 kernel: [    6.458894] [drm:r600_startup] *ERROR* Failed to load firmware!
Jan  4 13:28:21 cfhat12 kernel: [    6.458922] radeon 0000:01:05.0: disabling GPU acceleration
Jan  4 13:28:21 cfhat12 kernel: [    6.458958] radeon 0000:01:05.0: ffff88020c688a00 unpin not necessary
Jan  4 13:28:21 cfhat12 kernel: [    6.458961] radeon 0000:01:05.0: ffff88020c688a00 unpin not necessary
Jan  4 13:28:21 cfhat12 kernel: [    6.458970] [drm] Enabling audio support
Jan  4 13:28:21 cfhat12 kernel: [    6.459054] [drm] Radeon Display Connectors
Jan  4 13:28:21 cfhat12 kernel: [    6.459056] [drm] Connector 0:
Jan  4 13:28:21 cfhat12 kernel: [    6.459057] [drm]   VGA
Jan  4 13:28:21 cfhat12 kernel: [    6.459058] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
Jan  4 13:28:21 cfhat12 kernel: [    6.459059] [drm]   Encoders:
Jan  4 13:28:21 cfhat12 kernel: [    6.459060] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Jan  4 13:28:21 cfhat12 kernel: [    6.459061] [drm] Connector 1:
Jan  4 13:28:21 cfhat12 kernel: [    6.459062] [drm]   DVI-D
Jan  4 13:28:21 cfhat12 kernel: [    6.459063] [drm]   HPD1
Jan  4 13:28:21 cfhat12 kernel: [    6.459064] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
Jan  4 13:28:21 cfhat12 kernel: [    6.459065] [drm]   Encoders:
Jan  4 13:28:21 cfhat12 kernel: [    6.459066] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
Jan  4 13:28:21 cfhat12 kernel: [    6.576537] [drm] fb mappable at 0xD0040000
Jan  4 13:28:21 cfhat12 kernel: [    6.576538] [drm] vram apper at 0xD0000000
Jan  4 13:28:21 cfhat12 kernel: [    6.576539] [drm] size 7680000
Jan  4 13:28:21 cfhat12 kernel: [    6.576540] [drm] fb depth is 24
Jan  4 13:28:21 cfhat12 kernel: [    6.576541] [drm]    pitch is 6400
Jan  4 13:28:21 cfhat12 kernel: [    6.592570] Console: switching to colour frame buffer device 200x75
Jan  4 13:28:21 cfhat12 kernel: [    6.596984] fb0: radeondrmfb frame buffer device
Jan  4 13:28:21 cfhat12 kernel: [    6.596985] registered panic notifier
Jan  4 13:28:21 cfhat12 kernel: [    6.596988] [drm] Initialized radeon 2.0.0 20080528 for 0000:01:05.0 on minor 0
Jan  4 13:28:21 cfhat12 kernel: [    6.597061] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:28:21 cfhat12 kernel: [    6.597094] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  4 13:28:21 cfhat12 kernel: [    7.915969] Adding 1951668k swap on /dev/md3.  Priority:-1 extents:1 across:1951668k 
Jan  4 13:28:21 cfhat12 kernel: [    8.166848] loop: module loaded
Jan  4 13:28:21 cfhat12 kernel: [    8.885049] kjournald starting.  Commit interval 5 seconds
Jan  4 13:28:21 cfhat12 kernel: [    8.920420] EXT3 FS on md1, internal journal
Jan  4 13:28:21 cfhat12 kernel: [    8.920423] EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 13:28:21 cfhat12 kernel: [    9.051230] XFS mounting filesystem md7
Jan  4 13:28:21 cfhat12 kernel: [    9.343845] Ending clean XFS mount for filesystem: md7
Jan  4 13:28:21 cfhat12 kernel: [    9.414640] XFS mounting filesystem md5
Jan  4 13:28:21 cfhat12 kernel: [    9.708190] Ending clean XFS mount for filesystem: md5
Jan  4 13:28:21 cfhat12 kernel: [    9.740640] kjournald starting.  Commit interval 5 seconds
Jan  4 13:28:21 cfhat12 kernel: [    9.755568] EXT3 FS on md6, internal journal
Jan  4 13:28:21 cfhat12 kernel: [    9.755572] EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 13:28:21 cfhat12 kernel: [   10.420986] r8169: eth0: link up
Jan  4 13:28:21 cfhat12 kernel: [   10.420962] r8169: eth0: link up
Jan  4 13:28:21 cfhat12 kernel: [   10.907064] fuse init (API version 7.13)
Jan  4 13:28:23 cfhat12 kernel: [   13.817891] ADDRCONF(NETDEV_UP): eth1: link is not ready
Jan  4 13:28:24 cfhat12 kernel: [   14.247183] powernow-k8: Found 1 AMD Phenom(tm) II X4 965 Processor processors (4 cpu cores) (version 2.20.00)
Jan  4 13:28:24 cfhat12 kernel: [   14.247217] powernow-k8:    0 : pstate 0 (3400 MHz)
Jan  4 13:28:24 cfhat12 kernel: [   14.247219] powernow-k8:    1 : pstate 1 (2700 MHz)
Jan  4 13:28:24 cfhat12 kernel: [   14.247220] powernow-k8:    2 : pstate 2 (2200 MHz)
Jan  4 13:28:24 cfhat12 kernel: [   14.247221] powernow-k8:    3 : pstate 3 (800 MHz)
Jan  4 13:28:24 cfhat12 kernel: [   14.348424] Bluetooth: Core ver 2.15
Jan  4 13:28:24 cfhat12 kernel: [   14.348455] NET: Registered protocol family 31
Jan  4 13:28:24 cfhat12 kernel: [   14.348455] Bluetooth: HCI device and connection manager initialized
Jan  4 13:28:24 cfhat12 kernel: [   14.348455] Bluetooth: HCI socket layer initialized
Jan  4 13:28:24 cfhat12 kernel: [   14.429809] Bluetooth: L2CAP ver 2.14
Jan  4 13:28:24 cfhat12 kernel: [   14.429814] Bluetooth: L2CAP socket layer initialized
Jan  4 13:28:24 cfhat12 kernel: [   14.636050] Bluetooth: RFCOMM TTY layer initialized
Jan  4 13:28:24 cfhat12 kernel: [   14.636050] Bluetooth: RFCOMM socket layer initialized
Jan  4 13:28:24 cfhat12 kernel: [   14.636050] Bluetooth: RFCOMM ver 1.11
Jan  4 13:28:24 cfhat12 kernel: [   14.728960] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jan  4 13:28:24 cfhat12 kernel: [   14.728967] Bluetooth: BNEP filters: protocol multicast
Jan  4 13:28:24 cfhat12 kernel: [   14.807475] Bridge firewalling registered
Jan  4 13:28:24 cfhat12 kernel: [   15.017898] Bluetooth: SCO (Voice Link) ver 0.6
Jan  4 13:28:24 cfhat12 kernel: [   15.017904] Bluetooth: SCO socket layer initialized
Jan  4 13:28:31 cfhat12 kernel: [   21.120067] eth0: no IPv6 routers present
Jan  4 13:28:59 cfhat12 kernel: [   50.019447] JFS: nTxBlock = 8192, nTxLock = 65536
Jan  4 13:28:59 cfhat12 kernel: [   50.091217] NTFS driver 2.1.29 [Flags: R/W MODULE].
Jan  4 13:29:00 cfhat12 kernel: [   50.159660] QNX4 filesystem 0.2.3 registered.
Jan  4 13:29:00 cfhat12 kernel: [   50.258323] Btrfs loaded
Jan  4 13:29:17 cfhat12 kernel: [   67.642787] md: md7 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.642825] md: md6 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.642859] md: md5 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.642892] md: md3 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.642924] md: md2 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.642958] md: md1 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643065] md: md7 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643112] md: md6 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643145] md: md5 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643179] md: md3 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643211] md: md2 still in use.
Jan  4 13:29:17 cfhat12 kernel: [   67.643243] md: md1 still in use.
Jan  4 13:29:19 cfhat12 kernel: [   69.186318] fuse exit
Jan  4 13:29:23 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  4 13:30:02 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Linux version 2.6.35.7-xeno6 (hatuser@domain.hid) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Tue Jan 4 13:17:47 EST 2011
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno6 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] NX (Execute Disable) protection: active
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   6 disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   7 disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] RAMDISK: 37ca5000 - 37ff0000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880002200000-ffff880008bfffff] on node 0
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]     0: 0x00000001 -> 0x0000009f
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965454
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA zone: 0 pages reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA zone: 3942 pages, LIFO batch:0
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 40
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] early_res array is doubled to 64 at [3000 - 37ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880001a00000 s101760 r8192 d21120 u262144
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] pcpu-alloc: s101760 r8192 d21120 u262144 alloc=1*2097152
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935886
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno6 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Node 0: aperture @ 20000000 size 32 MB
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Aperture pointing to e820 RAM. Ignoring.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] early_res array is doubled to 128 at [3800 - 47ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Subtract (58 early reservations)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #1 [0001000000 - 000185ad98]   TEXT DATA BSS
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #2 [0037ca5000 - 0037ff0000]         RAMDISK
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #3 [000185b000 - 000185b0fe]             BRK
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #4 [00000f4420 - 0000100000]   BIOS reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #5 [00000f4410 - 00000f4420]    MP-table mpf
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #6 [000009f800 - 00000f1aa4]   BIOS reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #7 [00000f1c88 - 00000f4410]   BIOS reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #8 [00000f1aa4 - 00000f1c88]    MP-table mpc
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #10 [0000008000 - 000000a000]         PGTABLE
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #11 [000000a000 - 000000b000]         PGTABLE
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #12 [000185b100 - 000185c100]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #13 [0001c5c100 - 0001c5c6a0]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #14 [000205d000 - 000205e000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #15 [000205e000 - 000205f000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #16 [0002200000 - 0008c00000]        MEMMAP 0
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #17 [000185adc0 - 000185af40]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #18 [000185c100 - 0001874100]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #19 [0001874100 - 000188c100]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #20 [000188d000 - 000188e000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #21 [000185af40 - 000185af83]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #22 [000188c100 - 000188c368]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #23 [000188c380 - 000188c3e8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #24 [000188c400 - 000188c468]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #25 [000188c480 - 000188c4e8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #26 [000188c500 - 000188c568]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #27 [000188c580 - 000188c5e8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #28 [000188c600 - 000188c668]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #29 [000188c680 - 000188c6e8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #30 [000188c700 - 000188c768]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #31 [000188c780 - 000188c7e8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #32 [000188c800 - 000188c868]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #33 [000188c880 - 000188c8db]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #34 [000188c900 - 000188c95b]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #35 [0001a00000 - 0001a20000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #36 [0001a40000 - 0001a60000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #37 [0001a80000 - 0001aa0000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #38 [0001ac0000 - 0001ae0000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #39 [0001b00000 - 0001b20000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #40 [0001b40000 - 0001b60000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #41 [0001b80000 - 0001ba0000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #42 [0001bc0000 - 0001be0000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #43 [000185afc0 - 000185afc8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #44 [000188c980 - 000188c988]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #45 [000188c9c0 - 000188c9e0]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #46 [000188ca00 - 000188ca40]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #47 [000188ca40 - 000188cb60]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #48 [000188cb80 - 000188cbc8]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #49 [000188cc00 - 000188cc48]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #50 [000188e000 - 0001896000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #51 [0008c00000 - 0009400000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #52 [0001c5c6c0 - 000205c6c0]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #54 [0009400000 - 000d400000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #55 [0001896000 - 00018b6000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #56 [00018b6000 - 00018f6000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000]   #57 [000000b000 - 0000013000]         BOOTMEM
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Memory: 7596276k/8650752k available (4545k kernel code, 788936k absent, 265540k reserved, 2373k data, 480k init)
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] NR_IRQS:512
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] I-pipe 2.7-04: pipeline enabled.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  4 13:30:02 cfhat12 kernel: [    0.000000] Detected 3414.811 MHz processor.
Jan  4 13:30:02 cfhat12 kernel: [    0.008006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6829.61 BogoMIPS (lpj=13659228)
Jan  4 13:30:02 cfhat12 kernel: [    0.008009] pid_max: default: 32768 minimum: 301
Jan  4 13:30:02 cfhat12 kernel: [    0.008040] Security Framework initialized
Jan  4 13:30:02 cfhat12 kernel: [    0.008043] SELinux:  Initializing.
Jan  4 13:30:02 cfhat12 kernel: [    0.008050] SELinux:  Starting in permissive mode
Jan  4 13:30:02 cfhat12 kernel: [    0.008062] Mount-cache hash table entries: 256
Jan  4 13:30:02 cfhat12 kernel: [    0.008142] Initializing cgroup subsys ns
Jan  4 13:30:02 cfhat12 kernel: [    0.008144] Initializing cgroup subsys cpuacct
Jan  4 13:30:02 cfhat12 kernel: [    0.008147] Initializing cgroup subsys devices
Jan  4 13:30:02 cfhat12 kernel: [    0.008163] tseg: 00cff00000
Jan  4 13:30:02 cfhat12 kernel: [    0.008164] CPU: Physical Processor ID: 0
Jan  4 13:30:02 cfhat12 kernel: [    0.008165] CPU: Processor Core ID: 0
Jan  4 13:30:02 cfhat12 kernel: [    0.008167] mce: CPU supports 6 MCE banks
Jan  4 13:30:02 cfhat12 kernel: [    0.008173] using C1E aware idle routine
Jan  4 13:30:02 cfhat12 kernel: [    0.008174] Performance Events: AMD PMU driver.
Jan  4 13:30:02 cfhat12 kernel: [    0.008178] ... version:                0
Jan  4 13:30:02 cfhat12 kernel: [    0.008179] ... bit width:              48
Jan  4 13:30:02 cfhat12 kernel: [    0.008180] ... generic registers:      4
Jan  4 13:30:02 cfhat12 kernel: [    0.008181] ... value mask:             0000ffffffffffff
Jan  4 13:30:02 cfhat12 kernel: [    0.008182] ... max period:             00007fffffffffff
Jan  4 13:30:02 cfhat12 kernel: [    0.008184] ... fixed-purpose events:   0
Jan  4 13:30:02 cfhat12 kernel: [    0.008185] ... event mask:             000000000000000f
Jan  4 13:30:02 cfhat12 kernel: [    0.008235] ACPI: Core revision 20100428
Jan  4 13:30:02 cfhat12 kernel: [    0.016057] Setting APIC routing to flat
Jan  4 13:30:02 cfhat12 kernel: [    0.016447] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  4 13:30:02 cfhat12 kernel: [    0.020000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jan  4 13:30:02 cfhat12 kernel: [    0.020000] ...trying to set up timer (IRQ0) through the 8259A ...
Jan  4 13:30:02 cfhat12 kernel: [    0.020000] ..... (found apic 0 pin 2) ...
Jan  4 13:30:02 cfhat12 kernel: [    0.060791] ....... works.
Jan  4 13:30:02 cfhat12 kernel: [    0.060792] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:30:02 cfhat12 kernel: [    0.064000] Booting Node   0, Processors  #1
Jan  4 13:30:02 cfhat12 kernel: [    0.152004] System has AMD C1E enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.152004] Switch to broadcast mode on CPU1
Jan  4 13:30:02 cfhat12 kernel: [    0.152050]  #2
Jan  4 13:30:02 cfhat12 kernel: [    0.244008] Switch to broadcast mode on CPU2
Jan  4 13:30:02 cfhat12 kernel: [    0.244053]  #3
Jan  4 13:30:02 cfhat12 kernel: [    0.336016] Switch to broadcast mode on CPU3
Jan  4 13:30:02 cfhat12 kernel: [    0.336027] Brought up 4 CPUs
Jan  4 13:30:02 cfhat12 kernel: [    0.336031] Total of 4 processors activated (27341.45 BogoMIPS).
Jan  4 13:30:02 cfhat12 kernel: [    0.337651] Switch to broadcast mode on CPU0
Jan  4 13:30:02 cfhat12 kernel: [    0.337794] devtmpfs: initialized
Jan  4 13:30:02 cfhat12 kernel: [    0.338077] NET: Registered protocol family 16
Jan  4 13:30:02 cfhat12 kernel: [    0.338343] node 0 link 0: io port [8000, ffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338346] TOM: 00000000d0000000 aka 3328M
Jan  4 13:30:02 cfhat12 kernel: [    0.338347] Fam 10h mmconf [e0000000, e00fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338349] node 0 link 0: mmio [a0000, bffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338351] node 0 link 0: mmio [d0000000, dfffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338354] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338356] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338358] TOM2: 0000000230000000 aka 8960M
Jan  4 13:30:02 cfhat12 kernel: [    0.338360] bus: [00, 08] on node 0 link 0
Jan  4 13:30:02 cfhat12 kernel: [    0.338362] bus: 00 index 0 [io  0x0000-0xffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338364] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338365] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338367] bus: 00 index 3 [mem 0xe0900000-0xffffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338369] bus: 00 index 4 [mem 0xe0100000-0xe08fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338370] bus: 00 index 5 [mem 0x230000000-0xfcffffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.338378] ACPI: bus type pci registered
Jan  4 13:30:02 cfhat12 kernel: [    0.338439] PCI: Using configuration type 1 for base access
Jan  4 13:30:02 cfhat12 kernel: [    0.338441] PCI: Using configuration type 1 for extended access
Jan  4 13:30:02 cfhat12 kernel: [    0.342214] bio: create slab <bio-0> at 0
Jan  4 13:30:02 cfhat12 kernel: [    0.342900] ACPI: EC: Look up EC in DSDT
Jan  4 13:30:02 cfhat12 kernel: [    0.348434] ACPI: Interpreter enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.348437] ACPI: (supports S0 S5)
Jan  4 13:30:02 cfhat12 kernel: [    0.348447] ACPI: Using IOAPIC for interrupt routing
Jan  4 13:30:02 cfhat12 kernel: [    0.354437] ACPI Warning: Incorrect checksum in table [TAMG] - 0x8C, should be 0x8B (20100428/tbutils-314)
Jan  4 13:30:02 cfhat12 kernel: [    0.354514] ACPI: No dock devices found.
Jan  4 13:30:02 cfhat12 kernel: [    0.354517] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan  4 13:30:02 cfhat12 kernel: [    0.354606] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jan  4 13:30:02 cfhat12 kernel: [    0.354789] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
Jan  4 13:30:02 cfhat12 kernel: [    0.354791] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.354793] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.354795] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.354797] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xfebfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.354815] pci 0000:00:00.0: reg 1c: [mem 0xe0000000-0xffffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.354882] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.354885] pci 0000:00:07.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.354911] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.354914] pci 0000:00:09.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.354940] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.354942] pci 0000:00:0a.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.354974] pci 0000:00:11.0: reg 10: [io  0xff00-0xff07]
Jan  4 13:30:02 cfhat12 kernel: [    0.354979] pci 0000:00:11.0: reg 14: [io  0xfe00-0xfe03]
Jan  4 13:30:02 cfhat12 kernel: [    0.354983] pci 0000:00:11.0: reg 18: [io  0xfd00-0xfd07]
Jan  4 13:30:02 cfhat12 kernel: [    0.354988] pci 0000:00:11.0: reg 1c: [io  0xfc00-0xfc03]
Jan  4 13:30:02 cfhat12 kernel: [    0.354993] pci 0000:00:11.0: reg 20: [io  0xfb00-0xfb0f]
Jan  4 13:30:02 cfhat12 kernel: [    0.354997] pci 0000:00:11.0: reg 24: [mem 0xfe02f000-0xfe02f3ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355010] pci 0000:00:11.0: set SATA to AHCI mode
Jan  4 13:30:02 cfhat12 kernel: [    0.355048] pci 0000:00:12.0: reg 10: [mem 0xfe02e000-0xfe02efff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355094] pci 0000:00:12.2: reg 10: [mem 0xfe02d000-0xfe02d0ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355129] pci 0000:00:12.2: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355131] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:30:02 cfhat12 kernel: [    0.355134] pci 0000:00:12.2: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.355155] pci 0000:00:13.0: reg 10: [mem 0xfe02c000-0xfe02cfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355200] pci 0000:00:13.2: reg 10: [mem 0xfe02b000-0xfe02b0ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355236] pci 0000:00:13.2: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355237] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:30:02 cfhat12 kernel: [    0.355240] pci 0000:00:13.2: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.355294] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
Jan  4 13:30:02 cfhat12 kernel: [    0.355299] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
Jan  4 13:30:02 cfhat12 kernel: [    0.355303] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
Jan  4 13:30:02 cfhat12 kernel: [    0.355308] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
Jan  4 13:30:02 cfhat12 kernel: [    0.355313] pci 0000:00:14.1: reg 20: [io  0xfa00-0xfa0f]
Jan  4 13:30:02 cfhat12 kernel: [    0.355392] pci 0000:00:14.5: reg 10: [mem 0xfe02a000-0xfe02afff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355459] pci 0000:00:15.0: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355507] pci 0000:00:15.1: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355532] pci 0000:00:16.0: reg 10: [mem 0xfe029000-0xfe029fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355577] pci 0000:00:16.2: reg 10: [mem 0xfe028000-0xfe0280ff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355613] pci 0000:00:16.2: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355614] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:30:02 cfhat12 kernel: [    0.355617] pci 0000:00:16.2: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.355702] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.355705] pci 0000:01:05.0: reg 14: [io  0xce00-0xceff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355708] pci 0000:01:05.0: reg 18: [mem 0xfd3e0000-0xfd3effff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355713] pci 0000:01:05.0: reg 24: [mem 0xfd200000-0xfd2fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355723] pci 0000:01:05.0: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355734] pci 0000:01:05.1: reg 10: [mem 0xfd3fc000-0xfd3fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355750] pci 0000:01:05.1: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.355777] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  4 13:30:02 cfhat12 kernel: [    0.355780] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355782] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355785] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.355835] pci 0000:02:00.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355844] pci 0000:02:00.0: reg 14: [mem 0xfdf00000-0xfdf7ffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355852] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
Jan  4 13:30:02 cfhat12 kernel: [    0.355860] pci 0000:02:00.0: reg 1c: [mem 0xfdffc000-0xfdffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355882] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.355924] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.355928] pci 0000:02:00.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.355950] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  4 13:30:02 cfhat12 kernel: [    0.355953] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355955] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.355959] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356006] pci 0000:03:00.0: reg 10: [mem 0xfddfe000-0xfddfffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.356046] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.356049] pci 0000:03:00.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.356062] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  4 13:30:02 cfhat12 kernel: [    0.356065] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356067] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356070] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356107] pci 0000:04:00.0: reg 10: [io  0xde00-0xdeff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356121] pci 0000:04:00.0: reg 18: [mem 0xfd4ff000-0xfd4fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356130] pci 0000:04:00.0: reg 20: [mem 0xfd4f8000-0xfd4fbfff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356136] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356162] pci 0000:04:00.0: supports D1 D2
Jan  4 13:30:02 cfhat12 kernel: [    0.356163] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  4 13:30:02 cfhat12 kernel: [    0.356167] pci 0000:04:00.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.356182] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  4 13:30:02 cfhat12 kernel: [    0.356185] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356187] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356190] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356221] pci 0000:05:06.0: reg 10: [io  0xaf00-0xaf07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356228] pci 0000:05:06.0: reg 14: [io  0xae00-0xae07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356234] pci 0000:05:06.0: reg 18: [io  0xad00-0xad07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356240] pci 0000:05:06.0: reg 1c: [io  0xac00-0xac07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356280] pci 0000:05:06.1: reg 10: [io  0xab00-0xab07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356287] pci 0000:05:06.1: reg 14: [io  0xaa00-0xaa07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356294] pci 0000:05:06.1: reg 18: [io  0xa900-0xa907]
Jan  4 13:30:02 cfhat12 kernel: [    0.356300] pci 0000:05:06.1: reg 1c: [io  0xa800-0xa807]
Jan  4 13:30:02 cfhat12 kernel: [    0.356345] pci 0000:05:08.0: reg 10: [io  0xa700-0xa707]
Jan  4 13:30:02 cfhat12 kernel: [    0.356408] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356412] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356415] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356418] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356420] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356422] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356424] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356426] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356428] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  4 13:30:02 cfhat12 kernel: [    0.356528] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356562] pci 0000:06:00.0: PME# supported from D3hot
Jan  4 13:30:02 cfhat12 kernel: [    0.356566] pci 0000:06:00.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.356605] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356613] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  4 13:30:02 cfhat12 kernel: [    0.356621] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356628] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  4 13:30:02 cfhat12 kernel: [    0.356636] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  4 13:30:02 cfhat12 kernel: [    0.356688] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  4 13:30:02 cfhat12 kernel: [    0.356692] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356695] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356699] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356840] pci 0000:07:00.0: supports D1
Jan  4 13:30:02 cfhat12 kernel: [    0.356841] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  4 13:30:02 cfhat12 kernel: [    0.356847] pci 0000:07:00.0: PME# disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.356866] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  4 13:30:02 cfhat12 kernel: [    0.356870] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356873] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.356878] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.356976] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356987] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  4 13:30:02 cfhat12 kernel: [    0.356997] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  4 13:30:02 cfhat12 kernel: [    0.357007] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  4 13:30:02 cfhat12 kernel: [    0.357017] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  4 13:30:02 cfhat12 kernel: [    0.357028] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  4 13:30:02 cfhat12 kernel: [    0.357115] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  4 13:30:02 cfhat12 kernel: [    0.357120] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.357126] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.357132] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.357158] pci_bus 0000:00: on NUMA node 0
Jan  4 13:30:02 cfhat12 kernel: [    0.357160] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357384] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357422] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357465] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357546] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357582] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357617] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.357656] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  4 13:30:02 cfhat12 kernel: [    0.375087] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375156] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375222] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375288] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375354] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375419] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375487] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375553] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:30:02 cfhat12 kernel: [    0.375731] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  4 13:30:02 cfhat12 kernel: [    0.375736] vgaarb: loaded
Jan  4 13:30:02 cfhat12 kernel: [    0.375875] SCSI subsystem initialized
Jan  4 13:30:02 cfhat12 kernel: [    0.375959] libata version 3.00 loaded.
Jan  4 13:30:02 cfhat12 kernel: [    0.376165] usbcore: registered new interface driver usbfs
Jan  4 13:30:02 cfhat12 kernel: [    0.376193] usbcore: registered new interface driver hub
Jan  4 13:30:02 cfhat12 kernel: [    0.376230] usbcore: registered new device driver usb
Jan  4 13:30:02 cfhat12 kernel: [    0.376428] Advanced Linux Sound Architecture Driver Version 1.0.23.
Jan  4 13:30:02 cfhat12 kernel: [    0.376430] PCI: Using ACPI for IRQ routing
Jan  4 13:30:02 cfhat12 kernel: [    0.376432] PCI: pci_cache_line_size set to 64 bytes
Jan  4 13:30:02 cfhat12 kernel: [    0.376438] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.376521] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  4 13:30:02 cfhat12 kernel: [    0.376523] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  4 13:30:02 cfhat12 kernel: [    0.376626] NetLabel: Initializing
Jan  4 13:30:02 cfhat12 kernel: [    0.376627] NetLabel:  domain hash size = 128
Jan  4 13:30:02 cfhat12 kernel: [    0.376629] NetLabel:  protocols = UNLABELED CIPSOv4
Jan  4 13:30:02 cfhat12 kernel: [    0.376638] NetLabel:  unlabeled traffic allowed by default
Jan  4 13:30:02 cfhat12 kernel: [    0.376661] Switching to clocksource tsc
Jan  4 13:30:02 cfhat12 kernel: [    0.378664] pnp: PnP ACPI init
Jan  4 13:30:02 cfhat12 kernel: [    0.378672] ACPI: bus type pnp registered
Jan  4 13:30:02 cfhat12 kernel: [    0.379246] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379270] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.379275] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.379835] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379838] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379841] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379844] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379847] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379849] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:30:02 cfhat12 kernel: [    0.379939] pnp: PnP ACPI: found 11 devices
Jan  4 13:30:02 cfhat12 kernel: [    0.379940] ACPI: ACPI bus type pnp unregistered
Jan  4 13:30:02 cfhat12 kernel: [    0.379946] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379948] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379950] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379955] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379957] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379959] system 00:02: [io  0x040b] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379960] system 00:02: [io  0x04d6] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379962] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379965] system 00:02: [io  0x0c14] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379966] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379968] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379970] system 00:02: [io  0x0c6f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379972] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379974] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379976] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379977] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379979] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379981] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379983] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379985] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379987] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379991] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379995] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379997] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.379999] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.380001] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.380003] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.380005] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.380007] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  4 13:30:02 cfhat12 kernel: [    0.386732] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  4 13:30:02 cfhat12 kernel: [    0.386734] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386737] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386739] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386743] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386746] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  4 13:30:02 cfhat12 kernel: [    0.386747] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386750] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386753] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386756] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  4 13:30:02 cfhat12 kernel: [    0.386758] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386760] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386763] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386766] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386768] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  4 13:30:02 cfhat12 kernel: [    0.386770] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386773] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386775] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386778] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  4 13:30:02 cfhat12 kernel: [    0.386781] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386785] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386788] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386793] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  4 13:30:02 cfhat12 kernel: [    0.386795] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386799] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386802] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386806] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  4 13:30:02 cfhat12 kernel: [    0.386810] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386818] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386823] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386833] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  4 13:30:02 cfhat12 kernel: [    0.386835] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386839] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386842] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386857] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:30:02 cfhat12 kernel: [    0.386859] pci 0000:00:07.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386867] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.386869] pci 0000:00:09.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386877] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    0.386879] pci 0000:00:0a.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386887] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.386890] pci 0000:00:15.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386895] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.386898] pci 0000:00:15.1: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386909] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.386915] pci 0000:07:00.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.386919] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  4 13:30:02 cfhat12 kernel: [    0.386920] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386922] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386924] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386925] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386927] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386929] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386931] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386933] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386934] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386936] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386938] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386940] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386942] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386944] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386945] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386947] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386949] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386951] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386952] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386954] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  4 13:30:02 cfhat12 kernel: [    0.386956] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386957] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386959] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386961] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386963] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386964] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386966] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386968] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386970] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386972] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.386974] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386975] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  4 13:30:02 cfhat12 kernel: [    0.386977] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:30:02 cfhat12 kernel: [    0.387028] NET: Registered protocol family 2
Jan  4 13:30:02 cfhat12 kernel: [    0.387069] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.387564] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.388528] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.388766] TCP: Hash tables configured (established 262144 bind 65536)
Jan  4 13:30:02 cfhat12 kernel: [    0.388768] TCP reno registered
Jan  4 13:30:02 cfhat12 kernel: [    0.388771] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.388808] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.388939] NET: Registered protocol family 1
Jan  4 13:30:02 cfhat12 kernel: [    0.389056] RPC: Registered udp transport module.
Jan  4 13:30:02 cfhat12 kernel: [    0.389057] RPC: Registered tcp transport module.
Jan  4 13:30:02 cfhat12 kernel: [    0.389058] RPC: Registered tcp NFSv4.1 backchannel transport module.
Jan  4 13:30:02 cfhat12 kernel: [    0.389066] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  4 13:30:02 cfhat12 kernel: [    0.451419] pci 0000:01:05.0: Boot video device
Jan  4 13:30:02 cfhat12 kernel: [    0.451457] PCI: CLS 4 bytes, default 64
Jan  4 13:30:02 cfhat12 kernel: [    0.451500] Trying to unpack rootfs image as initramfs...
Jan  4 13:30:02 cfhat12 kernel: [    0.499217] Freeing initrd memory: 3372k freed
Jan  4 13:30:02 cfhat12 kernel: [    0.499887] PCI-DMA: Disabling AGP.
Jan  4 13:30:02 cfhat12 kernel: [    0.500049] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  4 13:30:02 cfhat12 kernel: [    0.500051] PCI-DMA: using GART IOMMU.
Jan  4 13:30:02 cfhat12 kernel: [    0.500053] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  4 13:30:02 cfhat12 kernel: [    0.504207] audit: initializing netlink socket (disabled)
Jan  4 13:30:02 cfhat12 kernel: [    0.504217] type=2000 audit(1294165791.500:1): initialized
Jan  4 13:30:02 cfhat12 kernel: [    0.504248] I-pipe: Domain Xenomai registered.
Jan  4 13:30:02 cfhat12 kernel: [    0.504317] Xenomai: hal/x86_64 started.
Jan  4 13:30:02 cfhat12 kernel: [    0.504328] Xenomai: scheduling class idle registered.
Jan  4 13:30:02 cfhat12 kernel: [    0.504329] Xenomai: scheduling class rt registered.
Jan  4 13:30:02 cfhat12 kernel: [    0.505448] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  4 13:30:02 cfhat12 kernel: [    0.703422] Xenomai: native skin init failed, code -19.
Jan  4 13:30:02 cfhat12 kernel: [    0.703778] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  4 13:30:02 cfhat12 kernel: [    0.703930] VFS: Disk quotas dquot_6.5.2
Jan  4 13:30:02 cfhat12 kernel: [    0.703951] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  4 13:30:02 cfhat12 kernel: [    0.704116] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, debug enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.704368] SGI XFS Quota Management subsystem
Jan  4 13:30:02 cfhat12 kernel: [    0.704373] msgmni has been set to 14971
Jan  4 13:30:02 cfhat12 kernel: [    0.704400] SELinux:  Registering netfilter hooks
Jan  4 13:30:02 cfhat12 kernel: [    0.704640] alg: No test for stdrng (krng)
Jan  4 13:30:02 cfhat12 kernel: [    0.704705] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  4 13:30:02 cfhat12 kernel: [    0.704708] io scheduler noop registered
Jan  4 13:30:02 cfhat12 kernel: [    0.704709] io scheduler deadline registered
Jan  4 13:30:02 cfhat12 kernel: [    0.704721] io scheduler cfq registered (default)
Jan  4 13:30:02 cfhat12 kernel: [    0.704817] pcieport 0000:00:07.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.704837] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.704911] pcieport 0000:00:09.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.704927] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.704997] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.705013] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.705085] pcieport 0000:00:15.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.705116] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.705199] pcieport 0000:00:15.1: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.705229] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.705717] Non-volatile memory driver v1.3
Jan  4 13:30:02 cfhat12 kernel: [    0.705720] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.959584] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:30:02 cfhat12 kernel: [    0.959934] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:30:02 cfhat12 kernel: [    0.960033] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:30:02 cfhat12 kernel: [    0.960119] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  4 13:30:02 cfhat12 kernel: [    0.960232] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  4 13:30:02 cfhat12 kernel: [    0.960345] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  4 13:30:02 cfhat12 kernel: [    0.960378] Couldn't register serial port 0000:05:06.0: -28
Jan  4 13:30:02 cfhat12 kernel: [    0.960385] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:30:02 cfhat12 kernel: [    0.960387] Couldn't register serial port 0000:05:06.1: -28
Jan  4 13:30:02 cfhat12 kernel: [    0.961527] brd: module loaded
Jan  4 13:30:02 cfhat12 kernel: [    0.961690] ahci 0000:00:11.0: version 3.0
Jan  4 13:30:02 cfhat12 kernel: [    0.961696] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:30:02 cfhat12 kernel: [    0.961732] ahci 0000:00:11.0: irq 45 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    0.961795] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  4 13:30:02 cfhat12 kernel: [    0.961798] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  4 13:30:02 cfhat12 kernel: [    0.961965] scsi0 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.962034] scsi1 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.962083] scsi2 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.962130] scsi3 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.962221] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 45
Jan  4 13:30:02 cfhat12 kernel: [    0.962224] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 45
Jan  4 13:30:02 cfhat12 kernel: [    0.962226] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 45
Jan  4 13:30:02 cfhat12 kernel: [    0.962228] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 45
Jan  4 13:30:02 cfhat12 kernel: [    0.962254] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.975468] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  4 13:30:02 cfhat12 kernel: [    0.975471] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  4 13:30:02 cfhat12 kernel: [    0.975476] ahci 0000:06:00.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.975593] scsi4 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.975664] scsi5 : ahci
Jan  4 13:30:02 cfhat12 kernel: [    0.975700] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  4 13:30:02 cfhat12 kernel: [    0.975703] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  4 13:30:02 cfhat12 kernel: [    0.975909] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.975983] scsi6 : pata_atiixp
Jan  4 13:30:02 cfhat12 kernel: [    0.976035] scsi7 : pata_atiixp
Jan  4 13:30:02 cfhat12 kernel: [    0.976773] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  4 13:30:02 cfhat12 kernel: [    0.976775] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  4 13:30:02 cfhat12 kernel: [    0.976854] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  4 13:30:02 cfhat12 kernel: [    0.976859] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.976884] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    0.976932] scsi8 : pata_jmicron
Jan  4 13:30:02 cfhat12 kernel: [    0.977005] scsi9 : pata_jmicron
Jan  4 13:30:02 cfhat12 kernel: [    0.977053] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  4 13:30:02 cfhat12 kernel: [    0.977055] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  4 13:30:02 cfhat12 kernel: [    0.977163] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Jan  4 13:30:02 cfhat12 kernel: [    0.977165] e100: Copyright(c) 1999-2006 Intel Corporation
Jan  4 13:30:02 cfhat12 kernel: [    0.977249] console [netcon0] enabled
Jan  4 13:30:02 cfhat12 kernel: [    0.977251] netconsole: network logging started
Jan  4 13:30:02 cfhat12 kernel: [    0.977261] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  4 13:30:02 cfhat12 kernel: [    0.977271] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.977282] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    0.977298] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  4 13:30:02 cfhat12 kernel: [    0.977320] ehci_hcd 0000:00:12.2: debug port 1
Jan  4 13:30:02 cfhat12 kernel: [    0.977328] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  4 13:30:02 cfhat12 kernel: [    0.987452] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  4 13:30:02 cfhat12 kernel: [    0.987585] hub 1-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    0.987588] hub 1-0:1.0: 5 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    0.987625] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.987636] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    0.987641] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  4 13:30:02 cfhat12 kernel: [    0.987663] ehci_hcd 0000:00:13.2: debug port 1
Jan  4 13:30:02 cfhat12 kernel: [    0.987672] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  4 13:30:02 cfhat12 kernel: [    0.999455] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  4 13:30:02 cfhat12 kernel: [    0.999576] hub 2-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    0.999579] hub 2-0:1.0: 5 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    0.999615] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    0.999625] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    0.999630] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  4 13:30:02 cfhat12 kernel: [    0.999651] ehci_hcd 0000:00:16.2: debug port 1
Jan  4 13:30:02 cfhat12 kernel: [    0.999661] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  4 13:30:02 cfhat12 kernel: [    1.011455] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  4 13:30:02 cfhat12 kernel: [    1.011575] hub 3-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.011578] hub 3-0:1.0: 4 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.011631] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  4 13:30:02 cfhat12 kernel: [    1.011641] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    1.011652] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    1.011658] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  4 13:30:02 cfhat12 kernel: [    1.011682] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  4 13:30:02 cfhat12 kernel: [    1.071567] hub 4-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.071573] hub 4-0:1.0: 5 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.071608] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    1.071618] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    1.071623] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  4 13:30:02 cfhat12 kernel: [    1.071636] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  4 13:30:02 cfhat12 kernel: [    1.131626] hub 5-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.131632] hub 5-0:1.0: 5 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.131668] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    1.131678] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    1.131683] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  4 13:30:02 cfhat12 kernel: [    1.131697] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  4 13:30:02 cfhat12 kernel: [    1.151723] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  4 13:30:02 cfhat12 kernel: [    1.151737] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  4 13:30:02 cfhat12 kernel: [    1.167744] ata7.00: configured for UDMA/33
Jan  4 13:30:02 cfhat12 kernel: [    1.195605] hub 6-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.195611] hub 6-0:1.0: 2 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.195645] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    1.195656] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    1.195662] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  4 13:30:02 cfhat12 kernel: [    1.195678] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  4 13:30:02 cfhat12 kernel: [    1.255593] hub 7-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.255598] hub 7-0:1.0: 4 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.255651] uhci_hcd: USB Universal Host Controller Interface driver
Jan  4 13:30:02 cfhat12 kernel: [    1.255702] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    1.255713] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    1.255716] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  4 13:30:02 cfhat12 kernel: [    1.255720] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  4 13:30:02 cfhat12 kernel: [    1.255817] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  4 13:30:02 cfhat12 kernel: [    1.259181] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  4 13:30:02 cfhat12 kernel: [    1.259270] xHCI xhci_add_endpoint called for root hub
Jan  4 13:30:02 cfhat12 kernel: [    1.259271] xHCI xhci_check_bandwidth called for root hub
Jan  4 13:30:02 cfhat12 kernel: [    1.259306] hub 8-0:1.0: USB hub found
Jan  4 13:30:02 cfhat12 kernel: [    1.259309] hub 8-0:1.0: 4 ports detected
Jan  4 13:30:02 cfhat12 kernel: [    1.259410] usbcore: registered new interface driver usblp
Jan  4 13:30:02 cfhat12 kernel: [    1.259412] Initializing USB Mass Storage driver...
Jan  4 13:30:02 cfhat12 kernel: [    1.259474] usbcore: registered new interface driver usb-storage
Jan  4 13:30:02 cfhat12 kernel: [    1.259476] USB Mass Storage support registered.
Jan  4 13:30:02 cfhat12 kernel: [    1.259536] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  4 13:30:02 cfhat12 kernel: [    1.259538] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  4 13:30:02 cfhat12 kernel: [    1.259667] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 13:30:02 cfhat12 kernel: [    1.259762] mice: PS/2 mouse device common for all mice
Jan  4 13:30:02 cfhat12 kernel: [    1.259806] rtc_cmos 00:04: RTC can wake from S4
Jan  4 13:30:02 cfhat12 kernel: [    1.259851] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  4 13:30:02 cfhat12 kernel: [    1.259871] rtc0: alarms up to one month, 242 bytes nvram
Jan  4 13:30:02 cfhat12 kernel: [    1.259895] md: linear personality registered for level -1
Jan  4 13:30:02 cfhat12 kernel: [    1.259897] md: raid0 personality registered for level 0
Jan  4 13:30:02 cfhat12 kernel: [    1.259898] md: raid1 personality registered for level 1
Jan  4 13:30:02 cfhat12 kernel: [    1.259899] md: raid10 personality registered for level 10
Jan  4 13:30:02 cfhat12 kernel: [    1.259929] device-mapper: uevent: version 1.0.3
Jan  4 13:30:02 cfhat12 kernel: [    1.259994] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid
Jan  4 13:30:02 cfhat12 kernel: [    1.260003] cpuidle: using governor ladder
Jan  4 13:30:02 cfhat12 kernel: [    1.260900] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:30:02 cfhat12 kernel: [    1.260927] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    1.276021] ALSA device list:
Jan  4 13:30:02 cfhat12 kernel: [    1.276022]   #0: HDA ATI HDMI at 0xfd3fc000 irq 19
Jan  4 13:30:02 cfhat12 kernel: [    1.276052] Netfilter messages via NETLINK v0.30.
Jan  4 13:30:02 cfhat12 kernel: [    1.276062] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jan  4 13:30:02 cfhat12 kernel: [    1.276140] ctnetlink v0.93: registering with nfnetlink.
Jan  4 13:30:02 cfhat12 kernel: [    1.276373] ip_tables: (C) 2000-2006 Netfilter Core Team
Jan  4 13:30:02 cfhat12 kernel: [    1.276400] TCP bic registered
Jan  4 13:30:02 cfhat12 kernel: [    1.276401] TCP cubic registered
Jan  4 13:30:02 cfhat12 kernel: [    1.276403] NET: Registered protocol family 17
Jan  4 13:30:02 cfhat12 kernel: [    1.276519] registered taskstats version 1
Jan  4 13:30:02 cfhat12 kernel: [    1.283512] ata4: SATA link down (SStatus 0 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.283533] ata3: SATA link down (SStatus 0 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.299519] ata6: SATA link down (SStatus 0 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.311529] ata5: SATA link down (SStatus 0 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.314012] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  4 13:30:02 cfhat12 kernel: [    1.459525] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.461059] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  4 13:30:02 cfhat12 kernel: [    1.461061] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  4 13:30:02 cfhat12 kernel: [    1.462621] ata1.00: configured for UDMA/133
Jan  4 13:30:02 cfhat12 kernel: [    1.463516] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  4 13:30:02 cfhat12 kernel: [    1.479605] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  4 13:30:02 cfhat12 kernel: [    1.479770] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:30:02 cfhat12 kernel: [    1.479779] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  4 13:30:02 cfhat12 kernel: [    1.479795] sd 0:0:0:0: [sda] Write Protect is off
Jan  4 13:30:02 cfhat12 kernel: [    1.479797] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  4 13:30:02 cfhat12 kernel: [    1.479808] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:30:02 cfhat12 kernel: [    1.479891]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Jan  4 13:30:02 cfhat12 kernel: [    1.512403] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  4 13:30:02 cfhat12 kernel: [    1.535528] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:30:02 cfhat12 kernel: [    1.538398] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  4 13:30:02 cfhat12 kernel: [    1.538401] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  4 13:30:02 cfhat12 kernel: [    1.541448] ata2.00: configured for UDMA/133
Jan  4 13:30:02 cfhat12 kernel: [    1.559600] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  4 13:30:02 cfhat12 kernel: [    1.559717] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:30:02 cfhat12 kernel: [    1.559743] sd 1:0:0:0: [sdb] Write Protect is off
Jan  4 13:30:02 cfhat12 kernel: [    1.559745] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  4 13:30:02 cfhat12 kernel: [    1.559756] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:30:02 cfhat12 kernel: [    1.559803] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  4 13:30:02 cfhat12 kernel: [    1.559830]  sdb:
Jan  4 13:30:02 cfhat12 kernel: [    1.560650] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  4 13:30:02 cfhat12 kernel: [    1.564742] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  4 13:30:02 cfhat12 kernel: [    1.564744] Uniform CD-ROM driver Revision: 3.20
Jan  4 13:30:02 cfhat12 kernel: [    1.564870] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  4 13:30:02 cfhat12 kernel: [    1.564939] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  4 13:30:02 cfhat12 kernel: [    1.567667]  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jan  4 13:30:02 cfhat12 kernel: [    1.597438] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  4 13:30:02 cfhat12 kernel: [    1.731006] Freeing unused kernel memory: 480k freed
Jan  4 13:30:02 cfhat12 kernel: [    1.740550] udev[804]: starting version 164
Jan  4 13:30:02 cfhat12 kernel: [    1.758507] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  4 13:30:02 cfhat12 kernel: [    1.758509] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  4 13:30:02 cfhat12 kernel: [    1.758543] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:30:02 cfhat12 kernel: [    1.758552] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  4 13:30:02 cfhat12 kernel: [    1.758559] e1000e 0000:02:00.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    1.758576] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:30:02 cfhat12 kernel: [    1.758636] r8169 0000:04:00.0: setting latency timer to 64
Jan  4 13:30:02 cfhat12 kernel: [    1.758681] r8169 0000:04:00.0: irq 46 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    1.758741] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    1.758744] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    1.758745] e1000e 0000:02:00.0: irq 49 for MSI/MSI-X
Jan  4 13:30:02 cfhat12 kernel: [    1.758862] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000054000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 46
Jan  4 13:30:02 cfhat12 kernel: [    1.759224] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  4 13:30:02 cfhat12 kernel: [    1.787716] usbcore: registered new interface driver hiddev
Jan  4 13:30:02 cfhat12 kernel: [    1.791712] input: USBPS2 as /class/input/input1
Jan  4 13:30:02 cfhat12 kernel: [    1.791721] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  4 13:30:02 cfhat12 kernel: [    1.798758] input: USBPS2 as /class/input/input2
Jan  4 13:30:02 cfhat12 kernel: [    1.798795] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  4 13:30:02 cfhat12 kernel: [    1.798804] usbcore: registered new interface driver usbhid
Jan  4 13:30:02 cfhat12 kernel: [    1.798805] usbhid: USB HID core driver
Jan  4 13:30:02 cfhat12 kernel: [    1.880675] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  4 13:30:02 cfhat12 kernel: [    1.880678] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  4 13:30:02 cfhat12 kernel: [    1.880689] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  4 13:30:02 cfhat12 kernel: [    2.022954] md: md1 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    2.024029] md: bind<sdb1>
Jan  4 13:30:02 cfhat12 kernel: [    2.024180] md: bind<sda1>
Jan  4 13:30:02 cfhat12 kernel: [    2.024888] md/raid1:md1: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    2.024903] md1: detected capacity change from 0 to 254791680
Jan  4 13:30:02 cfhat12 kernel: [    2.025412]  md1: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    2.240133] md: md2 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    2.241064] md: bind<sdb2>
Jan  4 13:30:02 cfhat12 kernel: [    2.241197] md: bind<sda2>
Jan  4 13:30:02 cfhat12 kernel: [    2.241893] md/raid1:md2: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    2.241906] md2: detected capacity change from 0 to 19998367744
Jan  4 13:30:02 cfhat12 kernel: [    2.242404]  md2: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    2.456181] md: md3 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    2.456947] md: bind<sdb3>
Jan  4 13:30:02 cfhat12 kernel: [    2.457102] md: bind<sda3>
Jan  4 13:30:02 cfhat12 kernel: [    2.457788] md/raid1:md3: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    2.457801] md3: detected capacity change from 0 to 1998573568
Jan  4 13:30:02 cfhat12 kernel: [    2.458303]  md3: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    2.684890] md: md5 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    2.685674] md: bind<sdb5>
Jan  4 13:30:02 cfhat12 kernel: [    2.685851] md: bind<sda5>
Jan  4 13:30:02 cfhat12 kernel: [    2.686537] md/raid1:md5: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    2.686551] md5: detected capacity change from 0 to 19997319168
Jan  4 13:30:02 cfhat12 kernel: [    2.687053]  md5: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    2.917294] md: md6 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    2.918104] md: bind<sdb6>
Jan  4 13:30:02 cfhat12 kernel: [    2.918300] md: bind<sda6>
Jan  4 13:30:02 cfhat12 kernel: [    2.918981] md/raid1:md6: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    2.918994] md6: detected capacity change from 0 to 19997319168
Jan  4 13:30:02 cfhat12 kernel: [    2.919492]  md6: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    3.143503] md: md7 stopped.
Jan  4 13:30:02 cfhat12 kernel: [    3.144470] md: bind<sdb7>
Jan  4 13:30:02 cfhat12 kernel: [    3.144669] md: bind<sda7>
Jan  4 13:30:02 cfhat12 kernel: [    3.145354] md/raid1:md7: active with 2 out of 2 mirrors
Jan  4 13:30:02 cfhat12 kernel: [    3.145366] md7: detected capacity change from 0 to 97784881152
Jan  4 13:30:02 cfhat12 kernel: [    3.145860]  md7: unknown partition table
Jan  4 13:30:02 cfhat12 kernel: [    3.417587] XFS mounting filesystem md2
Jan  4 13:30:02 cfhat12 kernel: [    3.704202] Ending clean XFS mount for filesystem: md2
Jan  4 13:30:02 cfhat12 kernel: [    5.042794] udev[1075]: starting version 164
Jan  4 13:30:02 cfhat12 kernel: [    5.693069] input: Power Button as /class/input/input3
Jan  4 13:30:02 cfhat12 kernel: [    5.693099] ACPI: Power Button [PWRB]
Jan  4 13:30:02 cfhat12 kernel: [    5.693151] input: Power Button as /class/input/input4
Jan  4 13:30:02 cfhat12 kernel: [    5.693168] ACPI: Power Button [PWRF]
Jan  4 13:30:02 cfhat12 kernel: [    5.706252] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f pref]
Jan  4 13:30:02 cfhat12 kernel: [    5.706255] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  4 13:30:02 cfhat12 kernel: [    5.716320] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    5.716324] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    5.716400] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  4 13:30:02 cfhat12 kernel: [    5.730619] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  4 13:30:02 cfhat12 kernel: [    5.734643] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  4 13:30:02 cfhat12 kernel: [    5.734646] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  4 13:30:02 cfhat12 kernel: [    5.734647] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  4 13:30:02 cfhat12 kernel: [    5.735695] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  4 13:30:02 cfhat12 kernel: [    5.804173] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  4 13:30:02 cfhat12 kernel: [    5.804251] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  4 13:30:02 cfhat12 kernel: [    7.146448] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  4 13:30:02 cfhat12 kernel: [    7.391525] loop: module loaded
Jan  4 13:30:02 cfhat12 kernel: [    8.006818] EXT3-fs: barriers not enabled
Jan  4 13:30:02 cfhat12 kernel: [    8.010029] kjournald starting.  Commit interval 5 seconds
Jan  4 13:30:02 cfhat12 kernel: [    8.024761] EXT3-fs (md1): using internal journal
Jan  4 13:30:02 cfhat12 kernel: [    8.024765] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  4 13:30:02 cfhat12 kernel: [    8.098321] XFS mounting filesystem md7
Jan  4 13:30:02 cfhat12 kernel: [    8.430701] Ending clean XFS mount for filesystem: md7
Jan  4 13:30:02 cfhat12 kernel: [    8.481463] XFS mounting filesystem md5
Jan  4 13:30:02 cfhat12 kernel: [    8.752237] Ending clean XFS mount for filesystem: md5
Jan  4 13:30:02 cfhat12 kernel: [    8.788199] EXT3-fs: barriers not enabled
Jan  4 13:30:02 cfhat12 kernel: [    8.793668] kjournald starting.  Commit interval 5 seconds
Jan  4 13:30:02 cfhat12 kernel: [    8.810923] EXT3-fs (md6): using internal journal
Jan  4 13:30:02 cfhat12 kernel: [    8.810927] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  4 13:30:02 cfhat12 kernel: [    9.631045] r8169 0000:04:00.0: eth0: link up
Jan  4 13:30:02 cfhat12 kernel: [    9.631051] r8169 0000:04:00.0: eth0: link up
Jan  4 13:30:02 cfhat12 kernel: [   10.078437] fuse init (API version 7.14)
Jan  4 13:30:02 cfhat12 kernel: [   10.394350] NET: Registered protocol family 10
Jan  4 13:30:12 cfhat12 kernel: [   20.998196] eth0: no IPv6 routers present
Jan  4 13:38:28 cfhat12 kernel: [  516.723666] md: md7 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723696] md: md6 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723724] md: md5 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723756] md: md3 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723784] md: md2 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723812] md: md1 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723905] md: md7 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723945] md: md6 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723970] md: md5 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.723995] md: md3 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.724018] md: md2 still in use.
Jan  4 13:38:28 cfhat12 kernel: [  516.724041] md: md1 still in use.
Jan  4 13:38:29 cfhat12 kernel: [  517.457158] fuse exit
Jan  4 13:38:34 cfhat12 kernel: Kernel logging (proc) stopped.
Jan  4 13:39:13 cfhat12 kernel: imklog 4.6.4, log source = /proc/kmsg started.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpuset
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Initializing cgroup subsys cpu
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Linux version 2.6.35.7-xeno6 (hatuser@domain.hid) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 SMP Tue Jan 4 13:17:47 EST 2011
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno6 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] BIOS-provided physical RAM map:
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cfdf0000 (usable)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf0000 - 00000000cfdf1000 (ACPI NVS)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfdf1000 - 00000000cfe00000 (ACPI data)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000cfe00000 - 00000000cff00000 (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] NX (Execute Disable) protection: active
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] DMI 2.4 present.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] last_pfn = 0x210000 max_arch_pfn = 0x400000000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] MTRR default type: uncachable
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] MTRR fixed ranges enabled:
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   00000-9FFFF write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   A0000-BFFFF uncachable
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   C0000-C7FFF write-protect
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   C8000-FFFFF uncachable
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] MTRR variable ranges enabled:
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   5 base 000200000000 mask FFFFF0000000 write-back
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   6 disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   7 disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] TOM2: 0000000230000000 aka 8960M
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] e820 update range: 00000000cfe00000 - 0000000100000000 (usable) ==> (reserved)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] last_pfn = 0xcfdf0 max_arch_pfn = 0x400000000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] found SMP MP-table at [ffff8800000f4410] f4410
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Using GB pages for direct mapping
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000cfdf0000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  0000000000 - 00c0000000 page 1G
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  00c0000000 - 00cfc00000 page 2M
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  00cfc00000 - 00cfdf0000 page 4k
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to cfdf0000 @ 8000-b000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] init_memory_mapping: 0000000100000000-0000000210000000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  0100000000 - 0200000000 page 1G
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  0200000000 - 0210000000 page 2M
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] kernel direct mapping tables up to 210000000 @ a000-c000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] RAMDISK: 37ca5000 - 37ff0000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: RSDP 00000000000f5db0 00014 (v00 GBT   )
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: RSDT 00000000cfdf1000 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: FACP 00000000cfdf1080 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: DSDT 00000000cfdf1100 07791 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: FACS 00000000cfdf0000 00040
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: SSDT 00000000cfdf8980 0088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: MCFG 00000000cfdf9280 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: MATS 00000000cfdf92c0 00034 (v01 GBT             00000000      00000000)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: TAMG 00000000cfdf9330 0048A (v01 GBT    GBT   B0 5455312E BG?? 53450101)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: APIC 00000000cfdf88c0 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]  [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880002200000-ffff880008bfffff] on node 0
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Zone PFN ranges:
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   Normal   0x00100000 -> 0x00210000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Movable zone start PFN for each node
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] early_node_map[3] active PFN ranges
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]     0: 0x00000001 -> 0x0000009f
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]     0: 0x00000100 -> 0x000cfdf0
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]     0: 0x00100000 -> 0x00210000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] On node 0 totalpages: 1965454
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA zone: 0 pages reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA zone: 3942 pages, LIFO batch:0
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA32 zone: 14280 pages used for memmap
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   DMA32 zone: 833064 pages, LIFO batch:31
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   Normal zone: 15232 pages used for memmap
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   Normal zone: 1098880 pages, LIFO batch:31
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: IRQ0 used by override.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: IRQ2 used by override.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] ACPI: IRQ9 used by override.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] nr_irqs_gsi: 40
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] early_res array is doubled to 64 at [3000 - 37ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880001a00000 s101760 r8192 d21120 u262144
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] pcpu-alloc: s101760 r8192 d21120 u262144 alloc=1*2097152
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1935886
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.35.7-xeno6 root=UUID=35576261-b346-41e5-ad7d-038009d97534 ro quiet
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Checking aperture...
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] No AGP bridge found
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Node 0: aperture @ 20000000 size 32 MB
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Aperture pointing to e820 RAM. Ignoring.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Your BIOS doesn't leave a aperture memory hole
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Please enable the IOMMU option in the BIOS setup
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] This costs you 64 MB of RAM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] early_res array is doubled to 128 at [3800 - 47ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Subtract (58 early reservations)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #1 [0001000000 - 000185ad98]   TEXT DATA BSS
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #2 [0037ca5000 - 0037ff0000]         RAMDISK
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #3 [000185b000 - 000185b0fe]             BRK
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #4 [00000f4420 - 0000100000]   BIOS reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #5 [00000f4410 - 00000f4420]    MP-table mpf
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #6 [000009f800 - 00000f1aa4]   BIOS reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #7 [00000f1c88 - 00000f4410]   BIOS reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #8 [00000f1aa4 - 00000f1c88]    MP-table mpc
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #9 [0000001000 - 0000003000]      TRAMPOLINE
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #10 [0000008000 - 000000a000]         PGTABLE
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #11 [000000a000 - 000000b000]         PGTABLE
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #12 [000185b100 - 000185c100]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #13 [0001c5c100 - 0001c5c6a0]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #14 [000205d000 - 000205e000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #15 [000205e000 - 000205f000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #16 [0002200000 - 0008c00000]        MEMMAP 0
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #17 [000185adc0 - 000185af40]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #18 [000185c100 - 0001874100]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #19 [0001874100 - 000188c100]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #20 [000188d000 - 000188e000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #21 [000185af40 - 000185af83]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #22 [000188c100 - 000188c368]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #23 [000188c380 - 000188c3e8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #24 [000188c400 - 000188c468]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #25 [000188c480 - 000188c4e8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #26 [000188c500 - 000188c568]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #27 [000188c580 - 000188c5e8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #28 [000188c600 - 000188c668]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #29 [000188c680 - 000188c6e8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #30 [000188c700 - 000188c768]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #31 [000188c780 - 000188c7e8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #32 [000188c800 - 000188c868]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #33 [000188c880 - 000188c8db]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #34 [000188c900 - 000188c95b]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #35 [0001a00000 - 0001a20000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #36 [0001a40000 - 0001a60000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #37 [0001a80000 - 0001aa0000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #38 [0001ac0000 - 0001ae0000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #39 [0001b00000 - 0001b20000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #40 [0001b40000 - 0001b60000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #41 [0001b80000 - 0001ba0000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #42 [0001bc0000 - 0001be0000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #43 [000185afc0 - 000185afc8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #44 [000188c980 - 000188c988]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #45 [000188c9c0 - 000188c9e0]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #46 [000188ca00 - 000188ca40]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #47 [000188ca40 - 000188cb60]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #48 [000188cb80 - 000188cbc8]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #49 [000188cc00 - 000188cc48]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #50 [000188e000 - 0001896000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #51 [0008c00000 - 0009400000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #52 [0001c5c6c0 - 000205c6c0]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #54 [0009400000 - 000d400000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #55 [0001896000 - 00018b6000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #56 [00018b6000 - 00018f6000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000]   #57 [000000b000 - 0000013000]         BOOTMEM
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Memory: 7596276k/8650752k available (4545k kernel code, 788936k absent, 265540k reserved, 2373k data, 480k init)
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Hierarchical RCU implementation.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] NR_IRQS:512
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] I-pipe 2.7-04: pipeline enabled.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] spurious 8259A interrupt: IRQ7.
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Console: colour VGA+ 80x25
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] console [tty0] enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Fast TSC calibration using PIT
Jan  4 13:39:13 cfhat12 kernel: [    0.000000] Detected 3415.228 MHz processor.
Jan  4 13:39:13 cfhat12 kernel: [    0.008006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6830.44 BogoMIPS (lpj=13660896)
Jan  4 13:39:13 cfhat12 kernel: [    0.008009] pid_max: default: 32768 minimum: 301
Jan  4 13:39:13 cfhat12 kernel: [    0.008039] Security Framework initialized
Jan  4 13:39:13 cfhat12 kernel: [    0.008042] SELinux:  Initializing.
Jan  4 13:39:13 cfhat12 kernel: [    0.008050] SELinux:  Starting in permissive mode
Jan  4 13:39:13 cfhat12 kernel: [    0.008062] Mount-cache hash table entries: 256
Jan  4 13:39:13 cfhat12 kernel: [    0.008141] Initializing cgroup subsys ns
Jan  4 13:39:13 cfhat12 kernel: [    0.008144] Initializing cgroup subsys cpuacct
Jan  4 13:39:13 cfhat12 kernel: [    0.008148] Initializing cgroup subsys devices
Jan  4 13:39:13 cfhat12 kernel: [    0.008163] tseg: 00cff00000
Jan  4 13:39:13 cfhat12 kernel: [    0.008165] CPU: Physical Processor ID: 0
Jan  4 13:39:13 cfhat12 kernel: [    0.008166] CPU: Processor Core ID: 0
Jan  4 13:39:13 cfhat12 kernel: [    0.008167] mce: CPU supports 6 MCE banks
Jan  4 13:39:13 cfhat12 kernel: [    0.008173] using C1E aware idle routine
Jan  4 13:39:13 cfhat12 kernel: [    0.008174] Performance Events: AMD PMU driver.
Jan  4 13:39:13 cfhat12 kernel: [    0.008178] ... version:                0
Jan  4 13:39:13 cfhat12 kernel: [    0.008179] ... bit width:              48
Jan  4 13:39:13 cfhat12 kernel: [    0.008180] ... generic registers:      4
Jan  4 13:39:13 cfhat12 kernel: [    0.008181] ... value mask:             0000ffffffffffff
Jan  4 13:39:13 cfhat12 kernel: [    0.008183] ... max period:             00007fffffffffff
Jan  4 13:39:13 cfhat12 kernel: [    0.008184] ... fixed-purpose events:   0
Jan  4 13:39:13 cfhat12 kernel: [    0.008185] ... event mask:             000000000000000f
Jan  4 13:39:13 cfhat12 kernel: [    0.008234] ACPI: Core revision 20100428
Jan  4 13:39:13 cfhat12 kernel: [    0.016057] Setting APIC routing to flat
Jan  4 13:39:13 cfhat12 kernel: [    0.016446] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan  4 13:39:13 cfhat12 kernel: [    0.020000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jan  4 13:39:13 cfhat12 kernel: [    0.020000] ...trying to set up timer (IRQ0) through the 8259A ...
Jan  4 13:39:13 cfhat12 kernel: [    0.020000] ..... (found apic 0 pin 2) ...
Jan  4 13:39:13 cfhat12 kernel: [    0.060754] ....... works.
Jan  4 13:39:13 cfhat12 kernel: [    0.060755] CPU0: AMD Phenom(tm) II X4 965 Processor stepping 03
Jan  4 13:39:13 cfhat12 kernel: [    0.064000] Booting Node   0, Processors  #1
Jan  4 13:39:13 cfhat12 kernel: [    0.152005] System has AMD C1E enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.152005] Switch to broadcast mode on CPU1
Jan  4 13:39:13 cfhat12 kernel: [    0.152052]  #2
Jan  4 13:39:13 cfhat12 kernel: [    0.244011] Switch to broadcast mode on CPU2
Jan  4 13:39:13 cfhat12 kernel: [    0.244097]  #3
Jan  4 13:39:13 cfhat12 kernel: [    0.336013] Switch to broadcast mode on CPU3
Jan  4 13:39:13 cfhat12 kernel: [    0.336019] Brought up 4 CPUs
Jan  4 13:39:13 cfhat12 kernel: [    0.336022] Total of 4 processors activated (27322.64 BogoMIPS).
Jan  4 13:39:13 cfhat12 kernel: [    0.337650] Switch to broadcast mode on CPU0
Jan  4 13:39:13 cfhat12 kernel: [    0.337790] devtmpfs: initialized
Jan  4 13:39:13 cfhat12 kernel: [    0.338074] NET: Registered protocol family 16
Jan  4 13:39:13 cfhat12 kernel: [    0.338342] node 0 link 0: io port [8000, ffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338345] TOM: 00000000d0000000 aka 3328M
Jan  4 13:39:13 cfhat12 kernel: [    0.338346] Fam 10h mmconf [e0000000, e00fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338348] node 0 link 0: mmio [a0000, bffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338350] node 0 link 0: mmio [d0000000, dfffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338353] node 0 link 0: mmio [f0000000, fe02ffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338355] node 0 link 0: mmio [e0000000, e08fffff] ==> [e0100000, e08fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338357] TOM2: 0000000230000000 aka 8960M
Jan  4 13:39:13 cfhat12 kernel: [    0.338359] bus: [00, 08] on node 0 link 0
Jan  4 13:39:13 cfhat12 kernel: [    0.338361] bus: 00 index 0 [io  0x0000-0xffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338363] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338365] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338366] bus: 00 index 3 [mem 0xe0900000-0xffffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338368] bus: 00 index 4 [mem 0xe0100000-0xe08fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338369] bus: 00 index 5 [mem 0x230000000-0xfcffffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.338377] ACPI: bus type pci registered
Jan  4 13:39:13 cfhat12 kernel: [    0.338439] PCI: Using configuration type 1 for base access
Jan  4 13:39:13 cfhat12 kernel: [    0.338440] PCI: Using configuration type 1 for extended access
Jan  4 13:39:13 cfhat12 kernel: [    0.342228] bio: create slab <bio-0> at 0
Jan  4 13:39:13 cfhat12 kernel: [    0.342915] ACPI: EC: Look up EC in DSDT
Jan  4 13:39:13 cfhat12 kernel: [    0.348432] ACPI: Interpreter enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.348435] ACPI: (supports S0 S5)
Jan  4 13:39:13 cfhat12 kernel: [    0.348445] ACPI: Using IOAPIC for interrupt routing
Jan  4 13:39:13 cfhat12 kernel: [    0.354453] ACPI Warning: Incorrect checksum in table [TAMG] - 0x8F, should be 0x8E (20100428/tbutils-314)
Jan  4 13:39:13 cfhat12 kernel: [    0.354530] ACPI: No dock devices found.
Jan  4 13:39:13 cfhat12 kernel: [    0.354533] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan  4 13:39:13 cfhat12 kernel: [    0.354621] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jan  4 13:39:13 cfhat12 kernel: [    0.354803] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
Jan  4 13:39:13 cfhat12 kernel: [    0.354805] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.354807] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.354809] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.354811] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xfebfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.354830] pci 0000:00:00.0: reg 1c: [mem 0xe0000000-0xffffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.354897] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.354899] pci 0000:00:07.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.354926] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.354928] pci 0000:00:09.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.354954] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.354956] pci 0000:00:0a.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.354988] pci 0000:00:11.0: reg 10: [io  0xff00-0xff07]
Jan  4 13:39:13 cfhat12 kernel: [    0.354993] pci 0000:00:11.0: reg 14: [io  0xfe00-0xfe03]
Jan  4 13:39:13 cfhat12 kernel: [    0.354997] pci 0000:00:11.0: reg 18: [io  0xfd00-0xfd07]
Jan  4 13:39:13 cfhat12 kernel: [    0.355002] pci 0000:00:11.0: reg 1c: [io  0xfc00-0xfc03]
Jan  4 13:39:13 cfhat12 kernel: [    0.355007] pci 0000:00:11.0: reg 20: [io  0xfb00-0xfb0f]
Jan  4 13:39:13 cfhat12 kernel: [    0.355011] pci 0000:00:11.0: reg 24: [mem 0xfe02f000-0xfe02f3ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355024] pci 0000:00:11.0: set SATA to AHCI mode
Jan  4 13:39:13 cfhat12 kernel: [    0.355062] pci 0000:00:12.0: reg 10: [mem 0xfe02e000-0xfe02efff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355107] pci 0000:00:12.2: reg 10: [mem 0xfe02d000-0xfe02d0ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355143] pci 0000:00:12.2: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355144] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:39:13 cfhat12 kernel: [    0.355147] pci 0000:00:12.2: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.355168] pci 0000:00:13.0: reg 10: [mem 0xfe02c000-0xfe02cfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355213] pci 0000:00:13.2: reg 10: [mem 0xfe02b000-0xfe02b0ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355249] pci 0000:00:13.2: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355250] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:39:13 cfhat12 kernel: [    0.355253] pci 0000:00:13.2: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.355307] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
Jan  4 13:39:13 cfhat12 kernel: [    0.355311] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
Jan  4 13:39:13 cfhat12 kernel: [    0.355316] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
Jan  4 13:39:13 cfhat12 kernel: [    0.355321] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
Jan  4 13:39:13 cfhat12 kernel: [    0.355325] pci 0000:00:14.1: reg 20: [io  0xfa00-0xfa0f]
Jan  4 13:39:13 cfhat12 kernel: [    0.355404] pci 0000:00:14.5: reg 10: [mem 0xfe02a000-0xfe02afff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355470] pci 0000:00:15.0: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355518] pci 0000:00:15.1: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355543] pci 0000:00:16.0: reg 10: [mem 0xfe029000-0xfe029fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355588] pci 0000:00:16.2: reg 10: [mem 0xfe028000-0xfe0280ff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355623] pci 0000:00:16.2: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355624] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
Jan  4 13:39:13 cfhat12 kernel: [    0.355627] pci 0000:00:16.2: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.355712] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.355715] pci 0000:01:05.0: reg 14: [io  0xce00-0xceff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355717] pci 0000:01:05.0: reg 18: [mem 0xfd3e0000-0xfd3effff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355723] pci 0000:01:05.0: reg 24: [mem 0xfd200000-0xfd2fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355732] pci 0000:01:05.0: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355744] pci 0000:01:05.1: reg 10: [mem 0xfd3fc000-0xfd3fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355759] pci 0000:01:05.1: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.355786] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  4 13:39:13 cfhat12 kernel: [    0.355789] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355791] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355794] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.355845] pci 0000:02:00.0: reg 10: [mem 0xfdfc0000-0xfdfdffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355853] pci 0000:02:00.0: reg 14: [mem 0xfdf00000-0xfdf7ffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355861] pci 0000:02:00.0: reg 18: [io  0xbf00-0xbf1f]
Jan  4 13:39:13 cfhat12 kernel: [    0.355870] pci 0000:02:00.0: reg 1c: [mem 0xfdffc000-0xfdffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355892] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.355933] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.355938] pci 0000:02:00.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.355960] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  4 13:39:13 cfhat12 kernel: [    0.355963] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355965] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.355968] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356020] pci 0000:03:00.0: reg 10: [mem 0xfddfe000-0xfddfffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.356060] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.356063] pci 0000:03:00.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.356075] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  4 13:39:13 cfhat12 kernel: [    0.356078] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356080] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356083] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356121] pci 0000:04:00.0: reg 10: [io  0xde00-0xdeff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356134] pci 0000:04:00.0: reg 18: [mem 0xfd4ff000-0xfd4fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356143] pci 0000:04:00.0: reg 20: [mem 0xfd4f8000-0xfd4fbfff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356148] pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356174] pci 0000:04:00.0: supports D1 D2
Jan  4 13:39:13 cfhat12 kernel: [    0.356175] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Jan  4 13:39:13 cfhat12 kernel: [    0.356179] pci 0000:04:00.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.356194] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  4 13:39:13 cfhat12 kernel: [    0.356197] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356199] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356202] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356233] pci 0000:05:06.0: reg 10: [io  0xaf00-0xaf07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356239] pci 0000:05:06.0: reg 14: [io  0xae00-0xae07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356246] pci 0000:05:06.0: reg 18: [io  0xad00-0xad07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356252] pci 0000:05:06.0: reg 1c: [io  0xac00-0xac07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356293] pci 0000:05:06.1: reg 10: [io  0xab00-0xab07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356299] pci 0000:05:06.1: reg 14: [io  0xaa00-0xaa07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356306] pci 0000:05:06.1: reg 18: [io  0xa900-0xa907]
Jan  4 13:39:13 cfhat12 kernel: [    0.356312] pci 0000:05:06.1: reg 1c: [io  0xa800-0xa807]
Jan  4 13:39:13 cfhat12 kernel: [    0.356357] pci 0000:05:08.0: reg 10: [io  0xa700-0xa707]
Jan  4 13:39:13 cfhat12 kernel: [    0.356420] pci 0000:00:14.4: PCI bridge to [bus 05-05] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356423] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356426] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356429] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356431] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356433] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356435] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356437] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356439] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff] (subtractive decode)
Jan  4 13:39:13 cfhat12 kernel: [    0.356539] pci 0000:06:00.0: reg 24: [mem 0xfd8fe000-0xfd8fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356573] pci 0000:06:00.0: PME# supported from D3hot
Jan  4 13:39:13 cfhat12 kernel: [    0.356578] pci 0000:06:00.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.356617] pci 0000:06:00.1: reg 10: [io  0x9f00-0x9f07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356625] pci 0000:06:00.1: reg 14: [io  0x9e00-0x9e03]
Jan  4 13:39:13 cfhat12 kernel: [    0.356632] pci 0000:06:00.1: reg 18: [io  0x9d00-0x9d07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356640] pci 0000:06:00.1: reg 1c: [io  0x9c00-0x9c03]
Jan  4 13:39:13 cfhat12 kernel: [    0.356647] pci 0000:06:00.1: reg 20: [io  0x9b00-0x9b0f]
Jan  4 13:39:13 cfhat12 kernel: [    0.356700] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  4 13:39:13 cfhat12 kernel: [    0.356704] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356706] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356711] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356852] pci 0000:07:00.0: supports D1
Jan  4 13:39:13 cfhat12 kernel: [    0.356854] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
Jan  4 13:39:13 cfhat12 kernel: [    0.356859] pci 0000:07:00.0: PME# disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.356879] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  4 13:39:13 cfhat12 kernel: [    0.356883] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356885] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.356890] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.356988] pci 0000:08:00.0: reg 10: [io  0x8f00-0x8f07]
Jan  4 13:39:13 cfhat12 kernel: [    0.356999] pci 0000:08:00.0: reg 14: [io  0x8e00-0x8e07]
Jan  4 13:39:13 cfhat12 kernel: [    0.357009] pci 0000:08:00.0: reg 18: [io  0x8d00-0x8d07]
Jan  4 13:39:13 cfhat12 kernel: [    0.357019] pci 0000:08:00.0: reg 1c: [io  0x8c00-0x8c07]
Jan  4 13:39:13 cfhat12 kernel: [    0.357029] pci 0000:08:00.0: reg 20: [io  0x8b00-0x8b07]
Jan  4 13:39:13 cfhat12 kernel: [    0.357040] pci 0000:08:00.0: reg 24: [io  0x8a00-0x8a0f]
Jan  4 13:39:13 cfhat12 kernel: [    0.357127] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  4 13:39:13 cfhat12 kernel: [    0.357132] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.357138] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.357143] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.357169] pci_bus 0000:00: on NUMA node 0
Jan  4 13:39:13 cfhat12 kernel: [    0.357172] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357397] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357434] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357477] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357558] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357594] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE9._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357629] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCEA._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.357668] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Jan  4 13:39:13 cfhat12 kernel: [    0.375123] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375191] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375257] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375324] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375390] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375456] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375524] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375589] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
Jan  4 13:39:13 cfhat12 kernel: [    0.375767] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Jan  4 13:39:13 cfhat12 kernel: [    0.375772] vgaarb: loaded
Jan  4 13:39:13 cfhat12 kernel: [    0.375909] SCSI subsystem initialized
Jan  4 13:39:13 cfhat12 kernel: [    0.376013] libata version 3.00 loaded.
Jan  4 13:39:13 cfhat12 kernel: [    0.376131] usbcore: registered new interface driver usbfs
Jan  4 13:39:13 cfhat12 kernel: [    0.376159] usbcore: registered new interface driver hub
Jan  4 13:39:13 cfhat12 kernel: [    0.376194] usbcore: registered new device driver usb
Jan  4 13:39:13 cfhat12 kernel: [    0.376390] Advanced Linux Sound Architecture Driver Version 1.0.23.
Jan  4 13:39:13 cfhat12 kernel: [    0.376392] PCI: Using ACPI for IRQ routing
Jan  4 13:39:13 cfhat12 kernel: [    0.376394] PCI: pci_cache_line_size set to 64 bytes
Jan  4 13:39:13 cfhat12 kernel: [    0.376401] pci 0000:00:00.0: no compatible bridge window for [mem 0xe0000000-0xffffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.376484] reserve RAM buffer: 000000000009f800 - 000000000009ffff 
Jan  4 13:39:13 cfhat12 kernel: [    0.376486] reserve RAM buffer: 00000000cfdf0000 - 00000000cfffffff 
Jan  4 13:39:13 cfhat12 kernel: [    0.376589] NetLabel: Initializing
Jan  4 13:39:13 cfhat12 kernel: [    0.376590] NetLabel:  domain hash size = 128
Jan  4 13:39:13 cfhat12 kernel: [    0.376591] NetLabel:  protocols = UNLABELED CIPSOv4
Jan  4 13:39:13 cfhat12 kernel: [    0.376600] NetLabel:  unlabeled traffic allowed by default
Jan  4 13:39:13 cfhat12 kernel: [    0.376624] Switching to clocksource tsc
Jan  4 13:39:13 cfhat12 kernel: [    0.378629] pnp: PnP ACPI init
Jan  4 13:39:13 cfhat12 kernel: [    0.378636] ACPI: bus type pnp registered
Jan  4 13:39:13 cfhat12 kernel: [    0.379208] pnp 00:02: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379232] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:02:00.0 BAR 6 [mem 0x00000000-0x0003ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.379237] pnp 00:02: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:04:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.379831] pnp 00:0a: disabling [mem 0x000d1000-0x000d3fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379835] pnp 00:0a: disabling [mem 0x000f0000-0x000f7fff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379838] pnp 00:0a: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379840] pnp 00:0a: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379843] pnp 00:0a: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379846] pnp 00:0a: disabling [mem 0x00100000-0xcfdeffff] because it overlaps 0000:00:00.0 BAR 3 [mem 0x00000000-0x1fffffff 64bit]
Jan  4 13:39:13 cfhat12 kernel: [    0.379935] pnp: PnP ACPI: found 11 devices
Jan  4 13:39:13 cfhat12 kernel: [    0.379936] ACPI: ACPI bus type pnp unregistered
Jan  4 13:39:13 cfhat12 kernel: [    0.379942] system 00:01: [io  0x04d0-0x04d1] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379944] system 00:01: [io  0x0220-0x0225] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379948] system 00:01: [io  0x0290-0x0294] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379951] system 00:02: [io  0x4100-0x411f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379953] system 00:02: [io  0x0228-0x022f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379955] system 00:02: [io  0x040b] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379957] system 00:02: [io  0x04d6] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379958] system 00:02: [io  0x0c00-0x0c01] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379960] system 00:02: [io  0x0c14] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379962] system 00:02: [io  0x0c50-0x0c52] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379964] system 00:02: [io  0x0c6c-0x0c6d] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379966] system 00:02: [io  0x0c6f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379967] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379969] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379971] system 00:02: [io  0x0cd4-0x0cdf] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379973] system 00:02: [io  0x4000-0x40fe] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379975] system 00:02: [io  0x4210-0x4217] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379977] system 00:02: [io  0x0b00-0x0b0f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379978] system 00:02: [io  0x0b10-0x0b1f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379980] system 00:02: [io  0x0b20-0x0b3f] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379983] system 00:02: [mem 0xfee00400-0xfee00fff window] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379987] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379990] system 00:0a: [mem 0xcfdf0000-0xcfdfffff] could not be reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379992] system 00:0a: [mem 0xffff0000-0xffffffff] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379994] system 00:0a: [mem 0xcfe00000-0xcfefffff] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379996] system 00:0a: [mem 0xcff00000-0xcfffffff] could not be reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.379999] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.380001] system 00:0a: [mem 0xfee00000-0xfee00fff] could not be reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.380003] system 00:0a: [mem 0xfff80000-0xfffeffff] has been reserved
Jan  4 13:39:13 cfhat12 kernel: [    0.386719] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jan  4 13:39:13 cfhat12 kernel: [    0.386721] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386724] pci 0000:00:01.0:   bridge window [mem 0xfd200000-0xfd3fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386726] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386731] pci 0000:02:00.0: BAR 6: assigned [mem 0xfde00000-0xfde3ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386733] pci 0000:00:07.0: PCI bridge to [bus 02-02]
Jan  4 13:39:13 cfhat12 kernel: [    0.386735] pci 0000:00:07.0:   bridge window [io  0xb000-0xbfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386737] pci 0000:00:07.0:   bridge window [mem 0xfdf00000-0xfdffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386739] pci 0000:00:07.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386743] pci 0000:00:09.0: PCI bridge to [bus 03-03]
Jan  4 13:39:13 cfhat12 kernel: [    0.386744] pci 0000:00:09.0:   bridge window [io  0xe000-0xefff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386747] pci 0000:00:09.0:   bridge window [mem 0xfdd00000-0xfddfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386749] pci 0000:00:09.0:   bridge window [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386753] pci 0000:04:00.0: BAR 6: assigned [mem 0xfd400000-0xfd41ffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386754] pci 0000:00:0a.0: PCI bridge to [bus 04-04]
Jan  4 13:39:13 cfhat12 kernel: [    0.386756] pci 0000:00:0a.0:   bridge window [io  0xd000-0xdfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386759] pci 0000:00:0a.0:   bridge window [mem 0xfd900000-0xfd9fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386761] pci 0000:00:0a.0:   bridge window [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386764] pci 0000:00:14.4: PCI bridge to [bus 05-05]
Jan  4 13:39:13 cfhat12 kernel: [    0.386767] pci 0000:00:14.4:   bridge window [io  0xa000-0xafff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386771] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386774] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386779] pci 0000:00:15.0: PCI bridge to [bus 06-06]
Jan  4 13:39:13 cfhat12 kernel: [    0.386781] pci 0000:00:15.0:   bridge window [io  0x9000-0x9fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386784] pci 0000:00:15.0:   bridge window [mem 0xfd800000-0xfd8fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386787] pci 0000:00:15.0:   bridge window [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386792] pci 0000:07:00.0: PCI bridge to [bus 08-08]
Jan  4 13:39:13 cfhat12 kernel: [    0.386795] pci 0000:07:00.0:   bridge window [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386803] pci 0000:07:00.0:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386808] pci 0000:07:00.0:   bridge window [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386818] pci 0000:00:15.1: PCI bridge to [bus 07-08]
Jan  4 13:39:13 cfhat12 kernel: [    0.386820] pci 0000:00:15.1:   bridge window [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386823] pci 0000:00:15.1:   bridge window [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386826] pci 0000:00:15.1:   bridge window [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386841] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:39:13 cfhat12 kernel: [    0.386843] pci 0000:00:07.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386851] pci 0000:00:09.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.386853] pci 0000:00:09.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386860] pci 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    0.386863] pci 0000:00:0a.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386871] pci 0000:00:15.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.386874] pci 0000:00:15.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386879] pci 0000:00:15.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.386882] pci 0000:00:15.1: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386892] pci 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.386898] pci 0000:07:00.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.386902] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Jan  4 13:39:13 cfhat12 kernel: [    0.386903] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386905] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386907] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386908] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386910] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386912] pci_bus 0000:01: resource 1 [mem 0xfd200000-0xfd3fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386913] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386915] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386917] pci_bus 0000:02: resource 1 [mem 0xfdf00000-0xfdffffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386919] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386920] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386922] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfddfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386924] pci_bus 0000:03: resource 2 [mem 0xfdc00000-0xfdcfffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386926] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386927] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386929] pci_bus 0000:04: resource 2 [mem 0xfd400000-0xfd4fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386931] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386932] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386934] pci_bus 0000:05: resource 2 [mem 0xfda00000-0xfdafffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386936] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
Jan  4 13:39:13 cfhat12 kernel: [    0.386937] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386939] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386941] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386942] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xfebfffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386944] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386946] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386947] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386949] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386951] pci_bus 0000:07: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386952] pci_bus 0000:07: resource 2 [mem 0xfd500000-0xfd5fffff 64bit pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.386954] pci_bus 0000:08: resource 0 [io  0x8000-0x8fff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386956] pci_bus 0000:08: resource 1 [mem 0xfd600000-0xfd6fffff]
Jan  4 13:39:13 cfhat12 kernel: [    0.386957] pci_bus 0000:08: resource 2 [mem 0xfd500000-0xfd5fffff pref]
Jan  4 13:39:13 cfhat12 kernel: [    0.387008] NET: Registered protocol family 2
Jan  4 13:39:13 cfhat12 kernel: [    0.387051] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.387545] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.388523] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.388767] TCP: Hash tables configured (established 262144 bind 65536)
Jan  4 13:39:13 cfhat12 kernel: [    0.388769] TCP reno registered
Jan  4 13:39:13 cfhat12 kernel: [    0.388772] UDP hash table entries: 4096 (order: 5, 131072 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.388806] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.388948] NET: Registered protocol family 1
Jan  4 13:39:13 cfhat12 kernel: [    0.389064] RPC: Registered udp transport module.
Jan  4 13:39:13 cfhat12 kernel: [    0.389065] RPC: Registered tcp transport module.
Jan  4 13:39:13 cfhat12 kernel: [    0.389066] RPC: Registered tcp NFSv4.1 backchannel transport module.
Jan  4 13:39:13 cfhat12 kernel: [    0.389074] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Jan  4 13:39:13 cfhat12 kernel: [    0.451443] pci 0000:01:05.0: Boot video device
Jan  4 13:39:13 cfhat12 kernel: [    0.451480] PCI: CLS 4 bytes, default 64
Jan  4 13:39:13 cfhat12 kernel: [    0.451524] Trying to unpack rootfs image as initramfs...
Jan  4 13:39:13 cfhat12 kernel: [    0.499239] Freeing initrd memory: 3372k freed
Jan  4 13:39:13 cfhat12 kernel: [    0.499915] PCI-DMA: Disabling AGP.
Jan  4 13:39:13 cfhat12 kernel: [    0.500072] PCI-DMA: aperture base @ 20000000 size 65536 KB
Jan  4 13:39:13 cfhat12 kernel: [    0.500073] PCI-DMA: using GART IOMMU.
Jan  4 13:39:13 cfhat12 kernel: [    0.500076] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Jan  4 13:39:13 cfhat12 kernel: [    0.504221] audit: initializing netlink socket (disabled)
Jan  4 13:39:13 cfhat12 kernel: [    0.504231] type=2000 audit(1294166343.500:1): initialized
Jan  4 13:39:13 cfhat12 kernel: [    0.504263] I-pipe: Domain Xenomai registered.
Jan  4 13:39:13 cfhat12 kernel: [    0.504331] Xenomai: hal/x86_64 started.
Jan  4 13:39:13 cfhat12 kernel: [    0.504341] Xenomai: scheduling class idle registered.
Jan  4 13:39:13 cfhat12 kernel: [    0.504343] Xenomai: scheduling class rt registered.
Jan  4 13:39:13 cfhat12 kernel: [    0.505467] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
Jan  4 13:39:13 cfhat12 kernel: [    0.703415] Xenomai: native skin init failed, code -19.
Jan  4 13:39:13 cfhat12 kernel: [    0.703774] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jan  4 13:39:13 cfhat12 kernel: [    0.703927] VFS: Disk quotas dquot_6.5.2
Jan  4 13:39:13 cfhat12 kernel: [    0.703947] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  4 13:39:13 cfhat12 kernel: [    0.704114] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, debug enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.704370] SGI XFS Quota Management subsystem
Jan  4 13:39:13 cfhat12 kernel: [    0.704375] msgmni has been set to 14971
Jan  4 13:39:13 cfhat12 kernel: [    0.704402] SELinux:  Registering netfilter hooks
Jan  4 13:39:13 cfhat12 kernel: [    0.704652] alg: No test for stdrng (krng)
Jan  4 13:39:13 cfhat12 kernel: [    0.704722] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jan  4 13:39:13 cfhat12 kernel: [    0.704725] io scheduler noop registered
Jan  4 13:39:13 cfhat12 kernel: [    0.704726] io scheduler deadline registered
Jan  4 13:39:13 cfhat12 kernel: [    0.704738] io scheduler cfq registered (default)
Jan  4 13:39:13 cfhat12 kernel: [    0.704833] pcieport 0000:00:07.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.704853] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.704927] pcieport 0000:00:09.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.704943] pcieport 0000:00:09.0: irq 41 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.705012] pcieport 0000:00:0a.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.705028] pcieport 0000:00:0a.0: irq 42 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.705099] pcieport 0000:00:15.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.705129] pcieport 0000:00:15.0: irq 43 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.705212] pcieport 0000:00:15.1: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.705242] pcieport 0000:00:15.1: irq 44 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.705727] Non-volatile memory driver v1.3
Jan  4 13:39:13 cfhat12 kernel: [    0.705730] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.959556] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:39:13 cfhat12 kernel: [    0.959908] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 13:39:13 cfhat12 kernel: [    0.960007] serial 0000:05:06.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:39:13 cfhat12 kernel: [    0.960093] 0000:05:06.0: ttyS1 at I/O 0xaf00 (irq = 20) is a 16550A
Jan  4 13:39:13 cfhat12 kernel: [    0.960205] 0000:05:06.0: ttyS2 at I/O 0xae00 (irq = 20) is a 16550A
Jan  4 13:39:13 cfhat12 kernel: [    0.960318] 0000:05:06.0: ttyS3 at I/O 0xad00 (irq = 20) is a 16550A
Jan  4 13:39:13 cfhat12 kernel: [    0.960351] Couldn't register serial port 0000:05:06.0: -28
Jan  4 13:39:13 cfhat12 kernel: [    0.960358] serial 0000:05:06.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Jan  4 13:39:13 cfhat12 kernel: [    0.960360] Couldn't register serial port 0000:05:06.1: -28
Jan  4 13:39:13 cfhat12 kernel: [    0.961502] brd: module loaded
Jan  4 13:39:13 cfhat12 kernel: [    0.961665] ahci 0000:00:11.0: version 3.0
Jan  4 13:39:13 cfhat12 kernel: [    0.961670] ahci 0000:00:11.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:39:13 cfhat12 kernel: [    0.961706] ahci 0000:00:11.0: irq 45 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    0.961768] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
Jan  4 13:39:13 cfhat12 kernel: [    0.961770] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Jan  4 13:39:13 cfhat12 kernel: [    0.961937] scsi0 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.962007] scsi1 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.962055] scsi2 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.962102] scsi3 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.962193] ata1: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f100 irq 45
Jan  4 13:39:13 cfhat12 kernel: [    0.962196] ata2: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f180 irq 45
Jan  4 13:39:13 cfhat12 kernel: [    0.962198] ata3: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f200 irq 45
Jan  4 13:39:13 cfhat12 kernel: [    0.962201] ata4: SATA max UDMA/133 abar m1024@domain.hid port 0xfe02f280 irq 45
Jan  4 13:39:13 cfhat12 kernel: [    0.962227] ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.975433] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Jan  4 13:39:13 cfhat12 kernel: [    0.975436] ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jan  4 13:39:13 cfhat12 kernel: [    0.975441] ahci 0000:06:00.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.975559] scsi4 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.975647] scsi5 : ahci
Jan  4 13:39:13 cfhat12 kernel: [    0.975684] ata5: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe100 irq 17
Jan  4 13:39:13 cfhat12 kernel: [    0.975687] ata6: SATA max UDMA/133 abar m8192@domain.hid port 0xfd8fe180 irq 17
Jan  4 13:39:13 cfhat12 kernel: [    0.975898] pata_atiixp 0000:00:14.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.975967] scsi6 : pata_atiixp
Jan  4 13:39:13 cfhat12 kernel: [    0.976040] scsi7 : pata_atiixp
Jan  4 13:39:13 cfhat12 kernel: [    0.976796] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14
Jan  4 13:39:13 cfhat12 kernel: [    0.976798] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15
Jan  4 13:39:13 cfhat12 kernel: [    0.976899] pata_jmicron 0000:06:00.1: enabling device (0000 -> 0001)
Jan  4 13:39:13 cfhat12 kernel: [    0.976905] pata_jmicron 0000:06:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.976929] pata_jmicron 0000:06:00.1: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    0.976972] scsi8 : pata_jmicron
Jan  4 13:39:13 cfhat12 kernel: [    0.977041] scsi9 : pata_jmicron
Jan  4 13:39:13 cfhat12 kernel: [    0.977083] ata9: PATA max UDMA/100 cmd 0x9f00 ctl 0x9e00 bmdma 0x9b00 irq 17
Jan  4 13:39:13 cfhat12 kernel: [    0.977085] ata10: PATA max UDMA/100 cmd 0x9d00 ctl 0x9c00 bmdma 0x9b08 irq 17
Jan  4 13:39:13 cfhat12 kernel: [    0.977207] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Jan  4 13:39:13 cfhat12 kernel: [    0.977208] e100: Copyright(c) 1999-2006 Intel Corporation
Jan  4 13:39:13 cfhat12 kernel: [    0.977294] console [netcon0] enabled
Jan  4 13:39:13 cfhat12 kernel: [    0.977295] netconsole: network logging started
Jan  4 13:39:13 cfhat12 kernel: [    0.977305] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan  4 13:39:13 cfhat12 kernel: [    0.977316] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.977327] ehci_hcd 0000:00:12.2: EHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    0.977343] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
Jan  4 13:39:13 cfhat12 kernel: [    0.977364] ehci_hcd 0000:00:12.2: debug port 1
Jan  4 13:39:13 cfhat12 kernel: [    0.977373] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe02d000
Jan  4 13:39:13 cfhat12 kernel: [    0.987413] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
Jan  4 13:39:13 cfhat12 kernel: [    0.987542] hub 1-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    0.987545] hub 1-0:1.0: 5 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    0.987583] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.987593] ehci_hcd 0000:00:13.2: EHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    0.987599] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
Jan  4 13:39:13 cfhat12 kernel: [    0.987621] ehci_hcd 0000:00:13.2: debug port 1
Jan  4 13:39:13 cfhat12 kernel: [    0.987631] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe02b000
Jan  4 13:39:13 cfhat12 kernel: [    0.999411] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
Jan  4 13:39:13 cfhat12 kernel: [    0.999532] hub 2-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    0.999535] hub 2-0:1.0: 5 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    0.999571] ehci_hcd 0000:00:16.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    0.999581] ehci_hcd 0000:00:16.2: EHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    0.999587] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
Jan  4 13:39:13 cfhat12 kernel: [    0.999608] ehci_hcd 0000:00:16.2: debug port 1
Jan  4 13:39:13 cfhat12 kernel: [    0.999617] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe028000
Jan  4 13:39:13 cfhat12 kernel: [    1.011414] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
Jan  4 13:39:13 cfhat12 kernel: [    1.011532] hub 3-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.011535] hub 3-0:1.0: 4 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.011588] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan  4 13:39:13 cfhat12 kernel: [    1.011598] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    1.011611] ohci_hcd 0000:00:12.0: OHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    1.011616] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
Jan  4 13:39:13 cfhat12 kernel: [    1.011639] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe02e000
Jan  4 13:39:13 cfhat12 kernel: [    1.071514] hub 4-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.071519] hub 4-0:1.0: 5 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.071553] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    1.071564] ohci_hcd 0000:00:13.0: OHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    1.071569] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
Jan  4 13:39:13 cfhat12 kernel: [    1.071582] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02c000
Jan  4 13:39:13 cfhat12 kernel: [    1.139461] hub 5-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.139467] hub 5-0:1.0: 5 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.139506] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    1.139518] ohci_hcd 0000:00:14.5: OHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    1.139523] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 6
Jan  4 13:39:13 cfhat12 kernel: [    1.139536] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe02a000
Jan  4 13:39:13 cfhat12 kernel: [    1.147674] ata7.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB03, max UDMA/100
Jan  4 13:39:13 cfhat12 kernel: [    1.147688] ata7.00: limited to UDMA/33 due to 40-wire cable
Jan  4 13:39:13 cfhat12 kernel: [    1.163674] ata7.00: configured for UDMA/33
Jan  4 13:39:13 cfhat12 kernel: [    1.199562] hub 6-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.199567] hub 6-0:1.0: 2 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.199597] ohci_hcd 0000:00:16.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    1.199608] ohci_hcd 0000:00:16.0: OHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    1.199613] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 7
Jan  4 13:39:13 cfhat12 kernel: [    1.199626] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe029000
Jan  4 13:39:13 cfhat12 kernel: [    1.263514] hub 7-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.263519] hub 7-0:1.0: 4 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.263574] uhci_hcd: USB Universal Host Controller Interface driver
Jan  4 13:39:13 cfhat12 kernel: [    1.263622] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    1.263633] xhci_hcd 0000:03:00.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    1.263636] xhci_hcd 0000:03:00.0: xHCI Host Controller
Jan  4 13:39:13 cfhat12 kernel: [    1.263641] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
Jan  4 13:39:13 cfhat12 kernel: [    1.263741] xhci_hcd 0000:03:00.0: irq 17, io mem 0xfddfe000
Jan  4 13:39:13 cfhat12 kernel: [    1.267104] usb usb8: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
Jan  4 13:39:13 cfhat12 kernel: [    1.267194] xHCI xhci_add_endpoint called for root hub
Jan  4 13:39:13 cfhat12 kernel: [    1.267196] xHCI xhci_check_bandwidth called for root hub
Jan  4 13:39:13 cfhat12 kernel: [    1.267231] hub 8-0:1.0: USB hub found
Jan  4 13:39:13 cfhat12 kernel: [    1.267234] hub 8-0:1.0: 4 ports detected
Jan  4 13:39:13 cfhat12 kernel: [    1.267334] usbcore: registered new interface driver usblp
Jan  4 13:39:13 cfhat12 kernel: [    1.267335] Initializing USB Mass Storage driver...
Jan  4 13:39:13 cfhat12 kernel: [    1.267402] usbcore: registered new interface driver usb-storage
Jan  4 13:39:13 cfhat12 kernel: [    1.267403] USB Mass Storage support registered.
Jan  4 13:39:13 cfhat12 kernel: [    1.267482] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jan  4 13:39:13 cfhat12 kernel: [    1.267484] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
Jan  4 13:39:13 cfhat12 kernel: [    1.267614] serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 13:39:13 cfhat12 kernel: [    1.267719] mice: PS/2 mouse device common for all mice
Jan  4 13:39:13 cfhat12 kernel: [    1.267766] rtc_cmos 00:04: RTC can wake from S4
Jan  4 13:39:13 cfhat12 kernel: [    1.267808] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jan  4 13:39:13 cfhat12 kernel: [    1.267827] rtc0: alarms up to one month, 242 bytes nvram
Jan  4 13:39:13 cfhat12 kernel: [    1.267852] md: linear personality registered for level -1
Jan  4 13:39:13 cfhat12 kernel: [    1.267853] md: raid0 personality registered for level 0
Jan  4 13:39:13 cfhat12 kernel: [    1.267855] md: raid1 personality registered for level 1
Jan  4 13:39:13 cfhat12 kernel: [    1.267856] md: raid10 personality registered for level 10
Jan  4 13:39:13 cfhat12 kernel: [    1.267886] device-mapper: uevent: version 1.0.3
Jan  4 13:39:13 cfhat12 kernel: [    1.267949] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@domain.hid
Jan  4 13:39:13 cfhat12 kernel: [    1.267958] cpuidle: using governor ladder
Jan  4 13:39:13 cfhat12 kernel: [    1.268853] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:39:13 cfhat12 kernel: [    1.268881] HDA Intel 0000:01:05.1: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    1.279445] ata3: SATA link down (SStatus 0 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.283922] ALSA device list:
Jan  4 13:39:13 cfhat12 kernel: [    1.283924]   #0: HDA ATI HDMI at 0xfd3fc000 irq 19
Jan  4 13:39:13 cfhat12 kernel: [    1.283947] Netfilter messages via NETLINK v0.30.
Jan  4 13:39:13 cfhat12 kernel: [    1.283957] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jan  4 13:39:13 cfhat12 kernel: [    1.284034] ctnetlink v0.93: registering with nfnetlink.
Jan  4 13:39:13 cfhat12 kernel: [    1.284274] ip_tables: (C) 2000-2006 Netfilter Core Team
Jan  4 13:39:13 cfhat12 kernel: [    1.284303] TCP bic registered
Jan  4 13:39:13 cfhat12 kernel: [    1.284305] TCP cubic registered
Jan  4 13:39:13 cfhat12 kernel: [    1.284307] NET: Registered protocol family 17
Jan  4 13:39:13 cfhat12 kernel: [    1.284422] registered taskstats version 1
Jan  4 13:39:13 cfhat12 kernel: [    1.291434] ata4: SATA link down (SStatus 0 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.295436] ata5: SATA link down (SStatus 0 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.303435] ata6: SATA link down (SStatus 0 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.324121] input: AT Translated Set 2 keyboard as /class/input/input0
Jan  4 13:39:13 cfhat12 kernel: [    1.451434] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.453002] ata1.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
Jan  4 13:39:13 cfhat12 kernel: [    1.453005] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Jan  4 13:39:13 cfhat12 kernel: [    1.454563] ata1.00: configured for UDMA/133
Jan  4 13:39:13 cfhat12 kernel: [    1.471514] scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  4 13:39:13 cfhat12 kernel: [    1.471670] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:39:13 cfhat12 kernel: [    1.471695] sd 0:0:0:0: [sda] Write Protect is off
Jan  4 13:39:13 cfhat12 kernel: [    1.471697] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jan  4 13:39:13 cfhat12 kernel: [    1.471708] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:39:13 cfhat12 kernel: [    1.471723] sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  4 13:39:13 cfhat12 kernel: [    1.471795]  sda:
Jan  4 13:39:13 cfhat12 kernel: [    1.475427] usb 5-1: new low speed USB device using ohci_hcd and address 2
Jan  4 13:39:13 cfhat12 kernel: [    1.480958]  sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Jan  4 13:39:13 cfhat12 kernel: [    1.506949] sd 0:0:0:0: [sda] Attached SCSI disk
Jan  4 13:39:13 cfhat12 kernel: [    1.507411] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 13:39:13 cfhat12 kernel: [    1.510199] ata2.00: ATA-6: ST3160023AS, 3.05, max UDMA/133
Jan  4 13:39:13 cfhat12 kernel: [    1.510201] ata2.00: 312581808 sectors, multi 16: LBA48 
Jan  4 13:39:13 cfhat12 kernel: [    1.513280] ata2.00: configured for UDMA/133
Jan  4 13:39:13 cfhat12 kernel: [    1.531478] scsi 1:0:0:0: Direct-Access     ATA      ST3160023AS      3.05 PQ: 0 ANSI: 5
Jan  4 13:39:13 cfhat12 kernel: [    1.531592] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Jan  4 13:39:13 cfhat12 kernel: [    1.531616] sd 1:0:0:0: [sdb] Write Protect is off
Jan  4 13:39:13 cfhat12 kernel: [    1.531618] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jan  4 13:39:13 cfhat12 kernel: [    1.531628] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 13:39:13 cfhat12 kernel: [    1.531645] sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan  4 13:39:13 cfhat12 kernel: [    1.531708]  sdb:
Jan  4 13:39:13 cfhat12 kernel: [    1.532471] scsi 6:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB03 PQ: 0 ANSI: 5
Jan  4 13:39:13 cfhat12 kernel: [    1.536616] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  4 13:39:13 cfhat12 kernel: [    1.536619] Uniform CD-ROM driver Revision: 3.20
Jan  4 13:39:13 cfhat12 kernel: [    1.536735] sr 6:0:0:0: Attached scsi CD-ROM sr0
Jan  4 13:39:13 cfhat12 kernel: [    1.536800] sr 6:0:0:0: Attached scsi generic sg2 type 5
Jan  4 13:39:13 cfhat12 kernel: [    1.542784]  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jan  4 13:39:13 cfhat12 kernel: [    1.572569] sd 1:0:0:0: [sdb] Attached SCSI disk
Jan  4 13:39:13 cfhat12 kernel: [    1.702884] Freeing unused kernel memory: 480k freed
Jan  4 13:39:13 cfhat12 kernel: [    1.712493] udev[804]: starting version 164
Jan  4 13:39:13 cfhat12 kernel: [    1.728115] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k4
Jan  4 13:39:13 cfhat12 kernel: [    1.728117] e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
Jan  4 13:39:13 cfhat12 kernel: [    1.728149] e1000e 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Jan  4 13:39:13 cfhat12 kernel: [    1.728164] e1000e 0000:02:00.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    1.728312] e1000e 0000:02:00.0: irq 46 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    1.728314] e1000e 0000:02:00.0: irq 47 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    1.728316] e1000e 0000:02:00.0: irq 48 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    1.728794] e1000e 0000:02:00.0: Disabling ASPM L0s 
Jan  4 13:39:13 cfhat12 kernel: [    1.733287] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan  4 13:39:13 cfhat12 kernel: [    1.733307] r8169 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Jan  4 13:39:13 cfhat12 kernel: [    1.733347] r8169 0000:04:00.0: setting latency timer to 64
Jan  4 13:39:13 cfhat12 kernel: [    1.733384] r8169 0000:04:00.0: irq 49 for MSI/MSI-X
Jan  4 13:39:13 cfhat12 kernel: [    1.733551] r8169 0000:04:00.0: eth0: RTL8168d/8111d at 0xffffc90000070000, 1c:6f:65:44:60:d1, XID 083000c0 IRQ 49
Jan  4 13:39:13 cfhat12 kernel: [    1.748466] usbcore: registered new interface driver hiddev
Jan  4 13:39:13 cfhat12 kernel: [    1.752560] input: USBPS2 as /class/input/input1
Jan  4 13:39:13 cfhat12 kernel: [    1.752571] generic-usb 0003:0D3D:0001.0001: input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:13.0-1/input0
Jan  4 13:39:13 cfhat12 kernel: [    1.759640] input: USBPS2 as /class/input/input2
Jan  4 13:39:13 cfhat12 kernel: [    1.759680] generic-usb 0003:0D3D:0001.0002: input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:13.0-1/input1
Jan  4 13:39:13 cfhat12 kernel: [    1.759691] usbcore: registered new interface driver usbhid
Jan  4 13:39:13 cfhat12 kernel: [    1.759693] usbhid: USB HID core driver
Jan  4 13:39:13 cfhat12 kernel: [    1.868517] e1000e 0000:02:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:1b:21:3d:40:c4
Jan  4 13:39:13 cfhat12 kernel: [    1.868519] e1000e 0000:02:00.0: eth1: Intel(R) PRO/1000 Network Connection
Jan  4 13:39:13 cfhat12 kernel: [    1.868531] e1000e 0000:02:00.0: eth1: MAC: 3, PHY: 8, PBA No: e46981-003
Jan  4 13:39:13 cfhat12 kernel: [    2.000798] md: md1 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    2.001635] md: bind<sdb1>
Jan  4 13:39:13 cfhat12 kernel: [    2.001843] md: bind<sda1>
Jan  4 13:39:13 cfhat12 kernel: [    2.002537] md/raid1:md1: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    2.002552] md1: detected capacity change from 0 to 254791680
Jan  4 13:39:13 cfhat12 kernel: [    2.003076]  md1: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    2.215887] md: md2 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    2.216813] md: bind<sdb2>
Jan  4 13:39:13 cfhat12 kernel: [    2.216950] md: bind<sda2>
Jan  4 13:39:13 cfhat12 kernel: [    2.217626] md/raid1:md2: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    2.217639] md2: detected capacity change from 0 to 19998367744
Jan  4 13:39:13 cfhat12 kernel: [    2.218144]  md2: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    2.431775] md: md3 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    2.432566] md: bind<sdb3>
Jan  4 13:39:13 cfhat12 kernel: [    2.432711] md: bind<sda3>
Jan  4 13:39:13 cfhat12 kernel: [    2.433383] md/raid1:md3: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    2.433396] md3: detected capacity change from 0 to 1998573568
Jan  4 13:39:13 cfhat12 kernel: [    2.433901]  md3: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    2.647881] md: md5 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    2.648581] md: bind<sdb5>
Jan  4 13:39:13 cfhat12 kernel: [    2.648698] md: bind<sda5>
Jan  4 13:39:13 cfhat12 kernel: [    2.649375] md/raid1:md5: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    2.649389] md5: detected capacity change from 0 to 19997319168
Jan  4 13:39:13 cfhat12 kernel: [    2.649897]  md5: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    2.869947] md: md6 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    2.870790] md: bind<sdb6>
Jan  4 13:39:13 cfhat12 kernel: [    2.870971] md: bind<sda6>
Jan  4 13:39:13 cfhat12 kernel: [    2.871654] md/raid1:md6: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    2.871665] md6: detected capacity change from 0 to 19997319168
Jan  4 13:39:13 cfhat12 kernel: [    2.872162]  md6: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    3.104357] md: md7 stopped.
Jan  4 13:39:13 cfhat12 kernel: [    3.105313] md: bind<sdb7>
Jan  4 13:39:13 cfhat12 kernel: [    3.105508] md: bind<sda7>
Jan  4 13:39:13 cfhat12 kernel: [    3.106186] md/raid1:md7: active with 2 out of 2 mirrors
Jan  4 13:39:13 cfhat12 kernel: [    3.106198] md7: detected capacity change from 0 to 97784881152
Jan  4 13:39:13 cfhat12 kernel: [    3.106710]  md7: unknown partition table
Jan  4 13:39:13 cfhat12 kernel: [    3.353495] XFS mounting filesystem md2
Jan  4 13:39:13 cfhat12 kernel: [    3.513859] Ending clean XFS mount for filesystem: md2
Jan  4 13:39:13 cfhat12 kernel: [    4.853296] udev[1069]: starting version 164
Jan  4 13:39:13 cfhat12 kernel: [    5.476536] input: Power Button as /class/input/input3
Jan  4 13:39:13 cfhat12 kernel: [    5.476545] ACPI: Power Button [PWRB]
Jan  4 13:39:13 cfhat12 kernel: [    5.476600] input: Power Button as /class/input/input4
Jan  4 13:39:13 cfhat12 kernel: [    5.476602] ACPI: Power Button [PWRF]
Jan  4 13:39:13 cfhat12 kernel: [    5.492371] ACPI: resource piix4_smbus [io  0x0b00-0x0b07] conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f pref]
Jan  4 13:39:13 cfhat12 kernel: [    5.492374] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Jan  4 13:39:13 cfhat12 kernel: [    5.501857] pcwd_pci: PCI-PC Watchdog driver, v1.03
Jan  4 13:39:13 cfhat12 kernel: [    5.505881] pcwd_pci: Found card at port 0xa700 (Firmware: 1.72) with temp option
Jan  4 13:39:13 cfhat12 kernel: [    5.505883] pcwd_pci: Option switches (0x0c): Temperature Reset Enable=OFF, Power On Delay=ON
Jan  4 13:39:13 cfhat12 kernel: [    5.505884] pcwd_pci: No previous trip detected - Cold boot or reset
Jan  4 13:39:13 cfhat12 kernel: [    5.506934] pcwd_pci: initialized. heartbeat=300 sec (nowayout=0)
Jan  4 13:39:13 cfhat12 kernel: [    5.513046] parport_pc 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    5.513049] PCI parallel port detected: 9710:9815, I/O at 0x8f00(0x8e00), IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    5.513125] parport0: PC-style at 0x8f00 (0x8e00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  4 13:39:13 cfhat12 kernel: [    5.607550] PCI parallel port detected: 9710:9815, I/O at 0x8d00(0x8c00), IRQ 17
Jan  4 13:39:13 cfhat12 kernel: [    5.607628] parport1: PC-style at 0x8d00 (0x8c00), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan  4 13:39:13 cfhat12 kernel: [    6.715033] Adding 1951672k swap on /dev/md3.  Priority:-1 extents:1 across:1951672k 
Jan  4 13:39:13 cfhat12 kernel: [    7.064069] loop: module loaded
Jan  4 13:39:13 cfhat12 kernel: [    7.706164] EXT3-fs: barriers not enabled
Jan  4 13:39:13 cfhat12 kernel: [    7.711608] kjournald starting.  Commit interval 5 seconds
Jan  4 13:39:13 cfhat12 kernel: [    7.717953] EXT3-fs (md1): using internal journal
Jan  4 13:39:13 cfhat12 kernel: [    7.717957] EXT3-fs (md1): mounted filesystem with writeback data mode
Jan  4 13:39:13 cfhat12 kernel: [    7.783202] XFS mounting filesystem md7
Jan  4 13:39:13 cfhat12 kernel: [    7.946534] Ending clean XFS mount for filesystem: md7
Jan  4 13:39:13 cfhat12 kernel: [    8.016064] XFS mounting filesystem md5
Jan  4 13:39:13 cfhat12 kernel: [    8.573615] Ending clean XFS mount for filesystem: md5
Jan  4 13:39:13 cfhat12 kernel: [    8.648338] EXT3-fs: barriers not enabled
Jan  4 13:39:13 cfhat12 kernel: [    8.659599] kjournald starting.  Commit interval 5 seconds
Jan  4 13:39:13 cfhat12 kernel: [    8.673098] EXT3-fs (md6): using internal journal
Jan  4 13:39:13 cfhat12 kernel: [    8.673101] EXT3-fs (md6): mounted filesystem with writeback data mode
Jan  4 13:39:13 cfhat12 kernel: [    9.482763] r8169 0000:04:00.0: eth0: link up
Jan  4 13:39:13 cfhat12 kernel: [    9.482769] r8169 0000:04:00.0: eth0: link up
Jan  4 13:39:13 cfhat12 kernel: [    9.702510] fuse init (API version 7.14)
Jan  4 13:39:13 cfhat12 kernel: [   10.064958] NET: Registered protocol family 10
Jan  4 13:39:23 cfhat12 kernel: [   20.131704] eth0: no IPv6 routers present
Jan  4 13:42:16 cfhat12 kernel: [  193.255287] Xenomai: starting POSIX services.
Jan  4 13:42:17 cfhat12 kernel: [  193.459116] Xenomai: POSIX skin init failed, code -19.

--------------020705070708090306000603--

