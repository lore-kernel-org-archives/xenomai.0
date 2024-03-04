Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06823B797
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557275; cv=none; b=Hw4oIi38qlu7a7RP9kL+nP8GYISSoDk0RAEdzDKKsHdYOMwJ+eJ/lWV+UH+UHKhEHSykHSZqvQr7PzHGhVjOhhUnZaTTVrF7RrJ2ngpMipKytZYld5ujOn53nK+tWIq1oDLNJxPNAnSFh6nPZQaPYFKEfS5qbuVruJymL8l6eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557275; c=relaxed/simple;
	bh=saXQegDxKC35uN5q27BRSJoWKZ9VAHrEUjY6hnGYf1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUWijfEa8AxPiDS1opBkZMKq/9Ji64vjaEOw8higIVutI+9NWzq4CYSyLu+zR13AG9XmdzTRl9tOHmLV/3LHM6CTrkoOx9IT7dv0S2POFZkNyETYeymydY+YmL+h7yAE1AB3EOqzFQR82+yUcdBoC9rySSpsfbSt8C3y9m0vZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=k7GmIW1h; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="k7GmIW1h"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240304130102fb97ce9f4b96862f23
        for <xenomai@lists.linux.dev>;
        Mon, 04 Mar 2024 14:01:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=28UJ3iDpWn/yPv/jRS/uieYvF7JQmvW98zND8ioqvlo=;
 b=k7GmIW1hR8T6I9MFo9qdzJy5K/YM0W4J4zu3qqfXbSNltXVzZIv2bMrXoBJylpQEzUxzVv
 8youhLI2vSqa7ZQKcm4eodL8yf4qVrAX8x15bNWVdgr+qf+hUqIGU0QPRwCzx3rVdiJXunoi
 AIUR/sEYEly8hSaJ9eg/Wt4cE0LMA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 04 Mar 2024 14:00:48 +0100
Subject: [PATCH dovetail 5.15-5.10 2/2] dovetail: arch: Fix fetching of the
 first syscall argument from compat tasks
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-v5-10-y-dovetail-rebase-v1-2-e8010867dbbe@siemens.com>
References: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
In-Reply-To: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On x86 there is a small difference in the ABI (= register) where the
first syscall argument is supplied between the x86_64 (native) and
compat (i386) case.

On x86_64 the DI register is being used, while i386 used the BX
register.

The same problem exists for further arguments - handled by
syscall_get_arguments() - as well. syscall_get_arg0() is dovetail
specific and is now in sync with syscall_get_arguments().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/syscall.h   | 3 ++-
 arch/arm64/include/asm/syscall.h | 3 ++-
 arch/x86/include/asm/syscall.h   | 7 ++++++-
 kernel/dovetail.c                | 5 ++++-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index eec5bca5cb37..e75e1227c059 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -63,7 +63,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
 	return regs->ARM_ORIG_r0;
 }
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 88272178d13e..86d0efc7f917 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -73,7 +73,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
 	return regs->orig_x0;
 }
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7b2a4648f514..40f7a948d083 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -128,8 +128,13 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
+	    task->thread_info.status & TS_COMPAT)
+		return regs->bx;
+
 	return regs->di;
 }
 
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 4d1e4c35b9ff..7c109a977f4e 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -169,6 +169,8 @@ int __pipeline_syscall(struct pt_regs *regs)
 
 static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	/*
 	 * Check whether the companion core might be interested in the
 	 * syscall call. If the old syscall form is handled, pass the
@@ -181,7 +183,8 @@ static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 			return true;
 	}
 
-	return arch_dovetail_is_syscall(nr) && syscall_get_arg0(regs) & __OOB_SYSCALL_BIT;
+	return arch_dovetail_is_syscall(nr) &&
+	       syscall_get_arg0(tsk, regs) & __OOB_SYSCALL_BIT;
 }
 
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs)

-- 
2.39.2

