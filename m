MIME-Version: 1.0
Date: Tue, 4 Sep 2012 15:42:31 +0200
Message-ID: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and Ipipe
(d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
I reserved one cpu (kernel param isolcpus=1).

Our application triggers the following NULL pointer dereference when I
set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
The application does not trigger this when all tasks have the same
affinity (set via /proc/xenomai/affinity).

I was able to reproduce this also under QEMU and will do some
debugging, but maybe someone knows what is wrong already by seeing the
stacktrace below:

[  108.013023] BUG: unable to handle kernel NULL pointer dereference at 00000294
[  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
[  108.013901] *pde = 36fa6067 *pte = 00000000
[  108.013901] Oops: 0000 [#1] PREEMPT SMP
[  108.013901] Modules linked in: platform_edge(O) sigmatek_lrt(O) usbhid
[  108.013901]
[  108.013901] Pid: 248, comm: cyclic:217:248 Tainted: G           O
3.4.6+ #62 Bochs Bochs
[  108.013901] EIP: 0060:[<c0126a91>] EFLAGS: 00213002 CPU: 1
[  108.013901] EIP is at __lock_task_sighand+0x53/0xc3
[  108.013901] EAX: 00000294 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  108.013901] ESI: fffffffd EDI: f4b83d44 EBP: f4b83d34 ESP: f4b83d20
[  108.013901]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  108.013901] CR0: 8005003b CR2: 00000294 CR3: 36f9c000 CR4: 00000690
[  108.013901] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  108.013901] DR6: ffff0ff0 DR7: 00000400
[  108.013901] Process cyclic:217:248 (pid: 248, ti=f4b82000
task=f4b48c80 task.ti=f4b82000)
[  108.013901] I-pipe domain Linux
[  108.013901] Stack:
[  108.013901]  00000000 00000294 00000000 fffffffd 00000000 f4b83d54
c0127971 f4b83d7c
[  108.013901]  0000001c 00000000 0000001c 00000000 f4b83dfc f4b83d64
c0127b9b 00000000
[  108.013901]  00001e02 f4b83e08 c0169674 0000001c c05e3e78 f4b83d7c
c056f538 0000001c
[  108.013901] Call Trace:
[  108.013901]  [<c0127971>] do_send_sig_info+0x23/0x5d
[  108.013901]  [<c0127b9b>] send_sig_info+0x19/0x1f
[  108.013901]  [<c0169674>] lostage_handler+0xf6/0x13a
[  108.013901]  [<c015f47a>] rthal_apc_handler+0x65/0x9c
[  108.013901]  [<c0155fbf>] __ipipe_do_sync_stage+0x108/0x15c
[  108.013901]  [<c0156049>] __ipipe_do_sync_pipeline+0x36/0x74
[  108.013901]  [<c0156288>] __ipipe_dispatch_irq+0x152/0x19d
[  108.013901]  [<c01124b5>] __ipipe_handle_irq+0x50/0x106
[  108.013901]  [<c011258a>] ipipe_raise_irq+0x1f/0x27
[  108.013901]  [<c01603a9>] ? xnheap_test_and_free+0x27e/0x288
[  108.013901]  [<c01603a9>] ? xnheap_test_and_free+0x27e/0x288
[  108.013901]  [<c0162669>] __xnpod_schedule+0x36/0x508
[  108.013901]  [<c016858a>] ? xnshadow_ppd_get+0x57/0x64
[  108.013901]  [<c016944a>] xnpod_schedule+0x32/0x34
[  108.013901]  [<c01699af>] taskexit_event+0xe4/0x149
[  108.013901]  [<c0157079>] ipipe_kevent_hook+0x17/0x1a
[  108.013901]  [<c0155ba5>] __ipipe_notify_kevent+0x3d/0x4e
[  108.013901]  [<c011f900>] do_exit+0x1d1/0x66b
[  108.013901]  [<c015703f>] ? ipipe_syscall_hook+0x2e/0x32
[  108.013901]  [<c011fe49>] sys_exit+0x13/0x13
[  108.013901]  [<c03d718a>] syscall_call+0x7/0xb
[  108.013901] Code: 19 d2 9d 83 fa 01 19 d2 81 e2 00 02 00 00 9c fa
64 a1 d8 b3 54 c0 8d 80 fc bc 54 c0 0f ba 28 00 9d 89 17 e8 04 cc 02
00 8b 45 f0 <8b> 30 85 f6 75 1c e8 0d da 02 00 8b 07 f6 c4 02 75 07 b8
01 00
[  108.013901] EIP: [<c0126a91>] __lock_task_sighand+0x53/0xc3 SS:ESP
0068:f4b83d20
[  108.013901] CR2: 0000000000000294
[  108.013901] ---[ end trace e6b28d16f226c997 ]---
[  108.013901] Kernel panic - not syncing: Fatal exception in interrupt

Thanks,
Henri

