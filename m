Sender: Thomas De Schampheleire <patrickdepinguin@domain.hid>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <68d35b0c2502bcfcd82a.1318861191@domain.hid>
In-Reply-To: <patchbomb.1318861189@domain.hid>
References: <patchbomb.1318861189@domain.hid>
Date: Wed, 19 Oct 2011 09:35:16 +0200
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Subject: [Xenomai-help] [PATCH 2 of 4] psos: port long_names feature to
	xenomai-forge
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

While psos interface accepts 4 character ids, non null terminated,
xenomai uses longer ids which must be null terminated. Revert to
the behaviour of psos interface, while allowing long id strings if
the global variable psos_long_names is set to non-zero.

This patch ports the original fix from xenomai to xenomai-forge,
fixing following problems:
* a bug in __psos_maybe_short_name so that only 3 characters are
  retained
* the call to __psos_maybe_short_name also needs to be done in the
  ident functions
* the pt_create and pt_ident functions also need to be adapted

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@domain.hid>
Signed-off-by: Ronny Meeus <ronny.meeus@domain.hid>

---
 include/psos/Makefile.am  |   2 +-
 include/psos/Makefile.in  |   2 +-
 include/psos/long_names.h |  14 ++++++++++++++
 include/psos/psos.h       |   2 ++
 lib/psos/init.c           |  15 +++++++++++++++
 lib/psos/pt.c             |   6 ++++++
 lib/psos/queue.c          |   6 ++++++
 lib/psos/rn.c             |   5 +++++
 lib/psos/sem.c            |   6 ++++++
 lib/psos/task.c           |   5 +++++
 10 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/psos/Makefile.am b/include/psos/Makefile.am
--- a/include/psos/Makefile.am
+++ b/include/psos/Makefile.am
@@ -1,3 +1,3 @@
 includesubdir = $(includedir)/psos
 
-includesub_HEADERS = psos.h
+includesub_HEADERS = psos.h long_names.h
diff --git a/include/psos/Makefile.in b/include/psos/Makefile.in
--- a/include/psos/Makefile.in
+++ b/include/psos/Makefile.in
@@ -238,7 +238,7 @@ top_build_prefix = @top_build_prefix@
 top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 includesubdir = $(includedir)/psos
-includesub_HEADERS = psos.h
+includesub_HEADERS = psos.h long_names.h
 all: all-am
 
 .SUFFIXES:
diff --git a/include/psos/long_names.h b/include/psos/long_names.h
new file mode 100644
--- /dev/null
+++ b/include/psos/long_names.h
@@ -0,0 +1,14 @@
+#ifndef LONG_NAMES_H
+#define LONG_NAMES_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+const char *__psos_maybe_short_name(char shrt[5], const char *lng);
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+#endif /* LONG_NAMES_H */
diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -371,6 +371,8 @@ u_long tm_wkwhen(u_long date,
 
 int psos_task_normalize_priority(unsigned long psos_prio);
 
+extern unsigned psos_long_names;
+
 #ifdef __cplusplus
 };
 #endif /* __cplusplus */
diff --git a/lib/psos/init.c b/lib/psos/init.c
--- a/lib/psos/init.c
+++ b/lib/psos/init.c
@@ -17,6 +17,7 @@
  */
 
 #include <stdio.h>
+#include <string.h>
 #include <time.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -27,6 +28,7 @@
 #include <copperplate/clockobj.h>
 #include <copperplate/debug.h>
 #include <psos/psos.h>
+#include <psos/long_names.h>
 #include "tm.h"
 #include "task.h"
 #include "sem.h"
@@ -34,6 +36,8 @@
 #include "pt.h"
 #include "rn.h"
 
