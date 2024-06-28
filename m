Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D961E4A6
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577896; cv=none; b=f9DdDsemNFxzxnXS4u0kBTl2/Ls2ywVRQYBZsday4fHmDVxHfCHxeHS7xkxkLE45+hG5PJ7vYvYpz0XsRQ0cCzxuK7YQ6VXpbIX2YwURm36cQ85LhGmWasqM35oa8YBp2xWZe6ll4L5F4JxEPxe9n+pAoMZuHTlwfY5rsHs+XqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577896; c=relaxed/simple;
	bh=stKcbat7n7byRvXLDGy1KbqG+rrffU5CChw2wTbFqe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cMDpMHk8YNPTa6DsQsfE6G6qdBrdZpj/MVPvutjpx5JcqI8JtWB/0ZzzzXq4o/8SuH5Pu0AJmlKkiOIfug1l7lE9comDBEoT/NA8xKvtB2RzTzTb48jS7S5YF+OFU4ZKh7S6ISgTKAFokfs8364g6B1mPf7ZKSBrTzjoUCR+9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=j5nhT3wt; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="j5nhT3wt"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240628122119861cdb0ad1752ba0d8
        for <xenomai@lists.linux.dev>;
        Fri, 28 Jun 2024 14:21:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=y6OTle6ZRSNh5Oodp2oiLS5JfZmRcMDKipPyQD2gZbU=;
 b=j5nhT3wtsQfvf68TL16z1LJJD+FiNxqy/DiJIYT5Ybyt5SLqFn8gF/jbDaK5th6k2CmFbW
 QUJYB+jbqd/Uy16O+VgMdhR/4P3PZ/OQsc2mIcbG7p7M7XpC6QeduTHuW0MxGEa3SvVld4jy
 VfvrHjGMMhS4hplyuNaD0ZunUOz/8=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 0/4] ci: add LAVA integration support for Xenomai on RPi4
Date: Fri, 28 Jun 2024 14:21:13 +0200
Message-Id: <20240628122117.19059-1-yi.jiang@siemens.com>
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

this patch series integrate RPi4 to the LAVA, so that Xenomai can be deployed on RPi4 remotely.

Best regards,
Yi Jiang


Yi Jiang (4):
  ci: specify the dtb file for rpi4 in machine conf
  ci: add gitlab-ci-base configurations for rpi4
  ci: add kernel support for rpi4
  ci: add test job configurations for rpi4

 ci/gitlab-ci-base.yml       | 14 +++++++-
 ci/kernel_5_10.yml          | 15 +++++++-
 ci/kernel_5_15.yml          | 15 +++++++-
 ci/kernel_6_1.yml           | 15 +++++++-
 ci/kernel_6_6.yml           | 13 +++++++
 conf/machine/rpi4.conf      |  2 ++
 tests/jobs/xenomai-rpi4.yml | 72 +++++++++++++++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100644 tests/jobs/xenomai-rpi4.yml

-- 
2.39.2

