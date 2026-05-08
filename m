Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5450377006
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221403; cv=none; b=BLKIHJj3dpk3ck5XOwT4oUC4YoIgdTQz30FPiGxqxmMdaBGhJc3LmAw9jitXpmQtx9o+4l3dprzYoIHLZdojSrDBzkOiBFf2PN+oogBQg9Y6/byt9LIwLhO66p/XRYhoQvZKMRXbH7tHO+7TRmyqshIRz2nI65MbgNH47ytK75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221403; c=relaxed/simple;
	bh=a5+Y5pITOlL8YPJH5HQ4SwEnUhG98+Z55d56OfwT7kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LV61OmivZaaGHBdjNmOGytOImUDLDKfYI7iDGE9RXV2qe1kDJ8EpBTBjcuyjbxDBO2GlOrf7OCKU0KvE02TnpZnSa3/YIZooSy3cKoE2KLH2OIOG1VWlxLPJTPM6BF2LWvShesQK2HmJbbKZHVyhnqU7EnkSY0F1+VYY2sR0HMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NOGIDL9o; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NOGIDL9o"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062304d1b3b0df2b00020719
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pqGGqud/jMV39er+fEoc8fZm71uh9Zu2NnrKvVfxnKI=;
 b=NOGIDL9outNfjgzS46W+HMw0HgFshlthmSQE206TVjZC/fYhfpSRHrob2T4qemRkSIsz0+
 7bgQemEQ7mwjg4vd9O2HTpFsl41TX0Isr5Pv/anOU3b2FPjn34jaVRN6eRveVBcKG66VL63a
 PpDggrdJkhQzbVDX5Sna9ktljPkH3AuXhEj615zi/r8+xrkeVuf9Djk2QvAmMTPKVnCrvyQU
 lTEWpPP2VfLxbIr6dSCavg/rHeQZ+oTkK31c0QA446lIKth9XUgdeIUMIF28FWd7EHSR41vl
 z1G/teoK8OkM7essN6YLfOqHdJ2OnvdQYFK1bDZI+wymycR/w7fO5bGg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:01 +0200
Subject: [PATCH 28/32] utils/analogy: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-28-e449f2bd4fc2@siemens.com>
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
 utils/analogy/analogy_calibrate.c |  7 +++----
 utils/analogy/analogy_calibrate.h |  8 +++-----
 utils/analogy/analogy_config.c    |  9 ++++-----
 utils/analogy/calibration_ni_m.c  |  8 +++-----
 utils/analogy/cmd_bits.c          |  8 ++++----
 utils/analogy/cmd_read.c          | 13 ++++++-------
 utils/analogy/cmd_write.c         |  8 ++++----
 utils/analogy/insn_bits.c         |  6 +++---
 utils/analogy/insn_read.c         |  8 ++++----
 utils/analogy/insn_write.c        |  6 +++---
 utils/analogy/wf_facilities.c     |  6 +++---
 utils/analogy/wf_facilities.h     |  3 +--
 utils/analogy/wf_generate.c       | 10 +++++-----
 13 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/utils/analogy/analogy_calibrate.c b/utils/analogy/analogy_calibrate.c
index 1a48b0db0bec9f7087fda6e5ac6f01d971545a00..b2e7bf28ea9fa976a00b9f84789f4985b58369a8 100644
--- a/utils/analogy/analogy_calibrate.c
+++ b/utils/analogy/analogy_calibrate.c
@@ -20,12 +20,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <sys/time.h>
-#include <getopt.h>
-#include <rtdm/analogy.h>
-#include "analogy_calibrate.h"
 #include "calibration_ni_m.h"
 
+#include <errno.h>
+#include <getopt.h>
+
 struct timespec calibration_start_time;
 a4l_desc_t descriptor;
 
diff --git a/utils/analogy/analogy_calibrate.h b/utils/analogy/analogy_calibrate.h
index 728ee1208acab1e807d99dce4225a69b146202a3..f3b5e79b73974cfba3fe6ba58a1f3e540d90ce86 100644
--- a/utils/analogy/analogy_calibrate.h
+++ b/utils/analogy/analogy_calibrate.h
@@ -24,13 +24,11 @@
 #ifndef __ANALOGY_CALIBRATE_H__
 #define __ANALOGY_CALIBRATE_H__
 
-#include <string.h>
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
+#include <error.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
-#include "error.h"
+#include <unistd.h>
 
 extern struct timespec calibration_start_time;
 extern a4l_desc_t descriptor;
diff --git a/utils/analogy/analogy_config.c b/utils/analogy/analogy_config.c
index f6ff976bb989223849e5ddc21df85d5e70e82219..5e400cf67fb3835db2127027122a300d6b325b4e 100644
--- a/utils/analogy/analogy_config.c
+++ b/utils/analogy/analogy_config.c
@@ -19,13 +19,12 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include <rtdm/analogy.h>
+
+#include <errno.h>
 #include <getopt.h>
+#include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <xeno_config.h>
-#include <rtdm/analogy.h>
 
 #define ANALOGY_DRIVERS_PROC "/proc/analogy/drivers"
 #define ANALOGY_DEVICES_PROC "/proc/analogy/devices"
diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
index 9a8673d12ac31f4db8448b4bd54138a7653f8e09..efabf7161497d3aee340f1d11ddfb441ec1dbe8f 100644
--- a/utils/analogy/calibration_ni_m.c
+++ b/utils/analogy/calibration_ni_m.c
@@ -20,12 +20,10 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <rtdm/uapi/analogy.h>
-#include <rtdm/analogy.h>
-#include <math.h>
-
-#include "boilerplate/ancillaries.h"
 #include "calibration_ni_m.h"
+#include "boilerplate/ancillaries.h"
+
+#include <math.h>
 
 struct listobj ai_calibration_list;
 struct listobj ao_calibration_list;
