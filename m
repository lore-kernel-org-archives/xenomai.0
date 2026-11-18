Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002560;
	b=oaVlCQycjp9CiVmyS2nxTouCGWaFneTsfsh9B13q2Gp1IekgCTUuCm/aFMSBBg6zIs3q
	 naSzQE044PYzMijks1D4OPFeHHHFXbpa5W1yaAJ8ME50EKi69LtDoTmjLDdNItf+t+2Uq
	 1B3dacAkN0YWca7G5EZWaIZ4f4CRb68YR3IGrAszcjAYGqYiOTf3I5l6+39dvfPMWLSXK
	 HERudZD5Qp2kvMcbCLeJLhaRhSBenRQzVPUphIkqm9hD2SLOx9ECoH9Vb0iFPDXV4CUXo
	 DCNfId088AB0ApBs1MZvHW/8+MIrING9NMYYE9iJV8FMzeGxwjomgPxBHHoF4SYPsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U91JOJicQfcMHRh+8VW3jKajIUxQKtRURzF/kjOKlV8=;
	b=UNWMY85AbmOWAK1HLDXC3Or5igf+wRL7BeEJ4Tu7KE3S9J87Wbb4qm238gkOMY89aYt2
	 bQYyVcXVBpzUGmdZMB4rIm24uY8b/Rp+1KTtxXBV4Fhu6ZjKTfbpeMdC/NcJFpAmX6U2P
	 nUy0YYXFjNc+yVbamn9EwQZl0Q4xbCBZ0M10hlXe76SmZHR3QOYzwV4jdDKg/Ovfc/+88
	 9m1F7OsKR19iqEQsTZhZ22DzJ/KlOdlhud0xdf9nsrEe7qeOj59B/S4/6fn37r8WrkbS8
	 5S4kTNAnzOdMatW/noqM6Rx274ABMnF9FqIRM0AuDtG9yM14AnkC9r8xELcu+w8bRpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=s+MQJhPp;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E99606A325
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E99606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=s+MQJhPp
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so1241219a12.1
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002559; x=1795607359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U91JOJicQfcMHRh+8VW3jKajIUxQKtRURzF/kjOKlV8=;
        b=s+MQJhPpvIAnc6Nh6iIiZZtuQ9G7E3KXZT8MfemRgSTr2zLCHxY67Ty0tSTAXb6aOi
         SOFnOrjVAXZaOEBn98NwhAgXaZWr7dbW9PLpUtJCBYGRnWZbaZpiw0QvBqW3zlZf3UOa
         e9tp2D9GHAj1VloAJq+jmUgtjmOkouJkWGTgB/sypEZTZsN37nLvkAaWO/ZZmaNqn6ig
         EKhichNe9yCd7jJz4ro5uPG0GdEgGCqMHHRvjL2ZeP7y7tq1gzhUj/fXjC7yNu3b4CyI
         qQF8LUzjHf1IwtjBXsqY+8LU7X8RDop56U9cC9YhZgzAYn0pnhDYklTtuS7UMHFI0ghr
         3p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002559; x=1795607359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U91JOJicQfcMHRh+8VW3jKajIUxQKtRURzF/kjOKlV8=;
        b=mhtS6NZlTavn/hPjGveGxAV94QgCl7w72IoNV0e1lb/65An9NDrZsM8XlMDX1C4oZk
         z778+T5t2sGJ0kKR4AleTGLn5u+h1eBZeqZSJLsI0VbFbwhv74qz7UkYChTRXKf4o79w
         4jiI6yh9d2OovXFiCWxP7uDSYogT6oRgCGodU0GMUBLFKomA0WsAHs8wESHSndULiKHE
         QcLoBP3GNznbGWfI/IDC0F90cZQDlAhzsjoZbI5HRPfwIexr2lzbRcjKWvqNka46QUEF
         oV4f3/Wsp8wuJIyOdkw3dlriUcFHJbv5UGuZe/4lyR7C30NHnvjlaJkMbPpJLASboGk4
         J2nQ==
X-Gm-Message-State: APuU4Z8dSOamfscDrlXRRihK5mV9QpJ7VOPbKtIVMl60VoqG4Va1TqvR
	r+C0LqbiD3GEmaIiwhViEid/qMQbatDa9DqNQ0+6aUcMTUsBphcUI4+DAt2Sig==
