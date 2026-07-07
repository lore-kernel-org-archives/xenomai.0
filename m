Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A13BD63A
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418435; cv=none; b=vD+Dw3iLfr2VbMIK6HN+oGrSb2nk2JZcz96+9GzNkxsU9/ZdpioNBSb1BPcmNbbN3swDlcpXOfZNP20oV6SRUUay833p2xn/Npx26cfD8/xfwWmoMDPj6T7jQD8y+AWpmRiUkrKLH2bQeCMeq7v0hb2aesy3hV83kQQ01szj7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418435; c=relaxed/simple;
	bh=fq4ir8IP7FwicXiQVVmNBP9COFmNN4XMENtvBP+MJI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1lU31soV3mbhLqPbJ5l7/zeQC8mplQsadWg/QBnBv1SAUdQPeFDUvT4gK+SGR6BNxJ/BlLkwDOxHSq9AjVvz0v1zGlXdBMo3ZGtSu81mzDbj6DAABFQnJ8oEaJYOYxCi0TD0YAFOfNBHjw4DYFDRDD7efKJnZFMF7JV5nhpG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZnBJ0DI3; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZnBJ0DI3"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202607070950206084b35a410002079d
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KbaaTpZhYAxvhLaVmn6S0wOx8iRcT3YYw5qmX+MKyuA=;
 b=ZnBJ0DI3CpdZZWdGGvr135kJPiZ4oqvvRuSmtXsvRjQ5gSjUqx9nY+6wA1eXlZ9w7ok/cc
 7Ouvb5BfK/0Xtl7qOSV9CUAPKfNFcfxbfPXpFE/2u8xgpNzflmUd3VVeY6kXHmpvocqFzGd4
 ejg4XICDY0MIHs5H/w20e8b9L9ExBzAJa2gAQVXl0Av7YS+hGjHNQ7WoDUU9b8PoevTLNCiF
 rzOw6Ay3q3Sp0YEK5NAEEGMAF5FvV953VLWgChr5LgE7YyuhY3iBKZNc0QkDFZ7e7lW0EtwH
 dMm+/Y8l1ydc2Qw7rDmuG782X9eysUDFR4LQttNzPWdjdkgxoWxx7eQg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:22 +0200
Subject: [PATCH Dovetail v4 6/8] arm: irq_pipeline: Add arch specific
 arch_kentry_ implementation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-6-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving the stall bit definitions into the architecture specific
implementations allows re-use of those definition within the arch
specifics.

Add the necessary implementation for arm to make the generic
implementation work.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/irq_pipeline.h | 41 +++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/irq_pipeline.h b/arch/arm/include/asm/irq_pipeline.h
index 5e3a20149246505e8401bc7157d9c9f13673f45e..3eb735f7cf5fe61112a6dd3403bb89d7532bd1d9 100644
--- a/arch/arm/include/asm/irq_pipeline.h
+++ b/arch/arm/include/asm/irq_pipeline.h
@@ -98,15 +98,33 @@ static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
 	handle_arch_irq(regs);
 }
 
-#define arch_kentry_get_irqstate(__regs)		\
-	({						\
-		to_svc_pt_regs(__regs)->irqstate;	\
-	})
-
-#define arch_kentry_set_irqstate(__regs, __irqstate)		\
-	do {							\
-		to_svc_pt_regs(__regs)->irqstate = __irqstate;	\
-	} while (0)
+#define KENTRY_STALL_BIT      BIT(0) /* Tracks INBAND_STALL_BIT */
+#define KENTRY_LOCKDEP_BIT    BIT(1) /* Tracks hardirqs_enabled */
+
+#define arch_kentry_test_stalled(__regs)			\
+({								\
+	to_svc_pt_regs(__regs)->irqstate & KENTRY_STALL_BIT;	\
+})
+
+#define arch_kentry_test_hardirq(__regs)			\
+({								\
+	to_svc_pt_regs(__regs)->irqstate & KENTRY_LOCKDEP_BIT;	\
+})
+
+#define arch_kentry_clear_irq_state(__regs)			\
+({								\
+	to_svc_pt_regs(__regs)->irqstate = 0;			\
+})
+
+#define arch_kentry_set_stalled(__regs)				\
+({								\
+	to_svc_pt_regs(__regs)->irqstate |= KENTRY_STALL_BIT;	\
+})
+
+#define arch_kentry_set_hardirq(__regs)				\
+({								\
+	to_svc_pt_regs(__regs)->irqstate |= KENTRY_LOCKDEP_BIT;	\
+})
 
 int handle_arch_irq_pipelined(struct pt_regs *regs);
 
@@ -142,6 +160,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return native_irqs_disabled_flags(flags);
 }
 
+#define arch_kentry_test_stalled(regs)	\
+({					\
+	!interrupts_enabled(regs);	\
+})
+
 #endif /* !CONFIG_IRQ_PIPELINE */
 
 #endif /* _ASM_ARM_IRQ_PIPELINE_H */

-- 
2.55.0

