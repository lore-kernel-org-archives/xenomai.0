Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AB20FD
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824803; x=1725360803;
  h=from:to:subject:date:message-id;
  bh=DnG9M0oTtMSYFdvcqDanUUeXs88PbIi3onNvysLn5cs=;
  b=XKXw+RhmB1rOIAFr7zGih+9Oy+vonR/Nk72Z7MDwh8a/MLYHnoCYd1Hw
   d9C1uE1YRsRxjYJEdmkK8PA6DnvAPKCd3dBsMnQAxcvzlhekQjT4/cxDv
   kXD+TNd3lEDIb0Nz50qTqEpwOZ0h2R0bt2jr81mVTmGC8viS6wrTz8iUT
   dhm2MOCDgTnbhByTRypAm+A6RuETtz1lZaQZK3bF4F0Fbaj4oKNixHrGl
   HvMSY2X0HNFIw8ioGWsQLcdznCyGSNasJYH4XKoyBNzCcvm7PsPOIesrC
   VnGOqbrIbisN05O2+qqSW+ZLezJBCcH6X7H3CFvxEqBp0YbwpoHdIIDIc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="373962346"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="373962346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914470869"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914470869"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:20 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 1/2] pinctrl: intel: irq_pipeline: enable pipelined interrupt control for pintctrl-intel
Date: Mon,  4 Sep 2023 06:25:32 -0400
Message-Id: <20230904102533.22448-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

This is required to run the locking code from the pipeline
entry context and the out-of-band stage.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 2ef9e2d8fd9c..7797618a899b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1322,7 +1322,8 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	pctrl->irqchip.irq_unmask = intel_gpio_irq_unmask;
 	pctrl->irqchip.irq_set_type = intel_gpio_irq_type;
 	pctrl->irqchip.irq_set_wake = intel_gpio_irq_wake;
-	pctrl->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;
+	pctrl->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND |
+			IRQCHIP_PIPELINE_SAFE;
 
 	/*
 	 * On some platforms several GPIO controllers share the same interrupt
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index ad34b7a3f6ed..89ef4e37511f 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -228,7 +228,7 @@ struct intel_pinctrl_context {
  */
 struct intel_pinctrl {
 	struct device *dev;
-	raw_spinlock_t lock;
+	hard_spinlock_t lock;
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct gpio_chip chip;
-- 
2.17.1

