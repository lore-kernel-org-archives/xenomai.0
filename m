Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B217347518
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221404; cv=none; b=dZcxlT/gBnbfT7tCU7CbzrntGlEolt5XGmVoAzpqf5nVvXWdaDo6O5661VIYh+nBH2LkixxRhp7BtsGgcwNiTXTnRYfrF0AGxYRVBDVVhyehhOa43IyZ6o/OY92QTz0gs8xm2SSsXSkC/KerwUnoWq6HeTqG4qYkdO7wp3IjM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221404; c=relaxed/simple;
	bh=KtmvnGSF29C0doZLEDYLn/AhvVAGGZ2g6T1GKIEDYaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMgrmRIGckISRjNUno992gem+fDd/p971+IkOvtH2CYB1ZqYdx3q34j6ipx3LRky+PJXfQuxFyKCjDM6W6Rx8VuDl6lA2k3FcEXjNuXbJ+U2FoWOrYHXDDNxtZTSnwITeG3lKl9FrbJ1RsBAS9UETb2+UzTGNuXm06lrgN3CUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Of5uAc8g; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Of5uAc8g"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260508062303e86d74c77c00020754
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xKAoEPUt8B7hoxK3E2trgngwQUl1SoPBAHU99HnEIUo=;
 b=Of5uAc8g0EEDdZXt5skGDKxoQaoW37imjQhQOuDub3moQo2D3rfsRwTV2v9Krb5mDHYpF1
 ECGmwfE/2t0X5A3Ol2XqDI4jUpwPQWQRbc7ROq2/ijFdIiNm9TlbA4lQKmryzIIhtQ04l1RM
 nxuRHt3J+egJ3IAEn8j09ljqvLMnLeZ8oMedHiUN71Vagg1GVEU/uJddYJwvpokt0pi9NpTf
 JouGDpZxVn7qtYmi/pf1Nh6PKEL0SBWM+UVKhxxJpLa82QVIg68Lk6Zn2+jmcvEi+SBzO5yt
 ttEod1AoPSHFGMpJrz57rR/+W8hIuWTsGbuRs2BcUsVARCLNTpnMxdnw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:00 +0200
Subject: [PATCH 27/32] demo/posix/cyclictest: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-27-e449f2bd4fc2@siemens.com>
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
 demo/posix/cyclictest/cyclictest.c | 32 +++++++++++---------------------
 demo/posix/cyclictest/error.c      |  4 ++++
 demo/posix/cyclictest/error.h      |  4 +---
 demo/posix/cyclictest/rt-utils.h   |  2 +-
 demo/posix/cyclictest/rt_numa.h    |  3 ++-
 5 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index 5bc6bd6fcc16be4bdcbb017053c8a6946603d14f..71725ade88e58ac17a73bc6d8c851b915de02508 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -12,35 +12,25 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <stdarg.h>
-#include <unistd.h>
+#include "rt_numa.h"
+#include "rt-utils.h"
+
+#include <boilerplate/ancillaries.h>
+
 #include <fcntl.h>
 #include <getopt.h>
-#include <pthread.h>
+#include <linux/unistd.h>
 #include <signal.h>
-#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <time.h>
-#include <errno.h>
-#include <limits.h>
-#include <linux/unistd.h>
-
+#include <sys/mman.h>
 #include <sys/prctl.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
-#include <sys/sysinfo.h>
-#include <sys/types.h>
 #include <sys/time.h>
-#include <sys/resource.h>
 #include <sys/utsname.h>
-#include <sys/mman.h>
-
-#include <boilerplate/ancillaries.h>
-
-#include "rt_numa.h"
-#include "rt-utils.h"
+#include <unistd.h>
 
 #define DEFAULT_INTERVAL 1000
 #define DEFAULT_DISTANCE 500
diff --git a/demo/posix/cyclictest/error.c b/demo/posix/cyclictest/error.c
index b32aa02707808ecd60829361bd061ecff939338c..86efe9f4c25d9e3f93003eb0cad352558ee86ce4 100644
--- a/demo/posix/cyclictest/error.c
+++ b/demo/posix/cyclictest/error.c
@@ -6,6 +6,10 @@
  */
 #include "error.h"
 
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 /* Print an error message, plus a message for err and exit with error err */
 void err_exit(int err, char *fmt, ...)
 {
diff --git a/demo/posix/cyclictest/error.h b/demo/posix/cyclictest/error.h
index ae05a2e128c8d3aef165fd1a378bd54cae5705c6..4256083b116b0fb29f2e40a4531f44b0993778ce 100644
--- a/demo/posix/cyclictest/error.h
+++ b/demo/posix/cyclictest/error.h
@@ -1,10 +1,8 @@
 #ifndef __ERROR_H
 #define __ERROR_H
 
-#include <stdio.h>
-#include <stdlib.h>
+//#include <stdio.h>
 #include <stdarg.h>
-#include <string.h>
 
 void err_exit(int err, char *fmt, ...);
 void err_msg(char *fmt, ...);
diff --git a/demo/posix/cyclictest/rt-utils.h b/demo/posix/cyclictest/rt-utils.h
index a7c7640b3b9e198c746546b68d69666772f7e3bc..3c6518032046377f9aa411da37853608b4c37c0f 100644
--- a/demo/posix/cyclictest/rt-utils.h
+++ b/demo/posix/cyclictest/rt-utils.h
@@ -2,7 +2,7 @@
 #define __RT_UTILS_H
 
 #include <stdint.h>
-#include <linux/sched.h>
+#include <sys/types.h>
 
 #ifndef SCHED_NORMAL
 #define SCHED_NORMAL SCHED_OTHER
diff --git a/demo/posix/cyclictest/rt_numa.h b/demo/posix/cyclictest/rt_numa.h
index 98e7d0ffda78e9c00f3aca69b1a319f904e11a23..f33a9a8d6b2e09fae2da0786ca3ae5a4f008051c 100644
--- a/demo/posix/cyclictest/rt_numa.h
+++ b/demo/posix/cyclictest/rt_numa.h
@@ -20,9 +20,10 @@
 #ifndef _RT_NUMA_H
 #define _RT_NUMA_H
 
-#include "rt-utils.h"
 #include "error.h"
 
+#include <stdlib.h>
+
 static int numa = 0;
 
 #ifdef NUMA

-- 
2.54.0

