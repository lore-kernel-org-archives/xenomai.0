Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21131A063
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=SHqYN/HYjjTV43QMx4cU1wAVzDzm4NWZOQMdoUZdyiX9WjY7edLSU0qbvd3f7EjE7tw1CR64eEsfwrGz4P40VkOta+1nvoFLCGaQF4qW0itRb98g3gFOb32DU/B95FMEiVUUND20Nfbkw/vgKIDKqmd+mnh3JShrnzsl9fbHNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=MgZbqubgtLrEnH+3eVGVFM5diXXcHfGX/nGxYu95R4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEtCl+Jae6p1Ad7VrWdC3RYLpdzJJa0g61KWmWmA4dNGJwdXjYP+nh4uKJ0pWTK7HmtCsKmlmArkUpwz70YSHR+unpDY+bvI8n3AJ3YA2+05v1/ZcPtr7ItBQWWduaA4lrNfPvV6rKXI6oVn2whaOeCjh98TgCOrLhk/yofcurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T/q+WTyn; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T/q+WTyn"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025081812264500cbf3562d0c184b3a
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IW8IQTeNfMG4r7xGge3Dtnnvd5eJGAE7zLmgN28mVi4=;
 b=T/q+WTynEr6u2XVn6e5foTd6OCUDgp+0M4UlVuQSccRt5FCsKrRXnoabgxyWgehxOwyG/C
 Sqs/9AMPAL+ocxLuXl7wf4wyF7wfzjV9ZkVZHqKkoqN2aeOwjoiV0PdCAEZ7GEkyLV6s/B87
 nB7Pl0hBN9WnPyQ8PhIDyazXlUaV3Jx/J9AXtjPCpY/TfB0G1A1sePhaQa4mSuT5qhioC4gX
 3U+Wfa5P9ChCj3KgXm3s/I4fmMoDg3qfuUCDSunrSiRMVDWqduvYS4hij6I+JRZ7W58iQRy2
 a9c/mOjGJM1o6rSeOw63V5wfHGVhsy2o5cNx0HdsiEJYHlKidGdB659w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:45 +0200
Subject: [PATCH 03/13] drivers/analogy/national_instruments: Add missing
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-3-c57f195e3f93@siemens.com>
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
 kernel/drivers/analogy/national_instruments/mite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
index 09896a3e2..87f7cabe7 100644
--- a/kernel/drivers/analogy/national_instruments/mite.c
+++ b/kernel/drivers/analogy/national_instruments/mite.c
@@ -806,6 +806,7 @@ static void __exit mite_cleanup(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM driver for the NI Mite PCI interface chip");
 module_init(mite_init);
 module_exit(mite_cleanup);
 

-- 
2.39.5

