Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC717A580
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013149; cv=none; b=U7TBmtkO0eefwp0oY8aMS5bnWXDNx66a1BQnIKVJCmMFw6Xi8C1sFlr0LKb3cNcUR5s6WZiy1YSn26a9JIWc2lve2LirGIodXiyFyRQAyh6WjhIXQ47PcIkUKFlJDUQjbfIIGrSx6cu1a34v7gO4+Un0G92jQdH1NNRB1fdQK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013149; c=relaxed/simple;
	bh=gv+HkaPRPrb2wMUVJ6Br3QGJJYmQ8Up1VDBuysneKj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9peTNnWF3aHZ8pJSVqpWj8LvOT+nC3yBLFGZA1nDKzgGLiwVw+TQUzqxsLzE554hGyeop262YfVKDBCXjxlXuluJDkWkw/hnPL2bVgAWdN9c36AyyGsWdS8CdvAoqSgHyCmr2tXmyKaDm91VmB0WQzOqIy91zHKSs2c4tGe9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FAl/kQt4; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FAl/kQt4"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202407031325383f58af4c0d4a286e68
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ss38AcJid5dCTKdo4XYLhVQBnGQHEspJsdUjOUamVYI=;
 b=FAl/kQt4VECow30cjIW/HJl/aX6JonBDIJ8VOjDsbiW2ybB5/aJ6CLvB/TCbta3/MtzkiF
 mHtXSq0ufLSYECtPth8hJZF9BqF12Frqzw8v6GIuApoNfw8G8iVRZcmSmWBF3ywsDO8LSkCQ
 5nAY75aofpIxP7L66efpsc28MlfyQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:25 +0200
Subject: [PATCH 02/33] cobalt/x86: Add missing log level to printk()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-2-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The Xenomai prefix was used, but the log level information was missing.
Addressed by using XENO_INFO.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/c1e.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/c1e.c b/kernel/cobalt/arch/x86/c1e.c
index 492ed1dae..65ff7bc64 100644
--- a/kernel/cobalt/arch/x86/c1e.c
+++ b/kernel/cobalt/arch/x86/c1e.c
@@ -22,6 +22,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include <asm/xenomai/c1e.h>
+#include <cobalt/kernel/assert.h>
 
 #define ICPU(model) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }
@@ -63,7 +64,8 @@ void mach_x86_c1e_disable(void)
 
 	id = x86_match_cpu(c1e_ids);
 	if (id) {
-		printk("[Xenomai] disabling automatic C1E state promotion on Intel processor\n");
+		printk(XENO_INFO
+		       "disabling automatic C1E state promotion on Intel processor\n");
 		/*
 		 * cpu uses C1E, disable this feature (copied from
 		 * intel_idle driver)

-- 
2.39.2

