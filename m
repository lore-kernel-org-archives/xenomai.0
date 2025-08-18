Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0032039C
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520021; cv=none; b=NX6cTrvSJQFFtLZSrWyhp2U87f4Spx5kdRABOkqB3qqR2PMOs6J+QIRt7tbpae4vDO86EHXgRy6jtsMFHSCZiGLR4jinrCNzjzWtQxNgEHDDKKbX7bfkLp2pEQE+SJRZu42HpREPjN2gKYzRjxnFt+RavJs3ppcrdvz8d/e1jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520021; c=relaxed/simple;
	bh=bjUeO2DW2YynXfwrw0nH0wUcDR4E5PZ/UpqJsy8P7l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWK9ihd1f3iwRqrhXMrt2AhLMJ6hcDuGqWZ3DzOGzKG0g50MIeY5N9LgP12Fjc50u3Dayu2uno7UHPAWLeNyUqHNPl0zNMXbnhAm/3M/5S8HJVsMhZEecJiYczFUlKweo2pBIC+e9z9KNun7WCy+xIe1HBXj7GtA7hiFrqt6WYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IetNHTsC; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IetNHTsC"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202508181226476ffe076b08fa1822b0
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wBg0Zv0W4NdEIlta2pBfIRyRrAziKy1mEaMvJWLMko8=;
 b=IetNHTsChTv5ljUiv4e+vQdia4OfSawCp83FmZl964My6M5b7VruWh4qXFyXKAn5aNwlFW
 a7i5IJeMBFxkG4T6lzKrpSE4T/PiSi8DXo1qjmq3+fN4F5Wdxu+XBwzlA++RM7fUGNA9+PkH
 ArXTRiKHHI83KvjLrlVIWegF7FQGsPzwv26bD+HBIvkEvfN33QKX8aAhkDmpckgC3CJyX0+R
 Zdz1/gVvQbr8UgWi6FM7q3uxDklY6vns6BEpZRmHNBHm31Tkw2nPye5n9tkJuOSGtzuAhRxc
 aACOajGOb4qFlYg81LQU7QOPY5UpHIySrPSDwFoTsvXugXrZAhyiTOzg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:53 +0200
Subject: [PATCH 11/13] drivers/can: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-11-c57f195e3f93@siemens.com>
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
 kernel/drivers/can/rtcan_module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index edc977cdb..8fc7a699c 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -38,6 +38,7 @@
 #include "corectl.h"
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RT-Socket-CAN, CAN raw socket interface");
 
 const char rtcan_rtdm_provider_name[] =
     "(C) 2006 RT-Socket-CAN Development Team";

-- 
2.39.5

