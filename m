From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH V2] testsuite/smokey: net: load rtnet module if it has not
 been loaded
Date: Wed,  4 Aug 2021 23:13:27 -0400
Message-Id: <20210805031327.10873-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Before checking net config, rtnet should be ready.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index 1badabdfb..a0512b00d 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -408,6 +408,10 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	struct sockaddr_in *in_peer = vpeer;
 	struct sockaddr *peer = vpeer;
 
+	err = smokey_net_modprobe(MODID_RTNET);
+	if (err < 0)
+		return err;
+
 	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
 			&net_config, sizeof(net_config));
 	if (err == -EINVAL)
-- 
2.17.1


