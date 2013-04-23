Message-ID: <51769250.7050504@bollue.de>
Date: Tue, 23 Apr 2013 15:53:20 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
In-Reply-To: <51767C09.3070502@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hello Jan,
thank you for your reply.

On 23.04.2013 14:18, Jan Kiszka wrote:
> Does sysrq still work then? sysrq-l would be interesting e.g.

No. It works before the freeze (so it's set up correctly), but not =

afterwards.

>> - Either nothing at all, or
>>
>> -
>> [  481.189349] INFO: rcu_bh detected stalls on CPUs/tasks: { 2}
>> (detected by 0, t=3D60042 jiffies)
>> [  481.291572] INFO: Stall ended before state dump start
>> [  541.224383] INFO: rcu_preempt detected stalls on CPUs/tasks: { 2}
>> (detected by 0, t=3D60002 jiffies)
>> [  541.331818] INFO: Stall ended before state dump start
>> (repeated), or
>>
>> -
>> [ 2333.757994] Xenomai: Unbalanced lock/unlock
> Ah, here's where the problem start.
>
> CONFIG_IPIPE_TRACE_PANIC may provide further information. Enable it via
> the I-pipe tracer. Then, before triggering the lockup, increase the
> backtrace points to, say, 2000:
>
> echo 2000 > /proc/ipipe/trace/back_trace_points

New console output attached.


Regards,
Kai
-------------- next part --------------
Loading, please wait...
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...[    5.498387] sp5100_tco: mmio ad=
dress 0xbafe00 already in use
[    5.771115] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    5.863541] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    5.956615] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.049175] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.141544] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.233849] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.327843] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.431569] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[    6.584874] r600_cp: Failed to load firmware "radeon/CEDAR_pfp.bin"
[    6.659847] [drm:evergreen_startup] *ERROR* Failed to load firmware!
[    6.736893] radeon 0000:01:00.0: disabling GPU acceleration
done.
Setting parameters of disc: (none).
Setting preliminary keymap...done.
Activating swap...done.
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda1: clean, 346598/7331840 files, 4342514/29296640 blocks
done.
Cleaning up ifupdown....
Loading kernel modules...done.
Setting up networking....
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
/dev/sda3: clean, 5388/52510720 files, 9685520/210010880 blocks
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.=
1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
Setting kernel variables ...done.
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 8
DHCPOFFER from [...]
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from [...]
bound to [...] -- renewal in 34596 seconds.
SIOCSIFADDR: No such device
eth2: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
eth2: ERROR while getting interface flags: No such device
Failed to bring up eth2.
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting up ALSA...done.
Setting console screen modes.
Rcannot (un)set powersave mode
Skipping font and keymap setup (handled by console-setup).
Setting up console font and keymap...done.
Setting sensors limits.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
Enabling additional executable binary formats: binfmt-support.
Starting ACPI services....
Starting system message bus: dbus.
Starting virtual private network daemon:.
Not starting GNOME Display Manager; it is not the default display manager.
Loading cpufreq kernel modules...done (none).
Starting deferred execution scheduler: atd.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
Starting anac(h)ronistic cron: anacron.
Starting periodic command scheduler: cron.
Starting bluetooth: bluetoothd.
Starting kerneloops:
Starting OpenBSD Secure Shell server: sshd.
Starting Common Unix Printing System: cupsd.
saned disabled; edit /etc/default/saned
Starting MTA: exim4.
Starting Hardware abstraction layer: hald.
Starting ISC DHCP server: dhcpd.
Starting K Display Manager: kdm.
[   40.911390] SysRq : Show State
[   52.255143] SysRq : Show backtrace of all active CPUs
INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
Using makefile-style concurrent boot in runlevel 0.
Stopping GNOME Display Manager: gdm3.
Stopping anac(h)ronistic cron: anacron.
saned disabled; edit /etc/default/saned
Stopping deferred execution scheduler: atd.
Stopping kerneloops: =

Stopping ISC DHCP server: dhcpd.
Stopping virtual private network daemon:.
Stopping MTA: exim4_listener.
Stopping bluetooth: bluetoothd.
Checking for running unattended-upgrades: Stopping Avahi mDNS/DNS-SD Daemon=
: avahi-daemon.
Shutting down ALSA...done.
Stopping K Display Manager: kdm...done.
Asking all remaining processes to terminate...done.
All processes ended within 1 seconds....done.
Stopping enhanced syslogd: rsyslogd.
Stopping portmap daemon....
Stopping NFS common utilities: statd.
Deconfiguring network interfaces...Internet Systems Consortium DHCP Client =
4.1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
DHCPRELEASE on eth0 to [...] port 67
done.
Cleaning up ifupdown....
Saving the system clock.
Deactivating swap...done.
Unmounting local filesystems...done.
Will now halt.
[  531.092086] Power down.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.7-xenomai-2.6.2.1 (root@IRT176) (gcc versi=
on 4.4.5 (Debian 4.4.5-8) ) #7 SMP PREEMPT Tue Apr 23 14:52:00 CEST 2013
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenomai-2.6.2=
.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro console=3DttyS0,96=
00
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000be1e4fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be1e5000-0x00000000be4e8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000be4e9000-0x00000000be8dafff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000be8db000-0x00000000bee2dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000bee2e000-0x00000000bee2efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bee2f000-0x00000000bf034fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf035000-0x00000000bf452fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf453000-0x00000000bf7f3fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000bf7f4000-0x00000000bf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000043effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x43f000 max_arch_pfn =3D 0x400000000
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820: last_pfn =3D 0xbf800 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda10-0x000fda1f] mapped at =
[ffff8800000fda10]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0xbf7fffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x43effffff]
[    0.000000] RAMDISK: [mem 0x37845000-0x37feffff]
[    0.000000] ACPI: RSDP 00000000000f0490 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000be8c8070 00064 (v01 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000be8d1090 0010C (v05 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero addres=
s or length: 0x0000000000000000/0x1 (20120320/tbfadt-579)
[    0.000000] ACPI: DSDT 00000000be8c8170 08F1C (v02 ALASKA    A M I 00000=
000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000be8d4080 00040
[    0.000000] ACPI: APIC 00000000be8d11a0 0009E (v03 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: FPDT 00000000be8d1240 00044 (v01 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000be8d1288 0003C (v01 ALASKA    A M I 01072=
009 MSFT 00010013)
[    0.000000] ACPI: AAFT 00000000be8d12c8 00062 (v01 ALASKA OEMAAFT  01072=
009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000be8d1330 00038 (v01 ALASKA    A M I 01072=
009 AMI  00000005)
[    0.000000] ACPI: SSDT 00000000be8d1368 01714 (v01 AMD    POWERNOW 00000=
001 AMD  00000001)
[    0.000000] ACPI: BGRT 00000000be8d2a80 00038 (v00 ALASKA    A M I 01072=
009 AMI  00010013)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x43effffff]
[    0.000000]   NODE_DATA [mem 0x43effc000-0x43effffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x43effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbe1e4fff]
[    0.000000]   node   0: [mem 0xbee2e000-0xbee2efff]
[    0.000000]   node   0: [mem 0xbf035000-0xbf452fff]
[    0.000000]   node   0: [mem 0xbf7f4000-0xbf7fffff]
[    0.000000]   node   0: [mem 0x100001000-0x43effffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec20000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, GSI 2=
4-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000=
9f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000be1e5000 - 00000000be4=
e9000
[    0.000000] PM: Registered nosave memory: 00000000be4e9000 - 00000000be8=
db000
[    0.000000] PM: Registered nosave memory: 00000000be8db000 - 00000000bee=
2e000
[    0.000000] PM: Registered nosave memory: 00000000bee2f000 - 00000000bf0=
35000
[    0.000000] PM: Registered nosave memory: 00000000bf453000 - 00000000bf7=
f4000
[    0.000000] PM: Registered nosave memory: 00000000bf800000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fec=
10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fec=
11000
[    0.000000] PM: Registered nosave memory: 00000000fec11000 - 00000000fec=
20000
[    0.000000] PM: Registered nosave memory: 00000000fec20000 - 00000000fec=
21000
[    0.000000] PM: Registered nosave memory: 00000000fec21000 - 00000000fed=
00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed=
01000
[    0.000000] PM: Registered nosave memory: 00000000fed01000 - 00000000fed=
61000
[    0.000000] PM: Registered nosave memory: 00000000fed61000 - 00000000fed=
71000
[    0.000000] PM: Registered nosave memory: 00000000fed71000 - 00000000fed=
80000
[    0.000000] PM: Registered nosave memory: 00000000fed80000 - 00000000fed=
90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fef=
00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 00000001000=
00000
[    0.000000] PM: Registered nosave memory: 0000000100000000 - 00000001000=
01000
[    0.000000] e820: [mem 0xbf800000-0xfebfffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 800 pages/cpu @ffff88042c600000 s3248064 r8=
192 d20544 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 4113879
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.5.7-xenoma=
i-2.6.2.1 root=3DUUID=3Dac291233-b3d4-4b70-b409-b36931bc7d7c ro console=3Dt=
tyS0,9600
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Xenomai: forcing noxsave
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ c998000000 size 32 MB
[    0.000000] Aperture beyond 4GB. Ignoring.
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ b4000000
[    0.000000] PM: Registered nosave memory: 00000000b4000000 - 00000000b80=
00000
[    0.000000] Memory: 16284536k/17809408k available (3897k kernel code, 10=
75596k absent, 449276k reserved, 2745k data, 3872k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D8, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:33024 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Interrupt pipeline (release #3)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 3991.481 MHz processor.
[    0.000004] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 7982.96 BogoMIPS (lpj=3D3991481)
[    0.126818] pid_max: default: 32768 minimum: 301
[    0.181944] Security Framework initialized
[    0.230804] SELinux:  Disabled at boot.
[    0.278013] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes)
[    0.370184] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes)
[    0.457988] Mount-cache hash table entries: 256
[    0.512223] Initializing cgroup subsys cpuacct
[    0.565281] Initializing cgroup subsys devices
[    0.618311] Initializing cgroup subsys freezer
[    0.671341] Initializing cgroup subsys net_cls
[    0.724393] CPU: Physical Processor ID: 0
[    0.772213] CPU: Processor Core ID: 0
[    0.815904] mce: CPU supports 7 MCE banks
[    0.863751] LVT offset 1 assigned for vector 0xf9
[    0.920017] ACPI: Core revision 20120320
[    0.994415] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    1.076096] CPU0: AMD FX(tm)-8350 Eight-Core Processor            steppi=
ng 00
[    1.263079] Performance Events: AMD Family 15h PMU driver.
[    1.328673] ... version:                0
[    1.376515] ... bit width:              48
[    1.425394] ... generic registers:      6
[    1.473236] ... value mask:             0000ffffffffffff
[    1.536644] ... max period:             00007fffffffffff
[    1.600052] ... fixed-purpose events:   0
[    1.647895] ... event mask:             000000000000003f
[    1.721030] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
[    1.909228] Brought up 8 CPUs
[    1.944597] Total of 8 processors activated (63863.69 BogoMIPS).
[    2.026105] devtmpfs: initialized
[    2.068968] PM: Registering ACPI NVS region [mem 0xbe4e9000-0xbe8dafff] =
(4136960 bytes)
[    2.165125] PM: Registering ACPI NVS region [mem 0xbee2f000-0xbf034fff] =
(2121728 bytes)
[    2.261254] dummy: =

[    2.286515] NET: Registered protocol family 16
[    2.340202] ACPI: bus type pci registered
[    2.388217] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    2.499411] PCI: not using MMCONFIG
[    2.541023] PCI: Using configuration type 1 for base access
[    2.607550] PCI: Using configuration type 1 for extended access
[    2.681963] bio: create slab <bio-0> at 0
[    2.730115] ACPI: Added _OSI(Module Device)
[    2.780137] ACPI: Added _OSI(Processor Device)
[    2.833267] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.889410] ACPI: Added _OSI(Processor Aggregator Device)
[    3.005454] ACPI: Executed 3 blocks of module-level executable AML code
[    3.128822] ACPI: Interpreter enabled
[    3.172526] ACPI: (supports S0 S3 S4 S5)
[    3.220159] ACPI: Using IOAPIC for interrupt routing
[    3.280191] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    3.391597] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACP=
I motherboard resources
[    3.633947] ACPI: No dock devices found.
[    3.680822] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    3.790928] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.866240] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    3.945248] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    4.024343] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    4.103403] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    4.182380] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x00=
0bffff]
[    4.269661] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x00=
0dffff]
[    4.356936] pci_root PNP0A03:00: host bridge window [mem 0xc0000000-0xff=
ffffff]
[    4.444327] PCI host bridge to bus 0000:00
[    4.493300] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    4.567085] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    4.640874] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    4.714661] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    4.788446] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    4.870534] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f]
[    4.952623] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfffffff=
f]
[    5.044324] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    5.107440] pci 0000:00:09.0: PCI bridge to [bus 02-02]
[    5.170512] pci 0000:00:0a.0: PCI bridge to [bus 03-03]
[    5.233537] pci 0000:00:14.4: PCI bridge to [bus 04-04] (subtractive dec=
ode)
[    5.317969] pci 0000:00:15.0: PCI bridge to [bus 05-05]
[    5.381154] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  Yo=
u can enable it with 'pcie_aspm=3Dforce'
[    5.500695] pci 0000:00:15.1: PCI bridge to [bus 06-06]
[    5.565113] pci 0000:00:15.2: PCI bridge to [bus 07-07]
[    5.629962] pci 0000:00:15.3: PCI bridge to [bus 08-08]
[    5.696212]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    5.763860]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), return=
ed control mask: 0x1d
[    5.865661] ACPI _OSC control for PCIe not granted, disabling ASPM
[    6.011871] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11 14 15) *0
[    6.085685] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11 14 15) *0
[    6.159692] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11 14 15) *0
[    6.233584] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11 14 15) *0
[    6.307421] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11 14 15) *0
[    6.381136] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11 14 15) *0
[    6.454818] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11 14 15) *0
[    6.528507] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11 14 15) *0
[    6.602408] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    6.699133] vgaarb: loaded
[    6.731482] vgaarb: bridge control possible 0000:01:00.0
[    6.795010] PCI: Using ACPI for IRQ routing
[    6.863514] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    6.922226] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    6.994202] Switching to clocksource hpet
[    7.056369] pnp: PnP ACPI init
[    7.092885] ACPI: bus type pnp registered
[    7.142566] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    7.227814] system 00:02: [mem 0xfec20000-0xfec200ff] could not be reser=
ved
[    7.313965] system 00:04: [io  0x040b] has been reserved
[    7.377415] system 00:04: [io  0x04d6] has been reserved
[    7.440926] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    7.511701] system 00:04: [io  0x0c14] has been reserved
[    7.575213] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    7.645991] system 00:04: [io  0x0c52] has been reserved
[    7.709508] system 00:04: [io  0x0c6c] has been reserved
[    7.773012] system 00:04: [io  0x0c6f] has been reserved
[    7.836523] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    7.907306] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    7.978082] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    8.048859] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    8.119632] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    8.190412] system 00:04: [io  0x0800-0x089f] has been reserved
[    8.261190] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    8.331964] system 00:04: [io  0x0900-0x090f] has been reserved
[    8.402740] system 00:04: [io  0x0910-0x091f] has been reserved
[    8.473521] system 00:04: [io  0xfe00-0xfefe] has been reserved
[    8.544297] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    8.627527] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    8.706602] system 00:04: [mem 0xfed80000-0xfed8ffff] has been reserved
[    8.785686] system 00:04: [mem 0xfed61000-0xfed70fff] has been reserved
[    8.864765] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    8.943845] system 00:04: [mem 0xfed00000-0xfed00fff] has been reserved
[    9.022918] system 00:04: [mem 0xffc00000-0xffffffff] has been reserved
[    9.102707] system 00:05: [io  0x0290-0x029f] has been reserved
[    9.176235] system 00:09: [io  0x04d0-0x04d1] has been reserved
[    9.250772] pnp: PnP ACPI: found 14 devices
[    9.300730] ACPI: ACPI bus type pnp unregistered
[    9.369432] pci 0000:06:00.0: no compatible bridge window for [mem 0xfff=
e0000-0xffffffff pref]
[    9.472551] pci 0000:00:15.1: BAR 15: assigned [mem 0xd0100000-0xd01ffff=
f pref]
[    9.559869] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    9.622345] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    9.695205] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    9.776353] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xcfffffff=
 64bit pref]
