Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B831B110
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520018; cv=none; b=tdApn64oITfRPkxnN2k7rZsPmLxSOrEgFiqrwvG9JK4d2bVQAf2pE/6LmvrdNheJvxwh9p79LNyw63u/+dW7b/bWlhs6na9zSR07K8v1b4d0xqFcc0tca+WDTAJ3c0KJT4B5Jr6uYCsxR/aZL1o41KrMiyJGG9jLX99rpaM2ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520018; c=relaxed/simple;
	bh=nbMwyuMJRpw1dldPyAtdPjdNLTAKIerM0vB5Q/KcGR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ua1UgSNTpA0LCyg4msz66SORVXe9MwUt5CDzd+XfnuK9eAzwEaeMYenwRuTkS7UzN5AsrqdhMVNkxR+tI1/zOy4YrDIMQuIm8el0fm5yukePFRj9nzUAt94rljXmVrCkmaJYCoDz2rdHcPnvnc3h6Lgkzx6kUlFsGRjza9L7Ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZVBNEp8Y; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZVBNEp8Y"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202508181226479e488c140f5073e0f8
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q0JcSl1P5wZ9T7INWpc+Dxvh7pI4ylZlv8bySuQkZNY=;
 b=ZVBNEp8YlZVTTr4n/lqEDu2qzf6OyxydYTnWK2RbcblWURfYaKWqA5/vmS0xlmqZtlT+jb
 YAEd/OBKEELrNcSCDOsVt1pxMqivXTBDLCDoBkj6uFLwy8fdDGBJZgvJfnAWSUaSvYEDVLJt
 4ZMzWcMuz7TO0ILo32HfThPVQSqsJAHXhw5BRsetPPCYjcmmtqaDYccs1rls67rEDJSdB2lj
 2yqUrCcZvS5xLAHs7Ty6GbTueQiX63n0Nr8IOVpsWtqkflstBb3GsrfEzqD9zKOnpdMfeWVx
 3K0nuZYu/F8CalM/yGvBpt+x5xGHQRmJr6ac/V8rgM/oyP/72wYwXkSg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:51 +0200
Subject: [PATCH 09/13] drivers/stack/rtcfg: Add missing
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-9-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
index 857237744..5c3cd47df 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
@@ -34,6 +34,7 @@
 #include <rtcfg/rtcfg_proc.h>
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-Time Configuration Distribution Protocol");
 
 static int __init rtcfg_init(void)
 {

-- 
2.39.5

