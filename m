From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 1/2] testsuite/smokey: net: load rtnet module if it has not
 been loaded
Date: Tue,  3 Aug 2021 22:47:13 -0400
Message-Id: <20210804024714.665-1-hongzhan.chen@intel.com>
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
index 1badabdfb..719d8175f 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -408,6 +408,14 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	struct sockaddr_in *in_peer = vpeer;
 	struct sockaddr *peer = vpeer;
 
+	err = access("/dev/rtnet", F_OK);
+	if (err) {
+		/* device does not exist and load rtnet*/
+		err = smokey_net_modprobe(MODID_RTNET);
+		if (err < 0)
+			return err;
+	}
+
 	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
 			&net_config, sizeof(net_config));
 	if (err == -EINVAL)
-- 
2.17.1


