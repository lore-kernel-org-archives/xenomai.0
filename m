From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:42 +0200
Message-Id: <ce7b68432823fb0c9466f3bda27a07eb0e8d36f9.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 01/23] hal: Mark file ops of
	rthal_add_proc_seq const
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

Older kernels do not have this tag but do not touch them as well, so
perform a type cast when assigning them to proc_dir_entry.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/hal.h |    2 +-
 ksrc/arch/generic/hal.c   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index 84c1a4d..61da1b7 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -554,7 +554,7 @@ struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
 					   struct proc_dir_entry *parent);
 
 struct proc_dir_entry *rthal_add_proc_seq(const char *name,
-					  struct file_operations *fops,
+					  const struct file_operations *fops,
 					  size_t size,
 					  struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index 8a5ec39..c2239ca 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -748,7 +748,7 @@ struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
 EXPORT_SYMBOL_GPL(rthal_add_proc_leaf);
 
 struct proc_dir_entry *rthal_add_proc_seq(const char *name,
-					  struct file_operations *fops,
+					  const struct file_operations *fops,
 					  size_t size,
 					  struct proc_dir_entry *parent)
 {
@@ -758,7 +758,7 @@ struct proc_dir_entry *rthal_add_proc_seq(const char *name,
 	if (entry == NULL)
 		return NULL;
 
-	entry->proc_fops = fops;
+	entry->proc_fops = (struct file_operations *)fops;
 	wrap_proc_dir_entry_owner(entry);
 
 	if (size)
-- 
1.6.0.2


