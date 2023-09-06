Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B562B
	for <xenomai@lists.linux.dev>; Wed,  6 Sep 2023 02:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693966145; x=1725502145;
  h=from:to:subject:date:message-id;
  bh=ElylLLy5ZhhvNpqrrukYw6Wn7IdY8HR2YAYyG2nykZM=;
  b=M3lFOAaVAedO8CG0xwXLM/67JaNQ1A2Kxth0XAygDmQa87EU/a1sX0ia
   6f04asAbe+lcRnUSA/L1lnLreZ/aRncmfHS5QoS2+EQ9/fpiEpeZkJb8g
   updSvRIcnz9zEG3RKZ8Yt2yCFDf/hYUgoVqMik5qL3rmt4m07Nv+72mvV
   /O+a7ukFzLX+bec0aydUPSmRqIiO2T+whWUCTqNOyKK98W4YXTJ86izyy
   W7Km6ol7YgmErGV6Xb7AfpYgritjMtdqTJRToIDm60rz1EdrEYWYMnL+5
   xJqD3XXpmWC3gOoyKZPLq/yg4fXokrjU1Od5v8ktUymvycnAkV1NseDIO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443341319"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443341319"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831458300"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="831458300"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:09:03 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH] pipeline: irq: ack the irq when it is postponed inband irq from outside of the pipeline entry path.
Date: Tue,  5 Sep 2023 21:41:13 -0400
Message-Id: <20230906014113.28637-1-hongzhan.chen@intel.com>
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
index 6aca6c036ada..7280a338bd3e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -863,14 +863,23 @@ void handle_edge_irq(struct irq_desc *desc)
 		chip->irq_ack(&desc->irq_data);
 		desc->istate |= IRQS_EDGE;
 		handle_oob_irq(desc);
+
+		/* For inband irq, we tag acked status
+		 * to avoid double ack
+		 */
+		if (!irq_settings_is_oob(desc))
+			desc->istate |= IRQS_ACK;
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

