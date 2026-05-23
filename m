Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2C305E28
	for <xenomai@lists.linux.dev>; Sat, 23 May 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779567059; cv=none; b=nDjbvc5xEGVLIBisj1Da4rVuuVB1DAaxNZCOlAjKCDL+UZtoW4wd9P9U+4kT7gZ011JVUXT+jIc6DriLELfni7zVfJd8/+a4RVO8EIvFZwlJ3gUdwq1bGCYj4y7RPPCymSVZXbXBXMxUK9uxdZpU2x51D0BOsMVtLwSnJXw/L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779567059; c=relaxed/simple;
	bh=HxmNAZYYQ6PptiRYaKbidqbw/oBCzCljoLoYOfyAXKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvAGrI48JLAcH+qZqAOxcj1hOCN5CJchnOsg4cT4Cw2gAPr4UCUEZQ31w+jBjtj0NnsPAuORVL7Alkd0PmWJFsi64DXlKhO9fiyY0f0eke006TYXG80GEL0GCDBri13IS2gBvnbuG9IrdW4nMKEJfgmWN5evdFDG3mJDsWbyFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN6SIID6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN6SIID6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44a044cb827so6292414f8f.0
        for <xenomai@lists.linux.dev>; Sat, 23 May 2026 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779567056; x=1780171856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=waT+wKSelv9hZu9palBKv2liy9EUbSe21X+rqNE2rR4=;
        b=FN6SIID6HVu4pSAjQ+BXkMXUYC5r2ggAnJmT5CXpsPtbYMPnTYvLHLBo17pysCCvlX
         F/w4mcOKiIn8ct8LhI2yStnXQUi5BH+hyahFiT8BybfC2HPxVmSCtSCJbcU/IpILt77z
         0ifC6VFjlIfl2HWAvEYrdXEPlhecafTd7r69DKnh4ei2eCUskKFMJySaxQsS3HYreiNP
         WAKbQGXoTcW2b0BJEHnvpRUek3InNPSJxlunHE7wnIpJeUS69F6V/eJlVUyqK0lNw4tH
         bjk5b7DP/yza+WCrHBVxD2lhq1a3GUJd2ZQrQxddXnY2O43dNf6IDwx75hLPmL8pQOZH
         0NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779567056; x=1780171856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waT+wKSelv9hZu9palBKv2liy9EUbSe21X+rqNE2rR4=;
        b=oUsIUG78YePms5QwYThQWqwEZU6xruN/gxtgumHQ2ztuXIYTllCG2I2YAvsx6Q7tR0
         apxc1K2gGDVFQ0ZJmAhqrF/VIniVy5rVl3t7l3lK47+Bmf3SsvhLZRfrnfJT+F/OhXXt
         JMjrtU57zrvC+cJXBoD4hv+PQ3hLAbAfyhYgCpQgDJ7Kr/fHmAdeLU6UbK128Ul5GSvC
         tJ3JarpFJlerAMK753Z2g3TIABfpDUCGeAtMqilicMDQ3ogkNzq/QiypIZ2qXwzZn6LA
         S7FOvf6hZ4sMI0n6PwJWWjHrIoDw6Lsvq2k710G2BWyJfWR6JQO9VEGeTixm8qtkPI8f
         VgmQ==
X-Gm-Message-State: AOJu0Ywh2wGPMi/HxXh5X13i7GEz592Kinq7Sl1S62A37qNIVf9JF0kj
	ML24v1IpBze9mcTl0qMR0Qc2dNLvK67OnsJDYAqPFBBuAJMaxgZiMFtBnTgqoA==
X-Gm-Gg: Acq92OEzcUFh1W7rbNospyISEA9vcmG/uUqcC/vlqhGxjQj0bcUhq+QGDFBN3qmmmD8
	JuTNb2B1YGl7znhThBzI1/hx61KyL/Aoc4SPRXl78wiUlyjMOO1bQltSTfEidDfQx/y9miKIK5C
	j2SLw9l9U3HwJphCXgHr99TOdl3hI/TL8krT+qGvOv/8q2Xxx3R2rjesU7e+ZLAf9/gY1LRNvAy
	NIAUtA9dT75DwKyYRH8+1tkFXtsMXtao4v4X6swNLzEY3naGSDqhR0tRX6/vv250ch7bZapWtXf
	zeCgG5JjUejJ3wPim1QKiwVT1gJMd0r9bgX2lo8XrVNFole91yT/TdOQkXVJt86Jq9wqRGFhcjJ
	s3BiK1jwlqdm60/pmCA2vzM8p6fEvSN95KFugmWMtElrSkKDa1xHCGjrQ5IQFSHoMiRaINuob7h
	EJKXq/67qOpXeVlU8HtKcoJj21ig==
