From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v5 6/8] drivers/can: add len field to can frame structures
Date: Sun, 19 Dec 2021 10:38:06 +0100
Message-Id: <20211219093809.21765-6-dariobin@libero.it>
In-Reply-To: <20211219093809.21765-1-dariobin@libero.it>
References: <20211219093809.21765-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jan Kiszka <jan.kiszka@siemens.com>, Dario Binacchi <dariobin@libero.it>, Philippe Gerum <rpm@xenomai.org>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>

As mentioned in Linux, can_dlc is a misleading name that suggests a code
instead of a length. Adding the len field can_dlc becomes deprecated too.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

(no changes since v1)

 include/rtdm/uapi/can.h           | 5 ++++-
 kernel/drivers/can/rtcan_socket.h | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/uapi/can.h b/include/rtdm/uapi/can.h
index 1c35a9b9d..0a74c764c 100644
--- a/include/rtdm/uapi/can.h
+++ b/include/rtdm/uapi/can.h
@@ -318,7 +318,10 @@ typedef struct can_frame {
 	can_id_t can_id;
 
 	/** Size of the payload in bytes */
-	uint8_t can_dlc;
+	union {
+		uint8_t can_dlc;
+		uint8_t len;
+	};
 
 	/** Payload data bytes */
 	uint8_t data[8] __attribute__ ((aligned(8)));
diff --git a/kernel/drivers/can/rtcan_socket.h b/kernel/drivers/can/rtcan_socket.h
index cf4422a1b..35ce13c3c 100644
--- a/kernel/drivers/can/rtcan_socket.h
+++ b/kernel/drivers/can/rtcan_socket.h
@@ -76,7 +76,10 @@ struct rtcan_rb_frame {
     /* DLC (between 0 and 15) and mark if frame has got a timestamp. The
      * existence of a timestamp is indicated by the RTCAN_HAS_TIMESTAMP
      * bit. */
-    unsigned char       can_dlc;
+    union {
+        unsigned char   can_dlc;
+        unsigned char   len;
+    };
 
     /* Data bytes */
     uint8_t             data[8];
-- 
2.17.1


