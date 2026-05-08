Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D2352F87
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221397; cv=none; b=oPfoTbhWCWXU2SUxU9uYybI1Sq38YdAogavuUveHWBWBXGdNRlzL0YdHnM8umkyRy1qUOWi3N7IdvIMBiRYyE9X4yKdu8yjKUSmsfYtnd79KttnqGHZqvBPa+dgoVuO8rHpQUXLud1V3NY5zRqf/o0vMvtYtTbqycL8sZ9Kr3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221397; c=relaxed/simple;
	bh=NkmUfvFIOAVK96+HY/LdHu6Q26wWfx9+dg8nTCnG0qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwybKvD2FEwINrahm4z9wHfaCWxY9burY22F4ZwJb/kLFxrCTtlnosDR4aeI6TC1685l4CHrlb1lVCuEBouX9RjBN+qR+LarjcSz8avVGpmRXEoLI/8Um5xgPTddPDUxjS9oz/4ZDwXne6vSIyMIL6USTq7mMmueDrBnDv1W5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Th6KRtxg; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Th6KRtxg"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605080622592503347e99000207db
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1xqRfuv6TpyH9FnqqnQU638TZTSxRUF+TCaNiwGD7tI=;
 b=Th6KRtxgkpWzhzpGmS95tGoJqMpbRCalvp2kh/QSimqnoWk00cKV4mRfv5a4UNCnyV2vxR
 Fnw+5CGINK29gd58nuBSU+usZDwUCXZWEguU2VmPOncstcL22fkeHV2jUyavFi/PKqxRpQHN
 0FiMEoJqbVzXdbn5tnY9r8B2hP5dA7RzCjwt4H/WV3MBCOfdZXRzgCEkUz0zi0+Sm4FZ9gtF
 1dkztsGcFXoxDQUqfEULsQjr5JsLdb08qoS5ipHIuf4rsAVopP4ecOu5cnLv2bemzvmJB7a+
 b1oN3NxuM4pxKAYD10SEFVqUqzYGSpBR5CthGZnEDPF/gCF47meMR4IA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:52 +0200
Subject: [PATCH 19/32] testsuite/smokey/psostests: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-19-e449f2bd4fc2@siemens.com>
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
 testsuite/smokey/psostests/mq-1.c      | 4 ++--
 testsuite/smokey/psostests/mq-2.c      | 4 ++--
 testsuite/smokey/psostests/mq-3.c      | 6 +++---
 testsuite/smokey/psostests/psostests.c | 1 -
 testsuite/smokey/psostests/pt-1.c      | 5 +++--
 testsuite/smokey/psostests/rn-1.c      | 5 +++--
 testsuite/smokey/psostests/sem-1.c     | 4 ++--
 testsuite/smokey/psostests/sem-2.c     | 4 ++--
 testsuite/smokey/psostests/task-1.c    | 4 ++--
 testsuite/smokey/psostests/task-2.c    | 4 ++--
 testsuite/smokey/psostests/task-3.c    | 4 ++--
 testsuite/smokey/psostests/task-4.c    | 4 ++--
 testsuite/smokey/psostests/task-5.c    | 4 ++--
 testsuite/smokey/psostests/task-6.c    | 4 ++--
 testsuite/smokey/psostests/task-7.c    | 4 ++--
 testsuite/smokey/psostests/task-8.c    | 6 +++---
 testsuite/smokey/psostests/task-9.c    | 4 ++--
 testsuite/smokey/psostests/tm-1.c      | 4 ++--
 testsuite/smokey/psostests/tm-2.c      | 4 ++--
 testsuite/smokey/psostests/tm-3.c      | 4 ++--
 testsuite/smokey/psostests/tm-4.c      | 4 ++--
 testsuite/smokey/psostests/tm-5.c      | 4 ++--
 testsuite/smokey/psostests/tm-6.c      | 4 ++--
 testsuite/smokey/psostests/tm-7.c      | 4 ++--
 24 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/testsuite/smokey/psostests/mq-1.c b/testsuite/smokey/psostests/mq-1.c
