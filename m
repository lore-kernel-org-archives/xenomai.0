Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBA3630AE
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221402; cv=none; b=TTyqwoNh78+ORdFm3Q9zdTzfxhA9ROhDj3xKbXk4NepoEDWxxcMheMCMoF8XsiLZ/wGXXVXcnaG20agllPXADfZJkNdlX99WPqJ6m1HAaniVjUV0IPgeeYw+222iN85YGfCP/kvn2dYFFlS3nkTunanWPtc0KheA2aTcpNfIfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221402; c=relaxed/simple;
	bh=XeVnZiJAySQ4G1pRXIX5gMqVovqTXl2Pfe07o4ZULac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB/q+ucO1ox9diNFahK1vtrjW+RzkDbkN8twjfLresBtkGtNGFv3nDVQtDGi66lvhS2bL/0/E0/a20xAfCSLBUwG1RNO7UTJ6Rlac1ELRokMGEffiZkZKwsIXFGWH0LdytK8NgKjk+nLI7hlneJqNNN/HXDWF18ETBLmLc0Q4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WcfbrOPn; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WcfbrOPn"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260508062300e63a1b6d1a00020794
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zjhye1t0qvNCU3wGBw+0KY6+RkJHISntttMr4NMzMYk=;
 b=WcfbrOPn1KhUaiwagD/JT8n/HTyAODUfgh/byWl6p8EJlT3D017d0oOXjwC2LjnCYxSECW
 122p0vnM+tXMiC6qpIu5CUrmbrxke9eqkKN2V71FENKgZ+SM8aHS9+wHKJhbBeojdY3YJFlZ
 08FN7T9d/3ZoSjumLd730hdhRj40IXoPaoLHR5j7YDE4xXjBqTdmWrNqVeRCfzj1tukDoEqH
 7ZG8Az2Nb8IrCYobdWY71ws2WNT/VPteVpw8PPwsMMaxlJuR1tfhSDDleL8SP/7Y6Oh+uS4W
 QOTxVy/8psylx69cScL+qn7jUbF2WkuiEgrqVsa0HXK/z93sCwhDFrsQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:53 +0200
Subject: [PATCH 20/32] testsuite/smokey/vxworkstests: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-20-e449f2bd4fc2@siemens.com>
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
 testsuite/smokey/vxworkstests/lst-1.c        | 4 ++--
 testsuite/smokey/vxworkstests/msgQ-1.c       | 4 ++--
 testsuite/smokey/vxworkstests/msgQ-2.c       | 4 ++--
 testsuite/smokey/vxworkstests/msgQ-3.c       | 4 ++--
 testsuite/smokey/vxworkstests/rng-1.c        | 5 +++--
 testsuite/smokey/vxworkstests/sem-1.c        | 6 +++---
 testsuite/smokey/vxworkstests/sem-2.c        | 6 +++---
 testsuite/smokey/vxworkstests/sem-3.c        | 4 ++--
 testsuite/smokey/vxworkstests/sem-4.c        | 4 ++--
 testsuite/smokey/vxworkstests/task-1.c       | 4 ++--
 testsuite/smokey/vxworkstests/task-2.c       | 5 +++--
 testsuite/smokey/vxworkstests/vxworkstests.c | 1 -
 testsuite/smokey/vxworkstests/wd-1.c         | 6 +++---
 13 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/lst-1.c b/testsuite/smokey/vxworkstests/lst-1.c
index 691d66fcf094a2ed66be09b590cc4d88314efade..5a9d21d4691c9763c7168efc627b608a14714bd7 100644
--- a/testsuite/smokey/vxworkstests/lst-1.c
+++ b/testsuite/smokey/vxworkstests/lst-1.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/lstLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static void rootTask(long arg, ...)
diff --git a/testsuite/smokey/vxworkstests/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
index 87415e167f9bddd58eb4a58c652fb02036389834..a71ba32649e5323d73af94908131a4b8938edcf5 100644
--- a/testsuite/smokey/vxworkstests/msgQ-1.c
+++ b/testsuite/smokey/vxworkstests/msgQ-1.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/msgQLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 #define NMESSAGES   ARRAY_SIZE(messages)
diff --git a/testsuite/smokey/vxworkstests/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
index 669c064e23035222c1808c005950b80d575dac78..b1b088ea4415817806627f2f9bb2bdb9858c2e39 100644
--- a/testsuite/smokey/vxworkstests/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/msgQLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/vxworkstests/msgQ-3.c b/testsuite/smokey/vxworkstests/msgQ-3.c
index 4aba719a7fef0fbc9db06b4f4d206af033d213e1..12036fe7b8ca43c4922156a3b09b25c367ca37ee 100644
--- a/testsuite/smokey/vxworkstests/msgQ-3.c
+++ b/testsuite/smokey/vxworkstests/msgQ-3.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/msgQLib.h>
 
