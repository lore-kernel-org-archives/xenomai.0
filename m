Message-ID: <481AD5C2.6030607@domain.hid>
Date: Fri, 02 May 2008 10:50:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481AA6B5.9070508@domain.hid> <481AC93E.3030107@domain.hid>
In-Reply-To: <481AC93E.3030107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] MSI Interrupt Crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> jeff koftinoff wrote:
>> Hi all,
>>  
>> I am currently writing an rtdm driver for an fpga card.
>> I am using the latest Xenomai version from the svn repository and kernel
>> version 2.6.24.5.
>> This runs on a Core2Duo with a debian 64 bit version.
>> The driver seems to work fine as long as I use legacy interrupts and not
>> MSI's.
>>
>>
>> As soon as I use pci_enable_msi before rtdm_irq_request I get:
>>  
>> [ 4260.359093] fpga_driver :MSI Enabled
>> [ 4260.359095] fpga_driver :IORESOURCE_IRQ IRQ: 248
>> [ 4260.359109] Unable to handle kernel NULL pointer dereference at
>> 0000000000000000 RIP:
>> [ 4260.359113]  [<0000000000000000>]
>> [ 4260.359117] PGD 3b1f7067 PUD 3b1f6067 PMD 0
>> [ 4260.359121] Oops: 0010 [1] SMP
>> [ 4260.359125] CPU 1
>> [ 4260.359127] Modules linked in: fpga_module(P) af_packet binfmt_misc
>> rfcomm l2cap bluetooth ppdev ipv6 sbs container dock video output sbshc
>> battery iptable_filter ip_tables x_tables ac coretemp max6650 sbp2
>> parport_pc lp parport atl1 mii i2c_core psmouse serio_raw button shpchp
>> iTCO_wdt iTCO_vendor_support intel_agp pci_hotplug evdev pcspkr ext3 jbd
>> mbcache sg sr_mod cdrom ata_generic sd_mod pata_acpi usbhid hid ohci1394
>> ieee1394 ahci pata_jmicron libata scsi_mod ehci_hcd uhci_hcd usbcore
>> dm_mirror dm_snapshot dm_mod fan fuse
>> [ 4260.359179] Pid: 7016, comm: insmod Tainted: P        2.6.24.5 #1
>> [ 4260.359181] RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
>> [ 4260.359185] RSP: 0000:ffff81003b23dc80  EFLAGS: 00010246
>> [ 4260.359187] RAX: ffffffff805dc2c0 RBX: 0000000000000000 RCX:
>> ffff810001018780
>> [ 4260.359189] RDX: ffff81008099a000 RSI: 0000000000000000 RDI:
>> 00000000000000f8
>> [ 4260.359192] RBP: ffffffff882cc688 R08: 0000000000000000 R09:
>> 00000000000000c1
>> [ 4260.359194] R10: 0000000000000000 R11: 0000000000000000 R12:
>> ffff81003ee87800
>> [ 4260.359196] R13: ffffffff882cbee0 R14: 0000000000000000 R15:
>> 000000000000000f
>> [ 4260.359198] FS:  00002b43257436e0(0000) GS:ffff81003ec01700(0000)
>> knlGS:0000000000000000
>> [ 4260.359200] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [ 4260.359202] CR2: 0000000000000000 CR3: 0000000032168000 CR4:
>> 00000000000006e0
>> [ 4260.359204] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [ 4260.359206] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
>> 0000000000000400
>> [ 4260.359209] Process insmod (pid: 7016, threadinfo ffff81003b23c000,
>> task ffff810032166fc0)
>> [ 4260.359210] Stack:  ffffffff8041e0ff ffff81003ee87800
>> ffffffff802c8a58 ffff81003ee87800
>> [ 4260.359216]  ffff81003ee87800 ffff81003ee87800 ffffffff882ca374
>> 0000000000000000
>> [ 4260.359221]  ffffffff882ca521 0000000000000001 ffff81003ee87870
>> ffffffff882cc1a0
>> [ 4260.359225] Call Trace:
>> [ 4260.359231]  [<ffffffff8041e0ff>] rthal_irq_enable+0x2f/0x40
>> [ 4260.359236]  [<ffffffff802c8a58>] rtdm_irq_request+0x48/0x60
>> [ 4260.359242]  [<ffffffff882ca374>]
>> :fpga_module:pci_request_resources+0x104/0x1d0
>> [ 4260.359246]  [<ffffffff882ca521>] :fpga_module:pci_probe+0xe1/0x180
>> [ 4260.359250]  [<ffffffff8039ec88>] pci_device_probe+0xf8/0x170
>> [ 4260.359256]  [<ffffffff8040069c>] driver_probe_device+0x9c/0x1b0
>> [ 4260.359259]  [<ffffffff80400969>] __driver_attach+0xc9/0xd0
>> [ 4260.359262]  [<ffffffff804008a0>] __driver_attach+0x0/0xd0
>> [ 4260.359265]  [<ffffffff803ff8dd>] bus_for_each_dev+0x4d/0x80
>> [ 4260.359270]  [<ffffffff803ffcec>] bus_add_driver+0xac/0x220
>> [ 4260.359274]  [<ffffffff8039ef09>] __pci_register_driver+0x69/0xb0
>> [ 4260.359280]  [<ffffffff88069037>] :fpga_module:card_init+0x37/0x64
>> [ 4260.359284]  [<ffffffff802657be>] sys_init_module+0x18e/0x1a90
>> [ 4260.359293]  [<ffffffff80389b28>] _atomic_dec_and_lock+0x48/0x70
>> [ 4260.359298]  [<ffffffff80253330>] param_get_int+0x0/0x20
>> [ 4260.359304]  [<ffffffff8020c3f2>] system_call+0x92/0x97
>> [ 4260.359308]
>> [ 4260.359310]
>> [ 4260.359310] Code:  Bad RIP value.
>> [ 4260.359313] RIP  [<0000000000000000>]
>> [ 4260.359315]  RSP <ffff81003b23dc80>
>> [ 4260.359316] CR2: 0000000000000000
>> [ 4260.359325] ---[ end trace 502b14894d3ed93b ]---
>>  
>> Any advice?
>>
> 
> Does this help?
> 
> --- include/asm-x86/wrappers_64.h	(revision 3719)
> +++ include/asm-x86/wrappers_64.h	(revision 3720)
> @@ -31,8 +31,8 @@
>  #define rthal_irq_descp(irq)		(irq_desc + irq)
>  #define rthal_irq_desc_status(irq)	(rthal_irq_descp(irq)->status)
> 
> -#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->enable(irq); 0; })
> -#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->disable(irq); 0; })
> +#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->unmask(irq); 0; })
> +#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->mask(irq); 0; })

Will probably create a BUG on disable, as not all irq_chips define
unmask IIRC. I'm still puzzled why the always-defined (in theory)
default handlers for enable/disable do not work.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

