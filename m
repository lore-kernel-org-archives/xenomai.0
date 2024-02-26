Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF254135407
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988032; cv=none; b=Soe84qpaFnSBjF4BSQB2mQny5IfdNpl4/jReyGeIgPNawRcdBTdXNFhjS7ehobr87SFSB7E1Nu5y6R6sD7HKA2Q7bbCGrbmpyi4J1NyH3u8iKmc5rI9HDpUaPh/DCcEVhwBuNAtbrH0VKEbEfX34hFult5rAE7TuV8WQy/f2CDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988032; c=relaxed/simple;
	bh=nTwvmlhkqiKctdTziGhMdYOXcDuJ03wA6jY1dq7XYSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAwrOlsG9VZ0KD4kVaCJb1d9l2N5jKFYxPnr0T8fAwDyITVaKjiZF9y7jfPg0aI0zLQifqbCUr0npjzjcqi0e8joxXqT4HbjJRfdM4cV9Y8CSfhvtw1XwCqDx2nfI0F5Hm8ymUKiUYecZVPZDo9OyFBHrLqVBN6Oa6yuG2xmi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TGz6C7xQ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TGz6C7xQ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202402262253416b3d396f04b3e2d7d3
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 23:53:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y7Soozhxo/hs+JdvSCXFzZdWRyU1AQxkTpOzXx7qtts=;
 b=TGz6C7xQ4C+888Wf7owoRFMmGRdCuHlsQ7Rm5C8kRAQnzjgQgqtiV2CjAA2UfA+Ted+H1s
 G4EQ3lJ1LiEahSPXdDWxgK4QszqzZFQEPXbAtYme2wuTvEAtpFc0iQfd0ZsJBjdJjINuRIYk
 933b41XNNRwC93QwsGJYflD8CP378=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 26 Feb 2024 23:53:41 +0100
Subject: [PATCH dovetail 6.7-6.1 v2 1/2] dovetail: x86: Fix detection of
 prctl based compat syscalls
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-v6-7-dovetail-rebase-v2-1-7d457d60d376@siemens.com>
References: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
In-Reply-To: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
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

