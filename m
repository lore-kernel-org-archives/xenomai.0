From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/7] drivers/net: cfg: fix config file load up
Date: Wed, 12 May 2021 12:05:53 +0200
Message-Id: <07a626a19ac67d6dad54cc03a2b13ec4671a4f5d.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
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

set_fs() is on its way out, so we cannot open code a file read
operation by calling the VFS handler directly anymore, faking a user
address space.

We do have kernel interfaces for loading files though, particularly
kernel_read_file(). So let's use that one for loading the
configuration file contents. Unfortunately, the signature of this
service changed during the 5.9-rc cycle, so we have to resort to an
ugly wrapper to cope with all supported kernels once again. Sigh.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../include/asm-generic/xenomai/wrappers.h    | 15 ++++
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 74 +++++++++----------
 2 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 652a04759f..54fdc8b05e 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -216,4 +216,19 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
+#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
+	({								\
+		loff_t ___file_size;					\
+		int __ret;						\
+		__ret = kernel_read_file(__file, __buf, &___file_size,	\
+				__buf_size, __id);			\
+		(*__file_size) = ___file_size;				\
+		__ret;							\
+	})
+#else
+#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
+	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
index 769b4e143c..158d7118f2 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
@@ -22,6 +22,7 @@
  *
  */
 
+#include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/vmalloc.h>
 
@@ -196,6 +197,40 @@ void cleanup_cmd_detach(void *priv_data)
 		kfree_rtskb(cmd->args.detach.stage2_chain);
 }
 
+static int load_cfg_file(struct rtcfg_file *cfgfile, struct rtcfg_cmd *cmd)
+{
+	size_t file_size = 0;
+	struct file *filp;
+	loff_t i_size;
+	int ret;
+
+	filp = filp_open(cfgfile->name, O_RDONLY, 0);
+	if (IS_ERR(filp))
+		return PTR_ERR(filp);
+
+	i_size = i_size_read(file_inode(filp));
+	if (i_size <= 0) {
+		/* allocate buffer even for empty files */
+		cfgfile->buffer = vmalloc(1);
+	} else {
+		cfgfile->buffer = NULL; /* Leave allocation to the kernel. */
+		ret = read_file_from_kernel(filp, &cfgfile->buffer,
+					i_size_read(file_inode(filp)),
+					&file_size, READING_UNKNOWN);
+		if (ret < 0) {
+			fput(filp);
+			return ret;
+		}
+	}
+
+	fput(filp);
+	cfgfile->size = file_size;
+
+	/* dispatch again, this time with new file attached */
+	return rtpc_dispatch_call(rtcfg_event_handler, 0, cmd,
+				sizeof(*cmd), NULL, cleanup_cmd_add);
+}
+
 int rtcfg_ioctl_add(struct rtnet_device *rtdev, struct rtcfg_cmd *cmd)
 {
 	struct rtcfg_connection *conn_buf;
@@ -264,46 +299,11 @@ int rtcfg_ioctl_add(struct rtnet_device *rtdev, struct rtcfg_cmd *cmd)
 
 	/* load file if missing */
 	if (ret > 0) {
-		struct file *filp;
-		mm_segment_t oldfs;
-
-		filp = filp_open(file->name, O_RDONLY, 0);
-		if (IS_ERR(filp)) {
+		ret = load_cfg_file(file, cmd);
+		if (ret) {
 			rtcfg_unlockwr_proc(cmd->internal.data.ifindex);
-			ret = PTR_ERR(filp);
 			goto err;
 		}
-
-		file->size = filp->f_path.dentry->d_inode->i_size;
-
-		/* allocate buffer even for empty files */
-		file->buffer = vmalloc((file->size) ? file->size : 1);
-		if (file->buffer == NULL) {
-			rtcfg_unlockwr_proc(cmd->internal.data.ifindex);
-			fput(filp);
-			ret = -ENOMEM;
-			goto err;
-		}
-
-		oldfs = get_fs();
-		set_fs(KERNEL_DS);
-		filp->f_pos = 0;
-
-		ret = filp->f_op->read(filp, file->buffer, file->size,
-				       &filp->f_pos);
-
-		set_fs(oldfs);
-		fput(filp);
-
-		if (ret != (int)file->size) {
-			rtcfg_unlockwr_proc(cmd->internal.data.ifindex);
-			ret = -EIO;
-			goto err;
-		}
-
-		/* dispatch again, this time with new file attached */
-		ret = rtpc_dispatch_call(rtcfg_event_handler, 0, cmd,
-					 sizeof(*cmd), NULL, cleanup_cmd_add);
 	}
 
 	return ret;
-- 
2.26.2


