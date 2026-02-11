Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5014A8E
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815459; cv=none; b=hVQ4ezqykPLCgmNErOjyLHWxA5991NCMKOCXwPGOEO9bDInv5qoXFt35IoVJiG7SqD0PILQLL6hZd/HwfPrjFg0ncnnjw35I60GwyscTqL89FUwGb9Gc3rcK5xi/FQBK9HI9bb/6euBiG3Igp1DMi34eHqrH8feOhdK1z2FcIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815459; c=relaxed/simple;
	bh=b1UkkfTtib535xW30VFSChgSY4ih4aMyacjrkCHYFzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAKPkSDhy2QXaqYF++sxOS5iBwKOEngeDi2LzJWm+Eh8HUMPXSDOvOVMoWIuCmwwUJ+B9ZwgJYqH3G4XPySa5BLwYU5etjYWnakh1xc5JOpe5HV7xUy/gtsfiunOULBdmD1QlyArL+jiJOkqoCMu0xngygKYsL/manO0wDfHJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=fS0NSolL; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="fS0NSolL"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260211131051e21223493100020795
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:10:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=GPrEj/w//apypcFKasX4WbXN1zgx7BSLmzmZeaoGY0E=;
 b=fS0NSolLCmxv5Rl6AC/NslVUdbA6I1bRe0AnwkyJk1V/nsiFRs8FYlE/cUbmVGZtZ3Np8S
 fq3ZFbLF3PfeozOd0vqMlqsoKonRdeONelgeeqXDkzvBS1J6+rbjGaGaua9Hs9W25pK2kjE8
 kW6Z+84U3LJUembQIKjXaVgr4FNaq1ZcKuyXOdbqzV7GpqI6a+Z+Gaa37uUK4aCtpo7VeoCO
 RUOrejl58+szWqGqQJSZLYghMgFjNBS5mL/GMFL5hxyBD1laJVqjnbn6pTVVAF08ent26YP8
 uml8g8pyXImfV7mttwk7bY0ccOmV3YRNzEH+xbPEdlS9xGiQDSpIUXHg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 0/5] Trigger xenomai-images CI for linux-evl and libevl
Date: Wed, 11 Feb 2026 14:10:37 +0100
Message-ID: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

This brings support for triggering the xenomai-images CI for pushes to:
- linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl
  next
- libevl branch: next, in combination with linux-evl head

Changes since v1:
- Do not consider pushes in linux-dovetail or linux-evl to retired or
  yet unsupported branches that match the regex rule of the head
  branch. Pushes to such branches will cause the downstream pipeline in
  xenomai-images to fail with the error "Jobs config should contain at
  least one visible job".
- Restructure the ci folder for better overview

Best regards,
Clara Kowalsky

Clara Kowalsky (5):
  ci: Move third-party config files into separate folder
  ci: Move reused files into lib folder
  ci: Add build job for pipeline triggered by libevl or linux-evl
  ci: Add CI for libevl
  ci: Add CI for linux-evl

 .gitlab-ci.yml                                | 10 ++-
 README.md                                     | 31 +++++++--
 ci/{compat_jobs.yml => lib/compat/jobs.yml}   |  0
 .../compat/xenomai_3_2_x.yml}                 |  2 +-
 .../compat/xenomai_3_3_x.yml}                 |  2 +-
 .../compat/xenomai_3_next.yml}                |  2 +-
 .../dovetail/xenomai_3_3_x.yml}               |  0
 .../dovetail/xenomai_3_next.yml}              |  0
 ci/{ => lib}/gitlab-ci-base.yml               |  0
 ci/{kernel_4_19.yml => lib/kernel/4_19.yml}   |  0
 ci/{kernel_5_10.yml => lib/kernel/5_10.yml}   |  0
 ci/{kernel_5_15.yml => lib/kernel/5_15.yml}   |  0
 ci/{kernel_6_1.yml => lib/kernel/6_1.yml}     |  0
 ci/{kernel_6_12.yml => lib/kernel/6_12.yml}   |  2 +-
 .../kernel/6_12_physical.yml}                 |  0
 ci/{kernel_head.yml => lib/kernel/head.yml}   |  0
 ci/{ci-dovetail.yml => trigger/dovetail.yml}  |  0
 ci/trigger/evl.yml                            | 63 +++++++++++++++++++
 ci/trigger/libevl.yml                         | 28 +++++++++
 ci/xenomai_3_1_x.yml                          |  4 +-
 ci/xenomai_3_2_x.yml                          | 12 ++--
 ci/xenomai_3_3_x.yml                          | 12 ++--
 ...l_xenomai_3.yml => xenomai_3_dovetail.yml} | 16 ++---
 ci/xenomai_3_next.yml                         | 10 +--
 ci/xenomai_3_next_long_term.yml               |  4 +-
 ci/xenomai_4_evl.yml                          | 29 +++++++++
 ci/xenomai_4_next.yml                         |  6 +-
 27 files changed, 191 insertions(+), 42 deletions(-)
 rename ci/{compat_jobs.yml => lib/compat/jobs.yml} (100%)
 rename ci/{xenomai_3_2_x_compat.yml => lib/compat/xenomai_3_2_x.yml} (90%)
 rename ci/{xenomai_3_3_x_compat.yml => lib/compat/xenomai_3_3_x.yml} (89%)
 rename ci/{xenomai_3_next_compat.yml => lib/compat/xenomai_3_next.yml} (90%)
 rename ci/{dovetail_xenomai_3_3_x.yml => lib/dovetail/xenomai_3_3_x.yml} (100%)
 rename ci/{dovetail_xenomai_3_next.yml => lib/dovetail/xenomai_3_next.yml} (100%)
 rename ci/{ => lib}/gitlab-ci-base.yml (100%)
 rename ci/{kernel_4_19.yml => lib/kernel/4_19.yml} (100%)
 rename ci/{kernel_5_10.yml => lib/kernel/5_10.yml} (100%)
 rename ci/{kernel_5_15.yml => lib/kernel/5_15.yml} (100%)
 rename ci/{kernel_6_1.yml => lib/kernel/6_1.yml} (100%)
 rename ci/{kernel_6_12.yml => lib/kernel/6_12.yml} (96%)
 rename ci/{kernel_6_12_physical.yml => lib/kernel/6_12_physical.yml} (100%)
 rename ci/{kernel_head.yml => lib/kernel/head.yml} (100%)
 rename ci/{ci-dovetail.yml => trigger/dovetail.yml} (100%)
 create mode 100644 ci/trigger/evl.yml
 create mode 100644 ci/trigger/libevl.yml
 rename ci/{dovetail_xenomai_3.yml => xenomai_3_dovetail.yml} (67%)
 create mode 100644 ci/xenomai_4_evl.yml

-- 
2.52.0

