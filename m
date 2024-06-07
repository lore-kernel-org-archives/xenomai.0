Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939F195999
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767963; cv=none; b=ZcxiQoVbffOok8UACm/h8HcQhoTYZhqyxkRWbjH7OrHJPE46jQTVq3+981jdxALp+kIS8DkGCaJ5rkWw2yFk/WKY2XsGAv2q2PaTqFZjnHaa8JIUxKRnFWCW1paaASXWqgZYaifyw1QT8cx8/KuA3x0oKOuY969fY4edTpsq2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767963; c=relaxed/simple;
	bh=rjn/8d/u68+JlXbm32LCoFgCfU/dkaIlANkFu6rQM8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smadftKc9rrBzlYQ5wNF7tLuV3G0tiV56tQOpAmBgGzo+lOOahkkYaDZRC6/tBZS8GLStEt/+orKPCdbaA4k3EN4oJwNHEAdS+69tRcQBGa5dTKouniChmOUBD6oE9aC7ZP5/NiAgPHvmsSxMkISFOGeAvqa97QDTh+4uoz5huw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=O7P4WurA; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="O7P4WurA"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024060713455611515fe74831e96a2f
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 15:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6wfOWfV/5wYxtkp2Q/GxQuqam3fHgI38wVlzZJzkFac=;
 b=O7P4WurAIECpYciCvbsKpbs+8kDxauOxZwzKO6Hc7WBYf8nCJb4Ga18AmLDWGGU71SbbmH
 I8jEn0WfwLmsTvuiHifAZ43jfVURPPLvBt/7UJdqKbRTQDEwhRSC2N+osCLyooYBoDloYwg5
 UNUcbALPK5fXrGeRZPBe4VnIoWgl4=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 0/3] I/O benchmark fixes
Date: Fri,  7 Jun 2024 15:45:48 +0200
Message-Id: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi all,

this is the second version of the series for fixing the GPIO benchmark.

Thank you, Jan, for your comments on v1.
Changes in v2 compared to v1:
- P1/3: Let it build in the gitlab-ci
- P2/3: Fix style
- P3/3: Fix style

Best regards,
Clara

Clara Kowalsky (3):
  drivers/gpio: Add driver for BCM2711-based SoCs
  testsuite/gpiobench: Fix output pin in react mode
  testsuite/gpiobench: Synchronize index of loopback mode and react mode

 .gitlab-ci.yml                     |  1 +
 kernel/drivers/gpio/Kconfig        |  8 ++++++++
 kernel/drivers/gpio/Makefile       |  2 ++
 kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
 testsuite/gpiobench/gpiobench.c    | 16 +++++++++++-----
 5 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c

-- 
2.39.2

