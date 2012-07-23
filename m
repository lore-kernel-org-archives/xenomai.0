Message-ID: <500D86BC.3050507@nta-inc.net>
Date: Mon, 23 Jul 2012 12:15:40 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5009DF76.5010306@nta-inc.net> <500A6516.10703@xenomai.org>
	<bc8da858918a991cb436fa7f40576b87.squirrel@www.nta-inc.net>
	<500CF868.70208@xenomai.org>
In-Reply-To: <500CF868.70208@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Lockup with Xenomai 2.6.1 / Linux 3.2.21 after bootup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 07/23/2012 02:08 AM, Gilles Chanteperdrix wrote:
>>> fasteoi irqs have been reworked in the I-pipe core patch (for linux
>>> 3.2). It would be nice if you could check whether 3.2 solves the issue
>>> you have.
>>
>> I did try using linux 3.2.21 (?) with the I-pipe core patch, but the
>> system locks up shortly after the login prompt appears.  I didn't have an
>> easy way to post the stack trace, so I haven't reported that issue yet.  I
>> was going to look through the mailing list archives to see how you
>> recommend collecting useful information to report in this situation, but I
>> haven't had a chance to do that yet.  What's the next step in debugging
>> the problem?
>
>
> If there is a stack trace, it is the best lead. In order to collect it,
> you need another computer, and either use the serial console or
> netconsole. In the past, we have already received photos of a stack trace.
>

I changed the subject line to something more appropriate to avoid confusion, since we're talking about the 3.x series now.  Thanks for the advice -- I was able to get a stack trace using the serial console.  It seems like moving the mouse may have triggered the lockup.  Here is the stack trace:

