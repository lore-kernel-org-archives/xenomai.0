From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/mqueue: Avoid returning internal EADV as error
Message-ID: <0f071d3f-3cc0-5b22-48a6-79c7a017d100@siemens.com>
Date: Mon, 15 Mar 2021 12:16:36 +0100
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

In contrast to real RTDM devices, message queues have no fallback path
to Linux in userspace. Thus, EADV is neither needed nor detected by
libcobalt. Avoid leaking it from RTDM to the mq syscall interface.

Fixes: 2db562ad62ec ("cobalt: switch hand over status to -EADV for non-RTDM fd")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Found by a more sophisticated testsuite than we have in upstream. 
Unfortunately, we cannot share that suite (and most of it is 
embarrassing anyway), but we need to improve our test coverage in the 
public suite.

 kernel/cobalt/posix/mqueue.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index cd1cf3ce8c..b58d111db8 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -374,7 +374,10 @@ static int mq_open(int uqd, const char *name, int oflags,
 
 static inline int mq_close(mqd_t fd)
 {
-	return rtdm_fd_close(fd, COBALT_MQD_MAGIC);
+	int err;
+
+	err = rtdm_fd_close(fd, COBALT_MQD_MAGIC);
+	return err == -EADV ? -EBADF : err;
 }
 
 static inline int mq_unlink(const char *name)
@@ -736,8 +739,8 @@ static inline struct cobalt_mqd *cobalt_mqd_get(mqd_t ufd)
 	fd = rtdm_fd_get(ufd, COBALT_MQD_MAGIC);
 	if (IS_ERR(fd)) {
 		int err = PTR_ERR(fd);
-		if (err == -EBADF && cobalt_current_process() == NULL)
-			err = -EPERM;
+		if (err == -EADV)
+			err = cobalt_current_process() ? -EBADF : -EPERM;
 		return ERR_PTR(err);
 	}
 
-- 
2.26.2

