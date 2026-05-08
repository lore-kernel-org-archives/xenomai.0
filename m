Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8134CFDA
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221393; cv=none; b=nNX/b5RjgrZo2VnmhwfiQwa4q56LJ6Xxubyi7IsvqoA/GtSz/OOKkO50ErQiCcB/fXScE2VhO3efYH+iKo+AdsF763cG9GvpMalA8ewBA/cq028UbZXKogXW+XlCiyZ0yFNttNNi+x+LIgHi16Wju80LeY3Gc/QjdS+jUw47iRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221393; c=relaxed/simple;
	bh=xlFSSIf+3XmPuM7m6lko3pN5FXashh36ol7wusCb+/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGPSeFKq9HyVbF3fdad/lk5KhrfAG0RIwNl7S6jEmhr8cjx7LkwP+t51aMJM/qQEKJOdoBpQwdyAQPwM1kSvR1P4XPBnvkfYPX4gGFCYFfwGGnWm9IPYck0HgA+Y1h5QJefLZP+q91hXyo2lqL/A2x3GmSoYl+obrF0JFUMKWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xw3+I0FQ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xw3+I0FQ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260508062256865da15aaa000207e8
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zifWii7SgoIhRwNmFCbYan92VQkSDNu5CttEO4J6IgU=;
 b=Xw3+I0FQAhcXVeQab7v1lmTGZoKUTU+GlGU8dTRSnUfPatzUzTzEELwjomxb1fBJ9wYjHb
 pBrBWuAPKx9FFVO/ELKNxG7naN3djupUUG3060UVnad3UiL2Ikqm4Bskt7eDFdVxrlqFG9SB
 Ag9w/VAWH+WzLhIjEjlj1gwXpRiYsYJS6DEPWjWxRSRt2qREbwdwmYnG+JwLZCayvGfvhFHN
 Wo+lNWZCTYDacHm2vwl0XfC6o+U+ba7ulMmZxA4rBf5PrEjM+VxegA0zRkIknexuhZ7V+BN5
 0aQlqv3z8nfHO8+V2YpQ0Qoj7bVBlH7dc9IDbdMfuMbBvPNBqVjHGQ5Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:47 +0200
Subject: [PATCH 14/32] testsuite/latency: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-14-e449f2bd4fc2@siemens.com>
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
 testsuite/latency/latency.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index bb97711a42db212f761b6cc02bebb51ea69d2366..edc568b6a57d076bbccc64f66f808c6ef5dd443d 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -22,24 +22,18 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdlib.h>
+#include <boilerplate/trace.h>
+#include <rtdm/testing.h>
+#include <xenomai/init.h>
+
+#include <error.h>
 #include <math.h>
+#include <semaphore.h>
+#include <signal.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <error.h>
-#include <signal.h>
-#include <sched.h>
-#include <time.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <pthread.h>
-#include <semaphore.h>
 #include <sys/timerfd.h>
-#include <xeno_config.h>
-#include <rtdm/testing.h>
-#include <boilerplate/trace.h>
-#include <xenomai/init.h>
 
 pthread_t latency_task, display_task;
 

-- 
2.54.0

