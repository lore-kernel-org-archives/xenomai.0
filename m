Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <7a6b7aaae44e8e8cdd75.1382447102@devws164.be.alcatel-lucent.com>
Date: Tue, 22 Oct 2013 15:05:02 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH] Xenomai-forge: psos: extended object names
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Extend object names with number to make them unique

Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>
Signed-off-by: Ronny Meeus <ronny.meeus@gmail.com>
Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

Although this is not a requirement for pSOS, it would be nice to have
unique names for debugging purposes. This comes especially in the picture
with the implementation of registry for pSOS. Without unique names no
object with duplicate name will be added to registry. Unless changes
are made to the creation of the files.


 lib/psos/queue.c |  5 ++++-
 lib/psos/rn.c    |  5 ++++-
 lib/psos/sem.c   |  5 ++++-
 lib/psos/task.c  |  5 ++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/psos/queue.c b/lib/psos/queue.c
--- a/lib/psos/queue.c
+++ b/lib/psos/queue.c
@@ -99,7 +99,10 @@ static u_long __q_create(const char *nam
 		sprintf(q->name, "q%lu", ++anon_qids);
 	else {
 		name = __psos_maybe_short_name(short_name, name);
-		strncpy(q->name, name, sizeof(q->name));
+		if (cluster_findobj(&psos_queue_table, name) != NULL)
+			snprintf(q->name,sizeof(q->name), "%s_%lu", name, ++anon_qids);
+		else
+			strncpy(q->name, name, sizeof(q->name));
 		q->name[sizeof(q->name) - 1] = '\0';
 	}
 
diff --git a/lib/psos/rn.c b/lib/psos/rn.c
--- a/lib/psos/rn.c
+++ b/lib/psos/rn.c
@@ -115,7 +115,10 @@ u_long rn_create(const char *name, void 
 		sprintf(rn->name, "rn%lu", ++anon_rnids);
 	else {
 		name = __psos_maybe_short_name(short_name, name);
-		strncpy(rn->name, name, sizeof(rn->name));
+		if (cluster_findobj(&psos_rn_table, name) != NULL)
+			snprintf(rn->name,sizeof(rn->name), "%s_%lu", name, ++anon_rnids);
+		else
+			strncpy(rn->name, name, sizeof(rn->name));
 		rn->name[sizeof(rn->name) - 1] = '\0';
 	}
 
diff --git a/lib/psos/sem.c b/lib/psos/sem.c
--- a/lib/psos/sem.c
+++ b/lib/psos/sem.c
@@ -93,7 +93,10 @@ u_long sm_create(const char *name,
 		sprintf(sem->name, "sm%lu", ++anon_smids);
 	else {
 		name = __psos_maybe_short_name(short_name, name);
-		strncpy(sem->name, name, sizeof(sem->name));
+		if (cluster_findobj(&psos_sem_table, name) != NULL)
+			snprintf(sem->name,sizeof(sem->name), "%s_%lu", name, ++anon_smids);
+		else
+			strncpy(sem->name, name, sizeof(sem->name));
 		sem->name[sizeof(sem->name) - 1] = '\0';
 	}
 
diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -285,7 +285,10 @@ u_long t_create(const char *name, u_long
 		sprintf(task->name, "t%lu", ++anon_tids);
 	else {
 		name = __psos_maybe_short_name(short_name, name);
-		strncpy(task->name, name, sizeof(task->name));
+		if (cluster_findobj(&psos_task_table, name) != NULL)
+			snprintf(task->name,sizeof(task->name), "%s_%lu", name, ++anon_tids);
+		else
+			strncpy(task->name, name, sizeof(task->name));
 		task->name[sizeof(task->name) - 1] = '\0';
 	}
 

