From: Wolfgang Grandegger <wg@domain.hid>
Date: Mon, 21 Nov 2011 10:05:59 +0100
Message-Id: <1321866361-19373-2-git-send-email-wg@domain.hid>
In-Reply-To: <1321866361-19373-1-git-send-email-wg@domain.hid>
References: <1321866361-19373-1-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH 1/3] serial/16650a: fix missing value in
	default_config initialization
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

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/serial/16550A.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 8c8c864..61613f1 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -111,7 +111,7 @@ struct rt_16550_context {
 
 static const struct rtser_config default_config = {
 	0xFFFF, RTSER_DEF_BAUD, RTSER_DEF_PARITY, RTSER_DEF_BITS,
-	RTSER_DEF_STOPB, RTSER_DEF_HAND, RTSER_DEF_FIFO_DEPTH,
+	RTSER_DEF_STOPB, RTSER_DEF_HAND, RTSER_DEF_FIFO_DEPTH, 0,
 	RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT,
 	RTSER_DEF_TIMESTAMP_HISTORY, RTSER_DEF_EVENT_MASK
 };
-- 
1.7.6.4


