Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4B1BDC8
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="H/9aEKEy"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202311031523358c60b357cff71e589b
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 16:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R9v9UWjnTI+vMLI9HnAWepKx0BUaGOJfUCor8KI0TA0=;
 b=H/9aEKEyfkpmzGBtLOUVKVZuW5gHoYBLi6+UyCAVgAnvNogXqQkJF0ZcqgzMp54wHOsdvk
 MRN+Yo6Xym5WbChF7klGTb3MnMeRYL5lBpOI84b+K6o04VgqLTcvONIzLHar/Rv1sKNAHTR7
 04wTT8UjWeWJufNyJRc3RbhUyRiy0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 03 Nov 2023 16:23:33 +0100
Subject: [PATCH 4/4] utils/analogy: Cleanup of unused includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-flo-cleanup-testsuite-v1-4-628287f21b8d@siemens.com>
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 utils/analogy/analogy_calibrate.c | 4 ----
 utils/analogy/analogy_config.c    | 1 -
 utils/analogy/calibration_ni_m.c  | 3 ++-
 utils/analogy/cmd_bits.c          | 2 --
 utils/analogy/cmd_read.c          | 1 -
 utils/analogy/cmd_write.c         | 2 --
 utils/analogy/insn_bits.c         | 2 --
 utils/analogy/insn_read.c         | 1 -
 utils/analogy/insn_write.c        | 1 -
 utils/analogy/wf_facilities.c     | 2 +-
 10 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/utils/analogy/analogy_calibrate.c b/utils/analogy/analogy_calibrate.c
index c5990a7b9..1a48b0db0 100644
--- a/utils/analogy/analogy_calibrate.c
+++ b/utils/analogy/analogy_calibrate.c
@@ -21,11 +21,7 @@
  */
 
 #include <sys/time.h>
-#include <sys/resource.h>
 #include <getopt.h>
-#include <pthread.h>
-#include <sys/mman.h>
-#include <xeno_config.h>
 #include <rtdm/analogy.h>
 #include "analogy_calibrate.h"
 #include "calibration_ni_m.h"
diff --git a/utils/analogy/analogy_config.c b/utils/analogy/analogy_config.c
index 96bc66ad0..f6ff976bb 100644
--- a/utils/analogy/analogy_config.c
+++ b/utils/analogy/analogy_config.c
@@ -20,7 +20,6 @@
  */
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
index 4ce20166c..9a8673d12 100644
--- a/utils/analogy/calibration_ni_m.c
+++ b/utils/analogy/calibration_ni_m.c
@@ -19,13 +19,14 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #include <rtdm/uapi/analogy.h>
 #include <rtdm/analogy.h>
 #include <math.h>
 
 #include "boilerplate/ancillaries.h"
 #include "calibration_ni_m.h"
-#include "calibration.h"
+
 struct listobj ai_calibration_list;
 struct listobj ao_calibration_list;
 
diff --git a/utils/analogy/cmd_bits.c b/utils/analogy/cmd_bits.c
index 17dc49610..fdcd9042b 100644
--- a/utils/analogy/cmd_bits.c
+++ b/utils/analogy/cmd_bits.c
@@ -19,11 +19,9 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <sys/mman.h>
 #include <errno.h>
 #include <getopt.h>
 #include <rtdm/analogy.h>
diff --git a/utils/analogy/cmd_read.c b/utils/analogy/cmd_read.c
index 86522f405..ee054ca49 100644
--- a/utils/analogy/cmd_read.c
+++ b/utils/analogy/cmd_read.c
@@ -27,7 +27,6 @@
 #include <error.h>
 #include <getopt.h>
 #include <string.h>
-#include <signal.h>
 #include <pthread.h>
 #include <rtdm/analogy.h>
 
diff --git a/utils/analogy/cmd_write.c b/utils/analogy/cmd_write.c
index 7b8870f2b..cc2efd6b5 100644
--- a/utils/analogy/cmd_write.c
+++ b/utils/analogy/cmd_write.c
@@ -22,12 +22,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <sys/mman.h>
 #include <errno.h>
 #include <getopt.h>
 #include <string.h>
 #include <rtdm/analogy.h>
-#include <fcntl.h>
 
 #define BUFFER_DEPTH 1024
 
diff --git a/utils/analogy/insn_bits.c b/utils/analogy/insn_bits.c
index f3ff8001f..b6b66bfd2 100644
--- a/utils/analogy/insn_bits.c
+++ b/utils/analogy/insn_bits.c
@@ -19,10 +19,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/mman.h>
 #include <errno.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/utils/analogy/insn_read.c b/utils/analogy/insn_read.c
index 8aa0740ed..8f5d5720b 100644
--- a/utils/analogy/insn_read.c
+++ b/utils/analogy/insn_read.c
@@ -22,7 +22,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <sys/mman.h>
 #include <errno.h>
 #include <getopt.h>
 #include <rtdm/analogy.h>
diff --git a/utils/analogy/insn_write.c b/utils/analogy/insn_write.c
index b2bbf6668..f4d5e5f68 100644
--- a/utils/analogy/insn_write.c
+++ b/utils/analogy/insn_write.c
@@ -21,7 +21,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/mman.h>
 #include <errno.h>
 #include <getopt.h>
 #include <rtdm/analogy.h>
diff --git a/utils/analogy/wf_facilities.c b/utils/analogy/wf_facilities.c
index 2281bcf1e..b979c92da 100644
--- a/utils/analogy/wf_facilities.c
+++ b/utils/analogy/wf_facilities.c
@@ -18,8 +18,8 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #include <stdio.h>
-#include <stdlib.h>
 #include <assert.h>
 #include <errno.h>
 #include <math.h>

-- 
2.39.2

