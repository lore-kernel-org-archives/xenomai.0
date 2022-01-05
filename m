From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 5/7] y2038: testsuite/smokey/y2038: Adding tests for
 cond_wait_prologue64
Date: Wed,  5 Jan 2022 15:06:48 +0100
Message-Id: <20220105140650.1033850-6-florian.bezdeka@siemens.com>
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

Extending the smokey testsuite to do some tests for the recently added
cond_wait_prologue64 syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 97 ++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index a1a5d12f6..874decc2a 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1116,6 +1116,99 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_cond_wait_prologue(void)
+{
+	int ret = 0;
+	int err = 0;
+	int sc_nr = sc_cobalt_cond_wait_prologue64;
+	pthread_mutex_t m;
+	pthread_cond_t c;
+	pthread_condattr_t attr;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+
+	if (!__T(ret, pthread_mutex_init(&m, NULL)))
+		return ret;
+
+	if (!__T(ret, pthread_condattr_init(&attr)))
+		goto out_mutex;
+
+	if (!__T(ret, pthread_cond_init(&c, &attr)))
+		goto out_cond_attr;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cond_wait_prologue64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/* Timed, but no timeout supplied, should deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, &c, &m, &err, 1 /* timed */, NULL);
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/* Timed and invalid timeout supplied, should deliver EINVAL */
+	t1.tv_sec = -1;
+	t1.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_nr, &c, &m, &err, 1 /* timed */, &t1);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	if (!__T(ret, pthread_mutex_lock(&m)))
+		goto out;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, &c, &m, &err, 1 /* timed */, &t1);
+	if (!smokey_assert(ret == -ETIMEDOUT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("cond_wait_prologue64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	pthread_mutex_unlock(&m);
+
+out:
+	pthread_cond_destroy(&c);
+out_cond_attr:
+	pthread_condattr_destroy(&attr);
+out_mutex:
+	pthread_mutex_destroy(&m);
+
+	return ret;
+}
 
 static int check_kernel_version(void)
 {
@@ -1199,5 +1292,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_cond_wait_prologue();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.30.2