+unsigned psos_long_names;
+
 static unsigned int clock_resolution = 1000000; /* 1ms */
 
 static const struct option psos_options[] = {
@@ -105,3 +109,14 @@ static __attribute__ ((constructor)) voi
 {
 	copperplate_register_skin(&psos_skin);
 }
+
+const char *__psos_maybe_short_name(char shrt[5], const char *lng)
+{
+	if (psos_long_names)
+		return lng;
+
+	strncpy(shrt, lng, 5 - 1);
+	shrt[4] = '\0';
+
+	return (const char *)shrt;
+}
diff --git a/lib/psos/pt.c b/lib/psos/pt.c
--- a/lib/psos/pt.c
+++ b/lib/psos/pt.c
@@ -26,6 +26,7 @@
 #include <copperplate/cluster.h>
 #include <copperplate/lock.h>
 #include <psos/psos.h>
+#include <psos/long_names.h>
 #include "pt.h"
 
 #define pt_magic	0x8181fefe
@@ -127,6 +128,7 @@ u_long pt_create(const char *name,
 	u_long overhead;
 	caddr_t mp;
 	u_long n;
+	char short_name[5];
 
 	if ((uintptr_t)paddr & (sizeof(uintptr_t) - 1))
 		return ERR_PTADDR;
@@ -145,6 +147,7 @@ u_long pt_create(const char *name,
 	if (name == NULL || *name == '\0')
 		sprintf(pt->name, "pt%lu", ++anon_ptids);
 	else {
+		name = __psos_maybe_short_name(short_name, name);
 		strncpy(pt->name, name, sizeof(pt->name));
 		pt->name[sizeof(pt->name) - 1] = '\0';
 	}
@@ -289,10 +292,13 @@ u_long pt_ident(const char *name, u_long
 	struct pvclusterobj *cobj;
 	struct service svc;
 	struct psos_pt *pt;
+	char short_name[5];
 
 	if (node)
 		return ERR_NODENO;
 
+	name = __psos_maybe_short_name(short_name, name);
+
 	COPPERPLATE_PROTECT(svc);
 	cobj = pvcluster_findobj(&psos_pt_table, name);
 	COPPERPLATE_UNPROTECT(svc);
diff --git a/lib/psos/queue.c b/lib/psos/queue.c
--- a/lib/psos/queue.c
+++ b/lib/psos/queue.c
@@ -28,6 +28,7 @@
 #include <copperplate/panic.h>
 #include <copperplate/cluster.h>
 #include <psos/psos.h>
+#include <psos/long_names.h>
 #include "reference.h"
 #include "task.h"
 #include "queue.h"
@@ -85,6 +86,7 @@ static u_long __q_create(const char *nam
 	struct service svc;
 	int sobj_flags = 0;
 	int ret = SUCCESS;
+	char short_name[5];
 
 	COPPERPLATE_PROTECT(svc);
 
@@ -97,6 +99,7 @@ static u_long __q_create(const char *nam
 	if (name == NULL || *name == '\0')
 		sprintf(q->name, "q%lu", ++anon_qids);
 	else {
+		name = __psos_maybe_short_name(short_name, name);
 		strncpy(q->name, name, sizeof(q->name));
 		q->name[sizeof(q->name) - 1] = '\0';
 	}
@@ -197,10 +200,13 @@ static u_long __q_ident(const char *name
 	struct clusterobj *cobj;
 	struct psos_queue *q;
 	struct service svc;
+	char short_name[5];
 
 	if (node)
 		return ERR_NODENO;
 
+	name = __psos_maybe_short_name(short_name, name);
+
 	COPPERPLATE_PROTECT(svc);
 	cobj = cluster_findobj(&psos_queue_table, name);
 	COPPERPLATE_UNPROTECT(svc);
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
@@ -26,6 +26,7 @@
 #include <copperplate/threadobj.h>
 #include <copperplate/clockobj.h>
 #include <psos/psos.h>
+#include <psos/long_names.h>
 #include "tm.h"
 #include "rn.h"
 
@@ -68,6 +69,7 @@ u_long rn_create(const char *name, void 
 	int sobj_flags = 0, ret = SUCCESS;
 	struct psos_rn *rn;
 	struct service svc;
+	char short_name[5];
 
 	if ((uintptr_t)saddr & (sizeof(uintptr_t) - 1))
 		return ERR_RNADDR;
@@ -113,6 +115,7 @@ u_long rn_create(const char *name, void 
 	if (name == NULL || *name == '\0')
 		sprintf(rn->name, "rn%lu", ++anon_rnids);
 	else {
+		name = __psos_maybe_short_name(short_name, name);
 		strncpy(rn->name, name, sizeof(rn->name));
 		rn->name[sizeof(rn->name) - 1] = '\0';
 	}
@@ -190,6 +193,8 @@ u_long rn_ident(const char *name, u_long
 	struct pvclusterobj *cobj;
 	struct psos_rn *rn;
 	struct service svc;
+	char short_name[5];
+	name = __psos_maybe_short_name(short_name, name);
 
 	COPPERPLATE_PROTECT(svc);
 	cobj = pvcluster_findobj(&psos_rn_table, name);
diff --git a/lib/psos/sem.c b/lib/psos/sem.c
--- a/lib/psos/sem.c
+++ b/lib/psos/sem.c
@@ -30,6 +30,7 @@
 #include "sem.h"
 #include "tm.h"
 #include <psos/psos.h>
+#include <psos/long_names.h>
 
 #define sem_magic	0x8181fbfb
 
@@ -77,6 +78,7 @@ u_long sm_create(const char *name,
 	struct service svc;
 	int sobj_flags = 0;
 	int ret = SUCCESS;
+	char short_name[5];
 
 	COPPERPLATE_PROTECT(svc);
 
@@ -89,6 +91,7 @@ u_long sm_create(const char *name,
 	if (name == NULL || *name == '\0')
 		sprintf(sem->name, "sm%lu", ++anon_smids);
 	else {
+		name = __psos_maybe_short_name(short_name, name);
 		strncpy(sem->name, name, sizeof(sem->name));
 		sem->name[sizeof(sem->name) - 1] = '\0';
 	}
@@ -148,10 +151,13 @@ u_long sm_ident(const char *name, u_long
 	struct clusterobj *cobj;
 	struct psos_sem *sem;
 	struct service svc;
+	char short_name[5];
 
 	if (node)
 		return ERR_NODENO;
 
+	name = __psos_maybe_short_name(short_name, name);
+
 	COPPERPLATE_PROTECT(svc);
 	cobj = cluster_findobj(&psos_sem_table, name);
 	COPPERPLATE_UNPROTECT(svc);
diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -33,6 +33,7 @@
 #include <copperplate/clockobj.h>
 #include <copperplate/cluster.h>
 #include <psos/psos.h>
+#include <psos/long_names.h>
 #include "task.h"
 #include "tm.h"
 
@@ -247,6 +248,7 @@ u_long t_create(const char *name, u_long
 	struct syncstate syns;
 	struct service svc;
 	int ret, cprio;
+	char short_name[5];
 
 	ret = check_task_priority(prio, &cprio);
 	if (ret)
@@ -276,6 +278,7 @@ u_long t_create(const char *name, u_long
 	if (name == NULL || *name == '\0')
 		sprintf(task->name, "t%lu", ++anon_tids);
 	else {
+		name = __psos_maybe_short_name(short_name, name);
 		strncpy(task->name, name, sizeof(task->name));
 		task->name[sizeof(task->name) - 1] = '\0';
 	}
@@ -460,6 +463,7 @@ u_long t_ident(const char *name, u_long 
 	struct psos_task *task;
 	struct service svc;
 	int ret = SUCCESS;
+	char short_name[5];
 
 	if (node)
 		return ERR_NODENO;
@@ -471,6 +475,7 @@ u_long t_ident(const char *name, u_long 
 		if (task == NULL)
 			goto out;
 	} else {
+		name = __psos_maybe_short_name(short_name, name);
 		cobj = cluster_findobj(&psos_task_table, name);
 		if (cobj == NULL) {
 			ret = ERR_OBJNF;


