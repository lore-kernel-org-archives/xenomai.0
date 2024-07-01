Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A51B809
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817703; cv=none; b=mH9asy8Us/wgChb6qi2tYTHgwe2WXZScPJNyKNJeVX8hCGdq2DVr8Py+nfJ9oZfHKhOOafSiAeWRR129im61dMKHxs8GpttPB6xpHBn7M7OKiS7+l4wQOJi1vLkfi90G9QkltDMa0VeO8EJO81Lz9zd2E+eH/ezU9Gy8CZklHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817703; c=relaxed/simple;
	bh=tz8HHOrqotAHxwVCPraK4b5IY6W0rnG9X2+vGDTIftc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=saEuFBxoot/Nnju7VlHupmVYpvw+UC8j2Q2dBXN501jHyh1R7w53B4LcY0nGZ4gW67zRSAMXfOdXMJaVKXbvrx0uQSorBgsXBaLdc4JcWnzOrH1R7wXSVIAEpLUOKGDRVrHkY0U/rpnCiVpKCfHYeAaqsWYK47GMYhkPDPK1jQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=KaQ4uIEW; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="KaQ4uIEW"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024070107080916991c67b925648b56
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jul 2024 09:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ccc83p2eXoUbDwG5QVPD0baNk36I0Ap+0rFHevZKUDU=;
 b=KaQ4uIEWwzYo13kKYS5VUTvFdoMqRNPnDUHg98n+h06afKpn3vSvAAEP+tjZYMfv5b75cM
 nglG43FSzjYW75Pzn2Sk4Mk9y18YdajxULauNTT2U6JtlVfzExE/lI8FEA1zbHNivJbCLBAO
 sdI8iBPPdDp8pyNLACg4WXVMvxlf4=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 0/4] ci: add LAVA integration support for Xenomai on RPi4
Date: Mon,  1 Jul 2024 09:08:03 +0200
Message-Id: <20240701070807.14465-1-yi.jiang@siemens.com>
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

this patch series integrate RPi4 to the LAVA, which support Xenomai (kernel version 6.6) to be deployed on RPi4 remotely.

Changelog:
v1 -> v2:
- change the order of [PATCH 3/4] and [PATCH 4/4]
- [PATCH v2 1/4]: add a new commit message to clarify that U-boot cannot take use of the local DTB file on the board, therefore we must provide the DTB for LAVA.
- [PATCH v2 4/4]: remove rpi4 setup for kernel 5.10, 5,15, 6.1; remove hikey setup for kernel 6.6.

Best regards,
Yi Jiang

Yi Jiang (4):
  ci: specify the dtb file for rpi4 in machine conf
  ci: add gitlab-ci-base configurations for rpi4
  ci: add test job configurations for rpi4
  ci: use rpi4 instead of hikey for kernel 6.6 deployment

 ci/gitlab-ci-base.yml       | 14 +++++++-
 ci/kernel_6_6.yml           | 10 +++---
 conf/machine/rpi4.conf      |  2 ++
 tests/jobs/xenomai-rpi4.yml | 72 +++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100644 tests/jobs/xenomai-rpi4.yml

-- 
2.39.2

