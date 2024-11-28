Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142F154BFE
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785272; cv=none; b=UxvpYkTXTTxwOu30kiojtnfdsfTxutFBHRnq3a753cqffrExg+39+UZvGm82d3S5NkwVyEW3zIl/XSl7I0bC5KiSS//ClTL/PPl7k+clGMcbD7/c6sDL7c9V2ONzdoKbSyaY1THInRPQznYhyX6XgNyD3PWDx+fd826Jr3Gbx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785272; c=relaxed/simple;
	bh=/wJXFmcbBXxwcpXAG04c1TJQFChnypasS1EBBfuO+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkoTujQICEy8tFHgQ5/u9LKqSd9TuUhBBlFpf+SOaO4Z3E4UfDK3Q0q3pTNwvG7asQ4tHaQoHr00vm27XQoRJ/oPYMR4u0iOI4T1HNwuKIEXlS60FyowcWCUU6ZmMcHkDMeudDhIm6DfJfy1YpTgv16uTlsN/BNwEjPfmUo8srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.aP2XU1q_1732785254 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 17:14:15 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v2] fix user get ifindex error issue
Date: Thu, 28 Nov 2024 09:14:11 +0000
Message-ID: <20241128091411.73192-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when user program get the ifindex cross the ioctl SIOCGIFINDEX, the ifindex is a random data.
this patch fix the user program getting ifindex error issue.

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 kernel/drivers/can/m_can/rtcan_m_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/can/m_can/rtcan_m_can.c b/kernel/drivers/can/m_can/rtcan_m_can.c
index c2bd16660..f647c6f7f 100644
--- a/kernel/drivers/can/m_can/rtcan_m_can.c
+++ b/kernel/drivers/can/m_can/rtcan_m_can.c
@@ -474,6 +474,8 @@ static int m_can_read_fifo(struct rtcan_device *dev, u32 rxfs)
 	u32 timestamp = 0;
 	int err;
 
+	cf->can_ifindex = dev->ifindex;
+
 	/* calculate the fifo get index for where to read data */
 	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
 	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
@@ -550,7 +552,8 @@ static int m_can_handle_lost_msg(struct rtcan_device *dev)
 
 	rtcandev_err(dev, "msg lost in rxf0\n");
 	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
-
+	
+	frame->can_ifindex = dev->ifindex;
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 	frame->can_dlc = CAN_ERR_DLC;
-- 
2.34.1

