Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25002101AE
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805561; cv=none; b=RjdIeYUjYdylKhDoTCjLDZnncpqZ+pi1gGpXCsgWsrMAEwy24oQOPDwR+cW8B1x/smkdkNgHn95cCqcc4Vf0ELrqIG9wMcHh/R0VUGSEdGpqJ3Yd85GtdJjo9oUdR1O4shTV6IdChSVVnyAafjrZb/VOO6aZSQP8UY5DAulcQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805561; c=relaxed/simple;
	bh=Ng8FhSBCqbH4Oci6PRPPm2jyvEYH2IauQZkB1JdZSTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwXuU3DLyc6O9NJz6inEcKv/NJokx6aZWT6siAaRECGs7Vxz+7rWYMsluYYskbDQU4NZQNY4AUD936ZB2T95jtB9mkYBWLJRVjGOiPcwE69j5JHG67R+EcqRAbSVRI0xKZY4lsjEX0Qe1LDI6napYy+pQNIMmxfiaWpETXOQ3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IA9N6gpT; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IA9N6gpT"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509251305517e5ca590fe000207e4
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HkYuG2GCRL1sLlCyI6JWye81on4viDKVEH2VZR/hLp4=;
 b=IA9N6gpT3Q16+nM6AiChHQKIBGtBSTSEBhoDoFKJZOmY8arH1Ck4hnELIXIrKw7jYMrJSk
 hVLsFbdNg+G+p5S31qCX66OQBiMaEveiJERCXCi/1mlRBVS01o6DEpfUB7KicFXvmDg4jeKx
 WRsVh39yqpCPp/MeMZtL54VekeoHUjDwFsXE1DBjQOlcGayRSF8lG8VxYFlgeg3DJ5JMSCT5
 rAVeHddazYlyQtRXzdTp8USP6SDE0aocZG9W/bU1ufMp4Isx+Z9zzDqXZx3sBEZm23Ux4qwz
 6xDXcCDc2ppXFpQr4/kYyJ98h5ZO5JCjwXNbP34LZ9CJnptrVNAMEFzw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 25 Sep 2025 15:05:51 +0200
Subject: [PATCH RFC Dovetail 6.16 5/5] kernel/irq/chip: Do not call low
 level irq chip hooks directly
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

irq_mask() and irq_unmask() are tracking a software IRQ state that
might run out of sync when bypassing them.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f18f513e20c7d..280f1526f0f8f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1125,8 +1125,8 @@ void handle_percpu_irq(struct irq_desc *desc)
 			handled = handle_oob_irq(desc);
 			if (chip->irq_eoi)
 				chip->irq_eoi(&desc->irq_data);
-			if (!handled && chip->irq_mask)
-				chip->irq_mask(&desc->irq_data);
+			if (!handled)
+				mask_irq(desc);
 		} else if (flow == IRQ_FLOW_FORWARD) {
 			handle_irq_event_percpu(desc);
 		} else {
@@ -1137,11 +1137,9 @@ void handle_percpu_irq(struct irq_desc *desc)
 			 * off, which is not the case on replay of
 			 * unserialized percpu irqs: fix this up.
 			 */
-			if (chip->irq_unmask) {
-				flags = hard_cond_local_irq_save();
-				chip->irq_unmask(&desc->irq_data);
-				hard_cond_local_irq_restore(flags);
-			}
+			flags = hard_cond_local_irq_save();
+			unmask_irq(desc);
+			hard_cond_local_irq_restore(flags);
 		}
 		return;
 	}
@@ -1190,8 +1188,8 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 			handled = handle_oob_irq(desc);
 			if (chip->irq_eoi)
 				chip->irq_eoi(&desc->irq_data);
-			if (!handled && chip->irq_mask)
-				chip->irq_mask(&desc->irq_data);
+			if (!handled)
+				mask_irq(desc);
 			return;
 		} else if (flow == IRQ_FLOW_FORWARD) {
 			handle_irq_event_percpu(desc);
@@ -1229,8 +1227,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		 * percpu irqs: fix this up.
 		 */
 		flags = hard_cond_local_irq_save();
-		if (chip->irq_unmask)
-			chip->irq_unmask(&desc->irq_data);
+		unmask_irq(desc);
 		hard_cond_local_irq_restore(flags);
 	} else if (chip->irq_eoi) {
 		chip->irq_eoi(&desc->irq_data);

-- 
2.39.5

