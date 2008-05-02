Message-ID: <481AA6B5.9070508@domain.hid>
Date: Thu, 01 May 2008 22:29:25 -0700
From: jeff koftinoff <jeffk@domain.hid>
MIME-Version: 1.0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] MSI Interrupt Crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<div class="moz-text-html" lang="x-western">
<div class="Section1">
<p class="MsoNormal"><font color="#444444" face="Verdana" size="2"><span
 style="font-size: 10pt; font-family: Verdana; color: rgb(68, 68, 68);">Hi
all,<br>
&nbsp;<br>
I am currently writing an rtdm driver for an fpga card.<br>
I am using the latest Xenomai version from the svn repository and
kernel
version 2.6.24.5.<br>
This runs on a Core2Duo with a debian 64 bit version.<br>
The driver seems to work fine as long as I use legacy interrupts and
not MSI's.<o:p></o:p></span></font></p>
<p class="MsoNormal"><font color="#444444" face="Verdana" size="2"><span
 style="font-size: 10pt; font-family: Verdana; color: rgb(68, 68, 68);"><br>
As soon as I use pci_enable_msi before rtdm_irq_request I get:<br>
&nbsp;<br>
[ 4260.359093] fpga_driver :MSI Enabled<br>
[ 4260.359095] fpga_driver :IORESOURCE_IRQ IRQ: 248<br>
[ 4260.359109] Unable to handle kernel NULL pointer dereference at
0000000000000000 RIP: <br>
[ 4260.359113]&nbsp; [&lt;0000000000000000&gt;]<br>
[ 4260.359117] PGD 3b1f7067 PUD 3b1f6067 PMD 0 <br>
[ 4260.359121] Oops: 0010 [1] SMP <br>
[ 4260.359125] CPU 1 <br>
[ 4260.359127] Modules linked in: fpga_module(P) af_packet binfmt_misc
rfcomm
l2cap bluetooth ppdev ipv6 sbs container dock video output sbshc
battery
iptable_filter ip_tables x_tables ac coretemp max6650 sbp2 parport_pc
lp
parport atl1 mii i2c_core psmouse serio_raw button shpchp iTCO_wdt
iTCO_vendor_support intel_agp pci_hotplug evdev pcspkr ext3 jbd mbcache
sg
sr_mod cdrom ata_generic sd_mod pata_acpi usbhid hid ohci1394 ieee1394
ahci
pata_jmicron libata scsi_mod ehci_hcd uhci_hcd usbcore dm_mirror
dm_snapshot
dm_mod fan fuse<br>
[ 4260.359179] Pid: 7016, comm: insmod Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.6.24.5 #1<br>
[ 4260.359181] RIP: 0010:[&lt;0000000000000000&gt;]&nbsp;
[&lt;0000000000000000&gt;]<br>
[ 4260.359185] RSP: 0000:ffff81003b23dc80&nbsp; EFLAGS: 00010246<br>
[ 4260.359187] RAX: ffffffff805dc2c0 RBX: 0000000000000000 RCX:
ffff810001018780<br>
[ 4260.359189] RDX: ffff81008099a000 RSI: 0000000000000000 RDI:
00000000000000f8<br>
[ 4260.359192] RBP: ffffffff882cc688 R08: 0000000000000000 R09:
00000000000000c1<br>
[ 4260.359194] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff81003ee87800<br>
[ 4260.359196] R13: ffffffff882cbee0 R14: 0000000000000000 R15:
000000000000000f<br>
[ 4260.359198] FS:&nbsp; 00002b43257436e0(0000) GS:ffff81003ec01700(0000)
knlGS:0000000000000000<br>
[ 4260.359200] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000000008005003b<br>
[ 4260.359202] CR2: 0000000000000000 CR3: 0000000032168000 CR4:
00000000000006e0<br>
[ 4260.359204] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000<br>
[ 4260.359206] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400<br>
[ 4260.359209] Process insmod (pid: 7016, threadinfo ffff81003b23c000,
task
ffff810032166fc0)<br>
[ 4260.359210] Stack:&nbsp; ffffffff8041e0ff ffff81003ee87800
ffffffff802c8a58
ffff81003ee87800<br>
[ 4260.359216]&nbsp; ffff81003ee87800 ffff81003ee87800 ffffffff882ca374
0000000000000000<br>
[ 4260.359221]&nbsp; ffffffff882ca521 0000000000000001 ffff81003ee87870
ffffffff882cc1a0<br>
[ 4260.359225] Call Trace:<br>
[ 4260.359231]&nbsp; [&lt;ffffffff8041e0ff&gt;] rthal_irq_enable+0x2f/0x40<br>
[ 4260.359236]&nbsp; [&lt;ffffffff802c8a58&gt;] rtdm_irq_request+0x48/0x60<br>
[ 4260.359242]&nbsp; [&lt;ffffffff882ca374&gt;]
:fpga_module:pci_request_resources+0x104/0x1d0<br>
[ 4260.359246]&nbsp; [&lt;ffffffff882ca521&gt;]
:fpga_module:pci_probe+0xe1/0x180<br>
[ 4260.359250]&nbsp; [&lt;ffffffff8039ec88&gt;] pci_device_probe+0xf8/0x170<br>
[ 4260.359256]&nbsp; [&lt;ffffffff8040069c&gt;]
driver_probe_device+0x9c/0x1b0<br>
[ 4260.359259]&nbsp; [&lt;ffffffff80400969&gt;] __driver_attach+0xc9/0xd0<br>
[ 4260.359262]&nbsp; [&lt;ffffffff804008a0&gt;] __driver_attach+0x0/0xd0<br>
[ 4260.359265]&nbsp; [&lt;ffffffff803ff8dd&gt;] bus_for_each_dev+0x4d/0x80<br>
[ 4260.359270]&nbsp; [&lt;ffffffff803ffcec&gt;] bus_add_driver+0xac/0x220<br>
[ 4260.359274]&nbsp; [&lt;ffffffff8039ef09&gt;]
__pci_register_driver+0x69/0xb0<br>
[ 4260.359280]&nbsp; [&lt;ffffffff88069037&gt;]
:fpga_module:card_init+0x37/0x64<br>
[ 4260.359284]&nbsp; [&lt;ffffffff802657be&gt;] sys_init_module+0x18e/0x1a90<br>
[ 4260.359293]&nbsp; [&lt;ffffffff80389b28&gt;]
_atomic_dec_and_lock+0x48/0x70<br>
[ 4260.359298]&nbsp; [&lt;ffffffff80253330&gt;] param_get_int+0x0/0x20<br>
[ 4260.359304]&nbsp; [&lt;ffffffff8020c3f2&gt;] system_call+0x92/0x97<br>
[ 4260.359308] <br>
[ 4260.359310] <br>
[ 4260.359310] Code:&nbsp; Bad RIP value.<br>
[ 4260.359313] RIP&nbsp; [&lt;0000000000000000&gt;]<br>
[ 4260.359315]&nbsp; RSP &lt;ffff81003b23dc80&gt;<br>
[ 4260.359316] CR2: 0000000000000000<br>
[ 4260.359325] ---[ end trace 502b14894d3ed93b ]---<br>
&nbsp;<br>
Any advice?<br>
</span></font></p>
<p class="MsoNormal"><font color="#444444" face="Verdana" size="2"><span
 style="font-size: 10pt; font-family: Verdana; color: rgb(68, 68, 68);">Jeff
and Thomas</span></font><font face="Arial" size="2"><span
 style="font-size: 10pt; font-family: Arial;"><o:p></o:p></span></font></p>
</div>
<br>
</div>
</body>
</html>

