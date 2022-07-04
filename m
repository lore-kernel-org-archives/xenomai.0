Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE146A3
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D8B6EC9998
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 57C6140012
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6A633D80091
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:36 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022070413083605f41d46dc2459d13c
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Sm1DqmNp+Wio6bSOBqYLO8/HoBVMNjAALPCIBfIO4Iw=;
 b=boXiQMGhVu8On1eKk9I4Z9B8DZoPrt5zORVIqbcHO4y0x4v19i+FtfwOilN7pYAXs4NWlX
 9/VswSrOzdYWMIrZw+Ml5N9OOMElEIQA0lZW/N2JRV9WHePiqqRF3kYFsyPC0E1SuGt8Mgrm
 iEQnQjsbrapBx9MXgHl5GqQfnNs4c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 03/15] drivers/switchtest: Remove unused local vars
Date: Mon,  4 Jul 2022 15:08:23 +0200
Message-Id: <4ec668f0c61c7740d8edac5b60ea908d0a32f0d6.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-2022070413083605f41d46dc2459d13c-q9B0Vb@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=boXiQMGh;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2022070413083605f41d46dc2459d13c-q9B0Vb@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-2022070413083605f41d46dc2459d13c-q9B0Vb@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Was forgotten in a50b60de8520.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/testing/switchtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 9072717d52..b6d0242de7 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -407,7 +407,7 @@ struct taskarg {
 static void rtswitch_ktask(void *cookie)
 {
 	struct taskarg *arg = (struct taskarg *) cookie;
-	unsigned int fp_val, expected, to, i = 0;
+	unsigned int to, i = 0;
 	struct rtswitch_context *ctx = arg->ctx;
 	struct rtswitch_task *task = arg->task;
 
-- 
2.35.3

