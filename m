Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FC377ECF
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221397; cv=none; b=FdZcxjHuXKoQpwyxiBY35/dAYlPuyOG2Afuj7pKEZXDyP4y3egb6TfIivuR9ZS5GOVD6V8xrDBxUoCDVdk1J1SfEUo73N5XNIJEPLkHkCx6W5AU65VPYYCjqPKgRGb5ZZMx1+vaWO4VVb13uTA0E6KW2GHtfO9reZlc3jhfa5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221397; c=relaxed/simple;
	bh=cX50DBVPXULk2qjAath6GzcGJ+HsSG4r1ICLqvm5c9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhK0FjyeK6pNS8pST24i9b2+ckjlY8n2XQSkY5c+94nfAOF2SIZD9xBfyY83l48oXAXpLrLpD/P7qxzSP6L3myc2UIi85iUK69B8gRPujZyxiPHyVPorTJ3eDXCvhEUggtXfpjyviGgoNn5pX8ZGfQHatfTqE47Qu12rWSAmIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Pa4CY/dP; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Pa4CY/dP"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260508062259f745e6ae7800020766
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RmgB326/AvcF+PHJiQhgIPKMIEYy+6SSOfGYz/dxNWE=;
 b=Pa4CY/dPP+CRliBYSj7DmCOw/L4EqQQvklQgSv4qjdXsd3vxvAdXGQB7nHzxWcmTi/HrLm
 UapuxXWdssSVfzeBP+wMQgVsGJ/gbng9m9PzuL6jjIMRdzmPRodOzeMnLnhl6Vxm3PXlLtxl
 fek0+2eMQAyemJGbcXyBgXYCHZbLdRRGMv1gvhdEl4TSV36mNBoeu8yRHTyCHKaXN3QfbUD9
 o/TrtTJvo+xODJjBO5rkKgvJenb6d3C1XN08RcgHpFgzXu56QhMdOYqp4ETuDAAz3PnvAvEa
 VwEDrFlG+Qr4kar97no/IURztJ0CPAd2LSVY/Ay5MLiHTlOmHbPJygtQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:50 +0200
Subject: [PATCH 17/32] testsuite/smokey/dlopen: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-17-e449f2bd4fc2@siemens.com>
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
 testsuite/smokey/dlopen/dlopen.c          | 1 -
 testsuite/smokey/dlopen/dlopentest.c      | 4 ++--
 testsuite/smokey/dlopen/libalchemy-test.c | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/testsuite/smokey/dlopen/dlopen.c b/testsuite/smokey/dlopen/dlopen.c
index 5259f067ef61ca78623f547974d6daf7e501e114..3262ab065e4fb30de316bde9de2b7d857f2597bf 100644
--- a/testsuite/smokey/dlopen/dlopen.c
+++ b/testsuite/smokey/dlopen/dlopen.c
@@ -21,7 +21,6 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <string.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(dlopen,
diff --git a/testsuite/smokey/dlopen/dlopentest.c b/testsuite/smokey/dlopen/dlopentest.c
index c124701ea710203d4bf19ca1d615dbb33d2905d1..8d5db3b5003c37de8f8e14b0d88049f474f4d714 100644
--- a/testsuite/smokey/dlopen/dlopentest.c
+++ b/testsuite/smokey/dlopen/dlopentest.c
@@ -21,12 +21,12 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <errno.h>
 #include <dlfcn.h>
+#include <errno.h>
 #include <error.h>
+#include <limits.h>
 #include <stdio.h>
 #include <string.h>
-#include <limits.h>
 
 static void *my_dlopen(char *name)
 {
diff --git a/testsuite/smokey/dlopen/libalchemy-test.c b/testsuite/smokey/dlopen/libalchemy-test.c
index c433ee3054bf062ea934ca42862e1b1151d1c7f9..db4613b40e879a9a97340c464252095c255efd10 100644
--- a/testsuite/smokey/dlopen/libalchemy-test.c
+++ b/testsuite/smokey/dlopen/libalchemy-test.c
@@ -22,9 +22,6 @@
  */
 
 #include <alchemy/queue.h>
-#include <string.h>
-
-#include <xenomai/init.h>
 #include <xenomai/tunables.h>
 
 static int ran_init = 0;

-- 
2.54.0

