Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DB304BB3
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274326; cv=none; b=NJ4t1GYRA/E0Gg7TfIRYx4FKL2QF/GUHVzXemQo7ShGNiIknoIwns00hq5/tpyLTgGUfAPib723L56N4eH+CpARaG74F/rXN0aSjLrurA7g7ob5AxuIOx7YTh9jOBm5bJ5FiGXn5F4w1pmPKgbp47d2jtVLUJ9mLxhu0CyBrxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274326; c=relaxed/simple;
	bh=uMQKDMT/FcJRdW+YuOrdDk218EE2dN3zNI94Ovr7afI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gtj4YDQ4AnenohLMf3+oK+zYhN7afQOHxsKsHyI2BYMHeS4sXBi5egezCkKrK5cj27DTOjF1mB3MNkY0iiyt8aAEvry/HjISXJ4VIM0PuFQ56yFBiDIt3x1d4sCsbRqc+23uWlaQ0U0gTS7b4hqE2jMSMquQRkrw9MMhy3HTzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Urlv3AMw; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Urlv3AMw"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260717074514ca203c9f3c000207cd
        for <xenomai@lists.linux.dev>;
        Fri, 17 Jul 2026 09:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iOr4eM5sDGZy/UySIZcAZVw4LwH//9IoV5KoFIyO2p4=;
 b=Urlv3AMwV8wEQ/rGXPgGWvDSjdX2GYzgCwCbSMe8lT6bMVVVRS0ofMpDVt+n28jofjZad2
 LJGLlh+lO5MojU41mMhhE3BLOI8MNFaxXN8QEEdmVgl5UPUJ12wSoM2zuU/7aTisCf4WGvgw
 ddYnO4YE2WEYxGTUCLrJCFzPfAbTqTTZAt7f1CHUgd8d/xeziQhCsOFzHncewRA1nhuL/Kqg
 zb95sb/WBWBcroYwlxlhspWIidYI93cjtUn1iwpkfAxRMn9zOYQcx+Q2L7SNgZK2TrVZd1Sn
 eXR9zuvkTg+YU5x3TnDClO0V01mvHS2LE6NZXAqFupmL1xu9HANj8sDw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 17 Jul 2026 09:45:07 +0200
Subject: [PATCH v3 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
In-Reply-To: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following compile errors:

rn-1.c: In function ‘alloc_task’:
rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
   16 |         int ret, n;
      |                  ^
rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
   15 |         u_long size, alloc_size = 0;
      |

task-2.c: In function ‘backgroundTask’:
task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
   19 |         unsigned int safety = 100000000, count = 0;
      |                                          ^~~~~
cc1: all warnings being treated as errors

The counting busy loop has been replaced by an interval based busy
loop. While at it: Enable this test for CI. It was previously marked
as broken. The counting busy loop was not enough to keep the task alive.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/psostests/psostests.c | 4 +---
 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 ++---
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2e62be4c1e437519f2fb37 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -15,9 +15,7 @@ static const char * const tests[] = {
 	"psostests_sem1",
 	"psostests_sem2",
 	"psostests_task1",
-	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
-	//"psostests_task2",
+	"psostests_task2",
 	"psostests_task3",
 	"psostests_task4",
 	"psostests_task5",
diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
--- a/testsuite/smokey/psostests/rn-1.c
+++ b/testsuite/smokey/psostests/rn-1.c
@@ -12,15 +12,15 @@ static u_long tid, rnid;
 
 static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
 {
-	u_long size, alloc_size = 0;
-	int ret, n;
+	u_long size;
 	void *buf;
+	int ret;
 
 	traceobj_enter(&trobj);
 
 	srandom(0x11223344);
 
-	for (n = 0;; n++) {
+	for (;;) {
 		size = (random() % (sizeof(rn_mem) / 8)) + 4;
 		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
 		if (ret) {
@@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
 			break;
 		}
 		memset(buf, 0xaa, size);
-		alloc_size += size;
 	}
 
 	traceobj_exit(&trobj);
diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..21497433f1a3584184406b172c367eacd5a8b127 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
+#include <copperplate/threadobj.h>
 #include <psos/psos.h>
 
 static struct traceobj trobj;
@@ -16,7 +17,6 @@ static u_long sem_id;
 
 static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 {
-	unsigned int safety = 100000000, count = 0;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
+	threadobj_spin(2000000);
 
 	traceobj_mark(&trobj, 3);
 

-- 
2.55.0

