Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA493624DB
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931309; cv=none; b=gpgVeThV1zWOs0LXFzb+BV3FUmUcEQ1nrZmZN+j76CrVWAYiUG2Ygf/c88NM0HPBYOZQSMXNyCd5tCGtbji2QdcscezRxIHTAa7r+rEhitAtL853pZghohYJ9i38RiMKaVd6QSIfuk33tKYgQMwtki3+NOfKGTHBHb8mbwiLVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931309; c=relaxed/simple;
	bh=JAfGfbYaXfraFCrYIRtnrdV1B3k73D5o3g6ZPozq3Ao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sJivJybgUmkBeY69DF+HF5UF9786oFF/EJteApiJiPwHupuDgs8BkIMaCaVEQplNr7ORc/BSCKzc6KrzSbcP6OJjoNInCLkAgphXau8xv9nhjOxdK3mcHtrriKpuws2uQl4oSsTYesQ8J61XjvlWPL2vI7DPeFPQiqGtM8eM9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Yg8ro9vo; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Yg8ro9vo"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260828153456d2aad2ff0c00020702
        for <xenomai@lists.linux.dev>;
        Fri, 28 Aug 2026 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=tV4hCfIvqenljx3oBADyrwT45IuxZCziVs8mH3cSSgk=;
 b=Yg8ro9voDULMeq6BEUPaNz6EXI8CZbokPIXH5wjvMG3E29FWhE2JO9ODo4GNvqgUmpKPxv
 ohG07iIoSIirIUqar25k6DxsR6TrsNe28kn2KdthMsEAsBnTPux3bj29u0wRr/SzJr3zPGdn
 jnTT0cKgZkUA6dbbPhm1zPL8uCV56WmiRiMOfA8b99i15f+nMeEI3qfiHUbn+tx5vYU37xrw
 MSeLg979fQghNibbMnADh7JPbjtaabpuvnc/pKL7/DscaILSBg4qUzYG5wZZ/F3i4UcIVRKj
 g0yiDR1c7wzPnxk2bo4ScO2mveoPPL006FIW3qjNe0woheV8adm6Yhrw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/5] Rootless build and smaller fixes
Date: Fri, 28 Aug 2026 17:34:51 +0200
Message-ID: <cover.1787931296.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This primarily switches the Isar build to rootless mode - at least
locally, our CI infrastructure will continue to grant privileges to the
jobs. That will be changed with the next CI runner update later.

Further changes adjust the head of Xenomai 4 kernel branches to the new
next/ schema and silence still failing RISC-V jobs.

Jan

Jan Kiszka (5):
  linux-xenomai-4: Switch to next branches for latest kernel builds
  ci: Allow riscv builds to fail
  Update Isar revision
  Update to kas 5.5
  Switch to rootless builds

 Kconfig                                       |  10 +-
 README.md                                     |   4 +-
 ci/lib/gitlab-ci-base.yml                     |   2 +-
 ci/lib/kernel/head.yml                        |   4 +
 kas-container                                 | 329 ++++++++++--------
 kas.yaml                                      |   4 +-
 .../linux/linux-xenomai-4_latest.bb           |   4 +-
 recipes-xenomai/xenomai/xenomai.inc           |   2 +-
 8 files changed, 206 insertions(+), 153 deletions(-)

-- 
2.47.3

