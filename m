Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAF20E02D
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103734; cv=none; b=N3QKqRZrYf6hugjOtmTCouXYP3nw2GMIRQkEMLSdlNR4E1T4rK2mBqAhMpiNfJSPOBaFgq6vX7RykkRhtVMM0KP+FtqsYB7uxY/MKmuYjOPD7lHn9o1aDhFqW2SbOpSVSSvOPXX5BycX8sGtA+Oyye1AFtN1ER5sYG91JXE2z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103734; c=relaxed/simple;
	bh=iaxS+dtmCgyFSRqvXhlXpeIFtBfbdEYQmw7Jzr8l2Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPt6gLE+qmIktgIV8crA+ZR2DYBjIofdyzhg1jIFzRWUN85zokWWb9UYfrmbY1aKGYbfowFwOu1lMVDKTJMGMYUzub5PoAMi0xYnUUauF7dNU38sKLEwxYf2mqtHL9h9p4XnTiarE1JlC2h3jOwhIHMmCUNXucfIa305JnQ91SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NExWh/sN; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NExWh/sN"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so73550b3a.0
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103732; x=1729708532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/cKWq/SYaTbNvaiPjXQFJPpS0FuZuzYBTc6IURdiq0=;
        b=NExWh/sN7XfgHgC6nqSHJSuMRGri1Gww81KCF4By+Pag5yvN1/LOywj/AEcfCgtZM1
         wFkZyHoHk/z+6IVItx6OUucG8ZvCKssXPHn/I8jr3d+GAP5qTdcU6HwtpHM9aLk358XK
         AD8nrW8YPN68b+NiV290ee2gjZhT5VYdBcDgj0Joef6yddRig37ZQIpy9atJ2j1TCwAV
         b3xOQSFRpnzmsfmTsTOC9AyTYWELlst692vvM8+/M/6hlaw5eDZ3K9FhmtbCkvfUINQS
         r4OYPDLwI90GUS3WU20p7Zqv1PxLGsA7KL16aUdVoSzk7+lV5IiZ5gB3xrKEUA13qhI+
         vk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103732; x=1729708532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/cKWq/SYaTbNvaiPjXQFJPpS0FuZuzYBTc6IURdiq0=;
        b=TtP46lz8IOvboNn5dTZmUAd4wdGmf4J6hnYUmay2diZxZ8mk1OqSMtFc05U7QF9MS7
         Lnip9H6XFUngticiTJTJfBhqAj4pwT3XYeu5v/YW6EefD8XhqnNk2RAF2FyEnKRH6tU3
         4n/eZjh6ZMlt3DMF1ZPtXpZJMW72jUF2fIvNxx596kIU9iH5FlD9a7JtW0VZNwG1cGFb
         SYB1T1Ul0PQK1xRKtb0vb1YzgP4jIK9EqzfY7Ux0YHMlgmyRG9Xh+qxbgrcHGlkqY8OJ
         orzzjuCrw6rGGztUIBsdq4833lluEElRP11U6l1wu9l9j6oemkcEas0lUHFJMof+Wruu
         Qnrg==
X-Gm-Message-State: AOJu0YxkkJ9L6btUWYdVLixViZch7VtQmgQDURodhNwnCSzIiv4OfBH9
	UK1kY/inEGCmc8z/ajsqeWC40oRzH8HfHZ3LrDFQlOEnZdtJrPG+UEg9icscUiNmTiNF
X-Google-Smtp-Source: AGHT+IHgyI1xLKTDgeERlf0rO78rMHTTW0YVPjxaWuqZL8VzYDBzyt8pL2cjUXBuQICuZtNAwDBkTg==
X-Received: by 2002:a05:6a00:23d1:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-71e4c13939bmr23159214b3a.2.1729103731843;
        Wed, 16 Oct 2024 11:35:31 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773b163fsm3402690b3a.87.2024.10.16.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:31 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 6/6] dovetail: Add more irq-chip support
Date: Thu, 17 Oct 2024 02:35:05 +0800
Message-ID: <20241016183505.738682-7-lz5333885@gmail.com>
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

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 drivers/irqchip/irq-loongarch-cpu.c    | 1 +
 drivers/irqchip/irq-loongson-pch-lpc.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c406043..411f93bba480 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -65,6 +65,7 @@ static struct irq_chip cpu_irq_controller = {
 	.name		= "CPUINTC",
 	.irq_mask	= mask_loongarch_irq,
 	.irq_unmask	= unmask_loongarch_irq,
+	.flags      = IRQCHIP_PIPELINE_SAFE,
 };
 
 static void handle_cpu_irq(struct pt_regs *regs)
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
index 9b35492fb6be..fc11be962186 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -97,7 +97,7 @@ static const struct irq_chip pch_lpc_irq_chip = {
 	.irq_unmask		= lpc_irq_unmask,
 	.irq_ack		= lpc_irq_ack,
 	.irq_set_type		= lpc_irq_set_type,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 static void lpc_irq_dispatch(struct irq_desc *desc)
-- 
2.47.0

