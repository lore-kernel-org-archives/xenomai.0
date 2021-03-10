Date: Thu, 11 Mar 2021 01:46:29 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: kernel BUG at kernel/auditsc.c:1527!
Message-ID: <20210310224629.fd6qttrnxock7gwc@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

On Mon, Mar 08, 2021 at 07:12:26AM +0100, xenomai--- via Xenomai wrote:
> Release tag: ipipe-core-4.19.177-cip44-x86-16

This is not appeared first on this release, but (this release too)
crashes when boot on x86_64 with audit enabled (audit=1, which is
default).

Boot console log:

[    4.211383] CPU: 6 PID: 2155 Comm: (journald) Not tainted 4.19.177-xenomai-alt1.cip44.16 #1
[    4.211384] Hardware name: Supermicro Super Server/H11DSi, BIOS 1.2 04/15/2019
[    4.211384] I-pipe domain: Linux
[    4.211389] RIP: 0010:__audit_syscall_entry+0x11f/0x130
[    4.211392] Code: 24 e8 a5 7c ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 83 ff 01 b8 01
[    4.259014] RSP: 0018:ffffc90003a2fe80 EFLAGS: 00010202
[    4.259016] RAX: ffff888214243800 RBX: ffff88821391c000 RCX: 0000000000090800
[    4.259017] RDX: 00007fdee39cf12c RSI: 00000000ffffff9c RDI: ffff888214243800
[    4.259019] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
[    4.285617] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    4.292752] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
[    4.299883] FS:  00007fdee2ea1900(0000) GS:ffff888217b00000(0000) knlGS:0000000000000000
[    4.307969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.313717] CR2: 00007fdee39cf12c CR3: 0000000213aa8000 CR4: 00000000003406e0
[    4.320846] Call Trace:
[    4.323306]  syscall_trace_enter+0x1b5/0x2d0
   [      Startin    4.327577]  ? __do_page_fault+0x267/0x500
[    4.333060]  do_syscall_64+0x127/0x170
[    4.336815]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
g 0;1;39mJourn    4.341865] RIP: 0033:0x7fdee35f1af8
[    4.346823] Code: 24 18 31 c0 41 83 e2 40 75 40 89 f0 25 00 00 41 00 3d 00 00 41 00 74 32 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 48 8b 4c 24 18 64 48 2b 0c 25 28 00 00 00
[    4.365568] RSP: 002b:00007ffd75c13770 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[    4.373135] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fdee35f1af8
[    4.380268] RDX: 0000000000090800 RSI: 00007fdee39cf12c RDI: 00000000ffffff9c
[    4.387398] RBP: 00007ffd75c13870 R08: 0000000000090800 R09: 00007fdee39cf12c
[    4.394533] R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd75c13880
[    4.401665] R13: 0000000000000026 R14: 0000000000000002 R15: 00007ffd75c137e0
[    4.408797] Modules linked in:
[    4.411859] ---[ end trace 7154c6167d14513d ]---
al Service..[    4.416477] RIP: 0010:__audit_syscall_entry+0x11f/0x130
[    4.423081] Code: 24 e8 a5 7c ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 83 ff 01 b8 01
[    4.441825] RSP: 0018:ffffc90003a2fe80 EFLAGS: 00010202
[    4.447051] RAX: ffff888214243800 RBX: ffff88821391c000 RCX: 0000000000090800
[    4.454183] RDX: 00007fdee39cf12c RSI: 00000000ffffff9c RDI: ffff888214243800
[    4.461317] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
[    4.468449] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    4.475582] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
[    4.482716] FS:  00007fdee2ea1900(0000) GS:ffff888217b00000(0000) knlGS:0000000000000000
[    4.490800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.496548] CR2: 00007fdee39cf12c CR3: 0000000213aa8000 CR4: 00000000003406e0
[    4.503684] ------------[ cut here ]------------
.
[    4.508300] kernel BUG at kernel/auditsc.c:1527!
[    4.513605] invalid opcode: 0000 [#2] SMP NOPTI
[    4.513612] systemd[1]: Starting Load Kernel Modules...
[    4.518138] CPU: 7 PID: 2156 Comm: (les-load) Tainted: G      D           4.19.177-xenomai-alt1.cip44.16 #1
[    4.518139] Hardware name: Supermicro Super Server/H11DSi, BIOS 1.2 04/15/2019
[    4.518139] I-pipe domain: Linux
[    4.518141] RIP: 0010:__audit_syscall_entry+0x11f/0x130
[    4.518142] Code: 24 e8 a5 7c ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 83 ff 01 b8 01
[    4.518143] RSP: 0018:ffffc90003a4fe80 EFLAGS: 00010202
[    4.518145] RAX: ffff888214247000 RBX: ffff88821391b800 RCX: 0000000000090800
[    4.518148] RDX: 00007fdee39cf12c RSI: 00000000ffffff9c RDI: ffff888214247000
[    4.586987] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
[    4.586988] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    4.586988] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
[    4.586989] FS:  00007fdee2ea1900(0000) GS:ffff888217b80000(0000) knlGS:0000000000000000
[    4.586992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.622196] CR2: 00007fdee39cf12c CR3: 0000000215ce6000 CR4: 00000000003406e0
[    4.629328] Call Trace:
[    4.631773]  syscall_trace_enter+0x1b5/0x2d0
[    4.636048]  ? __do_page_fault+0x267/0x500
[    4.640145]  do_syscall_64+0x127/0x170
[    4.643900]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.648950] RIP: 0033:0x7fdee35f1af8
[    4.652530] Code: 24 18 31 c0 41 83 e2 40 75 40 89 f0 25 00 00 41 00 3d 00 00 41 00 74 32 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 48 8b 4c 24 18 64 48 2b 0c 25 28 00 00 00
[    4.671276] RSP: 002b:00007ffd75c13790 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[    4.678842] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fdee35f1af8
[    4.685973] RDX: 0000000000090800 RSI: 00007fdee39cf12c RDI: 00000000ffffff9c
[    4.693096] RBP: 00007ffd75c13880 R08: 0000000000090800 R09: 00007fdee39cf12c
[    4.700222] R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd75c13890
[    4.707354] R13: 0000000000000026 R14: 0000000000000002 R15: 00007ffd75c13800
[    4.714488] Modules linked in:
[    4.717549] ---[ end trace 7154c6167d14513e ]---
[    4.722165] RIP: 0010:__audit_syscall_entry+0x11f/0x130
[    4.727392] Code: 24 e8 a5 7c ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 83 ff 01 b8 01
[    4.746139] RSP: 0018:ffffc90003a2fe80 EFLAGS: 00010202
[    4.751362] RAX: ffff888214243800 RBX: ffff88821391c000 RCX: 0000000000090800
[    4.758488] RDX: 00007fdee39cf12c RSI: 00000000ffffff9c RDI: ffff888214243800
[    4.765619] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
[    4.772745] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    4.779877] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
[    4.787010] FS:  00007fdee2ea1900(0000) GS:ffff888217b80000(0000) knlGS:0000000000000000
[    4.795097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.800842] CR2: 00007fdee39cf12c CR3: 0000000215ce6000 CR4: 00000000003406e0
[    4.807979] ------------[ cut here ]------------
[    4.812594] kernel BUG at kernel/auditsc.c:1527!
         Starting Load Kernel Modules...
