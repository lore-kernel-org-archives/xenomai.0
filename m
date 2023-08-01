Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78A1FB44
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:39:55 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202308010929457e2326e90fd257f69f
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DxI5RrEgnzNahaC/jHVlzDad0muub66lMbywust4oCs=;
 b=G6j1s8QcjAI74WODpjmJOkEZtBthVKHaWjjO1ydZpP6er2Fd73CsqSUEfjOORMCOHcLTcO
 BMkdCeuTF0gsS6x23ujeMVj1EtOqOJ4P2AaCpuZo4st6DCXo75/0vWmCK6z6J/AUXT7+f6KJ
 swVEujb7UAjQoZ7qdzPR0ZmPVW0Hs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 01 Aug 2023 11:29:40 +0200
Subject: [PATCH v3 6/7] include/rtdm/serial.h: Move to data types with
 fixed sizes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-6-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a preparation for making struct rtser_config compat aware.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/rtdm/uapi/serial.h | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/rtdm/uapi/serial.h b/include/rtdm/uapi/serial.h
index 9ac691b72..843c940b3 100644
--- a/include/rtdm/uapi/serial.h
+++ b/include/rtdm/uapi/serial.h
@@ -23,6 +23,8 @@
 #ifndef _RTDM_UAPI_SERIAL_H
 #define _RTDM_UAPI_SERIAL_H
 
+#include <linux/types.h>
+
 #define RTSER_PROFILE_VER		3
 
 /*!
@@ -198,27 +200,27 @@
  */
 typedef struct rtser_config {
 	/** mask specifying valid fields, see @ref RTSER_SET_xxx */
-	int		config_mask;
+	__s32		config_mask;
 
 	/** baud rate, default @ref RTSER_DEF_BAUD */
-	int		baud_rate;
+	__s32		baud_rate;
 
 	/** number of parity bits, see @ref RTSER_xxx_PARITY */
-	int		parity;
+	__s32		parity;
 
 	/** number of data bits, see @ref RTSER_xxx_BITS */
-	int		data_bits;
+	__s32		data_bits;
 
 	/** number of stop bits, see @ref RTSER_xxx_STOPB */
-	int		stop_bits;
+	__s32		stop_bits;
 
 	/** handshake mechanisms, see @ref RTSER_xxx_HAND */
-	int		handshake;
+	__s32		handshake;
 
 	/** reception FIFO interrupt threshold, see @ref RTSER_FIFO_xxx */
-	int		fifo_depth;
+	__s32		fifo_depth;
 
-	int		reserved;
+	__s32		reserved;
 
 	/** reception timeout, see @ref RTSER_TIMEOUT_xxx for special
 	 *  values */
@@ -232,14 +234,14 @@ typedef struct rtser_config {
 	nanosecs_rel_t	event_timeout;
 
 	/** enable timestamp history, see @ref RTSER_xxx_TIMESTAMP_HISTORY */
-	int		timestamp_history;
+	__s32		timestamp_history;
 
 	/** event mask to be used with @ref RTSER_RTIOC_WAIT_EVENT, see
 	 *  @ref RTSER_EVENT_xxx */
-	int		event_mask;
+	__s32		event_mask;
 
 	/** enable RS485 mode, see @ref RTSER_RS485_xxx */
-	int		rs485;
+	__s32		rs485;
 } rtser_config_t;
 
 /**
@@ -247,10 +249,10 @@ typedef struct rtser_config {
  */
 typedef struct rtser_status {
 	/** line status register, see @ref RTSER_LSR_xxx */
-	int		line_status;
+	__s32		line_status;
 
 	/** modem status register, see @ref RTSER_MSR_xxx */
-	int		modem_status;
+	__s32		modem_status;
 } rtser_status_t;
 
 /**
@@ -258,10 +260,10 @@ typedef struct rtser_status {
  */
 typedef struct rtser_event {
 	/** signalled events, see @ref RTSER_EVENT_xxx */
-	int		events;
+	__s32		events;
 
 	/** number of pending input characters */
-	int		rx_pending;
+	__s32		rx_pending;
 
 	/** last interrupt timestamp */
 	nanosecs_abs_t	last_timestamp;

-- 
2.39.2

