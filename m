Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3033C4
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:39 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D72CE6000C
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 85974AC0D94
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202207041308370d1063327f9acc05ca
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=BqY8WD0eVLxfO/6wjipWCNG44h0IQZn9JWzNX8SqeVs=;
 b=VSX/QH2XKFbCpSnprIITwOeNRO8T+KDglT8R5FW/3eZQdn0QCcWt7OIDd5kB0OWzyeLZrm
 aKV74xjl4N/uGkRNUUWCWtdy2ADEobsGKXgAAneR80/hl2jXtl2iMj/HzBQhld6E3eQWvc6m
 gdgyN+Dkoz7S0HG5WS8QUrwOY31Qk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 11/15] drivers/net/experimental/e1000: Use fallthrough
Date: Mon,  4 Jul 2022 15:08:31 +0200
Message-Id: <f96fbcc5626cd00e69a8ff0010bad1dc3a774950.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool3: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-202207041308370d1063327f9acc05ca-LX8_Qn@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b="VSX/QH2X";
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202207041308370d1063327f9acc05ca-LX8_Qn@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-202207041308370d1063327f9acc05ca-LX8_Qn@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c | 2 +-
 kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c
index 5c4fec0cb9..6e6e1f085a 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c
@@ -91,7 +91,7 @@ static s32 e1000_init_phy_params_82540(struct e1000_hw *hw)
 	case e1000_82546_rev_3:
 		if (phy->id == M88E1011_I_PHY_ID)
 			break;
-		/* Fall Through */
+		fallthrough;
 	default:
 		ret_val = -E1000_ERR_PHY;
 		goto out;
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c
index ab43f4990c..af32a34d04 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c
@@ -200,7 +200,7 @@ static s32 e1000_init_nvm_params_82571(struct e1000_hw *hw)
 			E1000_WRITE_REG(hw, E1000_EECD, eecd);
 			break;
 		}
-		/* Fall Through */
+		fallthrough;
 	default:
 		nvm->type	= e1000_nvm_eeprom_spi;
 		size = (u16)((eecd & E1000_EECD_SIZE_EX_MASK) >>
-- 
2.35.3

