Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0541C3BEA
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772563; cv=none; b=gDTBkVB4GhXzelDbHydvQO2hTwNsLEm+6MmJXZlnwr7J470NA2uLYe3M5APVH1jLotGDCcWQm1okKhAi9B8qGQLEQP3wr4V6aoCqC4oK7oqZkujNWSwsNWH9ktNzdF7jluViLEEWOWHHPWjpPFtfWegzzmnodCQ2a1Rk95uk0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772563; c=relaxed/simple;
	bh=MNJBgk+zlSmbRhrGCNxdp+qPnTM+1hW7/1KGEcN2ATs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XyE15GT0sGIsfVy1mFOUhXxA9JbU2lXIoDiqNgneZX6UCP/zCVWVDQ+Edb8ofarQIhWSkoYbm66cPufk01R1luxrUc/0ghjEirMcU+6P52g4V4fsKk/yYWArlPWDAX0Mjn95yeFPE040ejk0o4G5raF29HiHahXDf6rC7JCaFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=NPmQ8rwS; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="NPmQ8rwS"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250113124911268a18226462b5e0bc
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GgL9OkOa3dXHty2VoDUGLgEZORBo3qK3pcOCYo3sELw=;
 b=NPmQ8rwSPsaeoZ8zHgH4hEr9AatJla4qijn/8niujC00Bd6ucV+uSjutstOtrePlSy27KT
 TF5+7NRjq3E2e9HujfI38e6ia7Y3cBWTGiRPmwP2FsTRsrBofe9y6NjCAAwCh97z/Obj+yUm
 q2L/+LRdBM7PVrcQjGpYL+bKHD23QWo1P/SItepqJ89G3ncwnR2B5m9oTEGhCBCguaN6JPhd
 HLn9J+5zA9gm5UUegE7qSmNTV4DeNySZmRAf9gc5EkG7/rrA8hRIls4tilatSfuay/W2CrJ6
 WmjtW5p9bpWaE96b3x5idI1CJLomAnI3IWzmmR4I1PL5Nmlu7gQa6GAw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/6] Update kernel versions, kas and isar
Date: Mon, 13 Jan 2025 13:49:02 +0100
Message-ID: <cover.1736772548.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Most important change is probably the introduction of kernel 6.12 for
both Xenomai streams.

Jan

Jan Kiszka (6):
  Update kas to 4.6
  Update isar revision
  linux-xenomai: Switch to v6.1.y-cip branches
  linux-xenomai: Update to latest releases
  Add kernel 6.12 bits
  ci: Replace kernel 6.6 with 6.12

 Kconfig                                       | 10 ++++
 ci/compat_jobs.yml                            | 14 ++---
 ci/gitlab-ci-base.yml                         |  4 +-
 ci/kernel_6_12.yml                            | 52 +++++++++++++++++++
 ci/kernel_6_12_physical.yml                   | 52 +++++++++++++++++++
 ci/kernel_6_6.yml                             | 52 -------------------
 ci/kernel_6_6_physical.yml                    | 52 -------------------
 ci/xenomai_3_next.yml                         |  6 +--
 ci/xenomai_3_next_long_term.yml               |  4 +-
 ci/xenomai_4_next.yml                         |  6 +--
 kas-container                                 | 26 +++++-----
 kas.yml                                       |  4 +-
 opt-linux-6.12.yml                            | 17 ++++++
 opt-linux-latest-6.12.yml                     | 19 +++++++
 recipes-kernel/linux/linux-xenomai-3_4.19.bb  |  6 +--
 recipes-kernel/linux/linux-xenomai-3_4.4.bb   |  6 +--
 recipes-kernel/linux/linux-xenomai-3_5.10.bb  |  4 +-
 recipes-kernel/linux/linux-xenomai-3_5.15.bb  |  4 +-
 recipes-kernel/linux/linux-xenomai-3_5.4.bb   |  6 +--
 recipes-kernel/linux/linux-xenomai-3_6.1.bb   |  4 +-
 ...nomai-3_6.6.bb => linux-xenomai-3_6.12.bb} |  4 +-
 recipes-kernel/linux/linux-xenomai-3_6.6.bb   |  4 +-
 .../linux/linux-xenomai-3_latest.bb           | 11 ++--
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   |  4 +-
 ...nomai-4_6.6.bb => linux-xenomai-4_6.12.bb} |  6 +--
 recipes-kernel/linux/linux-xenomai-4_6.6.bb   |  4 +-
 .../linux/linux-xenomai-4_latest.bb           |  5 +-
 27 files changed, 219 insertions(+), 167 deletions(-)
 create mode 100644 ci/kernel_6_12.yml
 create mode 100644 ci/kernel_6_12_physical.yml
 delete mode 100644 ci/kernel_6_6.yml
 delete mode 100644 ci/kernel_6_6_physical.yml
 create mode 100644 opt-linux-6.12.yml
 create mode 100644 opt-linux-latest-6.12.yml
 copy recipes-kernel/linux/{linux-xenomai-3_6.6.bb => linux-xenomai-3_6.12.bb} (73%)
 copy recipes-kernel/linux/{linux-xenomai-4_6.6.bb => linux-xenomai-4_6.12.bb} (54%)

-- 
2.43.0

