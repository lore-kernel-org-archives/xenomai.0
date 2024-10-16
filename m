Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01612144A8
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103724; cv=none; b=hHykDa6uWLGDA2dvrfFuXvtk3jDB6gPkttC5qkkKwChzFfyLlERyBkFl6DeN/H6aJ2n4SZWJCX4po/xxV7kIyKQBIc8ptJkmmjJ/crWDQ0diZvhQ85B9c46kX6lZSUb05o5V8UALp3APFT7r3Q9Ifd8kVVkorwWflK+jNHc+TvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103724; c=relaxed/simple;
	bh=HdC4sXQETTJ2Dtbecb08gN+Neyhh+31wRDxLwyyxu38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcS5FNS9MYkyG9PDt/RWm0ZD4SDv7baERy24D5lDeVf22YCuE4817ZD0BeQoS12eEf+Evtes5iVJ9lgEeT5JcAxRnafItJv41tws92REscqX1oMBr5YycPHJKcJkGg5XvpHS/2J6H07gfRQwZI5BvnSdq4dsNpExO9LgXGAFXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9FVp4jM; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9FVp4jM"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cf6eea3c0so1270115ad.0
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103722; x=1729708522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vyqIDwl+M362QbayPKrXOileRmVG6cygdwZzkRt2tQ=;
        b=g9FVp4jMDywADeQqognrQVT9kh1TB4MWpttSMW4xJ42nkboa/PZ/OZ375P4tiKrhsa
         qXnYFu3II3t1Zyt6fTVZ1fdeNR9Q0F+iiO1mGiLZQ0UdoQU+sE3bOnU7OI3zjrQuu2Ed
         YYiKLLjk72iDoGYtULg9wHo+bYRI15O/G5tKPFyTKRIgmo2L576xNJk+B7o9lxJQyorY
         QqSTE2ScvhM8mrOvdMHIp9Ej4gs4ut2n69U4Jt17EOeFCD1NYac42yRzMeG/swTllir0
         5EJMbWzE0gkmECVbaJNkyHl+u4+lsUZD9QPpgaUKYMGLrXjcIfcOAI0HZ0Q6xTFUQh58
         xnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103722; x=1729708522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vyqIDwl+M362QbayPKrXOileRmVG6cygdwZzkRt2tQ=;
        b=jNPMqkUAnmsaxoaSn1KGBA1tDaa6QkW91fHdKbAtNDb3BKHsIm+i4YP+QqReKdLyyS
         aymGANmnAq3/GoIsc3jiHPWPCcrobXCBcSJnchziq3s/XnEYlc3lWDxlNeEKbHCEXacs
         D5xxOi0sOLnnCIdAPjFbZKGo+dilZ71YQJwS4mDD+bbLnv5eIx0Lo6jlCdUPMHukmIuh
         yDwfDBsWj9Cu9uHgFsI2TG03WwTxbMgeKukoAYYbXCji4yDbSx1fsZqMqeUrhWA6Zk7E
         E68d4kdaSsfj+6Swc0cAkgmcqMIdVTuZEXOTop2D4uA1vwF0MiT1ohrlnUuzh2PsTLuC
         bKTw==
X-Gm-Message-State: AOJu0YwBpG7c7UHqHyo9Qjah2tauCHHEp+DxDEAKRwyhSDTpXdSAdS5v
	9jsZWDNhuiO267mtmanJLCh0lM0WpSIiSGBzivCgy5MD/YVnRBtUpV5qa+vyP7fMA+Qm
X-Google-Smtp-Source: AGHT+IF2V9nQNr2c4zh/nD+Y/jRIM2jvJi/PbS5BTqlzFOCfHUvD4+4XnImC9LG7y5xHr3U2euhWjw==
X-Received: by 2002:a17:902:fc8e:b0:20c:e8df:2516 with SMTP id d9443c01a7336-20d27f1cbb0mr62215785ad.42.1729103721934;
        Wed, 16 Oct 2024 11:35:21 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f8892fsm31833355ad.5.2024.10.16.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:21 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 3/6] dovetail: Adapt Loongarch's clocksource
Date: Thu, 17 Oct 2024 02:35:02 +0800
Message-ID: <20241016183505.738682-4-lz5333885@gmail.com>
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

1. Adapting clock chip devices for proxying.

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 arch/loongarch/kernel/time.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index a03b62aae83c..c320e7e7489b 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -37,7 +37,7 @@ static irqreturn_t constant_timer_interrupt(int irq, void *data)
 	/* Clear Timer Interrupt */
 	write_csr_tintclear(CSR_TINTCLR_TI);
 	cd = &per_cpu(constant_clockevent_device, cpu);
-	cd->event_handler(cd);
+	clockevents_handle_event(cd);
 
 	return IRQ_HANDLED;
 }
@@ -155,8 +155,8 @@ int constant_clockevent_init(void)
 	cd = &per_cpu(constant_clockevent_device, cpu);
 
 	cd->name = "Constant";
-	cd->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_PERCPU;
-
+	cd->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_PERCPU
+		| CLOCK_EVT_FEAT_PIPELINE;
 	cd->irq = irq;
 	cd->rating = 320;
 	cd->cpumask = cpumask_of(cpu);
-- 
2.47.0