diff --git a/utils/analogy/cmd_bits.c b/utils/analogy/cmd_bits.c
index fdcd9042b439df290fe3955612e4617d346738d3..f25ecb92c34751a461a9bd3eb2fb9ff12c681ecd 100644
--- a/utils/analogy/cmd_bits.c
+++ b/utils/analogy/cmd_bits.c
@@ -19,12 +19,12 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
+#include <rtdm/analogy.h>
+
 #include <errno.h>
 #include <getopt.h>
-#include <rtdm/analogy.h>
+#include <stdlib.h>
+#include <unistd.h>
 
 #define FILENAME "analogy0"
 
diff --git a/utils/analogy/cmd_read.c b/utils/analogy/cmd_read.c
index ee054ca4942c45d459be959c03bc02a25c39ad4d..eee9c868e5e92766fa3da3376b56219c8ea60435 100644
--- a/utils/analogy/cmd_read.c
+++ b/utils/analogy/cmd_read.c
@@ -19,16 +19,15 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <errno.h>
+#include <rtdm/analogy.h>
+
 #include <error.h>
 #include <getopt.h>
-#include <string.h>
 #include <pthread.h>
-#include <rtdm/analogy.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
 
 typedef int (*dump_function_t) (a4l_desc_t *, a4l_cmd_t*, unsigned char *, int);
 
diff --git a/utils/analogy/cmd_write.c b/utils/analogy/cmd_write.c
index cc2efd6b5f717d5ebf346a990d1960f25f1097dd..aa34bee101548d32603894fbe46708348f31db76 100644
--- a/utils/analogy/cmd_write.c
+++ b/utils/analogy/cmd_write.c
@@ -19,13 +19,13 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
+#include <rtdm/analogy.h>
+
 #include <errno.h>
 #include <getopt.h>
+#include <stdlib.h>
 #include <string.h>
-#include <rtdm/analogy.h>
+#include <unistd.h>
 
 #define BUFFER_DEPTH 1024
 
diff --git a/utils/analogy/insn_bits.c b/utils/analogy/insn_bits.c
index b6b66bfd2b7e71ada03701cc856fa93aea8c98f7..71346f88a541c98da06451cbdd3338cf43a883c3 100644
--- a/utils/analogy/insn_bits.c
+++ b/utils/analogy/insn_bits.c
@@ -19,12 +19,12 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include <rtdm/analogy.h>
+
 #include <errno.h>
 #include <getopt.h>
+#include <stdlib.h>
 #include <string.h>
-#include <rtdm/analogy.h>
 
 #define FILENAME "analogy0"
 
diff --git a/utils/analogy/insn_read.c b/utils/analogy/insn_read.c
index 8f5d5720bb989262140fe25e43e80fbcccf1ef02..b688a3c38685d1cdb4232a1469a8e00bac75eb03 100644
--- a/utils/analogy/insn_read.c
+++ b/utils/analogy/insn_read.c
@@ -19,12 +19,12 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
+#include <rtdm/analogy.h>
+
 #include <errno.h>
 #include <getopt.h>
-#include <rtdm/analogy.h>
+#include <stdlib.h>
+#include <unistd.h>
 
 #define FILENAME "analogy0"
 #define BUF_SIZE 10000
diff --git a/utils/analogy/insn_write.c b/utils/analogy/insn_write.c
index f4d5e5f686e0fa6deecb0d0ae174a20d5a8f7b55..efc8df82bb13443c41e6a45631123f7ec703897c 100644
--- a/utils/analogy/insn_write.c
+++ b/utils/analogy/insn_write.c
@@ -19,11 +19,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include <rtdm/analogy.h>
+
 #include <errno.h>
 #include <getopt.h>
-#include <rtdm/analogy.h>
+#include <stdlib.h>
 
 /* Ten triggered scans by default */
 #define SCAN_CNT 10
diff --git a/utils/analogy/wf_facilities.c b/utils/analogy/wf_facilities.c
index b979c92da09766dc5ffe38f82d32b5223d501fb3..4fbb197c8afe6dae3a008e81b5d6309e1ef85806 100644
--- a/utils/analogy/wf_facilities.c
+++ b/utils/analogy/wf_facilities.c
@@ -19,12 +19,12 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
+#include "wf_facilities.h"
+
 #include <assert.h>
 #include <errno.h>
 #include <math.h>
-
-#include "wf_facilities.h"
+#include <stdio.h>
 
 #ifndef PI
 #define PI 3.14159265358979323846
diff --git a/utils/analogy/wf_facilities.h b/utils/analogy/wf_facilities.h
index f3df82f12d8c7f06426172ea0faa9159835ea0cb..fe88aa402c3d791bdc702e5fcf6b007208f852e6 100644
--- a/utils/analogy/wf_facilities.h
+++ b/utils/analogy/wf_facilities.h
@@ -18,11 +18,10 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #ifndef __SIGNAL_GENERATION_H__
 #define  __SIGNAL_GENERATION_H__
 
-#include <stdio.h>
-
 #define MAX_SAMPLE_COUNT 8096
 #define MIN_SAMPLE_COUNT 2
 
diff --git a/utils/analogy/wf_generate.c b/utils/analogy/wf_generate.c
index e9373097d69ed1f603e775dcdfcf2d5608181e89..b61b07edc802b67b85f16e95fd6cfe44c0bb9614 100644
--- a/utils/analogy/wf_generate.c
+++ b/utils/analogy/wf_generate.c
@@ -19,14 +19,14 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
+#include "wf_facilities.h"
+
 #include <errno.h>
 #include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-
-#include "wf_facilities.h"
+#include <unistd.h>
 
 static void do_print_usage(void)
 {

-- 
2.54.0