[    9.868935] pci 0000:00:09.0: PCI bridge to [bus 02-02]
[    9.931404] pci 0000:00:09.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[   10.012571] pci 0000:00:0a.0: PCI bridge to [bus 03-03]
[   10.075031] pci 0000:00:0a.0:   bridge window [mem 0xfe800000-0xfe8fffff]
[   10.156200] pci 0000:00:14.4: PCI bridge to [bus 04-04]
[   10.218656] pci 0000:00:14.4:   bridge window [io  0xd000-0xdfff]
[   10.291516] pci 0000:00:14.4:   bridge window [mem 0xfe300000-0xfe5fffff]
[   10.372680] pci 0000:00:15.0: PCI bridge to [bus 05-05]
[   10.435174] pci 0000:06:00.0: BAR 6: assigned [mem 0xd0100000-0xd011ffff=
 pref]
[   10.521478] pci 0000:00:15.1: PCI bridge to [bus 06-06]
[   10.583955] pci 0000:00:15.1:   bridge window [io  0xc000-0xcfff]
[   10.656811] pci 0000:00:15.1:   bridge window [mem 0xfe700000-0xfe7fffff]
[   10.737966] pci 0000:00:15.1:   bridge window [mem 0xd0100000-0xd01fffff=
 pref]
[   10.824317] pci 0000:00:15.2: PCI bridge to [bus 07-07]
[   10.886779] pci 0000:00:15.2:   bridge window [io  0xb000-0xbfff]
[   10.959637] pci 0000:00:15.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[   11.040805] pci 0000:00:15.3: PCI bridge to [bus 08-08]
[   11.103262] pci 0000:00:15.3:   bridge window [io  0xa000-0xafff]
[   11.176128] pci 0000:00:15.3:   bridge window [mem 0xd0000000-0xd00fffff=
 64bit pref]
[   11.269236] NET: Registered protocol family 2
[   11.323395] IP route cache hash table entries: 524288 (order: 10, 419430=
4 bytes)
[   11.416778] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[   11.508312] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   11.588631] TCP: Hash tables configured (established 524288 bind 65536)
[   11.667710] TCP: reno registered
[   11.706447] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[   11.779446] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[   11.857654] NET: Registered protocol family 1
[   12.165714] pci 0000:04:06.0: Firmware left e100 interrupts enabled; dis=
abling
[   12.252283] Unpacking initramfs...
[   12.503616] Freeing initrd memory: 7852k freed
[   12.563037] PCI-DMA: Disabling AGP.
[   12.604906] PCI-DMA: aperture base @ b4000000 size 65536 KB
[   12.671441] PCI-DMA: using GART IOMMU.
[   12.716175] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[   12.819102] LVT offset 0 assigned for vector 0x400
[   12.876396] perf: AMD IBS detected (0x000000ff)
[   12.930966] audit: initializing netlink socket (disabled)
[   12.995486] type=3D2000 audit(1366730241.647:1): initialized
[   13.074760] I-pipe: head domain Xenomai registered.
[   13.133533] Xenomai: hal/x86_64 started.
[   13.180589] Xenomai: scheduling class idle registered.
[   13.242032] Xenomai: scheduling class rt registered.
[   13.308558] Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loade=
d.
[   13.390772] Xenomai: debug mode enabled.
[   13.445304] Xenomai: starting native API services.
[   13.502518] Xenomai: starting POSIX services.
[   13.554869] Xenomai: starting RTDM services.
[   13.607596] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[   13.691915] VFS: Disk quotas dquot_6.5.2
[   13.738995] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   13.815706] Refined TSC clocksource calibration: 3991.355 MHz.
[   13.815717] Switching to clocksource tsc
[   13.932896] msgmni has been set to 31949
[   13.980685] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[   14.069050] io scheduler noop registered
[   14.116021] io scheduler deadline registered
[   14.167147] io scheduler cfq registered (default)
[   14.225776] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   14.321360] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[   14.415008] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[   14.482461] Linux agpgart interface v0.103
[   14.532092] i8042: PNP: No PS/2 controller found. Probing ports directly.
[   14.616186] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.675570] serio: i8042 AUX port at 0x60,0x64 irq 12
[   14.736456] mousedev: PS/2 mouse device common for all mice
[   14.803176] rtc_cmos 00:07: RTC can wake from S4
[   14.858762] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[   14.932016] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   15.013602] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Te=
am
[   15.095933] rtcan: registered rtcan0
[   15.138621] rtcan0: VIRT driver loaded
[   15.183500] rtcan: registered rtcan1
[   15.226214] rtcan1: VIRT driver loaded
[   15.271419] TCP: cubic registered
[   15.311525] NET: Registered protocol family 10
[   15.365407] mip6: Mobile IPv6
[   15.400874] NET: Registered protocol family 17
[   15.454045] Key type dns_resolver registered
[   15.505750] registered taskstats version 1
[   15.557036] rtc_cmos 00:07: setting system clock to 2013-04-23 15:17:41 =
UTC (1366730261)
[   15.700415] Freeing unused kernel memory: 3872k freed
[   15.763193] Write protecting the kernel read-only data: 6144k
[   15.839815] Freeing unused kernel memory: 188k freed
[   15.928311] Freeing unused kernel memory: 784k freed
Loading, please wait...
[   16.047183] udev[78]: starting version 164
[   16.167279] SCSI subsystem initialized
[   16.167800] ACPI: bus type usb registered
[   16.168034] usbcore: registered new interface driver usbfs
[   16.168157] usbcore: registered new interface driver hub
[   16.172711] usbcore: registered new device driver usb
[   16.175999] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   16.178776] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   16.189619] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[   16.189630] e100: Copyright(c) 1999-2006 Intel Corporation
[   16.731983] ehci_hcd 0000:00:12.2: EHCI Host Controller
[   16.732758] r8169 0000:06:00.0: eth0: RTL8168b/8111b at 0xffffc9000181e0=
00, f8:d1:11:02:8b:e5, XID 18000000 IRQ 72
[   16.732764] r8169 0000:06:00.0: eth0: jumbo features [frames: 4080 bytes=
, tx checksumming: ko]
[   16.732844] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   16.767563] e100 0000:04:06.0: eth1: addr 0xfe500000, irq 21, MAC addr 0=
0:90:27:8f:f6:c4
[   16.784424] firewire_ohci 0000:07:00.0: added OHCI v1.10 device as card =
0, 4 IR + 8 IT contexts, quirks 0x11
[   17.284737] firewire_core 0000:07:00.0: created device fw0: GUID 008f130=
0d3d31300, S400
[   17.397093] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[   17.397650] r8169 0000:08:00.0: eth2: RTL8168evl/8111evl at 0xffffc90001=
874000, bc:5f:f4:8b:f4:94, XID 0c900800 IRQ 73
[   17.397656] r8169 0000:08:00.0: eth2: jumbo features [frames: 9200 bytes=
, tx checksumming: ko]
[   17.716151] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[   17.717505] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   17.894161] ehci_hcd 0000:00:12.2: debug port 1
[   17.950074] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfeb09000
[   18.023609] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   18.092491] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   18.173660] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   18.260058] usb usb1: Product: EHCI Host Controller
[   18.318421] usb usb1: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[   18.398509] usb usb1: SerialNumber: 0000:00:12.2
[   18.454300] hub 1-0:1.0: USB hub found
[   18.499089] hub 1-0:1.0: 5 ports detected
[   18.547775] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   18.610310] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[   18.698907] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[   18.802996] ehci_hcd 0000:00:13.2: debug port 1
[   18.857151] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfeb07000
[   18.930643] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   18.999475] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   19.080683] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   19.167012] usb usb2: Product: EHCI Host Controller
[   19.225314] usb usb2: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[   19.305455] usb usb2: SerialNumber: 0000:00:13.2
[   19.361169] hub 2-0:1.0: USB hub found
[   19.406003] hub 2-0:1.0: 5 ports detected
[   19.456043] scsi0 : pata_atiixp
[   19.493956] scsi1 : pata_atiixp
[   19.537666] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq=
 14
[   19.620837] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq=
 15
[   19.704395] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
[   19.801085] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part =

[   19.899053] scsi2 : ahci
[   19.929773] scsi3 : ahci
[   19.960438] scsi4 : ahci
[   19.991037] scsi5 : ahci
[   20.021569] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b10=
0 irq 19
[   20.110018] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b18=
0 irq 19
[   20.198439] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b20=
0 irq 19
[   20.286888] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b28=
0 irq 19
[   20.375619] ohci_hcd 0000:00:12.0: OHCI Host Controller
[   20.438126] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus =
number 3
[   20.526626] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfeb0a000
[   20.649019] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   20.679846] ata6: SATA link down (SStatus 0 SControl 300)
[   20.679950] ata3: SATA link down (SStatus 0 SControl 300)
[   20.699772] ata5: SATA link down (SStatus 0 SControl 300)
[   20.923511] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   20.924297] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   20.925665] ata4.00: ATA-8: Hitachi HDS721010CLA330, JP4OA3MA, max UDMA/=
133
[   20.925670] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/3=
2), AA
[   21.253089] usb usb3: Product: OHCI Host Controller
[   21.253304] ata4.00: configured for UDMA/133
[   21.253821] scsi 3:0:0:0: Direct-Access     ATA      Hitachi HDS72101 JP=
4O PQ: 0 ANSI: 5
[   21.266645] sd 3:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/931 GiB)
[   21.267104] sd 3:0:0:0: [sda] Write Protect is off
[   21.267282] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   21.291007]  sda: sda1 sda2 sda3
[   21.292657] sd 3:0:0:0: [sda] Attached SCSI disk
[   21.809358] usb usb3: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[   21.889571] usb usb3: SerialNumber: 0000:00:12.0
[   21.945527] hub 3-0:1.0: USB hub found
[   21.990434] hub 3-0:1.0: 5 ports detected
[   22.039400] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   22.101995] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus =
number 4
[   22.190673] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfeb08000
[   22.313406] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   22.394542] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   22.413099] usb 3-3: new low-speed USB device number 2 using ohci_hcd
[   22.557851] usb usb4: Product: OHCI Host Controller
[   22.616253] usb usb4: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[   22.620786] usb 3-3: New USB device found, idVendor=3D046a, idProduct=3D=
0001
[   22.620792] usb 3-3: New USB device strings: Mfr=3D1, Product=3D0, Seria=
lNumber=3D0
[   22.620797] usb 3-3: Manufacturer: Cherry GmbH
[   22.914749] usb usb4: SerialNumber: 0000:00:13.0
[   22.914997] usb 3-4: new low-speed USB device number 3 using ohci_hcd
[   23.047471] hub 4-0:1.0: USB hub found
[   23.092339] hub 4-0:1.0: 5 ports detected
[   23.099746] usb 3-4: New USB device found, idVendor=3D046d, idProduct=3D=
c018
[   23.099752] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[   23.099757] usb 3-4: Product: USB Optical Mouse
[   23.099762] usb 3-4: Manufacturer: Logitech
[   23.410099] ehci_hcd 0000:00:16.2: EHCI Host Controller
[   23.472636] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus =
number 5
[   23.561144] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[   23.665176] ehci_hcd 0000:00:16.2: debug port 1
[   23.719430] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfeb04000
[   23.793088] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[   23.861891] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   23.942974] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   24.029353] usb usb5: Product: EHCI Host Controller
[   24.087674] usb usb5: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ehci_hcd
[   24.167791] usb usb5: SerialNumber: 0000:00:16.2
[   24.223558] hub 5-0:1.0: USB hub found
[   24.268340] hub 5-0:1.0: 4 ports detected
[   24.316981] ohci_hcd 0000:00:14.5: OHCI Host Controller
[   24.379522] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus =
number 6
[   24.467963] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfeb06000
[   24.590482] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   24.671647] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   24.758027] usb usb6: Product: OHCI Host Controller
[   24.816415] usb usb6: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[   24.896558] usb usb6: SerialNumber: 0000:00:14.5
[   24.952263] hub 6-0:1.0: USB hub found
[   24.997064] hub 6-0:1.0: 2 ports detected
[   25.045615] ohci_hcd 0000:00:16.0: OHCI Host Controller
[   25.108100] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus =
number 7
[   25.196640] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfeb05000
[   25.318905] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   25.400018] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   25.486448] usb usb7: Product: OHCI Host Controller
[   25.544836] usb usb7: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 ohci_hcd
[   25.624979] usb usb7: SerialNumber: 0000:00:16.0
[   25.680673] hub 7-0:1.0: USB hub found
[   25.725474] hub 7-0:1.0: 4 ports detected
[   25.802217] usbcore: registered new interface driver usbhid
[   25.868773] usbhid: USB HID core driver
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /[   26.372533] PM: Starting manual resume from disk
scripts/local-premount ... done.
[   26.515808] EXT4-fs (sda1): mounted filesystem with ordered data mode. O=
pts: (null)
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd[   28.064103] udev[328]: star=
ting version 164
.
Synthesizing the initial hotplug events...done.
[   28.387516] wmi: Mapper loaded
[   28.393255] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
C:00/input/input0
[   28.393271] ACPI: Power Button [PWRB]
[   28.393593] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[   28.393608] ACPI: Power Button [PWRF]
Waiting for /dev to be fully populated...[   28.822579] microcode: CPU0: pa=
tch_level=3D0x06000817
[   28.827673] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   29.078629] input: Cherry GmbH as /devices/pci0000:00/0000:00:12.0/usb3/=
3-3/3-3:1.0/input/input3
[   29.184301] hid-generic 0003:046A:0001.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Cherry GmbH] on usb-0000:00:12.0-3/input0
[   29.320171] input: Logitech USB Optical Mouse as /devices/pci0000:00/000=
0:00:12.0/usb3/3-4/3-4:1.0/input/input4
[   29.441500] hid-generic 0003:046D:C018.0002: input,hidraw1: USB HID v1.1=
1 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-4/input0
[   29.630330] MCE: In-kernel MCE decoding enabled.
[   29.711113] ACPI Warning: [   29.738582] [drm] Initialized drm 1.1.0 200=
60810
0x0000000000000b00-0x0000000000000b07 SystemIO conflicts with Region \SOR1 =
1 (20120320/utaddress-251)
[   29.875982] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   29.876009] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 8
[   29.880535] xhci_hcd 0000:02:00.0: irq 48, io mem 0xfe900000
[   29.925595] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.925633] microcode: CPU1: patch_level=3D0x06000817
[   29.932498] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.932527] microcode: CPU2: patch_level=3D0x06000817
[   29.939979] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.940009] microcode: CPU3: patch_level=3D0x06000817
[   29.940630] EDAC MC: Ver: 2.1.0
[   29.950974] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.951013] microcode: CPU4: patch_level=3D0x06000817
[   29.960407] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.960449] microcode: CPU5: patch_level=3D0x06000817
[   29.969731] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   29.969781] microcode: CPU6: patch_level=3D0x06000817
[   29.979290] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   31.105533] microcode: CPU7: patch_level=3D0x06000817
[   31.106590] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   31.106596] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   31.106602] usb usb8: Product: xHCI Host Controller
[   31.106607] usb usb8: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[   31.106612] usb usb8: SerialNumber: 0000:02:00.0
[   31.107313] hub 8-0:1.0: USB hub found
[   31.107335] hub 8-0:1.0: 2 ports detected
[   31.107740] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   31.107752] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 9
[   31.107902] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[   31.107908] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   31.107913] usb usb9: Product: xHCI Host Controller
[   31.107919] usb usb9: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[   31.107924] usb usb9: SerialNumber: 0000:02:00.0
[   31.108595] hub 9-0:1.0: USB hub found
[   31.108618] hub 9-0:1.0: 2 ports detected
[   32.222396] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[   32.227583] AMD64 EDAC driver v3.4.0
[   32.231115] microcode: failed to load file amd-ucode/microcode_amd_fam15=
h.bin
[   32.231654] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[   32.576844] kvm: Nested Virtualization enabled
[   32.577193] EDAC amd64: DRAM ECC disabled.
[   32.678825] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
[   32.678825]  Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
[   32.678825]  (Note that use of the override may cause unknown side effec=
ts.)
[   32.679011] kvm: Nested Paging enabled
[   32.680157] sp5100_tco: SP5100 TCO WatchDog Timer Driver v0.01
[   32.683441] sp5100_tco: mmio address 0xbafe00 already in use
[   33.151638] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   33.214457] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 10
[   33.308647] xhci_hcd 0000:03:00.0: irq 47, io mem 0xfe800000
[   33.378228] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   33.460595] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[   33.548278] usb usb10: Product: xHCI Host Controller
[   33.607969] usb usb10: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[   33.689252] usb usb10: SerialNumber: 0000:03:00.0
[   33.700160] [drm] radeon kernel modesetting enabled.
[   33.701290] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0=
x174B:0x3000).
[   33.899313] [drm] register mmio base: 0xFEA20000
[   33.900212] hub 10-0:1.0: USB hub found
[   33.900237] hub 10-0:1.0: 2 ports detected
[   33.900671] xhci_hcd 0000:03:00.0: xHCI Host Controller
[   33.900684] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus =
number 11
[   33.900837] usb usb11: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[   33.900843] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[   33.900848] usb usb11: Product: xHCI Host Controller
[   33.900854] usb usb11: Manufacturer: Linux 3.5.7-xenomai-2.6.2.1 xhci_hcd
[   33.900859] usb usb11: SerialNumber: 0000:03:00.0
[   33.901782] hub 11-0:1.0: USB hub found
[   33.901814] hub 11-0:1.0: 2 ports detected
[   34.661741] [drm] register mmio size: 131072
[   34.714719] ATOM BIOS: AMD
[   34.747225] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x0000=
00003FFFFFFF (1024M used)
[   34.854252] radeon 0000:01:00.0: GTT: 512M 0x0000000040000000 - 0x000000=
005FFFFFFF
[   34.955594] [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
[   35.014066] [drm] RAM width 64bits DDR
[   35.059273] [TTM] Zone  kernel: Available graphics memory: 8181592 kiB
[   35.137553] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   35.215688] [TTM] Initializing pool allocator
[   35.267852] [TTM] Initializing DMA pool allocator
[   35.324312] [drm] radeon: 1024M of VRAM memory ready
[   35.383741] [drm] radeon: 512M of GTT memory ready.
[   35.442240] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   35.521359] [drm] Driver supports precise vblank timestamp query.
[   35.594373] radeon 0000:01:00.0: radeon: using MSI.
[   35.652832] [drm] radeon: irq initialized.
[   35.701800] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   35.776638] [drm] Loading CEDAR Microcode
[   35.840717] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/s=
ound/card0/input5
[   35.844751] r600_cp: Failed to load firmware "radeon/CEDAR_pfp.bin"
[   35.844758] [drm:evergreen_startup] *ERROR* Failed to load firmware!
[   35.844764] radeon 0000:01:00.0: disabling GPU acceleration
[   35.845794] radeon 0000:01:00.0: ffff8804276b0000 unpin not necessary
[   35.846022] radeon 0000:01:00.0: ffff8804276b0400 unpin not necessary
[   35.846032] radeon 0000:01:00.0: ffff8804276b0400 unpin not necessary
[   35.847356] [drm] Radeon Display Connectors
[   35.847361] [drm] Connector 0:
[   35.847366] [drm]   HDMI-A-1
[   35.847371] [drm]   HPD4
[   35.847376] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644=
c 0x644c
[   35.847381] [drm]   Encoders:
[   35.847386] [drm]     DFP1: INTERNAL_UNIPHY1
[   35.847391] [drm] Connector 1:
[   35.847396] [drm]   DVI-I-1
[   35.847400] [drm]   HPD1
[   35.847406] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646=
c 0x646c
[   35.847410] [drm]   Encoders:
[   35.847415] [drm]     DFP2: INTERNAL_UNIPHY
[   35.847420] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   35.847425] [drm] Connector 2:
[   35.847430] [drm]   VGA-1
[   35.847435] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643=
c 0x643c
[   35.847440] [drm]   Encoders:
[   35.847444] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[   35.847530] [drm] Internal thermal controller without fan control
[   35.847674] [drm] radeon: power management initialized
[   37.421465] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14=
.2/sound/card0/input6
[   37.425597] [drm] fb mappable at 0xC0040000
[   37.425604] [drm] vram apper at 0xC0000000
[   37.425611] [drm] size 5242880
[   37.425618] [drm] fb depth is 24
[   37.425625] [drm]    pitch is 5120
[   37.425855] fbcon: radeondrmfb (fb0) is primary device
[   38.047818] Console: switching to colour frame buffer device 160x64
[   37.799352] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input7
[   37.799777] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:=
00:14.2/sound/card0/input8
[   37.800089] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0=
000:00:14.2/sound/card0/input9
[   37.800390] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000=
:00:14.2/sound/card0/input10
[   38.559897] fb0: radeondrmfb frame buffer device
[   38.615129] drm: registered panic notifier
[   38.664131] [drm] Initialized radeon 2.18.0 20080528 for 0000:01:00.0 on=
 minor 0
