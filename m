Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EF37474B
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116648; cv=none; b=slYfvng7nWOnB4lvoNZORHXqbCdKQHci1M+43uxa2aR4n0B2QkUvunLrFI9quc0gHVjYMLYkqwDUfrlInLrQX2Wgwxz4jJeOCmsjLBuE5tuA2Aj39SqN1SYr2yYBdWsR8eJqqPbxims2mII8dJBfEVX0QQq1Wbqnzu/zBUU4wAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116648; c=relaxed/simple;
	bh=pnklUgka/FSg1o/UozqLszXqG6Xj7PkNzhrk5Fn8j4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rbmfkcb0o9kYQQ/A3EraidK6ExPwVKDUZIhXfiYWbjdco59XUn6xGwpyvEuo69KyNKUpyV6RAdmRGv+BK5wikmivajzOEnh5UuV4xgh4qxc3w97TYLyPiXitD9bCT9JWSM+/yIGzIq16klZlaVf+0LNffM6lZqvHL2059wpFVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XTEqWq9Z; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XTEqWq9Z"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026022614371441649e6a0e000207a3
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2J/tOdBa2KspIauYucoEkUnCfC2ecIzrCNVxw8DHG5s=;
 b=XTEqWq9Z/KS830GImQBw0eHy+9sRvwtZC1GzX2TGCb7jLoXGSNnfUbLgpD/zOw6pH7zxVM
 mPpfZK65mW7m5mVOOdYr2Jh8h39OyqKRBxVvAs/RhYcwphC7rA4zXL/SinN1IeBp7/FcUO3u
 vBLUsOdEHizyyYDFCvOLrCVh4Av2JCHxvMx9fao3zlf4vHtyNU4peWrPfMVgrib0YQT4UFgd
 0DzqPbWywbX1JsmfLM/eIR8qvtuehfu76VLBDEXzoXHGAu++80ZyzExV3twjKsZe5hE1CTf5
 /qPxP/FR0TGTx7Po+dA79OXhSNuxoW/SEtVrVxAtRlznainkwUQU3Suw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 26 Feb 2026 15:37:13 +0100
Subject: [PATCH v3 2/5] cobalt/time: Migrate order of includes to "from
 global to local"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-2-e730e85eda81@siemens.com>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a preparation commit for the following wrapping of
mm_get_unmapped_area() for kernels < 6.19.

cobalt/kernel/time.h will include the wrappers.h, so everything below
that include is affected by wrapping. This includes Linux headers if
the ordering is wrong.

Moving the Linux include up solves this issue.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index d88f2efd8eadbb7b1480dc2c5158c2f2c1e88fb5..e24d1759de6ccac9b0b4376bcdc68e0826f1842e 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/compat.h>
+
 #include <asm-generic/xenomai/syscall.h>
 #include <cobalt/kernel/time.h>
-#include <linux/compat.h>
 
 int cobalt_get_timespec64(struct timespec64 *ts,
 			  const struct __kernel_timespec __user *uts)

-- 
2.53.0

