Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A43140E34
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947886; cv=none; b=KsJ1h4xBxTzz3JesBrD6EKzQ3w82EJcmp2BIeEQMYMWWDOWUWP7NqXdvgJKQv9emMndoESuyd/Qi8YgYPnvIfa4V1Ww3QYVPL6eCj/+C2yD8Iz/Vcefh4VjVZDOO8bHRjkzMxfPSqe4gyZnjfObSnGPohl0lhFKlPGhvO7dx59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947886; c=relaxed/simple;
	bh=54bhTOPZewH+V+AbEefFphN5E5nbE3iB4yY1HnqO3Lg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UghOoQ5xx0I+6V69OUTVZoyGoW+Onr+52mTZIeNyLIBVkdVKa+vylFtnjIMaW/+94F299itAcIRfHxOZV58Mr4ZZwboSqG5ShpTvDEfNx3uznndSscukwWUcbJ4VP5L9G6TH5RbUgYZmn+t9N40FeZVZleIGuaiHytK1uBv+NMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MD6tlvOQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MD6tlvOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716947884; x=1748483884;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=54bhTOPZewH+V+AbEefFphN5E5nbE3iB4yY1HnqO3Lg=;
  b=MD6tlvOQUdG48yqf0vUzt9pptRMHdC5TpKEglz6J7Tli2/IP1Ylvpim8
   sYi3U+pNg/xHGZ8ksYzqQL8sQm3BWZqTf4MaFMhbBUvleeEGyjWXT+LP8
   574tfKnEihyDOJsdSQJr4Z4AovoBMwfqIvn+WMm2ciYn6IU7mLU294BFQ
   aD44T694DFu6FBlULum1N3pgiUKha7V/LS1+NLDvMX8d6Hzvmv7Z8swBo
   2gPnW69c6/7CAiYzSZ48fNLKK+JnU9517hejb1/Cr5UFsya/GDeTY03tt
   KuR0qEThElvAW/y1SUT48OncSjMCuQxXNF1zI3ccD2tv6AJJS0Xonlwyw
   w==;
X-CSE-ConnectionGUID: +A7hVoXUQ2CXgiYTmHsnUQ==
X-CSE-MsgGUID: iYW8a1p9R8eACF0/DoUDxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24741933"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="24741933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:58:04 -0700
X-CSE-ConnectionGUID: kJwI4wQsRZC4mOib/9qcNw==
X-CSE-MsgGUID: A8KbuGJKRnW99JQeGAC9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35244245"
Received: from intel-optiplex-7090.sh.intel.com ([10.67.107.94])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:58:03 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH] drivers:igc: fail to init phy
Date: Wed, 29 May 2024 09:57:42 +0800
Message-Id: <20240529015742.603110-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merge commit 170110adbecc1c603baa57246c15d38ef1faa0fa:
Author: Sasha Neftin <sasha.neftin@intel.com>
igc: Remove _I_PHY_ID checking
i225 devices have only one PHY vendor. There is no point checking
I_PHY_ID during the link establishment and auto-negotiation process.
This patch comes to clean up these pointless checkings.

and commit fc7116a79a86500e15520658f279b6536ff9f700:
Author: Sasha Neftin <sasha.neftin@intel.com>
igc: Fix BUG: scheduling while atomic
Replace usleep_range() method with udelay() method to allow atomic contexts
in low-level MDIO access functions

and commit c9cfcdd111d7f82831ec9f205f4370427739b9d5
Author: Corinna Vinschen <vinschen@redhat.com>
igc: igc_read_phy_reg_gpy: drop premature return
igc_read_phy_reg_gpy checks the return value from igc_read_phy_reg_mdic
and if it's not 0, returns immediately. By doing this, it leaves the HW
semaphore in the acquired state.

and commit d4706de93cf7c766df288501b141bcb9fd9b3ee4
Author: Corinna Vinschen <vinschen@redhat.com>
igc: igc_write_phy_reg_gpy: drop premature return

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/kernel/drivers/net/drivers/igc/igc_base.c b/kernel/drivers/net/drivers/igc/igc_base.c
index fd37d2c20..7f3523f0d 100644
--- a/kernel/drivers/net/drivers/igc/igc_base.c
+++ b/kernel/drivers/net/drivers/igc/igc_base.c
@@ -187,15 +187,7 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 
 	igc_check_for_copper_link(hw);
 
-	/* Verify phy id and set remaining function pointers */
-	switch (phy->id) {
-	case I225_I_PHY_ID:
-		phy->type	= igc_phy_i225;
-		break;
-	default:
-		ret_val = -IGC_ERR_PHY;
-		goto out;
-	}
+	phy->type = igc_phy_i225;
 
 out:
 	return ret_val;
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index fcd08335f..60c59d991 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -2880,8 +2880,7 @@ bool igc_has_link(struct igc_adapter *adapter)
 		break;
 	}
 
-	if (hw->mac.type == igc_i225 &&
-	    hw->phy.id == I225_I_PHY_ID) {
+	if (hw->mac.type == igc_i225) {
 		if (!rtnetif_carrier_ok(adapter->netdev)) {
 			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
 		} else if (!(adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)) {
diff --git a/kernel/drivers/net/drivers/igc/igc_phy.c b/kernel/drivers/net/drivers/igc/igc_phy.c
index 8e1799508..3a103406e 100644
--- a/kernel/drivers/net/drivers/igc/igc_phy.c
+++ b/kernel/drivers/net/drivers/igc/igc_phy.c
@@ -249,8 +249,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
 			return ret_val;
 	}
 
-	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
-	    hw->phy.id == I225_I_PHY_ID) {
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL) {
 		/* Read the MULTI GBT AN Control Register - reg 7.32 */
 		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
 					    MMD_DEVADDR_SHIFT) |
@@ -390,8 +389,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
 		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
 					     mii_1000t_ctrl_reg);
 
-	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
-	    hw->phy.id == I225_I_PHY_ID)
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL)
 		ret_val = phy->ops.write_reg(hw,
 					     (STANDARD_AN_REG_MASK <<
 					     MMD_DEVADDR_SHIFT) |
@@ -583,7 +581,7 @@ static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
 	 * the lower time out
 	 */
 	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
-		usleep_range(500, 1000);
+		udelay(50);
 		mdic = rd32(IGC_MDIC);
 		if (mdic & IGC_MDIC_READY)
 			break;
@@ -640,7 +638,7 @@ static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
 	 * the lower time out
 	 */
 	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
-		usleep_range(500, 1000);
+		udelay(50);
 		mdic = rd32(IGC_MDIC);
 		if (mdic & IGC_MDIC_READY)
 			break;
@@ -748,8 +746,6 @@ s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
 		if (ret_val)
 			return ret_val;
 		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
@@ -781,8 +777,6 @@ s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
 		if (ret_val)
 			return ret_val;
 		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
-- 
2.34.1

