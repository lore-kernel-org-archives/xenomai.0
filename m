From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH v2] utils/can: fix error handling, use errno instead of -ret
Message-ID: <53a3cf58-5ad6-f64c-87ef-4d99defeec07@grandegger.com>
Date: Wed, 9 Oct 2019 10:52:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

rtcansend and rtcanrecv test and evaluate the return code of POSIX
functions instead of errno. This bug sneaked in with:

d245d6e utils/can: drop dependencies on obsolete rt_dev API

As we are at it, a few missing "\n" of some error messages have been
added as well.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---

Changes since v1:
- rt_task_shadow() still needs to handle "-ret"
- improved commit message

 utils/can/rtcanrecv.c | 28 ++++++++++++++--------------
 utils/can/rtcansend.c | 26 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/utils/can/rtcanrecv.c b/utils/can/rtcanrecv.c
index 8155ab7..b37b80b 100644
--- a/utils/can/rtcanrecv.c
+++ b/utils/can/rtcanrecv.c
@@ -63,7 +63,7 @@ static void cleanup(void)
 	ret = close(s);
 	s = -1;
 	if (ret) {
-	    fprintf(stderr, "close: %s\n", strerror(-ret));
+	    fprintf(stderr, "close: %s\n", strerror(errno));
 	}
 	exit(EXIT_SUCCESS);
     }
