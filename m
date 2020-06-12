MIME-Version: 1.0
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Date: Fri, 12 Jun 2020 11:52:33 +0200
Message-ID: <CAAjAsizNnLcRo4iuosFNerdzb0jiWHHV9ZMrumgQq-Femr92LQ@mail.gmail.com>
Subject: rtdm_munmap() kernel panic on 4.9.x
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have a problem on a kernel module that provide a remapped memory to a
userspace process.
In detail I'm using a kernel 4.9 with ipipe-core-4.9.51-arm-4.patch on a
beaglebone like board and problem occurs when I close the program that use
this module.
In the module close() I call the rtdm_munmap() to free remapped memory but
a kernel panic occurs when program is killed or exited.

I also update to the latest 4.9 LTS kernel version generating
ipipe-core-4.9.224-arm-*.patch wit  xenomai 3.1 but the problem remains.
Following kernel panic refers to this version.

Unable to handle kernel NULL pointer dereference at virtual address 00000038
pgd = c0004000
[00000038] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in: canopen_sync(O) mchpar1xxx davinci_mdio ti_cpsw cpsw_ale
cpsw_common davinci_cpdma omap_rng rng_core xeno_can_c_can_platform
xeno_can_c_ce
CPU: 0 PID: 748 Comm: cobalt_printf Tainted: G        W  O
 4.9.224-mainline-xenomai #1
