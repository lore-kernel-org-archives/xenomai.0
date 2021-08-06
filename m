From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: net: Load rtnet module if missing
Message-ID: <166cb503-258c-ddde-1143-4fd43c954c4f@siemens.com>
Date: Fri, 6 Aug 2021 09:38:11 +0200
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

This allows to run RTnet tests if the core is built as module but not
yet loaded at the start of the test.

For that, silence error reports of 'modprobe rtnet'.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This should do the trick as well, just a bit simpler.

 testsuite/smokey/net_common/setup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index 1badabdfb4..44a0cb24b9 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -138,7 +138,7 @@ static int do_down(const char *intf)
 	return 0;
 }
 
-static int smokey_net_modprobe(int modid)
+static int smokey_net_modprobe(int modid, bool silent)
 {
 	struct module *m = modules + modid;
 	char buffer[128];
@@ -168,7 +168,8 @@ static int smokey_net_modprobe(int modid)
 	smokey_trace("%s module not there: modprobing", m->name);
 
 	err = smokey_check_errno(
-		snprintf(buffer, sizeof(buffer), "modprobe %s", m->name));
+		snprintf(buffer, sizeof(buffer), "modprobe %s %s", m->name,
+			 silent ? "2>/dev/null" : ""));
 	if (err < 0)
 		return err;
 
@@ -177,7 +178,8 @@ static int smokey_net_modprobe(int modid)
 		return err;
 
 	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
-		smokey_warning("%s: abnormal exit", buffer);
+		if (!silent)
+			smokey_warning("%s: abnormal exit", buffer);
 		return -EINVAL;
 	}
 
@@ -224,7 +226,7 @@ static int smokey_net_setup_rtcfg_client(const char *intf, int net_config)
 	if ((net_config & _CC_COBALT_NET_CFG) == 0)
 		return -ENOSYS;
 
-	err = smokey_net_modprobe(MODID_CFG);
+	err = smokey_net_modprobe(MODID_CFG, false);
 	if (err < 0)
 		return err;
 
@@ -408,6 +410,12 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	struct sockaddr_in *in_peer = vpeer;
 	struct sockaddr *peer = vpeer;
 
+	/*
+	 * Main module needs to be loaded in order to use
+	 * _CC_COBALT_GET_NET_CONFIG.
+	 */
+	smokey_net_modprobe(MODID_RTNET, true);
+
 	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
 			&net_config, sizeof(net_config));
 	if (err == -EINVAL)
@@ -423,15 +431,15 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 		return -ENOSYS;
 
 	modules[MODID_DRIVER].name = driver;
-	err = smokey_net_modprobe(MODID_DRIVER);
+	err = smokey_net_modprobe(MODID_DRIVER, false);
 	if (err < 0)
 		return err;
 
-	err = smokey_net_modprobe(MODID_IPV4);
+	err = smokey_net_modprobe(MODID_IPV4, false);
 	if (err < 0)
 		return err;
 
-	err = smokey_net_modprobe(option_to_modid(tested_config));
+	err = smokey_net_modprobe(option_to_modid(tested_config), false);
 	if (err < 0)
 		return err;
 
-- 
2.31.1

