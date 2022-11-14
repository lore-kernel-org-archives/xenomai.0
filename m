Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE4847C
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 20:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EC5B663E5142
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 21:14:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yTewS1UX4zjA for <xenomai@lists.linux.dev>;
	Mon, 14 Nov 2022 21:14:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 92B5063E5143
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 21:14:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b9Sfo3VrZc5v for <xenomai@lists.linux.dev>;
	Mon, 14 Nov 2022 21:14:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 79C2C63E5142
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 21:14:15 +0100 (CET)
Date: Mon, 14 Nov 2022 21:14:15 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Message-ID: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
Subject: rtser_config and compat userspace
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: ibf5v3qlxkRTaeE16XPSbjeLOxe2Xw==
Thread-Topic: rtser_config and compat userspace

Hi!

I noticed that a 32-bits x86 application cannot use RTSER_RTIOC_SET_CONFIG and friends when the kernel
runs in 64-bits mode.
The problem is that struct rtser_config members have different alignment.

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

I propose the following fix:

diff --git a/include/rtdm/uapi/serial.h b/include/rtdm/uapi/serial.h
index 9ac691b723a0..3c798de13985 100644
--- a/include/rtdm/uapi/serial.h
+++ b/include/rtdm/uapi/serial.h
@@ -240,6 +240,8 @@ typedef struct rtser_config {
 
        /** enable RS485 mode, see @ref RTSER_RS485_xxx */
        int             rs485;
+
+       int             padding0;
 } rtser_config_t;
 
 /**


But I'm not sure whether you can accept this since it changes the ABI and existing Xenomai
applications will have to be recompiled.

Thanks,
//richard
