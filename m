Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D899200A7
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:39:55 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023080109294606694defaf2747eef7
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fNshWRhc29f9aRqvZWAPTYaqEMpFKj7WHld11Hd0lyw=;
 b=Zey9TUKD18GokLYDIQ2eiorZ2uNKkB1oKHQvSx83QoYnzvLxdcv9xXJ6obhgFpYamVFB5E
 i88G7r6e2NSKeOe063AagEPwCG4zj50mKLbblIGDtp7clpflupGKp/aMiDituAoUQ4HhsMB8
 9U7DHGhxHNCINOEl+J0FIh/NA8u5Q=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 01 Aug 2023 11:29:41 +0200
Subject: [PATCH v3 7/7] include/rtdm/serial.h: Fix compat support of struct
 rtser_config
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-7-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Richard Weinberger <richard@nod.at>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a backward compatibility breaking change for compat (32 bit)
applications. We already bumped the ABI revision so we already force
recompiling all applications.

On 32bits:
struct rtser_config {
        int                        config_mask;          /*     0     4 */
        int                        baud_rate;            /*     4     4 */
        int                        parity;               /*     8     4 */
        int                        data_bits;            /*    12     4 */
        int                        stop_bits;            /*    16     4 */
        int                        handshake;            /*    20     4 */
        int                        fifo_depth;           /*    24     4 */
        int                        reserved;             /*    28     4 */
        nanosecs_rel_t             rx_timeout;           /*    32     8 */
        nanosecs_rel_t             tx_timeout;           /*    40     8 */
        nanosecs_rel_t             event_timeout;        /*    48     8 */
        int                        timestamp_history;    /*    56     4 */
        int                        event_mask;           /*    60     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        rs485;                /*    64     4 */

        /* size: 68, cachelines: 2, members: 14 */
        /* last cacheline: 4 bytes */
} __attribute__((__packed__));

Note: I don't know why pahole reports this struct as packed. It is not.

and 64:
struct rtser_config {
        int                        config_mask;          /*     0     4 */
        int                        baud_rate;            /*     4     4 */
        int                        parity;               /*     8     4 */
        int                        data_bits;            /*    12     4 */
        int                        stop_bits;            /*    16     4 */
        int                        handshake;            /*    20     4 */
        int                        fifo_depth;           /*    24     4 */
        int                        reserved;             /*    28     4 */
        nanosecs_rel_t             rx_timeout;           /*    32     8 */
        nanosecs_rel_t             tx_timeout;           /*    40     8 */
        nanosecs_rel_t             event_timeout;        /*    48     8 */
        int                        timestamp_history;    /*    56     4 */
        int                        event_mask;           /*    60     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        rs485;                /*    64     4 */

        /* size: 72, cachelines: 2, members: 14 */
        /* padding: 4 */
        /* last cacheline: 8 bytes */
};

While nanosecs_rel_t is in both case int64_t, gcc adds different tail padding to the struct.

Link: https://lore.kernel.org/all/601440741.237005.1668456855365.JavaMail.zimbra@nod.at/
Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/rtdm/uapi/serial.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/rtdm/uapi/serial.h b/include/rtdm/uapi/serial.h
index 843c940b3..7a250a92d 100644
--- a/include/rtdm/uapi/serial.h
+++ b/include/rtdm/uapi/serial.h
@@ -242,6 +242,9 @@ typedef struct rtser_config {
 
 	/** enable RS485 mode, see @ref RTSER_RS485_xxx */
 	__s32		rs485;
+
+	/* anonymous padding for compat support */
+	int: 32;
 } rtser_config_t;
 
 /**

-- 
2.39.2

