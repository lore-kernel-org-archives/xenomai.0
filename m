Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75656429818
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676619; cv=none; b=iiY6/I5ZUV6DspvwWO58egqmQMNjXlDGHoNVUPtaCZw0qcRVxY4VdkGMT1cj3v2x7d/CBJj8Avy1u/6GurzYa5wRG/MaPatbFwlKe8LcSwK7hDO9wi9AoH3FmtFGj4DPtXOgcY3r4UxrsuIwDDdoCeuL5oPkl5TWKDlnGDu6Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676619; c=relaxed/simple;
	bh=dM17CvlymoyfNAK8NE37c830WZWT+nBY7QNVCt8ppGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiWoEKgfe+H+hlHiU7hfvLi2UU0ICPv/lcTFzcACh2OrW3IL26cnSXFVoDsdcwuCpTCVTpXZ2e5Yhv2U09EP8smYAog4+J6TeXoAcbnUaszDumGmqXqAwL1EYAt1XUfTLYIkcgzbhUtTISJGR+D3IxGUw/n9cnAQRepJ5MYNxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fttLZYwC; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fttLZYwC"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260513125014b89e0b68740002074f
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bzClev9fBs5lJ5gAblnAmpRUNMwpx4580mOBELfRT9A=;
 b=fttLZYwCMHb38TW9dNMTnk785lhokjDlaJRmtGR3bPyJ9DDpoXv6/0l+GY0X5Jw0wz2oDa
 d/28+U2oJNyoLzTs/3iBMiJ+RqiP0op6evUYOL8t1Ypv25dzYwNMAGdT6sjFGaC3vroTykJD
 VLVlLhCOIGNm5IA7gXEEpgi3o9feSS8eatVNvGf+83+fRfRgMelxDD2djPrW4KXWrFT/xCRE
 NXmtSPuRc2CvefnA9Ty4qRXCibV58FWWpz7wk3PiIu9vh5pK2ABygBb8Pkjo0Yts+A3LMZAK
 tfEemlLMklVhEQSbCaxoJnejEE+oq9hJwXuEBpIkIJiYtEOEVBeZX/uA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:50:11 +0200
Subject: [PATCH 4/5] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-wip-flo-gcc-16-v1-4-120ae1287401@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
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
index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..dfe9724a8325b821a13c34c9ddaa3aa4a0e37073 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -16,7 +16,7 @@ static u_long sem_id;
 
 static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 {
-	unsigned int safety = 100000000, count = 0;
+	unsigned int safety = 100000000;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
+	while (--safety > 0) {}
 
 	traceobj_mark(&trobj, 3);
 

-- 
2.54.0

