Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746D1591ED
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748331; cv=none; b=QElO4EpRILwYYmjM4XuK9pj7vRAdmmtgZT938aGeBZ12DJCBou3Mr+paRwez7kBRI6AUDaHBYChQAsWnL6lypRemolDYNE7Wd8rQmm3OzNBvPbEENKptkQZKyao+FjJTYbi70uUixjpRH/noD7r5FAB9MYGPnq3+p+lcevBaTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748331; c=relaxed/simple;
	bh=1YZyC5QOq5NrcNk7Qj/bnioLuXI7IbqeB7dlB2Ncv3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKtvKcfumy045xyoQXIruAGd5xnWVW+3bIpfIP7D5USuP3f9ii7md8hpOdvM35xGvkhFXQJWkTpNbJN03xG10keHh3JRtrylHPyLRBuv4Yf5rbbbdxw9tA5L98QI7mUddA/SOzjIRX+sb2+aa2bjKDmnPGEbVXX9E7p398jwUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=rIB5Y2+D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="rIB5Y2+D"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso57808225e9.1
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724748327; x=1725353127; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYC0wkHrlKstCsHNzZtMFCMAmAD6DMJkd2VlfVZZGiQ=;
        b=rIB5Y2+DZtxVKMTn2kx56fuKoKfvuUs1hNF+BR/+//389718Vn9Ey1q/DARg3qk1km
         OplkhxexZOHvoR0pqkYgHgSmRWxjzykmq4YBjGyMRCZAq72nGifIY9hwsK1WcuuM/WEx
         0s4cLeVDDwldtBgnzTkBd6v5M2CDbeWWT3wGF3qH+ikCdn1dHZ7ZvWfjg3fovrPTee4B
         suND/gWFAnfTOgaODXw8m66/E+m66Tec2c/4X9oExfb0RGxD7OeyiKvweJHrDC0SfUwl
         zyUo+8b9N5l7HFDw/2mxXDTynYISBIYaHzkcv4FLdsDz3zCuxuWoHe2Lu70GzHw6L4sA
         EG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748327; x=1725353127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYC0wkHrlKstCsHNzZtMFCMAmAD6DMJkd2VlfVZZGiQ=;
        b=KrNs6Oo3XPhx9cide+KEJh6gYXxvUSo+U+PHTRM8uDKkGKDdeeWQ2G/X6DHeknWPJ6
         vrsy+6LZCH6SOQQ3ltYs+wqXw53TXoKzmEhrB2vzp7cNNSfsHOL5/ujA0fYuclO1LDLL
         cHMBrJJHIAdDvPN8Izh9A4ndo4rgiWIa1G7f0TcJ/hy0R4oirb1vbsVu1F0iOavph1bh
         soV43J/rPIl9NjprFCCq8ilbHDruuNpm0WqS4cC3iOgEY48pwtV4Wlmy0FhnCQO73bnx
         c9GMJYIQ6pgVznzGjWDlPpBQwR5CLebryHvk2OBMrL3MoZXQIoGPrdwWunrf+Qw3BEqu
         LbrA==
X-Gm-Message-State: AOJu0YzM11rZls+SCodCSi07WhusrSN3+0H4rwKHy7zJLs7ZP6rGScCm
	2ueUMzJ0lgH4hmpZ0aTpTOJqfp4KXcJJ810lAsvQArNvKWa8/SseUJCpkNdT7v1thu7n3H3hig2
	qWoc=
X-Google-Smtp-Source: AGHT+IG+ifa1c16B5IpsKgghhN3qIMUTnoXU95GksTsF8TD045pwWR2ttAQa32kXzGODUOqqdb97CQ==
X-Received: by 2002:a5d:67cc:0:b0:371:8283:94c1 with SMTP id ffacd0b85a97d-373117be78bmr9972139f8f.0.1724748326725;
        Tue, 27 Aug 2024 01:45:26 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm211779435e9.17.2024.08.27.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:45:26 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v2 3/4] alchemytests: Set cpu-affinity by env var
Date: Tue, 27 Aug 2024 10:45:20 +0200
Message-ID: <20240827084521.13547-4-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827084521.13547-1-simon.graber@sigma-star.at>
References: <20240827084521.13547-1-simon.graber@sigma-star.at>
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

