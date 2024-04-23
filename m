Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0D56B79
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869518; cv=none; b=XCzvXL81fK5qsn7qNcHKpe5Tm5QzLBQyWd2ZH/BvQx3SaywoguliSqmxEiEH600hXyeUxYvrgVOvXaK1UnaGKcdIhG8ifwEAZe3mbla9JVJCohETfNE0/c+rIYPVTMksSn4IlAx5fxzLA2W4vdPkvUAvjj0Te1n5x784r+na0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869518; c=relaxed/simple;
	bh=mazjRrhmMeKGAAQb+WNwxkIlkgfDbIFWYXNJkl7dp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oywv/tjeT6jvANUYWBUK8+0o9ZNWyj9gRnOeApwjAbr/2j0ZaohWxaxica1ZPCLW9v+/2/W8rjXXdfne2ndUF9d7NFL6oJyCxHWQDLg5FtwfVE/Wpe+or4rdk13IjhIuyWFws9Zj3pIVh6DwzqOxCFC2X7QhKHE1HSwEY30ptQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=N+9RR8LS; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="N+9RR8LS"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240423104137f4b7698df826a6a0b4
        for <xenomai@lists.linux.dev>;
        Tue, 23 Apr 2024 12:41:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To:Cc;
 bh=ODMDuvw5zN9WzxN74d/x9fVhFfPUNnw0iE+09nMkV1s=;
 b=N+9RR8LSs6/aeYZuaOYwKFCzvQL8SoTruS/7LAqr57+w5HsBb8Yhe5as2UheRiYo06Jnr9
 wFpIV0FvXkFXdwbO+4z+wIlfrL2/koezCF6M2zpn6lIwFe5xmd1AjpDOfUfKEkhSjbWT8bVS
 qG66rG2t0iwTzEBDsbsPIAVkVvDB0=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: roman.hodek@siemens.com,
	Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [PATCH dovetail] x86: irq_pipeline: Add missing definition for !CONFIG_IRQ_PIPELINE
Date: Tue, 23 Apr 2024 12:41:11 +0200
Message-ID: <20240423104111.32385-1-Fabian.Scheler@siemens.com>
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

