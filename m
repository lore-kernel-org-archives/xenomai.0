From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 09/12] testsuite/smokey: net: do not unload pre-loaded modules
Date: Thu, 24 Jan 2019 16:34:25 +0100
Message-Id: <20190124153428.21006-10-rpm@xenomai.org>
In-Reply-To: <20190124153428.21006-1-rpm@xenomai.org>
References: <20190124153428.21006-1-rpm@xenomai.org>
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

We may want to use those tests in pre-configured situations, where a
set of RTnet modules is already in place at startup, which we don't
want the test to remove on exit.

Those changes ensure that only the modules we had to push for running
the test are actually removed on exit, leaving the pre-loaded ones
running.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/net_common/setup.c | 97 +++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index ea3daceca..d3791038f 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -28,6 +28,7 @@
 struct module {
 	int option;
 	const char *name;
+	bool loaded;
 };
 
 #define TIMEOUT 10
@@ -37,6 +38,15 @@ static int fd;
 static pthread_t loopback_server_tid;
 static bool loopback_thread_created;
 static struct module modules[] = {
+	{
+		.name = "rtnet",
+	},
+	{
+		.name = "rtipv4",
+	},
+	{
+		.name = "rtcfg",
+	},
 	{
 		.option = _CC_COBALT_NET_UDP,
 		.name = "rtudp",
@@ -45,9 +55,19 @@ static struct module modules[] = {
 		.option = _CC_COBALT_NET_AF_PACKET,
 		.name = "rtpacket",
 	},
+	{
+		.name = NULL,	/* driver */
+	},
 };
 
-static const char *option_to_module(int option)
+#define MODID_RTNET  0
+#define MODID_IPV4   1
+#define MODID_CFG    2
+#define MODID_UDP    3
+#define MODID_PACKET 4
+#define MODID_DRIVER 5
+
+static int option_to_modid(int option)
 {
 	unsigned i;
 
@@ -55,10 +75,10 @@ static const char *option_to_module(int option)
 		if (modules[i].option != option)
 			continue;
 
-		return modules[i].name;
+		return i;
 	}
 
-	return NULL;
+	return -1;
 }
 
 static int get_info(const char *intf)
@@ -118,13 +138,37 @@ static int do_down(const char *intf)
 	return 0;
 }
 
-static int smokey_net_modprobe(const char *mod)
+static int smokey_net_modprobe(int modid)
 {
+	struct module *m = modules + modid;
 	char buffer[128];
-	int err;
+	int err, len;
+	FILE *fp;
+
+	if (modid < 0)
+		return -EINVAL;
+
+	fp = fopen("/proc/modules", "r");
+	if (fp == NULL)
+		return -errno;
+
+	len = strlen(m->name);
+
+	while (fgets(buffer, sizeof(buffer), fp)) {
+		if (strncmp(buffer, m->name, len) == 0 &&
+		    len < sizeof(buffer) && buffer[len] == ' ') {
+			smokey_trace("%s module already loaded", m->name);
+			fclose(fp);
+			return 0;
+		}
+	}
+
+	fclose(fp);
+
+	smokey_trace("%s module not there: modprobing", m->name);
 
 	err = smokey_check_errno(
-		snprintf(buffer, sizeof(buffer), "modprobe %s", mod));
+		snprintf(buffer, sizeof(buffer), "modprobe %s", m->name));
 	if (err < 0)
 		return err;
 
@@ -137,16 +181,26 @@ static int smokey_net_modprobe(const char *mod)
 		return -EINVAL;
 	}
 
+	m->loaded = true;
+
 	return err;
 }
 
-static int smokey_net_rmmod(const char *mod)
+static int smokey_net_rmmod(int modid)
 {
+	struct module *m = modules + modid;
 	char buffer[128];
 	int err;
 
+	if (!m->loaded) {
+		smokey_trace("%s module was there on entry, keeping it", m->name);
+		return 0;
+	}
+
+	smokey_trace("unloading %s module", m->name);
+
 	err = smokey_check_errno(
-		snprintf(buffer, sizeof(buffer), "rmmod %s", mod));
+		snprintf(buffer, sizeof(buffer), "rmmod %s", m->name));
 	if (err < 0)
 		return err;
 
@@ -170,7 +224,7 @@ static int smokey_net_setup_rtcfg_client(const char *intf, int net_config)
 	if ((net_config & _CC_COBALT_NET_CFG) == 0)
 		return -ENOSYS;
 
-	err = smokey_net_modprobe("rtcfg");
+	err = smokey_net_modprobe(MODID_CFG);
 	if (err < 0)
 		return err;
 
@@ -213,11 +267,13 @@ static int smokey_net_teardown_rtcfg(const char *intf)
 	if (err < 0)
 		return err;
 
-	err = smokey_check_errno(ioctl(fd, RTCFG_IOC_DETACH, &cmd));
-	if (err < 0)
-		return err;
+	/*
+	 * We may or may not be acting as a server; don't check the
+	 * status.
+	 */
+	ioctl(fd, RTCFG_IOC_DETACH, &cmd);
 
-	return smokey_net_rmmod("rtcfg");
+	return smokey_net_rmmod(MODID_CFG);
 }
 
 static int find_peer(const char *intf, void *vpeer)
@@ -366,15 +422,16 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	if ((net_config & tested_config) == 0)
 		return -ENOSYS;
 
-	err = smokey_net_modprobe(driver);
+	modules[MODID_DRIVER].name = driver;
+	err = smokey_net_modprobe(MODID_DRIVER);
 	if (err < 0)
 		return err;
 
-	err = smokey_net_modprobe("rtipv4");
+	err = smokey_net_modprobe(MODID_IPV4);
 	if (err < 0)
 		return err;
 
-	err = smokey_net_modprobe(option_to_module(tested_config));
+	err = smokey_net_modprobe(option_to_modid(tested_config));
 	if (err < 0)
 		return err;
 
@@ -494,19 +551,19 @@ int smokey_net_teardown(const char *driver, const char *intf, int tested_config)
 	} else
 		err = tmp;
 
-	tmp = smokey_net_rmmod(option_to_module(tested_config));
+	tmp = smokey_net_rmmod(option_to_modid(tested_config));
 	if (err == 0)
 		err = tmp;
 
-	tmp = smokey_net_rmmod(driver);
+	tmp = smokey_net_rmmod(MODID_DRIVER);
 	if (err == 0)
 		err = tmp;
 
-	tmp = smokey_net_rmmod("rtipv4");
+	tmp = smokey_net_rmmod(MODID_IPV4);
 	if (err == 0)
 		err = tmp;
 
-	tmp = smokey_net_rmmod("rtnet");
+	tmp = smokey_net_rmmod(MODID_RTNET);
 	if (err == 0)
 		err = tmp;
 
-- 
2.17.2


