From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v3 1/7] testsuite/smokey: add virtual CAN testsuite
Date: Sun,  5 Dec 2021 21:45:12 +0100
Message-Id: <20211205204518.13259-2-dariobin@libero.it>
In-Reply-To: <20211205204518.13259-1-dariobin@libero.it>
References: <20211205204518.13259-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, Dario Binacchi <dariobin@libero.it>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>

Add a minimal test for the virtual CAN driver, checking that sent
messages are received correctly.

The timeout on read operations has been wired to 1 s in order not to
fail the test in case the verbose option is enabled.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

(no changes since v1)

 configure.ac                          |   1 +
 testsuite/smokey/Makefile.am          |   2 +
 testsuite/smokey/can-virt/Makefile.am |   8 +
 testsuite/smokey/can-virt/virt.c      | 295 ++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 testsuite/smokey/can-virt/Makefile.am
 create mode 100644 testsuite/smokey/can-virt/virt.c

diff --git a/configure.ac b/configure.ac
index e7a170161..2d6b6e443 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1005,6 +1005,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/cpu-affinity/Makefile \
 	testsuite/smokey/gdb/Makefile \
 	testsuite/smokey/y2038/Makefile \
+	testsuite/smokey/can-virt/Makefile
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	utils/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 56c873026..638c6e7f6 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -12,6 +12,7 @@ smokey_SOURCES = main.c
 COBALT_SUBDIRS = 	\
 	arith 		\
 	bufp		\
+	can-virt	\
 	cpu-affinity	\
 	fpu-stress	\
 	gdb		\
@@ -49,6 +50,7 @@ MERCURY_SUBDIRS =	\
 DIST_SUBDIRS = 		\
 	arith 		\
 	bufp		\
+	can-virt	\
 	cpu-affinity	\
 	dlopen		\
 	fpu-stress	\
