Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for recvmmsg64
Date: Tue,  7 Sep 2021 15:07:21 +0800
Message-Id: <1630998441-20041-1-git-send-email-chensong_2000@189.cn>
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

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 testsuite/smokey/y2038/syscall-tests.c | 135 +++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 8afedd7..7b68021 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -12,6 +12,7 @@
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
 #include <mqueue.h>
+#include <rtdm/ipc.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -989,6 +990,136 @@ static int test_sc_cobalt_event_wait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_recvmmsg64(void)
+{
+	int ret = 0;
+	int sockfd;
+	int sc_nr = sc_cobalt_recvmmsg64;
+	long data;
+	struct xn_timespec64 ts64, ts_wu;
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
+	ret = setsockopt(sockfd, SOL_XDDP, XDDP_LABEL, &plabel, sizeof(plabel));
+	if (ret) {
+		ret = -errno;
+		goto out;
+	}
+
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sipc_family = AF_RTIPC;
+	saddr.sipc_port = -1;
+	ret = bind(sockfd, (struct sockaddr *)&saddr, sizeof(saddr));
+	if (ret) {
+		ret = -errno;
+		goto out;
+	}
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
+	ts64.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &ts64);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * providing a zero timeout,
+	 * should come back immediately with EWOULDBLOCK
+	 */
+	ts64.tv_sec = 0;
+	ts64.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &ts64);
+	if (!smokey_assert(ret == -EWOULDBLOCK)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	} else
+		ret = 0;
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
+	ts64.tv_sec = 0;
+	ts64.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, sockfd, &msg, sizeof(msg), 0, &ts64);
+	if (!smokey_assert(ret == -ETIMEDOUT)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	} else
+		ret = 0;
+
+	ts64.tv_sec = ts_nat.tv_sec;
+	ts64.tv_nsec = ts_nat.tv_nsec;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	ts_wu.tv_sec = ts_nat.tv_sec;
+	ts_wu.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&ts_wu, &ts64))
+		smokey_warning("event_wait64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       ts64.tv_sec, ts64.tv_nsec, ts_wu.tv_sec,
+			       ts_wu.tv_nsec);
+
+out:
+	close(sockfd);
+	return ret;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -1041,5 +1172,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
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