index 83a24028ecde0e12db5d9bceb0fd31eb01bb5630..32bbc5abf637369b12d22f6504217cac522978c3 100644
--- a/testsuite/smokey/psostests/mq-1.c
+++ b/testsuite/smokey/psostests/mq-1.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static u_long tid, qid;
diff --git a/testsuite/smokey/psostests/mq-2.c b/testsuite/smokey/psostests/mq-2.c
index 8af8b42d6ef1335d0044c7b67e745436f0a68246..b4b6f6b22220f407dde88ef001995ffeb5522e74 100644
--- a/testsuite/smokey/psostests/mq-2.c
+++ b/testsuite/smokey/psostests/mq-2.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/mq-3.c b/testsuite/smokey/psostests/mq-3.c
index 4b6f2dcf358e04c87d68f11a954eaf956b41642e..38f27dc613d9cc62a458ee96de82a228b21b0dd2 100644
--- a/testsuite/smokey/psostests/mq-3.c
+++ b/testsuite/smokey/psostests/mq-3.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <copperplate/traceobj.h>
+#include <psos/psos.h>
+
 #include <stdbool.h>
-#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <copperplate/traceobj.h>
-#include <psos/psos.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 9d9639d441428c6ff6debeb3cfca361464f28f4b..b7de321429fe699d4c0a6e40bf42af1242fdc9f4 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
diff --git a/testsuite/smokey/psostests/pt-1.c b/testsuite/smokey/psostests/pt-1.c
index 496f1d07011e2d342cf47b8ea1bb12716d4904fd..bc08fa0f96f42ba68501befb24b73728c8b17af4 100644
--- a/testsuite/smokey/psostests/pt-1.c
+++ b/testsuite/smokey/psostests/pt-1.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <memory.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <memory.h>
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static char pt_mem[65536];
diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..dafe2f54cd795ac5d37c4cd7fa4d443465b5f595 100644
--- a/testsuite/smokey/psostests/rn-1.c
+++ b/testsuite/smokey/psostests/rn-1.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <memory.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <memory.h>
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static char rn_mem[65536];
diff --git a/testsuite/smokey/psostests/sem-1.c b/testsuite/smokey/psostests/sem-1.c
index d32334c02c17c4ae7557cbc2a4cdef0883e4cc5d..e86783c8185d9cd790db3dbfa38ad206ff034686 100644
--- a/testsuite/smokey/psostests/sem-1.c
+++ b/testsuite/smokey/psostests/sem-1.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/sem-2.c b/testsuite/smokey/psostests/sem-2.c
index 8223434f5e61573d7fcb112dbb45e939db30c055..15f9005d5b48018ec3af502b5651f2c13225088e 100644
--- a/testsuite/smokey/psostests/sem-2.c
+++ b/testsuite/smokey/psostests/sem-2.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-1.c b/testsuite/smokey/psostests/task-1.c
index a0e6efa972bea080b80fc3445c10adf03f642833..2a73b295299b52fc09fec064782585eea8432180 100644
--- a/testsuite/smokey/psostests/task-1.c
+++ b/testsuite/smokey/psostests/task-1.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static u_long tid;
diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..438b60e4c7896c86d9462b80c344ddb186daa18f 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-3.c b/testsuite/smokey/psostests/task-3.c
index d13e30423b28cd3e44d388af85178e02714ba91c..410a8b74de03275d6a501ca73a5c66a33d21d463 100644
--- a/testsuite/smokey/psostests/task-3.c
+++ b/testsuite/smokey/psostests/task-3.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static u_long tidA, tidB;
diff --git a/testsuite/smokey/psostests/task-4.c b/testsuite/smokey/psostests/task-4.c
index ec6a99609f94ab0f57f3c48ce28d486bc4b2fd59..e57860214d05eb82d278149e2bd264a1520638b1 100644
--- a/testsuite/smokey/psostests/task-4.c
+++ b/testsuite/smokey/psostests/task-4.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-5.c b/testsuite/smokey/psostests/task-5.c
index dcb8ec6eaa658833fa79001b81517bb5a8637c2b..dd00e8b7979548d3be7e7920ea6d537ca1219634 100644
--- a/testsuite/smokey/psostests/task-5.c
+++ b/testsuite/smokey/psostests/task-5.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-6.c b/testsuite/smokey/psostests/task-6.c
index 9cc46e63391b585b595589f79bf00c356dee3764..21a6b0f4c1839b148a89708071f73784c07affdb 100644
--- a/testsuite/smokey/psostests/task-6.c
+++ b/testsuite/smokey/psostests/task-6.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-7.c b/testsuite/smokey/psostests/task-7.c
index 9177dbbf46de77612c521be86562f82d1fdad0d8..3342b2d66117786b01f7f3dd2518f45d7dc57e0f 100644
--- a/testsuite/smokey/psostests/task-7.c
+++ b/testsuite/smokey/psostests/task-7.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/task-8.c b/testsuite/smokey/psostests/task-8.c
index 4543a04fade97a5e5eb214bf7da0a165d84c94f7..5df1238a06ebfe72f16bda411a4a70e5acad0d10 100644
--- a/testsuite/smokey/psostests/task-8.c
+++ b/testsuite/smokey/psostests/task-8.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <xeno_config.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
+#include <xeno_config.h>
+
+#include <stdlib.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/psostests/task-9.c b/testsuite/smokey/psostests/task-9.c
index f37d6736ed526c846499d0643644195b68d19529..e89cea937b30acf442e45befb41e6a725deae815 100644
--- a/testsuite/smokey/psostests/task-9.c
+++ b/testsuite/smokey/psostests/task-9.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 #define MAX_PRIO 95
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/psostests/tm-1.c b/testsuite/smokey/psostests/tm-1.c
index 64605d8b99ed550764d49e9dbb11c02236d754ba..30aefc0f7a5a8ea4cf27fb923baced8d4f03f505 100644
--- a/testsuite/smokey/psostests/tm-1.c
+++ b/testsuite/smokey/psostests/tm-1.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 #define TEST_DATE  ((2008 << 16)|(4 << 8)|25) /* 4/25/2008 */
 #define TEST_TIME  ((11 << 16)|(17 << 8)|30)  /* 11:17:30 */
 #define TEST_TICKS 10
