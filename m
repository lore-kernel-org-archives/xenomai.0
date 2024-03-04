Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484317C62
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557292; cv=none; b=MUjIysWAe8uC6cjCIDtCEPy92X3qNElW/KNWaaQuuSHC8HTnOKAMVhqSP+GsdB8I1D4+bEyEZV+ylJ55ZRlz2FkGKu/NkfHffIVUnfixwUq6j5eBUX9EqRWm4lJIKYG9UCV0zfQKIKCwRb5j1d5+RehBNsPAn2yH40JybFsksDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557292; c=relaxed/simple;
	bh=wvC9qi39Hd/rNiwtMraCd/g6329WZq8ztjUvjCuJUbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4L+fqVyX6HJ1kb72pn0X4p2CcL5pkkRrv0Jt0oncPOGeeVEyzYvqwmys9V2x/MsM/9gru9nfGAEor4Kci7nYAd/q+22MBP0aO2eYo83qoGMpGkAZZwMlkeEkxyfkMK4OWe+apBtRQddNKlzQifgXk4Y9WxsqEdQHDcTTQbUsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FMDi7h58; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FMDi7h58"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202403041301018e62e4541697ba0c70
        for <xenomai@lists.linux.dev>;
        Mon, 04 Mar 2024 14:01:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RHCtM9pLFwfGaruSBg+QDC480+L6zDVRY+qseGMaBzI=;
 b=FMDi7h585m3y1VgpvXRV4OEGmTGtPYFjrYmeL8Nj8X6mEyAPNj675ibHsFCHrLgfZEVN9X
 1dtRMDAKG/NYjV//8WPGbNMlhGJogAE1cYQEOOGWqslR3OmM6OHLZSqLNtr1lZMkGm0SYSyb
 yuSYHMjWRe99sUgnseYsnNIvpCB1I=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 04 Mar 2024 14:00:47 +0100
Subject: [PATCH dovetail 5.15-5.10 1/2] dovetail: x86: Fix detection of
 prctl based compat syscalls
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-v5-10-y-dovetail-rebase-v1-1-e8010867dbbe@siemens.com>
References: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
In-Reply-To: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
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
index 940726f16f2e..d401701e14f5 100644
--- a/arch/x86/include/asm/dovetail.h
+++ b/arch/x86/include/asm/dovetail.h
@@ -10,6 +10,7 @@
 
 #include <asm/fpu/api.h>
 #include <asm/io_bitmap.h>
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

