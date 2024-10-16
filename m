Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F210194
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103730; cv=none; b=ChkcezNmUgwbylumjGUS8XyDONdndY++3CxGaPaXtSKoFCQQw3ZkRjDEdSSPUKchPmtTjkpy2SMsomWLO0wb2sOWyKwPxlUs5dz9wASzdDdNvzaww0R6wmIJw/YIzc1PGsz/87FkSYaM9Q1E3Nf9thi/nEjChRijScpnwjZYEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103730; c=relaxed/simple;
	bh=rwdIo+SCb15aqQoDaWpOM4V1olyjtAHR4H0raQIeGRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4vXofpeDgDn8Ia2KGOZ/SIu+oekkdmfv919dNhJtAud45sfxR1wSM1iNhIh3vkDwLQme3MEPwYapOJ6VUk6Wq5IqCPsvEPcku317Ha0SSTddnyp+aRDQXAwk5Ji9NPgkse5wkirYlDp4PYGXDvvLpjMF21VjG67F1q/XyhpLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDGGRwkD; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDGGRwkD"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e91ae607aso4716b3a.3
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103725; x=1729708525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB7Cld3M7v5MG5I2FMXeVkwg41HLIivVn/iBiHWljOo=;
        b=bDGGRwkDCp0zjAtFexOY7hiKBNDIdGblYIv+5SmCKBFxTXjP9wdhi+alSuVAZs5vw1
         9qez2xyKLT6+y5ltY5bI/jqmKLmPqAOhBSeofQ8DCWNfXa/FZIfZLBcpnNGIXKi5G0DF
         HL7E0RROWzHboJxf+0LnH7BsenXSUnXO3PiomwSoh8qEw//9HvrcO/2PVxD5H3FqzJi1
         4nSLIIHEgESwPIC8mLvWnl/jTKY3KC9WlrcqQcCaISct8wFLUQVkcydYOGOcumsA3Uo0
         ZyZR1hRaLqjULt4V6fl4ixpGZMsjuzONTSa8jEagHVwNvbH8YHFqtD7F7YPiMMlOqsps
         LwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103725; x=1729708525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB7Cld3M7v5MG5I2FMXeVkwg41HLIivVn/iBiHWljOo=;
        b=Ranrc4/472AuMPJxLry0suZNe2k2VIyU9zyZP2ZziDBzgtyBB2zK/Oa0qsfRJ9xyYH
         CtIkmd5cVRO7uBXTKKDyIJr0CVzqmkR2zQt5Nq8h/iEDSttkLNPPxv1lwzHfUV804s/0
         NCsXcgMf4BjWRl3ceARSzVVQs8KRLYjuYyV1/3oH8L7nt25Z9EKG24nAuDg1cDFTKFq7
         O9lVVJ0dwjcVYNgfJu2OvB/ph+pGmXtktxQ2ud5v76fSqugjHH1UqavAIPVjWDqxlQjQ
         5a6UPL/yYuJGNAS0kLnZtNffhNNqWeAwdfG/T4cE3+PbMRm7YFSfULUf4Sgu/MKsGUIY
         KdSg==
X-Gm-Message-State: AOJu0YxnDSE5UX2/RzPjmdEmiChUM5sK7BCM2Z2O04xM3srnG5AVNd0V
	RPb2ftqga4v5SY9n5uYtzxfVBCIwM2RDc8oZu2DET42QDckII0PaavH9BG+xTQtR9efK
X-Google-Smtp-Source: AGHT+IEHFRmGwmcWra2gZFLuVKcBx86s//bPPNUhSLQT7sJ5WEKUFvSNIroldcI2lRu8SjPKc8rEUA==
X-Received: by 2002:a05:6a00:1898:b0:71e:66b:c7eb with SMTP id d2e1a72fcca58-71e4c1d894cmr27364294b3a.23.1729103724968;
        Wed, 16 Oct 2024 11:35:24 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773a3030sm3397846b3a.67.2024.10.16.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:24 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 4/6] dovetail: Add place holders for smp/ipi related functions
Date: Thu, 17 Oct 2024 02:35:03 +0800
Message-ID: <20241016183505.738682-5-lz5333885@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016183505.738682-1-lz5333885@gmail.com>
References: <20241016183505.738682-1-lz5333885@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipi interrupts in loongarch is a bit triky when dovetail needs irq_desc
for each oob ipi. Loongarch multiplex ipi through a iocsr register, which
is similar to arm64's way to multiplex ipi through a PER_CPU veriable.
The only problem is that there is only one irq_desc for ipi in Loongarch,
and there is no way to let oob irq use the rest of the irq_desc. So one
way is to multiplex all inband/oob ipi through iocsr register. But I
didn't implement this yet.

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 arch/loongarch/kernel/smp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ef35c871244f..fb2113688842 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -698,3 +698,26 @@ void flush_tlb_one(unsigned long vaddr)
 	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
 }
 EXPORT_SYMBOL(flush_tlb_one);
+
+// FIXME: ipi irq handling
+// not doing any thing yet
+
+int ipi_irq_base __read_mostly = 12;
+static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+}
+
+void irq_send_oob_ipi(unsigned int irq,
+		const struct cpumask *cpumask)
+{
+	unsigned int sgi = irq - ipi_irq_base;
+
+	/**if (WARN_ON(irq_pipeline_debug() &&*/
+	/**      (sgi < OOB_IPI_OFFSET ||*/
+	/**       sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))*/
+	/**  return;*/
+
+	/* Out-of-band IPI (SGI1-2). */
+	__smp_cross_call(cpumask, sgi);
+}
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
-- 
2.47.0

