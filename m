Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3B1B29D
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DMRMHr0+"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023110214414585db8ac1a582536295
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wcqBqqbQu5YqiCPnZrIM7S4u8VdzICnUIb5mha7XeB0=;
 b=DMRMHr0+79sh8NkqKZ9U7QhhdqfRDXP1rh423NVjikXwkhaXQLrEiHJ2NL1s7Ldk1ZLZAD
 YPfvOfyM6zES+p6frNvT0Ohz5qbshksKjnzM2qZ2spCkTlJwIr/LVU5cczi4VFaN8ATUgLUz
 0TE1wtWPCyFbxkvo0zny+8xzsWJOo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:45 +0100
Subject: [PATCH 4/6] testsuite: alchemytests: Skip pipe test if kernel
 support is missing
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-4-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The pipe test depends on the RTIPC/XDDP protocol which must be provided
by the kernel. Skip the test if the kernel does not support it.

Might be that the module is not loaded or the kernel configuration has
CONFIG_XENO_DRIVERS_RTIPC_XDDP set to 'n'.

The error message reported by smokey:
0"000.543| WARNING: [alchemytests_pi] RTIPC/XDDP protocol not supported by kernel
0"000.567| BUG in __traceobj_assert_failed(): [alchemytests_pi] trace assertion failed:
           pipe-1.c:88 => "ret >= 0"

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/alchemytests/pipe-1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 488c0ee3b..8989f3a46 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -6,6 +6,7 @@
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/pipe.h>
+#include <smokey/smokey.h>
 
 static struct traceobj trobj;
 
@@ -85,7 +86,10 @@ int main(int argc, char *const argv[])
 	traceobj_init(&trobj, argv[0], 0);
 
 	ret = rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
-	traceobj_assert(&trobj, ret >= 0);
+	if (ret < 0) {
+		notice("Test skipped (no kernel support)");
+		return 0;
+	}
 
 	ret = rt_pipe_delete(&mpipe);
 	traceobj_check(&trobj, ret, 0);
@@ -138,5 +142,5 @@ int main(int argc, char *const argv[])
 
 	traceobj_join(&trobj);
 
-	exit(0);
+	return 0;
 }

-- 
2.39.2

