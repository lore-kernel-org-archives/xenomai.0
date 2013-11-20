Message-ID: <528CFE8F.4020908@siemens.com>
Date: Wed, 20 Nov 2013 19:25:19 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
 <528A156C.1070501@xenomai.org> <528A21A9.9050502@siemens.com>
 <528A2486.4030606@xenomai.org> <528A2567.2000105@siemens.com>
 <528A27AF.3060608@xenomai.org> <528A2BB3.9040902@siemens.com>
 <528A2F96.7080302@xenomai.org> <528A3918.4000902@siemens.com>
 <528A3CEB.80909@xenomai.org> <528A446C.5060409@siemens.com>
 <528A4737.8040607@siemens.com>
In-Reply-To: <528A4737.8040607@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Account for
 invalid last_switch.from field
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-11-18 17:58, Jan Kiszka wrote:
> However, stress-testing switchtest with early interrupts also triggers
> this oops once in a while:
> 
> [  279.547820] [Xenomai] closing RTDM file descriptor 0
> [  279.548966] BUG: unable to handle kernel paging request at ffffc90002986f50
> [  279.550668] IP: [<ffffffff8112de10>] xntimer_destroy+0x110/0x290
> [  279.551563] PGD 3f830067 PUD 3f831067 PMD 3c299067 PTE 0
> [  279.552298] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
> [  279.552947] Modules linked in: xt_tcpudp xt_limit xt_pkttype ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw xt_CT ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables ip6table_filter ip6_tables x_tables dm_crypt 9pnet_virtio tpm_tis tpm psmouse microcode 9pnet tpm_bios serio_raw pcspkr e1000 i2c_piix4 floppy intel_agp intel_gtt virtio_pci virtio_blk virtio virtio_ring ahci libahci
> [  279.558564] CPU: 0 PID: 8217 Comm: rtuo_ufpp_ufps2 Not tainted 3.10.19+ #71
> [  279.558564] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  279.558564] task: ffff88003c128900 ti: ffff88003c138000 task.ti: ffff88003c138000
> [  279.558564] RIP: 0010:[<ffffffff8112de10>]  [<ffffffff8112de10>] xntimer_destroy+0x110/0x290
> [  279.558564] RSP: 0000:ffff88003c13b948  EFLAGS: 00010206
> [  279.558564] RAX: ffff88003e2a9288 RBX: ffff88003a5024a8 RCX: ffffffff818471e0
> [  279.558564] RDX: ffffc90002986f48 RSI: dead000000200200 RDI: dead000000100100
> [  279.558564] RBP: ffff88003c13b988 R08: 0000000000000218 R09: ffffffff81669c40
> [  279.558564] R10: ffff88003c13b9a0 R11: ffffffff811a0fbc R12: 0000000000000003
> [  279.558564] R13: 0000000000000000 R14: 0000000000016a90 R15: ffff88003c13b9a0
> [  279.558564] FS:  00007fdd847d2950(0000) GS:ffff88003d400000(0000) knlGS:0000000000000000
> [  279.558564] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  279.558564] CR2: ffffc90002986f50 CR3: 0000000001915000 CR4: 00000000000006f0
> [  279.558564] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  279.558564] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  279.558564] I-pipe domain Linux
> [  279.558564] Stack:
> [  279.558564]  ffff88003bae9260 ffffffff811a0fbc ffffc90002989540 0000000000000000
> [  279.558564]  0000000000000000 0000000000016a90 ffff88003a5024a8 ffff88003c13b9a0
> [  279.558564]  ffff88003c13b9d8 ffffffff8114119f ffff88003c13b9c8 000002b6fdeeead4
> [  279.558564] Call Trace:
> [  279.558564]  [<ffffffff811a0fbc>] ? __vunmap+0x9c/0x110
> [  279.558564]  [<ffffffff8114119f>] rtdm_timer_destroy+0xcf/0x220
> [  279.558564]  [<ffffffff8152e4d2>] rtswitch_close+0xe2/0x120
> [  279.558564]  [<ffffffff8113e2fe>] __rt_dev_close+0x39e/0x900
> [  279.558564]  [<ffffffff8113ea84>] cleanup_process_files+0x1f4/0x2b0
> [  279.558564]  [<ffffffff8114357a>] rtdm_process_detach+0x1a/0x30
> [  279.558564]  [<ffffffff8111f27b>] detach_ppd+0x1b/0x30
> [  279.558564]  [<ffffffff81122d88>] handle_taskexit_event+0x408/0x940
> [  279.558564]  [<ffffffff81125c98>] ipipe_kevent_hook+0x6d8/0x12a0
> [  279.558564]  [<ffffffff810e31a0>] ? rb_commit+0xd0/0x150
> [  279.558564]  [<ffffffff810e3375>] ? ring_buffer_unlock_commit+0x25/0xa0
> [  279.558564]  [<ffffffff810d87ec>] __ipipe_notify_kevent+0x9c/0x130
> [  279.558564]  [<ffffffff8104855d>] do_exit+0x80d/0xb00
> [  279.558564]  [<ffffffff810e3375>] ? ring_buffer_unlock_commit+0x25/0xa0
> [  279.558564]  [<ffffffff810ea023>] ? trace_buffer_unlock_commit+0x43/0x60
> [  279.558564]  [<ffffffff81048a12>] do_group_exit+0x52/0xc0
> [  279.558564]  [<ffffffff81058a92>] get_signal_to_deliver+0x242/0x5f0
> [  279.558564]  [<ffffffff810022a4>] do_signal+0x54/0x640
> [  279.558564]  [<ffffffff810d3b4f>] ? rcu_irq_exit+0xaf/0x100
> [  279.558564]  [<ffffffff810d8a0c>] ? __ipipe_do_sync_stage+0x18c/0x280
> [  279.558564]  [<ffffffff810028f5>] do_notify_resume+0x65/0x90
> [  279.558564]  [<ffffffff81364e5e>] ? trace_hardirqs_on_thunk+0x3a/0x3c
> [  279.558564]  [<ffffffff81651ee7>] int_signal+0x12/0x17
> [  279.558564] Code: 80 00 00 00 48 c7 43 48 00 00 00 00 48 89 43 30 48 8b 83 88 00 00 00 48 bf 00 01 10 00 00 00 ad de 48 be 00 02 20 00 00 00 ad de <48> 89 42 08 48 89 10 48 8b 05 6a 67 82 00 48 89 bb 80 00 00 00 
> [  279.558564] RIP  [<ffffffff8112de10>] xntimer_destroy+0x110/0x290
> [  279.558564]  RSP <ffff88003c13b948>
> [  279.558564] CR2: ffffc90002986f50
> 
> This didn't happen when just catching idx==-1, likely because we are
> still racing somewhere else, and that other change just papered over
> this race.

Here's the analysis: When terminating switchtest, the destruction of
kernel threads is triggered on file descriptor closing during process
cleanup, see the backtrace. rtswitch_close performs rtdm_task_destroy
and even also rtdm_task_join_nrt which are both supposed to return only
when the kernel thread is actually dead, thus when its resources can be
release. That release will happen via vfree in that function, afterward
we destroy the timer - but the kernel threads weren't cleaned up yet
ever time.

The reason is that xnthread_join does not block when called on automatic
process cleanup due to a termination signal - wait_event_interruptible
bails out.

Looks like we need a non-interruptible xnthread_join mode. Additional
parameter to xnthread_join?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

