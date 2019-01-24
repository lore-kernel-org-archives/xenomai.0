From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 10/12] testsuite/smokey: net: do not down a previously running
 test interface
Date: Thu, 24 Jan 2019 16:34:26 +0100
Message-Id: <20190124153428.21006-11-rpm@xenomai.org>
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

If the test interface is already up on entry, keep it that way on
exit, so that we may run this test multiple times without having to
reconfigure.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/net_common/setup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index d3791038f..1badabdfb 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -36,7 +36,7 @@ struct module {
 static struct rtnet_core_cmd cmd;
 static int fd;
 static pthread_t loopback_server_tid;
-static bool loopback_thread_created;
+static bool loopback_thread_created, ifup;
 static struct module modules[] = {
 	{
 		.name = "rtnet",
@@ -447,6 +447,7 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 		err = do_up(intf);
 		if (err < 0)
 			goto err;
+		ifup = true;
 	}
 
 	smokey_trace("Waiting for interface %s to be running", intf);
@@ -543,9 +544,11 @@ int smokey_net_teardown(const char *driver, const char *intf, int tested_config)
 				err = tmp;
 		}
 
-		tmp = do_down(intf);
-		if (err == 0)
-			err = tmp;
+		if (ifup) {
+			tmp = do_down(intf);
+			if (err == 0)
+				err = tmp;
+		}
 
 		close(fd);
 	} else
-- 
2.17.2


