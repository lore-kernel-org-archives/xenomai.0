Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAE440A3C
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770253; cv=none; b=DNZ3dfJXfOuRiwrAWOqDVoZUlsuHjeheYfxRD8ZD80zcgJ7Bh+e/O6fp5eacgSze9HSX1lKSp0RIUUf3aEk715nFb5mybMf1ei1fq73WRmasaZTGutCW3M+370B0SaZRBbkefyFitlJllqOJpdn34Njij1xmRcsJnYSyVIGOEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770253; c=relaxed/simple;
	bh=v6PnO7ExFzd+3SV55teRTFbTxXJ1VTabwgO62t1B8l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SA2QslW3QiVJ8gDxV+6Bq0ntSDuJvSODfrKwKyD2aFGMxMRqGVoJ/pxjZOd+XLLOVoton4xk0HvvO7At/xFU/8cN/VuZqifdBrWbM8Q0d85LO39OEE7r3CjmsDNWc+VzMVcHDvchu5kCVR7pEpgUHuChJjWOuiHNZtlu4r9wfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=m+1ISGdd; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="m+1ISGdd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fe8912so149422a12.2
        for <xenomai@lists.linux.dev>; Mon, 07 Sep 2026 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1788770249; x=1789375049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjlXXCeXuZHCdC2uKSBGZ2jR1vdr91X3xePDSxcX6zM=;
        b=m+1ISGddaD9xnmNKyk22ukAb+DQnsnERCuM905rA4tverPjksJEPaarE5EYZhblyzQ
         X8sMiCVna5NUafpR+ULRW8QIomC6sNgM/KdWOGhCA/oxWmzFz5kYSqE5JZD2ZSfwCX49
         Sl2fdJ0k8xoD9fGPUMoMByr6U6LErnXIFunlvFwdluQB1Ne8E7PcoupWFJmLXZIINZMj
         EXyFxQWcneHiy4mENyg3w9eSDv4G6MLnIZaAHLJotQhDfavQKpMJiUBeykMyddeTuHpV
         JcGkO3alwG09izWxft0cPgFEhvUT2VjXIzCpgDdEEjgxaG4N4mV2YMxiFuUvg2txFOzR
         dwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770249; x=1789375049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjlXXCeXuZHCdC2uKSBGZ2jR1vdr91X3xePDSxcX6zM=;
        b=pKNXn42OpABF7Z6QSW2bzvPzfla8wgpJPiZ0tx568stdrOCECbo75Xgoz6r+5P3+bt
         9GjCVNPBTj5F4D8OEsz3IjzLNCGkPBtRU9IFO9dRQKzsLCOkt+F399q+6shChp0yAcXF
         2G0DFuhYaadcShKlmEPJQ/T/xfMkub9FCsduN9Om3XTeAehbF9zOEIBxMgss9n1shbmy
         Rls4eUxMLlRjM3w0golyiFE8946T40WGQpG6f3JhgDostNPXHQoKc3NNn8faRlPO3kZw
         0ZKFzZ7Gb2p+55GRhfT+7g/eODGJxLoWoj8X4o2FUAcifHFEdMV7FvV6zYFm6UN5x05i
         R3Wg==
X-Gm-Message-State: AFuF++noWw048/XY2aLZZhgvx7zqTJodOKWpvGcw9C8hebXAEXaB6kWH
	TSessV4Zbs22HMssAg0V7p+l8amaJ9LVtTB9HkIhLmHNX6nAigFfvFNJXlLjp6Kf1frmVUFnA3y
	QelU9
