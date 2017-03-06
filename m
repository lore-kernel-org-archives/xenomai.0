From: Henning Schild <henning.schild@siemens.com>
Date: Mon,  6 Mar 2017 15:00:49 +0100
Message-Id: <20170306140049.23493-2-henning.schild@siemens.com>
In-Reply-To: <20170306140049.23493-1-henning.schild@siemens.com>
References: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
 <20170306140049.23493-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/2] lib/cobalt: wrap CXXABI One-time Constructor
	functions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The implementation of these functions uses locks and has the potential
to trigger a SIGXCPU when contended. Wrap them with assert_nrt so they
reliably cause a switch when used in the rt context.

This is a corrected version of: be90f09cf2770
which got reverted in: 0ef9dbd42d16d

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/cobalt/assert.wrappers  |  3 +++
 lib/cobalt/assert_context.c | 19 +++++++++++++++++++
 lib/cobalt/internal.h       | 12 ++++++++++++
 lib/cobalt/wrappers.c       | 19 +++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/lib/cobalt/assert.wrappers b/lib/cobalt/assert.wrappers
index 7164858..65320ab 100644
--- a/lib/cobalt/assert.wrappers
+++ b/lib/cobalt/assert.wrappers
@@ -1,2 +1,5 @@
 --wrap malloc
 --wrap free
+--wrap __cxa_guard_acquire
+--wrap __cxa_guard_release
+--wrap __cxa_guard_abort
diff --git a/lib/cobalt/assert_context.c b/lib/cobalt/assert_context.c
index 2085953..fd18d6b 100644
--- a/lib/cobalt/assert_context.c
+++ b/lib/cobalt/assert_context.c
@@ -66,3 +66,22 @@ COBALT_IMPL(void, free, (void *ptr))
 	assert_nrt();
 	__STD(free(ptr));
 }
+
+/* CXXABI 3.3.2 One-time Construction API */
+COBALT_IMPL(int, __cxa_guard_acquire, (__guard *g))
+{
+	assert_nrt();
+	return __STD(__cxa_guard_acquire(g));
+}
+
+COBALT_IMPL(void, __cxa_guard_release, (__guard *g))
+{
+	assert_nrt();
+	__STD(__cxa_guard_release(g));
+}
+
+COBALT_IMPL(void, __cxa_guard_abort, (__guard *g))
+{
+	assert_nrt();
+	__STD(__cxa_guard_abort(g));
+}
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index fee3fe1..9f58c6a 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -73,4 +73,16 @@ void cobalt_check_features(struct cobalt_featinfo *finfo);
 
 extern struct sigaction __cobalt_orig_sigdebug;
 
+#ifdef __ARM_EABI__
+typedef uint32_t __guard;
+#else
+typedef uint64_t __guard;
+#endif
+int __real___cxa_guard_acquire(__guard*);
+void __real___cxa_guard_release(__guard*);
+void __real___cxa_guard_abort(__guard*);
+int __cxa_guard_acquire(__guard*);
+void __cxa_guard_release(__guard*);
+void __cxa_guard_abort(__guard*);
+
 #endif /* _LIB_COBALT_INTERNAL_H */
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 09c74e5..c43772c 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -43,6 +43,7 @@
 #include <unistd.h>
 #include <malloc.h>
 #include <boilerplate/compiler.h>
+#include <internal.h>
 
 /* sched */
 __weak
@@ -532,3 +533,21 @@ unsigned int __real_sleep(unsigned int seconds)
 {
 	return sleep(seconds);
 }
+
+__weak
+int __real___cxa_guard_acquire(__guard *g)
+{
+	return __cxa_guard_acquire(g);
+}
+
+__weak
+void __real___cxa_guard_release(__guard *g)
+{
+	return __cxa_guard_release(g);
+}
+
+__weak
+void __real___cxa_guard_abort(__guard *g)
+{
+	return __cxa_guard_abort(g);
+}
-- 
2.10.2