Hardware name: Generic AM33XX (Flattened Device Tree)
I-pipe domain: Linux
task: de77c380 task.stack: dd29a000
PC is at down_write_killable+0x1c/0x58
LR is at vm_munmap+0x3c/0x6c
pc : [<c0933b0c>]    lr : [<c0264000>]    psr: 60050013
sp : dd29bcd0  ip : c0933b04  fp : dd29bcdc
r10: dd252240  r9 : dd5f24dc  r8 : c1098284
r7 : 00001000  r6 : b6f1b000  r5 : 00000038  r4 : 00000000
r3 : de77c380  r2 : ffff0001  r1 : 00001000  r0 : 00000038
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 9d704019  DAC: 00000051
Process cobalt_printf (pid: 748, stack limit = 0xdd29a218)
Stack: (0xdd29bcd0 to 0xdd29c000)
bcc0:                                     dd29bcfc dd29bce0 c0264000
c0933afc
bce0: dd28b200 dd28b234 00000000 00000000 dd29bd0c dd29bd00 c020eb58
c0263fd0
bd00: dd29bd24 dd29bd10 bf067728 c020eb4c dd28b200 bf068e10 dd29bd3c
dd29bd28
bd20: c020c320 bf0676d4 dd28b200 c0f2d510 dd29bd64 dd29bd40 c020f4b4
c020c2f0
bd40: dd29bd80 dd252240 dd29bd7c dd2bf800 dd5f200c c0210130 dd29bd7c
dd29bd68
bd60: c0210174 c020f41c dd2bf808 dd5f200c dd29bd9c dd29bd80 c0209140
c021013c
bd80: dd5f2000 dd5f200c dd5f2000 00000001 dd29bdac dd29bda0 c0210e50
c0209108
bda0: dd29bdc4 dd29bdb0 c021a4cc c0210e38 c0f36b38 00000000 dd29bdec
dd29bdc8
bdc0: c021a39c c021a42c dd5f2000 00000000 00000000 00000000 00000000
dd29a000
bde0: dd29be14 dd29bdf0 c021b400 c021a304 c02d8e34 c012b8b4 c0f2d510
00000000
be00: 00000000 dd607038 dd29be2c dd29be18 c01bb33c c021b05c dd607000
00000000
be20: dd29be44 dd29be30 c012b8c0 c01bb30c de77c380 dd607000 dd29be6c
dd29be48
be40: c01317c8 c012b878 dd29be6c dd29be58 de77c380 c0fcd9d0 00000009
b6e931e8
be60: dd29be8c dd29be70 c0131ee4 c0131438 00418004 dd29bec8 ffffe000
b6e931e8
be80: dd29bec4 dd29be90 c013d080 c0131e8c dd29bf10 dd268a80 c101af4c
ffffffff
bea0: dd29bfb0 fffffdfc b6e931e8 b6e931ec dd29a000 000000a2 dd29bf8c
dd29bec8
bec0: c010afd0 c013cd54 0000c350 00000000 00000001 00000000 c01810cc
00000009
bee0: 00000001 0000c350 dd29bf88 dd29a000 dd29bf84 dd29bf00 c01826bc
c0934fc4
bf00: 0000c350 00000000 05f6a450 00000000 dd29bf10 dd5b3e38 dd5afa60
00000000
bf20: 4b77d875 00000017 4b771525 00000017 c01816f4 c0f27840 00000000
000002ec
bf40: 00000000 61626f63 705f746c 746e6972 00000066 00000000 de77c380
00000000
bf60: 00000000 c0107da8 dd29bfb0 ffffe000 c0f2c510 c0107da8 dd29a000
000000a2
bf80: dd29bfac dd29bf90 c010b524 c010af58 00000000 b6eee87c b6eee82c
000000a2
bfa0: 00000000 dd29bfb0 c0107b80 c010b4a0 b6eee87c 00000000 b6c364e4
00000000
bfc0: 00000000 b6eee87c b6eee82c 000000a2 b6eee82c b6eee82c b6eee828
b6c35f9c
bfe0: 00000000 b6c35e58 00000000 b6e931e8 800e0010 b6eee87c 00000000
00000000
[<c0933b0c>] (down_write_killable) from [<c0264000>] (vm_munmap+0x3c/0x6c)
[<c0264000>] (vm_munmap) from [<c020eb58>] (rtdm_munmap+0x18/0x1c)
[<c020eb58>] (rtdm_munmap) from [<bf067728>] (canopen_sync_close+0x60/0xdc
[canopen_sync])
[<bf067728>] (canopen_sync_close [canopen_sync]) from [<c020c320>]
(__rtdm_dev_close+0x3c/0x58)
[<c020c320>] (__rtdm_dev_close) from [<c020f4b4>] (__put_fd+0xa4/0x120)
[<c020f4b4>] (__put_fd) from [<c0210174>] (destroy_fd+0x44/0x54)
[<c0210174>] (destroy_fd) from [<c0209140>] (xntree_cleanup+0x44/0x4c)
[<c0209140>] (xntree_cleanup) from [<c0210e50>] (rtdm_fd_cleanup+0x24/0x2c)
[<c0210e50>] (rtdm_fd_cleanup) from [<c021a4cc>]
(cobalt_process_detach+0xac/0x13c)
[<c021a4cc>] (cobalt_process_detach) from [<c021a39c>]
(remove_process+0xa4/0x108)
[<c021a39c>] (remove_process) from [<c021b400>]
(ipipe_kevent_hook+0x3b0/0x4c8)
[<c021b400>] (ipipe_kevent_hook) from [<c01bb33c>]
(__ipipe_notify_kevent+0x3c/0x7c)
[<c01bb33c>] (__ipipe_notify_kevent) from [<c012b8c0>] (mmput+0x54/0x124)
[<c012b8c0>] (mmput) from [<c01317c8>] (do_exit+0x39c/0xa08)
[<c01317c8>] (do_exit) from [<c0131ee4>] (do_group_exit+0x64/0x10c)
[<c0131ee4>] (do_group_exit) from [<c013d080>] (get_signal+0x338/0x8cc)
[<c013d080>] (get_signal) from [<c010afd0>] (do_signal+0x84/0x414)
[<c010afd0>] (do_signal) from [<c010b524>] (do_work_pending+0x90/0xf8)
[<c010b524>] (do_work_pending) from [<c0107b80>]
(slow_work_pending+0xc/0x20)
Code: e52de004 ebdf655b e59f2038 f5d0f000 (e1901f9f)
---[ end trace 1434b98004fcddb0 ]---
Fixing recursive fault but reboot is needed!

Best Regards.

Matteo Facchinetti,
Sirius Electronic Systems
