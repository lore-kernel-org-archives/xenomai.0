From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 2/7] cobalt/debug: switch to mmap_lock interface
Date: Sat, 27 Mar 2021 11:19:07 +0100
Message-Id: <20210327101912.2291474-3-rpm@xenomai.org>
In-Reply-To: <20210327101912.2291474-1-rpm@xenomai.org>
References: <20210327101912.2291474-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/debug.c                                | 4 ++--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 1e9edda99..f97144aeb 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -239,7 +239,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 
 	memset(&spot, 0, sizeof(spot));
 	mm = get_task_mm(current);
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 
 	for (n = 0, depth = 0; n < nr; n++) {
 		pc = backtrace[n];
@@ -278,7 +278,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 		depth++;
 	}
 
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 	free_page((unsigned long)tmp);
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index ac4e95aa0..cd22a8db5 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -176,6 +176,13 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define old_timeval32     compat_timeval
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
+#define mmap_read_lock(__mm)	down_read(&mm->mmap_sem)
+#define mmap_read_unlock(__mm)	up_read(&mm->mmap_sem)
+#define mmap_write_lock(__mm)	down_write(&mm->mmap_sem)
+#define mmap_write_unlock(__mm)	up_write(&mm->mmap_sem)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
 #define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags, PAGE_KERNEL)
 #else
-- 
2.29.2


