From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/9] cobalt: Use linux/stdarg.h
Date: Wed, 13 Oct 2021 13:55:47 +0200
Message-Id: <aa746e3dcc9a835022acd6667f1e7ca381d8b0e9.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Required with kernel 5.15 to avoid duplicate includes. Provide a stub
for older kernels that continues to use the toolchain header.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/heap.c                 | 2 +-
 kernel/cobalt/include/linux/stdarg.h | 1 +
 kernel/cobalt/posix/mqueue.c         | 2 +-
 kernel/cobalt/posix/process.c        | 2 +-
 kernel/cobalt/posix/thread.h         | 2 +-
 kernel/cobalt/synch.c                | 2 +-
 kernel/cobalt/vfile.c                | 2 +-
 scripts/prepare-kernel.sh            | 1 +
 8 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 kernel/cobalt/include/linux/stdarg.h

diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index d3f43729e1..f106d5d071 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -16,7 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
diff --git a/kernel/cobalt/include/linux/stdarg.h b/kernel/cobalt/include/linux/stdarg.h
new file mode 100644
index 0000000000..38ade6d9f5
--- /dev/null
+++ b/kernel/cobalt/include/linux/stdarg.h
@@ -0,0 +1 @@
+#include <stdarg.h>
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 9075c80be9..d93c0bdf6d 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -16,7 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 87b4893b30..935007f821 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -21,7 +21,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 51be372a7a..0959ff6d72 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -18,7 +18,7 @@
 #ifndef _COBALT_POSIX_THREAD_H
 #define _COBALT_POSIX_THREAD_H
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/signal.h>
diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 911bc83f60..6e50e537fa 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -16,7 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/signal.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
index fae0cc3773..a0ec5cad1c 100644
--- a/kernel/cobalt/vfile.c
+++ b/kernel/cobalt/vfile.c
@@ -15,7 +15,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/ctype.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 9ee1b3d650..64e2484e16 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -453,6 +453,7 @@ patch_link r n include/cobalt/kernel/$pipeline_type/pipeline include/xenomai/pip
 patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
 patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
 patch_link n version.h include/xenomai include/xenomai
+patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
 
 if test "x$output_patch" != "x"; then
     if test x$verbose = x1; then
-- 
2.31.1


