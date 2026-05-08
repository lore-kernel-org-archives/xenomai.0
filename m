Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442636F430
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221399; cv=none; b=vBQwzUCpYq8H3LWXDkLOA4E7E8NL3JLnoDgtRvxh7ZA+zp3uVmfNeQoGSNJTfpRfBzbueJa/Vx2nZeVO5/bzQ6rtzrG2kRDJ9g0Gy8UnEFE0u4JvYVHWpBj7BzoCCEYYts+qLPjO0JXwHdGXDSKPgSeNlcT8JVgHfCEIFlHN6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221399; c=relaxed/simple;
	bh=gAaYBuAG4Z6OLZvZAa8jGeEyNPFTd3AhnPkyVfHdjhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrTVHLlfzAfmmi4kr4pGtRfJY8vlouLOkfC2zvsXnAAUl2mVr7zs5B7BUmAN5KVXjvWX66m7JIwpaQSkGWWvfdhPPe2I0PDTHJdSQ9ayfpZvuQtdEwVg3KCH51Xmkg6VaVJGZDGJICNa9f/Pn3fi97wdfQ3TuDax8VjLkz/5G5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Bgwpx8oI; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Bgwpx8oI"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026050806230239ec5adbc300020765
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+ldF5j4PCCCYktLvoWL/MjnXBhDf1KWNaMazPUAbkjE=;
 b=Bgwpx8oI9lCXFmobvxyHuYQs1GXk3bme9V+x/4vomY3dtFTkH1Gw3Avx5S3+Fc7SgBKHDb
 Jq8NnwwGPubMTi8Dc/w6lXNWe7D+dzWm8CY1zZm9yIWnADxh244ECnZP8b8EIE2VcfFuir+y
 Bqx7aSb84WQFDrDVfmzE3C29E2OQM/8fYx6LsIfbA4W55VA8UVmtgrkg/8FzE7oOeKO9qx/j
 jCSH+x4TN38Gv2CicjTQFK5eFc9ofETI95Ci0uyFr7rm84eMzJk5sadpFaFwJQcFYaqDjfEq
 5VIzRcqff8qNmG2bD5OIx8c1OSOtjmftPg7z8e/ttCOUb4GqRejBDHVw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:55 +0200
Subject: [PATCH 22/32] testsuite/spitest: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-22-e449f2bd4fc2@siemens.com>
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
 testsuite/spitest/spitest.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index 88eca0246c678512bcdc9e6ab3023fe71fbe753d..afb0c7e6cd1e59ab686510386dc71e41aa800c01 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -21,19 +21,13 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/ioctl.h>
-#include <sys/timerfd.h>
-#include <stdio.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <smokey/smokey.h>
-#include <linux/spi/spidev.h>
 #include <rtdm/spi.h>
 
+#include <linux/spi/spidev.h>
+#include <sys/mman.h>
+#include <sys/timerfd.h>
+
 smokey_test_plugin(spi_transfer,
 		   SMOKEY_ARGLIST(
 			   SMOKEY_STRING(device),

-- 
2.54.0

