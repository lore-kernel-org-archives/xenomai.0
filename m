From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] init: early sync the inband stall with the hardware state
Date: Sat, 31 Jul 2021 11:49:32 +0200
Message-Id: <20210731094934.1799307-3-rpm@xenomai.org>
In-Reply-To: <20210731094934.1799307-1-rpm@xenomai.org>
References: <20210731094934.1799307-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Hard irqs are off when start_kernel() is called from the head code, we
must set the stall accordingly. Failing to do so causes lockdep to
complain, such as:

[    0.000000] DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5525 check_flags+0x193/0x1c0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc1+ #43
[    0.000000] IRQ stage: Linux
[    0.000000] RIP: 0010:check_flags+0x193/0x1c0
[    0.000000] Code: ff ff e8 60 17 ab ff 85 c0 74 21 44 8b 05 3d bb bd 00 45 85 c0 75 15 48 c7 c6 f7 7f 2d 82 48 c7 c7 38 ea 2b 82 e8 91 7c fb ff <0f> 0b 48 c7 c7 b0 95 2d 82 e8 92 ed fb ff e9 5c ff ff ff 65 48 8b
[    0.000000] RSP: 0000:ffffffff82403db8 EFLAGS: 00010096 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000030 RBX: ffffffff8255c6e0 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000002 RSI: ffffffff811c74e4 RDI: 00000000ffffffff
[    0.000000] RBP: ffffffff8242da00 R08: 0000000000000001 R09: 0000000000000000
[    0.000000] R10: ffffffffffffffff R11: 284e4f5f4e524157 R12: ffffffff8242e340
[    0.000000] R13: ffffffff80000200 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff82afb000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff888000013d10 CR3: 0000000002d4c000 CR4: 00000000000000a0
[    0.000000] Call Trace:
[    0.000000]  ? lock_is_held_type+0x6b/0x140
[    0.000000]  ? ___might_sleep+0x26/0x160
[    0.000000]  ? __mutex_lock+0x48/0x8e0
[    0.000000]  ? cgroup_init_subsys+0x26/0x181
[    0.000000]  ? lockdep_init_map_type+0x51/0x260
[    0.000000]  ? lockdep_init_map_type+0x51/0x260
[    0.000000]  ? cgroup_init_subsys+0x26/0x181
[    0.000000]  ? cgroup_init_subsys+0x26/0x181
[    0.000000]  ? cgroup_init_early+0xdd/0xf3
[    0.000000]  ? start_kernel+0x28/0x4ef
[    0.000000]  ? secondary_startup_64_no_verify+0xb0/0xbb
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] random: get_random_bytes called from __warn+0xb9/0x120 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] possible reason: unannotated irqs-on.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index dcc0a764626aba8..259b938d7cd2973 100644
--- a/init/main.c
+++ b/init/main.c
@@ -878,6 +878,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	char *command_line;
 	char *after_dashes;
 
+	stall_inband_nocheck();
 	set_task_stack_end_magic(&init_task);
 	smp_setup_processor_id();
 	debug_objects_early_init();
-- 
2.31.1


