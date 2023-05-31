Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554712B8C
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:11:35 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023053111112646ba53ec0e6ac83dd6
        for <xenomai@lists.linux.dev>;
        Wed, 31 May 2023 13:11:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=KFMKoWu4ZVQ/goX6331ZbDyawyultZQg3rWikq1vO+M=;
 b=pbSw+HV3S9Nti00mG36vIcKPriuk5xDsQZksfeSij9+sZCikav4WXiQYfr7sVBEOLD66x9
 0FVojhh/oY//dV6E6yuhBmthZ3Of3Zd7128d2J3Nw4ppL/qIXMYa1kioZB0Js8KovvXr6Q5W
 r11HvL6Pw2d+R9BScUldqqZBfzlxo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH [REPOST] 0/4] Fix build issues against kernel 6.4, modernize some API usage
Date: Wed, 31 May 2023 13:11:22 +0200
Message-Id: <cover.1685531485.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

[repost, first attempt triggered some spam filters for unknown reasons]

The goal of this series is to allow building against upcoming 6.4. Along
that, it gets rid of legacy Linux semaphore usage and replaces
gpio_export with gpiod_export. See patches for more details.

Jan

Jan Kiszka (4):
  kernel: Account for signature change of class_create in 6.4
  cobalt/registry: Convert export_mutex to real mutex
  drivers/can: Convert rtcan_devices_nrt_lock to real mutex
  drivers/gpio: Ensure compatibility with kernel 6.4

 kernel/cobalt/pipe.c                    |  4 ++++
 kernel/cobalt/registry.c                |  7 ++++---
 kernel/cobalt/rtdm/device.c             |  4 ++++
 kernel/drivers/can/rtcan_dev.c          | 18 +++++++++---------
 kernel/drivers/can/rtcan_dev.h          |  4 ++--
 kernel/drivers/can/rtcan_module.c       | 12 ++++++------
 kernel/drivers/gpio/gpio-core.c         |  7 ++++++-
 kernel/drivers/net/stack/rtnet_module.c |  4 ++++
 kernel/drivers/spi/spi-master.c         |  7 +++++--
 9 files changed, 44 insertions(+), 23 deletions(-)

-- 
2.35.3

