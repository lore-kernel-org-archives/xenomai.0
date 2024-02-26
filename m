Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AE12F39F
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964965; cv=none; b=PBASHVnpmIt0raaZkauouqVMsOKYsykBWUMO9i1E8jF+0pgw96ZCRygV4AEiATWqUeMRjcrGlIhbNkLvOF3JOdvyr351xV/9n4xO4Gi0EaE/cpSVttg8N9S/Ddi/SToZX65MFwRkSiJ/WVeLjO8fsm6e+1MDj0fzMJsi4lfDYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964965; c=relaxed/simple;
	bh=nTwvmlhkqiKctdTziGhMdYOXcDuJ03wA6jY1dq7XYSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8ITMMIE4Uc3LYHhE5+ipkgfBU0MkdADSb0VYRdSRaW+ZD1HYBjwu1rWMV9XZ2y/Bi7FO6/zqRifwlylZpcO4knAG6xeIZ+y1G/niptqTycGpUYsVlTfBrvNm3dBp8ATwPK3kTymlhg2XIZ/Gwp6QeqgxAII+Lj65+KIBeWJuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CnM80Bdc; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CnM80Bdc"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240226162914b127b0ed92a1d25666
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 17:29:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y7Soozhxo/hs+JdvSCXFzZdWRyU1AQxkTpOzXx7qtts=;
 b=CnM80Bdc+AKrYXNBzVDdCs/zoiYVqxk+QFrWFfRVzsp11mw/SQmZ6tHwPLIEu+TmmXI4xf
 uLOHVpTY8DMS1iT3e/hGgvwRHEJKk3HRg6P9X/NPiLc14e1SYfSS93BH1Xg6dLeyfCp0Jj6v
 dfwvWxCDG2AtVQaBdoe8Hywp9dHFE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 26 Feb 2024 17:29:13 +0100
Subject: [PATCH dovetail 6.7-6.1 1/2] dovetail: x86: Fix detection of prctl
 based compat syscalls
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-v6-7-dovetail-rebase-v1-1-2962213b5e9c@siemens.com>
References: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com>
In-Reply-To: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case a compat application is requesting a dovetail service the
syscall number will not be equal to __NR_prctl (= the x86_64 syscall
number).

The same problem exists on the arm64 architecture where the problem was
already addressed. Apply the same to x86.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/include/asm/dovetail.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/dovetail.h b/arch/x86/include/asm/dovetail.h
index 2a85995d6564..001520262ce6 100644
--- a/arch/x86/include/asm/dovetail.h
+++ b/arch/x86/include/asm/dovetail.h
@@ -10,6 +10,7 @@
 
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <linux/compat.h>
 
 static inline void arch_dovetail_exec_prepare(void)
 {
@@ -40,6 +41,14 @@ void arch_dovetail_switch_finish(bool enter_inband)
 	}
 }
 
+/*
+ * 172 is __NR_prctl from unistd in compat mode, without #inclusion
+ * hell. At the end of the day, this number is written in stone to
+ * honor the ABI stability promise anyway.
+ */
+#define arch_dovetail_is_syscall(__nr)	\
+	(in_compat_syscall() ? (__nr) == 172 : (__nr) == __NR_prctl)
+
 #endif
 
 #endif /* _ASM_X86_DOVETAIL_H */

-- 
2.39.2

