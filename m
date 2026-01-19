Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B642D97B9
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818858; cv=none; b=U2+IJltcAQjVVhzfOXk+3TkenK9fCD+MkErVlG4J4YSiyN3BkYKgVZzUaGA4eBGMjDNhG8E1DflaZenSbbHE0a10S00P0QVy+D5vA1+bGXQq1WC1iwV71kZql0Ee1OAM1ir3x0i/MW2JwWR0adNT3GIg6S5cqSU0Vc1ItyKwFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818858; c=relaxed/simple;
	bh=FbT1t5Pes/O9V7fOTTSwWnH8RofyoXydbudECBhXCDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsTQdySQLCYl0rm5OmLBHXqksVToUOPEIThL1o+Jja1Bm7qHcXJaLIKYDjW6a1+cVg2VgDy9rMkobFy5jNLWfCVP+mE+MNuKwzrDCGV7jxBVnB7Y5R1qAsJ8OxK33bSfdpUBApFnOG5UbICi73ldPe34msZkamHzXg9UdlfcPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Tyb+nwyZ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Tyb+nwyZ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601191034060d2759b97a000207e2
        for <xenomai@lists.linux.dev>;
        Mon, 19 Jan 2026 11:34:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hNOueMmdtr/+46IuBX5wttTmykK1ILKGZijYv7+y7vk=;
 b=Tyb+nwyZL5zgqiwXL7xX8FHsydfgM/vRp1decemNGBRKVTqz4X0EL3bldO1r8xDvvS5Rz9
 zVkXNk4TDV6lwZnFUHrwibP6I3UaY+KsenzfrVPGnjUNlR4i7b19Y98u7yQA5SF1qhDh9M2f
 84mSGNqP5EG1z1xv/HgwkGPr2paU4fDeBDVV6vzdvSwrAufskfUAYUrBUzJXzNBkJNBtYvz+
 wJ7zgzLMV0n4PxlzIhmpE73hlFFKHl1q0sXIBDFowWodvysM9zVKl3C81QJognvxkCsvc/5e
 AJ9Ow9Vl249BLF4k4oZ5o0sPJ+I8oK0AQybnXBZ6idnk6tj744c6r/Vg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 19 Jan 2026 11:34:04 +0100
Subject: [PATCH 1/3] testsuite/smokey/gdb: Remove unused include
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-wip-flo-test-improvements-v1-1-b70e8726ec0b@siemens.com>
References: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
In-Reply-To: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The xeno_config header was unused. Let's clean that up.
No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 3dbf87ab0..241fc614a 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -18,7 +18,6 @@
 #include <pthread.h>
 #include <semaphore.h>
 #include <sys/wait.h>
-#include <xeno_config.h>
 #include <smokey/smokey.h>
 #include "lib/cobalt/current.h"
 

-- 
2.39.5

