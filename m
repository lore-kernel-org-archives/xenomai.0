Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8517CA4
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:37 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 2E7C61C0006
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:30 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5B00CD80712
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:28 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202211222226278b5cbd22179ecb36df
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=14+3ARN/5SfVSJJnrrP6Q/0KyouJLYXtSJOzECIUlzs=;
 b=Bg9GwhI+FsUt/LC8o/3LsUc4f4F6NjLNPou0PG53RdATdv2EURQUiDYmx2wst7LO0U8Rp8
 09ugAtbephZgUDIrSrehEvJS5nG1Yctb+3bX9lyDiw4pxKQ0XdXevMaaCBVsYSrGqgaonMUx
 uXvEScmBLbfAwPiJ4gTV3C2VXzjj0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH 0/8] Support for kernel 6.1 / CI updates
Date: Tue, 22 Nov 2022 23:26:18 +0100
Message-Id: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) client-ip=185.136.64.226; envelope-from=fm-294854-202211222226278b5cbd22179ecb36df-e3yKOO@rts-flowmailer.siemens.com; helo=mta-64-226.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=Bg9GwhI+;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202211222226278b5cbd22179ecb36df-e3yKOO@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-294854-202211222226278b5cbd22179ecb36df-e3yKOO@rts-flowmailer.siemens.com

Make sure that we can build against kernels up to (upcoming) 6.1.
Furthermore, update CI accordingly and also do some chore work for it.
See patches for details.

Jan


CC: Gunter Grau <gunter.grau@philips.com>

Jan Kiszka (8):
  drivers/testing/heapcheck: Replace prandom_u32 with custom
    implementation
  drivers/net/pcnet32: Adjust for kernel 6.1
  drivers/net/freescale: Drop NAPI traces
  drivers/net/freescale: Convert direct dev_addr access
  ci: Update latest kernels to v6.x
  ci: Fold DOVETAIL_URL into PIPELINE_KERNEL
  ci: Exclude master branch from builds
  ci: Mark build jobs interruptible

 .gitlab-ci.yml                                | 29 +++++++------------
 kernel/drivers/net/drivers/freescale/fec.h    |  1 -
 .../drivers/net/drivers/freescale/fec_main.c  | 24 +--------------
 kernel/drivers/net/drivers/pcnet32.c          |  5 ++--
 kernel/drivers/testing/heapcheck.c            | 14 +++++++--
 5 files changed, 27 insertions(+), 46 deletions(-)

-- 
2.35.3

