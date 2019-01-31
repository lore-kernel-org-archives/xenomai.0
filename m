From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] ipipe: Introduce and use ipipe_root_nr_syscalls
Message-ID: <56901bab-a85d-2c35-83d7-df8521f72076@siemens.com>
Date: Thu, 31 Jan 2019 18:01:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

At least one arch, infamous x86, has a difference of NR_syscalls
depending on compat vs. native ABI. Account for that by introducing a
function that can deliver the currently valid syscall number if an arch
implements such a service. In all other cases, this change is
functionally no difference.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Not sure if this should rather go into linux/ipipe.h.

 include/linux/ipipe_base.h | 4 ++++
 kernel/ipipe/core.c        | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index a59e1d19eb40..62ae60209199 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -194,6 +194,10 @@ int __ipipe_notify_user_intreturn(void);
 
 #define __ipipe_serial_debug(__fmt, __args...)	raw_printk(__fmt, ##__args)
 
+#ifndef ipipe_root_nr_syscalls
+#define ipipe_root_nr_syscalls(ti)	NR_syscalls
+#endif
+
 #else /* !CONFIG_IPIPE */
 
 struct task_struct;
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 4d61c0e57ba1..bc4eeb98f942 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1018,6 +1018,7 @@ int ipipe_handle_syscall(struct thread_info *ti,
 			 unsigned long nr, struct pt_regs *regs)
 {
 	unsigned long local_flags = READ_ONCE(ti->ipipe_flags);
+	unsigned int nr_syscalls = ipipe_root_nr_syscalls(ti);
 	int ret;
 
 	/*
@@ -1051,7 +1052,7 @@ int ipipe_handle_syscall(struct thread_info *ti,
 	 * system call handler.
 	 */
 
-	if (nr >= NR_syscalls && (local_flags & _TIP_HEAD)) {
+	if (nr >= nr_syscalls && (local_flags & _TIP_HEAD)) {
 		ipipe_fastcall_hook(regs);
 		local_flags = READ_ONCE(ti->ipipe_flags);
 		if (local_flags & _TIP_HEAD) {
@@ -1064,7 +1065,7 @@ int ipipe_handle_syscall(struct thread_info *ti,
 		}
 	}
 
-	if ((local_flags & _TIP_NOTIFY) || nr >= NR_syscalls) {
+	if ((local_flags & _TIP_NOTIFY) || nr >= nr_syscalls) {
 		ret =__ipipe_notify_syscall(regs);
 		local_flags = READ_ONCE(ti->ipipe_flags);
 		if (local_flags & _TIP_HEAD)
-- 
2.16.4

