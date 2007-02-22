Message-ID: <bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>
Date: Thu, 22 Feb 2007 13:57:11 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DD9DB0.1010103@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45DC1D05.1000206@domain.hid> <45DD8438.4030306@domain.hid>
	<bc4264770702220406i1c8608cy3f748416f589f5c6@domain.hid>
	<45DD8B42.1020709@domain.hid>
	<bc4264770702220434v13302afcg3f790e823f08169c@domain.hid>
	<45DD9294.1060109@domain.hid>
	<bc4264770702220502p13556486l3d59ad7b4b3ff737@domain.hid>
	<45DD9814.4060809@domain.hid>
	<bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>
	<45DD9DB0.1010103@domain.hid>
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

Hi,

This is a bit better.

/proc/rtcan/rtcan0/info


Device     rtcan0
Controller <virtual>
Board      <virtual>
Clock-Hz   0
Baudrate   undefined
Bit-time   brp=0 prop_seg=0 phase_seg1=0 phase_seg2=0 sjw=0 sam=0
Ctrl-Mode
State      stopped
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

for rtcan1

Device     rtcan1
Controller <virtual>
Board      <virtual>
Clock-Hz   0
Baudrate   undefined
Bit-time   brp=0 prop_seg=0 phase_seg1=0 phase_seg2=0 sjw=0 sam=0
Ctrl-Mode
State      stopped
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0


And after ./rtcanconfig rtcan0 --baudrate=500000 start

Device     rtcan0
Controller <virtual>
Board      <virtual>
Clock-Hz   0
Baudrate   undefined
Bit-time   brp=0 prop_seg=0 phase_seg1=0 phase_seg2=0 sjw=0 sam=0
Ctrl-Mode
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

Why is the Baudrate undefined? I thought rtconfig should set this to 500000 ?

Is this all fine now? I oculd have sworn that I checked proc/rtcan
after I had recompiled the kernel with the virtual driver.

Anyhow. Is there a small program that I can compile to test the
virtual can with? I presume i can send it messages with rtcansend and
read the messages with rtcanrecieve?

I still have the outstanding question of what the module will be
called for the PEAK CAN dongle. I have to find it after make modules
to squirrle it away so i can load it after booting due to the
complications with my live distribution.  You said that I cannot build
that into the kernel statically correct? Can it be loaded without the
actual device being connected?

Maybe a small suggestion. Would it not be better to have the virtual
can driver built into the kernel by default. As a new user I did not
select it, saw no reason to.


Thanks.

Roland.


