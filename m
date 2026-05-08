Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E61419A4
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221992; cv=none; b=YizZK5D65niEjkGAzGGAt0HU9s3olfxju7eFsE+bR77Tk6JNTLGXD/QdPPjFITSiwJCphMV2hrSnfG3nJP80DkXXOTPO8CuACilaN3p5+fKOQ5dpd5U168UIY2Rme1aRAiZjNrBZEPuQ0D8vfOJPIineKdvY32DvDLiOiR3QRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221992; c=relaxed/simple;
	bh=ASyRdzo0Bd7rPpP0DLywEOKSJB7MoKd0mzA6l62z/Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kk8MhxXdJA1o4i0iu8FK81yYmuCvfOu9Qq+lwNXDmjjVbCfhl1GVAto5bpnbpQxUa3iH+qkM2tleCT8U7eSm32EoyVL+4x0LivBJxcOoSxs9rj7nFUuvsPP8pQJbt3TjSEwR7adTT+tyHEjZxjUma0ONLnpTYKfswFX51Cijl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VXw8307w; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VXw8307w"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260508062255a5a4c4edbc000207c9
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TgohpcU+R13ptHD/4om6dzEh8pFDlas9jtRcbYpiEgc=;
 b=VXw8307woIIETCFGdjFedqqHx7mkMlYBvxMzyiwg+2lrdiEWx0Pz6+9q6ErhrTVtNGE1oq
 oKglHlTo8ZqnxTDk5GHJztT6kT7eZyjjY8TdyP+6Y+IqhoE5IvfSjWZ9uViF+DuZ2O5La3ow
 EebYwdZkwYY6bJCw13dqdxpOgNM9tGbCrydb2SJXjV15ANoCO41rLeYu+szd4h0Q1rnGOm7N
 fg08yUSaw34LuA6ljXxUtnbTysfV7b/xlgGcFZUOIK/DHWPRZDjAO0mlRxc1E1MQZd1YxvGb
 +vqBkK2CXyvaT5sLhFoYQk5szrCwSkxeWfy1mMwnB7XBk2ZCkM+rB34w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:45 +0200
Subject: [PATCH 12/32] testsuite/gpiobench: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-12-e449f2bd4fc2@siemens.com>
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
 testsuite/gpiobench/gpiobench.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index f2cbb2549d33971dc48c10f0aa77738029c2ecd5..41a46e9b342878a12c47c8b7fa871ea09cb7da39 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -21,20 +21,15 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdlib.h>
+#include <rtdm/gpio.h>
+
+#include <getopt.h>
+#include <pthread.h>
+#include <signal.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <signal.h>
-#include <sched.h>
-#include <time.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <pthread.h>
-#include <rtdm/testing.h>
-#include <rtdm/gpio.h>
-#include <boilerplate/trace.h>
 #include <sys/mman.h>
-#include <getopt.h>
 
 #define NS_PER_MS (1000000)
 #define NS_PER_S (1000000000)

-- 
2.54.0

