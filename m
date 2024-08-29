Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71D18C033
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920537; cv=none; b=Tva4MjzshslWh7gZPL31sW4vVevI1H6GCWTbvOHSgXQSj9TFmlPNVaiJ7TeqEOlrZlQDx5Hlb0sKF9RjgW/lqRhH0UZrrM1PVWGhSOTrvrUnag9CA5sRLV/Ia202timsR9jhRqJLPDKgrOtXDsuwGhPeqioei3zaaQFTUlKmHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920537; c=relaxed/simple;
	bh=JgBkFfbMy+dipn325WFy4tZ2F2eGCen0uC3uaizhnCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBJjWPcCf3vef4zefyIZJzPtk3i5BkQzI7b+ww+05wYP6+AITiT7dzoiRxqyYn2kkDi1WAoWJnMbGC7GFd27+JHuJguQJiD3eWCO4WF9IsqoRU66qZxidrKunxokuQKUCzI5zGHXiD7m0zOL1A7TSax5w2pNr3rWZKjI+F18oWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=IxEy8Qyy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="IxEy8Qyy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so3284685e9.2
        for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724920532; x=1725525332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MtE3qtIKl/WAcJ2vxmFuMRQJcMRQpwutG60VbYD4Kk=;
        b=IxEy8QyyTEi3344/79k3xSHhG3F1TEtMuIA56gvK6D2MfLHDWlE3oekh/TZ83vf8Vb
         kH/z0vGC2R9bXbFwsV/HDukejSp1nSU+/dQA1IBCVJeCD3VrnXiO4Dk+GXPanPJjkBjS
         sok9SwKKOfbDO+WF6AR/BsTbzHEJqQoGfuCpZ15mhv3G7GVrAhI/KWdv3/DzA6ejIBcW
         vMHq4ctQxvCJtJ4wS+69Zf4Crun3jkpCceuONljck+eOZrt3YywCGkXXs7ppREeBb6/h
         qgq4/FbVlkVEtCN61wT3UodF944CQrP6rlsUoC7/0SpY2OwFH0r6O+FsCHVwupbI1diF
         DWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920532; x=1725525332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MtE3qtIKl/WAcJ2vxmFuMRQJcMRQpwutG60VbYD4Kk=;
        b=wvLCHzM0YRvySYo+qjH58TGoh5GYotGkkgwk0hubXSqiLjJQtiyEn1vJF5pYeaay3s
         jvxSnPe/wnLCERBITzaH2ACu7EEb8C97Aa/bs6pe/oVH07WKx7espzW9HHj27pW/QC8z
         E9KmE2tMkCfIeJb9tQWD/x5ggsH5b4g9X7Bd2Bx2jfu1Mn+HshnS5V5qWJkA07GF2cEV
         IwSDSGi1Kp98/KYdXbYXyKGKnyqaEooWEsqu27Hdk/gCM/hdvost8dOqWQska3EBwIpO
         u9xAKtJUh1j4SU8gmhVCU6a7Zdgj6QE78KPzgjWkCWpuS1k7QZ0wyjXB2CrVEFqy05Mh
         +ydA==
X-Gm-Message-State: AOJu0Yzh82u2dzH1KNuCaijPAvQvVSLH8iHoJoE9eWdYYjOCrdvKzio0
	XVyXj/xoMx2PF9MDOAi98KI6c43PUuEiSOH1FT2BHl+F1UOt7LDsDU+OhF9s0RKfNMkic7Tsp/A
	9Xw8=
X-Google-Smtp-Source: AGHT+IFHUDSs4ftetN7GybUifzgSUuLjzqo6D05uYnsYIJH1u6KVv7h++62wVBKsYU+QXGYReErllQ==
X-Received: by 2002:a05:600c:474c:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42bb02a82c4mr17979375e9.17.1724920532089;
        Thu, 29 Aug 2024 01:35:32 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm9995815e9.15.2024.08.29.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:35:31 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 3/4] alchemytests: Set cpu-affinity by env var
Date: Thu, 29 Aug 2024 10:35:25 +0200
Message-ID: <20240829083526.24536-4-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829083526.24536-1-simon.graber@sigma-star.at>
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alchemy test runner can now make use of
the XENO_CPU_AFFINITY environment variable by setting it before
dispatching to the inidvidual test programs.

In a later patch, the --vm argument will be passed via an env var too.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index cf9f970f1..edbafe6e7 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <stdlib.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
@@ -31,12 +32,19 @@ static const char * const tests[] = {
 
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
-	const char *args = "--vm --cpu-affinity=0";
 	const char *const mod = "xeno_rtipc";
+	const char *args = "--vm";
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
 
+	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
+	if (ret != 0) {
+		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
+			__func__);
+		return ret;
+	}
+
 	/* Try loading the xeno_rtipc module as the pipe test depends on it */
 	tmp = smokey_modprobe(mod, true);
 	if (tmp)
-- 
2.46.0

