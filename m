Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2 3/3] y2038: testsuite/smokey/y2038: testcase for recvmmsg64
Date: Wed,  8 Sep 2021 11:30:50 +0800
Message-Id: <1631071850-4065-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Extending the test suite for recvmmsg64 test.

---
v2:
1, rename variables
2, remove unnecessary branches
3, call smokey_check_errno

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 132 +++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 8afedd7..b43a44f 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -12,6 +12,7 @@
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
 #include <mqueue.h>
+#include <rtdm/ipc.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -989,6 +990,133 @@ static int test_sc_cobalt_event_wait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_recvmmsg64(void)
+{
+	int ret = 0;
+	int sockfd;
+	int sc_nr = sc_cobalt_recvmmsg64;
+	long data;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+	struct rtipc_port_label plabel;
+	struct sockaddr_ipc saddr;
+
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_name = NULL,
+		.msg_namelen = 0,
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+	};
+
+	sockfd = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
+	if (sockfd <= 0)
+		return -errno;
+
+	strcpy(plabel.label, "y2038:recvmmsg64");
+	ret = smokey_check_errno(setsockopt(sockfd, SOL_XDDP,
+					XDDP_LABEL, &plabel, sizeof(plabel)));
+	if (ret)
+		goto out;
+
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sipc_family = AF_RTIPC;
+	saddr.sipc_port = -1;
+	ret = smokey_check_errno(bind(sockfd, (struct sockaddr *)&saddr,
+					sizeof(saddr)));
+	if (ret)
+		goto out;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("recvmmsg64: skipped. (no kernel support)");
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EADV)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg),
+				0, (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * providing an invalid timeout has to deliver EINVAL
+	 */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &t1);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * providing a zero timeout,
+	 * should come back immediately with EWOULDBLOCK
+	 */
+	t1.tv_sec = 0;
+	t1.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &t1);
+	if (!smokey_assert(ret == -EWOULDBLOCK)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &t1);
+	if (!smokey_assert(ret == -ETIMEDOUT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("recvmmsg64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t1.tv_sec, t2.tv_nsec);
+
+	ret = 0;
+
+out:
+	close(sockfd);
+	return ret;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -1041,5 +1169,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_recvmmsg64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.7.4