@@ -105,17 +105,17 @@ static void rt_task(void)
 	    ret = recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
 				  (struct sockaddr *)&addr, &addrlen);
 	if (ret < 0) {
-	    switch (ret) {
-	    case -ETIMEDOUT:
+	    switch (errno) {
+	    case ETIMEDOUT:
 		if (verbose)
-		    printf("recv: timed out");
+		    printf("recv: timed out\n");
 		continue;
-	    case -EBADF:
+	    case EBADF:
 		if (verbose)
-		    printf("recv: aborted because socket was closed");
+		    printf("recv: aborted because socket was closed\n");
 		break;
 	    default:
-		fprintf(stderr, "recv: %s\n", strerror(-ret));
+		fprintf(stderr, "recv: %s\n", strerror(errno));
 	    }
 	    break;
 	}
@@ -234,7 +234,7 @@ int main(int argc, char **argv)
 
     ret = socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (ret < 0) {
-	fprintf(stderr, "socket: %s\n", strerror(-ret));
+	fprintf(stderr, "socket: %s\n", strerror(errno));
 	return -1;
     }
     s = ret;
@@ -254,7 +254,7 @@ int main(int argc, char **argv)
 
 	ret = ioctl(s, SIOCGIFINDEX, &ifr);
 	if (ret < 0) {
-	    fprintf(stderr, "ioctl GET_IFINDEX: %s\n", strerror(-ret));
+	    fprintf(stderr, "ioctl GET_IFINDEX: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
@@ -263,7 +263,7 @@ int main(int argc, char **argv)
 	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
 				&err_mask, sizeof(err_mask));
 	if (ret < 0) {
-	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
+	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
 	    goto failure;
 	}
 	if (verbose)
@@ -275,7 +275,7 @@ int main(int argc, char **argv)
 				&recv_filter, filter_count *
 				sizeof(struct can_filter));
 	if (ret < 0) {
-	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
+	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
@@ -285,7 +285,7 @@ int main(int argc, char **argv)
     ret = bind(s, (struct sockaddr *)&recv_addr,
 		      sizeof(struct sockaddr_can));
     if (ret < 0) {
-	fprintf(stderr, "bind: %s\n", strerror(-ret));
+	fprintf(stderr, "bind: %s\n", strerror(errno));
 	goto failure;
     }
 
@@ -294,7 +294,7 @@ int main(int argc, char **argv)
 	    printf("Timeout: %lld ns\n", (long long)timeout);
 	ret = ioctl(s, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
 	if (ret) {
-	    fprintf(stderr, "ioctl RCV_TIMEOUT: %s\n", strerror(-ret));
+	    fprintf(stderr, "ioctl RCV_TIMEOUT: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
@@ -302,7 +302,7 @@ int main(int argc, char **argv)
     if (with_timestamp) {
 	ret = ioctl(s, RTCAN_RTIOC_TAKE_TIMESTAMP, RTCAN_TAKE_TIMESTAMPS);
 	if (ret) {
-	    fprintf(stderr, "ioctl TAKE_TIMESTAMP: %s\n", strerror(-ret));
+	    fprintf(stderr, "ioctl TAKE_TIMESTAMP: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
diff --git a/utils/can/rtcansend.c b/utils/can/rtcansend.c
index 4a692b3..26b7e90 100644
--- a/utils/can/rtcansend.c
+++ b/utils/can/rtcansend.c
@@ -58,7 +58,7 @@ static void cleanup(void)
 	ret = close(s);
 	s = -1;
 	if (ret) {
-	    fprintf(stderr, "close: %s\n", strerror(-ret));
+	    fprintf(stderr, "close: %s\n", strerror(errno));
 	}
 	exit(EXIT_SUCCESS);
     }
@@ -87,17 +87,17 @@ static void rt_task(void)
 	    ret = sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
 				(struct sockaddr *)&to_addr, sizeof(to_addr));
 	if (ret < 0) {
-	    switch (ret) {
-	    case -ETIMEDOUT:
+	    switch (errno) {
+	    case ETIMEDOUT:
 		if (verbose)
-		    printf("send(to): timed out");
+		    printf("send(to): timed out\n");
 		break;
-	    case -EBADF:
+	    case EBADF:
 		if (verbose)
-		    printf("send(to): aborted because socket was closed");
+		    printf("send(to): aborted because socket was closed\n");
 		break;
 	    default:
-		fprintf(stderr, "send: %s\n", strerror(-ret));
+		fprintf(stderr, "send: %s\n", strerror(errno));
 		break;
 	    }
 	    i = loops;		/* abort */
@@ -215,7 +215,7 @@ int main(int argc, char **argv)
 
     ret = socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (ret < 0) {
-	fprintf(stderr, "socket: %s\n", strerror(-ret));
+	fprintf(stderr, "socket: %s\n", strerror(errno));
 	return -1;
     }
     s = ret;
@@ -224,7 +224,7 @@ int main(int argc, char **argv)
 	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
 				&loopback, sizeof(loopback));
 	if (ret < 0) {
-	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
+	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
 	    goto failure;
 	}
 	if (verbose)
@@ -237,7 +237,7 @@ int main(int argc, char **argv)
 
     ret = ioctl(s, SIOCGIFINDEX, &ifr);
     if (ret < 0) {
-	fprintf(stderr, "ioctl: %s\n", strerror(-ret));
+	fprintf(stderr, "ioctl: %s\n", strerror(errno));
 	goto failure;
     }
 
@@ -248,13 +248,13 @@ int main(int argc, char **argv)
 	/* Suppress definiton of a default receive filter list */
 	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
 	if (ret < 0) {
-	    fprintf(stderr, "setsockopt: %s\n", strerror(-ret));
+	    fprintf(stderr, "setsockopt: %s\n", strerror(errno));
 	    goto failure;
 	}
 
 	ret = bind(s, (struct sockaddr *)&to_addr, sizeof(to_addr));
 	if (ret < 0) {
-	    fprintf(stderr, "bind: %s\n", strerror(-ret));
+	    fprintf(stderr, "bind: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
@@ -282,7 +282,7 @@ int main(int argc, char **argv)
 	    printf("Timeout: %lld ns\n", (long long)timeout);
 	ret = ioctl(s, RTCAN_RTIOC_SND_TIMEOUT, &timeout);
 	if (ret) {
-	    fprintf(stderr, "ioctl SND_TIMEOUT: %s\n", strerror(-ret));
+	    fprintf(stderr, "ioctl SND_TIMEOUT: %s\n", strerror(errno));
 	    goto failure;
 	}
     }
-- 
1.9.1


