Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5860247
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927682; cv=none; b=o4kWZAGjb9KCfy/YLTx5KzymxAXW0FHnYWTJtcC422ZCWizlP0wd66UBrqlmFaDI4ijsoJtOQjvRqrF56FTp4/kI3ZSisflMCjBaYZ6ra1r0dINJLIZrOMqOJK/g/0kbhSofHXIPuccXJ3Vtzo8Q2pDUETVSPBVfoTuj+Ndqj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927682; c=relaxed/simple;
	bh=MVFvw7OTwwMsgqYW3jHfxzAeqnlT1sQ8Z5w6MW/wvWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNnN1hI7MDvWX7TyB49ofJ9+afYQ+UOX7PzAACe5uo0BuD0gfoeL8AiQPzMcD6mg42naOLsNfg3lvg64QZ2t3VY+/NLiBeD3O9Qgouj+qkHyO0hdrtYrhVAviJjtr9fBvOfEgLzAtDZVf3SLFhnLeQ5HFTal/oZSybCDrn2aVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ZRmPjyUZ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ZRmPjyUZ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240214162110970de66fd4fb550108
        for <xenomai@lists.linux.dev>;
        Wed, 14 Feb 2024 17:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dWlRtsI5g/A44WiAEo8Qh/kSXHjOx7SWG3PswpEew4I=;
 b=ZRmPjyUZjzG06Wz01ylbUt5BRdT6EKIKTqa6UJzu/cds86/Yj1uqTLHxqwFjqiveF443BG
 0FfTB77SB+nfwGWRsype1UpwMBmHH3WWyrOCU/VPPbYOrColcvGNdS4jiwReTYydO0lBBHUz
 5LjyC/a70HIj9Ji4+ksvmIfQ8ro7w=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3 3/6] compat support: cobalt/arm64: Add compat support and clean-up
Date: Wed, 14 Feb 2024 17:20:42 +0100
Message-Id: <20240214162045.2017832-4-clara.kowalsky@siemens.com>
In-Reply-To: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
References: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index 26e4ed8c3..42057e986 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -9,8 +9,6 @@
 #define _COBALT_ARM64_SYSCALL_H
 
 #include <linux/errno.h>
-#include <linux/uaccess.h>
-#include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
 
@@ -20,7 +18,13 @@
  */
 #define __xn_reg_sys(__regs)	((unsigned long)(__regs)->syscallno)
 #define __xn_syscall_p(regs)	((__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT) != 0)
+
+#ifdef CONFIG_XENO_ARCH_SYS3264
+#define __xn_syscall(__regs)    __COBALT_SYSNR32emu(__xn_reg_sys(__regs)	\
+				    & ~__COBALT_SYSCALL_BIT)
+#else
 #define __xn_syscall(__regs)	((unsigned long)(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT))
+#endif
 
 #define __xn_reg_rval(__regs)	((__regs)->regs[0])
 #define __xn_reg_pc(__regs)	((__regs)->pc)
@@ -32,7 +36,7 @@
  */
 #define __xn_rootcall_p(__regs, __code)			\
 	({						\
-		*(__code) = __xn_syscall(__regs);	\
+		*(__code) = __xn_reg_sys(__regs);	\
 		*(__code) < NR_syscalls;		\
 	})
 
-- 
2.39.2

