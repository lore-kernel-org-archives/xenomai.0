From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 4/7] cobalt: posix/cond: Add missing input validations
Date: Wed,  5 Jan 2022 15:06:47 +0100
Message-Id: <20220105140650.1033850-5-florian.bezdeka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The following validation issues have been addressed:

  - __cobalt_cond_wait_prologue() missed validating the supplied
    pointers after the registry lookup which could fail. That triggered
    the kernel OOPS dumped below

  - The check removed from cobalt_cond_timedwait_prologue() is now
    already done in __cobalt_cond_wait_prologue()

  - The entry point for the cond_wait_epilogue syscall missed the same
    validations

  - __cobalt_cond_wait_prologue() missed the validation for the
    supplied timeout

[   21.254929] BUG: kernel NULL pointer dereference, address: 0000000000000078
[   21.254930] #PF: supervisor read access in kernel mode
[   21.254931] #PF: error_code(0x0000) - not-present page
[   21.254932] PGD 0 P4D 0
[   21.254933] Oops: 0000 [#1] SMP NOPTI IRQ_PIPELINE
[   21.254934] CPU: 1 PID: 271 Comm: smokey Not tainted 5.10.76+ #54
[   21.254935] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[   21.254935] IRQ stage: Linux
[   21.254936] RIP: 0010:__cobalt_cond_wait_prologue+0x28c/0x430
[   21.254937] Code: 48 d1 e8 83 e0 01 49 39 c5 0f 85 10 01 00 00 48 83 7b 78 00 45 89 f8 44 89 f8 45 89 e7 0f 85 ed 00 00 00b
[   21.254937] RSP: 0018:ffffc90000843e30 EFLAGS: 00010246
[   21.254938] RAX: fffffffffffffff2 RBX: 0000000000000000 RCX: 0000000000000000
[   21.254938] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   21.254938] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   21.254939] R10: 0000000000019000 R11: 0000000000000000 R12: ffffc9000061c408
[   21.254939] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8118f400
[   21.254939] FS:  00007fdfe9f79680(0000) GS:ffff88803e880000(0000) knlGS:0000000000000000
[   21.254939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.254940] CR2: 0000000000000078 CR3: 0000000004108000 CR4: 00000000003506e0
[   21.254940] Call Trace:
[   21.254940]  ? dovetail_leave_inband+0xdc/0x120
[   21.254940]  ? CoBaLt_cond_wait_prologue+0x30/0x30
[   21.254941]  CoBaLt_cond_wait_prologue64+0x1e/0x30
[   21.254941]  handle_root_syscall+0xe0/0x2d0
[   21.254941]  __pipeline_syscall+0xb3/0x230
[   21.254941]  ? vfs_write+0x14d/0x270
[   21.254942]  pipeline_syscall+0x33/0xe0
[   21.254942]  syscall_enter_from_user_mode+0x23/0x80
[   21.254942]  do_syscall_64+0xf/0x50
[   21.254942]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   21.254943] RIP: 0033:0x5617e786b83d
[   21.254943] Code: 00 00 00 00 48 c7 45 c8 00 00 00 00 4c 8b 45 e8 4c 8b 55 e0 48 8b 55 d8 48 8b 75 d0 48 8b 7d c8 8b 45 f05
[   21.254943] RSP: 002b:00007ffd22b84db0 EFLAGS: 00000202 ORIG_RAX: 0000000010000073
[   21.254944] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00005617e786b83d
[   21.254944] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   21.254945] RBP: 00007ffd22b84f40 R08: 0000000000000000 R09: 0000000000000001
[   21.254945] R10: 0000000000000000 R11: 0000000000000202 R12: 00005617e7848e60
[   21.254945] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   21.254946] Modules linked in:
[   21.254946] CR2: 0000000000000078
[   21.254946] ---[ end trace 4f2931a73a5a875d ]---
[   21.254946] RIP: 0010:__cobalt_cond_wait_prologue+0x28c/0x430
[   21.254947] Code: 48 d1 e8 83 e0 01 49 39 c5 0f 85 10 01 00 00 48 83 7b 78 00 45 89 f8 44 89 f8 45 89 e7 0f 85 ed 00 00 00b
[   21.254947] RSP: 0018:ffffc90000843e30 EFLAGS: 00010246
[   21.254948] RAX: fffffffffffffff2 RBX: 0000000000000000 RCX: 0000000000000000
[   21.254948] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   21.254948] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   21.254949] R10: 0000000000019000 R11: 0000000000000000 R12: ffffc9000061c408
[   21.254949] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8118f400
[   21.254949] FS:  00007fdfe9f79680(0000) GS:ffff88803e880000(0000) knlGS:0000000000000000
[   21.254950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.254950] CR2: 0000000000000078 CR3: 0000000004108000 CR4: 00000000003506e0

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/cond.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index e3a95ff83..95d1e75bc 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -134,8 +134,7 @@ static inline int cobalt_cond_timedwait_prologue(struct xnthread *cur,
 	xnlock_get_irqsave(&nklock, s);
 
 	/* If another thread waiting for cond does not use the same mutex */
-	if (!cobalt_obj_active(cond, COBALT_COND_MAGIC, struct cobalt_cond)
-	    || (cond->mutex && cond->mutex != mutex)) {
+	if ((cond->mutex && cond->mutex != mutex)) {
 		err = -EINVAL;
 		goto unlock_and_return;
 	}
@@ -301,9 +300,13 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 
 	handle = cobalt_get_handle_from_user(&u_cnd->handle);
 	cond = xnregistry_lookup(handle, NULL);
+	if (!cobalt_obj_active(cond, COBALT_COND_MAGIC, typeof(*cond)))
+		return -EINVAL;
 
 	handle = cobalt_get_handle_from_user(&u_mx->handle);
 	mx = xnregistry_lookup(handle, NULL);
+	if (!cobalt_obj_active(mx, COBALT_MUTEX_MAGIC, typeof(*mx)))
+		return -EINVAL;
 
 	if (cond->mutex == NULL) {
 		__xn_get_user(offset, &u_mx->state_offset);
@@ -313,9 +316,12 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 	if (fetch_timeout) {
 		err = fetch_timeout(&ts, u_ts);
 		if (err == 0) {
-			trace_cobalt_cond_timedwait(u_cnd, u_mx, &ts);
-			err = cobalt_cond_timedwait_prologue(cur, cond, mx,
-							     ts2ns(&ts) + 1);
+			if (timespec64_valid(&ts)) {
+				trace_cobalt_cond_timedwait(u_cnd, u_mx, &ts);
+				err = cobalt_cond_timedwait_prologue(
+					cur, cond, mx, ts2ns(&ts) + 1);
+			} else
+				err = -EINVAL;
 		}
 	} else {
 		trace_cobalt_cond_wait(u_cnd, u_mx);
@@ -334,9 +340,8 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 		d.err = 0;	/* epilogue should return 0. */
 		break;
 
+	case -EINVAL:
 	default:
-		/* Please gcc and handle the case which will never
-		   happen */
 		d.err = EINVAL;
 	}
 
@@ -392,9 +397,14 @@ COBALT_SYSCALL(cond_wait_epilogue, primary,
 
 	handle = cobalt_get_handle_from_user(&u_cnd->handle);
 	cond = xnregistry_lookup(handle, NULL);
+	if (!cobalt_obj_active(cond, COBALT_COND_MAGIC, typeof(*cond)))
+		return -EINVAL;
 
 	handle = cobalt_get_handle_from_user(&u_mx->handle);
 	mx = xnregistry_lookup(handle, NULL);
+	if (!cobalt_obj_active(mx, COBALT_MUTEX_MAGIC, typeof(*mx)))
+		return -EINVAL;
+
 	err = cobalt_cond_timedwait_epilogue(cur, cond, mx);
 
 	if (cond->mutex == NULL)
-- 
2.30.2


