Received: from out198-30.us.a.mail.aliyun.com (out198-30.us.a.mail.aliyun.com [47.90.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F34207A2A
	for <xenomai@lists.linux.dev>; Tue,  5 Aug 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392828; cv=none; b=FbHSeEObMu0mNE8Fjskk1gxcdsdhr+WE8ITKCmxLqv41ti6VFMN1rSTa/pDl7hOJdmBZ8S7qjKHeENTsBptbhITdBr19oZvR7jBtnLCBIhwdhntZe19qNnZbjYDt8sWockYM3jL0GCtS3vtZ8CeTSB9gNUygC+Y2M6F8bqWl6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392828; c=relaxed/simple;
	bh=2+AaFChFMIM/IdPb3LCqMABTWltjHsJ3KV/4vE3qiCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccILX0qhMYRqq5Xq0SWKqc9GbYqoYxRuqfnlrpKuDhj9RWHOVhwzJh2GIJS9ZKkFr4p0ddZQolP4u61NN3RZ3vij71gUrlLn0+DQpSDjws21Qg4am9+Dv98ozcTJJRO2VGVyvZ5GAgBWQejLENW5cpq8Z1Gm6mpSmzL/Xqjuir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.e7AnSDR_1754392487 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 19:14:47 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v1] fix RTCFG_DEBUG macro compilation error
Date: Tue,  5 Aug 2025 19:14:45 +0800
Message-ID: <20250805111445.313736-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

