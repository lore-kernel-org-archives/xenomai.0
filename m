Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC1364953
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221389; cv=none; b=V+FYkij5Twle5Yt9D+YkunMHra3n5TZneVtsi403vJh4jEzvqJOxhzwXKwuE1GTG/5VFsLAGy/ycz8VmQIIvUhNgWzxZPAglSdNuR3UpiZ1JwarK8Isi+MeK//R2pa4uNMS5IHOprSPotiuIemPXxU97ci29e1b0XZ5OtqGXdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221389; c=relaxed/simple;
	bh=7fCmbhp5/ttPTgUV0muWnj+levCYDi9Te5RzVcpSQoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3pVGbHxtbImbj3FcJgWTe8qftqAu/wQpwr2uLZ5ljhhypsj1TXfkDoAhm5utk1iq5GDY5W7XHaaaMwj/e9ivZaNMA0bFp24NGFO9eMGHYH4kAKAotmdboTViOJEnI/+hDIwpLja2t75L/5kYYcVBT4S9toe2HJH0zsoLmpSkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OAv0iZRr; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OAv0iZRr"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026050806225770ba8a377700020712
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q3IxpEX7FeRT39N35gaIybcnl1s3u3M6sDNwEaBjykc=;
 b=OAv0iZRrwP140aSJa2UfXjoohqn/GCt2YVtKtwDTx4FWzKPHMlc3mZpASN51oyC1yGtPMT
 YieF2OXRY3ZWblqMHB2wYAg2f0VDiaVQlWFKLagu8RoZqThuiJKwXVwCmIUTwk3AHYcDACm6
 QObkk08E0nclBx1x7TcP9tp9c59yexWwS8QFlY8FAR4d+ZfsxRmyrbqdGSXVpt3Gf3VqclFW
 4iEYq1YMTXMrh3zi/McnPrCAjfeDU+ngARGiL8qos+PVoXbZmfX0HH2G/p3iXWjvGTjlnxin
 OGysU9Mac0I9ttJxeRonex91S7+4MRIINwHkhQ/d8czREtHFeaBlMeiA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:48 +0200
Subject: [PATCH 15/32] testsuite/smokey/arith: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-15-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/arith/arith-noinline.c | 3 ++-
 testsuite/smokey/arith/arith.c          | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/arith/arith-noinline.c b/testsuite/smokey/arith/arith-noinline.c
index cb10e6445612e079dd7865a8a8fe81dc9da13dad..d806ab73f9dd8fc38c2a4987f35729e38e923ab5 100644
--- a/testsuite/smokey/arith/arith-noinline.c
+++ b/testsuite/smokey/arith/arith-noinline.c
@@ -1,6 +1,7 @@
-#include <cobalt/arith.h>
 #include "arith-noinline.h"
 
+#include <cobalt/arith.h>
+
 long long dummy(void)
 {
 	return 0;
diff --git a/testsuite/smokey/arith/arith.c b/testsuite/smokey/arith/arith.c
index edb87229a08cd6f14d4f95c292b4bab7712e22b6..25bfe97af7fc9cf1015838f38ecaeecc1d305cfe 100644
--- a/testsuite/smokey/arith/arith.c
+++ b/testsuite/smokey/arith/arith.c
@@ -1,8 +1,8 @@
-#include <stdio.h>
-#include <smokey/smokey.h>
-#include <cobalt/arith.h>
 #include "arith-noinline.h"
 
+#include <cobalt/arith.h>
+#include <smokey/smokey.h>
+
 smokey_test_plugin(arith,
 		   SMOKEY_NOARGS,
 		   "Check helpers for fast arithmetics"

-- 
2.54.0

