Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE707F
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:49:39 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AB697D2E51
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:48 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 7154460010
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:41 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4247D740045
	for <xenomai@xenomai.org>; Mon,  1 Aug 2022 13:47:40 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220801134739e3a8d83898e8000f6a
        for <xenomai@xenomai.org>;
        Mon, 01 Aug 2022 15:47:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UKPuIPjBmHGs+qEZK9O7jLtLl2BEZVtStrQLJh7J2T4=;
 b=bO4aqlB6JeUa02r3+MFlSPQtJvqJDZB0+uhuhp1DLeVhafXikrjpize87cJ02kXxcvv5Ho
 0MHNp40PZC61RCnbZfPNs1Sm376XLaFUi37YwuU62DPowVU/wh88YFk23U3L08LrXrKVpeCB
 0X2H7jxBx0FkC25rVOGcemfvTkiwg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [xenomai-images][PATCH 3/4] kconfig: Limit I-pipe kernels to supported versions
Date: Mon,  1 Aug 2022 15:47:36 +0200
Message-Id: <df38f674914d3b2ef778fe152c9191dab099de68.1659361657.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1659361657.git.jan.kiszka@siemens.com>
References: <cover.1659361657.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool2: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-20220801134739e3a8d83898e8000f6a-7aUszw@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=bO4aqlB6;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220801134739e3a8d83898e8000f6a-7aUszw@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-20220801134739e3a8d83898e8000f6a-7aUszw@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

The development head of Xenomai lost I-pipe support. Therefore, limit
those kernels to 3.1 and 3.2 stable branches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index 7940180..af10be1 100644
--- a/Kconfig
+++ b/Kconfig
@@ -107,19 +107,19 @@ config KERNEL_5_10
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
-	depends on !XENOMAI_3_0_LATEST
+	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_5_4
 	bool "Latest 5.4 I-pipe version"
-	depends on !XENOMAI_3_0_LATEST
+	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_19_LATEST
 	bool "Head of 4.19-cip I-pipe branch"
-	depends on !XENOMAI_3_0_LATEST
+	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_19
 	bool "Latest 4.19-cip I-pipe version"
-	depends on !XENOMAI_3_0_LATEST
+	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_4_LATEST
 	bool "Head of 4.4-cip I-pipe branch"
-- 
2.35.3