[   38.752940] hda-intel: 0000:01:00.1: Handle VGA-switcheroo audio client
[   38.850835] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:02.0/0000:01:00.1/sound/card1/input11
done.
Setting parameters of disc: (none).
Setting preliminary keymap...done.
Activating swap...[   39.673544] Adding 19530748k swap on /dev/sda2.  Prior=
ity:-1 extents:1 across:19530748k =

done.
[   39.785612] EXT4-fs (sda1): re-mounted. Opts: (null)
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/sda1: clean[   40.046562] EXT4-fs (sda1): re-mounted. Opts: errors=3Dr=
emount-ro
, 346611/7331840 files, 4342765/29296640 blocks
done.
Cleaning up ifupdown....
[   40.240844] loop: module loaded
Loading kernel modules...done.
Setting up networking....
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
/dev/sda3: clean, 5440/52510720 files, 9686639/210010880 blocks
done.
Mounting local filesystems...[   41.011768] EXT4-fs (sda3): mounted filesys=
tem with ordered data mode. Opts: (null)
done.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...Setting kernel variables ...done.
Internet Systems Consortium DHCP Client 4.1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights r[   41.835518] r8169 0000:08:00.0: eth0: unable to load firmwar=
e patch rtl_nic/rtl8168e-3.fw (-2)
eserved.
For in[   41.951734] r8169 0000:08:00.0: eth0: link down
[   41.951786] r8169 0000:08:00.0: eth0: link down
fo, please visit[   42.070793] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not=
 ready
 https://www.isc.org/software/dhcp/

Listening on LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   LPF/eth0/bc:5f:f4:8b:f4:94
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 8
[   43.487992] r8169 0000:08:00.0: eth0: link up
[   43.541145] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 9
DHCPOFFER from [...]
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from [...]
bound to [...] -- renewal in 36643 seconds.
[   51.645238] r8169 0000:06:00.0: eth1: link down
[   51.645299] r8169 0000:06:00.0: eth1: link down
[   51.754903] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
SIOCSIFADDR: No such device
eth2: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such [   52.038161] e100 0000:04:06.0: eth3: NIC Link is=
 Up 100 Mbps Full Duplex
device
eth2: ER[   52.135742] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
ROR while gettin[   52.222251] IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link be=
comes ready
g interface flags: No such device
Failed to bring up eth2.
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting up ALSA...done.
[   52.724915] fuse init (API version 7.19)
Setting console screen modes.
Rcannot (un)set powersave mode
Skipping font and keymap setup (handled by console-setup).
Setting up console font and keymap...done.
Setting sensors limits.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting portmap daemon...Already running..
Starting NFS common utilities: statd.
Starting enhanced syslogd: rsyslogd.
[   53.739496] r8169 0000:06:00.0: eth1: link up
[   53.792980] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Enabling additional executable binary formats: binfmt-support.
Starting ACPI services....
Starting system message bus: dbus.
Starting virtual private network daemon:.
Not starting GNOME Display Manager; it is not the default display manager.
Starting Hardware abstraction layer: haldStarting anac(h)ronistic cron: ana=
cron.
Loading cpufreq kernel modules...done (none).
Starting deferred execution scheduler: atd.
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
[   55.899857] Bluetooth: Core ver 2.16
[   55.944499] NET: Registered protocol family 31
[   55.997660] Bluetooth: HCI device and connection manager initialized
[   56.073793] Bluetooth: HCI socket layer initialized
[   56.132378] Bluetooth: L2CAP socket layer initialized
[   56.193008] Bluetooth: SCO socket layer initialized
Starting periodic command scheduler: cron.
[   56.587839] Bluetooth: RFCOMM TTY layer initialized
[   56.646219] Bluetooth: RFCOMM socket layer initialized
[   56.708018] Bluetooth: RFCOMM ver 1.11
[   56.748222] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   56.748228] Bluetooth: BNEP filters: protocol multicast
[   56.981522] Bridge firewalling registered
Starting bluetooth: bluetoothd.
[   57.064281] sshd (1660): /proc/1660/oom_adj is deprecated, please use /p=
roc/1660/oom_score_adj instead.
Starting OpenBSD Secure Shell server: sshd.
.
Starting kerneloops:
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting K Display Manager: kdm.
Starting MTA: exim4.
[   58.638384] lp: driver loaded but no devices found
[   58.843040] ppdev: user-space parallel port driver
saned disabled; edit /etc/default/saned
Starting Common Unix Printing System: cupsd.
Starting ISC DHCP server: dhcpd.
[   93.840600] SysRq : Show backtrace of all active CPUs
[   93.900991] CPU5:
[   93.923924] CPU 5 =

[   93.945820] Modules linked in:[   93.982353]  parport_pc ppdev lp parpor=
t bridge stp llc bnep rfcomm bluetooth rfkill binfmt_misc fuse loop snd_hda=
_codec_hdmi snd_hda_codec_realtek radeon snd_hda_intel snd_seq snd_hda_code=
c snd_hwdep snd_pcm snd_timer snd_seq_device snd sp5100_tco ttm drm_kms_hel=
per kvm_amd soundcore edac_core kvm xhci_hcd crc32c_intel drm i2c_piix4 snd=
_page_alloc i2c_algo_bit edac_mce_amd k10temp fam15h_power i2c_core hid_gen=
eric psmouse pcspkr microcode mxm_wmi tpm_tis tpm evdev tpm_bios serio_raw =
button wmi ext4 mbcache jbd2 crc16 usbhid hid sd_mod crc_t10dif ata_generic=
 ohci_hcd pata_atiixp ahci libahci libata firewire_ohci e100 firewire_core =
crc_itu_t ehci_hcd r8169 mii usbcore scsi_mod usb_common [last unloaded: sc=
si_wait_scan]

[   94.752595] Pid: 0, comm: swapper/5 Not tainted 3.5.7-xenomai-2.6.2.1 #7=
 To Be Filled By O.E.M. To Be Filled By O.E.M./970 Extreme4
[   94.894145] RIP: 0010:[<ffffffff810a5a65>]  [<ffffffff810a5a65>] __ipipe=
_trace+0x4/0x5ba
[   94.990867] RSP: 0018:ffff88042a4d33f8  EFLAGS: 00000246
[   95.054277] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   95.139478] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   95.224678] RBP: ffff88042a4d33f8 R08: 0000000000000000 R09: 00000000000=
00000
[   95.309880] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   95.395085] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   95.480287] FS:  00007f79fa19b700(0000) GS:ffff88042da00000(0000) knlGS:=
0000000000000000
[   95.576904] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   95.645500] CR2: 00007fc25cc3bbf0 CR3: 0000000428b1c000 CR4: 00000000000=
007e0
[   95.730704] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   95.815905] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[   95.901115] Process swapper/5 (pid: 0, threadinfo ffff88042a4d0000, task=
 ffff88042a48c920)
[   95.999799] Stack:
[   96.023771]  ffff88042a4d3ee8 ffffffff81009f5a ffff88042a4d3f18 ffffffff=
81009665
[   96.112502]  000000000000ccb0 1f9bf6bb3fc69a41 ffff88042a4d3f18 00000000=
0000ccb0
[   96.201232]  ffff88042a4d3f48 ffffffff813bb797 554e472e65746f6e 5f2666a8=
5ae4177a
[   96.289964] Call Trace:
[   96.319137]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[   96.384618]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[   96.446994]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[   96.517674] Code: e8 ad a1 12 00 0f b6 4f 61 d3 e6 48 63 f6 48 03 77 10 =
8b 06 c9 c3 55 48 89 e5 e8 93 a1 12 00 0f b6 4f 61 d3 e6 03 77 08 89 f2 ec =
<0f> b6 c0 c9 c3 55 48 89 e5 e8 79 a1 12 00 0f b6 4f 61 89 d0 d3 =

[   96.750434] CPU6:
[   96.750464]  ffff8804286afca0 00000000ffffffff ffff88042dd185b0 ffff8804=
286afc58
[   96.750485]  ffffffff81004d80 ffff8804286afc78 ffffffff8128f478 00000000=
0000812d
[   96.750507] Call Trace:
[   96.750520]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[   96.750534]  [<ffffffff8128f478>] ? showacpu+0x4b/0x66
[   96.750548]  [<ffffffff8107ae8a>] ? generic_smp_call_function_interrupt+=
0xa3/0x17d
[   96.750559]  [<ffffffff8128f42d>] ? sysrq_showregs_othercpus+0x1b/0x1b
[   96.750572]  [<ffffffff8101c656>] ? smp_reboot_interrupt+0x1c/0x1c
[   96.750584]  [<ffffffff8101c656>] ? smp_reboot_interrupt+0x1c/0x1c
[   96.750598]  [<ffffffff8101c669>] ? smp_call_function_interrupt+0x13/0x22
[   96.750610]  [<ffffffff8101c26b>] ? __ipipe_do_IRQ+0x79/0x85
[   96.750626]  [<ffffffff8101c656>] ? smp_reboot_interrupt+0x1c/0x1c
[   96.750638]  [<ffffffff8101c271>] ? __ipipe_do_IRQ+0x7f/0x85
[   96.750654]  [<ffffffff810a325c>] ? __ipipe_do_sync_stage+0x160/0x17e
[   96.750671]  [<ffffffff810a32ec>] ? __ipipe_do_sync_pipeline+0x72/0xa3
[   96.750684]  [<ffffffff810a3343>] ? __ipipe_sync_pipeline+0x26/0x3e
[   96.750697]  [<ffffffff810a3748>] ? __ipipe_dispatch_irq+0x1ff/0x222
[   96.750712]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[   96.750726]  [<ffffffff813cb2a9>] ? call_function_interrupt+0x79/0xc0
[   96.750748]  [<ffffffff81159bec>] ? vfs_write+0xc9/0x10a
[   96.750762]  [<ffffffff81159bd1>] ? vfs_write+0xae/0x10a
[   96.750773]  [<ffffffff8115a547>] ? fget_light+0xb0/0xc0
[   96.750788]  [<ffffffff81159cf0>] ? sys_write+0x4a/0x71
[   96.750804]  [<ffffffff813ca086>] ? system_call_fastpath+0x16/0x1b
[   96.750443]  ffff8804286afc10 0000000000000005 0000000000000000 00000000=
00000006
[  145.552412] =

[  145.552412] *** RTnet 0.9.13 - built on Apr 23 2013 15:01:51 ***
[  145.552412] =

