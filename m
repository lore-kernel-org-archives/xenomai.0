From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7b1856bc-f10c-443d-a342-36ce6f330fe9@siemens.com>
Date: Tue, 9 Oct 2018 11:20:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/posix/mqueue: Fix crash after failing
 registration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

If xnregistry_enter in mq_open fails, the new entry will not be added to
cobalt_mqq. But the cleanup path taken afterwards will nevertheless try
to remove it from there. That will cause a crash because the mq->link is
uninitialized. Fix that by initializing it as list head so that list
removal becomes harmless, even when the entry is not on any list..

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This replaces "cobalt/posix/mqueue: Remove unused cobalt_mqq and fix
error cleanup bug".

 kernel/cobalt/posix/mqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 859e12ed7b..5c644b2c41 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -151,6 +151,7 @@ static inline int mq_init(struct cobalt_mq *mq, const struct mq_attr *attr)
 	xnselect_init(&mq->write_select);
 	mq->magic = COBALT_MQ_MAGIC;
 	mq->refs = 2;
+	INIT_LIST_HEAD(&mq->link);
 
 	return 0;
 }
-- 
2.16.4

