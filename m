Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF2C158D
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368879; cv=none; b=nnIGKMwBsmtilgFWvAz3jSZRtD7sw27ITwFH3OaOanENbjYUmi5HlqBNzmnNQ4ZhDXz45gdq/TGOp7IzRvxiED7kta4I17C6yvGm1fo7fKRT1+n+3l/to/oHgmzl075Z8hJ2ejpgX8I3KfTASmRkUK4u2I5JX6kPDeI1w5tB8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368879; c=relaxed/simple;
	bh=XsT4k0XdrweqtNQo9Kjr9HfF1ZiRTdDA1M6Y/1bC8II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJo89jjqYA90qBbHoMzhhlqjSxq5yxr7ZVT2QLmYVQTbnEdOdhQTb145zK//b4PET5HhZ+Na6bac4L3B0cxMC0+4MUyJWLUYjnoNf9hIPvGbjXSXRwJRUV80F+LyqzeLDGf9Tb6y8DbEt2XFavbUu1ocXHE9Fst6+2O4FHRSvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YL2IMV69; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YL2IMV69"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602172254273a7a362c9f00020748
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 23:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BbWna4nWjAKwrgPsN+Tviw+IHqFL+SJOEzPab7xkEUI=;
 b=YL2IMV69AXTDCw2ellZ3odprKJjQRZkLIw46+B99UPm1d0onNd2UhvHeMCNOAbxBTci0qP
 iEEtt5/M1GhKJ842QFkUun1LUCT4oN3s6gOECUVyb+Gyj85N4h7Xj2+F/M4rdycbARMTQkqW
 Zj66bRuQ1zCuLygX7EnKbnQJdl8I2eyk3Z0RN8SJb22vlRkXD9HKKZSvN5tm/ymoel6TCJf2
 DKWRz0LDtRLFTl28XiXRgvOzfypfm/9lRD4pFEHYpEVG/60aJWByaq1QyB/RUP0l6WbSOwwu
 7IGOTuAZPkvLGQt4FPXQ4+/Sj5wHfPEBfwJkMKowBCS94sIygzX/Em9g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 17 Feb 2026 23:54:27 +0100
Subject: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
References: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
In-Reply-To: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

cobalt / evl are currently using __request_percpu_irq() for setting up
OOB IRQs. In 6.19 the signature of __request_percpu_irq() has been
updated and 7.0 will remove the function entirely, so we need a
replacement.

All other variants (like the upcoming request_percpu_irq_affinity())
are missing the flags parameter which we require.

This could be backported to all supported dovetail versions. That
would allow co-kernels to switch to the new API unconditionally.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/linux/interrupt.h |  5 +++++
 kernel/irq/manage.c       | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71869d6737fbc8c1ae477c1ee 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
 				    devname, affinity, percpu_dev_id);
 }
 
+int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_t handler,
+				      unsigned long flags, const char *devname,
+				      const cpumask_t *affinity,
+				      void __percpu *dev_id);
+
 extern int __must_check
 request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *name,
 		   const struct cpumask *affinity, void __percpu *dev_id);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2a2991d529e4e21e88b8f15fcd51cdb01b69411c..b2290c7ba087e4e9a4b9e94163be1f45631d7c3f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2580,6 +2580,16 @@ struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long f
 	return action;
 }
 
+int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_t handler,
+				      unsigned long flags, const char *devname,
+				      const cpumask_t *affinity,
+				      void __percpu *dev_id)
+{
+	return __request_percpu_irq(irq, handler, flags, devname, affinity,
+				    dev_id);
+}
+EXPORT_SYMBOL_GPL(request_percpu_irq_affinity_flags);
+
 /**
  * __request_percpu_irq - allocate a percpu interrupt line
  * @irq:	Interrupt line to allocate

-- 
2.53.0

