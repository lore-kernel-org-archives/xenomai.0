From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:45 +0200
Message-Id: <bb57f6aaf099a7a0e51538b7498c8cefdea0a646.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 21/24] Add list_first_entry wrapper for
	older kernels
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/wrappers.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 64ec43f..d864397 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -559,6 +559,11 @@ static inline void wrap_proc_dir_entry_owner(struct proc_dir_entry *entry)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
 #endif /* CONFIG_PROC_FS */
 
+#ifndef list_first_entry
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define rthal_irq_descp(irq)	(irq_desc + (irq))
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32) */
-- 
1.6.0.2


