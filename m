Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A923A874B
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234335; cv=none; b=Xzy0ZW1E+cSse70bjUZw5mzPeXUrh8oh/aBSdo/L28B7b67A5CwXgnMdKUXgWYDGemFNQYoRzujWv3EZ4ciP6hLCG+TDKQkxRtgGC/PZH6wsdPjNDkKXPhEW23mp2s8QGNMS9cErXAgsHvYbClWAHrdD1PfDPhD972xgxOhBXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234335; c=relaxed/simple;
	bh=dJDvtPnMvJKrB2pZNboeWXoJjz7Q2Oql03/a9BIWLho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTAaMODpIxgT8azTFfxAYbv96tAaqp9fuuDr3WVOz7UOCabIr/6czzy7+G/gzuSrbppp5VumOMXP4KC6J4fGXyrVld1VhTBEOCbetzbhbjhbJWUa0geI42tvKnFMysnabTBByTmMxudF45NNJSf/LVR1SUlUmL/dmxvQ/ON7AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=hbypEsVB; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="hbypEsVB"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260508095847dd5b3cdbf80002074c
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 11:58:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HOcH9cxmC2X/GGg+1Vx9Y7lMQwK6fI6wzwtqEMappzA=;
 b=hbypEsVBhSWvdwHFXgMBROkadevuGk/R0PsNbYkVlRZ8vHBb2/6ZuLt9dfMW5RKZ6WnW63
 +7++IzEgmlkpXlEicX2HNb0FfSD139fHYy7QFDjdOSsRroeBY4xDGkDUJ1cU3YyIkEe1/BPh
 ofV5ZYAe9GUxcIsueMiEG9/loYvpCm1Bql0Ian1iU70amwo/q+gbC9A0989pK60Xad6cjL6I
 IXZwokfPaV/WAwNFOUQQU9jLYTzWIKHzvHbruD5RnKEla1cHtd2yUo8ma/YmOgaFTWBmxQOl
 dd41hKDEFyM+GnIeu8K5g9j1PCSkZYrRVRVW22jeiTyOhcsMMnwNgqNQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/3] testsuite/smokey/psostests: Avoid timeouts in over virtual environments
Date: Fri,  8 May 2026 11:58:44 +0200
Message-ID: <f188ef4acc2e470c5224073a0bd5f81259e5b651.1778234324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1778234324.git.jan.kiszka@siemens.com>
References: <cover.1778234324.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This was seen over QEMU:

2026-05-03T09:42:36 [2] at mq-3.c:31
2026-05-03T09:42:36    0\"071.079| BUG in __traceobj_assert_failed(): [TSKA] trace assertion failed:
2026-05-03T09:42:36               mq-3.c:32 => \"ret == 0\"
2026-05-03T09:42:36 [1] at mq-3.c:27
2026-05-03T09:42:36 test psostests_mq3 failed: 256

It's most likely that we ran into a timeout here due to QEMU not being
able to deliver the messages to all receivers in time. Just wait
infinitely in such cases to avoid spurious testsuite errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/psostests/mq-3.c      | 10 ++++++++--
 testsuite/smokey/psostests/psostests.c |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/psostests/mq-3.c b/testsuite/smokey/psostests/mq-3.c
index 1171a70544..4b6f2dcf35 100644
--- a/testsuite/smokey/psostests/mq-3.c
+++ b/testsuite/smokey/psostests/mq-3.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
@@ -12,6 +14,8 @@ static int tseq[] = {
 
 static u_long tidA, tidB, qid;
 
+static bool on_vm;
+
 static void task_A(u_long a0, u_long a1, u_long a2, u_long a3)
 {
 	u_long msgbuf[4];
@@ -27,7 +31,7 @@ static void task_A(u_long a0, u_long a1, u_long a2, u_long a3)
 	traceobj_mark(&trobj, 1);
 
 	for (n = 0; n < 3; n++) {
-		ret = q_receive(qid, Q_WAIT, 10, msgbuf);
+		ret = q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
 		traceobj_mark(&trobj, 2);
 		traceobj_assert(&trobj, ret == SUCCESS);
 		traceobj_assert(&trobj, msgbuf[0] == n + 1);
@@ -56,7 +60,7 @@ static void task_B(u_long a0, u_long a1, u_long a2, u_long a3)
 	traceobj_mark(&trobj, 4);
 
 	for (n = 0; n < 3; n++) {
-		ret = q_receive(qid, Q_WAIT, 10, msgbuf);
+		ret = q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
 		traceobj_mark(&trobj, 5);
 		traceobj_assert(&trobj, ret == SUCCESS);
 		traceobj_assert(&trobj, msgbuf[0] == n + 1);
@@ -75,6 +79,8 @@ int main(int argc, char *const argv[])
 	u_long args[] = { 1, 2, 3, 4 }, msgbuf[4], count;
 	int ret, n;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = q_create("QUEUE", Q_NOLIMIT, 0, &qid);
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index a28ceea056..289d563ac3 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -48,6 +48,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	smokey_note("psostests skipped. --enable-lores-clock missing.");
 	return 0;
 #else
+	const char *args = "--vm";
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
@@ -61,7 +62,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 NULL, &test_ret);
+					 smokey_on_vm ? args : NULL, &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
@@ -72,4 +73,3 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 #endif
 }
 smokey_test_plugin(psostests, SMOKEY_NOARGS, "Run external psostests");
-
-- 
2.47.3

