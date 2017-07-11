From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 11 Jul 2017 13:32:12 +0200
Message-Id: <20170711113213.16427-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/2] lib/alchemy: fix rt_mutex_create return values
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai @ xenomai . org" <xenomai@xenomai.org>

From: Henning Schild <henning.schild@siemens.com>

rt_mutex_create turned an -EPERM from the cobalt kernel syscall path
into an -EEXIST. If you have a model where threads create their
shadows on demand, when seeing the first -EPERM, that return value
must not be changed.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/alchemy/mutex.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 3aa55dd521..8c5e5f5968 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -96,7 +96,8 @@ static struct registry_operations registry_ops;
  * registered mutex.
  *
  * - -EPERM is returned if this service was called from an
- * asynchronous context.
+ * asynchronous context. Or - in dual kernel - when the thread is not
+ * allowed to issue syscalls.
  *
  * @apitags{mode-unrestricted, switch-secondary}
  *
@@ -147,12 +148,16 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
 		ret = 0;
 	}
 
-	if (syncluster_addobj(&alchemy_mutex_table, mcb->name, &mcb->cobj)) {
+	if (ret = syncluster_addobj(&alchemy_mutex_table, mcb->name,
+				    &mcb->cobj))
+	{
 		registry_destroy_file(&mcb->fsobj);
 		xnfree(mcb);
-		ret = -EEXIST;
-	} else
+		if (ret != -EPERM)
+			ret = -EEXIST;
+	} else {
 		mutex->handle = mainheap_ref(mcb, uintptr_t);
+	}
 out:
 	CANCEL_RESTORE(svc);
 
-- 
2.13.0


