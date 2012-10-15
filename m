MIME-Version: 1.0
Date: Mon, 15 Oct 2012 10:49:05 -0400
Message-ID: <CAGc_wL0r9=kn-ZaVv6N9d_vYkaY6yW0jc8pjrRnXFbO9hCS=BQ@mail.gmail.com>
From: Julien Delange <julien.delange@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Interrupts error when using analogy drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I recently updated my kernel from 2.8.38 to 3.2.21 and experience
several issues. For now, the system I use has a kernel with the
following parameters :
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_SMP=y

On the other hand, when loading an analogy board, the system
completely hangs with the 3.2.21 while everything appears to be ok
when using the 2.8.38 kernel. Please see the commands below with the
traces. Also, is there any idea about how to debug that and what could
lead to such issue ? It appears to be related to the ipipe patch but I
am not sure and would like to have confirmation of experienced people
:-)

Thanks for any help or suggestion regarding this,

Regards,


When trying to load the analogy card (using analogy_ni_pcimio) and
usign the command analogy_config analogy0 analogy_ni_pcimio, I have
the following kernel error:
Oct 15 15:52:13 xenoimg kernel: Analogy: analogy_ni_pcimio:
pcimio_attach: found pci-6052e board
Oct 15 15:52:13 xenoimg kernel: Analogy: analogy_ni_pcimio:
pcimio_attach: found irq 10
Oct 15 15:52:13 xenoimg kernel: ------------[ cut here ]------------
Oct 15 15:52:13 xenoimg kernel: WARNING: at
arch/x86/kernel/ipipe.c:248 ipipe_set_irq_affinity+0x33/0x85()
Oct 15 15:52:13 xenoimg kernel: Hardware name: SIMATIC IPC847C
Oct 15 15:52:13 xenoimg kernel: Modules linked in: loop i2c_i801
psmouse analogy_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255
analogy_ni_mite xeno_analogy evdev joydev i2c_core serio
_raw usb_storage uas sd_mod crc_t10dif ahci libahci libata scsi_mod
e1000e ehci_hcd [last unloaded: scsi_wait_scan]
Oct 15 15:52:13 xenoimg kernel: Pid: 1149, comm: analogy_config Not
tainted 3.2.21 #2
Oct 15 15:52:13 xenoimg kernel: Call Trace:
Oct 15 15:52:13 xenoimg kernel: [<c1026cf7>] ? warn_slowpath_common+0x6a/0x7b
Oct 15 15:52:13 xenoimg kernel: [<c1012441>] ? ipipe_set_irq_affinity+0x33/0x85
Oct 15 15:52:13 xenoimg kernel: [<c1026d15>] ? warn_slowpath_null+0xd/0x10
Oct 15 15:52:13 xenoimg kernel: [<c1012441>] ? ipipe_set_irq_affinity+0x33/0x85
Oct 15 15:52:13 xenoimg kernel: [<c10706c9>] ? xnintr_attach+0x25/0x157
Oct 15 15:52:13 xenoimg kernel: [<c10a6cf8>] ? rtdm_irq_request+0x21/0x43
Oct 15 15:52:13 xenoimg kernel: [<f8303a78>] ?
a4l_ioctl_insn+0xde/0xde [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<f8303d3f>] ?
__a4l_request_irq+0x26/0x2b [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<f8304721>] ?
a4l_request_irq+0x64/0xa8 [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<c1244dbb>] ? printk+0x78/0xdd
Oct 15 15:52:13 xenoimg kernel: [<f8354c9e>] ?
pcimio_attach+0x573/0x5b1 [analogy_ni_pcimio]
Oct 15 15:52:13 xenoimg kernel: [<f8302d83>] ?
a4l_assign_driver+0x5d/0xe4 [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<f8302fe2>] ?
a4l_device_attach+0x51/0x65 [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<f83032a2>] ?
a4l_ioctl_devcfg+0xb8/0xf2 [xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<f8304832>] ? a4l_ioctl+0x1a/0x1c
[xeno_analogy]
Oct 15 15:52:13 xenoimg kernel: [<c10a5516>] ? __rt_dev_ioctl+0x6d/0x14b
Oct 15 15:52:13 xenoimg kernel: [<c10a7ea8>] ? sys_rtdm_open+0x4a/0x58
Oct 15 15:52:13 xenoimg kernel: [<c10a7e34>] ? sys_rtdm_ioctl+0x15/0x19
Oct 15 15:52:13 xenoimg kernel: [<c107d92c>] ? losyscall_event+0xa8/0x1d9
Oct 15 15:52:13 xenoimg kernel: [<c10653e9>] ? ipipe_syscall_hook+0x2b/0x2e
Oct 15 15:52:13 xenoimg kernel: [<c1064085>] ? __ipipe_notify_syscall+0x70/0xdf
Oct 15 15:52:13 xenoimg kernel: [<c1011fee>] ? __ipipe_syscall_root+0x26/0x9a
Oct 15 15:52:13 xenoimg kernel: [<c124ac38>] ? sysenter_past_esp+0x55/0x6c
Oct 15 15:52:13 xenoimg kernel: ---[ end trace 49933b9006d9c94a ]---



On the other hand, when using the regular kernel, I do not experience
this issue and get the following message when issuing the command:
Oct 15 15:58:14 xenoimg kernel: analogy_mite 0000:11:01.0: found PCI
INT A -> IRQ 10
Oct 15 15:58:14 xenoimg kernel: Analogy: MITE: Available NI device IDs: 0x18b0



There is the configuration of the computer (output of lspci):

00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 02)
00:01.0 PCI bridge: Intel Corporation Core Processor PCI Express x16
Root Port (rev 02)
00:16.0 Communication controller: Intel Corporation 5 Series/3400
Series Chipset HECI Controller (rev 06)
00:19.0 Ethernet controller: Intel Corporation 82577LM Gigabit Network
Connection (rev 05)
00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05)
00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 05)
00:1c.5 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 6 (rev 05)
00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a5)
00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 05)
00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series
Chipset 6 port SATA AHCI Controller (rev 05)
00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 05)
00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
Series Chipset Thermal Subsystem (rev 05)
01:00.0 VGA compatible controller: nVidia Corporation G98 [Quadro NVS
295] (rev a1)
06:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
10:0c.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04)
11:01.0 Unassigned class [ff00]: National Instruments PCI-6052E

