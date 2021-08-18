From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH 4/4] cobalt/mqueue: Export created mqueues to procfs
Date: Wed, 18 Aug 2021 13:24:07 +0200
Message-Id: <20210818112407.12264-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210818112407.12264-1-florian.bezdeka@siemens.com>
References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
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

Exporting created mqueues to /proc/xenomai/registry/mqueue helps to
identify resource leaks by making mqueues visible. The content of all
created virtual files is empty. Removal of such files is not possible
and reports "operation not supported".

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/mqueue.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index ebe7cf7b0..59d176491 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -87,6 +87,38 @@ static struct mq_attr default_attr = {
 
 static LIST_HEAD(cobalt_mqq);
 
+#ifdef CONFIG_XENO_OPT_VFILE
+
+static int mq_vfile_show(struct xnvfile_regular_iterator *it, void *data)
+{
+	return 0;
+}
+
+static struct xnvfile_regular_ops mq_vfile_ops = {
+	.show = mq_vfile_show,
+};
+
+static struct xnpnode_regular __mq_pnode = {
+	.node = {
+		.dirname = "mqueue",
+		.root = NULL,
+		.ops = &xnregistry_vfreg_ops,
+	},
+	.vfile = {
+		.ops = &mq_vfile_ops,
+	},
+};
+
+#else /* !CONFIG_XENO_OPT_VFILE */
+
+static struct xnpnode_link __iddp_pnode = {
+	.node = {
+		.dirname = "mqueue",
+	},
+};
+
+#endif /* !CONFIG_XENO_OPT_VFILE */
+
 static inline struct cobalt_msg *mq_msg_alloc(struct cobalt_mq *mq)
 {
 	if (list_empty(&mq->avail))
@@ -352,7 +384,8 @@ static int mq_open(int uqd, const char *name, int oflags,
 		}
 
 		xnlock_get_irqsave(&nklock, s);
-		err = xnregistry_enter(mq->name, mq, &mq->handle, NULL);
+		err = xnregistry_enter(mq->name, mq, &mq->handle,
+				       &__mq_pnode.node);
 		if (err < 0)
 			--mq->refs;
 		else
-- 
2.30.2


