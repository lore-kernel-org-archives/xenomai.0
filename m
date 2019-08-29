From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] posix: Make CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO widely
Message-ID: <ec78142c-67d2-9702-df8b-c935956ae4a5@siemens.com>
Date: Thu, 29 Aug 2019 12:43:02 +0200
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

This converts the consistency checks for resource ownership from
optional into unconditional. The motivation is preventing the risk of
kernel crash in the presence of application bugs and the absence of
CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO which used to control this check.

The only remaining features that this config manages is then printing a
warning on mutex deadlocks. This is simply moved under the parent
CONFIG_XENO_OPT_DEBUG_USER.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml                   |  1 -
 include/cobalt/uapi/corectl.h |  2 +-
 kernel/cobalt/Kconfig         | 11 -----------
 kernel/cobalt/posix/cond.c    |  3 +--
 kernel/cobalt/posix/corectl.c |  2 --
 kernel/cobalt/posix/mutex.c   |  8 +++-----
 kernel/cobalt/posix/sem.c     |  3 +--
 7 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0e7aa6d10c..a3453b0ff9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -67,7 +67,6 @@ before_script:
   - ./scripts/config -e XENO_OPT_DEBUG_MEMORY
   - ./scripts/config -e XENO_OPT_DEBUG_CONTEXT
   - ./scripts/config -e XENO_OPT_DEBUG_USER
-  - ./scripts/config -e XENO_OPT_DEBUG_POSIX_SYNCHRO
   - ./scripts/config -e XENO_OPT_DEBUG_LEGACY
   - ./scripts/config -e XENO_OPT_DEBUG_TRACE_RELAX
   - ./scripts/config -e XENO_DRIVERS_16550A
diff --git a/include/cobalt/uapi/corectl.h b/include/cobalt/uapi/corectl.h
index 159bfbcb3b..98d989d635 100644
--- a/include/cobalt/uapi/corectl.h
+++ b/include/cobalt/uapi/corectl.h
@@ -29,7 +29,7 @@
 #   define _CC_COBALT_DEBUG_USER		8
 #   define _CC_COBALT_DEBUG_MUTEX_RELAXED	16
 #   define _CC_COBALT_DEBUG_MUTEX_SLEEP		32
-#   define _CC_COBALT_DEBUG_POSIX_SYNCHRO	64
+/* bit 6 (64) formerly used for DEBUG_POSIX_SYNCHRO */
 #   define _CC_COBALT_DEBUG_LEGACY		128
 #   define _CC_COBALT_DEBUG_TRACE_RELAX		256
 #   define _CC_COBALT_DEBUG_NET			512
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 16602a77e0..d099f873f8 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -436,17 +436,6 @@ config XENO_OPT_DEBUG_MUTEX_SLEEP
 	 disables the normal fast mutex operations from user-space,
 	 causing a system call for each mutex acquisition/release.
 
-config XENO_OPT_DEBUG_POSIX_SYNCHRO
-        bool "Detect POSIX synchronization issues"
-	default n
-	help
-	  When this debug category is enabled, calls to the thread
-	  synchronization services are checked for consistency, beyond
-	  the requirements of the POSIX standard. In most cases, a
-	  faulty call results in error EPERM when detected.
-
-	  This option has negligible overhead.
- 
 config XENO_OPT_DEBUG_LEGACY
         bool "Detect usage of legacy constructs/features"
 	default n
diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index 8ad39f3e87..35a8f7176d 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -139,8 +139,7 @@ static inline int cobalt_cond_timedwait_prologue(struct xnthread *cur,
 		goto unlock_and_return;
 	}
 
-	if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO) &&
-	    cond->resnode.scope !=
+	if (cond->resnode.scope !=
 	    cobalt_current_resources(cond->attr.pshared)) {
 		err = -EPERM;
 		goto unlock_and_return;
diff --git a/kernel/cobalt/posix/corectl.c b/kernel/cobalt/posix/corectl.c
index 6ec9934ea3..f7129ca64b 100644
--- a/kernel/cobalt/posix/corectl.c
+++ b/kernel/cobalt/posix/corectl.c
@@ -73,8 +73,6 @@ static int do_conf_option(int option, void __user *u_buf, size_t u_bufsz)
 			val |= _CC_COBALT_DEBUG_MUTEX_RELAXED;
 		if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP))
 			val |= _CC_COBALT_DEBUG_MUTEX_SLEEP;
-		if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO))
-			val |= _CC_COBALT_DEBUG_POSIX_SYNCHRO;
 		if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_LEGACY))
 			val |= _CC_COBALT_DEBUG_LEGACY;
 		if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_TRACE_RELAX))
diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 7872174817..79260b5448 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -104,8 +104,7 @@ int cobalt_mutex_release(struct xnthread *curr,
 	if (!cobalt_obj_active(mutex, COBALT_MUTEX_MAGIC, struct cobalt_mutex))
 		 return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO) &&
-	    mutex->resnode.scope !=
+	if (mutex->resnode.scope !=
 	    cobalt_current_resources(mutex->attr.pshared))
 		return -EPERM;
 
@@ -159,8 +158,7 @@ redo:
 		goto out;
 	}
 
-	if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO) &&
-	    mutex->resnode.scope !=
+	if (mutex->resnode.scope !=
 	    cobalt_current_resources(mutex->attr.pshared)) {
 		ret = -EPERM;
 		goto out;
@@ -190,7 +188,7 @@ redo:
 	switch(mutex->attr.type) {
 	case PTHREAD_MUTEX_NORMAL:
 		/* Attempting to relock a normal mutex, deadlock. */
-		if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO))
+		if (IS_ENABLED(XENO_OPT_DEBUG_USER))
 			printk(XENO_WARNING
 			       "thread %s deadlocks on non-recursive mutex\n",
 			       curr->name);
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index ab075bb55e..b02667e5f0 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -36,8 +36,7 @@ static inline int sem_check(struct cobalt_sem *sem)
 	if (sem == NULL || sem->magic != COBALT_SEM_MAGIC)
 		return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO) &&
-	    sem->resnode.scope && sem->resnode.scope != sem_kqueue(sem))
+	if (sem->resnode.scope && sem->resnode.scope != sem_kqueue(sem))
 		return -EPERM;
 
 	return 0;
-- 

2.16.4

