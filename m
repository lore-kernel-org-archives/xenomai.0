Message-ID: <4DC29BB9.1090709@domain.hid>
Date: Thu, 05 May 2011 14:44:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <505044.35954.qm@domain.hid>
	<4DC2908C.2020501@domain.hid>
In-Reply-To: <4DC2908C.2020501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with the configuration of new system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-05-05 13:57, Jan Kiszka wrote:
> On 2011-05-05 13:48, Franz Engel wrote:
>> Hello,
>>
>> I outline my problem:
>>
>> I tried to install Linux on my new dual-processor system:
>> Ubuntu 10.04, Kernel 2.6.37.6
>> Adeos 2.6.37.6
>> Xenomai 2.5.6
>>
>> My board has two processors with 6 cores per processor.
>>
>> I boot my patched system. Linux starts and after a few seconds the system freezes. And I get the following message over my serial debugging pc:
>> [   31.812461] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>> [   31.835959] IP: [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vector+0x30/0x40
>> [   31.857122] PGD 32bd90067 PUD 332714067 PMD 0
>> [   31.870488] Oops: 0000 [#1] SMP
>> [   31.880213] last sysfs file: /sys/devices/pci0000:00/0000:00:1c.5/0000:02:00.0/irq
>> [   31.902885] CPU 0
>> [   31.908370] Modules linked in: binfmt_misc ppdev dm_crypt snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss e1000e snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device shpchp snd ioatdma dca lp soundcore psmouse snd_page_alloc serio_raw parport
>> [   31.993160]
>> [   31.997632] Pid: 0, comm: swapper Not tainted 2.6.37.6 #1 System manufacturer System Product Name/Z8NA-D6(C)
>> [   32.027194] RIP: 0010:[<ffffffff81023c00>]  [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vector+0x30/0x40
>> [   32.055613] RSP: 0018:ffff8800bee03d08  EFLAGS: 00010046
>> [   32.071502] RAX: 0000000000000000 RBX: ffffffff81c38740 RCX: 0000000000000000
>> [   32.092874] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000020
>> [   32.114246] RBP: ffff8800bee03d08 R08: ffff8800bee0e860 R09: ffff8800bee0e850
>> [   32.135592] R10: ffff8800bee0e848 R11: 0000000000000002 R12: 0000000000032a60
>> [   32.156940] R13: 000000000000e840 R14: ffffffff81c38748 R15: ffff8800bee0c460
>> [   32.178313] FS:  0000000000000000(0000) GS:ffff8800bee00000(0000) knlGS:0000000000000000
>> [   32.202545] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [   32.219757] CR2: 0000000000000018 CR3: 0000000327910000 CR4: 00000000000006f0
>> [   32.241105] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   32.262477] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>> [   32.283850] Process swapper (pid: 0, threadinfo ffffffff81a00000, task ffffffff81a0b020)
>> [   32.308056] Stack:
>> [   32.314063]  ffff8800bee03d58 ffffffff810c0615 ffffffff813ff0ca ffffffff810237d0
>> [   32.336293]  ffffffff81024d95 0000000000000000 0000000000000010 0000000000000017
>> [   32.358525]  ffff8800bee0c460 ffffffff81a01fd8 ffff8800bee03d68 ffffffff810c0e81
>> [   32.380781] Call Trace:
>> [   32.388087]  <IRQ>
>> [   32.394382]  [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3
>> [   32.412375]  [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x230
>> [   32.431146]  [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt+0x0/0x130
>> [   32.452259]  [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_and+0x35/0x70
>> [   32.473631]  [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40
>> [   32.491625]  [<ffffffff8105ad03>] __do_softirq+0x63/0x230
>> [   32.507798]  [<ffffffff8100442e>] call_softirq+0x1e/0x50
>> [   32.523710]  [<ffffffff81005e25>] do_softirq+0xa5/0xe0
>> [   32.539101]  [<ffffffff8105ac15>] irq_exit+0x85/0x90
>> [   32.553976]  [<ffffffff815a70fa>] do_IRQ+0x7a/0x100
>> [   32.568588]  [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3
>> [   32.586579]  [<ffffffff815a7080>] ? do_IRQ+0x0/0x100
>> [   32.601427]  [<ffffffff810c0673>] ? __xirq_end+0x0/0xd
>> [   32.616818]  [<ffffffff815a7080>] ? do_IRQ+0x0/0x100
>> [   32.631666]  [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x120
>> [   32.650439]  [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300
>> [   32.668431]  [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
>> [   32.687465]  [<ffffffff8159f953>] common_interrupt+0x13/0x2c
>> [   32.704415]  <EOI>
>> [   32.710735]  [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2b/0x40
>> [   32.728468]  [<ffffffff8100c01b>] default_idle+0x4b/0xb0
>> [   32.744379]  [<ffffffff81001e7c>] cpu_idle+0xcc/0x150
>> [   32.759513]  [<ffffffff815888b2>] rest_init+0x72/0x80
>> [   32.774646]  [<ffffffff81ab7e62>] start_kernel+0x43d/0x448
>> [   32.791077]  [<ffffffff81ab7321>] x86_64_start_reservations+0x131/0x135
>> [   32.810890]  [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139
>> [   32.829141] Code: 1f 44 00 00 8d 87 00 ef ff ff 83 f8 1f 77 0c 8d 87 ea ef ff ff c9 c3 0f 1f 40 00 e8 cb 61 09 00 31 d2 48 85 c0 74 04 48 8b 50 18 <0f> b6 42 18 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48
>> [   32.887280] RIP  [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vector+0x30/0x40
>> [   32.908704]  RSP <ffff8800bee03d08>
>> [   32.919130] CR2: 0000000000000018
>> [   32.929039] ---[ end trace 8c9c4ef442ceeb7d ]---
>> [   32.942869] Kernel panic - not syncing: Fatal exception in interrupt
>> [   32.961877] Pid: 0, comm: swapper Tainted: G      D     2.6.37.6 #1
>> [   32.980649] Call Trace:
>> [   32.987981]  <IRQ>  [<ffffffff8159bdcf>] panic+0x91/0x1a1
>> [   33.004207]  [<ffffffff81055005>] ? kmsg_dump+0x185/0x1b0
>> [   33.020380]  [<ffffffff815a09b2>] oops_end+0xf2/0x100
>> [   33.035513]  [<ffffffff8103005b>] no_context+0xfb/0x260
>> [   33.051167]  [<ffffffff81576a9d>] ? packet_rcv_spkt+0x4d/0x1a0
>> [   33.068636]  [<ffffffff810302f5>] __bad_area_nosemaphore+0x135/0x1f0
>> [   33.087670]  [<ffffffff810303c3>] bad_area_nosemaphore+0x13/0x20
>> [   33.105661]  [<ffffffff815a32fc>] do_page_fault+0x33c/0x4c0
>> [   33.122357]  [<ffffffff812ec075>] ? blk_complete_request+0x25/0x30
>> [   33.140867]  [<ffffffff813c794f>] ? scsi_done+0x2f/0x70
>> [   33.156521]  [<ffffffff813f024a>] ? ata_scsi_qc_complete+0x6a/0x490
>> [   33.175292]  [<ffffffff813e8386>] ? ata_sg_clean+0x66/0xd0
>> [   33.191725]  [<ffffffff813e8480>] ? __ata_qc_complete+0x90/0x140
>> [   33.209718]  [<ffffffff8101f6b4>] __ipipe_handle_exception+0x144/0x3c0
>> [   33.229270]  [<ffffffff813fdc7b>] ? ata_hsm_qc_complete+0x4b/0x130
>> [   33.247784]  [<ffffffff8159fbe6>] page_fault+0x26/0x70
>> [   33.263176]  [<ffffffff81023c00>] ? __ipipe_get_ioapic_irq_vector+0x30/0x40
>> [   33.284028]  [<ffffffff81023bf5>] ? __ipipe_get_ioapic_irq_vector+0x25/0x40
>> [   33.304882]  [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3
>> [   33.322873]  [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x230
>> [   33.341646]  [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt+0x0/0x130
>> [   33.362758]  [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_and+0x35/0x70
>> [   33.384133]  [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40
>> [   33.402124]  [<ffffffff8105ad03>] __do_softirq+0x63/0x230
>> [   33.418298]  [<ffffffff8100442e>] call_softirq+0x1e/0x50
>> [   33.434209]  [<ffffffff81005e25>] do_softirq+0xa5/0xe0
>> [   33.449601]  [<ffffffff8105ac15>] irq_exit+0x85/0x90
>> [   33.464449]  [<ffffffff815a70fa>] do_IRQ+0x7a/0x100
>> [   33.479062]  [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3
>> [   33.497055]  [<ffffffff815a7080>] ? do_IRQ+0x0/0x100
>> [   33.511926]  [<ffffffff810c0673>] ? __xirq_end+0x0/0xd
>> [   33.527318]  [<ffffffff815a7080>] ? do_IRQ+0x0/0x100
>> [   33.542166]  [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x120
>> [   33.560938]  [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300
>> [   33.578932]  [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
>> [   33.597964]  [<ffffffff8159f953>] common_interrupt+0x13/0x2c
>> [   33.614915]  <EOI>  [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2b/0x40
>> [   33.634469]  [<ffffffff8100c01b>] default_idle+0x4b/0xb0
>> [   33.650381]  [<ffffffff81001e7c>] cpu_idle+0xcc/0x150
>> [   33.665513]  [<ffffffff815888b2>] rest_init+0x72/0x80
>> [   33.680646]  [<ffffffff81ab7e62>] start_kernel+0x43d/0x448
>> [   33.697079]  [<ffffffff81ab7321>] x86_64_start_reservations+0x131/0x135
>> [   33.716892]  [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139
>>
>> When I used a configuration without SMT-support the oops doesn't appear. But so I've only one of twelf available cores. Does somebody has an idea what is wrong?
> 
> No yet. I've already booted your config here, but not on a SMT box and
> with less CPUs.
> 
> First of all, you should note that SMT will increase latencies (I don't
> have numbers, you should measure on your box) as the pseudo cores share
> a lot of resources, thus may have to wait on each other without a chance
> to apply any priorities.
> 
> However, what happens if you leave on SMT but reduce the CPU count
> (maxcpus=6, 4, 2...)?

Ha! Reproduced with virtual kvm 12-core box. /me goes debugging...

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