X-Received: by 2002:a05:600c:5254:b0:490:484b:bf41 with SMTP id 5b1f17b1804b1-490484bbf7amr112667885e9.6.1779567056230;
        Sat, 23 May 2026 13:10:56 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490454a0b82sm144862205e9.9.2026.05.23.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 13:10:55 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] tidbits: net-udp: add server and client mode
Date: Sat, 23 May 2026 22:10:16 +0200
Message-ID: <20260523201044.12938-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additionally, fix memory leaks

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 240 insertions(+), 18 deletions(-)

diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
index 5673644..3cd7cb2 100644
--- a/tidbits/oob-net-udp.c
+++ b/tidbits/oob-net-udp.c
@@ -2,9 +2,23 @@
  * SPDX-License-Identifier: MIT
  *
  * This tidbit demonstrates out-of-band networking, by
- * sending[-S]/receiving[-R] UDP packets to/from a particular IP
+ * transmitting[-T]/receiving[-R] UDP packets to/from a particular IP
  * address[-a] and port[-p].
  *
+ * The server mode [-S] receives a packet from on a given
+ * port and sends a response to the sender's ip/port.
+ *
+ * The client mode [-S] sends a packet to a port/ip
+ * and receives the response from a server. The round
+ * trip time is measured.
+ *
+ * The client and the transmitter wait [-w] before sending the
+ * next packet to not flood the network.
+ *
+ * For the other side, the same code can be used.
+ * For transmitting / client on a non-oob port: socat - UDP-LISTEN:<port>
+ * For receiving / server on a non-oob port: socat - UDP:<Remote-IP-address>:<port>
+ *
  * See https://v4.xenomai.org/core/net/ for details.
  */
 
@@ -13,6 +27,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <memory.h>
 #include <getopt.h>
@@ -30,12 +45,21 @@ static int verbosity = 1;
 static void usage(void)
 {
 	fprintf(stderr, "oob-net-udp -a <IP-address> [-p <port>]"
-		"[-m <text>][-n <msgcount>][-I <iterations>][-i <interface>]"
-		"[-d][-s][-R|-S][-b]\n");
+		"[-m <text>][-n <msgcount>][-I <iterations>][-i <interface>][-w <wait_time_us>]"
+		"[-d][-s][-T|-R|-C|-S][-b]\n");
+}
+
+static void print_addr(char* text, struct sockaddr_in *addr){
+    char ip_str[INET_ADDRSTRLEN+1];
+    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
+    evl_printf("%s--------\n", text);
+    evl_printf("IP-Address: %s\n", ip_str);
+    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
+    evl_printf("Family:     %d\n", addr->sin_family);
 }
 
 static void sender(int s, const char *text, int mcount,
-		struct sockaddr_in *addr, int iter)
+		struct sockaddr_in *addr, int iter, useconds_t delay)
 {
 	struct oob_msghdr msghdr;
 	struct iovec iov;
@@ -66,8 +90,10 @@ static void sender(int s, const char *text, int mcount,
 		if (ret < 0)
 			error(1, errno, "oob_sendmsg() failed");
 
-		evl_usleep(1000000);
+		evl_usleep(delay);
 	}
+
+	free(tbuf);
 }
 
 static void receiver(int s, struct sockaddr_in *addr, int iter)
@@ -76,7 +102,7 @@ static void receiver(int s, struct sockaddr_in *addr, int iter)
 	socklen_t len = sizeof(_addr);
 	struct oob_msghdr msghdr;
 	struct iovec iov;
-	char tbuf[16384];
+	char rbuf[16384];
 	ssize_t ret;
 	int n;
 
@@ -89,12 +115,90 @@ static void receiver(int s, struct sockaddr_in *addr, int iter)
 		error(1, errno, "getsockname() failed");
 
 	if (verbosity)