[  145.659533] RTnet: initialising real-time networking
[  145.793747] rteth0: 0000:04:06.0, 00:90:27:8F:F6:C4, IRQ 21.
[  145.862978] RTnet: registered rteth0
[  171.742757] I-pipe: Detected illicit call from head domain 'Xenomai'
[  171.742757] <3>        into a regular Linux service
[  171.876811]  |  #*func    	        0 ipipe_trace_panic_freeze+0x9 (ipipe=
_root_only+0x62)
[  171.889987]   #func    	    -259182 task_tick_idle+0x4 (scheduler_tick+0=
xba)
[  171.889994]      #func    	    -259182 sched_avg_update+0x4 (__update_cp=
u_load+0xc8)
[  171.890002]      #func    	    -259183 __update_cpu_load+0xb (scheduler_=
tick+0x63)
[  171.890010]  |   #end     0x80000001  -259183 debug_smp_processor_id+0x9=
7 (__cycles_2_ns+0x11)
[  171.890018]  |   #begin   0x80000001  -259183 debug_smp_processor_id+0x4=
3 (__cycles_2_ns+0x11)
[  171.890027]      #func    	    -259183 update_rq_clock+0x9 (scheduler_ti=
ck+0x47)
[  171.890035]  |   #end     0x80000001  -259183 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890044]  |   #begin   0x80000001  -259183 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890052]      #func    	    -259183 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.890060]      #func    	    -259183 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.890069]      #func    	    -259184 _raw_spin_lock+0x9 (scheduler_tic=
k+0x3f)
[  171.890077]  |   #end     0x80000001  -259184 debug_smp_processor_id+0x9=
7 (scheduler_tick+0x1e)
[  171.890085]  |   #begin   0x80000001  -259184 debug_smp_processor_id+0x4=
3 (scheduler_tick+0x1e)
[  171.890094]      #func    	    -259184 scheduler_tick+0xd (update_proces=
s_times+0x67)
[  171.890102]  |   #end     0x80000001  -259184 debug_smp_processor_id+0x9=
7 (irq_work_run+0x17)
[  171.890111]  |   #begin   0x80000001  -259184 debug_smp_processor_id+0x4=
3 (irq_work_run+0x17)
[  171.890119]      #func    	    -259184 printk_tick+0x7 (update_process_t=
imes+0x46)
[  171.890127]      #func    	    -259184 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0x13b)
[  171.890135]      #func    	    -259184 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0x11c)
[  171.890144]      #func    	    -259185 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0xfd)
[  171.890152]  |   #end     0x80000001  -259185 debug_smp_processor_id+0x9=
7 (rcu_is_cpu_rrupt_from_idle+0x1a)
[  171.890160]  |   #begin   0x80000001  -259185 debug_smp_processor_id+0x4=
3 (rcu_is_cpu_rrupt_from_idle+0x1a)
[  171.890168]      #func    	    -259185 rcu_is_cpu_rrupt_from_idle+0x9 (r=
cu_check_callbacks+0x27)
[  171.890176]      #func    	    -259185 rcu_check_callbacks+0x7 (update_p=
rocess_times+0x41)
[  171.890185]  |   #end     0x80000001  -259185 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890193]  |   #begin   0x80000001  -259185 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890201]      #func    	    -259185 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.890210]      #func    	    -259186 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.890218]      #func    	    -259186 __raise_softirq_irqoff+0x7 (raise=
_softirq_irqoff+0x9)
[  171.890227]      #func    	    -259186 raise_softirq+0x9 (run_local_time=
rs+0x18)
[  171.890235]  |   #end     0x80000001  -259186 debug_smp_processor_id+0x9=
7 (hrtimer_run_queues+0x22)
[  171.890243]  |   #begin   0x80000001  -259186 debug_smp_processor_id+0x4=
3 (hrtimer_run_queues+0x22)
[  171.890252]      #func    	    -259186 hrtimer_run_queues+0x11 (run_loca=
l_timers+0xe)
[  171.890260]      #func    	    -259186 run_local_timers+0x4 (update_proc=
ess_times+0x36)
[  171.890268]  |   #end     0x80000001  -259186 debug_smp_processor_id+0x9=
7 (account_idle_time+0x37)
[  171.890276]  |   #begin   0x80000001  -259186 debug_smp_processor_id+0x4=
3 (account_idle_time+0x37)
[  171.890285]  |   #end     0x80000001  -259186 debug_smp_processor_id+0x9=
7 (account_idle_time+0x28)
[  171.890293]  |   #begin   0x80000001  -259187 debug_smp_processor_id+0x4=
3 (account_idle_time+0x28)
[  171.890301]      #func    	    -259187 account_idle_time+0xd (account_pr=
ocess_tick+0x8e)
[  171.890309]  |   #end     0x80000001  -259187 debug_smp_processor_id+0x9=
7 (account_process_tick+0x23)
[  171.890317]  |   #begin   0x80000001  -259187 debug_smp_processor_id+0x4=
3 (account_process_tick+0x23)
[  171.890326]      #func    	    -259187 account_process_tick+0xb (update_=
process_times+0x31)
[  171.890334]  |   #end     0x80000001  -259187 debug_smp_processor_id+0x9=
7 (update_process_times+0x23)
[  171.890342]  |   #begin   0x80000001  -259187 debug_smp_processor_id+0x4=
3 (update_process_times+0x23)
[  171.890351]      #func    	    -259187 update_process_times+0xd (update_=
root_process_times+0x2a)
[  171.890359]      #func    	    -259187 update_root_process_times+0x9 (ti=
ck_sched_timer+0x64)
[  171.890367]      #func    	    -259188 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.890376]      #func    	    -259188 _raw_spin_unlock+0x4 (tick_do_upd=
ate_jiffies64+0xb0)
[  171.890385]      #func    	    -259188 calc_global_load+0x5 (do_timer+0x=
4d1)
[  171.890393]  |   #end     0x80000001  -259188 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890401]  |   #begin   0x80000001  -259188 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890410]      #func    	    -259188 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.890418]      #func    	    -259188 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.890426]      #func    	    -259188 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.890434]      #func    	    -259188 _raw_spin_unlock+0x4 (write_sequn=
lock+0xf)
[  171.890443]  |   #end     0x80000001  -259188 hard_local_irq_restore+0x1=
b (__ipipe_notify_kevent+0x71)
[  171.890451]  |   #begin   0x80000001  -259189 hard_local_irq_save+0x1b (=
__ipipe_notify_kevent+0x62)
[  171.890460]  |   #end     0x80000001  -259189 hard_local_irq_restore+0x1=
b (__ipipe_spin_unlock_irqrestore+0x34)
[  171.890468]  |   #func    	    -259189 __ipipe_spin_unlock_irqrestore+0x=
9 (hostrt_event+0xbe)
[  171.890477]  |   #begin   0x80000001  -259189 hard_local_irq_save+0x1b (=
__ipipe_spin_lock_irqsave+0x14)
[  171.890486]      #func    	    -259189 __ipipe_spin_lock_irqsave+0x7 (ho=
strt_event+0x1d)
[  171.890494]      #func    	    -259189 hostrt_event+0x9 (ipipe_kevent_ho=
ok+0x1f)
[  171.890502]      #func    	    -259189 ipipe_kevent_hook+0x4 (__ipipe_no=
tify_kevent+0x5a)
[  171.890510]  |   #end     0x80000001  -259189 hard_local_irq_restore+0x1=
b (__ipipe_notify_kevent+0x4f)
[  171.890519]  |   #begin   0x80000001  -259190 hard_local_irq_save+0x1b (=
__ipipe_notify_kevent+0x27)
[  171.890527]  |   #end     0x80000001  -259190 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890536]  |   #begin   0x80000001  -259190 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890544]      #func    	    -259190 ipipe_root_only+0x9 (__ipipe_noti=
fy_kevent+0x22)
[  171.890552]      #func    	    -259190 __ipipe_notify_kevent+0xf (ipipe_=
update_hostrt+0x73)
[  171.890561]  |   #end     0x80000001  -259190 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890569]  |   #begin   0x80000001  -259190 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890578]      #func    	    -259190 ipipe_root_only+0x9 (ipipe_update=
_hostrt+0x25)
[  171.890586]      #func    	    -259190 ipipe_update_hostrt+0xf (update_v=
syscall+0xf3)
[  171.890595]      #func    	    -259190 set_normalized_timespec+0x4 (upda=
te_vsyscall+0xbd)
[  171.890603]      #func    	    -259191 __current_kernel_time+0x8 (update=
_vsyscall+0x9c)
[  171.890611]      #func    	    -259191 set_normalized_timespec+0x4 (upda=
te_vsyscall+0x82)
[  171.890619]      #func    	    -259191 update_vsyscall+0xf (timekeeping_=
update+0x43)
[  171.890628]      #func    	    -259191 set_normalized_timespec+0x4 (upda=
te_rt_offset+0x2a)
[  171.890636]      #func    	    -259191 update_rt_offset+0x8 (timekeeping=
_update+0x23)
[  171.890644]      #func    	    -259191 timekeeping_update+0x4 (do_timer+=
0x4b5)
[  171.890652]      #func    	    -259191 sub_preempt_count+0x4 (_raw_spin_=
unlock_irqrestore+0x22)
[  171.890660]  |   #end     0x80000001  -259191 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890669]  |   #begin   0x80000001  -259191 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890677]      #func    	    -259192 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.890686]      #func    	    -259192 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.890694]      #func    	    -259192 _raw_spin_unlock_irqrestore+0x4 (=
ntp_tick_length+0x39)
[  171.890703]      #func    	    -259192 __ipipe_spin_unlock_debug+0x4 (nt=
p_tick_length+0x2a)
[  171.890711]  |   #end     0x80000001  -259192 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890720]  |   #begin   0x80000001  -259192 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890728]      #func    	    -259192 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.890736]      #func    	    -259192 add_preempt_count+0x9 (_raw_spin_=
lock_irqsave+0x56)
[  171.890744]      #func    	    -259192 _raw_spin_lock_irqsave+0x7 (ntp_t=
ick_length+0x18)
[  171.890753]      #func    	    -259192 ntp_tick_length+0x7 (do_timer+0x3=
22)
[  171.890761]      #func    	    -259192 sub_preempt_count+0x4 (_raw_spin_=
unlock_irqrestore+0x22)
[  171.890769]  |   #end     0x80000001  -259193 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890778]  |   #begin   0x80000001  -259193 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890786]      #func    	    -259193 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.890794]      #func    	    -259193 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.890803]      #func    	    -259193 _raw_spin_unlock_irqrestore+0x4 (=
ntp_tick_length+0x39)
[  171.890811]      #func    	    -259193 __ipipe_spin_unlock_debug+0x4 (nt=
p_tick_length+0x2a)
[  171.890819]  |   #end     0x80000001  -259193 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890828]  |   #begin   0x80000001  -259193 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890836]      #func    	    -259193 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.890844]      #func    	    -259193 add_preempt_count+0x9 (_raw_spin_=
lock_irqsave+0x56)
[  171.890853]      #func    	    -259194 _raw_spin_lock_irqsave+0x7 (ntp_t=
ick_length+0x18)
[  171.890861]      #func    	    -259194 ntp_tick_length+0x7 (do_timer+0x1=
bc)
[  171.890869]      #func    	    -259194 sub_preempt_count+0x4 (_raw_spin_=
unlock_irqrestore+0x22)
[  171.890877]  |   #end     0x80000001  -259194 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890885]  |   #begin   0x80000001  -259194 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890894]      #func    	    -259194 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.890902]      #func    	    -259194 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.890911]      #func    	    -259194 _raw_spin_unlock_irqrestore+0x4 (=
ntp_tick_length+0x39)
[  171.890919]      #func    	    -259194 __ipipe_spin_unlock_debug+0x4 (nt=
p_tick_length+0x2a)
[  171.890927]  |   #end     0x80000001  -259195 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890936]  |   #begin   0x80000001  -259195 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890944]      #func    	    -259195 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.890953]      #func    	    -259195 add_preempt_count+0x9 (_raw_spin_=
lock_irqsave+0x56)
[  171.890961]      #func    	    -259195 _raw_spin_lock_irqsave+0x7 (ntp_t=
ick_length+0x18)
[  171.890969]      #func    	    -259195 ntp_tick_length+0x7 (do_timer+0xd=
5)
[  171.890977]  |   #end     0x80000001  -259195 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.890986]  |   #begin   0x80000001  -259195 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.890994]      #func    	    -259195 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.891002]      #func    	    -259195 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.891009]      #func    	    -259196 _raw_spin_lock+0x9 (write_seqlock=
+0x15)
[  171.891017]      #func    	    -259196 do_timer+0x11 (tick_do_update_jif=
fies64+0x89)
[  171.891026]  |   #end     0x80000001  -259196 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891034]  |   #begin   0x80000001  -259196 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891042]      #func    	    -259196 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.891051]      #func    	    -259196 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.891059]      #func    	    -259196 _raw_spin_lock+0x9 (tick_do_updat=
e_jiffies64+0x34)
[  171.891067]      #func    	    -259196 tick_do_update_jiffies64+0x9 (tic=
k_sched_timer+0x4a)
[  171.891076]  |   #end     0x80000001  -259196 debug_smp_processor_id+0x9=
7 (tick_sched_timer+0x2b)
[  171.891085]  |   #begin   0x80000001  -259197 debug_smp_processor_id+0x4=
3 (tick_sched_timer+0x2b)
[  171.891093]      #func    	    -259197 ktime_get+0xd (tick_sched_timer+0=
x23)
[  171.891102]      #func    	    -259197 tick_sched_timer+0xd (__run_hrtim=
er+0xf2)
[  171.891110]      #func    	    -259197 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.891118]      #func    	    -259197 _raw_spin_unlock+0x4 (__run_hrtim=
er+0xab)
[  171.891127]      #func    	    -259197 __remove_hrtimer+0x11 (__run_hrti=
mer+0x78)
[  171.891135]      #func    	    -259197 __run_hrtimer+0x11 (hrtimer_inter=
rupt+0xdd)
[  171.891143]      #func    	    -259197 ktime_get_update_offsets+0x11 (hr=
timer_interrupt+0x7a)
[  171.891151]  |   #end     0x80000001  -259198 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891160]  |   #begin   0x80000001  -259198 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891169]      #func    	    -259198 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.891177]      #func    	    -259198 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.891185]      #func    	    -259198 _raw_spin_lock+0x9 (hrtimer_inter=
rupt+0x6f)
[  171.891194]  |   #end     0x80000001  -259198 debug_smp_processor_id+0x9=
7 (hrtimer_interrupt+0x25)
[  171.891202]  |   #begin   0x80000001  -259198 debug_smp_processor_id+0x4=
3 (hrtimer_interrupt+0x25)
[  171.891211]      #func    	    -259198 hrtimer_interrupt+0x11 (smp_apic_=
timer_interrupt+0x71)
[  171.891219]  |   #end     0x80000001  -259198 debug_smp_processor_id+0x9=
7 (smp_apic_timer_interrupt+0x2d)
[  171.891227]  |   #begin   0x80000001  -259198 debug_smp_processor_id+0x4=
3 (smp_apic_timer_interrupt+0x2d)
[  171.891235]      #func    	    -259199 __rcu_read_unlock+0x9 (__atomic_n=
otifier_call_chain+0x45)
[  171.891244]      #func    	    -259199 notifier_call_chain+0xf (__atomic=
_notifier_call_chain+0x3d)
[  171.891252]      #func    	    -259199 __rcu_read_lock+0x4 (__atomic_not=
ifier_call_chain+0x25)
[  171.891259]      #func    	    -259199 __atomic_notifier_call_chain+0x9 =
(atomic_notifier_call_chain+0x14)
[  171.891267]      #func    	    -259199 atomic_notifier_call_chain+0x4 (e=
xit_idle+0x3e)
[  171.891276]      #func    	    -259199 exit_idle+0x4 (smp_apic_timer_int=
errupt+0x28)
[  171.891284]  |   #end     0x80000001  -259199 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891292]  |   #begin   0x80000001  -259199 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891301]      #func    	    -259199 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.891309]      #func    	    -259200 add_preempt_count+0x9 (irq_enter+=
0x5e)
[  171.891317]      #func    	    -259200 sub_preempt_count+0x4 (__local_bh=
_enable+0x99)
[  171.891325]      #func    	    -259200 __local_bh_enable+0x9 (_local_bh_=
enable+0x13)
[  171.891333]      #func    	    -259200 _local_bh_enable+0x4 (irq_enter+0=
x54)
[  171.891342]      #func    	    -259200 nr_iowait_cpu+0x4 (update_ts_time=
_stats+0x35)
[  171.891350]      #func    	    -259200 update_ts_time_stats+0xf (tick_no=
hz_stop_idle+0x2d)
[  171.891359]      #func    	    -259200 tick_nohz_stop_idle+0x9 (tick_che=
ck_idle+0x5b)
[  171.891367]      #func    	    -259200 ktime_get+0xd (tick_check_idle+0x=
44)
[  171.891375]      #func    	    -259201 tick_check_oneshot_broadcast+0x4 =
(tick_check_idle+0x21)
[  171.891384]      #func    	    -259201 tick_check_idle+0xd (irq_enter+0x=
4f)
[  171.891392]  |   #end     0x80000001  -259201 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891401]  |   #begin   0x80000001  -259201 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891409]      #func    	    -259201 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.891418]      #func    	    -259201 add_preempt_count+0x9 (local_bh_d=
isable+0x13)
[  171.891426]      #func    	    -259201 local_bh_disable+0x4 (irq_enter+0=
x48)
[  171.891434]  |   #end     0x80000001  -259201 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891443]  |   #begin   0x80000001  -259201 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891451]      #func    	    -259202 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.891460]      #func    	    -259202 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.891468]  |   #end     0x80000001  -259202 debug_smp_processor_id+0x9=
7 (rcu_idle_exit_common+0x41)
[  171.891476]  |   #begin   0x80000001  -259202 debug_smp_processor_id+0x4=
3 (rcu_idle_exit_common+0x41)
[  171.891484]      #func    	    -259202 rcu_idle_exit_common+0xb (rcu_irq=
_enter+0xa4)
[  171.891492]  |   #end     0x80000001  -259202 debug_smp_processor_id+0x9=
7 (rcu_irq_enter+0x54)
[  171.891500]  |   #begin   0x80000001  -259202 debug_smp_processor_id+0x4=
3 (rcu_irq_enter+0x54)
[  171.891508]      #func    	    -259202 rcu_irq_enter+0xd (irq_enter+0x1a)
[  171.891516]  |   #end     0x80000001  -259202 debug_smp_processor_id+0x9=
7 (irq_enter+0x13)
[  171.891525]  |   #begin   0x80000001  -259203 debug_smp_processor_id+0x4=
3 (irq_enter+0x13)
[  171.891533]      #func    	    -259203 irq_enter+0x9 (smp_apic_timer_int=
errupt+0x23)
[  171.891541]      #func    	    -259203 smp_apic_timer_interrupt+0x7 (__i=
pipe_do_IRQ+0x79)
[  171.891550]      #func    	    -259203 __ipipe_get_ioapic_irq_vector+0x4=
 (__ipipe_do_IRQ+0x24)
