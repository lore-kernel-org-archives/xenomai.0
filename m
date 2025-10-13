Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B12C0286
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375475; cv=none; b=sUnQNAdwGiAMjzvIR9bCjzh0QJeJ2TYPE43DQB9n+PbiiGpI57HPZfhUWPdO+Q4ejOJanW68eMZQGfMeiwxOwFAbGXZ139UxtAf9gxhBDV80GhnDQ+ivOWsM1zLh81ikgHodrrOdUEH0m/BYc6UPuIBrf3yobs4c0ABhGF7VgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375475; c=relaxed/simple;
	bh=2JsTc0ZKnV31T5oiklL/MZm/iP7GpJhVEcFIPEtzNAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2CneVeD0DRksJ3dK6qMKAh/jTuYxhlL8P1WqwY9DEyegy2mIzZqgU8v5dt0zVdsqqYOXKWDVx3p4h3e6d4GVzyoVjCOd8e+YEBDKJtQv9mXhr66h7s9Ze9pb0FpFh1EGDBLSx/3fjcWN2LaNn8M+SYdmMJ1afEnD8CLnJsylmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LNdOfyGF; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LNdOfyGF"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251013170100d82b350e2000020775
        for <xenomai@lists.linux.dev>;
        Mon, 13 Oct 2025 19:01:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=HKkh7wPVhzDJhDJ6OFIf5BEe3g+mjCDam/q9tpiN9JA=;
 b=LNdOfyGF60mTdXO/8qyYOa4by5ZASZLSXJyRR8npe0bBd6ZVyc2re7ZWz/HdBVT6FK0aRc
 uBnkUmArJ1EYbknMvOPbE2RVPGdZpYrlGrjc0ypRTsp//RL8ghmk6oEhTVT9Qnhr8yVvBaXc
 B/sahnsL0FsRg+Phwi6gjHfw5egQPIPLoMcKggIxvA4S9252FYvIN2oZTf4ASdsczGXl4qgF
 uu+CeKmCqrfgNihG1S5aelJp6cibUQ1wQ1tjqfTYIQUQNfXg3exnyzY3AuFdUwepc/xUiiGN
 JjosL72H1sx5Q9pvpqUZv7EREB9B2Dk2n6zisfUTh99XWx8rUz9bt7OQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 3/6] arm: fptest: Ensure that fp_regs_set/check functions are truly inline
Date: Mon, 13 Oct 2025 19:00:57 +0200
Message-ID: <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
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
 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
index d5c2c7515b..2b21bc5f55 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
@@ -20,7 +20,8 @@
 
 #define __COBALT_HAVE_VFP  0x1
 
-static inline void fp_regs_set(int features, unsigned int val)
+static inline void __attribute__ ((always_inline))
+fp_regs_set(int features, unsigned int val)
 {
 	unsigned long long e[16];
 	unsigned int i;
@@ -41,8 +42,9 @@ static inline void fp_regs_set(int features, unsigned int val)
 	}
 }
 
-static inline unsigned int fp_regs_check(int features, unsigned int val,
-					 int (*report)(const char *fmt, ...))
+static inline unsigned int __attribute__ ((always_inline))
+fp_regs_check(int features, unsigned int val,
+	      int (*report)(const char *fmt, ...))
 {
 	unsigned int result = val, i;
 	unsigned long long e[16];
-- 
2.51.0