diff --git a/testsuite/smokey/psostests/tm-2.c b/testsuite/smokey/psostests/tm-2.c
index 18ddff4b6e215ee5b70d35de2eedc8f95ff601cc..6d8435b97bed22d83e717c3f1093c1c28f8f26f0 100644
--- a/testsuite/smokey/psostests/tm-2.c
+++ b/testsuite/smokey/psostests/tm-2.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/tm-3.c b/testsuite/smokey/psostests/tm-3.c
index f5a947f463ea56d2dd42bf95ff65e81433626a9a..9f980f9cc0ded0c0a26803cde24b317f003a61fe 100644
--- a/testsuite/smokey/psostests/tm-3.c
+++ b/testsuite/smokey/psostests/tm-3.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/psostests/tm-4.c b/testsuite/smokey/psostests/tm-4.c
index 2c8c7a3189b2d98066749b121c7ab70940786e4b..badc0f14f695bf531fdfad4c34f3a76735da2b0f 100644
--- a/testsuite/smokey/psostests/tm-4.c
+++ b/testsuite/smokey/psostests/tm-4.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 #define TEST_DATE  ((2008 << 16)|(4 << 8)|25) /* 4/25/2008 */
 #define TEST_TIME  ((11 << 16)|(17 << 8)|30)  /* 11:17:30 */
 #define TEST_TICKS 0
diff --git a/testsuite/smokey/psostests/tm-5.c b/testsuite/smokey/psostests/tm-5.c
index d136133987c424aaa6bf73067c782a8def1d2457..9032f0106cd7b684e8de408aef372dbb720b30a8 100644
--- a/testsuite/smokey/psostests/tm-5.c
+++ b/testsuite/smokey/psostests/tm-5.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 #define TEST_DATE  ((2008 << 16)|(4 << 8)|25) /* 4/25/2008 */
 #define TEST_TIME  ((11 << 16)|(17 << 8)|30)  /* 11:17:30 */
 #define TEST_TICKS 0
diff --git a/testsuite/smokey/psostests/tm-6.c b/testsuite/smokey/psostests/tm-6.c
index ba92c3071f3cf0cf5977808cb25ecb0fa8fc1d3c..5872d00bcd9b6a4c9275e99d04418e511b3baa11 100644
--- a/testsuite/smokey/psostests/tm-6.c
+++ b/testsuite/smokey/psostests/tm-6.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static void task(u_long a0, u_long a1, u_long a2, u_long a3)
diff --git a/testsuite/smokey/psostests/tm-7.c b/testsuite/smokey/psostests/tm-7.c
index 3676502784ee83280c2211b412b82aac25cfe1d4..eb19bbc553180e2c84258109fbdf5b9ed1af3ce6 100644
--- a/testsuite/smokey/psostests/tm-7.c
+++ b/testsuite/smokey/psostests/tm-7.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static void task(u_long a0, u_long a1, u_long a2, u_long a3)

-- 
2.54.0

