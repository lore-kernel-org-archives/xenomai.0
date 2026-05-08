Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8273A5E78
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234334; cv=none; b=PsHodRqpQk7njsEtSk2+0KVgiFSKIFsb7clkA1TPa2n/3jAh4F0tJ60IIgbJ52parcIaviQaeB9X5iAV2EJpYfO+srt5BpHCG3Fd1BfowP8fnUEymXeTCJXzEaO3n+Hfwkr/k+uxfwzK7L7eWnVlbUVUJNHWwI2QM8alklSXctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234334; c=relaxed/simple;
	bh=giOY2/G3JSIT6mcz6n55EFtJ+DaqmbldshE81Gh7Z9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ921xLyAl5FHFxVUaXaY5xB2+JU/Ains9Nv8CDQFoGQ1d8Kgq/koGlMVPNqBpq8RdqLN8FVQG0W7VqljDxEs1olJhfnsFGAcf/OA5gZfedyiO/ZHYJ3YIKVYFBOYMKAVeEecxDIe3MdB9AwW5h0u4d7K10nU3RqmfJtterWe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=P8shjcHk; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="P8shjcHk"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605080958461b37493f99000207d7
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 11:58:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dFAfregsFLqwepWNpcrL18G5GDGa3OE8pdrlRDMo2v4=;
 b=P8shjcHkB25b+abayIxcb+Eo+mO4CA835FUV5MlFAppcy8IiXeLy8+NgBIoIhrr1FzkGYu
 up1NM0AnFYLQwcgyDj+7rzU4HV6xoVU/V8dH3kf13TnJvpB1Wq2hq9EypfmmfdMFtR9EEYIV
 k1Ye7TK86Mm66sntfVUW6t4AOwgKx4OjhJr6WqsG+TZbxT9tzrau2oYQk4cn2eIN6cPkfNWg
 yihiQOVZhFag94hdvO/8OEIMDHGEajtM0sC8FbCvjXmt+gXc5RdgZ8bszStvM9iqjrTFy2lZ
 TGGMLK12tyecdqWZ4Cg+VRAwR6wGVg4j+GSMhx+xLgpzLd0JU+1uruIw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/3] testsuite/smokey: Use XENO_CPU_AFFINITY envvar for psostests and vxworkstests as well
Date: Fri,  8 May 2026 11:58:43 +0200
Message-ID: <e4a337f1d8adbdf1c3112e64545c67ef8d850a62.1778234324.git.jan.kiszka@siemens.com>
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

Aligns these two testcase sets with 61fc9ff4b721, for the same reasons.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/psostests/psostests.c       | 10 +++++++++-
 testsuite/smokey/vxworkstests/vxworkstests.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 9d9639d441..a28ceea056 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <stdlib.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
@@ -51,9 +52,16 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
+	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
+	if (ret != 0) {
+		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
+			__func__);
+		return ret;
+	}
+
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 "--cpu-affinity=0", &test_ret);
+					 NULL, &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 26cd58c694..78068a4d15 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <stdlib.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
@@ -28,9 +29,16 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
+	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
+	if (ret != 0) {
+		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
+			__func__);
+		return ret;
+	}
+
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 "--cpu-affinity=0", &test_ret);
+					 NULL, &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
-- 
2.47.3

