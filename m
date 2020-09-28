From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] demo/posix/cobalt: Avoid ancillaries header
Message-ID: <7f113f55-83df-8524-bec0-058fb4194932@siemens.com>
Date: Mon, 28 Sep 2020 19:16:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Makes the demo more portable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 demo/posix/cobalt/eth_p_all.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
index 91aef9fbdb..c4cf0d696f 100644
--- a/demo/posix/cobalt/eth_p_all.c
+++ b/demo/posix/cobalt/eth_p_all.c
@@ -40,7 +40,6 @@
 #include <net/if.h>
 #include <arpa/inet.h>
 #include <netinet/ether.h>
-#include <boilerplate/ancillaries.h>
 
 char buffer[10*1024];
 int sock;
@@ -73,7 +72,7 @@ int main(int argc, char *argv[])
 	if (argc > 1) {
 		struct ifreq ifr;
 
-		namecpy(ifr.ifr_name, argv[1]);
+		snprintf(ifr.ifr_name, IFNAMSIZ, "%s", argv[1]);
 		if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
 			perror("cannot get interface index");
 			close(sock);
-- 
2.26.2

