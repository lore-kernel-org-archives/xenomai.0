Message-ID: <49B8DCA8.2000703@domain.hid>
Date: Thu, 12 Mar 2009 10:58:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <002501c9a2e8$132712d0$9b00a8c0@domain.hid>
In-Reply-To: <002501c9a2e8$132712d0$9b00a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] vrtx sc_tcreate gives kernel Oops
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
To: Hans Holm <hans.holm@domain.hid>
Cc: xenomai@xenomai.org

Hans Holm wrote:
> Hello gna org,
>  
> When porting and running a vrtx-task ("tercas" working fine in VRTX) to 
> the xenomai-linux environment I always got the below kernel Oops 
> creating/starting the thread.

Confirmed here.

> I use Kernel: 2.6.28.7 and xenomai: 2.4.7.
> If I run other examples like "native/trivial-periodic" this is working fine.
>  
> Please, could someone look at this /var/log/messages log and see why 
> this is not working:

We have a regression in the VRTX skin it seems, due to some interface changes in 
the nucleus. Will fix now.

> Thank you,
> Hans
> 
> Mar 12 09:44:59 localhost kernel: BUG: unable to handle kernel NULL 
> pointer dereference at 00000174
> 
> Mar 12 09:44:59 localhost kernel: IP: [<c046aab2>] rpi_push+0x12/0x230
> 
> Mar 12 09:44:59 localhost kernel: *pde = 7e1a7067
> 
> Mar 12 09:44:59 localhost kernel: Oops: 0000 [#3] PREEMPT SMP
> 
> Mar 12 09:44:59 localhost kernel: last sysfs file: /sys/block/sdf/size
> 
> Mar 12 09:44:59 localhost kernel: Modules linked in: vfat fat xeno_posix 
> xeno_vrtx xeno_native i915 drm autofs4 hidp rfcomm l2cap bluetooth 
> iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter 
> ip6_tables x_tables dm_multipath ipv6 parport_pc lp parport floppy 
> snd_hda_intel snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq 
> snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm sg snd_timer sr_mod snd 
> rtc_cmos cdrom rtc_core e1000e serio_raw soundcore pcspkr rtc_lib 
> snd_page_alloc dm_snapshot dm_zero dm_mirror dm_region_hash dm_log 
> dm_mod usb_storage ata_piix libata sd_mod scsi_mod ehci_hcd ohci_hcd 
> uhci_hcd [last unloaded: microcode]
> 
> Mar 12 09:44:59 localhost kernel:
> 
> Mar 12 09:44:59 localhost kernel: Pid: 16098, comm: tercas Tainted: G D 
> (2.6.28.7 #2) HP Compaq dc5800 Microtower
> 
> Mar 12 09:44:59 localhost kernel: EIP: 0060:[<c046aab2>] EFLAGS: 
> 00010282 CPU: 0
> 
> Mar 12 09:44:59 localhost kernel: EIP is at rpi_push+0x12/0x230
> 
> Mar 12 09:44:59 localhost kernel: EAX: 00000000 EBX: f084d650 ECX: 
> c9fddd50 EDX: 00000000
> 
> Mar 12 09:44:59 localhost kernel: ESI: 00000000 EDI: 00000000 EBP: 
> f084d650 ESP: f0a68e70
> 
> Mar 12 09:44:59 localhost kernel: DS: 007b ES: 007b FS: 00d8 GS: 0033 
> SS: 0068
> 
> Mar 12 09:44:59 localhost kernel: Process tercas (pid: 16098, 
> ti=f0a68000 task=e85c4920 task.ti=f0a68000)
> 
> Mar 12 09:44:59 localhost kernel: I-pipe domain Linux
> 
> Mar 12 09:44:59 localhost kernel: Stack:
> 
> Mar 12 09:44:59 localhost kernel: 00000000 00000003 f084d650 00000000 
> 00000000 00000000 c046be2c f084d650
> 
> Mar 12 09:44:59 localhost kernel: c0862a00 c0466142 c0862a00 00000000 
> 00000000 00000000 c0862a00 0000000a
> 
> Mar 12 09:44:59 localhost kernel: f839e4ea 00000003 f839e270 f084d610 
> f83a64bc f084ce14 f83a6e0c f084d650
> 
> Mar 12 09:44:59 localhost kernel: Call Trace:
> 
> Mar 12 09:44:59 localhost kernel: [<c046be2c>] xnshadow_start+0x2c/0x70
> 
> Mar 12 09:44:59 localhost kernel: [<c0466142>] 
> xnpod_start_thread+0x202/0x3a0
> 
> Mar 12 09:44:59 localhost kernel: [<f839e4ea>] 
> sc_tecreate_inner+0x25a/0x370 [xeno_vrtx]
> 
> Mar 12 09:44:59 localhost kernel: [<f839e270>] 
> vrtxtask_trampoline+0x0/0x20 [xeno_vrtx]
> 
> Mar 12 09:44:59 localhost kernel: [<c06ec5bc>] 
> _spin_unlock_irqrestore+0x1c/0x40
> 
> Mar 12 09:44:59 localhost kernel: [<c045b606>] cpupri_set+0x96/0xc0
> 
> Mar 12 09:44:59 localhost kernel: [<f83a0f78>] __sc_tecreate+0xe8/0x150 
> [xeno_vrtx]
> 
> Mar 12 09:44:59 localhost kernel: [<c046c569>] losyscall_event+0xa9/0x170
> 
> Mar 12 09:44:59 localhost kernel: [<c045a57f>] 
> __ipipe_dispatch_event+0xcf/0x1d0
> 
> Mar 12 09:44:59 localhost kernel: [<c046c4c0>] losyscall_event+0x0/0x170
> 
> Mar 12 09:44:59 localhost kernel: [<c0418073>] 
> __ipipe_syscall_root+0x43/0xf0
> 
> Mar 12 09:44:59 localhost kernel: [<c0403e83>] system_call+0x2b/0x4c
> 
> Mar 12 09:44:59 localhost kernel: Code: 89 f6 c7 03 ff ff ff ff eb e2 eb 
> 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 c5 57 56 53 83 ec 08 89 
> 14 24 8b 80 50 02 00 00 <83> b8 74 01 00 00 01 0f 84 cf 00 00 00 be ff 
> ff ff ff 8b 14 24
> 
> Mar 12 09:44:59 localhost kernel: EIP: [<c046aab2>] rpi_push+0x12/0x230 
> SS:ESP 0068:f0a68e70
> 
> Mar 12 09:44:59 localhost kernel: ---[ end trace 1acdc8335c56771f ]---
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

