From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH v2 4/4] y2038: lib/cobalt: Add support of
 sc_cobalt_sem_timedwait_time64
Date: Mon,  8 Mar 2021 18:02:06 +0100
Message-Id: <20210308170206.313181-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210308170206.313181-1-florian.bezdeka@siemens.com>
References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org, chensong@kylinos.cn

In case libcobalt is build with -D_TIME_BITS=64
sc_cobalt_sem_timedwait_time64 will be used instead of
sc_cobalt_sem_timedwait.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/semaphore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 45705d48f..7e7e6c707 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -373,7 +373,12 @@ COBALT_IMPL(int, sem_timedwait, (sem_t *sem, const struct timespec *abs_timeout)
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait_time64, _sem,
+			       abs_timeout);
+#else
 	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.29.2


