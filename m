Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429563D8
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694093056; x=1725629056;
  h=from:to:subject:date:message-id;
  bh=SIdSSYNTwrxCZP6rYZpRXZFDO5xHiwUxxgh63hZkcVM=;
  b=c5IXz1Nuu0QrvVLiIlVBfkGmlE9sZETRs9CQ2dAn8IhrLKRuSeiNy9eP
   AUNSLFLxkujMjU+ylEJTuGz6STx7R0bs3qIuSl8q4quqjX6f7ANytzslE
   BRDrSDTKXMTOLh2acXp1hOiDDDfXTzaoHODJ6hzAzPLwZGozZCAdLBdRa
   tokrC2Hd4vTsiBTrRhTVp4k8GBlVapY6z3Vuzoyrl3vEUtdaP4f5WhmaQ
   WV+YrUR3jG0rj2eJPWgihv/D37MuvQWgaYbF5Ct41U4zg8XsFe2rPE0Th
   j3WBMXoVxl43psaMLYaiHIa7726dBBGqeAZu9R6iR/Zh2yxnaTqTO1UJu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357664605"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357664605"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735496171"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735496171"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:24:09 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Subject: [PATCH] pipeline: irq: ack the irq when it is postponed inband irq from outside of the pipeline entry path.
Date: Thu,  7 Sep 2023 08:56:23 -0400
Message-Id: <20230907125623.12266-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

1. To avoid double ack for the interrupt that already acked in
   pipeline entry path, we add new flag to note such status and
   differentiate.
2. For postponed stacked edge irq that is handling outside of the
   pipeline entry path, as discussed in [1], ack the irq directly
   because it would never be acked in the pipeline entry path.

[1]: https://lore.kernel.org/xenomai/BY5PR11MB4276FEFA2C6D88C4B6CFFEFCF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com/T/#t

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6aca6c036ada..b8d8aba38e17 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -862,15 +862,25 @@ void handle_edge_irq(struct irq_desc *desc)
 	if (on_pipeline_entry()) {
 		chip->irq_ack(&desc->irq_data);
 		desc->istate |= IRQS_EDGE;
-		handle_oob_irq(desc);
+		if (!handle_oob_irq(desc)) {
+
+			/* For inband irq, we tag acked status
+			 * to avoid double ack
+			 */
+			if (!oob_stage_present() || !irq_settings_is_oob(desc))
+				desc->istate |= IRQS_ACK;
+		}
+
 		goto out_unlock;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
 
 	/* Start handling the irq */
-	if (!irqs_pipelined())
+	if (!(desc->istate & IRQS_ACK))
 		chip->irq_ack(&desc->irq_data);
+	else
+		desc->istate &= ~IRQS_ACK;
 
 	do {
 		if (unlikely(!desc->action)) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a9121f6e6f1c..1b43467b5407 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -54,6 +54,7 @@ enum {
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
  * IRQS_EDGE			- irq line received an edge event
+ * IRQS_ACK			- acked irq line
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -68,6 +69,7 @@ enum {
 	IRQS_NMI		= 0x00002000,
 	IRQS_SYSFS		= 0x00004000,
 	IRQS_EDGE		= 0x00008000,
+	IRQS_ACK		= 0x00010000,
 };
 
 #include "debug.h"
-- 
2.17.1

