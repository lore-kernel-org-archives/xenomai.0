Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABF2D3EE0
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596352; cv=none; b=OyfFDH2pndMjxpdcm1cCLsOTr2Q4/opew2cBLtH5IUH1h1us93M9Cv5xVs6E/DC9+3HpvUjEapmLivDoNDRMnd89R7CF5/eG99dEgccld2KrRKnC73hRtgM60F7UOoyzMxVsAXpqFOguvqL5sjCGTLkTyph6pEpECjPIm/MJ8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596352; c=relaxed/simple;
	bh=lno6U57wW/RdEmIRzHs7+Kmqro0HX+jTgrt8arsWgS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JosV3+aLrFy6pOtuT8fg8v/6YYjcuHC5YFEyeIDNYNRzWlGFcAA6qUPavxZRD3fxJu+0bBoWd9iG6ZPk16n7LBjeopQIfEf3BaJV/ILA4R3Nu1F7qm+I18oDnNbu97YVyGhN3gFUABh9eyOdpQ1/9LyCgM9jc1Z5TLmhDbYmmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=deBKsAzA; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="deBKsAzA"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202510160632255cdea5191600020753
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B+99sR89LaXAi8+vfJ06rIWlkGmmYdAYaNMRvCWqEnQ=;
 b=deBKsAzAnULR2J4kaRTtjh+qcq7AYNKgxXeMsPCDmEa3rFRiKkxA1BgGlyruggcrQA/aDx
 qKWDEjycp8s+6/btZGm+lMLuWVybnxyPA6OsxFZvYlyCULnbuz668tNnr8GYLYYoXPmrRNbz
 BwsC5ZQzbs+XCNnNVg9qy/WAm53UsA9rS3wfPOlqgtsL4NUICr64pM46+JaBVRSYU4ipuCBK
 tywMAJZXJGryoZoDr1wYHkoIu+9jxcy4DVy8jkkQcdqR6hGNncVPx6yep1qmjJlccLMKFcHB
 LbCDL/9+aQWgW8Cbego15gJt8ZeKQDuZZh70wu327vMDAtzCfUpVVcyA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 1/7] testsuite/switchtest: Avoid including arch-specific syscall header
Date: Thu, 16 Oct 2025 08:32:18 +0200
Message-ID: <8e7aeb4b292dd03d0da30929935766f751356811.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

We only need the generic one, and the arch-specific one will soon
require non-thumb mode from its users.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/switchtest/switchtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 434004450a..a2ff42dcfd 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -37,8 +37,8 @@
 #include <getopt.h>
 #include <asm/unistd.h>
 #include <asm/xenomai/features.h>
-#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/uapi/fptest.h>
+#include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/trace.h>
 #include <rtdm/testing.h>
 #include <sys/cobalt.h>
-- 
2.51.0