[   14.372137] invalid opcode: 0000 [#3] SMP NOPTI
[   14.372153] systemd[1]: Starting Create Static Device Nodes in /dev...
[   14.376670] CPU: 6 PID: 2161 Comm: (tmpfiles) Tainted: G      D           4.19.177-xenomai-alt1.cip44.16 #1
[   14.376671] Hardware name: Supermicro Super Server/H11DSi, BIOS 1.2 04/15/2019
[   14.376672] I-pipe domain: Linux
[   14.376674] RIP: 0010:__audit_syscall_entry+0x11f/0x130
[   14.376675] Code: 24 e8 a5 7c ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 83 ff 01 b8 01
[   14.376675] RSP: 0018:ffffc90003a57e80 EFLAGS: 00010202
[   14.376676] RAX: ffff888214240000 RBX: ffff888213919800 RCX: 0000000000090800
[   14.376677] RDX: 00007fdee39cf12c RSI: 00000000ffffff9c RDI: ffff888214240000
[   14.376678] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
[   14.376678] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   14.376679] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
[   14.376681] FS:  00007fdee2ea1900(0000) GS:ffff888217b00000(0000) knlGS:0000000000000000
[   14.476303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.476303] CR2: 00007fdee39cf12c CR3: 0000000215bf4000 CR4: 00000000003406e0
[   14.476304] Call Trace:
[   14.476306]  syscall_trace_enter+0x1b5/0x2d0
[   14.476309]  ? __do_page_fault+0x267/0x500
[   14.499998]  do_syscall_64+0x127/0x170
[   14.503750]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   14.508801] RIP: 0033:0x7fdee35f1af8

Then these 3 traces appear a lot while booting continues until it stops
forever in systemd:

  [***   ] A start job is running for /dev/dis…7e48a8ecbf63 (7min 23s / no limit)

