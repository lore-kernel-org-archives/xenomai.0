From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
Date: Wed, 16 May 2018 18:13:40 +0000
Message-ID: <42c109690d5e4729812cc187a71dd5b0@P10-EX01.3DSystems.Internal>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Boot failed on arm64 - xenomai_init --> ipipe_send_ipi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to build a xenomai-enabled kernel for an arm64 (quad A53 cores). Something is not configured correctly, but I haven't been able to get past a stall during xenomai_init. Any ideas on what I'm doing wrong? Thanks.

[    0.729547] kvm [1]: 8-bit VMID
[    0.732121] kvm [1]: IDMAP page: 40c5e000
[    0.736134] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    0.742609] kvm [1]: Hyp mode initialized successfully
[    0.747003] kvm [1]: GICv3: no GICV resource entry
[    0.751740] kvm [1]: disabling GICv2 emulation
[    0.756357] kvm [1]: GIC system register CPU interface enabled
[    0.762428] kvm [1]: vgic interrupt IRQ1
[    0.766021] kvm [1]: virtual timer IRQ4
[    0.775341] audit: initializing netlink subsys (disabled)
[    0.777914] audit: type=2000 audit(0.675:1): initialized
[    0.783729] [Xenomai] scheduling class idle registered.
[    0.788506] [Xenomai] scheduling class rt registered.
[   21.795205] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   21.798018]  2-...: (0 ticks this GP) idle=4c9/140000000000000/0 softirq=129/129 fqs=2428
[   21.806295]  (detected by 1, t=5255 jiffies, g=-252, c=-253, q=106)
[   21.812575] Task dump for CPU 2:
[   21.815801] swapper/0       R  running task        0     1      0 0x00000002
[   21.822864] Call trace:
[   21.825315] [<ffff0000080859f4>] __switch_to+0x8c/0xa0
[   21.830456] [<ffff0000084384a8>] gic_raise_softirq+0x58/0x170
[   21.836208] [<ffff00000808dd64>] ipipe_send_ipi+0x24/0x30
[   21.841615] [<ffff000008154f60>] ipipe_critical_enter+0x108/0x1a8
[   21.847719] [<ffff000008156d60>] ipipe_select_timers+0x2d8/0x320
[   21.853736] [<ffff0000091a2440>] xenomai_init+0x158/0x4c4
[   21.859141] [<ffff000008083308>] do_one_initcall+0x38/0x128
[   21.864724] [<ffff000009190d00>] kernel_init_freeable+0x1ac/0x24c
[   21.870828] [<ffff000008c57e40>] kernel_init+0x10/0x100
[   21.876056] [<ffff000008082fe4>] ret_from_fork+0x14/0x30

Thanks,
Kendall Auel, Senior Embedded Software Engineer
3D Systems, 26600 SW Parkway Ave., Suite 300, Dock 61, Wilsonville OR 97070, USA
Tel: +1 503 482 1970   Mobile: +1 503 939 6862   3dsystems.com<http://3dsystems.com/>

[3D-Systems-logo_primary_3-color_light-bkgrd_no-tm]

This e-mail is intended for the exclusive use of the recipients named above and may constitute privileged or confidential information or otherwise be protected from disclosure. Dissemination, distribution, forwarding or copying of this e-mail by anyone other than the intended recipients is prohibited. If you have received this e-mail in error, please notify me immediately by reply e-mail or telephone and completely delete or destroy any and all electronic or other copies of the original message and any attachments to it. Thank you.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 10651 bytes
Desc: image001.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180516/92c0d749/attachment.png>
