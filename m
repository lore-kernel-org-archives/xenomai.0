From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/can: Fix gcc-8 warning about improper string
 concatenation
Message-ID: <70b00d9f-8c70-e8e7-2ee4-7934e4e526bf@siemens.com>
Date: Mon, 9 Sep 2019 20:41:33 +0200
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

The compiler correctly remarks that strncat was used with the target
buffer size as input, ignoring the required space for the terminating
\0 - not to speak of the fact the we did this two times in a row.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_module.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 97beb457d0..eca8acb8cf 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -47,11 +47,9 @@ struct proc_dir_entry *rtcan_proc_root;
 static void rtcan_dev_get_ctrlmode_name(can_ctrlmode_t ctrlmode,
 					char* name, int max_len)
 {
-    *name = '\0';
-    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
-	strncat(name, "listen-only ", max_len);
-    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
-	strncat(name, "loopback ", max_len);
+    snprintf(name, max_len, "%s%s",
+	     ctrlmode & CAN_CTRLMODE_LISTENONLY ? "listen-only " : "",
+	     ctrlmode & CAN_CTRLMODE_LOOPBACK ? "loopback " : "");
 }
 
 static char *rtcan_state_names[] = {
-- 

2.16.4

