Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1eaa6333343a30020cd3.1381827039@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
Date: Tue, 15 Oct 2013 10:50:39 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 3 of 3] Initial implementation registry pSOS queue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Initial implementation of the registry functionality
for pSOS queues.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

diff --git a/lib/psos/queue.c b/lib/psos/queue.c
--- a/lib/psos/queue.c
+++ b/lib/psos/queue.c
@@ -21,6 +21,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <memory.h>
+#include <fcntl.h>
 #include <copperplate/threadobj.h>
 #include <copperplate/heapobj.h>
 #include <copperplate/clockobj.h>
@@ -74,10 +75,78 @@ objid_error:
 static void queue_finalize(struct syncobj *sobj)
 {
 	struct psos_queue *q = container_of(sobj, struct psos_queue, sobj);
+	registry_destroy_file(&q->fsobj);
 	xnfree(q);
 }
 fnref_register(libpsos, queue_finalize);
 
+#ifdef CONFIG_XENO_REGISTRY
+
+static ssize_t queue_registry_read(struct fsobj *fsobj,
+                                 char *buf, size_t size, off_t offset)
+{
+	struct psos_queue *queue;
+	size_t len;
+	struct msgholder *msg, *tmp;
+	int i;
+	void *msgbuffer = NULL;
+	int typesize;
+
+	queue = container_of(fsobj, struct psos_queue, fsobj);
+
+	if(queue->flags & Q_VARIABLE) {
+		// If queue is variable, we do not know type so we select one byte
+		typesize = 1;
+	}
+	else {
+		typesize = sizeof(unsigned long);
+	}
+	msgbuffer = (void*) malloc(queue->maxlen + 1);
+	if(msgbuffer == NULL)
+		return -ENOMEM;
+
+	len =  sprintf(buf,       "%-14s= %11s\n", "name", queue->name);
+	len += sprintf(buf + len, "%-14s= %#011lx\n","queue_id",  mainheap_ref(queue, u_long));
+	len += sprintf(buf + len, "%-14s= %11lu\n", "message_count", queue->msgcount);
+	len += sprintf(buf + len, "%-14s= %11lu\n", "max_messages", queue->maxmsg);
+	len += sprintf(buf + len, "%-14s= %11lu\n", "max_length", queue->maxlen);
+	len += sprintf(buf + len, "%-14s= \n", "messages");
+
+	if (!list_empty(&queue->msg_list)) {
+		list_for_each_entry_safe(msg, tmp, &queue->msg_list, link) {
+			memcpy(msgbuffer, msg + 1, msg->size);
+			for(i = 0; i < msg->size/typesize; i++){
+				if(queue->flags & Q_VARIABLE) {
+					len += sprintf(buf + len, "%02x ", 
+					*(unsigned char *) (msgbuffer + i));
+				}
+				else {
+					len += sprintf(buf + len, "%lu ",
+					*(unsigned long *) (msgbuffer + i * typesize));
+				}				
+			}
+			len += sprintf(buf + len, "\n");
+		}
+	}
+	free(msgbuffer);
+
+	if(len < offset)
+		return (ssize_t)0;
+	else
+		return (ssize_t)len;
+}
+
+
+static struct registry_operations registry_ops = {
+        .read   = queue_registry_read
+};
+
+#else
+
+static struct registry_operations registry_ops;
+
+#endif /* CONFIG_XENO_REGISTRY */
+
 static u_long __q_create(const char *name, u_long count,
 			 u_long flags, u_long maxlen, u_long *qid_r)
 {
@@ -122,6 +191,14 @@ static u_long __q_create(const char *nam
 	q->msgcount = 0;
 	q->magic = queue_magic;
 	*qid_r = mainheap_ref(q, u_long);
+
+        registry_init_file(&q->fsobj, &registry_ops);
+
+        ret = __bt(registry_add_file(&q->fsobj, O_RDONLY,
+                                     "/psos/queues/%s", q->name));
+        if (ret)
+                warning("failed to export queue %s to registry",
+                                q->name);
 out:
 	CANCEL_RESTORE(svc);
 
diff --git a/lib/psos/queue.h b/lib/psos/queue.h
--- a/lib/psos/queue.h
+++ b/lib/psos/queue.h
@@ -39,6 +39,7 @@ struct psos_queue {
 	struct syncobj sobj;
 	struct list msg_list;
 	struct clusterobj cobj;
+	struct fsobj fsobj;
 };
 
 struct psos_queue_wait {

