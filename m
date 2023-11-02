Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCB18C2A
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KI/7viJh"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231102144145e8c91b6273f9efbaee
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e53vW4PdjFHa6OmIELXfsAU/L75xpf/8jJlXdQrGlvo=;
 b=KI/7viJhfClNTe4p622kkkJgfO9uuHIj/sLq7vIA8bz1EyTUOdxiKGByTWFxnFQnMqSEA1
 IJtE0+SAvnuZ3NeDzT0owetIsAkXVvp24wQcKkcruw9siz4dgDOtBDRgaM1pLxkpytdVsKFN
 Ima17HoyQc5negx4siYz0r0GcbTiQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:44 +0100
Subject: [PATCH 3/6] testsuite: smokey/spitest: Fix --keep-going in
 combination with --verbose
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-3-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Printing a note about a failing test was skipped if
--keep-going was given at the cmdline. --verbose had no effect.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/main.c     | 5 +++--
 testsuite/spitest/spitest.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
index f24c1e990..11a359ade 100644
--- a/testsuite/smokey/main.c
+++ b/testsuite/smokey/main.c
@@ -40,10 +40,11 @@ int main(int argc, char *const argv[])
 				continue;
 			}
 			fails++;
+			if (smokey_verbose_mode)
+				smokey_note("test %s failed: %d", t->name,
+					    -ret);
 			if (smokey_keep_going)
 				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", t->name);
 			return 1;
 		}
 		smokey_note("%s OK", t->name);
diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index 99d609403..0b9aa62dc 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -455,10 +455,11 @@ int main(int argc, char *const argv[])
 				continue;
 			}
 			fails++;
+			if (smokey_verbose_mode)
+				smokey_note("test %s failed: %d", t->name,
+					    -ret);
 			if (smokey_keep_going)
 				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", t->name);
 			return 1;
 		}
 		smokey_note("%s OK", t->name);

-- 
2.39.2