-		printf("== bound to port %d\n", ntohs(_addr.sin_port));
+		print_addr("bind", addr);
+
+	for (n = 0; !iter || n < iter; n++) {
+		memset(rbuf, 0, sizeof(rbuf));
+		iov.iov_base = rbuf;
+		iov.iov_len = sizeof(rbuf);
+		msghdr.msg_iov = &iov;
+		msghdr.msg_iovlen = 1;
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+		msghdr.msg_name = &_addr;
+		msghdr.msg_namelen = sizeof(_addr);
+		msghdr.msg_flags = 0;
+		ret = oob_recvmsg(s, &msghdr, NULL, 0);
+		if (ret < 0)
+			error(1, errno, "oob_recvmsg() failed");
+		evl_printf("= %zd bytes received", ret);
+		if (msghdr.msg_flags & MSG_TRUNC)
+			evl_printf(" (TRUNCATED)");
+		evl_printf(": %.*s\n", (int)ret, rbuf);
+	}
+}
+
+static void client(int s, const char *text, int mcount,
+		struct sockaddr_in *addr, int iter, useconds_t delay)
+{
+	struct sockaddr_in _addr;
+	socklen_t len = sizeof(_addr);
+	struct oob_msghdr msghdr;
+	struct iovec iov;
+	int n, tlen;
+	ssize_t ret;
+	char *tbuf;
+	char rbuf[16384];
+	struct timespec ts_tx;
+	struct timespec ts_rx;
+	double rtt_us = 0.0;
+
+	tlen = (strlen(text) + 1) * mcount;
+	tbuf = malloc(tlen);
+	if (!tbuf)
+		error(1, ENOMEM, "cannot create message");
+
+	*tbuf = '\0';
+	for (n = 0; n < mcount; n++)
+		strcat(tbuf, text); /* yep, lazy.. */
+
+	ret = connect(s, (struct sockaddr *)addr, sizeof(*addr));
+	if (ret < 0)
+		error(1, errno, "connect() failed");
+
+	if (verbosity)
+		print_addr("send address", addr);
+
+	ret = getsockname(s, (struct sockaddr *)&_addr, &len);
+	if (ret < 0)
+		error(1, errno, "getsockname() failed");
+
+	if (verbosity)
+		print_addr("receive address", &_addr);
 
 	for (n = 0; !iter || n < iter; n++) {
-		memset(tbuf, 0, sizeof(tbuf));
+		evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_tx);
+
 		iov.iov_base = tbuf;
-		iov.iov_len = sizeof(tbuf);
+		iov.iov_len = tlen;
+		msghdr.msg_iov = &iov;
+		msghdr.msg_iovlen = 1;
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+		msghdr.msg_name = addr;
+		msghdr.msg_namelen = sizeof(*addr);
+		msghdr.msg_flags = 0;
+		ret = oob_sendmsg(s, &msghdr, NULL, 0);
+		if (ret < 0)
+			error(1, errno, "oob_sendmsg() failed");
+		if (verbosity > 1)
+			print_addr("sent to", addr);
+
+		memset(rbuf, 0, sizeof(rbuf));
+		/* recvmsg stores remote address */
+		memset(&_addr, 0, sizeof(_addr));
+		iov.iov_base = rbuf;
+		iov.iov_len = sizeof(rbuf);
 		msghdr.msg_iov = &iov;
 		msghdr.msg_iovlen = 1;
 		msghdr.msg_control = NULL;
@@ -103,26 +207,114 @@ static void receiver(int s, struct sockaddr_in *addr, int iter)
 		msghdr.msg_namelen = sizeof(_addr);
 		msghdr.msg_flags = 0;
 		ret = oob_recvmsg(s, &msghdr, NULL, 0);
+
+		evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_rx);
+		rtt_us = (ts_rx.tv_sec - ts_tx.tv_sec) * 1000000.0 + (ts_rx.tv_nsec - ts_tx.tv_nsec) / 1000.0;
+
 		if (ret < 0)
 			error(1, errno, "oob_recvmsg() failed");
+		if (verbosity > 1)
+			print_addr("received from", &_addr);
+		evl_printf("= %zd bytes received rtt=%.1fus", ret, rtt_us);
+		if (msghdr.msg_flags & MSG_TRUNC)
+			evl_printf(" (TRUNCATED)");
+		evl_printf(": %.*s\n", (int)ret, rbuf);
+
+		evl_usleep(delay);
+	}
+
+	free(tbuf);
+}
+
+static void server(int s, const char *text, int mcount,
+		struct sockaddr_in *addr, int iter)
+{
+	struct sockaddr_in _addr;
+	struct oob_msghdr msghdr;
+	struct iovec iov;
+	int n, tlen;
+	ssize_t ret;
+	char *tbuf;
+	char rbuf[16384];
+
+	tlen = (strlen(text) + 1) * mcount;
+	tbuf = malloc(tlen);
+	if (!tbuf)
+		error(1, ENOMEM, "cannot create message");
+
+	*tbuf = '\0';
+	for (n = 0; n < mcount; n++)
+		strcat(tbuf, text); /* yep, lazy.. */
+
+	ret = bind(s, (struct sockaddr *)addr, sizeof(*addr));
+	if (ret < 0)
+		error(1, errno, "bind() failed");
+
+	if (verbosity)
+		print_addr("bind", addr);
+
+	for (n = 0; !iter || n < iter; n++) {
+		memset(rbuf, 0, sizeof(rbuf));
+		/* recvmsg stores remote address, we respond to this address */
+		memset(&_addr, 0, sizeof(_addr));
+		iov.iov_base = rbuf;
+		iov.iov_len = sizeof(rbuf);
+		msghdr.msg_iov = &iov;
+		msghdr.msg_iovlen = 1;
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+		msghdr.msg_name = &_addr;
+		msghdr.msg_namelen = sizeof(_addr);
+		msghdr.msg_flags = 0;
+		ret = oob_recvmsg(s, &msghdr, NULL, 0);
+		if (ret < 0)
+			error(1, errno, "oob_recvmsg() failed");
+		if (verbosity > 1)
+			print_addr("received from", &_addr);
 		evl_printf("= %zd bytes received", ret);
 		if (msghdr.msg_flags & MSG_TRUNC)
 			evl_printf(" (TRUNCATED)");
-		evl_printf(": %.*s\n", (int)ret, tbuf);
+		evl_printf(": %.*s\n", (int)ret, rbuf);
+
+		iov.iov_base = tbuf;
+		iov.iov_len = tlen;
+		msghdr.msg_iov = &iov;
+		msghdr.msg_iovlen = 1;
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+		msghdr.msg_name = &_addr;
+		msghdr.msg_namelen = sizeof(_addr);
+		msghdr.msg_flags = 0;
+		ret = oob_sendmsg(s, &msghdr, NULL, 0);
+		if (ret < 0)
+			error(1, errno, "oob_sendmsg() failed");
+		if (verbosity > 1)
+			print_addr("sent to", &_addr);
 	}
+
+	free(tbuf);
 }
 
