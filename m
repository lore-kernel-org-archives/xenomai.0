From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 5/6] cobalt/posix/semaphore: Export named semaphores to procfs
Date: Mon, 23 Aug 2021 17:00:30 +0200
Message-Id: <20210823150031.78791-6-florian.bezdeka@siemens.com>
In-Reply-To: <20210823150031.78791-1-florian.bezdeka@siemens.com>
References: <20210823150031.78791-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Exporting named semaphores to /proc/xenomai/registry/posix/sem helps
to identify resource leaks by making registered semaphores visible. The
content of all created virtual files is empty. Removal of such files is
not possible and reports "operation not supported".

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/sem.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 72b20c78d..88d7b363a 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -26,6 +26,40 @@
 #include "sem.h"
 #include <trace/events/cobalt-posix.h>
 
+#ifdef CONFIG_XENO_OPT_VFILE
+
+extern struct xnptree posix_ptree;
+
+static int sem_vfile_show(struct xnvfile_regular_iterator *it, void *data)
+{
+	return 0;
+}
+
+static struct xnvfile_regular_ops sem_vfile_ops = {
+	.show = sem_vfile_show,
+};
+
+static struct xnpnode_regular __sem_pnode = {
+	.node = {
+		.dirname = "sem",
+		.root = &posix_ptree,
+		.ops = &xnregistry_vfreg_ops,
+	},
+	.vfile = {
+		.ops = &sem_vfile_ops,
+	},
+};
+
+#else /* !CONFIG_XENO_OPT_VFILE */
+
+static struct xnpnode_link __sem_pnode = {
+	.node = {
+		.dirname = "sem",
+	}
+};
+
+#endif /* !CONFIG_XENO_OPT_VFILE */
+
 static inline struct cobalt_resources *sem_kqueue(struct cobalt_sem *sem)
 {
 	int pshared = !!(sem->flags & SEM_PSHARED);
@@ -134,7 +168,8 @@ __cobalt_sem_init(const char *name, struct cobalt_sem_shadow *sm,
 		goto err_lock_put;
 	}
 
-	ret = xnregistry_enter(name ?: "", sem, &sem->resnode.handle, NULL);
+	ret = xnregistry_enter(name ?: "", sem, &sem->resnode.handle,
+			       name ? &__sem_pnode.node : NULL);
 	if (ret < 0)
 		goto err_lock_put;
 
-- 
2.30.2


