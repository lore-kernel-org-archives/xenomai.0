Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87C372675
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221993; cv=none; b=SYxemu4RMRtu+A+SQaBUMH/6KkEOmpjy3hRRfzJ2ead0APPyQivYB38Z/PlbEp5gHosIVWHNNj5PzX3gDRRES/qQ2c+i3w6LMFN8K/Ys8lJgBSODwvnRffafUzUtRXB6BxtkaMx+svWd27Q46xy5gAw/DxObK6lbux7VxnnbdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221993; c=relaxed/simple;
	bh=YAJRCUNu6oAgXuF/Qoco4P4WK1JvnaGEP5k+sTc/8oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXHyomlg0y9FBTy5FjMbuPO4dlT0RA1WLgbankLqmSKfWs/7kQv8rFapXZQ+bKJhI9PgbaeTo+9upAppSOJrFTm2On9VP3OedgLTrjN4ILphBubX4M1kVxerRMoRFrMkRT9rVm3dYOqtn+6Ul3nbNSR8hjUxEqyHLRTOHV0/fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JgXyBF71; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JgXyBF71"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260508062254c2e9aa937000020748
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oNHwtuipX05DkS9Tj1UltR49zytyeITUwaGPt3vuzRQ=;
 b=JgXyBF71+vismekig9TiwMn5vSe1ZKeYOTAN1sUi9r1tPIfupGOA4Jn29Qxc+ZqTwOebEz
 L+kQgqaJxn7db5j6XkDqabber/O/txIwoXl4zs4LCXWhjEur22l4g2MAk+PngAycR4PgOQCr
 1ARUpr3aeh9XD2UjF2bZjYw1hI4FqssVffr5dDgeXrwCReLVgGnG4B+tmu70MbDaa2avxqlE
 HwS+2C04QN3mQujydtXW8nArn0GW1Wulkb7SSRC2zYDsyGsTfHOPf0JuP56rP7WM52dDPEHu
 wNEP1QIBfOyecg5CV+Styhdru8Rsp788lVfiHnwVT5f+nhCmsPEzxOGw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:44 +0200
Subject: [PATCH 11/32] testsuite/clocktest: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-11-e449f2bd4fc2@siemens.com>
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
 testsuite/clocktest/clocktest.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index 283d33ccda77285483e06b781ad1feda53b52556..ae50dd9690235cf11c2326d6171d9ab333ae8605 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -16,22 +16,16 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
+#include <boilerplate/ancillaries.h>
+
+#include <ctype.h>
+#include <error.h>
 #include <signal.h>
+#include <stdint.h>
 #include <stdio.h>
-#include <error.h>
 #include <stdlib.h>
-#include <stdint.h>
-#include <ctype.h>
 #include <string.h>
-#include <time.h>
-#include <unistd.h>
 #include <sys/syscall.h>
-#include <sys/time.h>
-#include <boilerplate/ancillaries.h>
-#include <xeno_config.h>
 
 /*
  * We can't really trust POSIX headers to check for features, since

-- 
2.54.0