------------[ cut here ]------------
kernel BUG at arch/x86/kernel/ipipe.c:592!
invalid opcode: 0000 [#1] SMP
CPU 0
Modules linked in: binfmt_misc dm_crypt snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm lp snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timi

Pid: 0, comm: swapper/0 Not tainted 3.2.21-xenomai-2.6.1 #1 Dell Inc. Precision WorkStation T7500  /06FW8P
RIP: 0010:[<ffffffff8101c48c>]  [<ffffffff8101c48c>] __ipipe_handle_irq+0x1bc/0x1d0
RSP: 0018:ffffffff81a03890  EFLAGS: 00010086
RAX: 000000000000d840 RBX: 00000000ffffffff RCX: ffff88033d4ca800
RDX: ffffffffffffffdf RSI: ffffffff81a038c8 RDI: ffffffff81a038a8
RBP: ffffffff81a038b0 R08: 0000000000000001 R09: ffffffffa00459c5
R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000d840
R13: ffffffff81a038a8 R14: ffff88034ae00000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88034ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007f3303f3af88 CR3: 000000034183f000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper/0 (pid: 0, threadinfo ffffffff81a00000, task ffffffff81a0f020)
Stack:
  ffff88033d5e2000 0000000000000006 ffff880037822180 0000000000000006
  ffffffff81a03a18 ffffffff8158f35d ffffffff81a038c8 ffffffff81a03a18
  0000000000000202 0000000000000000 0000000000000001 ffffffffa00459c5
Call Trace:
  [<ffffffff8158f35d>] irq_move_cleanup_interrupt+0x5d/0x90
  [<ffffffffa00459c5>] ? hid_input_report+0x195/0x2b0 [hid]
  [<ffffffffa0049ab1>] ? hidraw_disconnect+0xb1/0x190 [hid]
  [<ffffffffa0045393>] ? hid_report_raw_event+0x103/0x5a0 [hid]
  [<ffffffff8158852a>] ? _raw_spin_unlock_irqrestore+0x2a/0x30
  [<ffffffffa00422cd>] ? hid_debug_event+0xbd/0xd0 [hid]
  [<ffffffffa0045a69>] hid_input_report+0x239/0x2b0 [hid]
  [<ffffffffa005f14c>] hid_irq_in+0x1cc/0x210 [usbhid]
  [<ffffffff81403a0f>] usb_hcd_giveback_urb+0x5f/0xd0
  [<ffffffff81423581>] uhci_giveback_urb+0xb1/0x260
  [<ffffffff81423c64>] uhci_scan_schedule+0x3e4/0xb40
  [<ffffffff8142676c>] uhci_irq+0x6c/0x150
  [<ffffffff81402ea3>] usb_hcd_irq+0x63/0xc0
  [<ffffffff810a25e7>] handle_irq_event_percpu+0x47/0x180
  [<ffffffff810a275b>] handle_irq_event+0x3b/0x60
  [<ffffffff810a559a>] handle_fasteoi_irq+0x4a/0xa0
  [<ffffffff8100435d>] handle_irq+0x1d/0x30
  [<ffffffff81003a81>] do_IRQ+0x61/0xf0
  [<ffffffff81003a20>] ? smp_x86_platform_ipi+0x50/0x50
  [<ffffffff8101caee>] __ipipe_do_IRQ+0x7e/0x90
  [<ffffffff8101caf4>] ? __ipipe_do_IRQ+0x84/0x90
  [<ffffffff810ab6b6>] __ipipe_do_sync_stage+0x156/0x160
  [<ffffffff810ab75d>] __ipipe_do_sync_pipeline+0x9d/0xb0
  [<ffffffff810ac58f>] __ipipe_dispatch_irq+0x10f/0x1d0
  [<ffffffff8101c33c>] __ipipe_handle_irq+0x6c/0x1d0
  [<ffffffff815886a0>] common_interrupt+0x60/0x7d
  [<ffffffff8101c5e6>] ? __ipipe_halt_root+0x26/0x40
  [<ffffffff8158bd55>] ? atomic_notifier_call_chain+0x15/0x20
  [<ffffffff8100a1e7>] default_idle+0x27/0x40
  [<ffffffff81002094>] cpu_idle+0xc4/0x110
  [<ffffffff8157184d>] rest_init+0x6d/0x80
  [<ffffffff81a9dd09>] start_kernel+0x3f3/0x3fe
  [<ffffffff81a9d321>] x86_64_start_reservations+0x131/0x135
  [<ffffffff81a9d456>] x86_64_start_kernel+0x131/0x138
Code: ff ff 0f 1f 44 00 00 48 83 a0 38 07 00 00 fe 4c 89 ee bf 20 00 00 00 e8 53 ee 08 00 e9 f1 fe ff ff be 01 00 00 00 e9 a6 fe ff ff <0f> 0b 66 90 eb fc 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55
RIP  [<ffffffff8101c48c>] __ipipe_handle_irq+0x1bc/0x1d0
  RSP <ffffffff81a03890>
Kernel panic - not syncing: Fatal exception in interrupt
Pid: 0, comm: swapper/0 Tainted: G      D      3.2.21-xenomai-2.6.1 #1
Call Trace:
  [<ffffffff81585232>] panic+0x8c/0x1a0
  [<ffffffff8158937a>] oops_end+0xea/0xf0
  [<ffffffff81005626>] die+0x56/0x90
  [<ffffffff81588d34>] do_trap+0xc4/0x170
  [<ffffffff810034e0>] do_invalid_op+0x90/0xb0
  [<ffffffff8101c48c>] ? __ipipe_handle_irq+0x1bc/0x1d0
  [<ffffffff8118e654>] ? send_sigio+0x84/0xf0
  [<ffffffff8101c877>] __ipipe_handle_exception+0xf7/0x280
  [<ffffffff81590eac>] invalid_op+0x1c/0x60
  [<ffffffffa00459c5>] ? hid_input_report+0x195/0x2b0 [hid]
  [<ffffffff8101c48c>] ? __ipipe_handle_irq+0x1bc/0x1d0
  [<ffffffff8158f35d>] irq_move_cleanup_interrupt+0x5d/0x90
  [<ffffffffa00459c5>] ? hid_input_report+0x195/0x2b0 [hid]
  [<ffffffffa0049ab1>] ? hidraw_disconnect+0xb1/0x190 [hid]
  [<ffffffffa0045393>] ? hid_report_raw_event+0x103/0x5a0 [hid]
  [<ffffffff8158852a>] ? _raw_spin_unlock_irqrestore+0x2a/0x30
  [<ffffffffa00422cd>] ? hid_debug_event+0xbd/0xd0 [hid]
  [<ffffffffa0045a69>] hid_input_report+0x239/0x2b0 [hid]
  [<ffffffffa005f14c>] hid_irq_in+0x1cc/0x210 [usbhid]
  [<ffffffff81403a0f>] usb_hcd_giveback_urb+0x5f/0xd0
  [<ffffffff81423581>] uhci_giveback_urb+0xb1/0x260
  [<ffffffff81423c64>] uhci_scan_schedule+0x3e4/0xb40
  [<ffffffff8142676c>] uhci_irq+0x6c/0x150
  [<ffffffff81402ea3>] usb_hcd_irq+0x63/0xc0
  [<ffffffff810a25e7>] handle_irq_event_percpu+0x47/0x180
  [<ffffffff810a275b>] handle_irq_event+0x3b/0x60
  [<ffffffff810a559a>] handle_fasteoi_irq+0x4a/0xa0
  [<ffffffff8100435d>] handle_irq+0x1d/0x30
  [<ffffffff81003a81>] do_IRQ+0x61/0xf0
  [<ffffffff81003a20>] ? smp_x86_platform_ipi+0x50/0x50
  [<ffffffff8101caee>] __ipipe_do_IRQ+0x7e/0x90
  [<ffffffff8101caf4>] ? __ipipe_do_IRQ+0x84/0x90
  [<ffffffff810ab6b6>] __ipipe_do_sync_stage+0x156/0x160
  [<ffffffff810ab75d>] __ipipe_do_sync_pipeline+0x9d/0xb0
  [<ffffffff810ac58f>] __ipipe_dispatch_irq+0x10f/0x1d0
  [<ffffffff8101c33c>] __ipipe_handle_irq+0x6c/0x1d0
  [<ffffffff815886a0>] common_interrupt+0x60/0x7d
  [<ffffffff8101c5e6>] ? __ipipe_halt_root+0x26/0x40
  [<ffffffff8158bd55>] ? atomic_notifier_call_chain+0x15/0x20
  [<ffffffff8100a1e7>] default_idle+0x27/0x40
  [<ffffffff81002094>] cpu_idle+0xc4/0x110
  [<ffffffff8157184d>] rest_init+0x6d/0x80
  [<ffffffff81a9dd09>] start_kernel+0x3f3/0x3fe
  [<ffffffff81a9d321>] x86_64_start_reservations+0x131/0x135
  [<ffffffff81a9d456>] x86_64_start_kernel+0x131/0x138
---[ end trace 3d7c3b7c137c1c5c ]---
do_IRQ: 30 callbacks suppressed
do_IRQ: 0.153 No irq handler for vector (irq -1)


