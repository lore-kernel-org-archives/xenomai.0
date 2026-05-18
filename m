Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C5388379
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094975; cv=none; b=DwpLXgpViJwNCLo+t1Vy0ohhbs71Z7q3SrTmumYX17fAjkjDK3VcX4aV9Z6nSKjavYmJoAscx/bcxQ5VIax5YKTbXZ8YdrrDYmDacZUdWgQyP71Pe2T1/7D9b5MYzbr2CGkmuRqod1s3+x+Yy/SUcPcqF8XID7AGSV7PkGLzB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094975; c=relaxed/simple;
	bh=pJz0eq4BoQjQK36Rh4uLEMJ6YwceWRKec70rDwYJxz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImfyxO9sPMFUVZZtTDEDDIUSGAJ4o2s4rW4A6N9i4qZKAX+SNcuBsb3oFwC2cTZ3RQOSH+T1Hnef6QJ6TIRUizGisSBafpRIlLdRH0pkzFXQRue0Bc74mRc2s3MWETNzZ7GJRvT4gnKJCM+joScI/2AzQAfGXZgeHCpER0WJiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Dfndk3dh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Dfndk3dh"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605180902447dba8ae3e3000207d5
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:02:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WgF35QuL6wFtlrPGaUyNDs9efMxwYp6dpaX0ovlHAhc=;
 b=Dfndk3dhYqeWn1//c97wZonR6MeaztXJw6jeL6IThvTEoN8/a0mEsJJ5yAkDNzXBBB2Ku2
 MmBTD+8skOCpU+KtvemNEYcEByM/PfvDgGQJSDAif3F77a+ooRk5G9cXhsKUtEqQddK+kEwN
 ip4Y5ORohIitoF13HLFwufACGfV1BwWt9AcHFas8AD3T/EUomE5zZO5HB8O8r75WfBSOqYpA
 2d6xqBfvZW0zoX/zEssFC8ctStjhufk42FMjfHc2E9Ro0FigZeiByFZWlUGoyLDdVnVswaYj
 y8cU3n68TPmsH/741WidLcFye6zjYf8ggjmy8VjeYSH+J2MHRocsCuIg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 May 2026 11:02:45 +0200
Subject: [PATCH v2 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-wip-flo-gcc-16-v2-4-f93562624fb4@siemens.com>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
In-Reply-To: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
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
loop.

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
index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..be1b6ca18c5354ba092d55b3655bae9a294f2ce7 100644
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
+	threadobj_spin(1000);
 
 	traceobj_mark(&trobj, 3);
 

-- 
2.54.0

