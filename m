From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 06/11] drivers/analogy: Convert to rtdm_available and clean up
Date: Fri, 13 Sep 2019 15:18:55 +0200
Message-Id: <014de8384cc4ada388e16d581f696e7c5d3c3061.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
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

Properly fail when the core is not available. Remove now obsolete
further checks because the functions will not longer be executed in that
case.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/driver.c         | 6 ------
 kernel/drivers/analogy/rtdm_interface.c | 7 ++-----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/kernel/drivers/analogy/driver.c b/kernel/drivers/analogy/driver.c
index c9ba1cc836..fb7c51722a 100644
--- a/kernel/drivers/analogy/driver.c
+++ b/kernel/drivers/analogy/driver.c
@@ -55,9 +55,6 @@ int a4l_lct_drv(char *pin, struct a4l_driver ** pio)
 
 int a4l_register_drv(struct a4l_driver * drv)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	__a4l_dbg(1, core_dbg, "board name=%s\n", drv->board_name);
 
 	if (a4l_lct_drv(drv->board_name, NULL) != 0) {
@@ -69,9 +66,6 @@ int a4l_register_drv(struct a4l_driver * drv)
 
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


