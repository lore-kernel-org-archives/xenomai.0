From: Norbert Lange <nolange79@gmail.com>
Date: Mon, 23 Apr 2018 16:21:32 +0200
Message-Id: <20180423142133.5275-1-norbert.lange@andritz.com>
Subject: [Xenomai] [PATCH] fix one out-of-bounds access
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 testsuite/smokey/net_common/smokey_net_server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/net_common/smokey_net_server.c b/testsuite/smokey/net_common/smokey_net_server.c
index a0ed52fd9..2e19208e7 100644
--- a/testsuite/smokey/net_common/smokey_net_server.c
+++ b/testsuite/smokey/net_common/smokey_net_server.c
@@ -89,7 +89,7 @@ rtnet_rtcfg_add_client(int fd, const char *hwaddr, const char *ipaddr)
 	cmd.args.add.ip_addr = ip.s_addr;
 	cmd.args.add.timeout = 3000;
 	memcpy(cmd.args.add.mac_addr, mac.ether_addr_octet,
-		sizeof(cmd.args.add.mac_addr));
+		sizeof(mac.ether_addr_octet));
 
 	check_unix(ioctl(fd, RTCFG_IOC_ADD, &cmd));
 }
-- 
2.17.0


