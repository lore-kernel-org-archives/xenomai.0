Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2E73504
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=guBcwj4jPL8NBP/UUw9L3MHs4GmYNU8CMfkiruorQ3UlA2t3HrIQbdbWaq4sdhPIguX+QDHYx/Z0AzrTxCG+NX4SKX5T41K5BVPRFF8XF5oh9g1OfhVBBW+R0yeidDpq6wypG70Q0qvanDKg026rdaQJcw0USKrlQaJxfChKfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=Kw7rGsk3slrQAi9n+5XcHtd93ViPhyZadZSSZIdW2WM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m50ilQ9BFCR5XoqwStrPO704/6UFKbJCUdCYCsMkThY1GIMi6dqGDsEa5U20abtwrT18a2fjEFISpPs+YZVji05y9lVbKfdP/BxFMkpURMV0B3m2pYVRnywQqzrzkClr492MCSVzypU3HZ450+m0+QOEnggZP8qlVmLBOMzDAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=gf+lF0gJ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gf+lF0gJ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024032606310657486764636a5a3506
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=e/mccopK55Pj9xCmC6x62L5V8OImWGSOrqvOzQVmJoY=;
 b=gf+lF0gJ3MvYLgBE3W7c4BaMzHhmmx6j318/TGFpfPA1H1XiVGn0vTsA7n/LH7Q0DkH08v
 5fiCcZU04EMcOmhFMidDZdmMiNAtgXAD2scuMDAMeFIW7rGCK3WJ1ltKqj8ReWMzgbhv+jCt
 go/oLPs6iZsxwwfQHrUGHKOyfFOtg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 05/25] cobalt/arith: Only implement xnarch_generic_full_divmod64 when used
Date: Tue, 26 Mar 2024 07:30:44 +0100
Message-Id: <7e95492d50f4d8cd94f5606cce2158b7cf752bbb.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

This also resolves warnings about a missing prototype.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/asm-generic/arith.h | 11 +++++++----
 kernel/cobalt/arith.c                   |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/asm-generic/arith.h b/include/cobalt/uapi/asm-generic/arith.h
index d01d01e95a..929baa89cc 100644
--- a/include/cobalt/uapi/asm-generic/arith.h
+++ b/include/cobalt/uapi/asm-generic/arith.h
@@ -73,6 +73,13 @@ static inline unsigned long long xnarch_generic_ulldiv (unsigned long long ull,
 #endif /* !xnarch_uldivrem */
 
 #ifndef xnarch_divmod64
+#if defined(__KERNEL__) && BITS_PER_LONG < 64
+unsigned long long xnarch_generic_full_divmod64(unsigned long long a,
+						unsigned long long b,
+						unsigned long long *rem);
+#define IMPLEMENT_GENERIC_FULL_DIVMOD64
+#endif
+
 static inline unsigned long long
 xnarch_generic_divmod64(unsigned long long a,
 			unsigned long long b,
@@ -80,10 +87,6 @@ xnarch_generic_divmod64(unsigned long long a,
 {
 	unsigned long long q;
 #if defined(__KERNEL__) && BITS_PER_LONG < 64
-	unsigned long long
-		xnarch_generic_full_divmod64(unsigned long long a,
-					     unsigned long long b,
-					     unsigned long long *rem);
 	if (b <= 0xffffffffULL) {
 		unsigned long r;
 		q = xnarch_ulldiv(a, b, &r);
diff --git a/kernel/cobalt/arith.c b/kernel/cobalt/arith.c
index 5603c2d528..92413014fc 100644
--- a/kernel/cobalt/arith.c
+++ b/kernel/cobalt/arith.c
@@ -17,6 +17,7 @@
  * 02111-1307, USA.
  */
 #include <linux/module.h>
+#include <cobalt/kernel/arith.h>
 
 /**
  * @ingroup cobalt_core
@@ -31,6 +32,7 @@
  * @{
  */
 
+#ifdef IMPLEMENT_GENERIC_FULL_DIVMOD64
 /**
  * Architecture-independent div64 operation with remainder.
  *
@@ -61,5 +63,6 @@ unsigned long long xnarch_generic_full_divmod64(unsigned long long a,
 	return q;
 }
 EXPORT_SYMBOL_GPL(xnarch_generic_full_divmod64);
+#endif
 
 /** @} */
-- 
2.35.3