diff --git a/testsuite/smokey/can-virt/Makefile.am b/testsuite/smokey/can-virt/Makefile.am
new file mode 100644
index 000000000..b7cf5ec99
--- /dev/null
+++ b/testsuite/smokey/can-virt/Makefile.am
@@ -0,0 +1,8 @@
+noinst_LIBRARIES = libcan-virt.a
+
+libcan_virt_a_SOURCES = \
+	virt.c
+
+libcan_virt_a_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
diff --git a/testsuite/smokey/can-virt/virt.c b/testsuite/smokey/can-virt/virt.c
new file mode 100644
index 000000000..4066c1cd2
--- /dev/null
+++ b/testsuite/smokey/can-virt/virt.c
@@ -0,0 +1,295 @@
+/*
+ * rtcan-virt test
+ *
+ * Copyright (C) 2021 Dario Binacchi <dariobin@libero.it>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include <pthread.h>
+#include <rtdm/can.h>
+#include <sys/cobalt.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+
+struct smokey_can_virt_ctx {
+	int s;
+	unsigned int baud;
+	unsigned int id;
+	unsigned int cnt;
+	unsigned int cnt_limit;
+	bool recv_run;
+	pthread_cond_t recv_run_cond;
+	pthread_mutex_t recv_run_mutex;
+	const char *recv_ifname;
+	nanosecs_rel_t recv_timeout;
+	const char *send_ifname;
+};
+
+smokey_test_plugin(can_virt, SMOKEY_NOARGS,
+	"Check rtcan-virt driver"
+);
+
+static void can_virt_trace_frame(bool send, struct can_frame *frame)
+{
+	char buf[128];
+	int i, len = 0, n = sizeof(buf);
+
+	if (!frame || smokey_verbose_mode <= 1)
+		return;
+
+	len += snprintf(buf, n, "%s, id: %d, dlc: %d, data:",
+			send ? "send" : "recv", frame->can_id, frame->can_dlc);
+	n = sizeof(buf) - len;
+	for (i = 0; i < frame->can_dlc; i++) {
+		len += snprintf(buf + len, n, " %02x", frame->data[i]);
+		n = sizeof(buf) - len;
+	}
+
+	smokey_trace("%s", buf);
+}
+
+static int can_virt_send(struct smokey_can_virt_ctx *ctx)
+{
+	struct can_ifreq ifr;
+	struct sockaddr_can to_addr;
+	struct can_frame frame = {0};
+	int ret;
+
+	namecpy(ifr.ifr_name, ctx->send_ifname);
+	ret = smokey_check_errno(__RT(ioctl(ctx->s, SIOCGIFINDEX, &ifr)));
+	if (ret < 0)
+		goto finally;
+
+	memset(&to_addr, 0, sizeof(to_addr));
+	to_addr.can_ifindex = ifr.ifr_ifindex;
+	to_addr.can_family = AF_CAN;
+
+	frame.can_id = ctx->id;
+	frame.can_dlc = sizeof(ctx->cnt);
+	memcpy(&frame.data[0], &ctx->cnt, sizeof(ctx->cnt));
+	can_virt_trace_frame(true, &frame);
+	ret = smokey_check_errno(__RT(sendto(ctx->s, (void *)&frame,
+					     sizeof(can_frame_t), 0,
+					     (struct sockaddr *)&to_addr,
+					     sizeof(to_addr))));
+	if (ret < 0)
+		goto finally;
+
+	ret = 0;
+finally:
+	return ret;
+}
+
+static int can_virt_recv(struct smokey_can_virt_ctx *ctx)
+{
+	struct can_ifreq ifr;
+	struct sockaddr_can addr;
+	socklen_t addrlen = sizeof(addr);
+	struct sockaddr_can recv_addr;
+	struct can_frame frame;
+	unsigned int cnt;
+	int ret;
+
+	namecpy(ifr.ifr_name, ctx->recv_ifname);
+	ret = smokey_check_errno(__RT(ioctl(ctx->s, SIOCGIFINDEX, &ifr)));
+	if (ret < 0)
+		return ret;
+
+	recv_addr.can_family = AF_CAN;
+	recv_addr.can_ifindex = ifr.ifr_ifindex;
+	ret = smokey_check_errno(__RT(bind(ctx->s,
+					   (struct sockaddr *)&recv_addr,
+					   sizeof(struct sockaddr_can))));
+	if (ret < 0)
+		return ret;
+
+	ret = smokey_check_errno(__RT(ioctl(ctx->s, RTCAN_RTIOC_RCV_TIMEOUT,
+					   &ctx->recv_timeout)));
+	if (ret < 0)
+		return ret;
+
+	ret = smokey_check_errno(__RT(recvfrom(ctx->s, (void *)&frame,
+					       sizeof(can_frame_t), 0,
+					       (struct sockaddr *)&addr,
+					       &addrlen)));
+	if (ret < 0)
+		return ret;
+
+	can_virt_trace_frame(false, &frame);
+
+	if (!smokey_assert(frame.can_dlc == sizeof(ctx->cnt)))
+		return -EINVAL;
+
+	if (!smokey_assert(frame.can_id == ctx->id))
+		return -EINVAL;
+
+	memcpy(&cnt, &frame.data[0], sizeof(cnt));
+	if (!smokey_assert(cnt == ctx->cnt))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void *recv_task(void *cookie)
+{
+	struct smokey_can_virt_ctx *ctx = (struct smokey_can_virt_ctx *)cookie;
+	struct sched_param prio;
+	int ret;
+
+	pthread_mutex_lock(&ctx->recv_run_mutex);
+	prio.sched_priority = 22;
+	ret = smokey_check_status(pthread_setschedparam(pthread_self(),
+							SCHED_FIFO, &prio));
+	ctx->recv_run = true;
+	pthread_cond_signal(&ctx->recv_run_cond);
+	pthread_mutex_unlock(&ctx->recv_run_mutex);
+
+	if (ret < 0)
+		goto finally;
+
+	for (;;) {
+		ret = can_virt_recv(ctx);
+		if (ret)
+			break;
+
+		if (ctx->cnt == ctx->cnt_limit)
+			break;
+	}
+
+finally:
+	ctx->recv_run = false;
+	pthread_exit((void *)(long)ret);
+}
+
+
+static void *loop_task(void *cookie)
+{
+	struct smokey_can_virt_ctx *ctx = (struct smokey_can_virt_ctx *)cookie;
+	struct timespec ts;
+	struct sched_param prio;
+	pthread_t tid;
+	void *tstatus;
+	int ret;
+
+	prio.sched_priority = 20;
+	ret = smokey_check_status(pthread_setschedparam(pthread_self(),
+							SCHED_FIFO, &prio));
+	if (ret < 0)
+		pthread_exit((void *)(long)ret);
+
+	pthread_mutex_lock(&ctx->recv_run_mutex);
+	ret = smokey_check_status(__RT(pthread_create(&tid, NULL, recv_task,
+						      ctx)));
+	if (ret < 0)
+		pthread_exit((void *)(long)ret);
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += 1;
+	ret = smokey_check_status(pthread_cond_timedwait(&ctx->recv_run_cond,
+							 &ctx->recv_run_mutex,
+							 &ts));
+	if (ret < 0)
+		goto finally;
+
+	smokey_trace("recv task started");
+	for (; ctx->recv_run && ctx->cnt <= ctx->cnt_limit; ctx->cnt++) {
+		ret = can_virt_send(ctx);
+		if (ret)
+			goto finally;
+	}
+
+finally:
+	pthread_join(tid, &tstatus);
+	if (!ret)
+		ret = (int)(long)tstatus;
+
+	pthread_exit((void *)(long)ret);
+}
+
+static int can_virt_config(int s, const char *ifname, int baudrate, int mode)
+{
+	struct can_ifreq ifr;
+	int ret;
+
+	namecpy(ifr.ifr_name, ifname);
+	ret = smokey_check_errno(__RT(ioctl(s, SIOCGIFINDEX, &ifr)));
+	if (ret < 0)
+		return ret;
+
+	if (baudrate > 0) {
+		ifr.ifr_ifru.baudrate = baudrate;
+		ret = smokey_check_errno(__RT(ioctl(s, SIOCSCANBAUDRATE,
+						    &ifr)));
+		if (ret < 0)
+			return ret;
+	}
+
+	if (mode >= 0) {
+		ifr.ifr_ifru.mode = mode;
+		ret = smokey_check_errno(__RT(ioctl(s, SIOCSCANMODE, &ifr)));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int run_can_virt(struct smokey_test *t, int argc, char *const argv[])
+{
+	struct smokey_can_virt_ctx ctx = {
+		.baud = 1250000,
+		.id = 19,
+		.cnt = 1,
+		.cnt_limit = 1000,
+		.recv_ifname = "rtcan0",
+		.recv_timeout = 1000000000, /* 1 s */
+		.send_ifname = "rtcan1",
+	};
+	pthread_t tid;
+	void *status;
+	int ret;
+
+	pthread_mutex_init(&ctx.recv_run_mutex, NULL);
+	pthread_cond_init(&ctx.recv_run_cond, NULL);
+
+	ret = smokey_check_errno(__RT(socket(PF_CAN, SOCK_RAW, CAN_RAW)));
+	if (ret < 0)
+		return ret;
+
+	ctx.s = ret;
+
+	ret = can_virt_config(ctx.s, ctx.recv_ifname, ctx.baud, CAN_MODE_START);
+	if (ret)
+		goto finally;
+
+	smokey_trace("config: ifname: %s, baud: %d, mode: up", ctx.recv_ifname,
+		     ctx.baud);
+	ret = can_virt_config(ctx.s, ctx.send_ifname, ctx.baud, CAN_MODE_START);
+	if (ret)
+		goto finally;
+
+	smokey_trace("config: ifname: %s, baud: %d, mode: up", ctx.send_ifname,
+		     ctx.baud);
+
+	ret = smokey_check_status(__RT(pthread_create(&tid, NULL, loop_task,
+						      &ctx)));
+	if (ret < 0)
+		goto finally;
+
+	pthread_join(tid, &status);
+	ret = (int)(long)status;
+
+	can_virt_config(ctx.s, ctx.send_ifname, -1, CAN_MODE_STOP);
+	smokey_trace("config: ifname: %s, mode: down", ctx.send_ifname);
+	can_virt_config(ctx.s, ctx.recv_ifname, -1, CAN_MODE_STOP);
+	smokey_trace("config: ifname: %s, mode: down", ctx.recv_ifname);
+
+finally:
+	__RT(close(ctx.s));
+	pthread_cond_destroy(&ctx.recv_run_cond);
+	pthread_mutex_destroy(&ctx.recv_run_mutex);
+	return ret;
+}
-- 
2.17.1


