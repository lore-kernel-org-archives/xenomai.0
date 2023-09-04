Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEB2100
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824805; x=1725360805;
  h=from:to:subject:date:message-id:in-reply-to:references;
  bh=JnfOsZbYXtdjsaPKdnMFnJ+ajbzmKJFUcl5CdmUryZk=;
  b=VcB7rs05UhPCrHw2dTKH+y1RBDvFzkPmhhOjdenxfUN140IKDUr6ADd4
   MGz2lhvY7UDl4Z/8setEgcoT/AXaaOgWDg5X5z5TaW7QL54qHiv1JChXX
   tYhHQV7YMaZPkT0ZADPVMmYp3bSy2TlRzgtZW87kB6PXeL3JE7E72rxry
   O0ss6TIarVL/dDNBcekQY7SepbQAhHg3cHpoqmNJg6YW9pesdhy8bNK/S
   WMw8DCNGIJVk0wEOv39RAw+Gt9Yf5Ukx9ZY8Zc7OJ8i6PxoTYmdu2UFeY
   20OsVedo6K9w1DBcZlKAK5BhSBQE3wPE8EZat48I/0eA8HxZJn87nKqLb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="373962347"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="373962347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914470894"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914470894"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:21 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 2/2] pinctrl: intel: irq_pipeline: enable pipelined interrupt control for pinctrl-baytrail
Date: Mon,  4 Sep 2023 06:25:33 -0400
Message-Id: <20230904102533.22448-2-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904102533.22448-1-hongzhan.chen@intel.com>
References: <20230904102533.22448-1-hongzhan.chen@intel.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

This is required to run the locking code from the pipeline
entry context and the out-of-band stage.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 394a421a19d5..6fae9ab9d913 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -538,7 +538,7 @@ static const struct intel_pinctrl_soc_data *byt_soc_data[] = {
 	NULL
 };
 
-static DEFINE_RAW_SPINLOCK(byt_lock);
+static DEFINE_HARD_SPINLOCK(byt_lock);
 
 static struct intel_community *byt_get_community(struct intel_pinctrl *vg,
 						 unsigned int pin)
@@ -1580,7 +1580,8 @@ static int byt_gpio_probe(struct intel_pinctrl *vg)
 		vg->irqchip.irq_mask = byt_irq_mask,
 		vg->irqchip.irq_unmask = byt_irq_unmask,
 		vg->irqchip.irq_set_type = byt_irq_type,
-		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE,
+		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE |
+			IRQCHIP_PIPELINE_SAFE,
 
 		girq = &gc->irq;
 		girq->chip = &vg->irqchip;
-- 
2.17.1