X-Gm-Gg: AYBFou2QLaBXxqK7ODYp43o6AUSj0RkZFPhZc8agzAkNuVrIBWvutb5MGwPa6OBQT+y
	aIgQpMMmxXDo7Phh89pbwomHWiOV6cz5sCVyflemK9TM/QtfUSNjZYTXCsZZeyqF6YH+GU64JYK
	pMDf0GCYz1N942C929AB5OTiWgrg1hOWlGGhSwYnEyr6AqXogWMqOV6NWLrTho0Luydnga0MJLx
	n2QPjGZPxVudGa514Xsh6Twbb8dLmaxD5v5YlsEPbmXvHMRGX6FGbt9SbXwiCH+ZsAGW6+4O6m7
	qUamUuUU1AtxFdE2phT+Mb79iPG/SlI3ZXSIZiRC8X8jlQqNnvn2nggzoUufsSb6qPHUb/GTxlq
	miQSHK1XbMYHMJSQXV+1+q9S6MDZccnJGz7Du3dix8e7/mf1nochvHczCL1UHr6wUxpBj36PwNe
	huEMDdQXTcodL1mFj85JeGvprsqXqAcv4F6T/9PuKFvpRwWDhQOZwgPYsq0YoYpq6Hx5tA4uwWc
	Bze9yPSeqbpNkve9LGNFRslIIedhPA8hELRqK0Z
X-Received: by 2002:a05:6402:3553:b0:6a0:cbef:884c with SMTP id 4fb4d7f45d1cf-6a7f68adb9emr4263103a12.0.1788770249137;
        Mon, 07 Sep 2026 01:37:29 -0700 (PDT)
Received: from Darias-MBP.eh.lan (89-160-62-194.cust.bredband2.com. [89.160.62.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68e9679sm3853528a12.20.2026.09.07.01.37.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 01:37:28 -0700 (PDT)
From: Andrew MacPherson <andrew@elk.audio>
To: xenomai@lists.linux.dev
Cc: Andrew MacPherson <andrew@elk.audio>
Subject: [PATCH] clocksource/arm_arch_timer: flag PPI registration as IRQF_TIMER
Date: Mon,  7 Sep 2026 10:37:08 +0200
Message-ID: <20260907083708.2566-1-andrew@elk.audio>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dovetail's tick_regs (kernel/irq/pipeline.c) snapshots the register frame
of the last timer interrupt for reuse by every deferred in-band IRQ, since
the genuinely preempted frame is gone by the time such handlers run. It
identifies "the timer" solely via desc->action->flags & __IRQF_TIMER.

arch_timer_register() requests its PPIs with request_percpu_irq(), which
always passes flags=0, so this flag can never be set. On any EVL/Dovetail
platform using the generic architected timer tick_regs is therefore never
populated, and every deferred in-band interrupt handler observes an
all-zero pt_regs via get_irq_regs(). Visible symptom: perf record/top
report every sample as unresolved (ip == 0), for both hardware and software
events.

TWD, ARM Global Timer and Exynos MCT already get this treatment but
arch_timer was never converted. Switch its PPI registration to
__request_percpu_irq(..., IRQF_TIMER, ...) to match.

Verified on STM32MP157 (Cortex-A7, kernel 6.6.48): before, tick_regs.pc
stays zero and perf shows 100% unresolved samples; after, tick_regs
refreshes every tick and perf resolves real kernel symbols.

Assisted-by: LLM

Signed-off-by: Andrew MacPherson <andrew@elk.audio>
---
 drivers/clocksource/arm_arch_timer.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0000000000000..0000000000000 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1033,25 +1033,25 @@
 	switch (arch_timer_uses_ppi) {
 	case ARCH_TIMER_VIRT_PPI:
 	case ARCH_TIMER_HYP_VIRT_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_virt,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_virt,
+					 IRQF_TIMER, "arch_timer", arch_timer_evt);
 		break;
 	case ARCH_TIMER_PHYS_SECURE_PPI:
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_phys,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+					 IRQF_TIMER, "arch_timer", arch_timer_evt);
 		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
-			err = request_percpu_irq(ppi, arch_timer_handler_phys,
-						 "arch_timer", arch_timer_evt);
+			err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+						 IRQF_TIMER, "arch_timer", arch_timer_evt);
 			if (err)
 				free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI],
 						arch_timer_evt);
 		}
 		break;
 	case ARCH_TIMER_HYP_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_phys,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+					 IRQF_TIMER, "arch_timer", arch_timer_evt);
 		break;
 	default:
 		BUG();
