From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:45 +0200
Message-Id: <38f32e3b3d5b65330c335c6ab86d95b5f76cce40.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 04/23] RTDM: Convert fildes proc to single-seq
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

As read_proc is deprecated and will die soon, we have to convert to
single-seq. Start with RTDM's fildes proc entry.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index 70ee4a2..ff264b6 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -17,6 +17,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <linux/seq_file.h>
+
 #include "rtdm/internal.h"
 
 /* Derived from Erwin Rol's rtai_proc_fs.h.
@@ -189,17 +191,26 @@ static int proc_kill_open_fildes(struct file *file, const char __user *buffer,
 	return count;
 }
 
-static int proc_read_fildes(char *buf, char **start, off_t offset,
-			    int count, int *eof, void *data)
+static int fildes_show(struct seq_file *seq, void *v)
 {
-	RTDM_PROC_PRINT_VARS(80);
-
-	RTDM_PROC_PRINT("total=%d:open=%d:free=%d\n", RTDM_FD_MAX,
-			open_fildes, RTDM_FD_MAX - open_fildes);
+	seq_printf(seq, "total=%d:open=%d:free=%d\n",
+		   RTDM_FD_MAX, open_fildes, RTDM_FD_MAX - open_fildes);
+	return 0;
+}
 
-	RTDM_PROC_PRINT_DONE;
+static int fildes_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fildes_show, NULL);
 }
 
+static const struct file_operations fildes_operations = {
+	.owner		= THIS_MODULE,
+	.open		= fildes_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int proc_read_dev_info(char *buf, char **start, off_t offset,
 			      int count, int *eof, void *data)
 {
@@ -313,11 +324,9 @@ int __init rtdm_proc_init(void)
 	proc_entry->read_proc = proc_read_open_fildes;
 	proc_entry->write_proc = proc_kill_open_fildes;
 
-	proc_entry =
-	    create_proc_entry("fildes", S_IFREG | S_IRUGO, rtdm_proc_root);
-	if (!proc_entry)
+	if (!rthal_add_proc_seq("fildes", &fildes_operations, 0,
+				rtdm_proc_root))
 		goto error;
-	proc_entry->read_proc = proc_read_fildes;
 
 	return 0;
 
-- 
1.6.0.2


