Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C72F7AB0
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221395; cv=none; b=dCgwxHq4Km/7EAMT/8PBmC04d2u/3y8GNqwnc+HXi400uSr7uUF7tGVvHEZKqJI9BWcHPZuDhsRWYdO/8xw2nyKNyuBO/TJ6U8JudfnOk/P4Bnon4d2hkhwjqInH4m4OF+elEibh2U3tlvmyiA8NToMoTt1sxY8FVx4RpmlUHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221395; c=relaxed/simple;
	bh=FAFQORMltZ+14E8DzvhLpRQdL1VPraIHxB91wCWql4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjAVC/4YD8CGMohdp2htYMillc3bDmFNTnwqz6lpoS/wwZ3Buh7mjQgECCJGu7Yj8LjlHDp4C++5tmsoTWuVyKQagh+Oc5d8bc/1dMJzO99DSnnoJPkRLXhqH4u4K4ZEO2QIV9xKytyXifVS+Xid8itT7TMnYUw0jU6UQcOE7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HAAe1+GS; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HAAe1+GS"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260508062258de35f79b99000207a0
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I8yslYCoJXfHIZ4U3dL9xTFJKaQq52NDAYd/JkrG2r0=;
 b=HAAe1+GSdj+Xe2s+1olPzajeBfds0L43DTRYMil7eiWtGKQnC0pKQwSWKj90lxZV6Vln4v
 em061JktLxHz4ys4dZBu1t555089/6XWDLrkG9UHvNXylxNQ8L/5rkaTfx41EJI11ZYdrthm
 kaRNM6gXgkHFHgmqBi5pNt0xTSGkoX4njh1kp2bQPpn2dNKmGq6RMSYbyqb5iMAucCp5FdhQ
 XHHVGoBXifixJSgKTyHnNTgHn13JtNrcilkVoXYMyLhjlfq6YVBwXtLxBtZWxY9iVMNo2q1v
 jvD8o7GGrWsffy3nKAgzevC3VIwaXNQ24hMXyBS2ZLBsCAt5aCBAjx+Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:49 +0200
Subject: [PATCH 16/32] testsuite/smokey/alchemytests: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-16-e449f2bd4fc2@siemens.com>
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
 testsuite/smokey/alchemytests/alarm-1.c      |  6 ++----
 testsuite/smokey/alchemytests/alchemytests.c |  4 ++--
 testsuite/smokey/alchemytests/buffer-1.c     |  7 ++-----
 testsuite/smokey/alchemytests/event-1.c      |  6 ++----
 testsuite/smokey/alchemytests/heap-1.c       |  7 ++-----
 testsuite/smokey/alchemytests/heap-2.c       |  6 ++----
 testsuite/smokey/alchemytests/mq-1.c         |  6 ++----
 testsuite/smokey/alchemytests/mq-2.c         |  6 ++----
 testsuite/smokey/alchemytests/mq-3.c         |  6 ++----
 testsuite/smokey/alchemytests/mutex-1.c      |  5 +----
 testsuite/smokey/alchemytests/mutex-2.c      |  5 +----
 testsuite/smokey/alchemytests/pipe-1.c       | 11 +++++------
 testsuite/smokey/alchemytests/sem-1.c        |  6 ++----
 testsuite/smokey/alchemytests/sem-2.c        |  6 ++----
 testsuite/smokey/alchemytests/task-1.c       |  4 +---
 testsuite/smokey/alchemytests/task-10.c      |  6 ++----
 testsuite/smokey/alchemytests/task-11.c      |  2 --
 testsuite/smokey/alchemytests/task-2.c       |  6 ++----
 testsuite/smokey/alchemytests/task-3.c       |  4 +---
 testsuite/smokey/alchemytests/task-4.c       |  6 ++----
 testsuite/smokey/alchemytests/task-5.c       |  6 ++----
 testsuite/smokey/alchemytests/task-6.c       |  4 +---
 testsuite/smokey/alchemytests/task-7.c       |  4 +---
 testsuite/smokey/alchemytests/task-8.c       |  6 ++----
 testsuite/smokey/alchemytests/task-9.c       |  5 +----
 25 files changed, 44 insertions(+), 96 deletions(-)

