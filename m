Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27828CF52
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294601; cv=none; b=qz0l5anmi33lnSzNA6C6pJW5BOn1q4dyFP9UaK8U4NxNra066ly9TSv08hd7DBxE+Wr3FiQEmaZdnMSmVST0HU40I+f+MZ6KvTYaOTyX6f1V685NRhswqF78jgm/a5ZnDU3L5gjeZyZd4D2nL8jxrP7nZmbxswAp6idMZrT6swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294601; c=relaxed/simple;
	bh=xtCZESV0U/aMPj5Pa3crvbjs67bJFmEtwDfu6U/lZr8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QWbWoaZRz8VLzZEJywtjq2Je+rd776Ac/nkpSKwRL12+dKW4BuecjOOHHveOX+iFZVNsE7h8Dv5wkfGXu/vgBQVP+HxM/0+dS5IWxUexp39wXk3o4rDInIRP0Um0SiK7HtwKf+2wWIpUQ8u3qjI+pKGIO3W+kooiPKS4eK8taHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=db2gPN/2; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="db2gPN/2"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250410141631cbdc1a84f1aac63fb5
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=P936/srdghxGm/QOgUicYJIvhPDuhLn1qfEuwtOOpws=;
 b=db2gPN/2WpJ7o26FOgMeDwoLIIwq1OYSXiBMzengpGKH+lRCVFo+9N0XqE7qVm7hfTvjVd
 KIjdB/eV7vjmQoS5oBEoTm9rk3/KkEBa7gfqpthzGhZBbqbUJ7xQpyr9U/cZUD8yVE/pDNlI
 PLhO304L58TndDyeHZlmhYCGAcDacfUL6tIWg1y/Ijm9SWzpI/ep/NVpfLphUYlSKj+5ZGJB
 JdZFvDMlOtRyJOGAakboysE5RrQn5YCAxgr0dMB8RTpnKwbEMCi73usr5ys1bt2avqdjBS/l
 05Iu5LYabYVuW2hadv2LBTa9vSfNYbIVabGi9nhGLKAwnU/Inx1ROAWw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/7] Add stable/v3.3.x branch, version updates, fix for evl kernel selection
Date: Thu, 10 Apr 2025 16:16:23 +0200
Message-ID: <cover.1744294590.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

See patches for details.

Jan

Jan Kiszka (7):
  Add stable 3.3 branch with kernel 6.12 as default
  ci: Add coverage for stable/v3.3.x branch
  libevl: Update to latest release r50
  linux-xenomai-4: Update to latest releases
  linux-xenomai-3: Update to latest releases
  linux-xenomai4: Enable selection of latest releases
  Kconfig: Add 6.12 kernel option for EVL

 .gitlab-ci.yml                                |  8 +++-
 Kconfig                                       | 12 ++++++
 ci/xenomai_3_3_x.yml                          | 23 +++++++++++
 ci/xenomai_3_3_x_compat.yml                   | 18 +++++++++
 conf/distro/include/xenomai-version.inc       | 12 ++++--
 opt-linux-6.1.yml                             |  1 +
 opt-linux-6.12.yml                            |  1 +
 opt-linux-6.6.yml                             |  1 +
 opt-linux-6.12.yml => opt-xenomai-3.3.x.yml   |  7 ++--
 recipes-kernel/linux/linux-xenomai-3_5.10.bb  |  2 +-
 recipes-kernel/linux/linux-xenomai-3_5.15.bb  |  2 +-
 recipes-kernel/linux/linux-xenomai-3_6.1.bb   |  2 +-
 recipes-kernel/linux/linux-xenomai-3_6.12.bb  |  2 +-
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   |  2 +-
 recipes-kernel/linux/linux-xenomai-4_6.12.bb  |  2 +-
 ...i-Take-Debian-multiarch-into-account.patch | 40 -------------------
 .../libevl/{libevl_47.bb => libevl_50.bb}     |  1 -
 .../xenomai/xenomai_stable-3.3.x.bb           |  1 +
 18 files changed, 83 insertions(+), 54 deletions(-)
 create mode 100644 ci/xenomai_3_3_x.yml
 create mode 100644 ci/xenomai_3_3_x_compat.yml
 copy opt-linux-6.12.yml => opt-xenomai-3.3.x.yml (51%)
 delete mode 100644 recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
 rename recipes-xenomai/libevl/{libevl_47.bb => libevl_50.bb} (77%)
 create mode 120000 recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb

-- 
2.43.0

