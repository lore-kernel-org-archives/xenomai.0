From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 07/18] testsuite/gpiotest: enable timestamping on 'timestamp'
 argument
Date: Mon,  4 Feb 2019 11:56:36 +0100
Message-Id: <20190204105647.5034-8-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/gpiotest/gpiotest.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/testsuite/gpiotest/gpiotest.c b/testsuite/gpiotest/gpiotest.c
index 3c8c6c318..7347ac506 100644
--- a/testsuite/gpiotest/gpiotest.c
+++ b/testsuite/gpiotest/gpiotest.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 #include <smokey/smokey.h>
 #include <rtdm/gpio.h>
+#include <boilerplate/time.h>
 
 smokey_test_plugin(interrupt,
 		   SMOKEY_ARGLIST(
@@ -39,6 +40,7 @@ smokey_test_plugin(interrupt,
    "\tdevice=<device-path>\n"
    "\trigger={edge[-rising/falling/both], level[-low/high]}\n"
    "\tselect, wait on select(2)."
+   "\ttimestamp, enable timestamping."
 );
 
 smokey_test_plugin(read_value,
@@ -72,8 +74,10 @@ static int run_interrupt(struct smokey_test *t, int argc, char *const argv[])
 		{ .name = "level-high", .flag = GPIO_TRIGGER_LEVEL_HIGH },
 		{ NULL, 0 },
 	};
-	int do_select = 0, fd, ret, trigger, n, value;
+	int do_select = 0, fd, ret, trigger, n, value, do_timestamp = 0;
 	const char *device = NULL, *trigname;
+	struct rtdm_gpio_readout rdo;
+	struct timespec now;
 	fd_set set;
 	
 	smokey_parse_args(t, argc, argv);
@@ -95,6 +99,9 @@ static int run_interrupt(struct smokey_test *t, int argc, char *const argv[])
 	if (SMOKEY_ARG_ISSET(interrupt, select))
 		do_select = SMOKEY_ARG_BOOL(interrupt, select);
 
+	if (SMOKEY_ARG_ISSET(interrupt, timestamp))
+		do_timestamp = SMOKEY_ARG_BOOL(interrupt, timestamp);
+
 	trigger = GPIO_TRIGGER_NONE;
 	if (SMOKEY_ARG_ISSET(interrupt, trigger)) {
 		trigname = SMOKEY_ARG_STRING(interrupt, trigger);
@@ -131,14 +138,28 @@ static int run_interrupt(struct smokey_test *t, int argc, char *const argv[])
 				return ret;
 			}
 		}
-		ret = read(fd, &value, sizeof(value));
-		if (ret < 0) {
-			ret = -errno;
-			warning("failed reading from %s [%s]",
-				device, symerror(ret));
-			return ret;
+		if (do_timestamp) {
+			ret = read(fd, &rdo, sizeof(rdo));
+			if (ret < 0) {
+				ret = -errno;
+				warning("failed reading from %s [%s]",
+					device, symerror(ret));
+				return ret;
+			}
+			clock_gettime(CLOCK_MONOTONIC, &now);
+			printf("received irq %llu us from now, GPIO state=%d\n",
+			       (timespec_scalar(&now) - rdo.timestamp) / 1000ULL,
+			       rdo.value);
+		} else {
+			ret = read(fd, &value, sizeof(value));
+			if (ret < 0) {
+				ret = -errno;
+				warning("failed reading from %s [%s]",
+					device, symerror(ret));
+				return ret;
+			}
+			printf("received irq, GPIO state=%d\n", value);
 		}
-		printf("received irq, GPIO state=%d\n", value);
 	}
 
 	close(fd);
-- 
2.17.2


