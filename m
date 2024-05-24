Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741B538A
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548593; cv=none; b=g4JNvIGTRnw5vLQTY0qO2iFviembt/A47br2DhrJDrlmVFXNP/u4pymypklEZ52mo1hhv/C6jzavloUdefhpslUOphYrM4Uu2PQsy8aqCtLB05cqFNct+yCj138U98V9/mBNSyyKSdTYzcs7EOQWCyFnJgHo2mT/GO87fVh7kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548593; c=relaxed/simple;
	bh=5+Y7BK8mYAyU0pqW/5T2cHtlhp86ROyYXXH0vN/zm+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgjLiOS8bPL4dyXOt8suGlzWM/mts7KyPWHIftO+1cGbdVw5amQ3mC0MtViwRxIPq0BfXu9/fmKvN+J0gmpOmsoJ64RgzLVh5RHaa/HQkAP/kE25HNxHvOJF3GIp9B07ix1a808EOQIZxEI+ROOudaF1DneNYdUwEiwfZEqhPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=Bxkcg5AV; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="Bxkcg5AV"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024052411025710b0b15c60b3761dd0
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 13:02:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mJgBR/4mx5D2qzNY8WsF5MoMX8BsxNp6YSsfiwmqgnk=;
 b=Bxkcg5AVdTDsb1kuvADuXvfnQExujEg0JwRvJZjlBXBtS/Sd1Q0heZlqxJMrVi1zefe4Lo
 +37lcFISWLP4pmY4tagvwE8yEDzv10YIr0dVerkkhBuy+DqrkPEx8/V+fT7xHRl8G81zEhnk
 6kf35zkve93JzjeL5Lyxr1J+xv64k=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 0/3] rpi4: add Xenomai building support for RPi4
Date: Fri, 24 May 2024 13:02:51 +0200
Message-Id: <20240524110254.37483-1-yi.jiang@siemens.com>
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

this is the second version of the series for adding Xenomai building support for RPi4.

Thanks Florian and Jan for your comments on v1.

Changelog v1 -> v2:
- [PATCH v2 2/3]: Remove rpi4.cfg.
- [PATCH v2 3/3]: Rename patch, and reword the patch description.

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
 .../linux/linux-xenomai-3-dovetail.inc        |  1 +
 .../linux/linux-xenomai-3_latest.bb           |  1 +
 wic/rpi4.wks                                  | 17 ++++++++++
 14 files changed, 161 insertions(+), 8 deletions(-)
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

