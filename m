Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5A16DC15
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314097; cv=none; b=Mr0kN/f6NW6VGP5J+G1POVPEdGvFmefNeqvrvNFt1Pm0BSt/+L79r2Cyt+yP1i5WRhCW5evu+uEV5paNCWs7BwlJ9aRIO6lVVyQA38Mk8xBTL1VZhHOv4EQ0DQNsw4H4WlUmsvMmKT3RaZVrDsAQOkpjGFLBFd4R1SS2zdpYymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314097; c=relaxed/simple;
	bh=AYZhpRsHL7nTr5RFStxpsUs062HTZogN8GowWnQt+Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ7qRNqj4dgBhRD653Pwi5meKKAXJNskYmA47MVkuR+NFTQrrWGyQNgXsUdGyR6wHWw+4mh9OehUyW7ESoh9vTtqBJGmsNQi2ovwq9bS3vU5MfIlobw56UUJRJxg6VUo7xVw5zNbh3yW5W46qHi0k2FlhjZHCFmmLeXxYi22ghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=BJvkcSkM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="BJvkcSkM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso3242525e9.0
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724314094; x=1724918894; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LS/uugV5d/jQBsioNNdagOU2FAwIhwZi3UR5ZPNjA=;
        b=BJvkcSkMYP03fDJ9GZg7YC7L7ycno2RmSTU5AsTXYrU3jdnXPBj3i8LPAbR/S7dPcn
         l2rhS70qCq15NgN5O340ZKhx8/l2IBD9BdYtXG9aDj7tjfw66VzLm0QTQI3TZgXU9gK1
         xwluJLV4QSp2hcyNjGjsb2xWThLfAKIc2hUxKHayUKnDx4xtKvNoMqtJ0OkVEv139Mv/
         nch/eUWJVLbaMYd6N83I1H5MIgH2/ilTbb1V00TCinGCCXvXoyzlOHmbkzIqCRn/aTwp
         IltFGllP1J45z91ludsxLM2rWQIAdw6apPiKAzmjYdLbU6XKJtbIZLKo5p4/dwyscXtu
         NQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314094; x=1724918894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0LS/uugV5d/jQBsioNNdagOU2FAwIhwZi3UR5ZPNjA=;
        b=ePn+D5Ze5Bnnw0oSZVuIf9N6KLH0PCNEVuDT0hk5kvivltLjCkTbYujrnsWs41bqeN
         xOtVhtlugtawKtFAB7YqPVlQ5a1HHuhdDiMLj76FgSJmfybZoWRyGtBsQfWN8pqVnnXv
         aBrBpa4Wuxg4kZf92ASPb/VtZRPQdNGTtZk5EJCUVv2FIRqORwUjaONGkFihbkP7rfeS
         ur2UYBCyjJkxsAGL/sFlZfcAUz1EjeakwgJOdNO30As6aMNgbu7XLOOeDvW7FafVCLvT
         lyP/G+z7kxjhs8B1azanroRmvsZXr+uPWGzFLHpdOWAzDDQTpjSuk2xoRjYvSbvhmHcH
         lJ8g==
X-Gm-Message-State: AOJu0YzUGzyUkH0qnK2tR7Jygnr6PZNFFiz+OOZCyyrWAQoV5d7tWEcX
	PF1FupWIgwo6cVPgLaUk/bEHQVmNE+ZpguqkTCFIbjkW2hX45b8/fSu/xwr5hRNB8QIdnrJjLUY
	YHAs=
X-Google-Smtp-Source: AGHT+IGO5oeK3+4oeOZCMpJlaJHz+PqZVDi+ShzDSJX+2LnCG6n8Kq68JTAkxZef2XXsAgRD7COmKw==
X-Received: by 2002:a05:600c:3552:b0:426:5216:3247 with SMTP id 5b1f17b1804b1-42abd21f4bemr31299585e9.6.1724314093764;
        Thu, 22 Aug 2024 01:08:13 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm52565255e9.38.2024.08.22.01.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:08:13 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 3/3] alchemytests: Set cpu-affinity by env var
Date: Thu, 22 Aug 2024 10:07:37 +0200
Message-ID: <20240822080737.17939-4-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822080737.17939-1-simon.graber@sigma-star.at>
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
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

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index cf9f970..edbafe6 100644
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

