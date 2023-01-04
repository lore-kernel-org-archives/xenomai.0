Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF0AD41
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 15:21:39 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230104152136b8cc82dd1fd893d689
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 16:21:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pgjgcJY+sYdPG88pLzF1jXx3fd4EQKH16yTnuc8bYLc=;
 b=OerYArG4TQzBa2AEDm+ElgSh/5DnoqUfpzIxNEJ+m7wzifbtbtbZFTKmI2CWxtSBr7scht
 fBoSVR/2mHeEhzqq8lLEkDt0wJH5Is86+DZlEt5jW8tjHQlG3iNr27ioSAi/+SrH4MHROzjL
 HeEZmqxxlWonBRHoXUYrEnsmf4VPQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/3] Version updates, start-qemu fix
Date: Wed,  4 Jan 2023 16:21:32 +0100
Message-Id: <cover.1672845695.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Just housekeeping

Jan

Jan Kiszka (3):
  linux-xenomai: Refresh releases and simplify their maintenance
  xenomai: Update to latest releases
  start-qemu: Start with read-writable rootfs

 conf/distro/include/xenomai-version.inc             |  8 ++++----
 recipes-kernel/linux/linux-xenomai_4.19.bb          | 13 ++++++-------
 recipes-kernel/linux/linux-xenomai_4.4.bb           | 10 +++++-----
 recipes-kernel/linux/linux-xenomai_5.10.bb          |  7 ++++---
 recipes-kernel/linux/linux-xenomai_5.15.bb          |  7 ++++---
 recipes-kernel/linux/linux-xenomai_5.4.bb           | 13 ++++++-------
 .../{xenomai_3.0.12.bb => xenomai_3.0.13.bb}        |  0
 .../xenomai/{xenomai_3.1.2.bb => xenomai_3.1.3.bb}  |  0
 .../xenomai/{xenomai_3.2.1.bb => xenomai_3.2.2.bb}  |  0
 start-qemu.sh                                       |  6 +++---
 10 files changed, 32 insertions(+), 32 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.12.bb => xenomai_3.0.13.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.2.bb => xenomai_3.1.3.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.1.bb => xenomai_3.2.2.bb} (100%)

-- 
2.35.3

