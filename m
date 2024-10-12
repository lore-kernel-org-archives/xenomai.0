Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AB153BD7
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728815; cv=none; b=SWcjvGXa/XZ90gehLeD52umlSmMZeNLIqpwRg4ACqPNU0HCDdjjbkrjBct7tqSfGtQGVeVvsEsKpvQb0AOOXdq9fC3/jDulK7eB/m1rObCn1tUYYYnbqrSm87MWSrvJgFfxm+Zt3mPEXr0VqMEHqb8stntQS+sSWU33XUr1SQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728815; c=relaxed/simple;
	bh=HU2yp5oa3LI5n4CYPvP/a87w/G48OFW8jlNv0ALdbbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gvub0UeEaGonCihe3Oob1OfIawoOFCTtzYAhmVU0NvaC/r3eYfPvowob5vYwdnAEeBS8ToqTUH4dgBFFcP9bsmPILi7FwNW6Epv/ND96wgIeXwUZvvx7Px7Yec754/ks23MwWvMYhXCQ13xpOEZUzr9fk6hV62IFsNTlYLP/5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Mh6HH0Dc; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Mh6HH0Dc"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241012102644c8f5093d0b78df0594
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q81fANhBEDZWjfhD1eKE4dQdS8lVEQCeFtCcwHy72eU=;
 b=Mh6HH0DcMRvmWlshcjz+WxYureK3h0VEunHWcHPShEcN3cgPMaLbz+Qbo14bUob90QL28Q
 s1og1NwHbJ69eGqxfFhZVl8+pcNqzuLwZbw90B6ZhhKCRtdXG2aaD5HnJSNHCB0SIKle05+T
 RKd4RZ8YeYQQSVgtcIqCEgQuwEOWuUj3nskbQE+o2XO0f483jCL6sgE1GaZqtRfLBuRhvI7j
 uDoCOMJul26dylmVTuSy+066GMnfcG26qNy6DQH6/FXMgdzI1a8KLf/O8u3ri057vLceNgN0
 oSJEC5IW1Y/RWpFwKbQ7pyPcY7UKLI1oDlTR3WUsK72SEPt0w8l4lRCQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:42 +0200
Subject: [PATCH 3/7] libcobalt: arm: Cleanup unused includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-3-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change, preparation work for the asm/xenomai/syscall.h
removal.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/arm/features.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/lib/cobalt/arch/arm/features.c b/lib/cobalt/arch/arm/features.c
index 707c87c7c..4db1e6f9f 100644
--- a/lib/cobalt/arch/arm/features.c
+++ b/lib/cobalt/arch/arm/features.c
@@ -14,21 +14,12 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <string.h>
-#include <string.h>
-#include <unistd.h>
-#include <limits.h>
-#include <cobalt/wrappers.h>
-#include <cobalt/ticks.h>
-#include <asm/xenomai/syscall.h>
+
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
+#include <stdio.h>
+#include <string.h>
+
 #include "internal.h"
 
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)

-- 
2.39.5