diff --git a/testsuite/smokey/alchemytests/alarm-1.c b/testsuite/smokey/alchemytests/alarm-1.c
index eb6c5310aa2b6a9d028e118defbeff0d257240df..f84af7946c91cc676420760352d412758fe90222 100644
--- a/testsuite/smokey/alchemytests/alarm-1.c
+++ b/testsuite/smokey/alchemytests/alarm-1.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/alarm.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index edbafe6e71796bac9ab6c0f3fa9088071a7ab1d3..2d8f506ac2add17ce3f43b2090470563804d7ac6 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <string.h>
-#include <stdlib.h>
 #include <smokey/smokey.h>
 
+#include <stdlib.h>
+
 static const char * const tests[] = {
 	"alchemytests_alarm1",
 	"alchemytests_buffer1",
diff --git a/testsuite/smokey/alchemytests/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
index 008797827c43602041c64a711c51c164cb710948..fb46665fb48533d5796bb97e1c2383214b6aaa27 100644
--- a/testsuite/smokey/alchemytests/buffer-1.c
+++ b/testsuite/smokey/alchemytests/buffer-1.c
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <memory.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/buffer.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/event-1.c b/testsuite/smokey/alchemytests/event-1.c
index d691192ec95540d81d6939749b03fe9d9cbfaf99..334b276a114727d3a8f73ee4b15e962fa0b9bd25 100644
--- a/testsuite/smokey/alchemytests/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/event.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
index 5b0ff78ca8c6ca3c0c104418ad4ffe614c9ca344..00ae5d36c432e84539d16821f67564aef13b2d0e 100644
--- a/testsuite/smokey/alchemytests/heap-1.c
+++ b/testsuite/smokey/alchemytests/heap-1.c
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/heap.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static int tseq[] = {
 	7, 1, 2, 3, 4,
diff --git a/testsuite/smokey/alchemytests/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
index 1f80db80ccbadfe8fabd9455b2dafafa0d974af6..8bec71eddd72d7e57fdc67c3c60b0542bc157a01 100644
--- a/testsuite/smokey/alchemytests/heap-2.c
+++ b/testsuite/smokey/alchemytests/heap-2.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/heap.h>
 #include <alchemy/queue.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 #define HEAPSIZE  16384
 #define MSGSIZE   16
diff --git a/testsuite/smokey/alchemytests/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
index 8e1aa4c6dd2ebff697abbc08e78f1c188e1aa9a3..37d6d89d33e1f106e92191c5e06fe0ca51fdbcce 100644
--- a/testsuite/smokey/alchemytests/mq-1.c
+++ b/testsuite/smokey/alchemytests/mq-1.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
+#include <alchemy/queue.h>
+#include <alchemy/task.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
-#include <alchemy/task.h>
-#include <alchemy/queue.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
index 09b26b2135fdaf2c389c252685d7bce07abb648b..28baa7473ce9e7690e81144f47aef9634e25c277 100644
--- a/testsuite/smokey/alchemytests/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
+#include <alchemy/queue.h>
+#include <alchemy/task.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
-#include <alchemy/task.h>
-#include <alchemy/queue.h>
 
 static struct traceobj trobj;
 static bool on_vm;
diff --git a/testsuite/smokey/alchemytests/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
index cb4c77d4302ff0177890248e79094aa1a6ae9637..fb6820d1d8c5f62b407fd4b5b19c5778d5a7e353 100644
--- a/testsuite/smokey/alchemytests/mq-3.c
+++ b/testsuite/smokey/alchemytests/mq-3.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/queue.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 #define NMESSAGES  10
 
diff --git a/testsuite/smokey/alchemytests/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
index f08665254ed6b84c7cf8c6dfc8ed0b3b06b4da29..3971d6cb7773ed51db92d34705c9349ea179c824 100644
--- a/testsuite/smokey/alchemytests/mutex-1.c
+++ b/testsuite/smokey/alchemytests/mutex-1.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/mutex.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/mutex-2.c b/testsuite/smokey/alchemytests/mutex-2.c
index cb2c2710fad625a2023f2b64f5a0b83c01a57055..5d41f3730651cb5de4c6e63b2967e2f2b95870be 100644
--- a/testsuite/smokey/alchemytests/mutex-2.c
+++ b/testsuite/smokey/alchemytests/mutex-2.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/mutex.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 8989f3a46a085291e03ebc37375b331312bcb14b..1a1746035c01ff6900155e951821b6f78361002d 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/pipe.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 #include <smokey/smokey.h>
 
+#include <fcntl.h>
+#include <unistd.h>
+
 static struct traceobj trobj;
 
 static RT_TASK t_real;
diff --git a/testsuite/smokey/alchemytests/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
index 080bcea9ae673609edd483d4ae0dfe6d51bd164e..10abfd89ac5d9898895f0a8fb25adb280dfc1156 100644
--- a/testsuite/smokey/alchemytests/sem-1.c
+++ b/testsuite/smokey/alchemytests/sem-1.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
index b6ecc07e938d257c36b7005243afa14bdaed3002..1752c60d1e92ea045ed7e167fb108b1906a641f2 100644
--- a/testsuite/smokey/alchemytests/sem-2.c
+++ b/testsuite/smokey/alchemytests/sem-2.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-1.c b/testsuite/smokey/alchemytests/task-1.c
index d3d9a6f7f8dcc84ff7d00ad0f3f5cc18dc5e3bdc..68f0672b4ef2fe2709e09add7bc92372e365a744 100644
--- a/testsuite/smokey/alchemytests/task-1.c
+++ b/testsuite/smokey/alchemytests/task-1.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
 #include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-10.c b/testsuite/smokey/alchemytests/task-10.c
index c4a29ae7604bf6dace604a193850633c83b680f4..8a9fd747bb3a721db109876416cef50086660df2 100644
--- a/testsuite/smokey/alchemytests/task-10.c
+++ b/testsuite/smokey/alchemytests/task-10.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
index 6d07e02703f15dd40d36f6cd98df2ebb8115b275..944e30b158651f5f566684e9e61d596be92b01e6 100644
--- a/testsuite/smokey/alchemytests/task-11.c
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 
diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index ca2225ad703b091c7c228b1c3bd20251576085e5..5283345581065734f5f4a70d30b06795e1e8756e 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-3.c b/testsuite/smokey/alchemytests/task-3.c
index eb24935a4f8768c947569363ba26c270584312a6..1a32324632ad1ea66f90415b65d37fd0af89c2eb 100644
--- a/testsuite/smokey/alchemytests/task-3.c
+++ b/testsuite/smokey/alchemytests/task-3.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
 #include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-4.c b/testsuite/smokey/alchemytests/task-4.c
index 90e0236beda4277d033d96bd2445c354c0bc0b94..b949bf804e5458e261305d242b155d0733e83182 100644
--- a/testsuite/smokey/alchemytests/task-4.c
+++ b/testsuite/smokey/alchemytests/task-4.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-5.c b/testsuite/smokey/alchemytests/task-5.c
index 2aecd81254c5ab7ff213544c6fae4d6a1f451c36..846ba5b0bf1a3f31b1427d1ac0203d229f3bf437 100644
--- a/testsuite/smokey/alchemytests/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-6.c b/testsuite/smokey/alchemytests/task-6.c
index fa58d0fdcab11c97873a030c23dc90f83eb70533..99e807c2b2ed6f0ba068ad8e3c2a8bfa45eb1b1a 100644
--- a/testsuite/smokey/alchemytests/task-6.c
+++ b/testsuite/smokey/alchemytests/task-6.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
 #include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-7.c b/testsuite/smokey/alchemytests/task-7.c
index d118abf423f18b54d88e79c93e2f94120fd69571..dc3fdf1d0d2955584d64c976a8f74a4106964058 100644
--- a/testsuite/smokey/alchemytests/task-7.c
+++ b/testsuite/smokey/alchemytests/task-7.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
 #include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-8.c b/testsuite/smokey/alchemytests/task-8.c
index 959b3d3c4caab8eb1feab063e9407c81e6cf7038..75d90a0bc0d01ea90277a5610fd320e6071bedd5 100644
--- a/testsuite/smokey/alchemytests/task-8.c
+++ b/testsuite/smokey/alchemytests/task-8.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <copperplate/traceobj.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
+#include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 
diff --git a/testsuite/smokey/alchemytests/task-9.c b/testsuite/smokey/alchemytests/task-9.c
index 9bb43efbdeaf6266ebec232f79f2d6a9c58aff14..2d84e26611198b0f1b0dc2d33cf70d34ac5d2fa1 100644
--- a/testsuite/smokey/alchemytests/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <copperplate/traceobj.h>
 #include <alchemy/task.h>
+#include <copperplate/traceobj.h>
 
 static struct traceobj trobj;
 

-- 
2.54.0

