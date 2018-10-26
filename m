From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/9] demos/posix: prevent unterminated destination buffer with
 strncpy()
Date: Fri, 26 Oct 2018 16:08:18 +0200
Message-Id: <20181026140825.5251-2-rpm@xenomai.org>
In-Reply-To: <20181026140825.5251-1-rpm@xenomai.org>
References: <20181026140825.5251-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

GCC 8.x introduced -Wstringop-truncation to help detecting likely
unwanted outcomes of strncpy(dst, src, n), such as omitting the NUL
character into the destination buffer whenever n < sizeof(src).

Fix unsafe strncpy() calls when we do expect a null-terminated
destination buffer.
---
 demo/posix/cobalt/can-rtt.c        | 4 ++--
 demo/posix/cobalt/eth_p_all.c      | 3 ++-
 demo/posix/cyclictest/cyclictest.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/demo/posix/cobalt/can-rtt.c b/demo/posix/cobalt/can-rtt.c
index 61cad05e5..dd212d804 100644
--- a/demo/posix/cobalt/can-rtt.c
+++ b/demo/posix/cobalt/can-rtt.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 	return -1;
     }
 
-    strncpy(ifr.ifr_name, rxdev, IFNAMSIZ);
+    namecpy(ifr.ifr_name, rxdev);
     printf("RX rxsock=%d, ifr_name=%s\n", rxsock, ifr.ifr_name);
 
     if (ioctl(rxsock, SIOCGIFINDEX, &ifr) < 0) {
@@ -282,7 +282,7 @@ int main(int argc, char *argv[])
 	    goto failure1;
 	}
 
-	strncpy(ifr.ifr_name, txdev, IFNAMSIZ);
+	namecpy(ifr.ifr_name, txdev);
 	printf("TX txsock=%d, ifr_name=%s\n", txsock, ifr.ifr_name);
 
 	if (ioctl(txsock, SIOCGIFINDEX, &ifr) < 0) {
diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
index 6ac12ab3e..91aef9fbd 100644
--- a/demo/posix/cobalt/eth_p_all.c
+++ b/demo/posix/cobalt/eth_p_all.c
@@ -40,6 +40,7 @@
 #include <net/if.h>
 #include <arpa/inet.h>
 #include <netinet/ether.h>
+#include <boilerplate/ancillaries.h>
 
 char buffer[10*1024];
 int sock;
@@ -72,7 +73,7 @@ int main(int argc, char *argv[])
 	if (argc > 1) {
 		struct ifreq ifr;
 
-		strncpy(ifr.ifr_name, argv[1], IFNAMSIZ);
+		namecpy(ifr.ifr_name, argv[1]);
 		if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
 			perror("cannot get interface index");
 			close(sock);
diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index ebe5461db..76983bd02 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -1353,7 +1353,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'F':
 		case OPT_FIFO:
 			use_fifo = 1;
-			strncpy(fifopath, optarg, strlen(optarg));
+			strncpy(fifopath, optarg, sizeof(fifopath) - 1);
 			break;
 
 		case 'H':
@@ -1458,7 +1458,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'T':
 		case OPT_TRACER:
 			tracetype = CUSTOM;
-			strncpy(tracer, optarg, sizeof(tracer));
+			strncpy(tracer, optarg, sizeof(tracer) - 1);
 			break;
 		case 'u':
 		case OPT_UNBUFFERED:
-- 
2.17.2


