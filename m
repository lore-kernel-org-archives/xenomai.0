From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 05/11] drivers/rtipc: Convert to rtdm_available and clean up
Date: Fri, 13 Sep 2019 15:18:54 +0200
Message-Id: <181f9bb34278d6f6618fa261d4528b902bab08af.1568380740.git.jan.kiszka@siemens.com>
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

Properly fail if the core is not available. This also obsoletes the
check on exit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/ipc/rtipc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index f236f0cff4..99f73202de 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -493,8 +493,8 @@ int __init __rtipc_init(void)
 {
 	int ret, n;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	for (n = 0; n < IPCPROTO_MAX; n++) {
 		if (protocols[n] && protocols[n]->proto_init) {
@@ -511,9 +511,6 @@ void __exit __rtipc_exit(void)
 {
 	int n;
 
-	if (!realtime_core_enabled())
-		return;
-
 	rtdm_dev_unregister(&device);
 
 	for (n = 0; n < IPCPROTO_MAX; n++) {
-- 
2.16.4


