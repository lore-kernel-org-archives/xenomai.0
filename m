From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/7] y2038: lib/cobalt: Dispatch cond_wait_prologue
Date: Wed,  5 Jan 2022 15:06:46 +0100
Message-Id: <20220105140650.1033850-4-florian.bezdeka@siemens.com>
In-Reply-To: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
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

It libc reports time64_t support, cond_wait_prologue is now dispatched
to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/cond.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 1bf5c74b3..35b367a73 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -227,6 +227,20 @@ static void __pthread_cond_cleanup(void *data)
 	c->mutex->lockcnt = c->count;
 }
 
+static inline int do_sc_cond_wait_prologue(struct cobalt_cond_shadow *cnd,
+					   struct cobalt_mutex_shadow *mx,
+					   int *err, int timed,
+					   const struct timespec *abstime)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_cond_wait_prologue64;
+#else
+	long sc_nr = sc_cobalt_cond_wait_prologue;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, cnd, mx, err, timed, abstime);
+}
+
 /**
  * Wait on a condition variable.
  *
@@ -310,8 +324,7 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_cond_wait_prologue,
-			       _cnd, _mx, &c.err, 0, NULL);
+	err = do_sc_cond_wait_prologue(_cnd, _mx, &c.err, 0, NULL);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -399,8 +412,8 @@ COBALT_IMPL(int, pthread_cond_timedwait, (pthread_cond_t *cond,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_cond_wait_prologue,
-			       _cnd, _mx, &c.err, 1, abstime);
+	err = do_sc_cond_wait_prologue(_cnd, _mx, &c.err, 1, abstime);
+
 	pthread_setcanceltype(oldtype, NULL);
 
 	pthread_cleanup_pop(0);
-- 
2.30.2


