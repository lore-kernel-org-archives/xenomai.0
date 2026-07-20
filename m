Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE142900B
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582920; cv=none; b=Rv52k88tKOXD2y823un0+n5QDb5DdkiPDXxl6yQXWV5kNNGpiHVNP6YGaLaBImJQQh75uPm7d5p4N3LiE/FJjgxecWhQQavGeaewsG1K58mhEj1DEGcOe4BfjZutX0vpp/vZCmKSSoUT+T7t+0Uyu8Chy0nK0p4gVmfPavUI2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582920; c=relaxed/simple;
	bh=H4/fXKvT7BeVcGZUZ3YFyjNWcCRs0aJa85l1MZT1j/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQUmwQKqmmr1O1Y8jfyGw1KHtHPzmrp5UdKUY9FmOSguyiXGusj7HS5ZuT+4T37vHJfXemHmSwLo5gqxxXLAT5i2yZNu2n3/Yw+RWhxKg3TqtrgTeIy14Uwgyx99ug2BZZ7h1wHWqtcr3ZrqYzKxwh3jIarijteNIUOTywBjpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Y2Nx1/Vb; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Y2Nx1/Vb"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202607202128268e22f13e90000207a4
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 23:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zCajoI4oUTjqVypgAMcj4BCMveg7nUoO9elRzUEOMF4=;
 b=Y2Nx1/VbIsBTiI9FhZBEfSjDO7DIo1s08ArgAm5IC3X3cTjpuzzLa3FekXXOMffMUpaPPP
 NVGvzg9GJcy84X9wB/gveGHjjhOCPDjqeqJejHd91E4bLq7yjpDq4M5bylSVMCAviS6OSc20
 iE5ivhMNOwX9GO/i1xn9Tl+l5vGWYrq1ZtmzmSNCgg2vAZjloc4gFIiqG274IR7ewpGOz7HA
 88TjhWb5EGiyQkgNG4T7j1tpHRfOCgyyOMihScf2iHC7Sm/mXE7t0LYhG6YPS73ompeucG0F
 eJe3w6H1woidyrXv3PdgqGJ5YBT2ASDwxYei80/Q7GTVA8w/8GmkbIgw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 20 Jul 2026 23:28:25 +0200
Subject: [PATCH v4 1/3] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-wip-flo-gcc-16-v4-1-f281a1f0cbd4@siemens.com>
References: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
In-Reply-To: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following error:

task-2.c: In function ‘backgroundTask’:
task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
   26 |         unsigned int safety = 100000000, count = 0;
      |                                          ^~~~~
cc1: all warnings being treated as errors

The busy waiting loop is keeping the background task alive, so that
the foreground task is able to call taskSuspend() for the background
task.

Replacing the counting busy loop with a call to threadobj_spin(), which
will be time based. We will stay in the RT domain while waiting, so that
taskSuspend() is called for a task part of the RT domain.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/task-2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a13383418c4360241ef244b8a24da975..d701394dda9d340fb59a7a96ce6e1ea620ca0212 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <unistd.h>
+#include <copperplate/threadobj.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/semLib.h>
@@ -23,7 +24,6 @@ static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
-	unsigned int safety = 100000000, count = 0;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
+	threadobj_spin(2000000);
 
 	/*
 	 * Enter infinite pause so that any pending cancellation is

-- 
2.55.0

