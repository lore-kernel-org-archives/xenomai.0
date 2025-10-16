Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52124A06D
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596353; cv=none; b=NeYuxscajfvT7hEV8nMGU0smhIklfM6wL89wfc3cumSTjVZUTiq/xJcDDZfUpTi0cTnjcj7kLgtPTatWZFPk4km1iGRcHixxUsfU4g/cY6ooazxuuqVxivHaTVVrCVnECsuz5iX6RFD4mY8w9bTYIHvPgVkvd6FSCXwPCgQzwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596353; c=relaxed/simple;
	bh=w4CQsmL26wkSUrqf6V/LbGGid5PzsOzzW+hTBKxAyKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC+QGI0ershJF/wvxDMIfBOkKwnzxlPU4muZypCdBf+MltsNF7pCHk9XkM+0f6y1Zykh1x8/7R0I71qxBGbsSrLBt77JyAioJpaU/ZuR7eWUkjRZsNdYgU2Gauw8yRG8GCrsTbaYrH8T3/tEFheDG/DjHCfFvHKljshE9tALMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Onc+iu/W; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Onc+iu/W"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025101606322652623e0a2300020778
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=x3TugFp6vujlabdjcytUjZSDE/fSKrrKy8Hgb6BmTLU=;
 b=Onc+iu/WgZDfDBw9mbqdh4T0fJdYyJzTTE0oZyuQYTXoHmPPsmLp9LIdakfcm/T1exgT1Z
 p8otaSaEI/NusXs4pkh0v1j6aTBoV3cDdqb1yqkz/t1+4cGAQ5fCvC5WCV0F61yqHCKvGF7F
 WeDpMcaCENHTjBodzS8H+oZy2cQyDl3Hn/QZYs/O4pTrV4F/16sFg6IFR8210dzA3z3RUNCs
 Ctmw7SHYtMbZ17X6EbYB+U8CkCIvJIulrTTkfgjg1nqTjmrh4kXAIBRxDzkVUmnYx1J0IfEI
 d61gI++DiQlcmy8et+T6sD//oFSQDFpm0EwZhy3QER1nUV7VD+aExz2Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 3/7] arm: fptest: Ensure that fp_regs_set/check functions are truly inline
Date: Thu, 16 Oct 2025 08:32:20 +0200
Message-ID: <0e3b625d60b0bcedd202e9ad10d9c03ddc322d3a.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

If they aren't, d8-d15 will be saved/restored, and that is ruining our
tests.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
index d5c2c7515b..2559f3525d 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
@@ -18,9 +18,11 @@
 #ifndef _COBALT_ARM_ASM_UAPI_FPTEST_H
 #define _COBALT_ARM_ASM_UAPI_FPTEST_H
 
+#include <linux/stddef.h>
+
 #define __COBALT_HAVE_VFP  0x1
 
-static inline void fp_regs_set(int features, unsigned int val)
+static __always_inline void fp_regs_set(int features, unsigned int val)
 {
 	unsigned long long e[16];
 	unsigned int i;
@@ -41,8 +43,9 @@ static inline void fp_regs_set(int features, unsigned int val)
 	}
 }
 
-static inline unsigned int fp_regs_check(int features, unsigned int val,
-					 int (*report)(const char *fmt, ...))
+static __always_inline unsigned int
+fp_regs_check(int features, unsigned int val,
+	      int (*report)(const char *fmt, ...))
 {
 	unsigned int result = val, i;
 	unsigned long long e[16];
-- 
2.51.0

