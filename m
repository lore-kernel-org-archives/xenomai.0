From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 06/12] drivers/analogy: Convert to rtdm_available and clean
 up
Date: Fri, 13 Sep 2019 18:46:49 +0200
Message-Id: <9c3ecf0dec5fb673fd06c7fac7554c3ca1128ac7.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Properly fail init and registration when the core is not available.
Remove further checks that are obsolete when an error is returned.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/driver.c         | 7 ++-----
 kernel/drivers/analogy/rtdm_interface.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/analogy/driver.c b/kernel/drivers/analogy/driver.c
index c9ba1cc836..a857dea92d 100644
--- a/kernel/drivers/analogy/driver.c
+++ b/kernel/drivers/analogy/driver.c
@@ -55,8 +55,8 @@ int a4l_lct_drv(char *pin, struct a4l_driver ** pio)
 
 int a4l_register_drv(struct a4l_driver * drv)
 {
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	__a4l_dbg(1, core_dbg, "board name=%s\n", drv->board_name);
 
@@ -69,9 +69,6 @@ int a4l_register_drv(struct a4l_driver * drv)
 
 int a4l_unregister_drv(struct a4l_driver * drv)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	__a4l_dbg(1, core_dbg, "board name=%s\n", drv->board_name);
 
 	if (a4l_lct_drv(drv->board_name, NULL) == 0) {
diff --git a/kernel/drivers/analogy/rtdm_interface.c b/kernel/drivers/analogy/rtdm_interface.c
index 4fb2b5ca50..af2b4eefe4 100644
--- a/kernel/drivers/analogy/rtdm_interface.c
+++ b/kernel/drivers/analogy/rtdm_interface.c
@@ -274,8 +274,8 @@ static int __init a4l_init(void)
 {
 	int ret;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	/* Initializes the devices */
 	a4l_init_devs();
@@ -299,9 +299,6 @@ out_a4l_init:
 
 static void __exit a4l_cleanup(void)
 {
-	if (!realtime_core_enabled())
-		return;
-
 	/* Removes Analogy proc files */
 	a4l_cleanup_proc();
 
-- 
2.16.4


