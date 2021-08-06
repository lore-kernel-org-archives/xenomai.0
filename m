From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] testsuite/smokey: net: load rtnet module if it has not been
 loaded
Date: Fri,  6 Aug 2021 01:56:20 -0400
Message-Id: <20210806055620.27190-1-hongzhan.chen@intel.com>
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
index 1badabdfb..bdae10bfb 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -138,6 +138,56 @@ static int do_down(const char *intf)
 	return 0;
 }
 
+static int smokey_net_modinfo(int modid)
+{
+	struct module *m = modules + modid;
+	char buffer[128];
+	int err;
+
+	if (modid < 0)
+		return -EINVAL;
+
+	smokey_trace("%s module: modinfoing", m->name);
+	err = smokey_check_errno(
+		snprintf(buffer, sizeof(buffer), "modinfo %s", m->name));
+	if (err < 0)
+		return err;
+
+	err = smokey_check_errno(system(buffer));
+	if (err < 0)
+		return err;
+
+	if (!WIFEXITED(err)) {
+		smokey_warning("%s: abnormal exit", buffer);
+		return -EINVAL;
+	}
+
+	if (WEXITSTATUS(err) != 0) {
+		/* double check if there is 'module not found' error,
+		 * translate it into -ENOSYS
+		 */
+		err = smokey_check_errno(
+			snprintf(buffer, sizeof(buffer),
+				"modinfo %s 2>&1 | grep '%s not found'",
+				m->name, m->name));
+		if (err < 0)
+			return err;
+
+		err = smokey_check_errno(system(buffer));
+		if (err < 0)
+			return err;
+
+		if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
+			smokey_warning("%s: abnormal exit", buffer);
+			return -EINVAL;
+		}
+
+		return -ENOSYS;
+	}
+
+	return err;
+}
+
 static int smokey_net_modprobe(int modid)
 {
 	struct module *m = modules + modid;
@@ -408,6 +458,14 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	struct sockaddr_in *in_peer = vpeer;
 	struct sockaddr *peer = vpeer;
 
+	err = smokey_net_modinfo(MODID_RTNET);
+	if (err < 0)
+		return err;
+
+	err = smokey_net_modprobe(MODID_RTNET);
+	if (err < 0)
+		return err;
+
 	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
 			&net_config, sizeof(net_config));
 	if (err == -EINVAL)
-- 
2.17.1


