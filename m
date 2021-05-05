From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 9/9] y2038: lib/cobalt: Add support of
 sc_cobalt_sem_timedwait64
Date: Wed,  5 May 2021 18:53:08 +0200
Message-Id: <982238c6b23f47f49551c169c3e4837bb52de4d0.1620233588.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620233588.git.jan.kiszka@siemens.com>
References: <cover.1620233588.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

From: Florian Bezdeka <florian.bezdeka@siemens.com>

In case libcobalt is build with -D_TIME_BITS=64
sc_cobalt_sem_timedwait64 will be used instead of
sc_cobalt_sem_timedwait.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/semaphore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 45705d48f3..bff0054401 100644
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
2.26.2


