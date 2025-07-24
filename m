Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2EA2C15B7
	for <xenomai@lists.linux.dev>; Thu, 24 Jul 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358429; cv=none; b=JHHon+zkX5Up5cKiPmIDDArMug67TJIsdN2x/d6DlMtbidS1KKvMD6XbiWfozMARIOCSkgu5Rnq3HyjBLt1yJw+bY7ugJv4tfFcZetGqle4ahYXDne0I5mcG6p3G/JuTC55XUytjJMfL9CvL5yrQ0kPj54TTOUipeHaR4draxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358429; c=relaxed/simple;
	bh=s0wojbbJtogAZc+34V4JuOIPcAPqgAbBwoMguBO2nZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abPvBWWMdwW9icd0YtjtKlsuMgiA1/Jfm/bl2k8Cx0h1mcqT6WVgn/E4KuO5tOKE6KnE+LRD8YoFdO2qh5GH8OeXpyEqIjLY64NlFOoySrh7CO9eXfM0dCAepRnYyn0hwby4ZQCaUCemzV5cKxfjRfJHNCLMaIP+4z8y2f0H2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A6mdYgMH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A6mdYgMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+H
	q7EKZVs/DckdAxeyfKJlmDci621NTzR7hmCkd7jps=; b=A6mdYgMHFl6bBQbwGl
	0rLDWkg4QMqi4dusmh0JTgbxqfuGVpzhSWDSd5wwLKMHVhgb1T7BnyBXtV/9L0ra
	/P7kkzCkn7av014zM8+dlEZTISn8sP5mgM4chESxmx30s08Gt250vaJlBPIbgUIN
	+DnbGcfh4iDWpvhiiEMl4L0pQ=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHxmpRIIJoV27kGw--.36049S3;
	Thu, 24 Jul 2025 20:00:18 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH 2/2] lib/cobalt: arm64: Fix syscall macro argument casting
Date: Thu, 24 Jul 2025 20:00:12 +0800
Message-Id: <20250724120012.1656476-2-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724120012.1656476-1-aspirestro@163.com>
References: <20250724120012.1656476-1-aspirestro@163.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHxmpRIIJoV27kGw--.36049S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWfXrW8trW3KF1fJw15XFb_yoW8KF43pF
	4xKw4UKF42g348K343Zry0vry7Jr1DJ3y2gFW2gryUW3WUta1rZryfua4vkrWfCrWkXFWf
	Zay3tr1qkr4vv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsa9-UUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXR6UcWiCFuWvKwABs6

The Xenomai syscall macros in the arm64 header file cast their
arguments like (unsigned long)__a1. This can cause issues when
macro arguments are complex expressions, due to missing parentheses.

Update all syscall macro definitions to use (unsigned long)(__a1)
style, ensuring proper evaluation order and preventing potential
macro expansion bugs.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 .../arch/arm64/include/asm/xenomai/syscall.h  | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index d89697712..5ed9eb252 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -74,31 +74,31 @@ DEFINE_XENOMAI_SYSCALL(5)
 	__xenomai_do_syscall0(__op)
 #define XENOMAI_SYSCALL1(__op, __a1)				\
 	__xenomai_do_syscall1(__op,				\
-			      (unsigned long)__a1)
+			      (unsigned long)(__a1))
 #define XENOMAI_SYSCALL2(__op, __a1, __a2)			\
 	__xenomai_do_syscall2(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2)
+			      (unsigned long)(__a1),		\
+			      (unsigned long)(__a2))
 #define XENOMAI_SYSCALL3(__op, __a1, __a2, __a3)		\
 	__xenomai_do_syscall3(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3)
+			      (unsigned long)(__a1),		\
+			      (unsigned long)(__a2),		\
+			      (unsigned long)(__a3))
 #define XENOMAI_SYSCALL4(__op, __a1, __a2, __a3, __a4)		\
 	__xenomai_do_syscall4(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3,		\
-			      (unsigned long)__a4)
+			      (unsigned long)(__a1),		\
+			      (unsigned long)(__a2),		\
+			      (unsigned long)(__a3),		\
+			      (unsigned long)(__a4))
 #define XENOMAI_SYSCALL5(__op, __a1, __a2, __a3, __a4, __a5)	\
 	__xenomai_do_syscall5(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3,		\
-			      (unsigned long)__a4,		\
-			      (unsigned long)__a5)
+			      (unsigned long)(__a1),		\
+			      (unsigned long)(__a2),		\
+			      (unsigned long)(__a3),		\
+			      (unsigned long)(__a4),		\
+			      (unsigned long)(__a5))
 #define XENOMAI_SYSBIND(__breq)					\
 	__xenomai_do_syscall1(sc_cobalt_bind,			\
-			      (unsigned long)__breq)
+			      (unsigned long)(__breq))
 
 #endif /* !_LIB_COBALT_ARM64_SYSCALL_H */
-- 
2.34.1

