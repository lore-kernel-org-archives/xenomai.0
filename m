From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 17/31] demo/net: add rtnet tests
Date: Tue, 11 May 2021 18:05:21 +0200
Message-Id: <20210511160535.26580-18-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 configure.ac                   |   1 +
 demo/Makefile.am               |   2 +-
 demo/net/Makefile.am           |  78 ++++++++
 demo/net/mcast-receiver.c      | 205 ++++++++++++++++++++
 demo/net/mcast-sender.c        | 151 +++++++++++++++
 demo/net/raw-ethernet.c        | 100 ++++++++++
 demo/net/rtt-mcast-measure.c   | 210 ++++++++++++++++++++
 demo/net/rtt-mcast-responder.c | 109 +++++++++++
 demo/net/rtt-responder.c       | 193 +++++++++++++++++++
 demo/net/rtt-sender.c          | 341 +++++++++++++++++++++++++++++++++
 demo/net/rttcp-client.c        | 212 ++++++++++++++++++++
 demo/net/rttcp-server.c        | 181 +++++++++++++++++
 demo/net/udp-send.c            | 136 +++++++++++++
 13 files changed, 1918 insertions(+), 1 deletion(-)
 create mode 100644 demo/net/Makefile.am
 create mode 100644 demo/net/mcast-receiver.c
 create mode 100644 demo/net/mcast-sender.c
 create mode 100644 demo/net/raw-ethernet.c
 create mode 100644 demo/net/rtt-mcast-measure.c
 create mode 100644 demo/net/rtt-mcast-responder.c
 create mode 100644 demo/net/rtt-responder.c
 create mode 100644 demo/net/rtt-sender.c
 create mode 100644 demo/net/rttcp-client.c
 create mode 100644 demo/net/rttcp-server.c
 create mode 100644 demo/net/udp-send.c

