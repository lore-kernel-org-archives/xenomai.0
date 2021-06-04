From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/can/rtcan_flexcan: Address fall-through warning
Message-ID: <f2e1bcd2-94c7-5a9b-e281-7b40bfb4a6d1@siemens.com>
Date: Fri, 4 Jun 2021 11:04:14 +0200
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

Only detected by the compiler when formatted this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_flexcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index ed855b2ed..601dd0ba4 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -604,7 +604,8 @@ static void flexcan_change_state(struct rtcan_device *dev,
 				CAN_ERR_CRTL_TX_WARNING :
 				CAN_ERR_CRTL_RX_WARNING;
 		}
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		/* fallthrough */
+	case CAN_STATE_ERROR_WARNING:
 		/*
 		 * from: ERROR_ACTIVE, ERROR_WARNING
 		 * to  : ERROR_PASSIVE, BUS_OFF
-- 
2.26.2

