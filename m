From: Wolfgang Grandegger <wg@domain.hid>
Date: Mon, 21 Nov 2011 10:06:00 +0100
Message-Id: <1321866361-19373-3-git-send-email-wg@domain.hid>
In-Reply-To: <1321866361-19373-1-git-send-email-wg@domain.hid>
References: <1321866361-19373-1-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH 2/3] serial: add shift register empty event
	and RS485 support flag
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

From: Wolfgang Grandegger <wg@domain.hid>

This patch extends rtserial.h to support RS485 and shift register empty
events. In contrast to the MPC5200 PSC UART, the 16550A seem not be able
to signal that event via interrupt. The "Tramsmitter Empty" bit in the
line status register needs to be polled.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 include/rtdm/rtserial.h      |   14 ++++++++++++++
 ksrc/drivers/serial/16550A.c |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/include/rtdm/rtserial.h b/include/rtdm/rtserial.h
index 00dc536..a6d9753 100644
--- a/include/rtdm/rtserial.h
+++ b/include/rtdm/rtserial.h
@@ -130,6 +130,15 @@
 /** @} */
 
 /*!
+ * @anchor RTSER_RS485_xxx   @name RTSER_RS485_xxx
+ * RS485 mode with automatic RTS handling
+ * @{ */
+#define RTSER_RS485_DISABLE		0x00
+#define RTSER_RS485_ENABLE		0x01
+#define RTSER_DEF_RS485			RTSER_RS485_DISABLE
+/** @} */
+
+/*!
  * @anchor RTSER_FIFO_xxx   @name RTSER_FIFO_xxx
  * Reception FIFO interrupt threshold
  * @{ */
@@ -165,6 +174,7 @@
 #define RTSER_EVENT_ERRPEND		0x02
 #define RTSER_EVENT_MODEMHI		0x04
 #define RTSER_EVENT_MODEMLO		0x08
+#define RTSER_EVENT_TXEMPTY		0x10
 #define RTSER_DEF_EVENT_MASK		0x00
 /** @} */
 
@@ -184,6 +194,7 @@
 #define RTSER_SET_TIMEOUT_EVENT		0x0400
 #define RTSER_SET_TIMESTAMP_HISTORY	0x0800
 #define RTSER_SET_EVENT_MASK		0x1000
+#define RTSER_SET_RS485			0x2000
 /** @} */
 
 
@@ -282,6 +293,9 @@ typedef struct rtser_config {
 	/** event mask to be used with @ref RTSER_RTIOC_WAIT_EVENT, see
 	 *  @ref RTSER_EVENT_xxx */
 	int		event_mask;
+
+	/** enable RS485 mode, see @ref RTSER_RS485_xxx */
+	int		rs485;
 } rtser_config_t;
 
 /**
diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 61613f1..3672539 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -113,7 +113,7 @@ static const struct rtser_config default_config = {
 	0xFFFF, RTSER_DEF_BAUD, RTSER_DEF_PARITY, RTSER_DEF_BITS,
 	RTSER_DEF_STOPB, RTSER_DEF_HAND, RTSER_DEF_FIFO_DEPTH, 0,
 	RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT,
-	RTSER_DEF_TIMESTAMP_HISTORY, RTSER_DEF_EVENT_MASK
+	RTSER_DEF_TIMESTAMP_HISTORY, RTSER_DEF_EVENT_MASK, RTSER_DEF_RS485
 };
 
 static struct rtdm_device *device[MAX_DEVICES];
-- 
1.7.6.4


