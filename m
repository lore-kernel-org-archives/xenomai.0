Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142913EF0CD
	for <xenomai@lists.linux.dev>; Tue, 31 Mar 2026 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996788; cv=none; b=dVOSrpOFFNwgCtDZ+e3HcgSQQ00urOw4lZnFSpXtx0hp02e4IivGHQdNjWDkVJAggAVHJlriSR/Bij1FMxE0u8BZq9g3zp8Ol9oChGVU0ph37Ebs5aOuuhu6Gr9p958r6GbsV7VNXB+UomOvSuVRrS41zxCwAuyDi4/y8Wg+jSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996788; c=relaxed/simple;
	bh=QZwZFgmcdGq7WJsbyjmtPWUTvqTY6HOfjYYQIhL9o2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LD/g3L6qBcUS6VXg4GBzKcL08KwDYweueYLXV3KtxZQLF6kLUxE6tG2N3Rs8xwo61WLXjQQRJoN8Eyoo/beX3n6+V+fgoG2zxfcK1PW95cnWyJh6S8/gI8A1piyNK98YJMYllcHSQ8LkJbwFbhe0SkB4DaQ8Eq/d0Oq3vlHZQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLHhYl8z; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLHhYl8z"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8416732eec.1
        for <xenomai@lists.linux.dev>; Tue, 31 Mar 2026 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774996786; x=1775601586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdfzM8qbHycbxmKJ2xn8YMKCOZglAfEnyt+4t7Z+rRQ=;
        b=YLHhYl8zW7ADBHHXXSNTItj4iiM+T3RnfvWE8Ax2Yn5Li7DXc3oJXa60skDe9+RwiM
         NTtDtbtqCbYD/a+tjWSoTLeOBhn1gnOBNrhOM0mVjtWehFFNaMM9Y/8RQKGE+yfnuveN
         jZcQqGJT7SlNm1UJ7XkPsmEGS6ZmQU9bI228KRs9t4LsP7rGEULOUPjVrqtNpId2M4Le
         rdnVGD4jRc8kjvR/aT7XHl2SNwT2+r/78zvmkD7TOTiH+FbRl90aDoM2YI2EDF23jo7n
         wcOeqkHVuf4vxaHnbyfM77eMa7sffzsQBehcBVzCLSbfGmIDB1GweNH8sbyPdvf+b2V/
         zPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774996786; x=1775601586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdfzM8qbHycbxmKJ2xn8YMKCOZglAfEnyt+4t7Z+rRQ=;
        b=C/jGHEOj+9TESkfS2RG7XQMfVjpNI6mLTyfgzooCAiiaqoFhr/2NrXqQMvOuN3Pj48
         T3W5XUZNfDIJpFDFF8Wr8g5rpHvaM2tJeFNP8cdHss8XZ8UELUc5RMTspeccnhd39akX
         fADQiGEsKZ+fAxiTnT53i55ttXOcnYIwqLx5lieiRBmFPstfYgK+ijgImTIWFf3kKZSL
         h5JPvjaL+t7ZHB/Ko85N4hLXFj6eRpuqpVT9hmFjMyCvh1UV/B0cfS3DPbTjogrqcqaq
         y6cz/eAr434eVoWcnOBWHz1mI/s9zCmZgziJ2yM83Y3FGdrqu+dYB2JUck8vr8CcaYLS
         kRUg==
X-Gm-Message-State: AOJu0YygFJO0NS3kJ9mys3TP/5mXrujSNc8abkcsRx50ZSvr4J+crrX+
	CD/sC5MylshK89QcAd/KkB0Mn39eNt3OKktjtkcYpva0+36uFbvePBskq3S7dA==
X-Gm-Gg: ATEYQzwcSBdCfMR1H09BUC3/4i7zon6uCvok3BY9u2YBZkrEtGHs5uPP1Z5SfT4V1ls
	CJ3WK7LdmR2RriDeCC++jXOpaR1TK5m+FKrzojhSHcysooXPvTLQuD7t3RePn4Pv92mHm2DsfIb
	84BwfX9l+as6VEoxIcy2WXlARnReMAz3Yo0mNleVXIIwWUYYicQaKfLWFoYZ985fgXZXWsGRm0f
	xzcNPdIByoreLa6V1oZbniYjUFTe+blHahyymxcw8YxDUjmXnKf15CWHwoY25nUItuSwgWJpHbw
	2se2UK7I8uyaEebZULIZY/yLeUNGP2V4I8tb89Uyk8VKOUn25Iv+6yBnCFX1h5CN1hPRnoHrjlM
	MCMvRUDJGKjTPkac2GjHGTt4fGapI1d9jGQxBHe5OMaW3Gk4rjyePo8EMcArrFl/vxVlh3SWYKl
	Ohh2ZWlhj1LseDK7kr9g50ib9BowZ8QfcgBJCTGVlXegUkFoTy2WwvOYNh9680fMM=
X-Received: by 2002:a05:7300:ed18:b0:2c5:b23e:48ab with SMTP id 5a478bee46e88-2c9321b76b5mr629685eec.21.1774996785672;
        Tue, 31 Mar 2026 15:39:45 -0700 (PDT)
Received: from brho-desktop.RELATIVITY.company ([136.226.6.69])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2c89135747csm2962679eec.12.2026.03.31.15.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:39:45 -0700 (PDT)
From: Brandon Ho <brandonho667@gmail.com>
X-Google-Original-From: Brandon Ho <brho@relativityspace.com>
To: xenomai@lists.linux.dev
Cc: Brandon Ho <brho@relativityspace.com>
Subject: [PATCH] release oob skb in __consume_stateless_skb
Date: Tue, 31 Mar 2026 15:37:39 -0700
Message-ID: <20260331223817.136912-1-brho@relativityspace.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an oob-enabled driver receives packets, those skbs are allocated
from oob pools. The evl core may leave some of these packets to the
regular network stack for handling based on eBPF filter criteria.
When the regular netstack eventually consumes these skbs via
__consume_stateless_skb, the current implementation does not release
them back to their oob pools, causing a resource leak.

This patch adds a call to skb_release_oob() in __consume_stateless_skb
to properly return oob skbs to their pools before the standard skb
cleanup occurs.

Target kernel series v6.12.y-cip-evl-rebase.

Signed-off-by: Brandon Ho <brho@relativityspace.com>
---
 kernel/evl/net/skb.c | 3 +++
 net/core/skbuff.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/evl/net/skb.c b/kernel/evl/net/skb.c
index 8efdca1da..302f79dfd 100644
--- a/kernel/evl/net/skb.c
+++ b/kernel/evl/net/skb.c
@@ -55,6 +55,9 @@
  *                                                -> free_skb_oob(skb)
  *                        -> dev_kfree_skb(skb)
  *                                -> consume_skb(skb) [1]
+ * 			  |
+ * 			    __consume_stateless_skb(skb)
+ * 						  -> free_skb_oob(skb)
  */
 
 #define SKB_RECYCLING_THRESHOLD 32
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e297781da..e08d0bc54 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1645,6 +1645,8 @@ EXPORT_SYMBOL(consume_skb);
 void __consume_stateless_skb(struct sk_buff *skb)
 {
 	trace_consume_skb(skb, __builtin_return_address(0));
+	if (skb_release_oob(skb))
+		return;
 	skb_release_data(skb, SKB_CONSUMED);
 	kfree_skbmem(skb);
 }
-- 
2.43.0

