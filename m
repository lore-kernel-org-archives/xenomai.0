Message-ID: <52852654.3020404@siemens.com>
Date: Thu, 14 Nov 2013 20:36:52 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <528290CE.1030002@xenomai.org> <52837DD0.1050405@siemens.com>
 <52838180.7070701@xenomai.org> <5283846B.8070004@siemens.com>
In-Reply-To: <5283846B.8070004@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-11-13 14:53, Jan Kiszka wrote:
> On 2013-11-13 14:41, Gilles Chanteperdrix wrote:
>> On 11/13/2013 02:25 PM, Jan Kiszka wrote:
>>> On 2013-11-12 21:34, Gilles Chanteperdrix wrote:
>>>>
>>>> Hi,
>>>>
>>>> for a change, I ran the xeno-regression-test with a lot of debugging and
>>>> options known to having caused problems in the past and found two
>>>> issues:
>>>>
>>>> on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
>>>> debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
>>>> series of warnings at the end of the mail.
>>>
>>> We are currently facing crashes inside __switch_to, FPU related
>>> (non-existing save area).
>>
>> Probably the issue solved by this patch:
>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=9b3320eef67e3f118f96065c8c2584b715710d94
> 
> Thought I had everything, but I lost track, and it's missing here. Will
> merge and give it a try.

OK, this fixes the crash in __switch_to, triggerable by terminating
xeno-test while running clocktest. But we still face a crash when
terminating switchtest early. Are you aware of this?

[   59.563411] [Xenomai] switching rtk1/0 to secondary mode after exception #14 in kernel-space at 0xffffffff815276f4 (pid 4371)
[   59.565408] BUG: unable to handle kernel paging request at ffffd2000235a704
[   59.566032] IP: [<ffffffff815276f4>] rtswitch_to_rt+0x384/0x540
[   59.566039] PGD 0 
[   59.566041] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[   59.566044] Modules linked in: 9p fscache xt_tcpudp xt_limit xt_pkttype ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw xt_CT ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables ip6table_filter ip6_tables x_tables dm_crypt e1000 psmouse 9pnet_virtio 9pnet tpm_tis intel_agp i2c_piix4 tpm floppy serio_raw intel_gtt microcode tpm_bios pcspkr virtio_pci virtio_blk virtio virtio_ring ahci libahci
[   59.566109] CPU: 0 PID: 4371 Comm: rtk1/0 Not tainted 3.10.15+ #42
[   59.566111] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   59.566113] task: ffff88003c187500 ti: ffff88003c4bc000 task.ti: ffff88003c4bc000
[   59.566119] RIP: 0010:[<ffffffff815276f4>]  [<ffffffff815276f4>] rtswitch_to_rt+0x384/0x540
[   59.566121] RSP: 0000:ffff88003c4bfd98  EFLAGS: 00010206
[   59.566123] RAX: 000008fffffff700 RBX: ffff88003af14038 RCX: ffffc9000235b000
[   59.566125] RDX: 00000000ffffffff RSI: 0000000000000002 RDI: ffff88003af14038
[   59.566127] RBP: ffff88003c4bfde8 R08: 0000000000000000 R09: 00000000002a1220
[   59.566129] R10: 0000000000000000 R11: ffff88003d400000 R12: ffffc9000235c200
[   59.566131] R13: ffffd2000235a700 R14: ffff88003af14038 R15: 0000000000000000
[   59.566134] FS:  0000000000000000(0000) GS:ffff88003d400000(0000) knlGS:0000000000000000
[   59.566136] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   59.566138] CR2: ffffd2000235a704 CR3: 000000003c6f2000 CR4: 00000000000006f0
[   59.566147] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.566154] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   59.566155] I-pipe domain Linux
[   59.566157] Stack:
[   59.566162]  ffffc9000235c200 0000000000000002 ffff88003af14038 0000000000000000
[   59.566168]  ffff88003c4bfdc8 0000000000000000 ffffc9000235c200 0000000000000002
[   59.566173]  ffff88003af14038 0000000000000000 ffff88003c4bfe68 ffffffff81527a80
[   59.566175] Call Trace:
[   59.566181]  [<ffffffff81527a80>] rtswitch_ktask+0x70/0x220
[   59.566189]  [<ffffffff8111d733>] ? xnshadow_map_kernel+0x1d3/0x1e0
[   59.566194]  [<ffffffff8111b590>] ? xnshadow_call_mayday+0x90/0x90
[   59.566200]  [<ffffffff811251e0>] ? xnthread_cancel+0x3f0/0x3f0
[   59.566204]  [<ffffffff8112523d>] kthread_trampoline+0x5d/0xb0
[   59.566211]  [<ffffffff8106a48e>] kthread+0xde/0xf0
[   59.566217]  [<ffffffff8106a3b0>] ? flush_kthread_worker+0x100/0x100
[   59.566224]  [<ffffffff8164e1ad>] ret_from_fork+0x7d/0xb0
[   59.566229]  [<ffffffff8106a3b0>] ? flush_kthread_worker+0x100/0x100
[   59.566295] Code: b4 c0 ff 85 c0 0f 85 22 fe ff ff 0f ae f0 c7 05 3f 55 42 00 ff ff ff ff e9 10 fe ff ff 89 d2 48 8d 04 d2 48 c1 e0 08 4c 8d 2c 01 <41> 8b 45 04 83 e0 04 75 2b 4c 89 ab 18 01 00 00 8b bb 20 01 00 
[   59.566297] RIP  [<ffffffff815276f4>] rtswitch_to_rt+0x384/0x540
[   59.566298]  RSP <ffff88003c4bfd98>
[   59.566298] CR2: ffffd2000235a704
[   59.566301] ---[ end trace 251dca1b60fac852 ]---

Can debug this tomorrow - it nicely triggers in my vm.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

