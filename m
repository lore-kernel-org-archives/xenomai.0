Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145583BED5C
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582915; cv=none; b=N0I0HGVY8I89a+na7HP7d1YpAi9VRAE3Rj1P2CcJF9zkln1sVA+GMDPwQNcHaXXjzOGSDJ6hnrNcrI+GL6mp6RK5SG3fBSc5obDsuNSOQWL/McZ7VvClcCDtrYmCK14iSwZHZaBqg0unlulbDmE+oBD9yxTMAnfwsHaUvJgJHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582915; c=relaxed/simple;
	bh=BYyAcNE8wmWXv3xWuDdV/NkQSSoEUPcV+KRGTvEePWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaYiEZzAvmnyT7XFz/YW5P+g0G4OhgxXUik3KQ5YZY3bPuhtVux+EFwPJcN+4RukrjuNJhpyWSYXRS14Y4szDNYlF+7xUq5oncGty1VvLH9xpR1N5i1hTwtmgCi6L97duWnwm3q2rRSuoOsCyY+36q/kg43Ngo2aIFb/sbmDWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hp31Vo9P; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hp31Vo9P"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260720212826a72c274e0b000207d5
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 23:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jwfnUbrdaGH4KRPRjNDQqBdw/WRm3s2439rED53ENeI=;
 b=hp31Vo9POyKlUx1LQNOQJxtYc9zXvjATBzbLzZ61UZne9sllWt9eSOczU8lT85e0Cm0Ulv
 bcWNEzo1kLB81pnA/eMrG3fWZTcVvw22VnhHzZvQDq0rmBqGrwXTGNpcMoNFQoHUHA0ZY3+Y
 dwJyuUh625Hx3OgYeT7I2Z/1vh4ooxgiHmzhrqgs3729YdKmmu9q1B7+rn0WFrPEwziMyclX
 z43czqqnvDBMr/deos3z5QmOO9kVb0Uxth3T6UN8o4pdJv0gporvoPCL9cuNGQyk5JIEs1QS
 abLk6JlAevhuG2MuOVf9OGmSe88xFUMh37sLdudifT7WIKQUd6jbMFdw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 20 Jul 2026 23:28:26 +0200
Subject: [PATCH v4 2/3] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-wip-flo-gcc-16-v4-2-f281a1f0cbd4@siemens.com>
References: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
In-Reply-To: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
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
loop. The counting busy loop was not enough to keep the task alive.
That is most likely the reason why the test had to be disabled on
smokey level (and with that for CI).

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/psostests/rn-1.c   | 7 +++----
 testsuite/smokey/psostests/task-2.c | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

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

