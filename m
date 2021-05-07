From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v6 4/4] y2038: lib/cobalt: Add support of
 sc_cobalt_sem_timedwait64
Date: Fri,  7 May 2021 23:51:49 +0200
Message-Id: <20210507215149.1409729-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210507215149.1409729-1-florian.bezdeka@siemens.com>
References: <20210507215149.1409729-1-florian.bezdeka@siemens.com>
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

In case libcobalt is build with -D_TIME_BITS=64
sc_cobalt_sem_timedwait64 will be used instead of
sc_cobalt_sem_timedwait.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/semaphore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 45705d48f..bff005440 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -373,7 +373,12 @@ COBALT_IMPL(int, sem_timedwait, (sem_t *sem, const struct timespec *abs_timeout)
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem,
+			       abs_timeout);
+#else
 	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.31.1


