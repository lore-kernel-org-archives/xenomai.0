Message-ID: <493116EA.10808@domain.hid>
Date: Sat, 29 Nov 2008 11:18:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <A820268933E41D449CC13B5E097C1E2F0363CE13@domain.hid>
	<A820268933E41D449CC13B5E097C1E2F0363CE15@domain.hid>
	<493099E2.6070502@domain.hid>
In-Reply-To: <493099E2.6070502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] External PCIe device: MSI interrupt install
	hangs up the CPU
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Rubio, Martial" <Martial.Rubio@domain.hid>, jeanfrancois.gilot@domain.hid, "Dupeyrou,
	Gilles" <Gilles.Dupeyrou@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Hi Martial,
> 
> sorry for the late reply, but my work queue suffered from some overflows...
> 
> Rubio, Martial wrote:
>> Hello ...
>>
>> ...  I apologize : pci_bus_read_config_word is an old 32-bit access
>> routine ... 
>> Sorry for my great haste.
>>
>> If I disable CONFIG_PCI_MSI, eth0 is plugged now on a classical PCI IRQ
>> vector 
>> And the init part of PEV1100 (my external PCIe device) does not work
>> (it's normal)
>>
>> So CONFIG_PCI_MSI is mandatory .
>>
>> About PEV1100 after pci_msi_enable (allways in init part) no source of
>> interrupt is still enabled ...
>> So registration can be done (rtdm ...) .
>>
>> BUT : are the MSI interrupts (eth0 & PEV1100) are rightly dispatched ???
>>
>> By viewing attached file, the last function seems to be
>> __ipipe_restore_root
>> And a few lines before irq_tick_handler+0x0/0x14
>> [vxworks_tick_time_module]*
>> As if an interrupt source of PEV1100 has allready been enabled
>> (obviously no).
> 
> The problem is that ipipe calls into Linux services (->MSI->PCI) that
> are not prepared for running in ipipe context:
> 
> ------------[ cut here ]------------
> kernel BUG at kernel/ipipe/core.c:323!
> invalid opcode: 0000 [#1] PREEMPT SMP
> Modules linked in: vxworks_tick_time_module(P) lp parport_pc ppdev
> parport st ide_disk ide_cd_mod ide_core af_packet joydev nfs lockd
> nfs_acl sunrpc autofs4 snd_pcm_oss snd_mixer_oss snd_seq binfmt_misc
> snd_seq_device iptable_filter ip_tables ip6_tables x_tables fuse loop
> dm_mod snd_hda_intel snd_pcm snd_timer snd_page_alloc snd_hwdep snd
> ohci1394 sr_mod ieee1394 shpchp i2c_nforce2 i2c_core forcedeth sg
> pci_hotplug soundcore cdrom k8temp usbhid hid ff_memless ehci_hcd
> ohci_hcd sd_mod usbcore edd ext3 mbcache jbd pata_amd sata_nv libata
> mptsas mptscsih mptbase scsi_transport_sas scsi_mod [last unloaded:
> parport_pc]
> 
> Pid: 12492, comm: tick Tainted: P         (2.6.25-pae #10)
> EIP: 0060:[<c0150a81>] EFLAGS: 00010006 CPU: 0
> EIP is at __ipipe_restore_root+0x1a/0x3f
> EAX: c042c574 EBX: 80850000 ECX: 00000001 EDX: 05de7000
> ESI: 0000004c EDI: 00000000 EBP: d94e7cd4 ESP: d94e7cd4
>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> Process tick (pid: 12492, ti=d94e6000 task=d89f50e0 task.ti=d94e6000)<0>
> I-pipe domain Linux
> Stack: d94e7cdc c02e9519 d94e7cf0 c02786d8 c03d8e9c 00000085 d94e7d44
> d94e7d14
>        c0279732 0000004c 00000004 d94e7d44 00000000 00000000 da0c1000
> 0000004c
>        d94e7d2c c02797b0 0000004c 00000004 d94e7d44 c03d8f00 d94e7d54
> c021a89c
> Call Trace:
>  [<c02e9519>] ? _spin_unlock_irqrestore+0x18/0x36
>  [<c02786d8>] ? pci_conf1_read+0xa4/0xab
>  [<c0279732>] ? raw_pci_read+0x4a/0x55
>  [<c02797b0>] ? pci_read+0x1d/0x22
>  [<c021a89c>] ? pci_bus_read_config_dword+0x40/0x63
>  [<c0221b93>] ? read_msi_msg+0x44/0xbf
>  [<c0110970>] ? set_msi_irq_affinity+0x89/0xd0
>  [<c011316d>] ? __ipipe_set_irq_affinity+0xbd/0xd1
>  [<c014feb8>] ? ipipe_set_irq_affinity+0x41/0x5d
>  [<c0154a43>] ? xnintr_attach+0x98/0x117
>  [<c0186552>] ? rtdm_irq_request+0x23/0x49
>  [<dc711022>] ? irq_tick_handler+0x0/0x14 [vxworks_tick_time_module]
>  [<dc71132e>] ? open_rt+0x82/0xb4 [vxworks_tick_time_module]
>  [<c0185911>] ? __rt_dev_open+0x8d/0x118
>  [<c01875d8>] ? sys_rtdm_open+0x46/0x55
>  [<c0180030>] ? mq_getattr+0x106/0x158
>  [<c0161e0d>] ? hisyscall_event+0x137/0x256
>  [<c015053e>] ? __ipipe_dispatch_event+0xc6/0x1a3
>  [<c0161cd6>] ? hisyscall_event+0x0/0x256
>  [<c0112e37>] ? __ipipe_syscall_root+0x7f/0x112
>  [<c0104a9d>] ? system_call+0x29/0x4a
>  =======================
> 
> Philippe, I recall some issue that turned out to be a similar call into
> pci_read_config - was it resolved in any official ipipe release?
>

Yes, this one is a well-known issue. And no, this has not been solved yet,
mainly because the x86 io_apic and MSI code has been in perpetual state of flux
since ages, so I did not want to fiddle with it until the kernel folks
eventually made their mind about a stable implementation. I plan to address this
in 2.6.28/2.6.29, depending on my work load, unless someone else picks that earlier.

ATM, I-pipe generic and powerpc optimizations + Xenomai scheduling classes
support drain most of my available time, unfortunately.

> However, Martial, you can likely work around it by registering the open
> handler of vxworks_tick_time_module only to open_nrt. That will switch
> the caller of rt_dev_open to secondary (Linux) mode and allow to run
> that service safely. Device opening is almost never time critical (and
> I'm planning to remove open/socket/close_rt handler for Xenomai 2.5 anyway).
> 
> Jan
> 


-- 
Philippe.