[  171.891558]      #func    	    -259203 __ipipe_do_IRQ+0x7 (__ipipe_do_sy=
nc_stage+0x160)
[  171.891567]  |   #end     0x80000000  -259203 hard_local_irq_enable+0x15=
 (__ipipe_do_sync_stage+0xe1)
[  171.891575]  |   +func    	    -259203 __ipipe_do_sync_stage+0xf (__ipip=
e_do_sync_pipeline+0x72)
[  171.891584]  |   +func    	    -259203 __ipipe_do_sync_pipeline+0x9 (__i=
pipe_dispatch_irq+0x1bf)
[  171.891592]  |  # func    	    -259204 __ipipe_set_irq_pending+0xd (xnin=
tr_host_tick+0x5f)
[  171.891601]  |  # func    	    -259204 xnintr_host_tick+0x9 (__xnpod_sch=
edule+0x125)
[  171.891609]  |  # func    	    -259204 xnsched_pick_next+0x11 (__xnpod_s=
chedule+0xf3)
[  171.891617]  |  # [ 2180] -<?>-   -1  -259204 __xnpod_schedule+0x88 (xnp=
od_schedule+0x36)
[  171.891625]  |  # func    	    -259204 __xnpod_schedule+0x14 (xnpod_sche=
dule+0x36)
[  171.891633]  |  # func    	    -259205 lapic_next_event+0x4 (ipipe_timer=
_set+0x8d)
[  171.891642]  |  # func    	    -259205 ipipe_timer_set+0x7 (xntimer_next=
_local_shot+0xab)
[  171.891650]  |  # event   tick@364559 -259205 xntimer_next_local_shot+0x=
a3 (xntimer_tick_aperiodic+0x13b)
[  171.891659]  |  # func    	    -259205 xntimer_next_local_shot+0x9 (xnti=
mer_tick_aperiodic+0x13b)
[  171.891667]  |  # func    	    -259205 xntimer_tick_aperiodic+0x11 (xnin=
tr_clock_handler+0xce)
[  171.891676]  |  # func    	    -259206 xnintr_clock_handler+0xd (__ipipe=
_dispatch_irq+0x178)
[  171.891684]  |   +func    	    -259206 lapic_itimer_ack+0x4 (__ipipe_ack=
_hrtimer_irq+0x73)
[  171.891693]  |   +func    	    -259206 __ipipe_ack_hrtimer_irq+0xd (__ip=
ipe_dispatch_irq+0xbf)
[  171.891701]  |   +func    	    -259206 __ipipe_dispatch_irq+0xb (__ipipe=
_handle_irq+0x108)
[  171.891710]  |   +func    	    -259206 __ipipe_handle_irq+0xb (apic_time=
r_interrupt+0x79)
[  171.891719]  |   +begin   0x000000ef  -259207 apic_timer_interrupt+0x6a =
(__ipipe_halt_root+0x50)
[  171.891727]  |   +end     0x8000000e  -260163 __ipipe_halt_root+0x4e (de=
fault_idle+0x4c)
[  171.891736]  |   #begin   0x80000000  -260163 __ipipe_halt_root+0x1b (de=
fault_idle+0x4c)
[  171.891745]      #func    	    -260163 __ipipe_halt_root+0x4 (default_id=
le+0x4c)
[  171.891753]  |   #end     0x80000001  -260163 debug_smp_processor_id+0x9=
7 (default_idle+0x1f)
[  171.891762]  |   #begin   0x80000001  -260163 debug_smp_processor_id+0x4=
3 (default_idle+0x1f)
[  171.891770]  |   #end     0x80000001  -260163 debug_smp_processor_id+0x9=
7 (default_idle+0xe)
[  171.891778]  |   #begin   0x80000001  -260163 debug_smp_processor_id+0x4=
3 (default_idle+0xe)
[  171.891787]      #func    	    -260163 default_idle+0x4 (cpu_idle+0xb8)
[  171.891795]  |   #end     0x80000001  -260163 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891804]  |   #begin   0x80000001  -260164 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.891812]      #func    	    -260164 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.891821]      #func    	    -260164 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.891829]  |   #end     0x80000001  -260164 debug_smp_processor_id+0x9=
7 (rcu_idle_enter_common+0x93)
[  171.891837]  |   #begin   0x80000001  -260164 debug_smp_processor_id+0x4=
3 (rcu_idle_enter_common+0x93)
[  171.891845]      #func    	    -260164 rcu_idle_enter_common+0xd (rcu_id=
le_enter+0xca)
[  171.891853]  |   #end     0x80000001  -260164 debug_smp_processor_id+0x9=
7 (rcu_idle_enter+0x54)
[  171.891862]  |   #begin   0x80000001  -260164 debug_smp_processor_id+0x4=
3 (rcu_idle_enter+0x54)
[  171.891870]      #func    	    -260164 rcu_idle_enter+0xd (cpu_idle+0xb2)
[  171.891878]      #func    	    -260164 __rcu_read_unlock+0x9 (__atomic_n=
otifier_call_chain+0x45)
[  171.891886]      #func    	    -260165 notifier_call_chain+0xf (__atomic=
_notifier_call_chain+0x3d)
[  171.891894]      #func    	    -260165 __rcu_read_lock+0x4 (__atomic_not=
ifier_call_chain+0x25)
[  171.891902]      #func    	    -260165 __atomic_notifier_call_chain+0x9 =
(atomic_notifier_call_chain+0x14)
[  171.891910]      #func    	    -260165 atomic_notifier_call_chain+0x4 (e=
nter_idle+0x25)
[  171.891918]      #func    	    -260165 enter_idle+0x4 (cpu_idle+0xad)
[  171.891927]      +func    	    -260165 local_touch_nmi+0x4 (cpu_idle+0x9=
1)
[  171.891935]  |   +end     0x80000001  -260165 debug_smp_processor_id+0x9=
7 (cpu_idle+0x7d)
[  171.891943]  |   +begin   0x80000001  -260165 debug_smp_processor_id+0x4=
3 (cpu_idle+0x7d)
[  171.891952]  |   +end     0x80000000  -260165 hard_local_irq_enable+0x15=
 (ipipe_unstall_root+0x2d)
[  171.891960]  |   #func    	    -260165 ipipe_root_only+0x9 (ipipe_unstal=
l_root+0x13)
[  171.891969]  |   #begin   0x80000000  -260166 hard_local_irq_disable+0x1=
6 (ipipe_unstall_root+0xe)
[  171.891977]      #func    	    -260166 ipipe_unstall_root+0x4 (ipipe_res=
tore_root+0x39)
[  171.891986]  |   #end     0x80000001  -260166 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.891994]  |   #begin   0x80000001  -260166 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892003]      #func    	    -260166 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.892011]      #func    	    -260166 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.892019]  |   #end     0x80000001  -260166 debug_smp_processor_id+0x9=
7 (rcu_idle_exit_common+0x41)
[  171.892027]  |   #begin   0x80000001  -260166 debug_smp_processor_id+0x4=
3 (rcu_idle_exit_common+0x41)
[  171.892036]      #func    	    -260166 rcu_idle_exit_common+0xb (rcu_idl=
e_exit+0xc4)
[  171.892044]  |   #end     0x80000001  -260166 debug_smp_processor_id+0x9=
7 (rcu_idle_exit+0x54)
[  171.892052]  |   #begin   0x80000001  -260167 debug_smp_processor_id+0x4=
3 (rcu_idle_exit+0x54)
[  171.892060]      +func    	    -260167 rcu_idle_exit+0xd (cpu_idle+0xbd)
[  171.892068]  |   +end     0x80000001  -260167 debug_smp_processor_id+0x9=
7 (default_idle+0x74)
[  171.892076]  |   +begin   0x80000001  -260167 debug_smp_processor_id+0x4=
3 (default_idle+0x74)
[  171.892085]  |   +end     0x80000001  -260167 debug_smp_processor_id+0x9=
7 (default_idle+0x68)
[  171.892093]  |   +begin   0x80000001  -260167 debug_smp_processor_id+0x4=
3 (default_idle+0x68)
[  171.892101]  |   +end     0x000000ef  -260167 apic_timer_interrupt+0x8c =
(__ipipe_halt_root+0x50)
[  171.892110]      #func    	    -260168 sub_preempt_count+0x4 (irq_exit+0=
xc0)
[  171.892119]  |   #end     0x80000001  -260168 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.892127]  |   #begin   0x80000001  -260168 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892136]      #func    	    -260168 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.892144]      #func    	    -260168 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.892152]  |   #end     0x80000001  -260168 debug_smp_processor_id+0x9=
7 (rcu_idle_enter_common+0x93)
[  171.892161]  |   #begin   0x80000001  -260168 debug_smp_processor_id+0x4=
3 (rcu_idle_enter_common+0x93)
[  171.892169]      #func    	    -260169 rcu_idle_enter_common+0xd (rcu_ir=
q_exit+0xa6)
[  171.892177]  |   #end     0x80000001  -260169 debug_smp_processor_id+0x9=
7 (rcu_irq_exit+0x54)
[  171.892185]  |   #begin   0x80000001  -260169 debug_smp_processor_id+0x4=
3 (rcu_irq_exit+0x54)
[  171.892193]      #func    	    -260169 rcu_irq_exit+0xd (irq_exit+0xb6)
[  171.892202]      #func    	    -260169 rcu_needs_cpu+0x4 (tick_nohz_stop=
_sched_tick+0x135)
[  171.892210]      #func    	    -260169 timekeeping_max_deferment+0x4 (ti=
ck_nohz_stop_sched_tick+0x11c)
[  171.892218]  |   #end     0x80000001  -260169 debug_smp_processor_id+0x9=
7 (__cycles_2_ns+0x11)
[  171.892226]  |   #begin   0x80000001  -260169 debug_smp_processor_id+0x4=
3 (__cycles_2_ns+0x11)
[  171.892234]  |   #end     0x80000001  -260169 debug_smp_processor_id+0x9=
7 (sched_clock_idle_sleep_event+0x9)
[  171.892242]  |   #begin   0x80000001  -260170 debug_smp_processor_id+0x4=
3 (sched_clock_idle_sleep_event+0x9)
[  171.892250]      #func    	    -260170 ktime_get+0xd (tick_nohz_stop_sch=
ed_tick+0x4e)
[  171.892259]  |   #end     0x80000001  -260170 debug_smp_processor_id+0x9=
7 (tick_nohz_stop_sched_tick+0x3c)
[  171.892267]  |   #begin   0x80000001  -260170 debug_smp_processor_id+0x4=
3 (tick_nohz_stop_sched_tick+0x3c)
[  171.892276]  |   #end     0x80000001  -260170 debug_smp_processor_id+0x9=
7 (tick_nohz_stop_sched_tick+0x22)
[  171.892284]  |   #begin   0x80000001  -260170 debug_smp_processor_id+0x4=
3 (tick_nohz_stop_sched_tick+0x22)
[  171.892293]      #func    	    -260170 tick_nohz_stop_sched_tick+0x11 (t=
ick_nohz_irq_exit+0x32)
[  171.892301]  |   #end     0x80000001  -260170 debug_smp_processor_id+0x9=
7 (tick_nohz_irq_exit+0x1a)
[  171.892310]  |   #begin   0x80000001  -260170 debug_smp_processor_id+0x4=
3 (tick_nohz_irq_exit+0x1a)
[  171.892318]      #func    	    -260170 tick_nohz_irq_exit+0x9 (irq_exit+=
0xb1)
[  171.892327]      #func    	    -260171 idle_cpu+0x4 (irq_exit+0x81)
[  171.892335]  |   #end     0x80000001  -260171 debug_smp_processor_id+0x9=
7 (irq_exit+0x7a)
[  171.892343]  |   #begin   0x80000001  -260171 debug_smp_processor_id+0x4=
3 (irq_exit+0x7a)
[  171.892351]  |   #end     0x80000001  -260171 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.892360]  |   #begin   0x80000001  -260171 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892369]      #func    	    -260171 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.892377]      #func    	    -260171 ipipe_restore_root+0x9 (do_softir=
q+0xb6)
[  171.892385]      #func    	    -260171 sub_preempt_count+0x4 (__local_bh=
_enable+0x99)
[  171.892393]      #func    	    -260171 __local_bh_enable+0x9 (__do_softi=
rq+0x1b6)
[  171.892402]      +func    	    -260172 rcu_bh_qs+0x4 (__do_softirq+0x162)
[  171.892410]      +func    	    -260172 __rcu_read_unlock+0x9 (rebalance_=
domains+0x143)
[  171.892418]      +func    	    -260172 msecs_to_jiffies+0x4 (rebalance_d=
omains+0x85)
[  171.892426]      +func    	    -260172 idle_cpu+0x4 (update_sd_lb_stats+=
0x2a3)
[  171.892434]      +func    	    -260172 scale_rt_power+0x4 (update_group_=
power+0xdd)
[  171.892442]      +func    	    -260172 msecs_to_jiffies+0x4 (update_grou=
p_power+0x26)
[  171.892450]      +func    	    -260173 update_group_power+0xb (update_sd=
_lb_stats+0x325)
[  171.892458]      +func    	    -260173 idle_cpu+0x4 (update_sd_lb_stats+=
0x2a3)
[  171.892466]      +func    	    -260173 idle_cpu+0x4 (update_sd_lb_stats+=
0x151)
[  171.892473]      +func    	    -260173 group_balance_cpu+0x4 (update_sd_=
lb_stats+0xe3)
[  171.892482]      +func    	    -260173 find_busiest_group+0xb (load_bala=
nce+0xb7)
[  171.892490]  |   +end     0x80000001  -260173 debug_smp_processor_id+0x9=
7 (load_balance+0x42)
[  171.892498]  |   +begin   0x80000001  -260173 debug_smp_processor_id+0x4=
3 (load_balance+0x42)
[  171.892506]      +func    	    -260174 load_balance+0x14 (rebalance_doma=
ins+0xe9)
[  171.892514]      +func    	    -260174 msecs_to_jiffies+0x4 (rebalance_d=
omains+0x85)
[  171.892522]      +func    	    -260174 __rcu_read_lock+0x4 (rebalance_do=
mains+0x49)
[  171.892530]      +func    	    -260174 __rcu_read_unlock+0x9 (update_sha=
res+0xf1)
[  171.892538]      +func    	    -260174 __rcu_read_lock+0x4 (update_share=
s+0x34)
[  171.892545]      +func    	    -260174 update_shares+0x11 (rebalance_dom=
ains+0x44)
[  171.892553]      +func    	    -260174 rebalance_domains+0x11 (run_rebal=
ance_domains+0x4b)
[  171.892561]  |   +end     0x80000001  -260174 debug_smp_processor_id+0x9=
7 (run_rebalance_domains+0x25)
[  171.892569]  |   +begin   0x80000001  -260174 debug_smp_processor_id+0x4=
3 (run_rebalance_domains+0x25)
[  171.892577]      +func    	    -260175 run_rebalance_domains+0x11 (__do_=
softirq+0xdd)
[  171.892585]      +func    	    -260175 rcu_bh_qs+0x4 (__do_softirq+0x162)
[  171.892594]      +func    	    -260175 sub_preempt_count+0x4 (_raw_spin_=
unlock_irq+0x1c)
[  171.892602]  |   +end     0x80000000  -260175 hard_local_irq_enable+0x15=
 (ipipe_unstall_root+0x2d)
