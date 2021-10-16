From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/{cobalt,copperplate}: Use valid addresses for
 pthread_setspecific
Message-ID: <f49545fe-0d9e-85c3-5dea-62af19ea927f@siemens.com>
Date: Sat, 16 Oct 2021 16:07:52 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

glibx 2.34 and newer annotated pthread_setspecific in a way that gcc-11
complains about non-NULL pointers that are outside of what is considered
valid. So use dummy addresses instead. namely the related pthread keys.
Those pointers will never be dereferenced in both use cases.

See also https://sourceware.org/bugzilla/show_bug.cgi?id=28458.

Reported-by: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/copperplate/threadobj.h | 6 +++++-
 lib/cobalt/printf.c             | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
index 7e6904f4c8..c8363415b4 100644
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -173,7 +173,11 @@ void threadobj_save_timeout(struct threadobj_corespec *corespec,
 #define __THREAD_M_SPARE6	(1 << 22)
 #define __THREAD_M_SPARE7	(1 << 23)
 
-#define THREADOBJ_IRQCONTEXT    ((struct threadobj *)-2UL)
+/*
+ * We need to use a valid address here. The object will never be dereferenced
+ * when it is identified as IRQ context, so the pthread key itself is fine.
+ */
+#define THREADOBJ_IRQCONTEXT	((struct threadobj *)&threadobj_tskey)
 
 struct traceobj;
 struct syncobj;
diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 8982ddc937..0aa5940c67 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -729,7 +729,7 @@ done:
 	pthread_cond_init(&printer_wakeup, NULL);
 	spawn_printer_thread();
 	/* We just need a non-zero TSD to trigger the dtor upon unwinding. */
-	pthread_setspecific(cleanup_key, (void *)1);
+	pthread_setspecific(cleanup_key, &cleanup_key);
 
 	atexit(rt_print_flush_buffers);
 }
-- 
2.31.1

