From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:54 +0200
Message-Id: <947b4a579d955c162b545cb4001750aa685c46b8.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 13/23] nucleus: Add infrastructure for
	supporting the seq_file mechanism in registry objects
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

We augment struct xnpnode with a new element for representing file_operations that
allow for using more generic file system methods than read_proc. However, we
have to retain read_proc and write_proc for now since not all proc entries are
immediately converted. However, we should be able to get rid of them in the
future because writing can as well be implemented in conjunction to the
seq_file mechanism.

NOTE: When the proc file depends on a data argument given to registry_enter, it
can be obtained in seq_open via PDE(inode)->data. In turn, it should be
associated with the seq_file instance, which is easy enough for single_open
(just use it as third argument). It must be done manually for
seq_open; note that seq_file is available as file->private after
the call. ((struct seq_file *)file->private)->private = PDE(inode)->data
is your friend.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/hal.h  |    6 ++++++
 include/nucleus/registry.h |   19 ++++++++++++-------
 ksrc/arch/generic/hal.c    |   18 ++++++++++++++++++
 ksrc/nucleus/registry.c    |   14 +++++++++++++-
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index 61da1b7..04979cd 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -557,6 +557,12 @@ struct proc_dir_entry *rthal_add_proc_seq(const char *name,
 					  const struct file_operations *fops,
 					  size_t size,
 					  struct proc_dir_entry *parent);
+
+struct proc_dir_entry *rthal_add_proc_seq_data(const char *name,
+					       const struct file_operations *fops,
+					       size_t size,
+					       void *data,
+					       struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_IPIPE_TRACE
diff --git a/include/nucleus/registry.h b/include/nucleus/registry.h
index 56826db..3685308 100644
--- a/include/nucleus/registry.h
+++ b/include/nucleus/registry.h
@@ -73,6 +73,7 @@ void xnregistry_cleanup(void);
 #ifdef CONFIG_PROC_FS
 
 #include <linux/proc_fs.h>
+#include <linux/fs.h>
 
 #define XNOBJECT_PROC_RESERVED1 ((struct proc_dir_entry *)1)
 #define XNOBJECT_PROC_RESERVED2 ((struct proc_dir_entry *)2)
@@ -90,13 +91,17 @@ typedef struct xnptree {
 
 typedef struct xnpnode {
 
-    struct proc_dir_entry *dir;
-    const char *type;
-    int entries;
-    read_proc_t *read_proc;
-    write_proc_t *write_proc;
-    link_proc_t *link_proc;
-    xnptree_t *root;
+	struct proc_dir_entry *dir;
+	const char *type;
+	int entries;
+
+	/* NOTE: Use either read_proc/write_proc, link_proc or fops. */
+	read_proc_t *read_proc;
+	write_proc_t *write_proc;
+	link_proc_t *link_proc;
+	struct file_operations *fops;
+
+	xnptree_t *root;
 
 } xnpnode_t;
 
diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index c97659a..3b38895 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -901,6 +901,24 @@ struct proc_dir_entry *rthal_add_proc_seq(const char *name,
 }
 EXPORT_SYMBOL_GPL(rthal_add_proc_seq);
 
+struct proc_dir_entry
+*rthal_add_proc_seq_data(const char *name,
+			 const struct file_operations *fops,
+			 size_t size,
+			 void *data,
+			 struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *entry;
+
+	entry = rthal_add_proc_seq(name, fops, size, parent);
+
+	if (entry)
+		entry->data = data;
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(rthal_add_proc_seq_data);
+
 static int rthal_proc_register(void)
 {
 	rthal_proc_root = create_proc_entry("xenomai", S_IFDIR, 0);
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 9958dd3..c71da5d 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -338,8 +338,20 @@ static DECLARE_WORK_FUNC(registry_proc_callback)
 			object->proc = add_proc_link(object->key,
 						     pnode->link_proc,
 						     object->objaddr, dir);
+		else if (pnode->fops)
+			/* Entry is a proper file */
+			object->proc = rthal_add_proc_seq_data(object->key,
+							       pnode->fops,
+							       0,
+							       object->objaddr,
+							       dir);
 		else
-			/* Entry allows to get/set object properties. */
+			/*
+			 * Entry allows us to get/set object properties
+			 * via read/write_proc. Note that this type
+			 * is deprecated since support in the Linux kernel
+			 * will go away.
+			 */
 			object->proc = rthal_add_proc_leaf(object->key,
 							   pnode->read_proc,
 							   pnode->write_proc,
-- 
1.6.0.2


