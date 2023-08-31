Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9619BCE
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:48 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202308312037457f66dcd6ef5204bd1f
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/yk5tkvS8hNK5wSPnqi0VCCmmsWuzVjb1OMWsNI7jQA=;
 b=BrY3iBwW295Y3C9GImmctubCmhcQTIxYQmS97KNJIaOVWBHTc/0u4QlnmuPAhRbBCf5Jpr
 D5fMuupPA/I1nRqshzciioZCWqsBDqba5qfIlm7UlxI48pUcfWJm3u6m5adtHxF1Rd+plpkt
 dYyLR5qgUU3quFhSgu8wllVg6VIKM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:36 +0200
Subject: [PATCH stable/v3.2.x 10/19] drivers/net/experimental/e1000: Use
 fallthrough
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-10-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit b0c1f8afbfdb84c88579e99a53a9f3632477b289 ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c | 2 +-
 kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c
index 5c4fec0cb..6e6e1f085 100644
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
index ab43f4990..af32a34d0 100644
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
2.39.2

