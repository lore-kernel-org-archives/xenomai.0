Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463926158C
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268736; cv=none; b=cDg85yo9GNWanFojr9ig27iWAni+x4bKLt77edJIA8kOTzy9eb+jCvE4rvdSGpTBR1dpv4L02f5ihGJvm9uQhk6AMjCZuZBgGR8y9TNdAjOdkH4kj/9Y+r6WOj0AeLx9dqhpmjTccbvLjubx0SmqytY7KUhuu1INfzusBX1cDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268736; c=relaxed/simple;
	bh=XsT4k0XdrweqtNQo9Kjr9HfF1ZiRTdDA1M6Y/1bC8II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXZE/6V2o6EpGAqScvR4Mv/Lyi1lAACdpe6O9oaRlEGVArZ4HBS9F1GY9avcH8WKya8hBblhevhUrleFpSQT4x6qeBCLnhMR2PGDRk8PyHrhhcB34jgF/ktzlxSM/mohRHUm4ZfsC6ENuMiTIGobC2Qj6I721coYK25Yh/MabO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T9OEL/Qy; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T9OEL/Qy"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602161905268f27a2a46d00020700
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 20:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BbWna4nWjAKwrgPsN+Tviw+IHqFL+SJOEzPab7xkEUI=;
 b=T9OEL/QyvJKAzGzUcSfGaAlmRX3pw5KcBeHc99PXQdGJJuWYOPXokguMFelkjLm7G2IJEu
 g2HG64mwXAdX1Cbvd0wvGcChESPrnbA9opGL+DRT2txSSGj2yKMsZgGH2RaTgjL8itu8PL3r
 R4sQBmxjmd0giT9Y6Yll6NhodIDeWevnSM6Mqe8TqjeL8afAJlS1DNyAni/TLb2uLb3C+i8N
 PTLRDfMcqLGiDbK1dnORwfAJ7znxLg4Ot7Vib/b8I53sni5o/1DK5qSefs3cyhIr/HCkqMQf
 govx+JKWQ0Pzq3Gp6S03JepsLctPHYt7HA80VIcb7C02qt1a7VspPfxQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 16 Feb 2026 20:05:25 +0100
Subject: [PATCH Dovetail 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-wip-flo-v6-19-dovetail-rebase-v1-1-5c36863cba17@siemens.com>
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
In-Reply-To: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
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

