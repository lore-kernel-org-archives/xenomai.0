Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7D378D8A
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221402; cv=none; b=p8m1BfI1pJJ4zvVgS64IPOIUZuHNyjXjAdvQ8TTSQ7VPmHpTCkCJxbpEYSXAiw1K/5YIgW0DAtwANhF4yzPeh1miTq67pAdzTy+Va7VK31VYCgXDs6MVc9OVLUH+FXAGDrEvBgUyN8dYHWFpvEzW76QokjRcvSkNBiN8/soD1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221402; c=relaxed/simple;
	bh=+iuwnf947FO7Aw+mnMqRUIV9Rv2hiqowfdwsrcQuscw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRQtJukD/ccP//k0I380Tc9jobQT5NIRpFxAv6VcD6HxYQGYtuFw52HxnxngT39sjHlWVhDU6p12I+QCnGgUw4ZjnhN9MWj9KUiezxwmV7hoZ68w21AgndRfyKPzijiSFOKhkAmYh1BWbU0wPDRUXsfjNSp775+5j9CbeEIltcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BWBRVp8F; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BWBRVp8F"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202605080623053bf751f0e300020701
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aEHvj3JhfYLwaldrHKJ4rGpiN5S+/Zts8ejARPjEdec=;
 b=BWBRVp8FISTJeyd1CQpKJcbryPHYGujEy1ZPmKIBV6akO3szlRv6M6t0H53LRr0Ev6NsxQ
 BbE8CazP05iXhX0g28KNCAFEAv0oHxB6T/SBiz6J2uzMJnLmk02BF1cWXm/trhV3PhFoOPDI
 fjC19Gj225KnOTL2H1i9w5L+nmSGPII5GpcxMCHlMtA/MvGdj7LnDQP1vziS3g8u/TnQYmQy
 hAKbQKKVZuavJhtWWG/zlA6gbL4mFlB/ucN0aGd7QCcEBUD0WWgOmDywdXmIgKh2sP0bllOx
 /YIt68peDP5F7EQqEm3NnChoHdwJydvT12riGUYxaG9jWkMv/N5TiqLQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:04 +0200
Subject: [PATCH 31/32] utils: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-31-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained. This commit holds the cleanups of all utils/
subdirectories where only a single file has been modified.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 utils/autotune/autotune.c    | 17 ++++++-----------
 utils/chkkconf/checkconfig.c | 12 ++++++------
 utils/corectl/corectl.c      | 11 +++++------
 utils/hdb/hdb.c              | 16 ++++++++--------
 utils/ps/rtps.c              |  7 ++++---
 utils/slackspot/slackspot.c  | 19 +++++++++----------
 6 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/utils/autotune/autotune.c b/utils/autotune/autotune.c
index f52733b7ae1d5a920fc7ad79c7288001dfeb8f21..b608eba8c7044971a8800a273e2e3ad32b28f650 100644
--- a/utils/autotune/autotune.c
+++ b/utils/autotune/autotune.c
@@ -16,20 +16,15 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <fcntl.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <pthread.h>
-#include <limits.h>
-#include <time.h>
-#include <signal.h>
-#include <error.h>
-#include <sys/cobalt.h>
+
 #include <rtdm/autotune.h>
+#include <sys/cobalt.h>
 #include <xenomai/init.h>
 
+#include <error.h>
+#include <getopt.h>
+#include <stdlib.h>
+
 static int tune_irqlat, tune_kernlat, tune_userlat;
 
 static int reset, noload, background;
diff --git a/utils/chkkconf/checkconfig.c b/utils/chkkconf/checkconfig.c
index 134d8e519085320043c510b565ae488d105a882e..31d6c7838b109b55c85e9f99179851e442ea2272 100644
--- a/utils/chkkconf/checkconfig.c
+++ b/utils/chkkconf/checkconfig.c
@@ -4,17 +4,17 @@
  * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <error.h>
 #include <getopt.h>
+#include <search.h>
 #include <stdbool.h>
-#include <ctype.h>
-#include <stdlib.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <search.h>
-#include <error.h>
-#include <errno.h>
 #include <sys/utsname.h>
+#include <unistd.h>
 
 #define DEFAULT_KCONFIG    "/proc/config.gz"
 #define DEFAULT_CHECKLIST  DATADIR"/kconf-checklist"
diff --git a/utils/corectl/corectl.c b/utils/corectl/corectl.c
index 41b8773ad5db15d60a85b2d00b9b7bba7189d971..c8977af168fc30b1ff4a8ee9ff8c4839258fde52 100644
--- a/utils/corectl/corectl.c
+++ b/utils/corectl/corectl.c
@@ -16,15 +16,14 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <xeno_config.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <error.h>
+
 #include <sys/cobalt.h>
 #include <xenomai/init.h>
 
+#include <error.h>
+#include <getopt.h>
+#include <stdlib.h>
+
 int __cobalt_control_bind = 1;
 
 static int action;
diff --git a/utils/hdb/hdb.c b/utils/hdb/hdb.c
index 1ecce6ebf533a13b96f7a4a36f281edff10c4d00..dd596b32f9e638fe6dd92bed322914fe58326791 100644
--- a/utils/hdb/hdb.c
+++ b/utils/hdb/hdb.c
@@ -16,17 +16,17 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <xeno_config.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <stdlib.h>
-#include <malloc.h>
-#include <stdio.h>
-#include <error.h>
-#include <fcntl.h>
+
 #include <copperplate/cluster.h>
 #include <xenomai/init.h>
 
+#include <error.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
 static const struct option options[] = {
 	{
 #define dump_cluster_opt	0
diff --git a/utils/ps/rtps.c b/utils/ps/rtps.c
index 6a07f110dbd7694225a6a6837cdd8fffb1562786..1ff53956862ae243193fb9826334f3c1e33702cc 100644
--- a/utils/ps/rtps.c
+++ b/utils/ps/rtps.c
@@ -16,11 +16,12 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#include <string.h>
-#include <stdio.h>
-#include <error.h>
+
 #include <errno.h>
+#include <error.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 
 #define PROC_ACCT  "/proc/xenomai/sched/acct"
 #define PROC_PID  "/proc/%d/cmdline"
diff --git a/utils/slackspot/slackspot.c b/utils/slackspot/slackspot.c
index 031b97f13f975ca77ac579afc41fbb8e3ddbc479..9fb507b2812b295f846740cd485b4dde02ea5e07 100644
--- a/utils/slackspot/slackspot.c
+++ b/utils/slackspot/slackspot.c
@@ -19,20 +19,19 @@
  * vfile, to get backtraces of spurious relaxes.
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <stdio.h>
+#include <errno.h>
 #include <error.h>
-#include <stdint.h>
-#include <stdlib.h>
 #include <fnmatch.h>
+#include <getopt.h>
+#include <limits.h>
 #include <search.h>
-#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <limits.h>
-#include <malloc.h>
-#include <getopt.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+/* UAPI and dependencies */
 #include <signal.h>
 #include <cobalt/uapi/signal.h>
 

-- 
2.54.0