[  171.892611]  |   #func    	    -260175 ipipe_root_only+0x9 (ipipe_unstal=
l_root+0x13)
[  171.892619]  |   #begin   0x80000000  -260175 hard_local_irq_disable+0x1=
6 (ipipe_unstall_root+0xe)
[  171.892627]      #func    	    -260175 ipipe_unstall_root+0x4 (_raw_spin=
_unlock_irq+0x12)
[  171.892636]      #func    	    -260175 _raw_spin_unlock_irq+0x4 (run_tim=
er_softirq+0x2b5)
[  171.892645]  |   #end     0x80000001  -260175 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.892653]  |   #begin   0x80000001  -260176 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892662]      #func    	    -260176 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.892670]      #func    	    -260176 add_preempt_count+0x9 (_raw_spin_=
lock_irq+0x32)
[  171.892678]      +func    	    -260176 _raw_spin_lock_irq+0x9 (run_timer=
_softirq+0x3d)
[  171.892687]      +func    	    -260176 hrtimer_run_pending+0xd (run_time=
r_softirq+0x24)
[  171.892695]      +func    	    -260176 run_timer_softirq+0x11 (__do_soft=
irq+0xdd)
[  171.892703]  |   +end     0x80000000  -260176 hard_local_irq_enable+0x15=
 (ipipe_unstall_root+0x2d)
[  171.892712]  |   #func    	    -260176 ipipe_root_only+0x9 (ipipe_unstal=
l_root+0x13)
[  171.892720]  |   #begin   0x80000000  -260176 hard_local_irq_disable+0x1=
6 (ipipe_unstall_root+0xe)
[  171.892729]      #func    	    -260177 ipipe_unstall_root+0x4 (__do_soft=
irq+0x66)
[  171.892737]  |   #end     0x80000001  -260177 debug_smp_processor_id+0x9=
7 (__do_softirq+0x37)
[  171.892745]  |   #begin   0x80000001  -260177 debug_smp_processor_id+0x4=
3 (__do_softirq+0x37)
[  171.892754]  |   #end     0x80000001  -260177 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.892762]  |   #begin   0x80000001  -260177 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892771]      #func    	    -260177 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.892779]      #func    	    -260177 add_preempt_count+0x9 (__do_softi=
rq+0x29)
[  171.892787]      #func    	    -260177 __do_softirq+0x11 (call_softirq+0=
x1e)
[  171.892795]      #func    	    -260177 do_softirq+0x7 (irq_exit+0x44)
[  171.892803]      #func    	    -260177 sub_preempt_count+0x4 (irq_exit+0=
x13)
[  171.892812]      #func    	    -260178 irq_exit+0x4 (smp_apic_timer_inte=
rrupt+0x76)
[  171.892820]  |   #end     0x80000000  -260178 hard_local_irq_enable+0x15=
 (__ipipe_restore_head+0x73)
[  171.892828]  |  *#func    	    -260178 __ipipe_restore_head+0x9 (ipipe_r=
estore_pipeline_head+0x5b)
[  171.892837]  |  *#func    	    -260178 lapic_next_event+0x4 (ipipe_timer=
_set+0x8d)
[  171.892845]  |  *#func    	    -260178 ipipe_timer_set+0x7 (xntimer_next=
_local_shot+0xab)
[  171.892854]  |  *#event   tick@-259211 -260178 xntimer_next_local_shot+0=
xa3 (xntimer_start_aperiodic+0x124)
[  171.892863]  |  *#func    	    -260178 xntimer_next_local_shot+0x9 (xnti=
mer_start_aperiodic+0x124)
[  171.892871]  |  *#func    	    -260179 xnarch_ns_to_tsc+0x4 (xntimer_sta=
rt_aperiodic+0x65)
[  171.892880]  |  *#func    	    -260179 xntimer_start_aperiodic+0x11 (xna=
rch_next_htick_shot+0x55)
[  171.892888]  |   #begin   0x80000000  -260179 ipipe_test_and_stall_pipel=
ine_head+0x16 (__xnlock_get_irqsave+0x23)
[  171.892896]      #func    	    -260179 xnarch_next_htick_shot+0x7 (clock=
events_program_event+0xa2)
[  171.892904]      #func    	    -260179 ktime_get+0xd (clockevents_progra=
m_event+0x69)
[  171.892913]      #func    	    -260179 clockevents_program_event+0xd (ti=
ck_program_event+0x24)
[  171.892921]      #func    	    -260179 tick_program_event+0x4 (hrtimer_i=
nterrupt+0x123)
[  171.892930]      #func    	    -260180 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.892938]      #func    	    -260180 _raw_spin_unlock+0x4 (hrtimer_int=
errupt+0x110)
[  171.892946]      #func    	    -260180 enqueue_hrtimer+0xd (__run_hrtime=
r+0x156)
[  171.892955]  |   #end     0x80000001  -260180 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.892963]  |   #begin   0x80000001  -260180 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.892972]      #func    	    -260180 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.892980]      #func    	    -260180 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.892988]      #func    	    -260180 _raw_spin_lock+0x9 (__run_hrtimer=
+0x13b)
[  171.892997]      #func    	    -260180 hrtimer_forward+0x4 (tick_sched_t=
imer+0x80)
[  171.893005]  |   #end     0x80000001  -260181 debug_smp_processor_id+0x9=
7 (profile_tick+0x3d)
[  171.893013]  |   #begin   0x80000001  -260181 debug_smp_processor_id+0x4=
3 (profile_tick+0x3d)
[  171.893021]      #func    	    -260181 profile_tick+0x7 (tick_sched_time=
r+0x6e)
[  171.893029]      #func    	    -260181 run_posix_cpu_timers+0x11 (update=
_process_times+0x6f)
[  171.893037]      #func    	    -260181 idle_cpu+0x4 (trigger_load_balanc=
e+0x61)
[  171.893045]  |   #end     0x80000001  -260181 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.893054]  |   #begin   0x80000001  -260181 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.893062]      #func    	    -260181 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.893071]      #func    	    -260181 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.893079]      #func    	    -260182 __raise_softirq_irqoff+0x7 (raise=
_softirq_irqoff+0x9)
[  171.893088]      #func    	    -260182 raise_softirq+0x9 (trigger_load_b=
alance+0x53)
[  171.893096]      #func    	    -260182 trigger_load_balance+0x11 (schedu=
ler_tick+0x114)
[  171.893104]  |   #end     0x80000001  -260182 debug_smp_processor_id+0x9=
7 (perf_event_task_tick+0x1d)
[  171.893113]  |   #begin   0x80000001  -260182 debug_smp_processor_id+0x4=
3 (perf_event_task_tick+0x1d)
[  171.893121]      #func    	    -260182 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.893129]      #func    	    -260182 _raw_spin_unlock+0x4 (scheduler_t=
ick+0xc2)
[  171.893138]      #func    	    -260182 task_tick_idle+0x4 (scheduler_tic=
k+0xba)
[  171.893146]      #func    	    -260182 sched_avg_update+0x4 (__update_cp=
u_load+0xc8)
[  171.893154]      #func    	    -260183 __update_cpu_load+0xb (scheduler_=
tick+0x63)
[  171.893162]  |   #end     0x80000001  -260183 debug_smp_processor_id+0x9=
7 (__cycles_2_ns+0x11)
[  171.893170]  |   #begin   0x80000001  -260183 debug_smp_processor_id+0x4=
3 (__cycles_2_ns+0x11)
[  171.893179]      #func    	    -260183 update_rq_clock+0x9 (scheduler_ti=
ck+0x47)
[  171.893187]  |   #end     0x80000001  -260183 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.893196]  |   #begin   0x80000001  -260183 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.893204]      #func    	    -260183 ipipe_root_only+0x9 (add_preempt_=
count+0x15)
[  171.893212]      #func    	    -260183 add_preempt_count+0x9 (_raw_spin_=
lock+0x1b)
[  171.893221]      #func    	    -260183 _raw_spin_lock+0x9 (scheduler_tic=
k+0x3f)
[  171.893229]  |   #end     0x80000001  -260184 debug_smp_processor_id+0x9=
7 (scheduler_tick+0x1e)
[  171.893238]  |   #begin   0x80000001  -260184 debug_smp_processor_id+0x4=
3 (scheduler_tick+0x1e)
[  171.893246]      #func    	    -260184 scheduler_tick+0xd (update_proces=
s_times+0x67)
[  171.893255]  |   #end     0x80000001  -260184 debug_smp_processor_id+0x9=
7 (irq_work_run+0x17)
[  171.893263]  |   #begin   0x80000001  -260184 debug_smp_processor_id+0x4=
3 (irq_work_run+0x17)
[  171.893272]      #func    	    -260184 printk_tick+0x7 (update_process_t=
imes+0x46)
[  171.893280]      #func    	    -260184 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0x13b)
[  171.893288]      #func    	    -260184 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0x11c)
[  171.893296]      #func    	    -260185 __rcu_pending+0x11 (rcu_check_cal=
lbacks+0xfd)
[  171.893304]  |   #end     0x80000001  -260185 debug_smp_processor_id+0x9=
7 (rcu_is_cpu_rrupt_from_idle+0x1a)
[  171.893312]  |   #begin   0x80000001  -260185 debug_smp_processor_id+0x4=
3 (rcu_is_cpu_rrupt_from_idle+0x1a)
[  171.893321]      #func    	    -260185 rcu_is_cpu_rrupt_from_idle+0x9 (r=
cu_check_callbacks+0x27)
[  171.893329]      #func    	    -260185 rcu_check_callbacks+0x7 (update_p=
rocess_times+0x41)
[  171.893337]  |   #end     0x80000001  -260185 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.893345]  |   #begin   0x80000001  -260185 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.893354]      #func    	    -260185 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.893362]      #func    	    -260185 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.893370]      #func    	    -260186 __raise_softirq_irqoff+0x7 (raise=
_softirq_irqoff+0x9)
[  171.893379]      #func    	    -260186 raise_softirq+0x9 (run_local_time=
rs+0x18)
[  171.893387]  |   #end     0x80000001  -260186 debug_smp_processor_id+0x9=
7 (hrtimer_run_queues+0x22)
[  171.893395]  |   #begin   0x80000001  -260186 debug_smp_processor_id+0x4=
3 (hrtimer_run_queues+0x22)
[  171.893404]      #func    	    -260186 hrtimer_run_queues+0x11 (run_loca=
l_timers+0xe)
[  171.893412]      #func    	    -260186 run_local_timers+0x4 (update_proc=
ess_times+0x36)
[  171.893420]  |   #end     0x80000001  -260186 debug_smp_processor_id+0x9=
7 (account_idle_time+0x37)
[  171.893428]  |   #begin   0x80000001  -260186 debug_smp_processor_id+0x4=
3 (account_idle_time+0x37)
[  171.893435]  |   #end     0x80000001  -260186 debug_smp_processor_id+0x9=
7 (account_idle_time+0x28)
[  171.893443]  |   #begin   0x80000001  -260187 debug_smp_processor_id+0x4=
3 (account_idle_time+0x28)
[  171.893451]      #func    	    -260187 account_idle_time+0xd (account_pr=
ocess_tick+0x8e)
[  171.893459]  |   #end     0x80000001  -260187 debug_smp_processor_id+0x9=
7 (account_process_tick+0x23)
[  171.893467]  |   #begin   0x80000001  -260187 debug_smp_processor_id+0x4=
3 (account_process_tick+0x23)
[  171.893476]      #func    	    -260187 account_process_tick+0xb (update_=
process_times+0x31)
[  171.893484]  |   #end     0x80000001  -260187 debug_smp_processor_id+0x9=
7 (update_process_times+0x23)
[  171.893492]  |   #begin   0x80000001  -260187 debug_smp_processor_id+0x4=
3 (update_process_times+0x23)
[  171.893501]      #func    	    -260187 update_process_times+0xd (update_=
root_process_times+0x2a)
[  171.893509]      #func    	    -260187 update_root_process_times+0x9 (ti=
ck_sched_timer+0x64)
[  171.893517]      #func    	    -260188 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.893526]      #func    	    -260188 _raw_spin_unlock+0x4 (tick_do_upd=
ate_jiffies64+0xb0)
[  171.893535]      #func    	    -260188 calc_global_load+0x5 (do_timer+0x=
4d1)
[  171.893543]  |   #end     0x80000001  -260188 hard_local_irq_restore+0x1=
b (ipipe_root_only+0x51)
[  171.893551]  |   #begin   0x80000001  -260188 hard_local_irq_save+0x1b (=
ipipe_root_only+0x13)
[  171.893559]      #func    	    -260188 ipipe_root_only+0x9 (ipipe_restor=
e_root+0x16)
[  171.893568]      #func    	    -260188 ipipe_restore_root+0x9 (arch_loca=
l_irq_restore+0x14)
[  171.893576]      #func    	    -260188 sub_preempt_count+0x4 (_raw_spin_=
unlock+0x17)
[  171.893584]      #func    	    -260188 _raw_spin_unlock+0x4 (write_sequn=
lock+0xf)
[  171.893593]  |   #end     0x80000001  -260188 hard_local_irq_restore+0x1=
b (__ipipe_notify_kevent+0x71)
[  171.893602] ------------[ cut here ]------------
[  171.893605] WARNING: at kernel/ipipe/core.c:1661 __ipipe_spin_unlock_deb=
ug+0x32/0x3b()
[  171.893606] Hardware name: To Be Filled By O.E.M.
[  171.893606] Modules linked in: rt_eepro100(O) rtudp(O) rttcp(O) rtipv4(O=
) rtnet(O) parport_pc ppdev lp parport bridge stp llc bnep rfcomm bluetooth=
 rfkill binfmt_misc fuse loop snd_hda_codec_hdmi snd_hda_codec_realtek rade=
on snd_hda_intel snd_seq snd_hda_codec snd_hwdep snd_pcm snd_timer snd_seq_=
device snd sp5100_tco ttm drm_kms_helper kvm_amd soundcore edac_core kvm xh=
ci_hcd crc32c_intel drm i2c_piix4 snd_page_alloc i2c_algo_bit edac_mce_amd =
k10temp fam15h_power i2c_core hid_generic psmouse pcspkr microcode mxm_wmi =
tpm_tis tpm evdev tpm_bios serio_raw button wmi ext4 mbcache jbd2 crc16 usb=
hid hid sd_mod crc_t10dif ata_generic ohci_hcd pata_atiixp ahci libahci lib=
ata firewire_ohci firewire_core crc_itu_t ehci_hcd r8169 mii usbcore scsi_m=
od usb_common [last unloaded: e100]
[  171.893666] Pid: 0, comm: swapper/3 Tainted: G           O 3.5.7-xenomai=
-2.6.2.1 #7
[  171.893667] Call Trace:
[  171.893668] ---[ end trace a856cfe41a1f61c7 ]---
[  171.876822]  |  #*func    	        0 ipipe_prepare_panic+0x7 (ipipe_root=
_only+0x5d)
[  248.054441] ------------[ cut here ]------------
[  248.109555] WARNING: at include/linux/ipipe_debug.h:88 ipipe_restore_pip=
eline_head+0x2d/0x6a [rt_eepro100]()
[  248.226926] Hardware name: To Be Filled By O.E.M.
[  248.283071] Modules linked in: rt_eepro100(O) rtudp(O) rttcp(O) rtipv4(O=
) rtnet(O) parport_pc ppdev lp parport bridge stp llc bnep rfcomm bluetooth=
 rfkill binfmt_misc fuse loop snd_hda_codec_hdmi snd_hda_codec_realtek rade=
