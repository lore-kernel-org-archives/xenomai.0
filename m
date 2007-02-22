Message-ID: <bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>
Date: Thu, 22 Feb 2007 13:36:50 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DD9814.4060809@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23285_9010000.1172151410830"
References: <45DC1D05.1000206@domain.hid> <45DD7C42.9070407@domain.hid>
	<bc4264770702220339m1b8dfcbfk11f9c05e2a0aed91@domain.hid>
	<45DD8438.4030306@domain.hid>
	<bc4264770702220406i1c8608cy3f748416f589f5c6@domain.hid>
	<45DD8B42.1020709@domain.hid>
	<bc4264770702220434v13302afcg3f790e823f08169c@domain.hid>
	<45DD9294.1060109@domain.hid>
	<bc4264770702220502p13556486l3d59ad7b4b3ff737@domain.hid>
	<45DD9814.4060809@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_23285_9010000.1172151410830
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Wolfgang,

I did this

#/var> grep -r "Xenomai" ./  >> dmesg.txt

I found what you are looking for you will find it in the message attached.

I did the same for rtcan which should yield the last 4 lines

and found this:

./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan0
./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan0: VIRT driver loaded
./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan1
./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan1: VIRT driver loaded
./log/dmesg:rtcan: registered rtcan0
./log/dmesg:rtcan0: VIRT driver loaded
./log/dmesg:rtcan: registered rtcan1
./log/dmesg:rtcan1: VIRT driver loaded
./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan0
./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan0: VIRT driver loaded
./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan1
./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan1: VIRT driver loaded
./adm/dmesg:rtcan: registered rtcan0
./adm/dmesg:rtcan0: VIRT driver loaded
./adm/dmesg:rtcan: registered rtcan1
./adm/dmesg:rtcan1: VIRT driver loaded


Hope this helps us?

Regards,

Roland


