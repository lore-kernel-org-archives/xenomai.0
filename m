From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 24 May 2018 19:44:53 +0200
Message-Id: <1d7bccbc6aaa4454c98ecf11694e2cc2d7d150e2.1527183892.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1527183892.git.jan.kiszka@siemens.com>
References: <cover.1527183892.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1527183892.git.jan.kiszka@siemens.com>
References: <cover.1527183892.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 2/2] cobalt/posix/sem: Fix sem_open for
	preexisting semaphores
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We missed to create and copy the shadow into userspace in case a
preexisting semaphore was opened in process that didn't created it. Was
biting us in pshared setups, but also when the previous owner died
before destroying a named semaphore.

Reported-by: Paal Tamas <paal_to@freemail.hu>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/nsem.c | 11 +++++++----
 kernel/cobalt/posix/sem.c  | 23 ++++++++++++++++++-----
 kernel/cobalt/posix/sem.h  |  3 +++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/cobalt/posix/nsem.c b/kernel/cobalt/posix/nsem.c
index bf2157d35..89cf62b6f 100644
--- a/kernel/cobalt/posix/nsem.c
+++ b/kernel/cobalt/posix/nsem.c
@@ -95,6 +95,8 @@ sem_open(struct cobalt_process *process,
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry_bind;
 		}
+
+		__cobalt_sem_shadow_init(sem, COBALT_NAMED_SEM_MAGIC, &shadow);
 		break;
 
 	case -EWOULDBLOCK:
@@ -112,10 +114,6 @@ sem_open(struct cobalt_process *process,
 			return ERR_PTR(rc);
 		}
 
-		if (cobalt_copy_to_user(ushadow, &shadow, sizeof(shadow))) {
-			__cobalt_sem_destroy(shadow.handle);
-			return ERR_PTR(-EFAULT);
-		}
 		sem->pathname = filename;
 		handle = shadow.handle;
 		break;
@@ -124,6 +122,11 @@ sem_open(struct cobalt_process *process,
 		return ERR_PTR(rc);
 	}
 
+	if (cobalt_copy_to_user(ushadow, &shadow, sizeof(shadow))) {
+		__cobalt_sem_destroy(handle);
+		return ERR_PTR(-EFAULT);
+	}
+
 	u = xnmalloc(sizeof(*u));
 	if (u == NULL) {
 		__cobalt_sem_destroy(handle);
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index dc7ff0de3..ab075bb55 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -153,13 +153,11 @@ __cobalt_sem_init(const char *name, struct cobalt_sem_shadow *sm,
 	sem->refs = name ? 2 : 1;
 	sem->pathname = NULL;
 
-	sm->magic = name ? COBALT_NAMED_SEM_MAGIC : COBALT_SEM_MAGIC;
-	sm->handle = sem->resnode.handle;
-	sm->state_offset = cobalt_umm_offset(&sys_ppd->umm, state);
-	if (flags & SEM_PSHARED)
-		sm->state_offset = -sm->state_offset;
 	xnlock_put_irqrestore(&nklock, s);
 
+	__cobalt_sem_shadow_init(sem,
+			name ? COBALT_NAMED_SEM_MAGIC : COBALT_SEM_MAGIC, sm);
+
 	trace_cobalt_psem_init(name ?: "anon",
 			       sem->resnode.handle, flags, value);
 
@@ -176,6 +174,21 @@ out:
 	return ERR_PTR(ret);
 }
 
+void __cobalt_sem_shadow_init(struct cobalt_sem *sem, __u32 magic,
+			      struct cobalt_sem_shadow *sm)
+{
+	__u32 flags = sem->state->flags;
+	struct cobalt_ppd *sys_ppd;
+
+	sys_ppd = cobalt_ppd_get(!!(flags & SEM_PSHARED));
+
+	sm->magic = magic;
+	sm->handle = sem->resnode.handle;
+	sm->state_offset = cobalt_umm_offset(&sys_ppd->umm, sem->state);
+	if (sem->state->flags & SEM_PSHARED)
+		sm->state_offset = -sm->state_offset;
+}
+
 static int sem_destroy(struct cobalt_sem_shadow *sm)
 {
 	struct cobalt_sem *sem;
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index a95b6c4ce..17238078e 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -76,6 +76,9 @@ struct cobalt_sem *
 __cobalt_sem_init(const char *name, struct cobalt_sem_shadow *sem,
 		  int flags, unsigned value);
 
+void __cobalt_sem_shadow_init(struct cobalt_sem *sem, __u32 magic,
+			      struct cobalt_sem_shadow *sm);
+
 COBALT_SYSCALL_DECL(sem_init,
 		    (struct cobalt_sem_shadow __user *u_sem,
 		     int flags, unsigned value));
-- 
2.13.6


