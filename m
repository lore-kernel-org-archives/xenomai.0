Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67F52F88
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765451; cv=none; b=GZ8eikv2onbfrkKgdjwCi42RfqaNmlX/Gj8OdTtOMElMBTtDR/9XSaXr8oefVwwq7k0dN6JY3CHaPAafwtBlBGHbatWe1NP5Mdt/NOkUz8k2WudNjiPtRXJohmEh8YMXFpm78R/2MoDtrMxgGtr5gvbFqBH87jHnKTFFBMJ4ps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765451; c=relaxed/simple;
	bh=wQzRtL/DnXbHKochKp31zkrX39ynPEc1QAGebVgF+1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnvI9juV6PEd1kLLKuhlcG3Hd+cWuXo5VGFmepaoZXp8brsk3Zo24lXpwD4Y00n6Omjv7YGuNQfJXF1S578nasxcsicfLHIcot/3ScxrGnIiv6NRBI1obw3w1MR6KWhZhpPJTW0kIxg48kI5eweasGi/wi4EM3HV3+11NceCE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.aOmULZ4_1732765432 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 11:43:53 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v2] fix user get ifindex error issue
Date: Thu, 28 Nov 2024 11:43:51 +0800
Message-Id: <20241128034351.1871231-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