on snd_hda_intel snd_seq snd_hda_codec snd_hwdep snd_pcm snd_timer snd_seq_=
device snd sp5100_tco ttm drm_kms_helper kvm_amd soundcore edac_core kvm xh=
ci_hcd crc32c_intel drm i2c_piix4 snd_page_alloc i2c_algo_bit edac_mce_amd =
k10temp fam15h_power i2c_core hid_generic psmouse pcspkr microcode mxm_wmi =
tpm_tis tpm evdev tpm_bios serio_raw button wmi ext4 mbcache jbd2 crc16 usb=
hid hid sd_mod crc_t10dif ata_generic ohci_hcd pata_atiixp ahci libahci lib=
ata firewire_ohci firewire_core crc_itu_t ehci_hcd r8169 mii usbcore scsi_m=
od usb_common [last unloaded: e100]
[  249.108626] Pid: 0, comm: swapper/3 Tainted: G        W  O 3.5.7-xenomai=
-2.6.2.1 #7
[  249.200054] Call Trace:
[  249.229216] ---[ end trace a856cfe41a1f61c8 ]---
[  291.281270] BUG: scheduling while atomic: make/3151/0x00000003
[  291.350911] Modules linked in: rt_eepro100(O) rtudp(O) rttcp(O) rtipv4(O=
) rtnet(O) parport_pc ppdev lp parport bridge stp llc bnep rfcomm bluetooth=
 rfkill binfmt_misc fuse loop snd_hda_codec_hdmi snd_hda_codec_realtek rade=
on snd_hda_intel snd_seq snd_hda_codec snd_hwdep snd_pcm snd_timer snd_seq_=
device snd sp5100_tco ttm drm_kms_helper kvm_amd soundcore edac_core kvm xh=
ci_hcd crc32c_intel drm i2c_piix4 snd_page_alloc i2c_algo_bit edac_mce_amd =
k10temp fam15h_power i2c_core hid_generic psmouse pcspkr microcode mxm_wmi =
tpm_tis tpm evdev tpm_bios serio_raw button wmi ext4 mbcache jbd2 crc16 usb=
hid hid sd_mod crc_t10dif ata_generic ohci_hcd pata_atiixp ahci libahci lib=
ata firewire_ohci firewire_core crc_itu_t ehci_hcd r8169 mii usbcore scsi_m=
od usb_common [last unloaded: e100]
[  292.176469] Pid: 3151, comm: make Tainted: G        W  O 3.5.7-xenomai-2=
.6.2.1 #7
[  292.265821] Call Trace:
[  292.294987]  [<ffffffff8105a1e1>] __schedule_bug+0x5f/0x6b
[  292.360470]  [<ffffffff813c2b52>] __schedule+0xdf/0x4f3
[  292.422840]  [<ffffffff813c30ae>] schedule+0x1c/0x1e
[  292.482098]  [<ffffffff81036410>] do_wait+0x1c4/0x238
[  292.542394]  [<ffffffff81036522>] sys_wait4+0x9e/0xc1
[  292.602688]  [<ffffffff8101bd39>] ? __ipipe_syscall_root+0x12/0xab
[  292.676473]  [<ffffffff8103418d>] ? wait_noreap_copyout+0x11a/0x11a
[  292.751298]  [<ffffffff813ca086>] system_call_fastpath+0x16/0x1b
[  294.844646] Xenomai: watchdog triggered -- killing runaway thread 'rtnet=
-rtpc'
[  294.930985] Xenomai: assertion failed at kernel/xenomai/nucleus/pod.c:23=
59 (xnthread_lock_count(curr) > 0)
[  294.966416] Xenomai: stuck on nucleus lock ffffffff8162db50
[  294.966416] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  294.966416] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  294.966425]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  294.966432]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
[  294.966440] Call Trace:
[  294.966443]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  294.966450]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  294.966455]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  294.966461]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  294.966466]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  294.966471]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  294.966477]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  294.966482]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  294.966489]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  294.966494]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  294.966498]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  294.966502]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  294.966507]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  294.966859] Xenomai: stuck on nucleus lock ffffffff8162db50
[  294.966859] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  294.966859] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  294.966861]  ffff88042a4cfca8 00000000000000c9 ffffffff8162db50 00000000=
00000004
[  294.966869]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0
[  294.966876]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  294.966884] Call Trace:
[  294.966887]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  294.966894]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  294.966901]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  294.966906]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  294.966911]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  294.966917]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  294.966922]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  294.966929]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  294.966934]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  294.966938]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  294.966943]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  294.966948]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  295.052783] Xenomai: stuck on nucleus lock ffffffff8162db50
[  295.052783] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  295.052783] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  295.052784]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  295.052792]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  295.052799]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  295.052806] Call Trace:
[  295.052809]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  295.052813]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  295.052820]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  295.052825]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  295.052830]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  295.052835]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  295.052839]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  295.052844]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  295.052850]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  295.052854]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  295.052858]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  295.052863]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  295.052868]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  295.052875]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  295.052879]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  295.052883]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  295.052888]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  295.052893]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  295.053112] Xenomai: stuck on nucleus lock ffffffff8162db50
[  295.053112] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  295.053112] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  295.053114]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  295.053122]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  295.053129]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  295.053136] Call Trace:
[  295.053176] Xenomai: stuck on nucleus lock ffffffff8162db50
[  295.053176] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  295.053176] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  295.053179] Xenomai: stuck on nucleus lock ffffffff8162db50
[  295.053179] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  295.053179] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  295.053180]  ffffffff81603ba8 ffff88042a4c3b98 00000000000000c5 00000000=
000000c5 ffffffff8162db50 ffffffff8162db50 0000000000000000 0000000000000001
[  295.053190] =

[  295.053191]  0000000000000000 0000000000000000 ffffffff814c59c4 ffffffff=
814c59c4 0000000000000892 0000000000000892 ffffffff81603bf0 ffff88042a4c3be0
[  295.053201] =

[  295.053202]  ffffffff81004d80 ffffffff81004d80 ffffffff81603c60 ffff8804=
2a4c3c50 ffffffff810cf862 ffffffff810cf862 ffffffff814c59c4 ffffffff814c59c4
[  295.053211] =

[  295.053212] Call Trace:
[  295.053213] Call Trace:
[  295.053215]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  295.053223]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  295.053224]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  295.053229]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  295.053230]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  295.053233]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  295.053236]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  295.053239]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  295.053242]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  295.053245]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  295.053248]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  295.053252]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  295.053258]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  295.053259]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  295.053266]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  295.053266]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  295.053270]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  295.053272]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  295.053277]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  295.053278]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  295.053280]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  295.053284]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  295.053287]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  295.053290]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  295.053294]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  295.053297]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  295.053300]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  295.053304]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  295.053307]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  295.053312]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  295.053313]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  295.053319]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  295.053320]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  295.053325]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  295.053325]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  295.053329]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  295.053332]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  295.053336]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  295.053341]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  295.053345]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  295.168604] Xenomai: stuck on nucleus lock ffffffff8162db50
[  295.168604] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  295.168604] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  295.168606]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  295.168617]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  295.168628]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  295.168639] Call Trace:
[  295.168643]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  295.168650]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  295.168661]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  295.168670]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  295.168678]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  295.168686]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  295.168693]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  295.168701]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  295.168711]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  295.168717]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  295.168724]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  295.168732]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  295.168740]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  295.168750]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  295.168758]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  295.168765]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  295.168770]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  295.168778]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  294.966419]  ffff88042a4dfca8 00000000000000c9 ffffffff8162db50 00000000=
00000007
[  305.840113] Xenomai: Unbalanced lock/unlock[  305.976270] =

[  305.976270]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  306.058359] >  0  0       -1      0        00500080  ROOT/0
[  306.124879] >  1  0       -1      0        00500080  ROOT/1
[  306.191402] >  2  0       -1      0        00500080  ROOT/2
[  306.257924] >  3  0       -1      0        00500080  ROOT/3
[  306.324444]    3  0       98      0        00000082  rtnet-stack
[  306.396154] >  4  0       -1      0        00500080  ROOT/4
[  306.462678]    5  0       -1      0        00500088  ROOT/5
[  306.529199] >  5  0        1      0        00000080  rttcp timerwheel
[  306.606097] >  6  0       -1      0        00500080  ROOT/6
[  306.672620] >  7  0       -1      0        00500080  ROOT/7
[  306.739141] Master time base: clock=3D1407555687363
[  306.795286] Current CPU: #3
[  306.828599]  ffff880427905ca8 0000000000000000 ffff88041ec70220 ffff8804=
1ec70418
[  306.917329]  ffff88041ec70000 ffff88041ed88e80 ffff8800bdc7f0a0 ffff8804=
27905cf0
[  307.006083]  ffffffff81004d80 ffff880427905d00 ffffffff810d1e44 ffff8804=
27905d10
[  307.094789] Call Trace:
[  347.610767] Xenomai: stuck on nucleus lock ffffffff8162db50
[  347.610767] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  347.610767] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.649378] Xenomai: stuck on nucleus lock ffffffff8162db50
[  347.649378] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  347.649378] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.649386]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0
[  347.649393]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  347.649400] Call Trace:
[  347.649403]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  347.649407]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  347.649414]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  347.649419]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  347.649423]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  347.649428]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  347.649433]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  347.649440]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  347.649444]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  347.649449]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  347.649453]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  347.649458]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  347.735753] Xenomai: stuck on nucleus lock ffffffff8162db50
[  347.735753] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  347.735753] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.735754]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  347.735762]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  347.735769]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  347.735777] Call Trace:
[  347.778750] Xenomai: stuck on nucleus lock ffffffff8162db50
[  347.778750] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  347.778750] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.778752]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  347.778763]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  347.778773]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  347.778783] Call Trace:
[  347.778788]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  347.778794]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  347.778804]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  347.778812]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  347.778820]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  347.778828]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  347.778835]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  347.778842]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  347.778851]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  347.778856]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  347.778863]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  347.778871]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  347.778879]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  347.778889]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  347.778897]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  347.778903]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  347.778910]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  347.778917]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  347.843704] Xenomai: stuck on nucleus lock ffffffff8162db50
[  347.843704] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  347.843704] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.843706]  ffff88042a4c3b98[  347.843708] Xenomai: stuck on nucleus lo=
ck ffffffff8162db50
[  347.843708] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  347.843708] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  347.843710]  00000000000000c5 ffffffff81603ba8 ffffffff8162db50 00000000=
000000c5 0000000000000001 ffffffff8162db50
[  347.843717]  0000000000000000 0000000000000000
[  347.843720]  ffffffff814c59c4 0000000000000000 0000000000000892 ffffffff=
814c59c4 ffff88042a4c3be0 0000000000000892
[  347.843728]  ffffffff81603bf0 ffffffff81004d80
[  347.843731]  ffff88042a4c3c50 ffffffff81004d80 ffffffff810cf862 ffffffff=
81603c60 ffffffff814c59c4 ffffffff810cf862
[  347.843738]  ffffffff814c59c4Call Trace:
[  347.843740] =

[  347.843741] Call Trace:
[  347.843742]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  347.843745]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  347.843750]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  347.843750]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  347.843753]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  347.843756]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  347.843759]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  347.843762]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  347.843764]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  347.843767]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  347.843770]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  347.843774]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  347.843779]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  347.843780]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  347.843785]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  347.843786]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  347.843789]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  347.843792]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  347.843796]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  347.843797]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  347.843800]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  347.843803]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  347.843806]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  347.843810]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  347.843813]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  347.843816]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  347.843819]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  347.843823]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  347.843828]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  347.843829]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  347.843835]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  347.843835]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  347.843840]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  347.843841]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  347.843844]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  347.843848]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  347.843851]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  347.843855]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  347.843860]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  347.843865]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  353.142868] Xenomai: stuck on nucleus lock ffffffff8162db50
[  353.142868] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  353.142868] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  353.142870]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  353.142877]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  353.142885]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  353.142892] Call Trace:
[  353.142896]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  353.142900]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  353.142906]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  353.142912]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  353.142917]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  353.142922]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  353.142927]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  353.142932]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  353.142937]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  353.142941]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  353.142946]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  353.142951]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  353.142957]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  353.142963]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  353.142968]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  353.142972]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  353.142977]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  353.142982]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  347.649380]  ffff88042a4cfca8 00000000000000c9 ffffffff8162db50 00000000=
00000004
[  357.238021]  ffff88042a4dfca8[  357.359648]  00000000000000c9 ffffffff81=
62db50 0000000000000007
[  357.430633]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  357.519362]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
Call Trace:
[  357.621693]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  357.685099]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  357.751623]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  357.810880]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  357.869100]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  357.943923]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  358.019787]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  358.093573]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  358.167360]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  358.238031]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  358.308705]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  358.374188]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  358.436560]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  400.346912] Xenomai: stuck on nucleus lock ffffffff8162db50
[  400.346912] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  400.346912] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  400.513811] Xenomai: stuck on nucleus lock ffffffff8162db50
[  400.513811] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  400.513811] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  400.513822]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  400.513832]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  400.513843] Call Trace:
[  400.669702] Xenomai: stuck on nucleus lock ffffffff8162db50
[  400.669702] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  400.669702] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  400.669704]  ffff88042a4c3b98 00000000000000c5 ffffffff8162db50 00000000=
00000001[  400.669711] Xenomai: stuck on nucleus lock ffffffff8162db50
[  400.669711] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  400.669711] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  400.669711] =

[  400.669713]  ffffffff81603ba8 0000000000000000 00000000000000c5 ffffffff=
814c59c4 ffffffff8162db50 0000000000000892 0000000000000000 ffff88042a4c3be0
[  400.669734] =

[  400.669735]  0000000000000000 ffffffff81004d80 ffffffff814c59c4 ffff8804=
2a4c3c50 0000000000000892 ffffffff810cf862 ffffffff81603bf0 ffffffff814c59c4
[  400.669744] =

[  400.669745]  ffffffff81004d80Call Trace:
[  400.669747]  ffffffff81603c60 ffffffff810cf862 ffffffff814c59c4 [<ffffff=
ff81004d80>] ? show_stack+0x1c/0x1e
[  400.669753] =

[  400.669754] Call Trace:
[  400.669756]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  400.669757]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  400.669760]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  400.669765]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  400.669765]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  400.669768]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  400.669771]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  400.669774]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  400.669777]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  400.669781]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  400.669786]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  400.669787]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  400.669792]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  400.669793]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  400.669796]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  400.669801]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  400.669802]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  400.669805]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  400.669808]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  400.669813]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  400.669814]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  400.669817]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  400.669820]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  400.669824]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  400.669827]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  400.669830]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  400.669836]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  400.669837]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  400.669842]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  400.669843]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  400.669848]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  400.669849]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  400.669852]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  400.669857]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  400.669859]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  400.669863]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  400.669867]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  400.669873]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  400.669877]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  400.513812]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  404.977230]  ffff88042a4cfca8[  405.098856]  00000000000000c9 ffffffff81=
62db50 0000000000000004
[  405.169842]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0[  405.245280] Xenomai: stuck on nucleus lock ffffffff8162db50
[  405.245280] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  405.245280] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  405.245282]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  405.245289]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  405.245296]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  405.245304] Call Trace:
[  405.245307]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  405.245311]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  405.245317]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  405.245322]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  405.245327]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  405.245332]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  405.245336]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  405.245341]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  405.245347]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  405.245351]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  405.245355]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  405.245360]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  405.245365]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  405.245372]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  405.245376]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  405.245381]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  405.245385]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  405.245390]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  405.649557] Xenomai: stuck on nucleus lock ffffffff8162db50
[  405.649557] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  405.649557] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  405.649559]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  405.649566]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  405.649574]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  405.649581] Call Trace:
[  405.649584]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  405.649588]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  405.649594]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  405.649599]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  405.649604]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  405.649609]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  405.649613]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  405.649618]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  405.649624]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  405.649627]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  405.649632]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  405.649637]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  405.649642]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  405.649648]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  405.649653]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  405.649657]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  405.649661]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  405.649666]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6

