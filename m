Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C643451C4
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073196; cv=none; b=gyKu1+SZri1iUU803QCgfpkQGxAWbQRJJ5gtLsem0VIAwo+P0AxjL1b5RF5tfLzb9bEbQYL7EGx4TH4QivGiN5eNMtrFZfaexGt5l/HWxwFZkqsigmeLLggVyU3c1Vw+Nb46vhDsxhbUMkDSGWLaOy8Nj0xl2XYitxVCkXxICxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073196; c=relaxed/simple;
	bh=xBc5+KXUdpSfoCmpJpVYdQ1c0UUYl9QT8xkkdo6yjHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SroEgm3gOLdePA7j0sWnCWSSR+ImIA24QNmkZXkwN3+KuUGWa++N9IYDbmu/qU12Eyz7W+6Dl6rbmbI34VGEN5NC9EBR0r9M/zxTQLZ8CqwEaaIjIGCa4fg6XnLWZB7pa9sCQVIdMFEPfWmPh6KIVfGxhMpM5Yq6LYCy+/9n74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=cPwER5Nc; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cPwER5Nc"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025090511430061723ecebf0002075f
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 13:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PpGz3KJnAbrwdSlP3ToCCuVU+TB5WahujHuSaatuzks=;
 b=cPwER5NcPf0eFy46phSGebvVjZdmBO8BPB40ltpCuV8cf9oTHq7VVhwUGQRoAD+Mdun3vD
 vI7sYqXYtG2ZVqz19mxU9ZXSpTEpS+JtVoh+xYp2cc3CruRYCUmmbfl3xSMglzvJ8e8voiTa
 sTRxCIe3LoZa6EwXkGdvXTR8qi2GupcH+ICfgkR7XLBrfU8/AtpXbGbhUhs5tZ2IVOLRrTxF
 jFhZ67SZPcGecofP8KJY+4Dd4aSDlpy4n9l51JejKyVlBFAaTNbUUIgk9q3wHgH5rR+nJCVY
 hpL94/wVimkd5ChsHU1kwfajiz9R6fiRSIZyLqWSqkR4CEoXLquwnyWA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 4/5] drivers/net/eepro100: Silence FORTIFY_SOURCE warning
Date: Fri,  5 Sep 2025 13:42:57 +0200
Message-ID: <f2e9f00793cf221701a63e007a2797db1950b12a.1757072578.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757072578.git.jan.kiszka@siemens.com>
References: <cover.1757072578.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

We are writing into correctly allocated areas in the TX ring in both
cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/eepro100.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index e889894464..40bb1dd7ec 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -997,7 +997,8 @@ static void speedo_resume(struct rtnet_device *rtdev)
 		ias_cmd->cmd_status = cpu_to_le32((CmdSuspend | CmdIASetup) | 0xa000);
 		ias_cmd->link =
 			cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->cur_tx % TX_RING_SIZE));
-		memcpy(ias_cmd->params, rtdev->dev_addr, 6);
+		memcpy(((u8 *)ias_cmd) + offsetof(struct descriptor, params),
+		       rtdev->dev_addr, 6);
 		sp->last_cmd = ias_cmd;
 	}
 
@@ -1705,7 +1706,8 @@ static void set_rx_mode(struct rtnet_device *rtdev)
 		sp->tx_ring[entry].status = cpu_to_le32(CmdSuspend | CmdConfigure);
 		sp->tx_ring[entry].link =
 			cpu_to_le32(TX_RING_ELEM_DMA(sp, (entry + 1) % TX_RING_SIZE));
-		config_cmd_data = (void *)&sp->tx_ring[entry].tx_desc_addr;
+		config_cmd_data = ((u8 *)&sp->tx_ring[entry]) +
+			offsetof(struct TxFD, tx_desc_addr);
 		/* Construct a full CmdConfig frame. */
 		memcpy(config_cmd_data, i82558_config_cmd, CONFIG_DATA_SIZE);
 		config_cmd_data[1] = (txfifo << 4) | rxfifo;
-- 
2.43.0

