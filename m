Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD784E1C7
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dRPU8pP+"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231205124140aef5f6aed7406b8912
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iKu2vc7vptxGTY0eGRRcYbVWKyBiN5TWaxTO2vHCag0=;
 b=dRPU8pP+c2rEYl4P+eBTzrIFMQW0rDkW24P6il1aMc1FWpZ4MYF3qpVQu/5Pszl0Jk+yf9
 2+r3Ar6NQTfiPWEXmYAvgdwZmDQw/UAmieJQUYIDax2GLJH5K5WNLhzA5HvtN8qG0Gk0EpDM
 3BeXW01MEFH7hTCSsijzpGY6oLoC8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:39 +0100
Subject: [PATCH 02/13] demo: Migrate to ARRAY_SIZE()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-2-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Use ARRAY_SIZE() where possible. No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/posix/cobalt/bufp-label.c     | 4 +++-
 demo/posix/cobalt/bufp-readwrite.c | 4 +++-
 demo/posix/cobalt/iddp-label.c     | 4 +++-
 demo/posix/cobalt/iddp-sendrecv.c  | 4 +++-
 demo/posix/cobalt/xddp-echo.c      | 4 +++-
 demo/posix/cobalt/xddp-label.c     | 4 +++-
 demo/posix/cobalt/xddp-stream.c    | 4 +++-
 demo/posix/cyclictest/cyclictest.c | 6 +++---
 8 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/demo/posix/cobalt/bufp-label.c b/demo/posix/cobalt/bufp-label.c
index 1141c8913..85984c7c7 100644
--- a/demo/posix/cobalt/bufp-label.c
+++ b/demo/posix/cobalt/bufp-label.c
@@ -30,6 +30,8 @@
 #include <string.h>
 #include <pthread.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
@@ -163,7 +165,7 @@ static void *client(void *arg)
 		}
 		printf("%s: sent %d bytes, \"%.*s\"\n",
 		       __FUNCTION__, ret, ret, msg[n]);
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/bufp-readwrite.c b/demo/posix/cobalt/bufp-readwrite.c
index 34d761aeb..74faa5bc8 100644
--- a/demo/posix/cobalt/bufp-readwrite.c
+++ b/demo/posix/cobalt/bufp-readwrite.c
@@ -30,6 +30,8 @@
 #include <string.h>
 #include <pthread.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
@@ -128,7 +130,7 @@ static void *client(void *arg)
 		}
 		printf("%s: sent %d bytes, \"%.*s\"\n",
 		       __FUNCTION__, ret, ret, msg[n]);
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/iddp-label.c b/demo/posix/cobalt/iddp-label.c
index 06fc8814c..fe21bf77f 100644
--- a/demo/posix/cobalt/iddp-label.c
+++ b/demo/posix/cobalt/iddp-label.c
@@ -37,6 +37,8 @@
 #include <string.h>
 #include <pthread.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
@@ -180,7 +182,7 @@ static void *client(void *arg)
 		}
 		printf("%s: sent %d bytes, \"%.*s\"\n",
 		       __FUNCTION__, ret, ret, msg[n]);
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-sendrecv.c
index 31ee10fde..0ce6be2a9 100644
--- a/demo/posix/cobalt/iddp-sendrecv.c
+++ b/demo/posix/cobalt/iddp-sendrecv.c
@@ -32,7 +32,9 @@
 #include <string.h>
 #include <pthread.h>
 #include <errno.h>
+
 #include <rtdm/ipc.h>
+#include <boilerplate/ancillaries.h>
 
 pthread_t svtid, cltid;
 
@@ -136,7 +138,7 @@ static void *client(void *arg)
 		}
 		printf("%s: sent %d bytes, \"%.*s\"\n",
 		       __FUNCTION__, ret, ret, msg[n]);
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/xddp-echo.c b/demo/posix/cobalt/xddp-echo.c
index ba8558266..c76f9e7cc 100644
--- a/demo/posix/cobalt/xddp-echo.c
+++ b/demo/posix/cobalt/xddp-echo.c
@@ -66,6 +66,8 @@
 #include <pthread.h>
 #include <fcntl.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t rt, nrt;
@@ -164,7 +166,7 @@ static void *realtime_thread(void *arg)
 
 		printf("   => \"%.*s\" echoed by peer\n", ret, buf);
 
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/xddp-label.c b/demo/posix/cobalt/xddp-label.c
index 9de31fdea..52c898444 100644
--- a/demo/posix/cobalt/xddp-label.c
+++ b/demo/posix/cobalt/xddp-label.c
@@ -72,6 +72,8 @@
 #include <pthread.h>
 #include <fcntl.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t rt1, rt2, nrt;
@@ -235,7 +237,7 @@ static void *realtime_thread2(void *arg)
 		printf("%s: sent %d bytes, \"%.*s\"\n",
 		       __FUNCTION__, ret, ret, msg[n]);
 
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cobalt/xddp-stream.c b/demo/posix/cobalt/xddp-stream.c
index e53729462..b7934edc4 100644
--- a/demo/posix/cobalt/xddp-stream.c
+++ b/demo/posix/cobalt/xddp-stream.c
@@ -68,6 +68,8 @@
 #include <pthread.h>
 #include <fcntl.h>
 #include <errno.h>
+
+#include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
 pthread_t rt, nrt;
@@ -170,7 +172,7 @@ static void *realtime_thread(void *arg)
 
 		printf("   => \"%.*s\" echoed by peer\n", ret, buf);
 
-		n = (n + 1) % (sizeof(msg) / sizeof(msg[0]));
+		n = (n + 1) % ARRAY_SIZE(msg);
 		/*
 		 * We run in full real-time mode (i.e. primary mode),
 		 * so we have to let the system breathe between two
diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index b92596c25..5bc6bd6fc 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -36,15 +36,15 @@
 #include <sys/resource.h>
 #include <sys/utsname.h>
 #include <sys/mman.h>
-#include "rt_numa.h"
 
+#include <boilerplate/ancillaries.h>
+
+#include "rt_numa.h"
 #include "rt-utils.h"
 
 #define DEFAULT_INTERVAL 1000
 #define DEFAULT_DISTANCE 500
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 /* Ugly, but .... */
 #define gettid() syscall(__NR_gettid)
 #define sigev_notify_thread_id _sigev_un._tid

-- 
2.39.2