On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> roland Tollenaar wrote:
> > Hi Wolfgang,
> >
> > I did this
> >
> > #/var> grep -r "Xenomai" ./  >> dmesg.txt
> >
> > I found what you are looking for you will find it in the message attached.
> >
> > I did the same for rtcan which should yield the last 4 lines
> >
> > and found this:
> >
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan0
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan0: VIRT driver loaded
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan1
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: rtcan1: VIRT driver loaded
> > ./log/dmesg:rtcan: registered rtcan0
> > ./log/dmesg:rtcan0: VIRT driver loaded
> > ./log/dmesg:rtcan: registered rtcan1
> > ./log/dmesg:rtcan1: VIRT driver loaded
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan0
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan0: VIRT driver loaded
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan: registered rtcan1
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: rtcan1: VIRT driver loaded
> > ./adm/dmesg:rtcan: registered rtcan0
> > ./adm/dmesg:rtcan0: VIRT driver loaded
> > ./adm/dmesg:rtcan: registered rtcan1
> > ./adm/dmesg:rtcan1: VIRT driver loaded
> >
> >
> > Hope this helps us?
>
> OK, now, what is the output of /proc/rtcan?
>
> >
> > Regards,
> >
> > Roland
> >
> >
> > On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> roland Tollenaar wrote:
> >> > Hi Wolfgang,
> >> >
> >> > sorry to ask a stupid question here but where would I find the complete
> >> > boot log
> >> >
> >> > I am checking /var/log/
> >> >
> >> > but am not sure which one you would want?
> >>
> >> Output of "dmesg" please or the log of your console output. You should
> >> find lines similar to the following:
> >>
> >> I-pipe: Domain Xenomai registered.
> >> Xenomai: hal/powerpc started.
> >> Xenomai: real-time nucleus v2.4-devel (Bells Of Lal) loaded.
> >> Xenomai: starting native API services.
> >> Xenomai: starting POSIX services.
> >> Xenomai: starting RTDM services.
> >> RT-Socket-CAN 0.20.2 - (C) 2006 RT-Socket-CAN Development Team
> >> rtcan: registered rtcan0
> >> rtcan0: VIRT driver loaded
> >> rtcan: registered rtcan1
> >> rtcan1: VIRT driver loaded
> >>
> >> >
> >> > Xenomai itself must be running because the the programs in the
> >> > testsuite seem to be working.
> >> >
> >> > Roland
> >> >
> >> > On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> >> roland Tollenaar wrote:
> >> >> > Hi,
> >> >> >
> >> >> >>
> >> >> >> Without device it will not register anyhow and see above.
> >> >> >>
> >> >> >
> >> >> > I have now built the kernel with the virtual driver statically built
> >> >> > into it. No difference still no devices.
> >> >> >
> >> >> >>
> >> >> >> The driver for the dongle will not start properly when statically
> >> >> linked
> >> >> >> into the kernel. There should be a log message, though.
> >> >> >>
> >> >> > No log message unless I am missing something. What is the module
> >> >> > called? After the
> >> >> > make modules in the kernel building process I will have to find
> >> it and
> >> >> > store it somewhere I will try loading it manually when the new
> >> kernel
> >> >> > is booted.
> >> >> >
> >> >> > The virtual driver I can build in statically?
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> Can you post the compete dmesg output?
> >> >> >>
> >> >> >
> >> >> > It is attached as a txt file. The errors regarding ehci, ohci, uhci
> >> >> > and mass_storage are results of trying to load modules that I have
> >> >> > statically built into the kernel.
> >> >>
> >> >> I'm missing Xenomai related messages? Could you send the complete boot
> >> >> log please.
> >> >>
> >> >> Wolfgang.
> >> >>
> >> >> >
> >> >> > Regards,
> >> >> >
> >> >> > Roland
> >> >> >
> >> >> >
> >> >> >
> >> >> >
> >> >> >
> >> >> >> > I have checked the .config for the kernel build and CAN is
> >> >> statically
> >> >> >> > built into it.
> >> >> >> >
> >> >> >> > I would prefer to statically build these things into the kernel
> >> >> due to
> >> >> >> > unwieldiness of my ditribution. If this is not possible I will
> >> make
> >> >> >> > modules. But is this the cause of problem I am having?
> >> >> >> > I have no device hooked to my system (PEAK dongle on its way) and
> >> >> the
> >> >> >> > virtual driver and TX loopback ability  has been excluded from
> >> the
> >> >> >> > kernel build. Is this possibly why i have no devices listed in
> >> >> >> > proc/rtcan/devices?
> >> >> >> Wolfgang.
> >> >> >>
> >> >> >> > On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> >> >> >> roland Tollenaar wrote:
> >> >> >> >> > Hi Jan,
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> rtcanX are networking devices, but only visible in the
> >> >> context of
> >> >> >> >> >> RTDM/AF_CAN.
> >> >> >> >> > What is this?
> >> >> >> >> >
> >> >> >> >> > To enable them, use rtcanconfig as explained in the README.
> >> >> >> >> > Which README are you referring to? The only one I know of that
> >> >> says
> >> >> >> >> > something about rtcanconfig is in /src/utils/can and it
> >> does not
> >> >> >> >> > explain how to use ctrlmode and bittime. There is an example
> >> >> in it
> >> >> >> >> >
> >> >> >> >> > rtcanconfig rtcan0 --baudrate=125000 start.
> >> >> >> >> >
> >> >> >> >> > If I try
> >> >> >> >> >
> >> >> >> >> > rtcanconfig rtcan0 --baudrate=125000 start
> >> >> >> >> >
> >> >> >> >> > I get:
> >> >> >> >> >
> >> >> >> >> > "Can't get interface index for rtcan0, code=-19"
> >> >> >> >> >
> >> >> >> >> > Any idea what is wrong?
> >> >> >> >>
> >> >> >> >> Your devices have not yet show up on your system. I guess there
> >> >> is no
> >> >> >> >> entry in /proc/rtcan/devices. Check your boot log.
> >> >> >> >>
> >> >> >> >> Wolfgang.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >
> >> >> >> >
> >> >> >>
> >> >> >>
> >> >> >
> >> >> >
> >> >>
> >> ------------------------------------------------------------------------
> >> >> >
> >> >> > veReady SeekComplete Error }
> >> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> >> LastFailedSense=0x05 }
> >> >> > ide: failed opcode was: unknown
> >> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> >> Error }
> >> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> >> LastFailedSense=0x05 }
> >> >> > ide: failed opcode was: unknown
> >> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> >> Error }
> >> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> >> LastFailedSense=0x05 }
> >> >> > ide: failed opcode was: unknown
> >> >> > hdc: packet command error: status=0x51 { DriveReady SeekComplete
> >> >> Error }
> >> >> > hdc: packet command error: error=0x54 { AbortedCommand
> >> >> LastFailedSense=0x05 }
> >> >> > ide: failed opcode was: unknown
> >> >> > UDF-fs: No partition found (1)
> >> >> > XFS: bad magic number
> >> >> > XFS: SB validate failed
> >> >> > NTFS volume version 3.1.
> >> >> > spurious 8259A interrupt: IRQ7.
> >> >> > UDF-fs: No partition found (1)
> >> >> > XFS: bad magic number
> >> >> > XFS: SB validate failed
> >> >> > Linux agpgart interface v0.101 (c) Dave Jones
> >> >> > fuse init (API version 7.6)
> >> >> > NTFS volume version 3.1.
> >> >> > input: PS/2 Synaptics TouchPad as /class/input/input1
> >> >> > Intel ISA PCIC probe: not found.
> >> >> > Databook TCIC-2 PCMCIA probe: not found.
> >> >> > PCI: Found IRQ 4 for device 0000:02:03.0
> >> >> > PCI: Sharing IRQ 4 with 0000:00:1f.3
> >> >> > PCI: Sharing IRQ 4 with 0000:00:1f.5
> >> >> > PCI: Sharing IRQ 4 with 0000:00:1f.6
> >> >> > IRQ routing conflict for 0000:02:03.0, have irq 11, want irq 4
> >> >> > Yenta: CardBus bridge found at 0000:02:03.0 [1584:3000]
> >> >> > Yenta: adjusting diagnostic: 40 -> 60
> >> >> > Yenta: Enabling burst memory read transactions
> >> >> > Yenta: Using CSCINT to route CSC interrupts to PCI
> >> >> > Yenta: Routing CardBus interrupts to PCI
> >> >> > Yenta TI: socket 0000:02:03.0, mfunc 0x005c1d22, devctl 0x44
> >> >> > Yenta TI: socket 0000:02:03.0 probing PCI interrupt failed, trying
> >> >> to fix
> >> >> > Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please
> >> report.
> >> >> > Yenta: no PCI IRQ, CardBus support disabled for this socket.
> >> >> > Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
> >> >> > Yenta: ISA IRQ mask 0x02c0, PCI irq 0
> >> >> > Socket status: 30000006
> >> >> > pcmcia: parent PCI bridge I/O window: 0xc000 - 0xcfff
> >> >> > cs: IO port probe 0xc000-0xcfff: clean.
> >> >> > pcmcia: parent PCI bridge Memory window: 0xffd00000 - 0xffdfffff
> >> >> > pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
> >> >> > pcmcia: Detected deprecated PCMCIA ioctl usage.
> >> >> > pcmcia: This interface will soon be removed from the kernel; please
> >> >> expect breakage unless you upgrade to new tools.
> >> >> > pcmcia: see
> >> >> http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
> >> >> details.
> >> >> > cs: IO port probe 0xc00-0xcff: clean.
> >> >> > cs: IO port probe 0x820-0x8ff: clean.
> >> >> > cs: IO port probe 0x800-0x80f: clean.
> >> >> > cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> >> >> > cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
> >> >> > cs: IO port probe 0xa00-0xaff: clean.
> >> >> > 8139too Fast Ethernet driver 0.9.27
> >> >> > PCI: Found IRQ 3 for device 0000:02:0b.0
> >> >> > PCI: Sharing IRQ 3 with 0000:00:1d.1
> >> >> > eth0: RealTek RTL8139 at 0xc800, 00:03:0d:14:95:c4, IRQ 3
> >> >> > eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> >> >> > ieee1394: Initialized config rom entry `ip1394'
> >> >> > PCI: Found IRQ 5 for device 0000:02:0a.0
> >> >> > PCI: Sharing IRQ 5 with 0000:00:1d.2
> >> >> > PCI: Sharing IRQ 5 with 0000:00:1f.1
> >> >> > ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]
> >> >> MMIO=[ffdff800-ffdfffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> >> >> > PCI: Found IRQ 4 for device 0000:00:1f.5
> >> >> > PCI: Sharing IRQ 4 with 0000:00:1f.3
> >> >> > PCI: Sharing IRQ 4 with 0000:00:1f.6
> >> >> > IRQ routing conflict for 0000:02:03.0, have irq 11, want irq 4
> >> >> > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> >> >> > intel8x0_measure_ac97_clock: measured 55427 usecs
> >> >> > intel8x0: clocking to 48000
> >> >> > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00030d4975701d84]
> >> >> > i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > agpgart: Detected an Intel 865 Chipset.
> >> >> > agpgart: AGP aperture is 64M @ 0xf8000000
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > shpchp: Unknown symbol acpi_get_name
> >> >> > shpchp: Unknown symbol acpi_evaluate_object
> >> >> > kobject_register failed for ehci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
> >> >> (PCI)
> >> >> > kobject_register failed for ohci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c032636c>] bus_add_driver+0x5c/0xa0
> >> >> >  [<c0326e37>] driver_register+0x57/0x90
> >> >> >  [<c02ea732>] __pci_register_driver+0x52/0x80
> >> >> >  [<f8ecf02e>] ohci_hcd_pci_init+0x2e/0x35 [ohci_hcd]
> >> >> >  [<c012e6e2>] sys_init_module+0x102/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for uhci_hcd (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > kobject_register failed for usb_storage (-17)
> >> >> >  [<c02ddf56>] kobject_register+0x36/0x50
> >> >> >  [<c012d0ed>] mod_sysfs_setup+0x3d/0xb0
> >> >> >  [<c012e4c9>] load_module+0x909/0x9f0
> >> >> >  [<c012e623>] sys_init_module+0x43/0x190
> >> >> >  [<c01029c8>] syscall_call+0x7/0xb
> >> >> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> >> >> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> >> >> > NET: Registered protocol family 10
> >> >> > lo: Disabled Privacy Extensions
> >> >> > IPv6 over IPv4 tunneling driver
> >> >> > eth0: no IPv6 routers present
> >> >>
> >> >>
> >> >
> >> >
> >>
> >>
> >
> > ------------------------------------------------------------------------
> >
> > ./log/messages:Feb 22 14:00:59 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -nq xeno_nucleus
> > ./log/messages:Feb 22 14:00:59 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_native
> > ./log/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_rtdm
> > ./log/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_timerbench
> > ./log/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/usr/xenomai/bin/latency
> > ./adm/messages:Feb 22 14:00:59 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -nq xeno_nucleus
> > ./adm/messages:Feb 22 14:00:59 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_native
> > ./adm/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_rtdm
> > ./adm/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/sbin/modprobe -n xeno_timerbench
> > ./adm/messages:Feb 22 14:01:00 (none) sudo:     root : TTY=pts/4 ; PWD=/mnt/appusb/xenomai/share/xenomai/testsuite/latency ; USER=root ; COMMAND=/usr/xenomai/bin/latency
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: I-pipe: Domain Xenomai registered.
> > ./log/syslog:Feb 22 13:21:38 (none) kernel: Xenomai: SMI-enabled chipset found but SMI workaround not enabled (check
> > ./log/messages:Feb 22 13:21:38 (none) kernel: Xenomai: hal/x86 started.
> > ./log/messages:Feb 22 13:21:38 (none) kernel: Xenomai: real-time nucleus v2.3 (Baroque) loaded.
> > ./log/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting native API services.
> > ./log/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting POSIX services.
> > ./log/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting RTDM services.
> > ./log/dmesg:I-pipe: Domain Xenomai registered.
> > ./log/dmesg:Xenomai: hal/x86 started.
> > ./log/dmesg:Xenomai: real-time nucleus v2.3 (Baroque) loaded.
> > ./log/dmesg:Xenomai: SMI-enabled chipset found but SMI workaround not enabled (check
> > ./log/dmesg:Xenomai: starting native API services.
> > ./log/dmesg:Xenomai: starting POSIX services.
> > ./log/dmesg:Xenomai: starting RTDM services.
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: I-pipe: Domain Xenomai registered.
> > ./adm/syslog:Feb 22 13:21:38 (none) kernel: Xenomai: SMI-enabled chipset found but SMI workaround not enabled (check
> > ./adm/messages:Feb 22 13:21:38 (none) kernel: Xenomai: hal/x86 started.
> > ./adm/messages:Feb 22 13:21:38 (none) kernel: Xenomai: real-time nucleus v2.3 (Baroque) loaded.
> > ./adm/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting native API services.
> > ./adm/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting POSIX services.
> > ./adm/messages:Feb 22 13:21:38 (none) kernel: Xenomai: starting RTDM services.
> > ./adm/dmesg:I-pipe: Domain Xenomai registered.
> > ./adm/dmesg:Xenomai: hal/x86 started.
> > ./adm/dmesg:Xenomai: real-time nucleus v2.3 (Baroque) loaded.
> > ./adm/dmesg:Xenomai: SMI-enabled chipset found but SMI workaround not enabled (check
> > ./adm/dmesg:Xenomai: starting native API services.
> > ./adm/dmesg:Xenomai: starting POSIX services.
> > ./adm/dmesg:Xenomai: starting RTDM services.
>
>
>

