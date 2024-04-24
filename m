Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA7D29E
	for <xenomai@lists.linux.dev>; Wed, 24 Apr 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949228; cv=none; b=SgtEsPXNOCgz7baJ2lIxtH4oyWDRrcy92mlo9oP59VPUEzR7rqOqKG0Pb1IdEzAWMwf/QipX/XPRxNB/zShliplnxvW0DWvlCZrQ47zZZkurQ4Tej3ZIHf90zUq8Hk22aSCQ2zdNCrmqcr3lgoUbrl47Yf2Y3IVddSHsJMbkPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949228; c=relaxed/simple;
	bh=uMuGBiDZlaXOIvl79Xoj3JlxC48HWEao2zrAoRExTRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN2Y49Fy252r4e85r5GTx8ZUOoQFLmP/lG394R2/n9qhoLbIeJC2EWkwEM4C4r7rsVKqZ865m0Q/9RpMpXVRPlv2UYzQTGLjRXLtJFcFzD91RRRdaSiOyv3ZE4dibdiqBLe0TT0pm0wRx4MLUWsxkhRL1rrv8EjytZQuRscm1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=Fv8bKzaE; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="Fv8bKzaE"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240424090022fbae10e4a0009a591a
        for <xenomai@lists.linux.dev>;
        Wed, 24 Apr 2024 11:00:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To:Cc:References:In-Reply-To;
 bh=oSakE5xF+m2De77/TGNPoY0O8GE4vh3ndfc0KWrTsgM=;
 b=Fv8bKzaE9yzJ0ZQDnCn3vRyUeFnKdBdVRWim5k2ncG3hZGRa5psIz3OqaYiqfEazwi6KMB
 WzDVTUYZHlhCO1zWY6/GwDP1djjXwXelREjDBforuXo9Mabb0TS5HPtOyKR433J09df4e9uN
 iAOxkHSqOBcvKmwWuOMlzrkx18/9E=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: roman.hodek@siemens.com
Subject: [PATCH v2 dovetail] x86: irq_pipeline: Add missing definition for !CONFIG_IRQ_PIPELINE
Date: Wed, 24 Apr 2024 10:58:35 +0200
Message-ID: <20240424085922.41944-2-Fabian.Scheler@siemens.com>
In-Reply-To: <20240424085922.41944-1-Fabian.Scheler@siemens.com>
References: <87o7a0yx5f.fsf@xenomai.org>
 <20240424085922.41944-1-Fabian.Scheler@siemens.com>
Reply-To: xenomai@lists.linux.dev
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer

From: Roman Hodek <roman.hodek@siemens.com>

Fixup b917e98008314b3c7596099f48ea98f541451083 introducing
DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN only if CONFIG_IRQ_PIPELINE is
defined.

Reported-by: Roman Hodek <roman.hodek@siemens.com>
Signed-off-by: Roman Hodek <roman.hodek@siemens.com>
---
 arch/x86/include/asm/idtentry.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 9b936d3e76a2..307623b4e10e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -230,6 +230,7 @@ __visible __noreturn void __##func(struct pt_regs *regs)
 
 #define DEFINE_IDTENTRY_IRQ_PIPELINED(func)			DEFINE_IDTENTRY_IRQ(func)
 #define DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DEFINE_IDTENTRY_SYSVEC(func)
+#define DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN(vector, func)	DEFINE_IDTENTRY_SYSVEC(func)
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)	DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)
 
 /**
-- 
2.44.0

