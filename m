Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F064275AE8
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211607; cv=none; b=gAxD4Wt0Z3h2GJ8fGOXuOrntX8q1gWZQckcXvd9cIfDHUKknRzxEhY+x+wq89rdG8E2+b/l/3Ko465kBgUH8Y45px9bcL8slHI91prrA3IyKMm3fb4UD/2ic0yU0x2YLAxn4GmUu+lEgMkG/HBNlERTOHbkymHy8/kT/Ui9NDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211607; c=relaxed/simple;
	bh=KczFsLWRDTGQPyxeDhtKdUN8p+It0dM+fybaX80Y3PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRLKjPJUBsKR2tyR5YNHqBzHMywSlkrqvkGi2lnzEhKVQmXpJTCC6ZplWX5dEgpwSSyvC3KUjPOunpsZ6utNNR4FPK1xjHNOVMLQ/XR7Vv7NUNANNivG/COg5+8cYh5Q2e0XpOG/6Z65l2dd+pSGhE/CKayjy/lZ9KgbnX8CRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjgQqAiR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjgQqAiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768211606; x=1799747606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KczFsLWRDTGQPyxeDhtKdUN8p+It0dM+fybaX80Y3PQ=;
  b=OjgQqAiRk5T5ElBJiHQY8U38hzIAV97PgMxsSFEUff6xlv/7BIQJ8OSy
   WtP76JbhNnbCmMd4DfJRKvj1LgvdAH/Jeqd/x71uJB7CeRsn34f+Km+0x
   pjPMZku5XTlJUz1QEYhiDt0URUj1/aMhYxo2SkiVP4BsC6RU66E6dizKb
   8eY594YRZVsrOKzOw12xgdNAu8b6TlgK12TpDD4POA3UEW42CroE7gWX9
   XLwt6mcKAo2p4A/2GRevAf/bAE5SMhvfmXyNj2KrB/xqqxyE/5J9ld8Tw
   qqG2EFShn6aDUJr4enSimAyYFgEC7aVUbBNijDHje1qWPPhGv4nS7Uy9N
   g==;
X-CSE-ConnectionGUID: Gzt1FRm5SemTmchLP/yTvQ==
X-CSE-MsgGUID: CXdZRhcvR4ut9ZSzl7k+0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69218272"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69218272"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:53:26 -0800
X-CSE-ConnectionGUID: 7Z9q2cqGTcGn0YmBi1OR0Q==
X-CSE-MsgGUID: lAvMJqT2Q965kl589ad+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="234742396"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:53:24 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev,
	yuan1.wang@intel.com
Cc: junxiao.chang@intel.com
Subject: [PATCH evl 6.18 1/2] evl/genirq/test: fix irq test build issue
Date: Tue, 13 Jan 2026 17:48:51 +0800
Message-ID: <20260113094852.2806192-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw lock in irq test case should be replaced with hybrid lock.

Fixes: a4a5748406af ("genirq: irq_pipeline: add IRQ pipeline core")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
 kernel/irq/irq_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index e2d31914b3c4..f13ea0f7cbdc 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -145,7 +145,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	disable_irq(virq);
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
-	scoped_guard(raw_spinlock_irqsave, &desc->lock)
+	scoped_guard(hybrid_spinlock_irqsave, &desc->lock)
 		irq_shutdown_and_deactivate(desc);
 
 	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-- 
2.43.0