On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> roland Tollenaar wrote:
> > Hi Wolfgang,
> >
> > sorry to ask a stupid question here but where would I find the complete
> > boot log
> >
> > I am checking /var/log/
> >
> > but am not sure which one you would want?
>
> Output of "dmesg" please or the log of your console output. You should
> find lines similar to the following:
>
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.4-devel (Bells Of Lal) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> RT-Socket-CAN 0.20.2 - (C) 2006 RT-Socket-CAN Development Team
> rtcan: registered rtcan0
> rtcan0: VIRT driver loaded
> rtcan: registered rtcan1
> rtcan1: VIRT driver loaded
>
> >
> > Xenomai itself must be running because the the programs in the
> > testsuite seem to be working.
> >
> > Roland
> >
> > On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> roland Tollenaar wrote:
> >> > Hi,
> >> >
> >> >>
> >> >> Without device it will not register anyhow and see above.
> >> >>
> >> >
> >> > I have now built the kernel with the virtual driver statically built
> >> > into it. No difference still no devices.
> >> >
> >> >>
> >> >> The driver for the dongle will not start properly when statically
> >> linked
> >> >> into the kernel. There should be a log message, though.
> >> >>
> >> > No log message unless I am missing something. What is the module
> >> > called? After the
> >> > make modules in the kernel building process I will have to find it and
> >> > store it somewhere I will try loading it manually when the new kernel
> >> > is booted.
> >> >
> >> > The virtual driver I can build in statically?
> >> >
> >> >
> >> >>
> >> >> Can you post the compete dmesg output?
> >> >>
> >> >
> >> > It is attached as a txt file. The errors regarding ehci, ohci, uhci
> >> > and mass_storage are results of trying to load modules that I have
> >> > statically built into the kernel.
> >>
> >> I'm missing Xenomai related messages? Could you send the complete boot
> >> log please.
> >>
> >> Wolfgang.
> >>
> >> >
> >> > Regards,
> >> >
> >> > Roland
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >> > I have checked the .config for the kernel build and CAN is
> >> statically
> >> >> > built into it.
> >> >> >
> >> >> > I would prefer to statically build these things into the kernel
> >> due to
> >> >> > unwieldiness of my ditribution. If this is not possible I will make
> >> >> > modules. But is this the cause of problem I am having?
> >> >> > I have no device hooked to my system (PEAK dongle on its way) and
> >> the
> >> >> > virtual driver and TX loopback ability  has been excluded from the
> >> >> > kernel build. Is this possibly why i have no devices listed in
> >> >> > proc/rtcan/devices?
> >> >> Wolfgang.
> >> >>
> >> >> > On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> >> >> roland Tollenaar wrote:
> >> >> >> > Hi Jan,
> >> >> >> >
> >> >> >> >>
> >> >> >> >> rtcanX are networking devices, but only visible in the
> >> context of
> >> >> >> >> RTDM/AF_CAN.
> >> >> >> > What is this?
> >> >> >> >
> >> >> >> > To enable them, use rtcanconfig as explained in the README.
> >> >> >> > Which README are you referring to? The only one I know of that
> >> says
> >> >> >> > something about rtcanconfig is in /src/utils/can and it does not
> >> >> >> > explain how to use ctrlmode and bittime. There is an example
> >> in it
> >> >> >> >
> >> >> >> > rtcanconfig rtcan0 --baudrate=125000 start.
> >> >> >> >
> >> >> >> > If I try
> >> >> >> >
> >> >> >> > rtcanconfig rtcan0 --baudrate=125000 start
> >> >> >> >
> >> >> >> > I get:
> >> >> >> >
> >> >> >> > "Can't get interface index for rtcan0, code=-19"
> >> >> >> >
> >> >> >> > Any idea what is wrong?
> >> >> >>
> >> >> >> Your devices have not yet show up on your system. I guess there
> >> is no
> >> >> >> entry in /proc/rtcan/devices. Check your boot log.
> >> >> >>
> >> >> >> Wolfgang.
> >> >> >>
> >> >> >>
> >> >> >
> >> >> >
> >> >>
> >> >>
> >> >
> >> >
> >> ------------------------------------------------------------------------
> >> >
> >> > veReady SeekComplete Error }
> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> LastFailedSense=0x05 }
> >> > ide: failed opcode was: unknown
> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> Error }
> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> LastFailedSense=0x05 }
> >> > ide: failed opcode was: unknown
> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> Error }
> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> LastFailedSense=0x05 }
> >> > ide: failed opcode was: unknown
> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> Error }
> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> LastFailedSense=0x05 }
> >> > ide: failed opcode was: unknown
> >> > UDF-fs: No partition found (1)
> >> > XFS: bad magic number
> >> > XFS: SB validate failed
> >> > NTFS volume version 3.1.
> >> > spurious 8259A interrupt: IRQ7.
> >> > UDF-fs: No partition found (1)
> >> > XFS: bad magic number
> >> > XFS: SB validate failed
> >> > Linux agpgart interface v0.101 (c) Dave Jones
> >> > fuse init (API version 7.6)
> >> > NTFS volume version 3.1.
> >> > input: PS/2 Synaptics TouchPad as /class/input/input1
> >> > Intel ISA PCIC probe: not found.
> >> > Databook TCIC-2 PCMCIA probe: not found.
> >> > PCI: Found IRQ 4 for device 0000:02:03.0
> >> > PCI: Sharing IRQ 4 with 0000:00:1f.3
> >> > PCI: Sharing IRQ 4 with 0000:00:1f.5
> >> > PCI: Sharing IRQ 4 with 0000:00:1f.6
> >> > IRQ routing conflict for 0000:02:03.0, have irq 11, want irq 4
> >> > Yenta: CardBus bridge found at 0000:02:03.0 [1584:3000]
> >> > Yenta: adjusting diagnostic: 40 -> 60
> >> > Yenta: Enabling burst memory read transactions
> >> > Yenta: Using CSCINT to route CSC interrupts to PCI
> >> > Yenta: Routing CardBus interrupts to PCI
> >> > Yenta TI: socket 0000:02:03.0, mfunc 0x005c1d22, devctl 0x44
> >> > Yenta TI: socket 0000:02:03.0 probing PCI interrupt failed, trying
> >> to fix
> >> > Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report.
> >> > Yenta: no PCI IRQ, CardBus support disabled for this socket.
> >> > Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
> >> > Yenta: ISA IRQ mask 0x02c0, PCI irq 0
> >> > Socket status: 30000006
> >> > pcmcia: parent PCI bridge I/O window: 0xc000 - 0xcfff
> >> > cs: IO port probe 0xc000-0xcfff: clean.
> >> > pcmcia: parent PCI bridge Memory window: 0xffd00000 - 0xffdfffff
> >> > pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
> >> > pcmcia: Detected deprecated PCMCIA ioctl usage.
> >> > pcmcia: This interface will soon be removed from the kernel; please
> >> expect breakage unless you upgrade to new tools.
> >> > pcmcia: see
> >> http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
> >> details.
> >> > cs: IO port probe 0xc00-0xcff: clean.
> >> > cs: IO port probe 0x820-0x8ff: clean.
> >> > cs: IO port probe 0x800-0x80f: clean.
> >> > cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> >> > cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
> >> > cs: IO port probe 0xa00-0xaff: clean.
> >> > 8139too Fast Ethernet driver 0.9.27
> >> > PCI: Found IRQ 3 for device 0000:02:0b.0
> >> > PCI: Sharing IRQ 3 with 0000:00:1d.1
> >> > eth0: RealTek RTL8139 at 0xc800, 00:03:0d:14:95:c4, IRQ 3
> >> > eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> >> > ieee1394: Initialized config rom entry `ip1394'
> >> > PCI: Found IRQ 5 for device 0000:02:0a.0
> >> > PCI: Sharing IRQ 5 with 0000:00:1d.2
> >> > PCI: Sharing IRQ 5 with 0000:00:1f.1
> >> > ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]
> >> MMIO=[ffdff800-ffdfffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> >> > PCI: Found IRQ 4 for device 0000:00:1f.5
> >> > PCI: Sharing IRQ 4 with 0000:00:1f.3
> >> > PCI: Sharing IRQ 4 with 0000:00:1f.6
> >> > IRQ routing conflict for 0000:02:03.0, have irq 11, want irq 4
> >> > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> >> > intel8x0_measure_ac97_clock: measured 55427 usecs
> >> > intel8x0: clocking to 48000
> >> > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00030d4975701d84]
> >> > i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > agpgart: Detected an Intel 865 Chipset.
> >> > agpgart: AGP aperture is 64M @ 0xf8000000
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > shpchp: Unknown symbol acpi_get_name
> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> > kobject_register failed for ehci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
> >> (PCI)
> >> > kobject_register failed for ohci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c032636c>] bus_add_driver+0x5c/0xa0
> >> >  [<c0326e37>] driver_register+0x57/0x90
> >> >  [<c02ea732>] __pci_register_driver+0x52/0x80
> >> >  [<f8ecf02e>] ohci_hcd_pci_init+0x2e/0x35 [ohci_hcd]
> >> >  [<c012e6e2>] sys_init_module+0x102/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for uhci_hcd (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > kobject_register failed for usb_storage (-17)
> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> >> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> >> > NET: Registered protocol family 10
> >> > lo: Disabled Privacy Extensions
> >> > IPv6 over IPv4 tunneling driver
> >> > eth0: no IPv6 routers present
> >>
> >>
> >
> >
>
>

------=_Part_23285_9010000.1172151410830
Content-Type: text/plain; name=dmesg.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyhapday
Content-Disposition: attachment; filename="dmesg.txt"

Li9sb2cvbWVzc2FnZXM6RmViIDIyIDE0OjAwOjU5IChub25lKSBzdWRvOiAgICAgcm9vdCA6IFRU
WT1wdHMvNCA7IFBXRD0vbW50L2FwcHVzYi94ZW5vbWFpL3NoYXJlL3hlbm9tYWkvdGVzdHN1aXRl
L2xhdGVuY3kgOyBVU0VSPXJvb3QgOyBDT01NQU5EPS9zYmluL21vZHByb2JlIC1ucSB4ZW5vX251
Y2xldXMKLi9sb2cvbWVzc2FnZXM6RmViIDIyIDE0OjAwOjU5IChub25lKSBzdWRvOiAgICAgcm9v
dCA6IFRUWT1wdHMvNCA7IFBXRD0vbW50L2FwcHVzYi94ZW5vbWFpL3NoYXJlL3hlbm9tYWkvdGVz
dHN1aXRlL2xhdGVuY3kgOyBVU0VSPXJvb3QgOyBDT01NQU5EPS9zYmluL21vZHByb2JlIC1uIHhl
bm9fbmF0aXZlCi4vbG9nL21lc3NhZ2VzOkZlYiAyMiAxNDowMTowMCAobm9uZSkgc3VkbzogICAg
IHJvb3QgOiBUVFk9cHRzLzQgOyBQV0Q9L21udC9hcHB1c2IveGVub21haS9zaGFyZS94ZW5vbWFp
L3Rlc3RzdWl0ZS9sYXRlbmN5IDsgVVNFUj1yb290IDsgQ09NTUFORD0vc2Jpbi9tb2Rwcm9iZSAt
biB4ZW5vX3J0ZG0KLi9sb2cvbWVzc2FnZXM6RmViIDIyIDE0OjAxOjAwIChub25lKSBzdWRvOiAg
ICAgcm9vdCA6IFRUWT1wdHMvNCA7IFBXRD0vbW50L2FwcHVzYi94ZW5vbWFpL3NoYXJlL3hlbm9t
YWkvdGVzdHN1aXRlL2xhdGVuY3kgOyBVU0VSPXJvb3QgOyBDT01NQU5EPS9zYmluL21vZHByb2Jl
IC1uIHhlbm9fdGltZXJiZW5jaAouL2xvZy9tZXNzYWdlczpGZWIgMjIgMTQ6MDE6MDAgKG5vbmUp
IHN1ZG86ICAgICByb290IDogVFRZPXB0cy80IDsgUFdEPS9tbnQvYXBwdXNiL3hlbm9tYWkvc2hh
cmUveGVub21haS90ZXN0c3VpdGUvbGF0ZW5jeSA7IFVTRVI9cm9vdCA7IENPTU1BTkQ9L3Vzci94
ZW5vbWFpL2Jpbi9sYXRlbmN5Ci4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxNDowMDo1OSAobm9uZSkg
c3VkbzogICAgIHJvb3QgOiBUVFk9cHRzLzQgOyBQV0Q9L21udC9hcHB1c2IveGVub21haS9zaGFy
ZS94ZW5vbWFpL3Rlc3RzdWl0ZS9sYXRlbmN5IDsgVVNFUj1yb290IDsgQ09NTUFORD0vc2Jpbi9t
b2Rwcm9iZSAtbnEgeGVub19udWNsZXVzCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxNDowMDo1OSAo
bm9uZSkgc3VkbzogICAgIHJvb3QgOiBUVFk9cHRzLzQgOyBQV0Q9L21udC9hcHB1c2IveGVub21h
aS9zaGFyZS94ZW5vbWFpL3Rlc3RzdWl0ZS9sYXRlbmN5IDsgVVNFUj1yb290IDsgQ09NTUFORD0v
c2Jpbi9tb2Rwcm9iZSAtbiB4ZW5vX25hdGl2ZQouL2FkbS9tZXNzYWdlczpGZWIgMjIgMTQ6MDE6
MDAgKG5vbmUpIHN1ZG86ICAgICByb290IDogVFRZPXB0cy80IDsgUFdEPS9tbnQvYXBwdXNiL3hl
bm9tYWkvc2hhcmUveGVub21haS90ZXN0c3VpdGUvbGF0ZW5jeSA7IFVTRVI9cm9vdCA7IENPTU1B
TkQ9L3NiaW4vbW9kcHJvYmUgLW4geGVub19ydGRtCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxNDow
MTowMCAobm9uZSkgc3VkbzogICAgIHJvb3QgOiBUVFk9cHRzLzQgOyBQV0Q9L21udC9hcHB1c2Iv
eGVub21haS9zaGFyZS94ZW5vbWFpL3Rlc3RzdWl0ZS9sYXRlbmN5IDsgVVNFUj1yb290IDsgQ09N
TUFORD0vc2Jpbi9tb2Rwcm9iZSAtbiB4ZW5vX3RpbWVyYmVuY2gKLi9hZG0vbWVzc2FnZXM6RmVi
IDIyIDE0OjAxOjAwIChub25lKSBzdWRvOiAgICAgcm9vdCA6IFRUWT1wdHMvNCA7IFBXRD0vbW50
L2FwcHVzYi94ZW5vbWFpL3NoYXJlL3hlbm9tYWkvdGVzdHN1aXRlL2xhdGVuY3kgOyBVU0VSPXJv
b3QgOyBDT01NQU5EPS91c3IveGVub21haS9iaW4vbGF0ZW5jeQouL2xvZy9zeXNsb2c6RmViIDIy
IDEzOjIxOjM4IChub25lKSBrZXJuZWw6IEktcGlwZTogRG9tYWluIFhlbm9tYWkgcmVnaXN0ZXJl
ZC4KLi9sb2cvc3lzbG9nOkZlYiAyMiAxMzoyMTozOCAobm9uZSkga2VybmVsOiBYZW5vbWFpOiBT
TUktZW5hYmxlZCBjaGlwc2V0IGZvdW5kIGJ1dCBTTUkgd29ya2Fyb3VuZCBub3QgZW5hYmxlZCAo
Y2hlY2sKLi9sb2cvbWVzc2FnZXM6RmViIDIyIDEzOjIxOjM4IChub25lKSBrZXJuZWw6IFhlbm9t
YWk6IGhhbC94ODYgc3RhcnRlZC4KLi9sb2cvbWVzc2FnZXM6RmViIDIyIDEzOjIxOjM4IChub25l
KSBrZXJuZWw6IFhlbm9tYWk6IHJlYWwtdGltZSBudWNsZXVzIHYyLjMgKEJhcm9xdWUpIGxvYWRl
ZC4KLi9sb2cvbWVzc2FnZXM6RmViIDIyIDEzOjIxOjM4IChub25lKSBrZXJuZWw6IFhlbm9tYWk6
IHN0YXJ0aW5nIG5hdGl2ZSBBUEkgc2VydmljZXMuCi4vbG9nL21lc3NhZ2VzOkZlYiAyMiAxMzoy
MTozOCAobm9uZSkga2VybmVsOiBYZW5vbWFpOiBzdGFydGluZyBQT1NJWCBzZXJ2aWNlcy4KLi9s
b2cvbWVzc2FnZXM6RmViIDIyIDEzOjIxOjM4IChub25lKSBrZXJuZWw6IFhlbm9tYWk6IHN0YXJ0
aW5nIFJURE0gc2VydmljZXMuCi4vbG9nL2RtZXNnOkktcGlwZTogRG9tYWluIFhlbm9tYWkgcmVn
aXN0ZXJlZC4KLi9sb2cvZG1lc2c6WGVub21haTogaGFsL3g4NiBzdGFydGVkLgouL2xvZy9kbWVz
ZzpYZW5vbWFpOiByZWFsLXRpbWUgbnVjbGV1cyB2Mi4zIChCYXJvcXVlKSBsb2FkZWQuCi4vbG9n
L2RtZXNnOlhlbm9tYWk6IFNNSS1lbmFibGVkIGNoaXBzZXQgZm91bmQgYnV0IFNNSSB3b3JrYXJv
dW5kIG5vdCBlbmFibGVkIChjaGVjawouL2xvZy9kbWVzZzpYZW5vbWFpOiBzdGFydGluZyBuYXRp
dmUgQVBJIHNlcnZpY2VzLgouL2xvZy9kbWVzZzpYZW5vbWFpOiBzdGFydGluZyBQT1NJWCBzZXJ2
aWNlcy4KLi9sb2cvZG1lc2c6WGVub21haTogc3RhcnRpbmcgUlRETSBzZXJ2aWNlcy4KLi9hZG0v
c3lzbG9nOkZlYiAyMiAxMzoyMTozOCAobm9uZSkga2VybmVsOiBJLXBpcGU6IERvbWFpbiBYZW5v
bWFpIHJlZ2lzdGVyZWQuCi4vYWRtL3N5c2xvZzpGZWIgMjIgMTM6MjE6MzggKG5vbmUpIGtlcm5l
bDogWGVub21haTogU01JLWVuYWJsZWQgY2hpcHNldCBmb3VuZCBidXQgU01JIHdvcmthcm91bmQg
bm90IGVuYWJsZWQgKGNoZWNrCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxMzoyMTozOCAobm9uZSkg
a2VybmVsOiBYZW5vbWFpOiBoYWwveDg2IHN0YXJ0ZWQuCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAx
MzoyMTozOCAobm9uZSkga2VybmVsOiBYZW5vbWFpOiByZWFsLXRpbWUgbnVjbGV1cyB2Mi4zIChC
YXJvcXVlKSBsb2FkZWQuCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxMzoyMTozOCAobm9uZSkga2Vy
bmVsOiBYZW5vbWFpOiBzdGFydGluZyBuYXRpdmUgQVBJIHNlcnZpY2VzLgouL2FkbS9tZXNzYWdl
czpGZWIgMjIgMTM6MjE6MzggKG5vbmUpIGtlcm5lbDogWGVub21haTogc3RhcnRpbmcgUE9TSVgg
c2VydmljZXMuCi4vYWRtL21lc3NhZ2VzOkZlYiAyMiAxMzoyMTozOCAobm9uZSkga2VybmVsOiBY
ZW5vbWFpOiBzdGFydGluZyBSVERNIHNlcnZpY2VzLgouL2FkbS9kbWVzZzpJLXBpcGU6IERvbWFp
biBYZW5vbWFpIHJlZ2lzdGVyZWQuCi4vYWRtL2RtZXNnOlhlbm9tYWk6IGhhbC94ODYgc3RhcnRl
ZC4KLi9hZG0vZG1lc2c6WGVub21haTogcmVhbC10aW1lIG51Y2xldXMgdjIuMyAoQmFyb3F1ZSkg
bG9hZGVkLgouL2FkbS9kbWVzZzpYZW5vbWFpOiBTTUktZW5hYmxlZCBjaGlwc2V0IGZvdW5kIGJ1
dCBTTUkgd29ya2Fyb3VuZCBub3QgZW5hYmxlZCAoY2hlY2sKLi9hZG0vZG1lc2c6WGVub21haTog
c3RhcnRpbmcgbmF0aXZlIEFQSSBzZXJ2aWNlcy4KLi9hZG0vZG1lc2c6WGVub21haTogc3RhcnRp
bmcgUE9TSVggc2VydmljZXMuCi4vYWRtL2RtZXNnOlhlbm9tYWk6IHN0YXJ0aW5nIFJURE0gc2Vy
dmljZXMuCg==
------=_Part_23285_9010000.1172151410830--