With audit not disabled -15, -16 kernels behave the same. -13 is not
tested. .12 falls into kgdb due to oops:

  [13]kdb> bt
  Stack traceback for pid 5978
  0xffff8882156c0000     5978        1  1   13   R  0xffff8882156c0980
  *(d-sysctl)
  [13]kdb> go
  Catastrophic error detected
  kdb_continue_catastrophic=0, type go a second time if you really want to continue
  [13]kdb> go
  Catastrophic error detected
  kdb_continue_catastrophic=0, attempting to continue
  [  185.352136] invalid opcode: 0000 [#1] SMP NOPTI
  0m][ Finished  clocksource: timekeeping watchdog on CPU18: Marking clocksource 'tsc' as unstable because the skew is too large:
  [  185.352205] systemd[1]: Starting Apply Kernel Variables...
  ;1;39mLoad Kerne[  185.356668] CPU: 13 PID: 5978 Comm: (d-sysctl) Not tainted 4.19.114-xenomai-alt1.cip24.12 #1
  [  185.356670] Hardware name: Supermicro Super Server/H11DSi, BIOS 1.2 04/15/2019
  [  185.356676] I-pipe domain: Linux
  l M[odules.
    185.369268] clocksource:                       'hpet' wd_now: 9ea35940 wd_last: 824d73d mask: ffffffff
  [  185.374748] RIP: 0010:__audit_syscall_entry+0x11f/0x130
  [  185.374752] Code: 24 e8 95 82 ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 31 c0 85 ff 41
  [  185.384559] clocksource:                       'tsc' cs_now: 9625049718 cs_last: 3bd1781f20 mask: ffffffffffffffff
  [  185.391776] RSP: 0018:ffffc900071dbe80 EFLAGS: 00010202
  [  185.395018] tsc: Marking TSC unstable due to clocksource watchdog
  [  185.405694] RAX: ffff8882156c0000 RBX: ffff888214a6e800 RCX: 0000000000090800
  [  185.405698] RDX: 00007f9e120ee12c RSI: 00000000ffffff9c RDI: ffff8882156c0000
  [  185.410952] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
  [  185.429673] RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
  [  185.429674] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
  [  185.429675] R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
  [  185.429677] FS:  00007f9e115b1900(0000) GS:ffff888616880000(0000) knlGS:0000000000000000
  [  185.429678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  185.429679] CR2: 00007f9e120ee12c CR3: 00000002131fe000 CR4: 00000000003406e0
  [  185.429679] Call Trace:
  [  185.429682]  syscall_trace_enter+0x1b5/0x2d0
  [  185.429688]  ? __do_page_fault+0x248/0x4d0
  [  185.440031] sched_clock: Marking unstable (185414188971, -3242020)<-(185881046466, -470105649)
  [  185.445248]  do_syscall_64+0x127/0x170
  [  185.445251]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  [  185.445253] RIP: 0033:0x7f9e11d01af8
  [  185.445258] Code: 24 18 31 c0 41 83 e2 40 75 40 89 f0 25 00 00 41 00 3d 00 00 41 00 74 32 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 48 8b 4c 24 18 64 48 2b 0c 25 28 00 00 00

  Entering kdb (current=0xffff8882156c0000, pid 5978) on processor 13 Oops: (null)
  due to oops @ 0xffffffff8110b6ef
  CPU: 13 PID: 5978 Comm: (d-sysctl) Not tainted 4.19.114-xenomai-alt1.cip24.12 #1
  Hardware name: Supermicro Super Server/H11DSi, BIOS 1.2 04/15/2019
  I-pipe domain: Linux
  RIP: 0010:__audit_syscall_entry+0x11f/0x130
  Code: 24 e8 95 82 ff ff 48 8b 34 24 48 8b 54 24 08 85 c0 48 8b 4c 24 10 4c 8b 44 24 18 0f 84 61 ff ff ff 48 83 c4 20 5b 5d 41 5c c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 31 c0 85 ff 41
  RSP: 0018:ffffc900071dbe80 EFLAGS: 00010202
  RAX: ffff8882156c0000 RBX: ffff888214a6e800 RCX: 0000000000090800
  RDX: 00007f9e120ee12c RSI: 00000000ffffff9c RDI: ffff8882156c0000
  RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000101 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f9e115b1900(0000) GS:ffff888616880000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f9e120ee12c CR3: 00000002131fe000 CR4: 00000000003406e0
  Call Trace:
   syscall_trace_enter+0x1b5/0x2d0
   ? __do_page_fault+0x248/0x4d0
   do_syscall_64+0x127/0x170
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f9e11d01af8
  Code: 24 18 31 c0 41 83 e2 40 75 40 89 f0 25 00 00 41 00 3d 00 00 41 00 74 32 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 48 8b 4c 24 18 64 48 2b 0c 25 28 00 00 00
  RSP: 002b:00007fffb8648630 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f9e11d01af8
  RDX: 0000000000090800 RSI: 00007f9e120ee12c RDI: 00000000ffffff9c
  RBP: 00007fffb8648720 R08: 0000000000090800 R09: 00007f9e120ee12c
  R10: 0000000000000000 R11: 0000000000000287 R12: 00007fffb8648730
  R13: 0000000000000026 R14: 0000000000000002 R15: 00007fffb86486a0

  [13]kdb>



