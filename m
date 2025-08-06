Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442FCA5A
	for <xenomai@lists.linux.dev>; Wed,  6 Aug 2025 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441369; cv=none; b=uYVIRV0IzLXx0TrY6CpHjZSSMfV/cbATiuPL5bvONgSag21CP29MJgxRCToZpum4wt7npBwWvxy7KLJpZJKW4JJ1bgpEavF4ap96JAPkbJeZ0XsMbB6wU7WlzA+YJ0q01zvl5EQzYnmLgQpndye+yOlHic3sMcKhKCaqgYzB4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441369; c=relaxed/simple;
	bh=UXSm07bhM1NnJWOkonTEsrjYcKhGsZpf2r4ZoU2w8cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULWCqntP5Tk2Zdv0sHBZ96rU9mZ3lSrZEpZnlAKPOpRWJKgG18+UbGWkV9CxrMQpUsPH/X87sWDsd5EKTKqxLpEg639W6jVkmCxtcpEQcpsyugaZmGBVC69IuonZKEFyclnnfGIhX/WH0aS+k/c8osYcJRB/Lb0ELyC72GK0CiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.e7kGCos_1754441361 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 08:49:21 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v1] drivers/net: fix compilation error caused by RTCFG_DEBUG
Date: Wed,  6 Aug 2025 08:49:19 +0800
Message-ID: <20250806004919.314981-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

when kernel config enable CONFIG_DYNAMIC_DEBUG and
CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG
The RTCFG_DEBUG macro uses a ternary operator (?:) to
conditionally call pr_debug based on the debug level
(rtcfg_debug >= n). The pr_debug macro, in turn, expands to
dynamic_pr_debug, which is defined in include/linux/dynamic_debug.h
and involves a do { ... } while (0) construct. The problem arises
because the ternary operator's false branch returns 0, which is
not a valid expression in the context of the do block, leading to
the error expected expression before ‘do’

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
index eb9ad076e..df0e8e06d 100644
--- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
+++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
@@ -41,8 +41,11 @@ extern int rtcfg_debug;
 /* use 0 for production, 1 for verification, >2 for debug */
 #define RTCFG_DEFAULT_DEBUG_LEVEL 10
 
-#define RTCFG_DEBUG(n, fmt, ...)                                               \
-	(rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
+#define RTCFG_DEBUG(n, fmt, args...) \
+	do { \
+		if (rtcfg_debug >= (n)) \
+			pr_debug(fmt, ##args); \
+	} while (0)
 #else
 #define RTCFG_DEBUG(n, fmt, ...)
 #endif /* CONFIG_RTCFG_DEBUG */
-- 
2.43.0

