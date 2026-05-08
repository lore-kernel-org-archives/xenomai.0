Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15B34D93B
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221396; cv=none; b=SRmYo+K4p/ekUDHX+HRzuJXZWG/KRGcCvY9yMlULuio0yAmdCifGt8XmvP920npI3Q3TjbqG/nvshw333V6dQB1fn65ZOBeQOyMb8irQn+hsssrgqMCfUCA+h9tl+ChAwUMzxva+liD7vBFVzuh2Hqd+ehLRc5Xtf3fNLPBQqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221396; c=relaxed/simple;
	bh=3DptEIOO6X+kAa3KC898OoAZV63BEtiIm8gJzBqPAf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Orwik0DmaU98Yp4R5u3D21+tvO8KDYlvPdfyJFzjyTJisA+66DmeOBbs/XSNbB6/g/yfrTR+5TcwjAvGgSZPmJzpmmqH1reKlZIcanm/kG4iInuQOUH4WNYGvyCAiYQVxOltuiINzT7pC/uRwr4bPWYRaXlIF7ssyqBsE+4Bn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dpeAUCML; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dpeAUCML"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260508062302415947e1980002072f
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZxTPr8ERhkZOFnEhSDChczQbYv3pb2mYIjqXQfao4Y0=;
 b=dpeAUCMLGnjIlayoCgSvNrSEtVMyehA+vkzzBSnkRshgxoyfrvWGpPBxKTNL0nBSI3MaiX
 mCuhBmdrUDA971JYxjS1UcQ+OsHX+y7hSEG/Ak3XgX2inmkK2tTxb51JvwIFRFYRa7ZxDLPZ
 +Nyrbzg6gbEag5fEiIjEvF/RE4uUblEL3+7MczvWSuandJ4qQS6cKi9eK9zjCZJtCDDZHEX3
 v+FjXzpKNDjbirXs6ZYcAFuaZRALjiFgDVEFITLTFpU4aX9/coISgAJP4PINZmXre0R2opsK
 HmtcVKLnlfeBZpHm2evh3favtNbS2SIFJ6rGsQPMK+ziXyJX079Y4WMg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:56 +0200
Subject: [PATCH 23/32] testsuite/switchtest: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-23-e449f2bd4fc2@siemens.com>
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
 testsuite/switchtest/switchtest.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index a2ff42dcfdd6cc894913ecf3184da07a5474ebf8..eebd2de38bfa37a043e8f65ddbcddddd13c2722b 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -21,29 +21,21 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <ctype.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <stdarg.h>
-#include <limits.h>
-#include <sched.h>
-#include <signal.h>
-#include <unistd.h>
-#include <pthread.h>
-#include <semaphore.h>
-#include <setjmp.h>
-#include <getopt.h>
-#include <asm/unistd.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
-#include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/trace.h>
+#include <cobalt/uapi/asm-generic/syscall.h>
 #include <rtdm/testing.h>
 #include <sys/cobalt.h>
 #include <xenomai/init.h>
 
+#include <asm/unistd.h>
+#include <ctype.h>
+#include <getopt.h>
+#include <setjmp.h>
+#include <stdlib.h>
+#include <string.h>
+
 static unsigned int nr_cpus;
 
 #define for_each_cpu(__cpu)				\

-- 
2.54.0