+typedef enum {
+	TRANSMIT,
+	RECEIVE,
+	SERVER,
+	CLIENT
+} udp_mode_t;
+
 int main(int argc, char *argv[])
 {
 	int tfd, s, c, mcount = 1, iter = 0, port = 42042, on = 1;
-	const char *text = "Mellow sword!", *iface = NULL;
-	bool send = false, bcast = false;
+	const char *text = "Mellow sword!\n", *iface = NULL;
+	bool bcast = false;
+	udp_mode_t mode = RECEIVE;
 	struct sched_param param;
 	struct sockaddr_in addr;
 	const char *ip = NULL;
 	ssize_t ret;
+	useconds_t delay=1000000;
 
-	while ((c = getopt(argc, argv, "a:m:n:i:I:p:dsRSb")) != EOF) {
+	while ((c = getopt(argc, argv, "a:m:n:i:w:I:p:dsTRCSb")) != EOF) {
 		switch (c) {
 		case 'a':
 			ip = optarg;
@@ -142,6 +334,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			iface = optarg;
 			break;
+		case 'w':
+			delay = atoi(optarg);
+			break;
 		case 'I':
 			iter = atoi(optarg);
 			break;
@@ -151,11 +346,17 @@ int main(int argc, char *argv[])
 		case 'b':
 			bcast = true; /* Force mode, e.g. for directed broadcast */
 			break;
+		case 'T':
+			mode = TRANSMIT;
+			break;
 		case 'R':
-			send = false;
+			mode = RECEIVE;
+			break;
+		case 'C':
+			mode = CLIENT;
 			break;
 		case 'S':
-			send = true;
+			mode = SERVER;
 			break;
 		default:
 			usage();
@@ -203,7 +404,7 @@ int main(int argc, char *argv[])
 			printf("== bound to %s\n", iface);
 	}
 
-	if (send) {
+	if (mode == TRANSMIT) {
 		if (bcast) {
 			ret = setsockopt(s, SOL_SOCKET, SO_BROADCAST, &on, sizeof(on));
 			if (ret)
@@ -224,12 +425,33 @@ int main(int argc, char *argv[])
 		if (verbosity)
 			printf("== sender mode (=> %s:%d)\n", bcast ? "[broadcast]" : ip, port);
 
-		sender(s, text, mcount, &addr, iter);
-	} else {
+		sender(s, text, mcount, &addr, iter, delay);
+	} else if (mode == RECEIVE) {
 		if (verbosity)
 			printf("== receiver mode (<= %s:%d)\n", ip, port);
 
 		receiver(s, &addr, iter);
+	} else if (mode == CLIENT) {
+		if (verbosity)
+			printf("== client mode (<= %s:%d)\n", ip, port);
+
+		/*
+		 * Guarantee a mere oob path from the first packet
+		 * onward by pre-caching the route and link-layer
+		 * address via an explicit neighbour solicitation
+		 * before we start sending data.
+		 */
+		ret = evl_net_solicit(s, (const struct sockaddr *)&addr,
+				EVL_NEIGH_PERMANENT);
+
+		client(s, text, mcount, &addr, iter, delay);
+	} else if (mode == SERVER) {
+		if (verbosity)
+			printf("== server mode (<= %s:%d)\n", ip, port);
+
+		server(s, text, mcount, &addr, iter);
+	} else {
+		error(1, 0, "Mode not implemented");
 	}
 
 	return 0;
-- 
2.47.3

