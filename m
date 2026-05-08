Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5B35AC1E
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221996; cv=none; b=ip7iIx89CgH8vHEplJnAHvU1dSj0Nj0g9a6lnRLVOSWm1Sf8+RaayGgTluZJq7FUi7a4pFAwxaYFWbyRxtBCba+UwHPpmzOBDnuFgJskhx7GFdIZqezqR5ydNRrqELhIsKP8MpX84NgQtvfnAcYw2kc3FNnU/pYjqZt9OYmO784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221996; c=relaxed/simple;
	bh=kPp6X+t0X/yhopivT0BAMx35V9C6WYjEQnrLgYOdI04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWYq+DqVsZ4REVWuBpPe7x6b86PezjRUHJjoGfAi5GqI3EM69S8IopvRnai1KxGxt8VGaKfZx3FHWi85RZVqoxJ5XZLDAjOQssljkAZjqv99DKJC/ue9GglWOgAFmziSa29vUCZsVlf6dVkLzOa2htTv5Dc5bfmDHEQlhhtbErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hcrNwsyd; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hcrNwsyd"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062256ac727943cb0002070f
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sBsJqmQ3GAfRJ5O9NgqSya6TiG8VWsLZ+5Uk4rxQzkk=;
 b=hcrNwsydT2Tinx6C7METmXvOvjA6qeFZM6syB9D+UiZVRQfEQ39Q/4HaLGWcjEuRAwNJF2
 9LK2S5ZuCX2iHtVvTWd0gDR1HF3es7DOV2jZGhJN/yLPZt85uQfc0VnukJhF6Q7hm4bw5i2F
 c4+zlLw9snMauOV/k2kHHJA2qeo7nFscE1mVWUf4LjiRqSW1ljeQVJDbjqxLtlgS/vBuXKbq
 aWfhza22jdQ2mR1RLr5sncvO+OVo18Nb+Y3HJGEqdh1CkX4gcnLjiRMKCoey8uwVTcme1MDu
 lE0o+04uWVvYTFk400hkN4fviO/xFW3io8HvLy/66Shag6n4aWSZwTLw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:46 +0200
Subject: [PATCH 13/32] testsuite/gpiotest: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-13-e449f2bd4fc2@siemens.com>
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
 testsuite/gpiotest/gpiotest.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testsuite/gpiotest/gpiotest.c b/testsuite/gpiotest/gpiotest.c
index b86a88515413f4cafbbf7898926ab9f01481a47d..65ca430d8d08660a7c847209e7407280ce03878b 100644
--- a/testsuite/gpiotest/gpiotest.c
+++ b/testsuite/gpiotest/gpiotest.c
@@ -21,15 +21,11 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdio.h>
-#include <error.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <smokey/smokey.h>
 #include <rtdm/gpio.h>
 
+#include <error.h>
+
 smokey_test_plugin(interrupt,
 		   SMOKEY_ARGLIST(
 			   SMOKEY_STRING(device),

-- 
2.54.0