X-Gm-Gg: AYBFou3cVQjs+PPm6IN33pGstaO9Kvp+A0PmJRHHYQIxUXbzpQA/BW6a3SfIZqpXrQT
	yuViMeKXRqi11Kk2ZV54KKqaAwXPdUAHEzNQVWn2pVjSW3XPR4oj0UPQU+pQ/RID4K6o9dGqDbZ
	Y8bViZbjih/J/0acHkeLaD8R1PkaapttNXxPjc55UDjoxL1p4O2eBn2gw+lz+CzesnR8jPVQhYi
	SwcS9TbJB74lO0K2uzGC18kloeMJDKn2w6DViP9HzVpeirdx5cTf7JLIyQCvK2lD1wrOD5/tntj
	2Nh/RntZinc+rY+HQERKTpt0AANVydHkNLNieTcBtz4tlbSoy7a14DHkQbG4/PVMXQy4d0ppl+x
	0n56aEbTIxyoZ5G+cOOecLJv5/m24wd4mKkBdr/NvFuqpa7jiDzFAKM9HDF0pSy96HDOTJtWcqB
	AtNIR7NOHjUDGH2Yu0cPBupgn0MIw8QDtJ/vV4GJTHaR1EcVuze0FJaZYVhaxsyizJmS4UZm5KE
	FXrRQgpvfwfWmVD6fB2zoil/Eu7b5Ze4PpCufcr+8C46UGI61E49+UiBRW7uFEryleMIP+VUITS
	v4llGlMU6AsZ5bXVACA0qB+5WYxuhznHSJ54DWvZQFTbkouD0spzswh0q119i2dCZmPIILSK176
	4ev3bi8dEww==
X-Received: by 2002:a05:6402:4515:b0:6b8:8638:4e58 with SMTP id 4fb4d7f45d1cf-6b887ef125cmr1963493a12.33.1795002558630;
        Wed, 18 Nov 2026 03:49:18 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:18 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 5/5] testsuite/smokey: Fix unused variable warnings with GCC 16
Date: Wed, 18 Nov 2026 12:49:09 +0100
Message-Id: <20261118114909.3030884-6-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC 16 now warns about variables that are only incremented, which
breaks the build of the pSOS and VxWorks tests due to -Werror:

  task-2.c:19:42: error: variable 'count' set but not used [-Werror=unused-but-set-variable=]
  rn-1.c:15:22: error: variable 'alloc_size' set but not used [-Werror=unused-but-set-variable=]
  rn-1.c:16:18: error: variable 'n' set but not used [-Werror=unused-but-set-variable=]

In task-2, count only makes the background task busy-wait. Making it
volatile is not enough, as GCC 16 still warns about it, so drop it and
use compiler_barrier() in the loop instead, as the Alchemy task-2 test
does. In rn-1, alloc_size and n are not needed, so drop them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 +++--
 testsuite/smokey/vxworkstests/task-2.c | 5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
index 5e82d1506..3583aaa79 100644
--- a/testsuite/smokey/psostests/rn-1.c
+++ b/testsuite/smokey/psostests/rn-1.c
@@ -12,15 +12,15 @@ static u_long tid, rnid;
 
 static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
 {
-	u_long size, alloc_size = 0;
-	int ret, n;
+	u_long size;
+	int ret;
 	void *buf;
 
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
index d24c13465..614f79173 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/atomic.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
@@ -16,7 +17,7 @@ static u_long sem_id;
 
 static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 {
-	unsigned int safety = 100000000, count = 0;
+	unsigned int safety = 100000000;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -29,7 +30,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 	traceobj_mark(&trobj, 2);
 
 	while (--safety > 0)
-		count++;
+		compiler_barrier();
 
 	traceobj_mark(&trobj, 3);
 
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a..49ccfcf49 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <unistd.h>
+#include <boilerplate/atomic.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/semLib.h>
@@ -23,7 +24,7 @@ static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
-	unsigned int safety = 100000000, count = 0;
+	unsigned int safety = 100000000;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -36,7 +37,7 @@ static void backgroundTask(long arg, ...)
 	traceobj_mark(&trobj, 2);
 
 	while (--safety > 0)
-		count++;
+		compiler_barrier();
 
 	/*
 	 * Enter infinite pause so that any pending cancellation is
-- 
2.34.1

