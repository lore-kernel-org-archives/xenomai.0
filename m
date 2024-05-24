Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBF12CD8C
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563028; cv=none; b=q0ysc4licFuoZlS07gLHgQI/lmllfuEGOdgo3wSuE8cxB2N78jEblATCuHCiK7TehtOd6Ck9rVp5hfjWZjBTPUY1ydcGhVLfgFDaSyuMWj8nYqcpfuYBgifzM+uYWvW+XrN67wia38jAt4gJeW2ed7CWT1WeKWaZn00bkPYVUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563028; c=relaxed/simple;
	bh=AO/tqpGcuDi5zAxEGAGdhUy5sZ87vN7kGoBX81n8c84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjAtlaAhtZU/Btuq6MDA1QAuhd1uqs3A4lORytfXe2HnkbDrjAtRJLs5Dl94EHTAwxF7vqoZcICXXo+EYJkqy9arzYcBfM5MxzsYkMoAakRl4NG5d4+foJqG4LAx0NupWCOOnxAPJ3XOwu27BbCOP4f093NS7AIgerK9GditwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=fklN8pnG; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="fklN8pnG"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240524150337dc5a72c0eb2ba9febd
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 17:03:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gVJtbZa1PJwnbO+SJFNDasM4JIFZXH+3KsXfPGfogqg=;
 b=fklN8pnGE0pJlIc3oXqknh4qPIGA88ZCet8K2wmCkaHlMlvIgTeaQF3+3uweaU3nu+YqD6
 Z4kJpdfv/RC6k8bycCrRt5PS71vOYurqRmso+L/56P7Tb5zZNmjx8WQgse3soHThRtOe1eEL
 //7P64tWnucgqA33rU5tBVIuwed8o=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v3 0/3] rpi4: add Xenomai building support for RPi4
Date: Fri, 24 May 2024 17:03:32 +0200
Message-Id: <20240524150335.23090-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

Hi, all,

this is the third version of the series for adding Xenomai building support for RPi4.

Thanks Florian for your comments on v2.

Changelog:
v2 -> v3:
- [PATCH v2 2/3]: Remove rpi4.cfg.

Best regards,
Yi Jiang


Florian Bezdeka (2):
  rpi-firmware: Add recipe for building version 20230405
  rpi4: Add rpi4 (Raspberry Pi 4) as target platform

Yi Jiang (1):
  rpi4: add building options for rpi4; remove build options of old
    kernel and Xenomai versions in kas menu for rpi4.

 Kconfig                                       | 14 +++++---
 board-rpi4.yml                                | 15 +++++++++
 conf/machine/rpi4.conf                        | 32 +++++++++++++++++++
 .../rpi-firmware/files/debian/aliases.dts     | 18 +++++++++++
 .../rpi-firmware/files/debian/cmdline.txt     |  1 +
 .../rpi-firmware/files/debian/config.txt      | 12 +++++++
 .../files/debian/rpi-firmware.install         |  9 ++++++
 recipes-bsp/rpi-firmware/files/rules          |  7 ++++
 .../rpi-firmware/rpi-firmware_1.20230405.bb   | 30 +++++++++++++++++
 .../customizations/files/primary.network      |  2 +-
 recipes-kernel/linux/files/arm64_defconfig    | 10 ++++--
 wic/rpi4.wks                                  | 17 ++++++++++
 12 files changed, 159 insertions(+), 8 deletions(-)
 create mode 100644 board-rpi4.yml
 create mode 100644 conf/machine/rpi4.conf
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/aliases.dts
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/cmdline.txt
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/config.txt
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install
 create mode 100644 recipes-bsp/rpi-firmware/files/rules
 create mode 100644 recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
 create mode 100644 wic/rpi4.wks

-- 
2.39.2