+#include <stdlib.h>
+
 #define NMESSAGES  10
 
 static struct traceobj trobj;
diff --git a/testsuite/smokey/vxworkstests/rng-1.c b/testsuite/smokey/vxworkstests/rng-1.c
index 7e847dc7edb86965271df0cf4c07de4da3c743b1..3f35d9cfb850148d944222ca8b11a6db301d2c1f 100644
--- a/testsuite/smokey/vxworkstests/rng-1.c
+++ b/testsuite/smokey/vxworkstests/rng-1.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <string.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/rngLib.h>
 
+#include <stdlib.h>
+#include <string.h>
+
 static struct traceobj trobj;
 
 #define ADD_CONTENT(buffer,bytes,counter)				\
diff --git a/testsuite/smokey/vxworkstests/sem-1.c b/testsuite/smokey/vxworkstests/sem-1.c
index 33270c38b1310eb63e51c0a25903eb6626291b99..23129dcd8943c0841fd530c472177439afc0c7a1 100644
--- a/testsuite/smokey/vxworkstests/sem-1.c
+++ b/testsuite/smokey/vxworkstests/sem-1.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskInfo.h>
 #include <vxworks/semLib.h>
+#include <vxworks/taskInfo.h>
+
+#include <stdlib.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/vxworkstests/sem-2.c b/testsuite/smokey/vxworkstests/sem-2.c
index 1fb008be9076a480c4d9f04a933bc018c1947cfe..cd8f650fa78c179b5430e7985fd08e11afbf1089 100644
--- a/testsuite/smokey/vxworkstests/sem-2.c
+++ b/testsuite/smokey/vxworkstests/sem-2.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/taskInfo.h>
 #include <vxworks/semLib.h>
+#include <vxworks/taskInfo.h>
+
+#include <stdlib.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/vxworkstests/sem-3.c b/testsuite/smokey/vxworkstests/sem-3.c
index 921fa25cd8d44585737708df09d7203bbc6b11c1..24a3db17c2f869e6cc91f62620293df81e483304 100644
--- a/testsuite/smokey/vxworkstests/sem-3.c
+++ b/testsuite/smokey/vxworkstests/sem-3.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/semLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = {
diff --git a/testsuite/smokey/vxworkstests/sem-4.c b/testsuite/smokey/vxworkstests/sem-4.c
index 0a8daedb1d2451b17e7f26c098b37e93bd547dc8..ac0b14cf0f2ac3cfa5d9b0884ad03ffe22bb4abb 100644
--- a/testsuite/smokey/vxworkstests/sem-4.c
+++ b/testsuite/smokey/vxworkstests/sem-4.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/semLib.h>
 #include <vxworks/tickLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 #define WAIT_TIME  100
diff --git a/testsuite/smokey/vxworkstests/task-1.c b/testsuite/smokey/vxworkstests/task-1.c
index c5aeae1fbde3605d4de775fb500f5694bd9990f1..f6127d7cb254bd7ea4b873c0d9c309cb8d7b9ff3 100644
--- a/testsuite/smokey/vxworkstests/task-1.c
+++ b/testsuite/smokey/vxworkstests/task-1.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 
+#include <stdlib.h>
+
 static struct traceobj trobj;
 
 static int tseq[] = { 1, 2 };
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a13383418c4360241ef244b8a24da975..7075ab670b10b3afd319ef1015633056d9b9c1b7 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdlib.h>
-#include <unistd.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/semLib.h>
 
+#include <stdlib.h>
+#include <unistd.h>
+
 static inline void safe_pause(void)
 {
 	for (;;)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 26cd58c694ccaca75b32e3d38ace56ccd97afacf..7066c1f827a96c3218d96e7995abb5e93aae495e 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
diff --git a/testsuite/smokey/vxworkstests/wd-1.c b/testsuite/smokey/vxworkstests/wd-1.c
index e67089520cf635f9a7dad0c38aba06b600796e0d..5031a95c13c7cc20950800ee7ccb12f33a46110e 100644
--- a/testsuite/smokey/vxworkstests/wd-1.c
+++ b/testsuite/smokey/vxworkstests/wd-1.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
-#include <vxworks/wdLib.h>
 #include <vxworks/intLib.h>
+#include <vxworks/wdLib.h>
+
+#include <stdlib.h>
 
 static struct traceobj trobj;
 

-- 
2.54.0

