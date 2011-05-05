Message-ID: <505044.35954.qm@domain.hid>
Date: Thu, 5 May 2011 12:48:05 +0100 (BST)
From: Franz Engel <franz_lambert_engel@domain.hid>
In-Reply-To: <4DC2616E.2070301@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1968741166-1304596085=:35954"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0-1968741166-1304596085=:35954
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I outline my problem:

I tried to install Linux on my new dual-processor system:
Ubuntu 10.04, Kernel 2.6.37.6
Adeos 2.6.37.6
Xenomai 2.5.6

My board has two processors with 6 cores per processor.

I boot my patched system. Linux starts and after a few seconds the system f=
reezes. And I get the following message over my serial debugging pc:
[=A0=A0 31.812461] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000018=0D
[=A0=A0 31.835959] IP: [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vector+0=
x30/0x40=0D
[=A0=A0 31.857122] PGD 32bd90067 PUD 332714067 PMD 0=A0=0D
[=A0=A0 31.870488] Oops: 0000 [#1] SMP=A0=0D
[=A0=A0 31.880213] last sysfs file: /sys/devices/pci0000:00/0000:00:1c.5/00=
00:02:00.0/irq=0D
[=A0=A0 31.902885] CPU 0=A0=0D
[=A0=A0 31.908370] Modules linked in: binfmt_misc ppdev dm_crypt snd_hda_in=
tel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss e1000e snd_pcm snd_se=
q_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd=
_timer snd_seq_device shpchp snd ioatdma dca lp soundcore psmouse snd_page_=
alloc serio_raw parport=0D
[=A0=A0 31.993160]=A0=0D
[=A0=A0 31.997632] Pid: 0, comm: swapper Not tainted 2.6.37.6 #1 System man=
ufacturer System Product Name/Z8NA-D6(C)=0D
[=A0=A0 32.027194] RIP: 0010:[<ffffffff81023c00>]=A0 [<ffffffff81023c00>] _=
_ipipe_get_ioapic_irq_vector+0x30/0x40=0D
[=A0=A0 32.055613] RSP: 0018:ffff8800bee03d08=A0 EFLAGS: 00010046=0D
[=A0=A0 32.071502] RAX: 0000000000000000 RBX: ffffffff81c38740 RCX: 0000000=
000000000=0D
[=A0=A0 32.092874] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000=
000000020=0D
[=A0=A0 32.114246] RBP: ffff8800bee03d08 R08: ffff8800bee0e860 R09: ffff880=
0bee0e850=0D
[=A0=A0 32.135592] R10: ffff8800bee0e848 R11: 0000000000000002 R12: 0000000=
000032a60=0D
[=A0=A0 32.156940] R13: 000000000000e840 R14: ffffffff81c38748 R15: ffff880=
0bee0c460=0D
[=A0=A0 32.178313] FS:=A0 0000000000000000(0000) GS:ffff8800bee00000(0000) =
knlGS:0000000000000000=0D
[=A0=A0 32.202545] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b=0D
[=A0=A0 32.219757] CR2: 0000000000000018 CR3: 0000000327910000 CR4: 0000000=
0000006f0=0D
[=A0=A0 32.241105] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000=0D
[=A0=A0 32.262477] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400=0D
[=A0=A0 32.283850] Process swapper (pid: 0, threadinfo ffffffff81a00000, ta=
sk ffffffff81a0b020)=0D
[=A0=A0 32.308056] Stack:=0D
[=A0=A0 32.314063]=A0 ffff8800bee03d58 ffffffff810c0615 ffffffff813ff0ca ff=
ffffff810237d0=0D
[=A0=A0 32.336293]=A0 ffffffff81024d95 0000000000000000 0000000000000010 00=
00000000000017=0D
[=A0=A0 32.358525]=A0 ffff8800bee0c460 ffffffff81a01fd8 ffff8800bee03d68 ff=
ffffff810c0e81=0D
[=A0=A0 32.380781] Call Trace:=0D
[=A0=A0 32.388087]=A0 <IRQ>=A0=0D
[=A0=A0 32.394382]=A0 [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3=
=0D
[=A0=A0 32.412375]=A0 [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x23=
0=0D
[=A0=A0 32.431146]=A0 [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt=
+0x0/0x130=0D
[=A0=A0 32.452259]=A0 [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_an=
d+0x35/0x70=0D
[=A0=A0 32.473631]=A0 [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40=
=0D
[=A0=A0 32.491625]=A0 [<ffffffff8105ad03>] __do_softirq+0x63/0x230=0D
[=A0=A0 32.507798]=A0 [<ffffffff8100442e>] call_softirq+0x1e/0x50=0D
[=A0=A0 32.523710]=A0 [<ffffffff81005e25>] do_softirq+0xa5/0xe0=0D
[=A0=A0 32.539101]=A0 [<ffffffff8105ac15>] irq_exit+0x85/0x90=0D
[=A0=A0 32.553976]=A0 [<ffffffff815a70fa>] do_IRQ+0x7a/0x100=0D
[=A0=A0 32.568588]=A0 [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3=
=0D
[=A0=A0 32.586579]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 32.601427]=A0 [<ffffffff810c0673>] ? __xirq_end+0x0/0xd=0D
[=A0=A0 32.616818]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 32.631666]=A0 [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x12=
0=0D
[=A0=A0 32.650439]=A0 [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300=
=0D
[=A0=A0 32.668431]=A0 [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x=
20=0D
[=A0=A0 32.687465]=A0 [<ffffffff8159f953>] common_interrupt+0x13/0x2c=0D
[=A0=A0 32.704415]=A0 <EOI>=A0=0D
[=A0=A0 32.710735]=A0 [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2b/0x40=0D
[=A0=A0 32.728468]=A0 [<ffffffff8100c01b>] default_idle+0x4b/0xb0=0D
[=A0=A0 32.744379]=A0 [<ffffffff81001e7c>] cpu_idle+0xcc/0x150=0D
[=A0=A0 32.759513]=A0 [<ffffffff815888b2>] rest_init+0x72/0x80=0D
[=A0=A0 32.774646]=A0 [<ffffffff81ab7e62>] start_kernel+0x43d/0x448=0D
[=A0=A0 32.791077]=A0 [<ffffffff81ab7321>] x86_64_start_reservations+0x131/=
0x135=0D
[=A0=A0 32.810890]=A0 [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139=
=0D
[=A0=A0 32.829141] Code: 1f 44 00 00 8d 87 00 ef ff ff 83 f8 1f 77 0c 8d 87=
 ea ef ff ff c9 c3 0f 1f 40 00 e8 cb 61 09 00 31 d2 48 85 c0 74 04 48 8b 50=
 18 <0f> b6 42 18 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48=A0=0D
[=A0=A0 32.887280] RIP=A0 [<ffffffff81023c00>] __ipipe_get_ioapic_irq_vecto=
r+0x30/0x40=0D
[=A0=A0 32.908704]=A0 RSP <ffff8800bee03d08>=0D
[=A0=A0 32.919130] CR2: 0000000000000018=0D
[=A0=A0 32.929039] ---[ end trace 8c9c4ef442ceeb7d ]---=0D
[=A0=A0 32.942869] Kernel panic - not syncing: Fatal exception in interrupt=
=0D
[=A0=A0 32.961877] Pid: 0, comm: swapper Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=
=A0=A0 2.6.37.6 #1=0D
[=A0=A0 32.980649] Call Trace:=0D
[=A0=A0 32.987981]=A0 <IRQ>=A0 [<ffffffff8159bdcf>] panic+0x91/0x1a1=0D
[=A0=A0 33.004207]=A0 [<ffffffff81055005>] ? kmsg_dump+0x185/0x1b0=0D
[=A0=A0 33.020380]=A0 [<ffffffff815a09b2>] oops_end+0xf2/0x100=0D
[=A0=A0 33.035513]=A0 [<ffffffff8103005b>] no_context+0xfb/0x260=0D
[=A0=A0 33.051167]=A0 [<ffffffff81576a9d>] ? packet_rcv_spkt+0x4d/0x1a0=0D
[=A0=A0 33.068636]=A0 [<ffffffff810302f5>] __bad_area_nosemaphore+0x135/0x1=
f0=0D
[=A0=A0 33.087670]=A0 [<ffffffff810303c3>] bad_area_nosemaphore+0x13/0x20=
=0D
[=A0=A0 33.105661]=A0 [<ffffffff815a32fc>] do_page_fault+0x33c/0x4c0=0D
[=A0=A0 33.122357]=A0 [<ffffffff812ec075>] ? blk_complete_request+0x25/0x30=
=0D
[=A0=A0 33.140867]=A0 [<ffffffff813c794f>] ? scsi_done+0x2f/0x70=0D
[=A0=A0 33.156521]=A0 [<ffffffff813f024a>] ? ata_scsi_qc_complete+0x6a/0x49=
0=0D
[=A0=A0 33.175292]=A0 [<ffffffff813e8386>] ? ata_sg_clean+0x66/0xd0=0D
[=A0=A0 33.191725]=A0 [<ffffffff813e8480>] ? __ata_qc_complete+0x90/0x140=
=0D
[=A0=A0 33.209718]=A0 [<ffffffff8101f6b4>] __ipipe_handle_exception+0x144/0=
x3c0=0D
[=A0=A0 33.229270]=A0 [<ffffffff813fdc7b>] ? ata_hsm_qc_complete+0x4b/0x130=
=0D
[=A0=A0 33.247784]=A0 [<ffffffff8159fbe6>] page_fault+0x26/0x70=0D
[=A0=A0 33.263176]=A0 [<ffffffff81023c00>] ? __ipipe_get_ioapic_irq_vector+=
0x30/0x40=0D
[=A0=A0 33.284028]=A0 [<ffffffff81023bf5>] ? __ipipe_get_ioapic_irq_vector+=
0x25/0x40=0D
[=A0=A0 33.304882]=A0 [<ffffffff810c0615>] __ipipe_sync_stage+0x195/0x1f3=
=0D
[=A0=A0 33.322873]=A0 [<ffffffff813ff0ca>] ? ata_bmdma_interrupt+0x18a/0x23=
0=0D
[=A0=A0 33.341646]=A0 [<ffffffff810237d0>] ? smp_irq_move_cleanup_interrupt=
+0x0/0x130=0D
[=A0=A0 33.362758]=A0 [<ffffffff81024d95>] ? physflat_cpu_mask_to_apicid_an=
d+0x35/0x70=0D
[=A0=A0 33.384133]=A0 [<ffffffff810c0e81>] __ipipe_unstall_root+0x31/0x40=
=0D
[=A0=A0 33.402124]=A0 [<ffffffff8105ad03>] __do_softirq+0x63/0x230=0D
[=A0=A0 33.418298]=A0 [<ffffffff8100442e>] call_softirq+0x1e/0x50=0D
[=A0=A0 33.434209]=A0 [<ffffffff81005e25>] do_softirq+0xa5/0xe0=0D
[=A0=A0 33.449601]=A0 [<ffffffff8105ac15>] irq_exit+0x85/0x90=0D
[=A0=A0 33.464449]=A0 [<ffffffff815a70fa>] do_IRQ+0x7a/0x100=0D
[=A0=A0 33.479062]=A0 [<ffffffff810c066d>] __ipipe_sync_stage+0x1ed/0x1f3=
=0D
[=A0=A0 33.497055]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 33.511926]=A0 [<ffffffff810c0673>] ? __xirq_end+0x0/0xd=0D
[=A0=A0 33.527318]=A0 [<ffffffff815a7080>] ? do_IRQ+0x0/0x100=0D
[=A0=A0 33.542166]=A0 [<ffffffff810c0b0e>] __ipipe_walk_pipeline+0x10e/0x12=
0=0D
[=A0=A0 33.560938]=A0 [<ffffffff8101ef2f>] __ipipe_handle_irq+0x13f/0x300=
=0D
[=A0=A0 33.578932]=A0 [<ffffffff810b9ce0>] ? __ipipe_ack_fasteoi_irq+0x0/0x=
20=0D
[=A0=A0 33.597964]=A0 [<ffffffff8159f953>] common_interrupt+0x13/0x2c=0D
[=A0=A0 33.614915]=A0 <EOI>=A0 [<ffffffff8101f2ab>] ? __ipipe_halt_root+0x2=
b/0x40=0D
[=A0=A0 33.634469]=A0 [<ffffffff8100c01b>] default_idle+0x4b/0xb0=0D
[=A0=A0 33.650381]=A0 [<ffffffff81001e7c>] cpu_idle+0xcc/0x150=0D
[=A0=A0 33.665513]=A0 [<ffffffff815888b2>] rest_init+0x72/0x80=0D
[=A0=A0 33.680646]=A0 [<ffffffff81ab7e62>] start_kernel+0x43d/0x448=0D
[=A0=A0 33.697079]=A0 [<ffffffff81ab7321>] x86_64_start_reservations+0x131/=
0x135=0D
[=A0=A0 33.716892]=A0 [<ffffffff81ab7457>] x86_64_start_kernel+0x132/0x139

When I used a configuration without SMT-support the oops doesn't appear. Bu=
t so I've only one of twelf available cores. Does somebody has an idea what=
 is wrong?

regards,
=A0=A0=A0 Franz

--0-1968741166-1304596085=:35954
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hello,<br><br>I outline my problem:<br><br>I =
tried to install Linux on my new dual-processor system:<br>Ubuntu 10.04, Ke=
rnel 2.6.37.6<br>Adeos 2.6.37.6<br>Xenomai 2.5.6<br><br>My board has two pr=
ocessors with 6 cores per processor.<br><br>I boot my patched system. Linux=
 starts and after a few seconds the system freezes. And I get the following=
 message over my serial debugging pc:<br>[&nbsp;&nbsp; 31.812461] BUG: unab=
le to handle kernel NULL pointer dereference at 0000000000000018=0D<br>[&nb=
sp;&nbsp; 31.835959] IP: [&lt;ffffffff81023c00&gt;] __ipipe_get_ioapic_irq_=
vector+0x30/0x40=0D<br>[&nbsp;&nbsp; 31.857122] PGD 32bd90067 PUD 332714067=
 PMD 0&nbsp;=0D<br>[&nbsp;&nbsp; 31.870488] Oops: 0000 [#1] SMP&nbsp;=0D<br=
>[&nbsp;&nbsp; 31.880213] last sysfs file: /sys/devices/pci0000:00/0000:00:=
1c.5/0000:02:00.0/irq=0D<br>[&nbsp;&nbsp; 31.902885] CPU 0&nbsp;=0D<br>[&nb=
sp;&nbsp;
 31.908370] Modules linked in: binfmt_misc ppdev dm_crypt snd_hda_intel snd=
_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss e1000e snd_pcm snd_seq_dummy=
 snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer =
snd_seq_device shpchp snd ioatdma dca lp soundcore psmouse snd_page_alloc s=
erio_raw parport=0D<br>[&nbsp;&nbsp; 31.993160]&nbsp;=0D<br>[&nbsp;&nbsp; 3=
1.997632] Pid: 0, comm: swapper Not tainted 2.6.37.6 #1 System manufacturer=
 System Product Name/Z8NA-D6(C)=0D<br>[&nbsp;&nbsp; 32.027194] RIP: 0010:[&=
lt;ffffffff81023c00&gt;]&nbsp; [&lt;ffffffff81023c00&gt;] __ipipe_get_ioapi=
c_irq_vector+0x30/0x40=0D<br>[&nbsp;&nbsp; 32.055613] RSP: 0018:ffff8800bee=
03d08&nbsp; EFLAGS: 00010046=0D<br>[&nbsp;&nbsp; 32.071502] RAX: 0000000000=
000000 RBX: ffffffff81c38740 RCX: 0000000000000000=0D<br>[&nbsp;&nbsp; 32.0=
92874] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000020=0D=
<br>[&nbsp;&nbsp; 32.114246] RBP: ffff8800bee03d08 R08: ffff8800bee0e860 R0=
9:
 ffff8800bee0e850=0D<br>[&nbsp;&nbsp; 32.135592] R10: ffff8800bee0e848 R11:=
 0000000000000002 R12: 0000000000032a60=0D<br>[&nbsp;&nbsp; 32.156940] R13:=
 000000000000e840 R14: ffffffff81c38748 R15: ffff8800bee0c460=0D<br>[&nbsp;=
&nbsp; 32.178313] FS:&nbsp; 0000000000000000(0000) GS:ffff8800bee00000(0000=
) knlGS:0000000000000000=0D<br>[&nbsp;&nbsp; 32.202545] CS:&nbsp; 0010 DS: =
0000 ES: 0000 CR0: 000000008005003b=0D<br>[&nbsp;&nbsp; 32.219757] CR2: 000=
0000000000018 CR3: 0000000327910000 CR4: 00000000000006f0=0D<br>[&nbsp;&nbs=
p; 32.241105] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000=0D<br>[&nbsp;&nbsp; 32.262477] DR3: 0000000000000000 DR6: 00000000ffff=
0ff0 DR7: 0000000000000400=0D<br>[&nbsp;&nbsp; 32.283850] Process swapper (=
pid: 0, threadinfo ffffffff81a00000, task ffffffff81a0b020)=0D<br>[&nbsp;&n=
bsp; 32.308056] Stack:=0D<br>[&nbsp;&nbsp; 32.314063]&nbsp; ffff8800bee03d5=
8 ffffffff810c0615 ffffffff813ff0ca ffffffff810237d0=0D<br>[&nbsp;&nbsp; 32=
.336293]&nbsp;
 ffffffff81024d95 0000000000000000 0000000000000010 0000000000000017=0D<br>=
[&nbsp;&nbsp; 32.358525]&nbsp; ffff8800bee0c460 ffffffff81a01fd8 ffff8800be=
e03d68 ffffffff810c0e81=0D<br>[&nbsp;&nbsp; 32.380781] Call Trace:=0D<br>[&=
nbsp;&nbsp; 32.388087]&nbsp; &lt;IRQ&gt;&nbsp;=0D<br>[&nbsp;&nbsp; 32.39438=
2]&nbsp; [&lt;ffffffff810c0615&gt;] __ipipe_sync_stage+0x195/0x1f3=0D<br>[&=
nbsp;&nbsp; 32.412375]&nbsp; [&lt;ffffffff813ff0ca&gt;] ? ata_bmdma_interru=
pt+0x18a/0x230=0D<br>[&nbsp;&nbsp; 32.431146]&nbsp; [&lt;ffffffff810237d0&g=
t;] ? smp_irq_move_cleanup_interrupt+0x0/0x130=0D<br>[&nbsp;&nbsp; 32.45225=
9]&nbsp; [&lt;ffffffff81024d95&gt;] ? physflat_cpu_mask_to_apicid_and+0x35/=
0x70=0D<br>[&nbsp;&nbsp; 32.473631]&nbsp; [&lt;ffffffff810c0e81&gt;] __ipip=
e_unstall_root+0x31/0x40=0D<br>[&nbsp;&nbsp; 32.491625]&nbsp; [&lt;ffffffff=
8105ad03&gt;] __do_softirq+0x63/0x230=0D<br>[&nbsp;&nbsp; 32.507798]&nbsp; =
[&lt;ffffffff8100442e&gt;] call_softirq+0x1e/0x50=0D<br>[&nbsp;&nbsp; 32.52=
3710]&nbsp;
 [&lt;ffffffff81005e25&gt;] do_softirq+0xa5/0xe0=0D<br>[&nbsp;&nbsp; 32.539=
101]&nbsp; [&lt;ffffffff8105ac15&gt;] irq_exit+0x85/0x90=0D<br>[&nbsp;&nbsp=
; 32.553976]&nbsp; [&lt;ffffffff815a70fa&gt;] do_IRQ+0x7a/0x100=0D<br>[&nbs=
p;&nbsp; 32.568588]&nbsp; [&lt;ffffffff810c066d&gt;] __ipipe_sync_stage+0x1=
ed/0x1f3=0D<br>[&nbsp;&nbsp; 32.586579]&nbsp; [&lt;ffffffff815a7080&gt;] ? =
do_IRQ+0x0/0x100=0D<br>[&nbsp;&nbsp; 32.601427]&nbsp; [&lt;ffffffff810c0673=
&gt;] ? __xirq_end+0x0/0xd=0D<br>[&nbsp;&nbsp; 32.616818]&nbsp; [&lt;ffffff=
ff815a7080&gt;] ? do_IRQ+0x0/0x100=0D<br>[&nbsp;&nbsp; 32.631666]&nbsp; [&l=
t;ffffffff810c0b0e&gt;] __ipipe_walk_pipeline+0x10e/0x120=0D<br>[&nbsp;&nbs=
p; 32.650439]&nbsp; [&lt;ffffffff8101ef2f&gt;] __ipipe_handle_irq+0x13f/0x3=
00=0D<br>[&nbsp;&nbsp; 32.668431]&nbsp; [&lt;ffffffff810b9ce0&gt;] ? __ipip=
e_ack_fasteoi_irq+0x0/0x20=0D<br>[&nbsp;&nbsp; 32.687465]&nbsp; [&lt;ffffff=
ff8159f953&gt;] common_interrupt+0x13/0x2c=0D<br>[&nbsp;&nbsp; 32.704415]&n=
bsp;
 &lt;EOI&gt;&nbsp;=0D<br>[&nbsp;&nbsp; 32.710735]&nbsp; [&lt;ffffffff8101f2=
ab&gt;] ? __ipipe_halt_root+0x2b/0x40=0D<br>[&nbsp;&nbsp; 32.728468]&nbsp; =
[&lt;ffffffff8100c01b&gt;] default_idle+0x4b/0xb0=0D<br>[&nbsp;&nbsp; 32.74=
4379]&nbsp; [&lt;ffffffff81001e7c&gt;] cpu_idle+0xcc/0x150=0D<br>[&nbsp;&nb=
sp; 32.759513]&nbsp; [&lt;ffffffff815888b2&gt;] rest_init+0x72/0x80=0D<br>[=
&nbsp;&nbsp; 32.774646]&nbsp; [&lt;ffffffff81ab7e62&gt;] start_kernel+0x43d=
/0x448=0D<br>[&nbsp;&nbsp; 32.791077]&nbsp; [&lt;ffffffff81ab7321&gt;] x86_=
64_start_reservations+0x131/0x135=0D<br>[&nbsp;&nbsp; 32.810890]&nbsp; [&lt=
;ffffffff81ab7457&gt;] x86_64_start_kernel+0x132/0x139=0D<br>[&nbsp;&nbsp; =
32.829141] Code: 1f 44 00 00 8d 87 00 ef ff ff 83 f8 1f 77 0c 8d 87 ea ef f=
f ff c9 c3 0f 1f 40 00 e8 cb 61 09 00 31 d2 48 85 c0 74 04 48 8b 50 18 &lt;=
0f&gt; b6 42 18 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48&nbsp;=0D=
<br>[&nbsp;&nbsp; 32.887280] RIP&nbsp; [&lt;ffffffff81023c00&gt;]
 __ipipe_get_ioapic_irq_vector+0x30/0x40=0D<br>[&nbsp;&nbsp; 32.908704]&nbs=
p; RSP &lt;ffff8800bee03d08&gt;=0D<br>[&nbsp;&nbsp; 32.919130] CR2: 0000000=
000000018=0D<br>[&nbsp;&nbsp; 32.929039] ---[ end trace 8c9c4ef442ceeb7d ]-=
--=0D<br>[&nbsp;&nbsp; 32.942869] Kernel panic - not syncing: Fatal excepti=
on in interrupt=0D<br>[&nbsp;&nbsp; 32.961877] Pid: 0, comm: swapper Tainte=
d: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp;&nbsp; 2.6.37.6 #1=0D=
<br>[&nbsp;&nbsp; 32.980649] Call Trace:=0D<br>[&nbsp;&nbsp; 32.987981]&nbs=
p; &lt;IRQ&gt;&nbsp; [&lt;ffffffff8159bdcf&gt;] panic+0x91/0x1a1=0D<br>[&nb=
sp;&nbsp; 33.004207]&nbsp; [&lt;ffffffff81055005&gt;] ? kmsg_dump+0x185/0x1=
b0=0D<br>[&nbsp;&nbsp; 33.020380]&nbsp; [&lt;ffffffff815a09b2&gt;] oops_end=
+0xf2/0x100=0D<br>[&nbsp;&nbsp; 33.035513]&nbsp; [&lt;ffffffff8103005b&gt;]=
 no_context+0xfb/0x260=0D<br>[&nbsp;&nbsp; 33.051167]&nbsp; [&lt;ffffffff81=
576a9d&gt;] ? packet_rcv_spkt+0x4d/0x1a0=0D<br>[&nbsp;&nbsp; 33.068636]&nbs=
p;
 [&lt;ffffffff810302f5&gt;] __bad_area_nosemaphore+0x135/0x1f0=0D<br>[&nbsp=
;&nbsp; 33.087670]&nbsp; [&lt;ffffffff810303c3&gt;] bad_area_nosemaphore+0x=
13/0x20=0D<br>[&nbsp;&nbsp; 33.105661]&nbsp; [&lt;ffffffff815a32fc&gt;] do_=
page_fault+0x33c/0x4c0=0D<br>[&nbsp;&nbsp; 33.122357]&nbsp; [&lt;ffffffff81=
2ec075&gt;] ? blk_complete_request+0x25/0x30=0D<br>[&nbsp;&nbsp; 33.140867]=
&nbsp; [&lt;ffffffff813c794f&gt;] ? scsi_done+0x2f/0x70=0D<br>[&nbsp;&nbsp;=
 33.156521]&nbsp; [&lt;ffffffff813f024a&gt;] ? ata_scsi_qc_complete+0x6a/0x=
490=0D<br>[&nbsp;&nbsp; 33.175292]&nbsp; [&lt;ffffffff813e8386&gt;] ? ata_s=
g_clean+0x66/0xd0=0D<br>[&nbsp;&nbsp; 33.191725]&nbsp; [&lt;ffffffff813e848=
0&gt;] ? __ata_qc_complete+0x90/0x140=0D<br>[&nbsp;&nbsp; 33.209718]&nbsp; =
[&lt;ffffffff8101f6b4&gt;] __ipipe_handle_exception+0x144/0x3c0=0D<br>[&nbs=
p;&nbsp; 33.229270]&nbsp; [&lt;ffffffff813fdc7b&gt;] ? ata_hsm_qc_complete+=
0x4b/0x130=0D<br>[&nbsp;&nbsp; 33.247784]&nbsp; [&lt;ffffffff8159fbe6&gt;]
 page_fault+0x26/0x70=0D<br>[&nbsp;&nbsp; 33.263176]&nbsp; [&lt;ffffffff810=
23c00&gt;] ? __ipipe_get_ioapic_irq_vector+0x30/0x40=0D<br>[&nbsp;&nbsp; 33=
.284028]&nbsp; [&lt;ffffffff81023bf5&gt;] ? __ipipe_get_ioapic_irq_vector+0=
x25/0x40=0D<br>[&nbsp;&nbsp; 33.304882]&nbsp; [&lt;ffffffff810c0615&gt;] __=
ipipe_sync_stage+0x195/0x1f3=0D<br>[&nbsp;&nbsp; 33.322873]&nbsp; [&lt;ffff=
ffff813ff0ca&gt;] ? ata_bmdma_interrupt+0x18a/0x230=0D<br>[&nbsp;&nbsp; 33.=
341646]&nbsp; [&lt;ffffffff810237d0&gt;] ? smp_irq_move_cleanup_interrupt+0=
x0/0x130=0D<br>[&nbsp;&nbsp; 33.362758]&nbsp; [&lt;ffffffff81024d95&gt;] ? =
physflat_cpu_mask_to_apicid_and+0x35/0x70=0D<br>[&nbsp;&nbsp; 33.384133]&nb=
sp; [&lt;ffffffff810c0e81&gt;] __ipipe_unstall_root+0x31/0x40=0D<br>[&nbsp;=
&nbsp; 33.402124]&nbsp; [&lt;ffffffff8105ad03&gt;] __do_softirq+0x63/0x230=
=0D<br>[&nbsp;&nbsp; 33.418298]&nbsp; [&lt;ffffffff8100442e&gt;] call_softi=
rq+0x1e/0x50=0D<br>[&nbsp;&nbsp; 33.434209]&nbsp; [&lt;ffffffff81005e25&gt;=
]
 do_softirq+0xa5/0xe0=0D<br>[&nbsp;&nbsp; 33.449601]&nbsp; [&lt;ffffffff810=
5ac15&gt;] irq_exit+0x85/0x90=0D<br>[&nbsp;&nbsp; 33.464449]&nbsp; [&lt;fff=
fffff815a70fa&gt;] do_IRQ+0x7a/0x100=0D<br>[&nbsp;&nbsp; 33.479062]&nbsp; [=
&lt;ffffffff810c066d&gt;] __ipipe_sync_stage+0x1ed/0x1f3=0D<br>[&nbsp;&nbsp=
; 33.497055]&nbsp; [&lt;ffffffff815a7080&gt;] ? do_IRQ+0x0/0x100=0D<br>[&nb=
sp;&nbsp; 33.511926]&nbsp; [&lt;ffffffff810c0673&gt;] ? __xirq_end+0x0/0xd=
=0D<br>[&nbsp;&nbsp; 33.527318]&nbsp; [&lt;ffffffff815a7080&gt;] ? do_IRQ+0=
x0/0x100=0D<br>[&nbsp;&nbsp; 33.542166]&nbsp; [&lt;ffffffff810c0b0e&gt;] __=
ipipe_walk_pipeline+0x10e/0x120=0D<br>[&nbsp;&nbsp; 33.560938]&nbsp; [&lt;f=
fffffff8101ef2f&gt;] __ipipe_handle_irq+0x13f/0x300=0D<br>[&nbsp;&nbsp; 33.=
578932]&nbsp; [&lt;ffffffff810b9ce0&gt;] ? __ipipe_ack_fasteoi_irq+0x0/0x20=
=0D<br>[&nbsp;&nbsp; 33.597964]&nbsp; [&lt;ffffffff8159f953&gt;] common_int=
errupt+0x13/0x2c=0D<br>[&nbsp;&nbsp; 33.614915]&nbsp; &lt;EOI&gt;&nbsp;
 [&lt;ffffffff8101f2ab&gt;] ? __ipipe_halt_root+0x2b/0x40=0D<br>[&nbsp;&nbs=
p; 33.634469]&nbsp; [&lt;ffffffff8100c01b&gt;] default_idle+0x4b/0xb0=0D<br=
>[&nbsp;&nbsp; 33.650381]&nbsp; [&lt;ffffffff81001e7c&gt;] cpu_idle+0xcc/0x=
150=0D<br>[&nbsp;&nbsp; 33.665513]&nbsp; [&lt;ffffffff815888b2&gt;] rest_in=
it+0x72/0x80=0D<br>[&nbsp;&nbsp; 33.680646]&nbsp; [&lt;ffffffff81ab7e62&gt;=
] start_kernel+0x43d/0x448=0D<br>[&nbsp;&nbsp; 33.697079]&nbsp; [&lt;ffffff=
ff81ab7321&gt;] x86_64_start_reservations+0x131/0x135=0D<br>[&nbsp;&nbsp; 3=
3.716892]&nbsp; [&lt;ffffffff81ab7457&gt;] x86_64_start_kernel+0x132/0x139<=
br><br>When I used a configuration without SMT-support the oops doesn't app=
ear. But so I've only one of twelf available cores. Does somebody has an id=
ea what is wrong?<br><br>regards,<br>&nbsp;&nbsp;&nbsp; Franz<br></td></tr>=
</table>
--0-1968741166-1304596085=:35954--