diff --git a/configure.ac b/configure.ac
index bd5fd5ba9..8fd322d54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1010,6 +1010,7 @@ AC_CONFIG_FILES([ \
 	demo/posix/cobalt/Makefile \
 	demo/alchemy/Makefile \
 	demo/alchemy/cobalt/Makefile \
+	demo/net/Makefile \
 	include/Makefile \
 	include/cobalt/uapi/Makefile \
 	include/cobalt/uapi/asm-generic/Makefile \
diff --git a/demo/Makefile.am b/demo/Makefile.am
index fe5107c25..2839d074b 100644
--- a/demo/Makefile.am
+++ b/demo/Makefile.am
@@ -1,2 +1,2 @@
 
-SUBDIRS = posix alchemy
+SUBDIRS = posix alchemy net
diff --git a/demo/net/Makefile.am b/demo/net/Makefile.am
new file mode 100644
index 000000000..f9755bace
--- /dev/null
+++ b/demo/net/Makefile.am
@@ -0,0 +1,78 @@
+demodir = @XENO_DEMO_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+demo_PROGRAMS = 	\
+	mcast-receiver	\
+	mcast-sender	\
+	raw-ethernet	\
+	rttcp-client	\
+	rttcp-server	\
+	rtt-mcast-measure	\
+	rtt-mcast-responder	\
+	rtt-responder	\
+	rtt-sender	\
+	udp-send
+
+cppflags = 			\
+	$(XENO_USER_CFLAGS)	\
+	-I$(top_srcdir)/include
+
+ldflags = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+
+ldadd = 					\
+	 @XENO_CORE_LDADD@			\
+	 @XENO_USER_LDADD@			\
+	-lpthread -lrt
+
+mcast_receiver_SOURCES = mcast-receiver.c
+mcast_receiver_CPPFLAGS = $(cppflags)
+mcast_receiver_LDFLAGS = $(ldflags)
+mcast_receiver_LDADD = $(ldadd)
+
+mcast_sender_SOURCES = mcast-sender.c
+mcast_sender_CPPFLAGS = $(cppflags)
+mcast_sender_LDFLAGS = $(ldflags)
+mcast_sender_LDADD = $(ldadd)
+
+raw_ethernet_SOURCES = raw-ethernet.c
+raw_ethernet_CPPFLAGS = $(cppflags)
+raw_ethernet_LDFLAGS = $(ldflags)
+raw_ethernet_LDADD = $(ldadd)
+
+rttcp_client_SOURCES = rttcp-client.c
+rttcp_client_CPPFLAGS = $(cppflags)
+rttcp_client_LDFLAGS = $(ldflags)
+rttcp_client_LDADD = $(ldadd)
+
+rttcp_server_SOURCES = rttcp-server.c
+rttcp_server_CPPFLAGS = $(cppflags)
+rttcp_server_LDFLAGS = $(ldflags)
+rttcp_server_LDADD = $(ldadd)
+
+rtt_mcast_measure_SOURCES = rtt-mcast-measure.c
+rtt_mcast_measure_CPPFLAGS = $(cppflags)
+rtt_mcast_measure_LDFLAGS = $(ldflags)
+rtt_mcast_measure_LDADD = ../../lib/alchemy/libalchemy.la 	\
+		../../lib/copperplate/libcopperplate.la		\
+		$(ldadd)
+
+rtt_mcast_responder_SOURCES = rtt-mcast-responder.c
+rtt_mcast_responder_CPPFLAGS = $(cppflags)
+rtt_mcast_responder_LDFLAGS = $(ldflags)
+rtt_mcast_responder_LDADD = $(ldadd)
+
+rtt_responder_SOURCES = rtt-responder.c
+rtt_responder_CPPFLAGS = $(cppflags)
+rtt_responder_LDFLAGS = $(ldflags)
+rtt_responder_LDADD = $(ldadd)
+
+rtt_sender_SOURCES = rtt-sender.c
+rtt_sender_CPPFLAGS = $(cppflags)
+rtt_sender_LDFLAGS = $(ldflags)
+rtt_sender_LDADD = $(ldadd)
+
+udp_send_SOURCES = udp-send.c
+udp_send_CPPFLAGS = $(cppflags)
+udp_send_LDFLAGS = $(ldflags)
+udp_send_LDADD = $(ldadd)
diff --git a/demo/net/mcast-receiver.c b/demo/net/mcast-receiver.c
new file mode 100644
index 000000000..a121d0d32
--- /dev/null
+++ b/demo/net/mcast-receiver.c
@@ -0,0 +1,205 @@
+/*
+ * listener.c -- joins a multicast group and echoes all data it receives from
+ *		the group to its stdout...
+ *
+ * Antony Courtney,	25/11/94
+ * Modified by: Frédéric Bastien (25/03/04)
+ * to compile without warning and work correctly
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <time.h>
+#include <string.h>
+#include <sched.h>
+#include <pthread.h>
+#include <errno.h>
+
+#include <sys/ioctl.h>
+#include <linux/sockios.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <signal.h>
+
+#include <execinfo.h>
+
+#define HELLO_PORT 12345
+#define HELLO_GROUP "225.0.0.37"
+#define MSGBUFSIZE 256
+
+#define TO_US(ns) \
+    (ns) / 1000, (ns) % 1000
+
+static void check(const char *file, int line, const char *service, int status, int err)
+{
+	if (status >= 0)
+		return;
+
+	pthread_setmode_np(PTHREAD_WARNSW, 0, NULL);
+	__real_fprintf(stderr, "%s:%d: %s: %s\n", file, line, service, strerror(err));
+
+	exit(EXIT_FAILURE);
+}
+
+#define check_pthread(expr)						\
+    ({									\
+	    int _status = (expr);					\
+	    check(__FILE__, __LINE__, #expr, -_status, _status);	\
+    })
+
+#define check_unix(expr)					\
+    ({								\
+	    int _status = (expr);				\
+	    check(__FILE__, __LINE__, #expr, _status, errno);	\
+    })
+
+static const char *reason_str[] = {
+	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
+	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
+	[SIGDEBUG_MIGRATE_SYSCALL] = "invoked syscall",
+	[SIGDEBUG_MIGRATE_FAULT] = "triggered fault",
+	[SIGDEBUG_MIGRATE_PRIOINV] = "owner is not in real-time mode",
+	[SIGDEBUG_NOMLOCK] = "process memory not locked",
+	[SIGDEBUG_WATCHDOG] = "watchdog triggered (period too short?)",
+	[SIGDEBUG_LOCK_BREAK] = "scheduler lock break",
+	[SIGDEBUG_MUTEX_SLEEP] = "caller sleeps with mutex",
+};
+
+static void sigdebug(int sig, siginfo_t *si, void *context)
+{
+	const char fmt[] = "%s, aborting.\n";
+	unsigned int reason = sigdebug_reason(si);
+	int n __attribute__ ((unused));
+	static char buffer[256];
+	void *bt[32];
+	int nentries;
+
+	if (reason >= sizeof(reason_str) / sizeof(reason_str[0]))
+		reason = SIGDEBUG_UNDEFINED;
+
+	n = snprintf(buffer, sizeof(buffer), fmt, reason_str[reason]);
+	n = write(STDERR_FILENO, buffer, n);
+	nentries = backtrace(bt, sizeof(bt) / sizeof(bt[0]));
+	backtrace_symbols_fd(bt, nentries, STDERR_FILENO);
+
+	signal(sig, SIG_DFL);
+	kill(getpid(), sig);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long long min, max, sum, count, gmin, gmax, gsum, gcount;
+	struct sigaction sa __attribute__((unused));
+	struct sockaddr_in addr;
+	int fd, err;
+	struct ip_mreq mreq;
+	socklen_t addrlen;
+	struct timespec last_print;
+	struct sched_param sparm;
+	char msgbuf[MSGBUFSIZE];
+	bool first = true;
+
+	if (argc != 2) {
+		fprintf(stderr, "Local ip address expected as first and "
+			"only argument\n");
+		exit(EXIT_FAILURE);
+	}
+
+	sparm.sched_priority = 97;
+	check_pthread(pthread_setschedparam(pthread_self(),
+						    SCHED_FIFO, &sparm));
+
+	check_unix(fd = socket(AF_INET,SOCK_DGRAM,0));
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_sigaction = sigdebug;
+	sa.sa_flags = SA_SIGINFO;
+	check_unix(sigaction(SIGDEBUG, &sa, NULL));
+
+	memset(&addr,0,sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = inet_addr(argv[1]);
+	addr.sin_port = htons(HELLO_PORT);
+
+	check_unix(bind(fd, (struct sockaddr *)&addr,sizeof(addr)));
+
+	mreq.imr_multiaddr.s_addr = inet_addr(HELLO_GROUP);
+	mreq.imr_interface.s_addr = addr.sin_addr.s_addr;
+	check_unix(setsockopt(fd,IPPROTO_IP,
+				IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq)));
+
+	gmin = min = ~0ULL;
+	gmax = max = 0;
+	gsum = sum = 0;
+	gcount = count = 0;
+
+	check_pthread(pthread_setmode_np(0, PTHREAD_WARNSW, NULL));
+
+	check_unix(clock_gettime(CLOCK_REALTIME, &last_print));
+
+	while (1) {
+		struct timespec now;
+		struct timeval packet;
+		unsigned long long diff;
+
+		addrlen = sizeof(addr);
+		check_unix(recvfrom(fd, msgbuf, sizeof(msgbuf), 0,
+					(struct sockaddr *)&addr, &addrlen));
+		check_unix(clock_gettime(CLOCK_REALTIME, &now));
+
+		err = ioctl(fd, SIOCGSTAMP, &packet);
+		if (err < 0) {
+			perror("ioctl");
+			exit(1);
+		}
+
+		if (first) {
+			first = false;
+			continue;
+		}
+
+		diff = now.tv_sec * 1000000000ULL + now.tv_nsec -
+			(packet.tv_sec * 1000000000ULL
+			+ packet.tv_usec * 1000ULL);
+		if ((long long)diff < 0)
+			printf("%lu.%09lu - %lu.%06lu\n",
+				now.tv_sec, now.tv_nsec,
+				packet.tv_sec, packet.tv_usec);
+
+		if (diff < min)
+			min = diff;
+		if (diff > max)
+			max = diff;
+		sum += diff;
+		++count;
+
+		diff = now.tv_sec * 1000000000ULL + now.tv_nsec -
+			(last_print.tv_sec * 1000000000ULL
+			+ last_print.tv_nsec);
+		if (diff < 1000000000)
+			continue;
+
+		if (min < gmin)
+			gmin = min;
+		if (max > gmax)
+			gmax = max;
+		gsum += sum;
+		gcount += count;
+
+		printf("%g pps, %Lu.%03Lu %Lu.%03Lu %Lu.%03Lu "
+			"| %Lu.%03Lu %Lu.%03Lu %Lu.%03Lu\n",
+			count / (diff / 1000000000.0),
+			TO_US(min), TO_US(sum / count), TO_US(max),
+			TO_US(gmin), TO_US(gsum / gcount), TO_US(gmax));
+
+		min = ~0ULL;
+		max = 0;
+		sum = 0;
+		count = 0;
+		last_print = now;
+	}
+}
diff --git a/demo/net/mcast-sender.c b/demo/net/mcast-sender.c
new file mode 100644
index 000000000..3e4a083f9
--- /dev/null
+++ b/demo/net/mcast-sender.c
@@ -0,0 +1,151 @@
+/*
+ * sender.c -- multicasts "hello, world!" to a multicast group once a second
+ *
+ * Antony Courtney,	25/11/94
+ */
+
+#include <time.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <pthread.h>
+#include <errno.h>
+#include <signal.h>
+#include <execinfo.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+
+#define HELLO_PORT 12345
+#define HELLO_GROUP "225.0.0.37"
+
+static void check(const char *file, int line, const char *service, int status, int err)
+{
+	if (status >= 0)
+		return;
+
+	pthread_setmode_np(PTHREAD_WARNSW, 0, NULL);
+	__real_fprintf(stderr, "%s:%d: %s: %s\n", file, line, service, strerror(err));
+
+	exit(EXIT_FAILURE);
+}
+
+#define check_pthread(expr)						\
+    ({									\
+	    int _status = (expr);					\
+	    check(__FILE__, __LINE__, #expr, -_status, _status);	\
+    })
+
+#define check_unix(expr)					\
+    ({								\
+	    int _status = (expr);				\
+	    check(__FILE__, __LINE__, #expr, _status, errno);	\
+    })
+
+static const char *reason_str[] = {
+	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
+	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
+	[SIGDEBUG_MIGRATE_SYSCALL] = "invoked syscall",
+	[SIGDEBUG_MIGRATE_FAULT] = "triggered fault",
+	[SIGDEBUG_MIGRATE_PRIOINV] = "owner is not in real-time mode",
+	[SIGDEBUG_NOMLOCK] = "process memory not locked",
+	[SIGDEBUG_WATCHDOG] = "watchdog triggered (period too short?)",
+	[SIGDEBUG_LOCK_BREAK] = "scheduler lock break",
+	[SIGDEBUG_MUTEX_SLEEP] = "caller sleeps with mutex",
+};
+
+static void sigdebug(int sig, siginfo_t *si, void *context)
+{
+	const char fmt[] = "%s, aborting.\n";
+	unsigned int reason = sigdebug_reason(si);
+	int n __attribute__ ((unused));
+	static char buffer[256];
+	void *bt[32];
+	int nentries;
+
+	if (reason >= sizeof(reason_str) / sizeof(reason_str[0]))
+		reason = SIGDEBUG_UNDEFINED;
+
+	n = snprintf(buffer, sizeof(buffer), fmt, reason_str[reason]);
+	n = write(STDERR_FILENO, buffer, n);
+	nentries = backtrace(bt, sizeof(bt) / sizeof(bt[0]));
+	backtrace_symbols_fd(bt, nentries, STDERR_FILENO);
+
+	signal(sig, SIG_DFL);
+	kill(getpid(), sig);
+}
+
+static void usage(const char *progname)
+{
+	fprintf(stderr, "%s address frequency\n"
+		"Starts sending 'frequency' multicast UDP packets per second on"
+		" the interface\nwith IP address 'address'.\n",
+		progname);
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction sa __attribute__((unused));
+	struct sockaddr_in addr;
+	int fd;
+	char message[] = "Hello, World!\n";
+	struct sched_param sparm;
+	struct timespec next;
+	double freq;
+	unsigned period_ns;
+
+	if (argc != 3) {
+		usage(argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	freq = atof(argv[2]);
+	period_ns = freq ? 1000000000 / freq : 0;
+
+	check_unix(fd = socket(AF_INET,SOCK_DGRAM, 0));
+
+	addr.sin_addr.s_addr = inet_addr(argv[1]);
+
+	check_unix(setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
+				&addr.sin_addr, sizeof(addr.sin_addr)));
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_sigaction = sigdebug;
+	sa.sa_flags = SA_SIGINFO;
+	check_unix(sigaction(SIGDEBUG, &sa, NULL));
+
+	memset(&addr,0,sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = inet_addr(HELLO_GROUP);
+	addr.sin_port = htons(HELLO_PORT);
+
+	sparm.sched_priority = 99;
+	check_pthread(pthread_setschedparam(pthread_self(),
+						SCHED_FIFO, &sparm));
+
+	check_unix(clock_gettime(CLOCK_MONOTONIC, &next));
+
+	check_pthread(pthread_setmode_np(0, PTHREAD_WARNSW, NULL));
+
+	while (1) {
+		check_unix(sendto(fd,message,sizeof(message), 0,
+					(struct sockaddr *)&addr,
+					sizeof(addr)));
+
+		if (!period_ns)
+			continue;
+
+		next.tv_nsec += period_ns;
+		if (next.tv_nsec >= 1000000000) {
+			next.tv_nsec -= 1000000000;
+			next.tv_sec++;
+		}
+		check_unix(clock_nanosleep(CLOCK_MONOTONIC,
+						TIMER_ABSTIME, &next, NULL));
+	}
+}
diff --git a/demo/net/raw-ethernet.c b/demo/net/raw-ethernet.c
new file mode 100644
index 000000000..f0448d8f6
--- /dev/null
+++ b/demo/net/raw-ethernet.c
@@ -0,0 +1,100 @@
+/***
+ *
+ *  examples/xenomai/posix/raw-ethernet.c
+ *
+ *  SOCK_RAW sender - sends out Ethernet frames via a SOCK_RAW packet socket
+ *
+ *  Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>
+ *
+ *  RTnet - real-time networking example
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <netpacket/packet.h>
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+
+char buffer[1514];
+int sock;
+
+
+int main(int argc, char *argv[])
+{
+    struct sched_param param = { .sched_priority = 1 };
+    ssize_t len;
+    struct sockaddr_ll addr;
+    struct ifreq ifr;
+    struct timespec delay = { 1, 0 };
+    struct ether_header *eth = (struct ether_header *)buffer;
+
+
+    if (argc < 2) {
+        printf("usage: %s <interface>\n", argv[0]);
+        return 0;
+    }
+
+    if ((sock = socket(PF_PACKET, SOCK_RAW, htons(0x1234))) < 0) {
+        perror("socket cannot be created");
+        return 1;
+    }
+
+    strncpy(ifr.ifr_name, argv[1], IFNAMSIZ-1)[IFNAMSIZ-1] = 0;
+    if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
+        perror("cannot get interface index");
+        close(sock);
+        return 1;
+    }
+
+    addr.sll_family   = AF_PACKET;
+    addr.sll_protocol = htons(0x1234);
+    addr.sll_ifindex  = ifr.ifr_ifindex;
+
+    if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+        perror("cannot bind to local ip/port");
+        close(sock);
+        return 1;
+    }
+
+    memset(eth->ether_dhost, 0xFF, ETH_HLEN);
+    eth->ether_type = htons(0x1234);
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    while (1) {
+        len = send(sock, buffer, sizeof(buffer), 0);
+        if (len < 0)
+            break;
+
+        printf("Sent frame of %zd bytes\n", len);
+
+        nanosleep(&delay, NULL);
+    }
+
+    /* This call also leaves primary mode, required for socket cleanup. */
+    printf("shutting down\n");
+
+    return 0;
+}
diff --git a/demo/net/rtt-mcast-measure.c b/demo/net/rtt-mcast-measure.c
new file mode 100644
index 000000000..dc6650645
--- /dev/null
+++ b/demo/net/rtt-mcast-measure.c
@@ -0,0 +1,210 @@
+/*
+ * Multicast RTT sender. Derived from.
+ *
+ * listener.c -- joins a multicast group and echoes all data it receives from
+ *		the group to its stdout...
+ *
+ * Antony Courtney, 	25/11/94
+ * Modified by: Frédéric Bastien (25/03/04)
+ * to compile without warning and work correctly
+ */
+
+#include <stdio.h>
+#include <time.h>
+#include <stdlib.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <alchemy/task.h>
+#include <alchemy/timer.h>
+#include <rtdm/net.h>
+
+#define RTT_PORT 12345
+#define RTT_RECEIVER_GROUP "225.0.0.37"
+#define RTT_SENDER_GROUP "224.0.0.37"
+
+#define rt_inet_aton inet_addr
+#define do_div(ull, u) ({ unsigned long _r = ull % u; ull /= u; _r; })
+
+static int fd;
+
+static void thread(void *arg)
+{
+	unsigned long long gmin, gmax, gsum, gcount;
+	struct sockaddr_in addr, to_addr;
+	RTIME period, start;
+	int i, nbytes, err;
+	socklen_t addrlen;
+	char msgbuf[1500];
+
+	(void)arg;
+
+	memset(&to_addr, 0, sizeof(to_addr));
+	to_addr.sin_family = AF_INET;
+	to_addr.sin_addr.s_addr = rt_inet_aton(RTT_RECEIVER_GROUP);
+	to_addr.sin_port = htons(RTT_PORT);
+
+	start = 0;
+	period = 1000000;
+	err = rt_task_set_periodic(NULL, start, period);
+	if (err < 0) {
+		printf("make_periodic: %d\n", err);
+		rt_task_delete(NULL);
+	}
+
+	gmin = ~0ULL;
+	gmax = 0;
+	gsum = 0;
+	gcount = 0;
+
+	/* now just enter a receive/send loop */
+	for(;;) {
+		unsigned long long smin, smax, ssum, savg, gavg,
+			smin_us, smin_ns, savg_us, savg_ns, smax_us, smax_ns,
+			gmin_us, gmin_ns, gavg_us, gavg_ns, gmax_us, gmax_ns;
+
+		smin = ~0ULL;
+		smax = 0;
+		ssum = 0;
+
+		for (i = 0; i < 1000; i++) {
+			unsigned long overruns;
+			long long rtt;
+
+			err = rt_task_wait_period(&overruns);
+			if (err == -ETIMEDOUT)
+				printf("%ld overruns\n", overruns);
+			else if (err < 0) {
+				printf("wait_period: %d\n", err);
+				rt_task_delete(NULL);
+			}
+
+			rtt = rt_timer_read();
+			err = sendto(fd, msgbuf, 4, 0,
+				(struct sockaddr *)&to_addr, sizeof(to_addr));
+			if (err < 0) {
+				perror("sendto");
+				rt_task_delete(NULL);
+			}
+
+			addrlen = sizeof(addr);
+			nbytes = recvfrom(fd, msgbuf, sizeof(msgbuf), 0,
+					  (struct sockaddr *)&addr, &addrlen);
+			rtt = rt_timer_read() - rtt;
+			if (nbytes <= 0) {
+				perror("recvfrom");
+				rt_task_delete(NULL);
+			}
+
+			if (rtt < smin)
+				smin = rtt;
+			if (rtt > smax)
+				smax = rtt;
+			ssum += rtt;
+		}
+
+		if (smin < gmin)
+			gmin = smin;
+		if (smax > gmax)
+			gmax = smax;
+		gsum += ssum;
+		gcount += 1000;
+
+		savg = ssum + 500;
+		do_div(savg, 1000);
+
+		gavg = gsum + gcount / 2;
+		do_div(gavg, gcount);
+
+		smin_us = smin;
+		smin_ns = do_div(smin_us, 1000);
+
+		savg_us = savg;
+		savg_ns = do_div(savg_us, 1000);
+
+		smax_us = smax;
+		smax_ns = do_div(smax_us, 1000);
+
+		gmin_us = gmin;
+		gmin_ns = do_div(gmin_us, 1000);
+
+		gavg_us = gavg;
+		gavg_ns = do_div(gavg_us, 1000);
+
+		gmax_us = gmax;
+		gmax_ns = do_div(gmax_us, 1000);
+
+		printf("%Lu.%03Lu %Lu.%03Lu %Lu.%03Lu | %Lu.%03Lu %Lu.%03Lu %Lu.%03Lu\n",
+			smin_us, smin_ns, savg_us, savg_ns, smax_us, smax_ns,
+			gmin_us, gmin_ns, gavg_us, gavg_ns, gmax_us, gmax_ns);
+	}
+}
+
+static int create_thread(RT_TASK *tid, int mode, void *arg)
+{
+	struct sockaddr_in addr;
+	struct ip_mreq mreq;
+	int err;
+
+	/* create what looks like an ordinary UDP socket */
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return fd;
+	}
+
+	/* set up destination address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	if (!arg) {
+		printf("Local ip address expected as first and only argument\n");
+		return -EINVAL;
+	}
+
+	addr.sin_addr.s_addr = rt_inet_aton(arg);
+	addr.sin_port = htons(RTT_PORT);
+
+	/* bind to receive address */
+	err = bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("bind");
+		return err;
+	}
+
+	/* use setsockopt() to request that the kernel join a multicast group */
+	mreq.imr_multiaddr.s_addr = rt_inet_aton(RTT_SENDER_GROUP);
+	mreq.imr_interface.s_addr = addr.sin_addr.s_addr;
+	err = setsockopt(fd, IPPROTO_IP,
+			 IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq));
+	if (err < 0) {
+		perror("setsockopt");
+		rt_task_delete(NULL);
+	}
+
+	err = rt_task_spawn(tid, "rtt-mcast-measure", 8192, 99, mode,
+		thread, NULL);
+	if (err < 0)
+		printf("rt_task_spawn: %d\n", err);
+
+	return err;
+}
+
+int main(int argc, char *argv[])
+{
+	RT_TASK tid;
+	int err;
+
+	err = create_thread(&tid, T_JOINABLE, argc >= 2 ? argv[1] : NULL);
+	if (err)
+		exit(EXIT_FAILURE);
+
+	err = rt_task_join(&tid);
+	if (err < 0)
+		printf("rt_task_join: %d\n", err);
+
+	exit(EXIT_FAILURE);
+}
diff --git a/demo/net/rtt-mcast-responder.c b/demo/net/rtt-mcast-responder.c
new file mode 100644
index 000000000..b8f7dee02
--- /dev/null
+++ b/demo/net/rtt-mcast-responder.c
@@ -0,0 +1,109 @@
+/*
+ * Multicast RTT responder. Derived from.
+ *
+ * listener.c -- joins a multicast group and echoes all data it receives from
+ *		the group to its stdout...
+ *
+ * Antony Courtney, 	25/11/94
+ * Modified by: Frédéric Bastien (25/03/04)
+ * to compile without warning and work correctly
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <time.h>
+#include <string.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <pthread.h>
+#include <rtdm/net.h>
+
+
+#define RTT_PORT 12345
+#define RTT_RECEIVER_GROUP "225.0.0.37"
+#define RTT_SENDER_GROUP "224.0.0.37"
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in addr, to_addr;
+	struct sched_param sparm;
+	int add_rtskbs = 128;
+	struct ip_mreq mreq;
+	int fd, err, nbytes;
+	socklen_t addrlen;
+	char msgbuf[1500];
+
+	sparm.sched_priority = 99;
+	err = pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparm);
+	if (err) {
+		fprintf(stderr, "pthread_setschedparam: %d\n", err);
+		exit(EXIT_FAILURE);
+	}
+
+	/* create what looks like an ordinary UDP socket */
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	/* set up destination address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	if (argc != 2) {
+		fprintf(stderr, "Local ip address expected as first and only argument\n");
+		exit(EXIT_FAILURE);
+	}
+
+	addr.sin_addr.s_addr = inet_addr(argv[1]);
+	addr.sin_port = htons(RTT_PORT);
+
+	/* bind to receive address */
+	err = bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&to_addr, 0, sizeof(to_addr));
+	to_addr.sin_family = AF_INET;
+	to_addr.sin_addr.s_addr = inet_addr(RTT_SENDER_GROUP);
+	to_addr.sin_port = htons(RTT_PORT);
+
+	/* use setsockopt() to request that the kernel join a multicast group */
+	mreq.imr_multiaddr.s_addr = inet_addr(RTT_RECEIVER_GROUP);
+	mreq.imr_interface.s_addr = addr.sin_addr.s_addr;
+	err = setsockopt(fd, IPPROTO_IP,
+			IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq));
+	if (err < 0) {
+		perror("setsockopt");
+		exit(EXIT_FAILURE);
+	}
+
+	err = ioctl(fd, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
+	if (err < 0)
+		perror("ioctl(RTNET_RTIOC_EXTPOOL)\n");
+
+	/* now just enter a receive/send loop */
+	while (1) {
+		addrlen = sizeof(addr);
+		nbytes = recvfrom(fd, msgbuf, sizeof(msgbuf), 0,
+				(struct sockaddr *)&addr, &addrlen);
+		if (nbytes <= 0) {
+			perror("recvfrom");
+			exit(EXIT_FAILURE);
+		}
+
+		err = sendto(fd, msgbuf, nbytes, 0,
+			(struct sockaddr *)&to_addr, sizeof(addr));
+		if (err < 0) {
+			perror("sendto");
+			exit(EXIT_FAILURE);
+		}
+	}
+}
diff --git a/demo/net/rtt-responder.c b/demo/net/rtt-responder.c
new file mode 100644
index 000000000..6e31a1ff2
--- /dev/null
+++ b/demo/net/rtt-responder.c
@@ -0,0 +1,193 @@
+/***
+ *
+ *  examples/xenomai/posix/rtt-responder.c
+ *
+ *  Round-Trip Time Responder - listens and sends back a packet
+ *
+ *  Based on Ulrich Marx's module, later ported over user space POSIX.
+ *
+ *  Copyright (C) 2002 Ulrich Marx <marx@kammer.uni-hannover.de>
+ *                2002 Marc Kleine-Budde <kleine-budde@gmx.de>
+ *                2004, 2006 Jan Kiszka <jan.kiszka@web.de>
+ *
+ *  RTnet - real-time networking example
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <arpa/inet.h>
+#include <limits.h>
+
+#include <rtdm/net.h>
+
+char *dest_ip_s = "";
+char *local_ip_s  = "";
+unsigned int reply_size = 0;
+
+pthread_t rt_thread;
+
+#define RCV_PORT    36000
+#define XMT_PORT    35999
+
+struct sockaddr_in dest_addr;
+
+int sock;
+
+char buffer[65536];
+
+
+static void *responder(void* arg)
+{
+    struct sched_param  param = { .sched_priority = 81 };
+    struct msghdr       rx_msg;
+    struct iovec        iov;
+    ssize_t             ret;
+
+
+    if (dest_addr.sin_addr.s_addr == INADDR_ANY) {
+        rx_msg.msg_name    = &dest_addr;
+        rx_msg.msg_namelen = sizeof(dest_addr);
+    } else {
+        rx_msg.msg_name    = NULL;
+        rx_msg.msg_namelen = 0;
+    }
+    rx_msg.msg_namelen     = sizeof(struct sockaddr_in);
+    rx_msg.msg_iov         = &iov;
+    rx_msg.msg_iovlen      = 1;
+    rx_msg.msg_control     = NULL;
+    rx_msg.msg_controllen  = 0;
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    while(1) {
+        iov.iov_base = &buffer;
+        iov.iov_len  = sizeof(buffer);
+
+        ret = recvmsg(sock, &rx_msg, 0);
+        if (ret <= 0) {
+            printf("terminating responder thread\n");
+            return NULL;
+        }
+
+        sendto(sock, &buffer, reply_size ? : ret, 0,
+               (struct sockaddr *)&dest_addr,
+               sizeof(struct sockaddr_in));
+    }
+}
+
+
+int main(int argc, char *argv[])
+{
+    struct sockaddr_in local_addr;
+    int add_rtskbs = 30;
+    pthread_attr_t thattr;
+    int ret;
+
+
+    while (1) {
+        switch (getopt(argc, argv, "d:l:s:")) {
+            case 'd':
+                dest_ip_s = optarg;
+                break;
+
+            case 'l':
+                local_ip_s = optarg;
+                break;
+
+            case 's':
+                reply_size = atoi(optarg);
+                break;
+
+            case -1:
+                goto end_of_opt;
+
+            default:
+                printf("usage: %s [-d <dest_ip>] [-l <local_ip>] "
+                       "[-s <reply_size>]\n", argv[0]);
+                return 0;
+        }
+    }
+ end_of_opt:
+
+    if (dest_ip_s[0]) {
+        inet_aton(dest_ip_s, &dest_addr.sin_addr);
+        dest_addr.sin_port = htons(XMT_PORT);
+    } else
+        dest_addr.sin_addr.s_addr = INADDR_ANY;
+
+    if (local_ip_s[0])
+        inet_aton(local_ip_s, &local_addr.sin_addr);
+    else
+        local_addr.sin_addr.s_addr = INADDR_ANY;
+
+    if (reply_size > 65505)
+        reply_size = 65505;
+    else if (reply_size < sizeof(struct timespec))
+        reply_size = sizeof(struct timespec);
+
+    printf("destination ip address: %s = %08x\n",
+           dest_ip_s[0] ? dest_ip_s : "SENDER", dest_addr.sin_addr.s_addr);
+    printf("local ip address: %s = %08x\n",
+           local_ip_s[0] ? local_ip_s : "INADDR_ANY", local_addr.sin_addr.s_addr);
+    printf("reply size: %d\n", reply_size);
+
+    /* create rt-socket */
+    if ((sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
+        perror("socket cannot be created");
+        return 1;
+    }
+
+    /* bind the rt-socket to local_addr */
+    local_addr.sin_family = AF_INET;
+    local_addr.sin_port   = htons(RCV_PORT);
+    if (bind(sock, (struct sockaddr *)&local_addr, sizeof(local_addr)) < 0) {
+        perror("cannot bind to local ip/port");
+        close(sock);
+        return 1;
+    }
+
+    /* extend the socket pool */
+    ret = ioctl(sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
+    if (ret < 0)
+        perror("ioctl(RTNET_RTIOC_EXTPOOL)\n");
+
+    /* create reply rt-thread */
+    pthread_attr_init(&thattr);
+    pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_JOINABLE);
+    pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+    ret = pthread_create(&rt_thread, &thattr, &responder, NULL);
+    if (ret) {
+        close(sock);
+        errno = ret; perror("pthread_create failed");
+        return 1;
+    }
+
+    pause();
+
+    pthread_kill(rt_thread, SIGHUP);
+    pthread_join(rt_thread, NULL);
+
+    return 0;
+}
diff --git a/demo/net/rtt-sender.c b/demo/net/rtt-sender.c
new file mode 100644
index 000000000..ae75a6f19
--- /dev/null
+++ b/demo/net/rtt-sender.c
@@ -0,0 +1,341 @@
+/***
+ *
+ *  examples/xenomai/posix/rtt-requester.c
+ *
+ *  Round-Trip Time Requester - sends packet, receives echo, evaluates
+ *                              and displays per-station round-trip times
+ *
+ *  Based on Ulrich Marx's module, adopted to RTmac and later ported over
+ *  user space POSIX.
+ *
+ *  Copyright (C) 2002 Ulrich Marx <marx@kammer.uni-hannover.de>
+ *                2002 Marc Kleine-Budde <kleine-budde@gmx.de>
+ *                2006 Jan Kiszka <jan.kiszka@web.de>
+ *
+ *  RTnet - real-time networking example
+ *  RTmac - real-time media access control example
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <errno.h>
+#include <mqueue.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <arpa/inet.h>
+#include <limits.h>
+
+#include <rtdm/net.h>
+
+char *dest_ip_s = "127.0.0.1";
+char *local_ip_s = "";
+unsigned int cycle = 50000; /* 50 ms */
+
+pthread_t xmit_thread;
+pthread_t recv_thread;
+
+#define RCV_PORT                35999
+#define XMT_PORT                36000
+
+#define DEFAULT_ADD_BUFFERS     30
+
+struct sockaddr_in dest_addr;
+
+int sock;
+mqd_t mq;
+
+#define BUFSIZE 1500
+union {
+    char            data[BUFSIZE];
+    struct timespec tx_date;
+} packet;
+
+struct station_stats {
+    struct in_addr  addr;
+    long long       last, min, max;
+    unsigned long   count;
+};
+
+struct packet_stats {
+    struct in_addr  addr;
+    long long       rtt;
+};
+
+#define MAX_STATIONS 100
+static struct station_stats station[MAX_STATIONS];
+
+
+static struct station_stats *lookup_stats(struct in_addr addr)
+{
+    int i;
+
+    for (i = 0; i < MAX_STATIONS; i++) {
+        if (station[i].addr.s_addr == addr.s_addr)
+            break;
+        if (station[i].addr.s_addr == 0) {
+            station[i].addr = addr;
+            station[i].min  = LONG_MAX;
+            station[i].max  = LONG_MIN;
+            break;
+        }
+    }
+    if (i == MAX_STATIONS)
+        return NULL;
+    return &station[i];
+}
+
+
+static void *transmitter(void *arg)
+{
+    struct sched_param  param = { .sched_priority = 80 };
+    struct timespec     next_period;
+    struct timespec     tx_date;
+
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    clock_gettime(CLOCK_MONOTONIC, &next_period);
+
+    while(1) {
+        next_period.tv_nsec += cycle * 1000;
+        if (next_period.tv_nsec >= 1000000000) {
+            next_period.tv_nsec = 0;
+            next_period.tv_sec++;
+        }
+
+        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next_period, NULL);
+
+        clock_gettime(CLOCK_MONOTONIC, &tx_date);
+
+        /* transmit the request packet containing the local time */
+        if (sendto(sock, &tx_date, sizeof(tx_date), 0,
+                   (struct sockaddr *)&dest_addr,
+                   sizeof(struct sockaddr_in)) < 0) {
+            if (errno == EBADF)
+                printf("terminating transmitter thread\n");
+            else
+                perror("sendto failed");
+            return NULL;
+        }
+    }
+}
+
+
+static void *receiver(void *arg)
+{
+    struct sched_param  param = { .sched_priority = 82 };
+    struct msghdr       msg;
+    struct iovec        iov;
+    struct sockaddr_in  addr;
+    struct timespec     rx_date;
+    struct packet_stats stats;
+    int                 ret;
+
+
+    msg.msg_name       = &addr;
+    msg.msg_namelen    = sizeof(addr);
+    msg.msg_iov        = &iov;
+    msg.msg_iovlen     = 1;
+    msg.msg_control    = NULL;
+    msg.msg_controllen = 0;
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    while (1) {
+        iov.iov_base = &packet;
+        iov.iov_len  = sizeof(packet);
+
+        ret = recvmsg(sock, &msg, 0);
+        if (ret <= 0) {
+            printf("terminating receiver thread\n");
+            return NULL;
+        }
+
+        clock_gettime(CLOCK_MONOTONIC, &rx_date);
+        stats.rtt = rx_date.tv_sec * 1000000000LL + rx_date.tv_nsec;
+        stats.rtt -= packet.tx_date.tv_sec * 1000000000LL +
+            packet.tx_date.tv_nsec;
+        stats.addr = addr.sin_addr;
+
+        mq_send(mq, (char *)&stats, sizeof(stats), 0);
+    }
+}
+
+
+int main(int argc, char *argv[])
+{
+    struct sched_param param = { .sched_priority = 1 };
+    struct sockaddr_in local_addr;
+    int add_rtskbs = DEFAULT_ADD_BUFFERS;
+    pthread_attr_t thattr;
+    char mqname[32];
+    struct mq_attr mqattr;
+    int stations = 0;
+    int ret;
+
+
+    while (1) {
+        switch (getopt(argc, argv, "d:l:c:b:")) {
+            case 'd':
+                dest_ip_s = optarg;
+                break;
+
+            case 'l':
+                local_ip_s = optarg;
+                break;
+
+            case 'c':
+                cycle = atoi(optarg);
+                break;
+
+            case 'b':
+                add_rtskbs = atoi(optarg);
+
+            case -1:
+                goto end_of_opt;
+
+            default:
+                printf("usage: %s [-d <dest_ip>] [-l <local_ip>] "
+                       "[-c <cycle_microsecs>] [-b <add_buffers>]\n",
+                       argv[0]);
+                return 0;
+        }
+    }
+ end_of_opt:
+
+    dest_addr.sin_family = AF_INET;
+    dest_addr.sin_port   = htons(XMT_PORT);
+    if (dest_ip_s[0])
+        inet_aton(dest_ip_s, &dest_addr.sin_addr);
+    else
+        dest_addr.sin_addr.s_addr = INADDR_ANY;
+
+    if (local_ip_s[0])
+        inet_aton(local_ip_s, &local_addr.sin_addr);
+    else
+        local_addr.sin_addr.s_addr = INADDR_ANY;
+
+    printf("destination ip address: %s = %08x\n",
+           dest_ip_s[0] ? dest_ip_s : "SENDER", dest_addr.sin_addr.s_addr);
+    printf("local ip address: %s = %08x\n",
+           local_ip_s[0] ? local_ip_s : "INADDR_ANY", local_addr.sin_addr.s_addr);
+    printf("cycle: %d us\n", cycle);
+
+    /* create rt-socket */
+    if ((sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
+        perror("socket cannot be created");
+        return 1;
+    }
+
+    /* bind the rt-socket to local_addr */
+    local_addr.sin_family = AF_INET;
+    local_addr.sin_port   = htons(RCV_PORT);
+    if (bind(sock, (struct sockaddr *)&local_addr, sizeof(local_addr)) < 0) {
+        perror("cannot bind to local ip/port");
+        close(sock);
+        return 1;
+    }
+
+    /* extend the socket pool */
+    ret = ioctl(sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
+    if (ret < 0)
+        perror("ioctl(RTNET_RTIOC_EXTPOOL)");
+
+    /* create statistics message queue */
+    snprintf(mqname, sizeof(mqname), "/rtt-sender-%d", getpid());
+    mqattr.mq_flags   = 0;
+    mqattr.mq_maxmsg  = 100;
+    mqattr.mq_msgsize = sizeof(struct packet_stats);
+    mq = mq_open(mqname, O_RDWR | O_CREAT | O_EXCL, 0600, &mqattr);
+    if (mq == (mqd_t)-1) {
+        perror("opening mqueue failed");
+        close(sock);
+        return 1;
+    }
+
+    /* create transmitter rt-thread */
+    pthread_attr_init(&thattr);
+    pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_JOINABLE);
+    pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+    ret = pthread_create(&recv_thread, &thattr, &receiver, NULL);
+    if (ret) {
+        errno = ret; perror("pthread_create(receiver) failed");
+        close(sock);
+        mq_close(mq);
+        return 1;
+    }
+
+    /* create receiver rt-thread */
+    ret = pthread_create(&xmit_thread, &thattr, &transmitter, NULL);
+    if (ret) {
+        errno = ret; perror("pthread_create(transmitter) failed");
+        close(sock);
+        mq_close(mq);
+        pthread_kill(recv_thread, SIGHUP);
+        pthread_join(recv_thread, NULL);
+        return 1;
+    }
+
+    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+
+    while (1) {
+        struct packet_stats pack;
+        struct station_stats *pstat;
+        int nr;
+
+        ret = mq_receive(mq, (char *)&pack, sizeof(pack), NULL);
+        if (ret < (int)sizeof(pack))
+            break;
+
+        pstat = lookup_stats(pack.addr);
+        if (!pstat)
+            continue;
+
+        pstat->last = pack.rtt;
+        if (pstat->last < pstat->min)
+            pstat->min = pstat->last;
+        if (pstat->last > pstat->max)
+            pstat->max = pstat->last;
+        pstat->count++;
+
+        nr = pstat - &station[0];
+        if (nr >= stations) {
+            stations = nr+1;
+            printf("\n");
+        }
+
+        printf("\033[%dA%s\t%9.3f us, min=%9.3f us, max=%9.3f us, count=%ld\n",
+               stations-nr, inet_ntoa(pack.addr), (float)pstat->last/1000,
+               (float)pstat->min/1000, (float)pstat->max/1000, pstat->count);
+        for (nr = stations-nr-1; nr > 0; nr --)
+            printf("\n");
+    }
+
+    /* This call also leaves primary mode, required for socket cleanup. */
+    printf("shutting down\n");
+
+    pthread_join(xmit_thread, NULL);
+    pthread_kill(recv_thread, SIGHUP);
+    pthread_join(recv_thread, NULL);
+
+    return 0;
+}
diff --git a/demo/net/rttcp-client.c b/demo/net/rttcp-client.c
new file mode 100644
index 000000000..e7da36b91
--- /dev/null
+++ b/demo/net/rttcp-client.c
@@ -0,0 +1,212 @@
+/***
+ *
+ *  examples/xenomai/posix/rttcp-client.c
+ *
+ *  Simple RTNet TCP client - sends packet to a server
+ *
+ *  Copyright (C) 2009 Vladimir Zapolskiy <vladimir.zapolskiy@siemens.com>
+ *
+ *  RTnet - real-time networking example
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License, version 2, as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <arpa/inet.h>
+#include <limits.h>
+
+#include <rtdm/net.h>
+
+char *dest_ip_s = "127.0.0.1";
+char *local_ip_s = "";
+unsigned int cycle = 500000; /* 500 ms */
+
+#define RCV_PORT                35999
+#define XMT_PORT                36000
+#define DEFAULT_LOOPS           10
+#define DEFAULT_ADD_BUFFERS     30
+
+int add_rtskbs = DEFAULT_ADD_BUFFERS;
+
+pthread_t sender_task = 0;
+
+struct conn_t {
+    int nloops;
+    int sock;
+    struct sockaddr_in dest_addr;
+    struct sockaddr_in local_addr;
+};
+
+const char msg[] = "Hello";
+
+static void *sender(void *arg)
+{
+    struct conn_t *connection = (struct conn_t *)arg;
+    int sock = connection->sock;
+    int ret, i, sopt_len;
+    struct timeval  tv;
+    struct timespec sleep_period;
+
+    sopt_len = 1;
+    if ((ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &sopt_len,
+                          sizeof(sopt_len))) < 0) {
+        perror("set SO_KEEPALIVE socket option");
+        return NULL;
+    }
+
+    tv.tv_sec = 0;
+    tv.tv_usec = 100000;
+    if ((ret = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tv,
+                          sizeof(tv))) < 0) {
+        perror("set SO_SNDTIMEO socket option");
+        return NULL;
+    }
+
+    if ((ret = bind(sock, (struct sockaddr*)&connection->local_addr,
+        sizeof(struct sockaddr_in))) < 0)
+    {
+        perror("bind socket");
+        return NULL;
+    }
+
+    if ((ret = connect(sock, (struct sockaddr*)&connection->dest_addr,
+        sizeof(struct sockaddr_in))) < 0)
+    {
+        perror("connect to server");
+        return NULL;
+    }
+
+    sleep_period.tv_nsec = cycle * 1000;
+
+    for (i = 1; i <= connection->nloops; i++) {
+        clock_gettime(CLOCK_MONOTONIC, &sleep_period);
+
+        sleep_period.tv_nsec += cycle * 1000;
+        if (sleep_period.tv_nsec >= 1000000000) {
+            sleep_period.tv_nsec = 0;
+            sleep_period.tv_sec++;
+        }
+
+        ret = write(sock, msg, sizeof(msg));
+        if (ret <= 0) {
+            if (ret == 0)
+                printf("connection closed by peer\n");
+            else
+                perror("write to socket");
+            return NULL;
+        }
+        printf("%d: wrote %d bytes to socket\n", i, ret);
+
+        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &sleep_period, NULL);
+    }
+
+    return NULL;
+}
+
+int main(int argc, char** argv)
+{
+    struct conn_t connection = { .nloops = DEFAULT_LOOPS };
+    struct sched_param param;
+    pthread_attr_t attr;
+    int local_port = RCV_PORT;
+    int ret;
+
+    while (1) {
+        switch (getopt(argc, argv, "d:l:p:n:")) {
+            case 'd':
+                dest_ip_s = optarg;
+                break;
+
+            case 'l':
+                local_ip_s = optarg;
+                break;
+
+            case 'p':
+                local_port = atoi(optarg);
+                break;
+
+            case 'n':
+                connection.nloops = atoi(optarg);
+                break;
+
+            case -1:
+                goto end_of_opt;
+
+            default:
+                printf("usage: %s [-d <dest_ip>] [-l <local_ip>] "
+                       "[-p <local port>] [-n <number of loops>]\n", argv[0]);
+                return 0;
+        }
+    }
+ end_of_opt:
+
+    connection.dest_addr.sin_family = AF_INET;
+    connection.dest_addr.sin_port   = htons(XMT_PORT);
+    if (dest_ip_s[0])
+        inet_aton(dest_ip_s, &connection.dest_addr.sin_addr);
+    else
+        connection.dest_addr.sin_addr.s_addr = INADDR_ANY;
+
+    connection.local_addr.sin_family = AF_INET;
+    connection.local_addr.sin_port = htons(local_port);
+    if (local_ip_s[0])
+        inet_aton(local_ip_s, &connection.local_addr.sin_addr);
+    else
+        connection.local_addr.sin_addr.s_addr = INADDR_ANY;
+
+    printf("destination ip address: %s = %08x\n",
+           dest_ip_s[0] ? dest_ip_s : "SENDER",
+           connection.dest_addr.sin_addr.s_addr);
+    printf("local ip address: %s = %08x\n",
+           local_ip_s[0] ? local_ip_s : "INADDR_ANY",
+           connection.local_addr.sin_addr.s_addr);
+    printf("port: %d\n", local_port);
+
+    /* create rt-socket */
+    if ((connection.sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
+        perror("socket create");
+        return 1;
+    }
+
+    /* extend the socket pool (optional, will fail with non-RT sockets) */
+    ret = ioctl(connection.sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
+    if (ret < 0)
+        perror("ioctl(RTNET_RTIOC_EXTPOOL)");
+
+    pthread_attr_init(&attr);
+    pthread_attr_setinheritsched(&attr, 1);
+    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
+    pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
+    param.sched_priority = 80;
+    pthread_attr_setschedparam(&attr, &param);
+
+    ret = pthread_create(&sender_task, &attr, &sender, &connection);
+    if (ret) {
+        perror("start real-time task");
+        return 1;
+    }
+
+    pthread_join(sender_task, NULL);
+    close(connection.sock);
+
+    return 0;
+}
diff --git a/demo/net/rttcp-server.c b/demo/net/rttcp-server.c
new file mode 100644
index 000000000..d6422e60e
--- /dev/null
+++ b/demo/net/rttcp-server.c
@@ -0,0 +1,181 @@
+/***
+ *
+ *  examples/xenomai/posix/rttcp-server.c
+ *
+ *  Simple RTNet TCP server - listens and sends back a packet
+ *
+ *  Copyright (C) 2009 Vladimir Zapolskiy <vladimir.zapolskiy@siemens.com>
+ *
+ *  RTnet - real-time networking example
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License, version 2, as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <arpa/inet.h>
+#include <limits.h>
+
+#include <rtdm/net.h>
+
+char *local_ip_s  = "";
+
+#define RCV_PORT            36000
+#define MAX_STRLENGTH       128
+#define DEFAULT_ADD_BUFFERS 30
+
+int add_rtskbs = DEFAULT_ADD_BUFFERS;
+
+pthread_t receiver_task = 0;
+
+struct conn_t {
+    int sock;
+    struct sockaddr_in client_addr;
+    struct sockaddr_in local_addr;
+};
+
+static void* receiver(void* arg)
+{
+    struct conn_t *connection = (struct conn_t*)arg;
+    socklen_t len = sizeof(struct sockaddr_in);
+    int sock = connection->sock;
+    struct timeval tv;
+    fd_set readset;
+    int cnt = 0;
+    char chr;
+    int ret;
+
+    /* bind the rt-socket to local_addr */
+    connection->local_addr.sin_family = AF_INET;
+    connection->local_addr.sin_port   = htons(RCV_PORT);
+    if (bind(sock, (struct sockaddr *)&connection->local_addr,
+             sizeof(struct sockaddr_in)) < 0) {
+        perror("bind socket");
+        return NULL;
+    }
+
+    /* Backlog is ignored, current realization just transmit state to LISTEN */
+    if (listen(sock, 1) < 0) {
+        perror("listen on socket");
+        return NULL;
+    }
+
+    /* Warning, no new socket descriptor, only one connection */
+    sock = accept(sock, (struct sockaddr *)&connection->client_addr, &len);
+    if (sock < 0) {
+        perror("accept connection");
+        return NULL;
+    }
+    printf("connection from %s:%d\n",
+           inet_ntoa(connection->client_addr.sin_addr),
+           ntohs(connection->client_addr.sin_port));
+
+    while (1) {
+        FD_ZERO(&readset);
+        FD_SET(sock, &readset);
+        tv.tv_sec = 5;
+        tv.tv_usec = 0;
+
+        ret = select(sock + 1, &readset, NULL, NULL, &tv);
+        if (ret <= 0) {
+            if (ret == 0)
+                fprintf(stderr, "timeout during select()\n");
+            else
+                perror("error on select()");
+            return NULL;
+        }
+
+        if (FD_ISSET(sock, &readset)) {
+            ret = read(sock, &chr, 1);
+            if (ret <= 0) {
+                if (ret == 0)
+                    printf("connection closed\n");
+                else
+                    perror("error on read()");
+                return NULL;
+            }
+
+            printf("%d: received %d bytes, message: %c\n", cnt++, ret, chr);
+        }
+    }
+    return NULL;
+}
+
+int main(int argc, char** argv)
+{
+    struct conn_t connection;
+    struct sched_param param;
+    pthread_attr_t attr;
+    int ret;
+
+    while (1) {
+        switch (getopt(argc, argv, "l:")) {
+            case 'l':
+                local_ip_s = optarg;
+                break;
+
+            case -1:
+                goto end_of_opt;
+
+            default:
+                printf("usage: %s [-l <local_ip>]\n", argv[0]);
+                return 0;
+        }
+    }
+ end_of_opt:
+
+    if (local_ip_s[0])
+        inet_aton(local_ip_s, &connection.local_addr.sin_addr);
+    else
+        connection.local_addr.sin_addr.s_addr = INADDR_ANY;
+
+    printf("local ip address: %s = %08x\n",
+           local_ip_s[0] ? local_ip_s : "INADDR_ANY",
+           connection.local_addr.sin_addr.s_addr);
+
+    /* create rt-socket */
+    if ((connection.sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
+        perror("socket create");
+        return 1;
+    }
+
+    /* extend the socket pool (optional, will fail with non-RT sockets) */
+    ret = ioctl(connection.sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
+    if (ret < 0)
+        perror("ioctl(RTNET_RTIOC_EXTPOOL)");
+
+    pthread_attr_init(&attr);
+    pthread_attr_setinheritsched(&attr, 1);
+    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
+    pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
+    param.sched_priority = 20;
+    pthread_attr_setschedparam(&attr, &param);
+
+    ret = pthread_create(&receiver_task, NULL, &receiver, &connection);
+    if (ret) {
+        perror("start real-time task");
+        return 1;
+    }
+
+    pthread_join(receiver_task, NULL);
+    close(connection.sock);
+
+    return 0;
+}
diff --git a/demo/net/udp-send.c b/demo/net/udp-send.c
new file mode 100644
index 000000000..a29f98024
--- /dev/null
+++ b/demo/net/udp-send.c
@@ -0,0 +1,136 @@
+/*
+ * sender.c -- multicasts "hello, world!" to a multicast group once a second
+ *
+ * Antony Courtney,	25/11/94
+ */
+
+#include <time.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <error.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <pthread.h>
+#include <sys/timerfd.h>
+#include <boilerplate/trace.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+
+#define HELLO_PORT 12345
+#define HELLO_GROUP "225.0.0.37"
+#define ONE_BILLION	1000000000
+
+#define check_pthread(expr)			\
+	({ \
+		int __e = (expr);		\
+		if (__e) {			\
+			printf("%s: %d\n", #expr, __e);	\
+			exit(EXIT_FAILURE);		\
+		}					\
+	})
+
+int main(int argc, char *argv[])
+{
+     struct sockaddr_in addr;
+     int fd, tfd, err;
+     char message[] = "Hello, World!\n";
+     struct timespec last_print, start, now;
+     struct sched_param sparm;
+     unsigned long long diff, min = ~0ULL, max = 0, sum, count;
+     struct itimerspec timer_conf;
+
+     /* create what looks like an ordinary UDP socket */
+     if ((fd=socket(AF_INET,SOCK_DGRAM,0)) < 0) {
+	  perror("socket");
+	  exit(1);
+     }
+
+     if (argc != 2) {
+	 fprintf(stderr, "Local ip address expected as first and only argument\n");
+	 exit(1);
+     }
+
+     memset(&addr,0,sizeof(addr));
+     addr.sin_family=AF_INET;
+     addr.sin_addr.s_addr=inet_addr(argv[1]); /* N.B.: differs from sender */
+     addr.sin_port=htons(HELLO_PORT);
+
+     /* bind to receive address */
+     if (bind(fd,(struct sockaddr *) &addr,sizeof(addr)) < 0) {
+	  perror("bind");
+	  exit(1);
+     }
+
+     /* set up destination address */
+     memset(&addr,0,sizeof(addr));
+     addr.sin_family=AF_INET;
+     addr.sin_addr.s_addr=inet_addr(HELLO_GROUP);
+     addr.sin_port=htons(HELLO_PORT);
+
+     sparm.sched_priority = 99;
+
+     check_pthread(pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparm));
+
+     tfd = timerfd_create(CLOCK_MONOTONIC, 0);
+     if (tfd == -1)
+	     error(1, errno, "timerfd_create()");
+
+     check_pthread(pthread_setmode_np(0, PTHREAD_WARNSW, NULL));
+
+     /* now just sendto() our destination! */
+     sum = 0;
+     count = 0;
+     err = clock_gettime(CLOCK_MONOTONIC, &start);
+     start.tv_nsec += 1000000;
+     if (start.tv_nsec > ONE_BILLION) {
+	     start.tv_nsec -= ONE_BILLION;
+	     start.tv_sec++;
+     }
+     timer_conf.it_value = start;
+     timer_conf.it_interval.tv_sec = 0;
+     timer_conf.it_interval.tv_nsec = 5000000;
+     err = timerfd_settime(tfd, TFD_TIMER_ABSTIME, &timer_conf, NULL);
+     if (err)
+	     error(1, errno, "timerfd_settime()");
+     clock_gettime(CLOCK_MONOTONIC, &last_print);
+
+     while (1) {
+	     uint64_t ticks;
+	     clock_gettime(CLOCK_MONOTONIC, &start);
+	     if (sendto(fd,message,sizeof(message),0,(struct sockaddr *) &addr,
+			     sizeof(addr)) < 0) {
+		     perror("sendto");
+		     exit(1);
+	     }
+	     clock_gettime(CLOCK_MONOTONIC, &now);
+
+	     diff = now.tv_sec * 1000000ULL + now.tv_nsec / 1000 -
+		     (start.tv_sec * 1000000ULL + start.tv_nsec / 1000);
+	     if (diff < min)
+		     min = diff;
+	     if (diff > max) {
+		     xntrace_user_freeze(diff, 0);
+		     max = diff;
+	     }
+	     sum += diff;
+	     count++;
+
+	     diff = now.tv_sec * 1000000ULL + now.tv_nsec / 1000 -
+		     (last_print.tv_sec * 1000000ULL + last_print.tv_sec / 1000);
+	     if (diff >= 1000000) {
+		     fprintf(stderr, "%Lu, %Lu, %Lu\n",
+			     min, sum / count, max);
+		     last_print = now;
+	     }
+
+	     err = read(tfd, &ticks, sizeof(ticks));
+	     if (err < 0)
+		     error(1, errno, "read()");
+     }
+}
-- 
2.17.1