[  408.870571] =

[  408.890497]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  408.979227] Call Trace:
[  409.008395]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  409.071800]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  409.138326]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  409.196543]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  409.271366]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  409.347228]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  409.421016]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  409.494802]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  409.565475]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  409.636147]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  409.701630]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  409.764003]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  411.176364] Xenomai: stuck on nucleus lock ffffffff8162db50
[  411.176364] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  411.176364] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  411.435968]  ffff88042a4dfca8 00000000000000c9 ffffffff8162db50 00000000=
00000007
[  411.524699]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  411.613430]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
[  411.702160] Call Trace:
[  411.731326]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  411.794757]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  411.861358]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  411.920616]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  411.978836]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  412.053660]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  412.129522]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  412.203308]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  412.277095]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  412.347766]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  412.418441]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  412.483923]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  412.546295]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  453.490254] Xenomai: stuck on nucleus lock ffffffff8162db50
[  453.490254] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  453.490254] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  453.490266] Xenomai: stuck on nucleus lock ffffffff8162db50
[  453.490266] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  453.490266] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  453.490277]  0000000000000000 ffffffff814c59c4 0000000000000892 ffffffff=
81603bf0
[  453.490287]  ffffffff81004d80 ffffffff81603c60 ffffffff810cf862 ffffffff=
814c59c4
[  453.490298] Call Trace:
[  453.490302]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  453.490308]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  453.490318]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  453.490328]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  453.490334]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  453.490343]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  453.490349]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  453.490356]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  453.490365]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  453.490371]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  453.490378]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  453.490385]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  453.490393]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  453.490403]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  453.490411]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  453.490418]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  453.490424]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  453.490431]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  453.490439]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  453.490444]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  453.490455]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  453.490462]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  453.490269]  ffffffff81603ba8 00000000000000c5 ffffffff8162db50 00000000=
00000000
[  455.744064]  ffff88042a4c3b98[  455.865690]  00000000000000c5 ffffffff81=
62db50 0000000000000001
[  455.936676]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c3be0
[  456.025405]  ffffffff81004d80 ffff88042a4c3c50 ffffffff810cf862 ffffffff=
814c59c4
Call Trace:
[  456.127736]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  456.191143]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  456.257667]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  456.331453]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  456.402125]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  456.460346]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  456.529980]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  456.598578]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  456.675478]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  456.743036]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  456.818898]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  456.894760]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  456.968546]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  457.042333]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  457.113004]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  457.183677]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  457.249161]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  457.311533]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  457.350649] Xenomai: stuck on nucleus lock ffffffff8162db50
[  457.350649] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  457.350649] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  457.350657]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  457.350664]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  457.350672] Call Trace:
[  457.350675]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  457.350679]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  457.350685]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  457.350690]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  457.350695]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  457.350700]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  457.350705]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  457.350709]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  457.350715]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  457.350719]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  457.350724]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  457.350729]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  457.350734]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  457.350740]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  457.350745]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  457.350749]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  457.350753]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  457.350758]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  457.733872] Xenomai: stuck on nucleus lock ffffffff8162db50
[  457.733872] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  457.733872] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  457.733874]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  457.733882]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  457.733889]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  457.733896] Call Trace:
[  459.013989] Xenomai: stuck on nucleus lock ffffffff8162db50
[  459.013989] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  459.013989] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  459.013991]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  459.013998]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  459.014005]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  459.014012] Call Trace:
[  459.014016]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  459.014020]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  459.014026]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  459.014031]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  459.014036]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  459.014041]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  459.014045]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  459.014050]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  459.014055]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  459.014059]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  459.014063]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  459.014068]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  459.014073]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  459.014080]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  459.014084]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  459.014089]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  459.014093]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  459.014098]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  457.350651]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  462.543755] Xenomai: stuck on nucleus lock ffffffff8162db50
[  462.543755] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  462.543755] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  462.891681]  ffff88042a4cfca8 00000000000000c9 ffffffff8162db50 00000000=
00000004
[  462.980410]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0
[  463.069142]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  463.157873] Call Trace:
[  463.187040]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  463.250447]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  463.316969]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  463.375190]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  463.450014]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  463.525874]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  463.599661]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  463.673448]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  463.744120]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  463.814791]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  463.880275]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  463.942647]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  465.283904] Xenomai: stuck on nucleus lock ffffffff8162db50
[  465.283904] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  465.283904] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  465.543524]  ffff88042a4dfca8 00000000000000c9 ffffffff8162db50 00000000=
00000007
[  465.632254]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  465.720986]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
[  465.809715] Call Trace:
[  465.838884]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  465.902290]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  465.968812]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  466.028089]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  466.086289]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  466.161114]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  466.236977]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  466.310762]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  466.384550]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  466.455221]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  466.525893]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  466.591377]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  466.653750]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  509.473628] Xenomai: stuck on nucleus lock ffffffff8162db50
[  509.473628] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  509.473628] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  509.729058]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  509.817789]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  509.906519]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  509.995249] Call Trace:
[  510.024415]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  510.087824]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  510.154346]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  510.191464] Xenomai: stuck on nucleus lock ffffffff8162db50
[  510.191464] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  510.191464] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  510.191472]  0000000000000000 ffffffff814c59c4 0000000000000892 ffffffff=
81603bf0
[  510.191479]  ffffffff81004d80 ffffffff81603c60 ffffffff810cf862 ffffffff=
814c59c4
[  510.191487] Call Trace:
[  510.191490]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  510.191494]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  510.191500]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  510.191505]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  510.191510]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  510.191515]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  510.191520]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  510.191524]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  510.191530]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  510.191534]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  510.191538]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  510.191543]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  510.191548]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  510.191555]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  510.191559]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  510.191564]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  510.191568]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  510.191573]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  510.191577]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  510.191581]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  510.191586]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  510.191591]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  511.174380] Xenomai: stuck on nucleus lock ffffffff8162db50
[  511.174380] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  511.174380] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  511.174382]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  511.174389]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  511.174396]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  511.174404] Call Trace:
[  512.396385] Xenomai: stuck on nucleus lock ffffffff8162db50
[  512.396385] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  512.396385] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  512.396387]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  512.396394]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  512.396401]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  512.396409] Call Trace:
[  512.396412]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  512.396416]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  512.396422]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  512.396427]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  512.396432]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  512.396437]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  512.396441]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  512.396446]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  512.396451]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  512.396455]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  512.396459]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  512.396464]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  512.396469]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  512.396476]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  512.396480]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  512.396484]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  512.396489]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  512.396493]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  514.281057] Xenomai: stuck on nucleus lock ffffffff8162db50
[  514.281057] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  514.281057] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  514.281059]  ffff88042a4c3b98 00000000000000c5 ffffffff8162db50 00000000=
00000001
[  514.281067]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c3be0
[  514.281074]  ffffffff81004d80 ffff88042a4c3c50 ffffffff810cf862 ffffffff=
814c59c4
[  514.281081] Call Trace:
[  514.281084]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  514.281088]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  514.281094]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  514.281100]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  514.281105]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  514.281110]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  514.281114]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  514.281119]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  514.281125]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  514.281128]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  514.281133]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  514.281138]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  514.281143]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  514.281149]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  514.281154]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  514.281158]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  514.281163]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  514.281167]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  510.191466]  ffffffff81603ba8 00000000000000c5 ffffffff8162db50 00000000=
00000000
[  516.391411]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  516.550505]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  516.608727]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  516.678360]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  516.738330] Xenomai: stuck on nucleus lock ffffffff8162db50
[  516.738330] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  516.738330] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  516.738337]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0
[  516.738345]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  516.738352] Call Trace:
[  516.738355]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  516.738359]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  516.738365]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  516.738370]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  516.738374]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  516.738380]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  516.738384]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  516.738391]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  516.738396]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  516.738400]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  516.738404]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  516.738409]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  516.738332]  ffff88042a4cfca8 00000000000000c9 ffffffff8162db50 00000000=
00000004
[  518.040654]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  518.205976]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  518.273533]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  518.349398]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  518.425258]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  518.499049]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  518.572833]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  518.643503]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  518.714176]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  518.779662]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  518.842037]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  519.396968] Xenomai: stuck on nucleus lock ffffffff8162db50
[  519.396968] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  519.396968] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  519.656581]  ffff88042a4dfca8 00000000000000c9 ffffffff8162db50 00000000=
00000007
[  519.745312]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  519.834042]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
[  519.922773] Call Trace:
[  519.951940]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  520.015347]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  520.081870]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  520.141128]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  520.199346]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  520.274170]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  520.350045]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  520.423820]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  520.497607]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  520.568278]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  520.638951]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  520.704435]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  520.766806]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  562.989394] Xenomai: stuck on nucleus lock ffffffff8162db50
[  562.989394] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #0)
[  562.989394] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  563.244768]  ffffffff81603ba8 00000000000000c5 ffffffff8162db50 00000000=
00000000
[  563.333497]  0000000000000000 ffffffff814c59c4 0000000000000892 ffffffff=
81603bf0
[  563.422228]  ffffffff81004d80 ffffffff81603c60 ffffffff810cf862 ffffffff=
814c59c4
[  563.510958] Call Trace:
[  563.540126]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  563.603534]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  563.670055]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  563.743843]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  563.814515]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  563.872735]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  563.884567] Xenomai: stuck on nucleus lock ffffffff8162db50
[  563.884567] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #5)
[  563.884567] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  563.884575]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
27907de0
[  563.884582]  ffffffff81004d80 ffff880427907e50 ffffffff810cf862 ffffffff=
814c59c4
[  563.884589] Call Trace:
[  563.884569]  ffff880427907d98 00000000000000c5 ffffffff8162db50 00000000=
00000005
[  564.404386]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  564.561406]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  564.638306]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  564.705864]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  564.781727]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  564.857589]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  564.931374]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  565.005164]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  565.075835]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  565.146524]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  565.211992]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  565.274363]  [<ffffffff813ad34f>] ? rest_init+0x83/0x87
[  565.336734]  [<ffffffff81997d32>] ? start_kernel+0x3f7/0x404
[  565.404291]  [<ffffffff81997770>] ? kernel_init+0x1d3/0x1d3
[  565.470815]  [<ffffffff819972b4>] ? x86_64_start_reservations+0xb8/0xbd
[  565.549789]  [<ffffffff819973ea>] ? x86_64_start_kernel+0x131/0x138
[  565.759844] Xenomai: stuck on nucleus lock ffffffff8162db50
[  565.759844] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #6)
[  565.759844] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  566.015231]  ffff88042a4dbb98 00000000000000c5 ffffffff8162db50 00000000=
00000006
[  566.103960]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4dbbe0
[  566.192690]  ffffffff81004d80 ffff88042a4dbc50 ffffffff810cf862 ffffffff=
814c59c4
[  566.281421] Call Trace:
[  566.310588]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  566.373994]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  566.440518]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  566.514305]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  566.584977]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  566.643196]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  566.712831]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  566.781429]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  566.858328]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  566.925886]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  567.001749]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  567.077612]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  567.151398]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  567.225185]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  567.295858]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  567.366530]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  567.432013]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  567.494386]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  568.373665] Xenomai: stuck on nucleus lock ffffffff8162db50
[  568.373665] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #1)
[  568.373665] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  568.629090]  ffff88042a4c3b98 00000000000000c5 ffffffff8162db50 00000000=
00000001
[  568.717822]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c3be0
[  568.806551]  ffffffff81004d80 ffff88042a4c3c50 ffffffff810cf862 ffffffff=
814c59c4
[  568.895282] Call Trace:
[  568.924449]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  568.987856]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  569.054391]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  569.128269]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  569.198942]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  569.257163]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  569.326797]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  569.395498]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  569.450274] Xenomai: stuck on nucleus lock ffffffff8162db50
[  569.450274] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #4)
[  569.450274] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  569.450282]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4cfcf0
[  569.450289]  ffffffff81004d80 ffff88042a4cfd60 ffffffff810cf862 ffffffff=
814c59c4
[  569.450296] Call Trace:
[  569.450299]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  569.450303]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  569.450309]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  569.450314]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  569.450319]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  569.450324]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  569.450329]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  569.450335]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  569.450340]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  569.450344]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  569.450348]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  569.450353]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  569.450276]  ffff88042a4cfca8 00000000000000c9 ffffffff8162db50 00000000=
00000004
[  570.766093]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  570.922075]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  570.997937]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  571.026338] Xenomai: stuck on nucleus lock ffffffff8162db50
[  571.026338] 	  waiter =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #2)
[  571.026338] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  571.026346]  0000000000000000 ffffffff814c59c4 0000000000000892 ffff8804=
2a4c7be0
[  571.026353]  ffffffff81004d80 ffff88042a4c7c50 ffffffff810cf862 ffffffff=
814c59c4
[  571.026360] Call Trace:
[  571.026363]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  571.026368]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  571.026374]  [<ffffffff810cf8e9>] ? __xnlock_get_irqsave+0x66/0xaa
[  571.026379]  [<ffffffff810d1786>] ? __xnpod_schedule+0x58/0x67e
[  571.026384]  [<ffffffff813c9e3b>] ? trace+0x3a/0x6f
[  571.026389]  [<ffffffff8101ce5f>] ? lapic_next_event+0x1d/0x21
[  571.026393]  [<ffffffff810a444c>] ? ipipe_timer_set+0x8d/0x9d
[  571.026398]  [<ffffffff810d8e4a>] ? xntimer_next_local_shot+0xab/0xaf
[  571.026404]  [<ffffffff810ce10d>] ? xnpod_schedule+0x36/0x38
[  571.026408]  [<ffffffff810ce368>] ? xnintr_clock_handler+0x149/0x186
[  571.026412]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  571.026417]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  571.026422]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  571.026429]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  571.026433]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  571.026438]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  571.026442]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  571.026447]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  571.026340]  ffff88042a4c7b98 00000000000000c5 ffffffff8162db50 00000000=
00000002
[  572.792155]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  572.954364]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  573.028152]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  573.098823]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  573.169495]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  573.234979]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  573.297349]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
[  574.385748] Xenomai: stuck on nucleus lock ffffffff8162db50
[  574.385748] 	  waiter =3D kernel/xenomai/nucleus/intr.c:109 (xnintr_cloc=
k_handler(), CPU #7)
[  574.385748] 	  owner	 =3D kernel/xenomai/nucleus/pod.c:2194 (__xnpod_sch=
edule(), CPU #3)
[  574.645320]  ffff88042a4dfca8 00000000000000c9 ffffffff8162db50 00000000=
00000007
[  574.734050]  0000000000000000 ffffffff814c57c0 000000000000006d ffff8804=
2a4dfcf0
[  574.822780]  ffffffff81004d80 ffff88042a4dfd60 ffffffff810cf862 ffffffff=
814c59c4
[  574.911511] Call Trace:
[  574.940677]  [<ffffffff81004d80>] ? show_stack+0x1c/0x1e
[  575.004086]  [<ffffffff810cf862>] ? __xnlock_spin+0xa2/0xc3
[  575.070608]  [<ffffffff813cc515>] ? do_IRQ+0xc5/0xc5
[  575.129864]  [<ffffffff810ce1e6>] ? T.922+0x5a/0x93
[  575.188084]  [<ffffffff810ce2e8>] ? xnintr_clock_handler+0xc9/0x186
[  575.262908]  [<ffffffff810a36c1>] ? __ipipe_dispatch_irq+0x178/0x222
[  575.338770]  [<ffffffff8101bc5d>] ? __ipipe_handle_irq+0x108/0x162
[  575.412555]  [<ffffffff813cac39>] ? apic_timer_interrupt+0x79/0xc0
[  575.486346]  [<ffffffff8101be73>] ? __ipipe_halt_root+0x50/0x52
[  575.557017]  [<ffffffff8101be71>] ? __ipipe_halt_root+0x4e/0x52
[  575.627689]  [<ffffffff81009f5a>] ? default_idle+0x4c/0x80
[  575.693171]  [<ffffffff81009665>] ? cpu_idle+0xb8/0x10c
[  575.755543]  [<ffffffff813bb797>] ? start_secondary+0x1df/0x1e6
