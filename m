Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468731AF24
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520017; cv=none; b=gY6CgwR25FusebQrt9Xh8AOtV2s1nEFPcu/IbFxoEP7rIerrT6ExkoXilJEqyv2bb/8eObUoJsriWi/j9IMKiXmmZ8+aCBgp/lfBpKddq8O+7BJm9y1skuqeo0uVCKGRZkpv9GlXvTZ/95xfzmfxKWCb4zg0gSrMwbIsWVEFasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520017; c=relaxed/simple;
	bh=BJ/OzA4Lag5LWJl7bJRa0ne07HX7DzSjgzljeryyaVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeCzj5SbM2/7M/mb9KLILeboCZ4lH9Ju4C7HzKvhlzSr+5r+JipgPD7ClBakm3nrV6ScO+xbTqMdK9paMLuJJJq6op0AnsIZcpkaAH6K6Zrv0ulDbxG1r26vorNDaU204JvAbISePMSvOleoZ2g9XQyG7P6u95MufFcvZeHFxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=R1iT2HvW; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="R1iT2HvW"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250818122646bf7e0f8789c8f0b5ef
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Rvwwwrhqr5ccB0+MKPEjdE0UZhCmvDODVbGXrLxF8Q8=;
 b=R1iT2HvWIqGluRF2NoqTh26EhjCkV1qtv+bp75vKtGu8fP+8zNiZx7J2qjX9IKmQx9Tcyx
 4Br7281ylTOGVIkwUVlsSpmw3OVTJs9wMeZzVzrHy4nHYnuASdEkSaQhsvV8GfZjHLx0UQkZ
 bkJLKluGuDgo2xa7VYElZ9M/kKAwVLT7dlSRECXQRv/kKKxSsq+VYY8XINYZB0Mk18RFJAnw
 CXruBnO36BOnALiCsLl9CZNDxcq1pehALl2VyDZqf2mPwoPJbhCdN8x41i2Srf2pSBX5o0cx
 LYgVdvoUssxAab+JMnrXbQR4GTrZUxnYZoN1C+mRDDHat/1aNA1BtuqA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:50 +0200
Subject: [PATCH 08/13] drivers/stack/packet: Add missing
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-8-c57f195e3f93@siemens.com>
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
 kernel/drivers/net/stack/packet/af_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index 6013ff9e7..0c3908e64 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -31,6 +31,7 @@
 #include <stack_mgr.h>
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-time capable AF_PACKET implementation");
 
 /***
  *  rt_packet_rcv

-- 
2.39.5

