Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380436D9FA
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221385; cv=none; b=jNXP3PEDoznAfEGEXVCJuAT4SC4epY+t4PaYmJebET1MqGkrODypIDrkMg4CeuMlkuVcGNOJyT84i6gnUoyFscDYwG/1v9VNwBlQySKfv+mhuwRq5ZOVfnGjlGBiKdvic6bPE9iChxDACd+1wVDRaM5u3OW8O6LEn60bedDLsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221385; c=relaxed/simple;
	bh=D8v41F2OZUG67DClfErOS0U0X/q/H7y0DsVfNaWiCjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EobBtAcTAZ9nP9xDQaEmU+Hfh7BLsJdTDqNHpe8ZL7nOLpfi2dTHntqkqSp+CeBkL1BA4dgSZS4Ku5JViyEhrWDQ+v/FlYTOAHkv5xIyUyKrgz62beGWWjMvmmfR+ujHuJEc5sYkRNanfkc09iRj4yFfWt1UcQ9bPz4k2WgGrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fyvCbDHX; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fyvCbDHX"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202605080622533c54b763aa00020769
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UuxiMVSWAqqpctAVr+SHtCI5iFSHW5wKxYl6c64LnqA=;
 b=fyvCbDHXsWaqiOm8lTAQ2I7VfuLrIJ+M2WTaJuGPbsXqY6qnmPSii+X73RcSXbklwEtWYH
 2cz7oPsTQX3hBIxTYlByRuHUdLfa+FJH6JFqR6ERMpQjwXnAPT+WeS7EAfJrst1oFTCOir7m
 aryaF9bPHY2x8QA3E8sukEhflunLFpcZjHYbLwiPXpinVooL68ZQmQuRBoDu01l4zdr/+UYV
 G9aIxzrAJMgz8FF+gpAUb08WQJ2SftEjOb+NWsR05zu6ye/R1oN69lW1Y1sXvk3gMcP4m4eC
 zbD/78tNve+1n0wTZIFaDN2ervJIJYOcheghcYP01GMGncOiDfhbzxXw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:41 +0200
Subject: [PATCH 08/32] lib/smokey: Rearrange includes and harmonize license
 headers
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-8-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained.

While at it: Harmonzie license headers. doxygen reported a warning
while generating the docs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/smokey/helpers.c | 15 +++++----------
 lib/smokey/init.c    | 19 +++++++------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index f4b9ee1fcd83238508ae722d4c57ee5191099700..fe52f48db08628b79df6e8331e0f67bdf45f7cfa 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -10,24 +10,19 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <stdarg.h>
+#include <boilerplate/ancillaries.h>
+#include <smokey/smokey.h>
+
 #include <ctype.h>
-#include <stdlib.h>
-#include <string.h>
 #include <error.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/types.h>
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <boilerplate/ancillaries.h>
-#include <smokey/smokey.h>
 
 int smokey_int(const char *s, struct smokey_arg *arg)
 {
diff --git a/lib/smokey/init.c b/lib/smokey/init.c
index 19e47f1fbde9d7ed5cc8397453219493ad55528d..1c45572c75e4f58aa845a385a519369909d817ad 100644
--- a/lib/smokey/init.c
+++ b/lib/smokey/init.c
@@ -10,25 +10,20 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
-
+ *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <malloc.h>
-#include <string.h>
-#include <errno.h>
-#include <getopt.h>
-#include <fnmatch.h>
-#include <boilerplate/list.h>
-#include <boilerplate/ancillaries.h>
+#include <copperplate/tunables.h>
 #include <smokey/smokey.h>
 
-#include "copperplate/internal.h"
+#include <ctype.h>
+#include <fnmatch.h>
+#include <getopt.h>
+#include <malloc.h>
+#include <stdlib.h>
 
 /**
  * @defgroup smokey Smokey API

-- 
2.54.0

