Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EB31AF14
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=q5DpbCY3aXaLDT3Ul3c0VeJXY8pHuIKK1OilmEGUiXM2MjZFUmOk9lAMxvJzI/R9WF3FLi2oDzmEzLH59cngVIXyVLUGap82nm7Vcy6vqfb0rwCqeCRk7yStRVh6mHKAGQY+EKrxRYCjo31Ijtr4Z0YJxwU493hn1mo4NQmBBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=JRIC6LmIFahbWereatr9wEHUUvB+4R9Rr+b82pOLQf4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RtlxHgCB0dyOq1x+XoYOmoJBzC38MgGZ+9NtbMYm93wK0yeKgklKTNWWltZm1o4Iqi1dTNq77WpASRE+MuB0J0F/lbOurx8xlE6lqb9lCxt4QAKOVmckMqxHx4hX5Xir9DZsOfQ7ULiqac9ZTVCTNwCWMuJB+e9A2dbdHDn6iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dkAIdFth; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dkAIdFth"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026022009084593aae4b03400020760
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CzNpj9ZkZPSVp97qqenkbi3dOH+gtH2ryIEikgYXUhU=;
 b=dkAIdFthKPGN5kr2t8fa5aKgDMhavX5Lv9PnuAuNWqDtwn8HbgE3fYojqSXa76TiE0F51T
 HZsTuNWlnmy/g9G2ErbrG49DB1/UGUwAc/MtkuPyb/CXTZkstPouhw5vLzTqyE3pVZeRFkIT
 w4a839fTg1gmj6hq2LFWrC7EY+r9P5FbgEJ49nU4GcAzkR29XbzZMBuRa+/5uQEjCFsqTIej
 jKcNdY1viJ4SjwCf7VjXgcrOM8Wdguwkj6jItpZXXw4Wyf55ET8C5IA7eI7wai+jVZouuddK
 hPEKPDDSgKZprjzt3vkDg3tEie1yVTPxNs5UpRr9d6QSQm7mlaD3kNFA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
Date: Fri, 20 Feb 2026 10:08:43 +0100
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJskmGkC/x2NQQqDMBQFryJ/7QdNraZeRVzE+K0PbJQkpIJ49
 4YuB4aZi4J4SKC+uMhLQsDuMtRlQXY17i2MOTOpSrWVql/8xcHLtvOCkyM+0jb8UBMiOxORhLU
 8Zz11trNGU64cXrL6Pwzjff8AZ4iqLXEAAAA=
X-Change-ID: 20260219-wip-flo-fix-time64-32bit-native-8e5d8b7c7ca8
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

The current time64_t / y2038 support switched libcobalt to time64_t
only, removing the interfaces for the native time_t type.

With that series applied both worlds can live together in one libcobalt
build which should hopefully increase the backward compatibility a bit.

All time64_t services have been moved into a separate compile unit that
can be compiled twice now, if necessary. Unaffected environments like
x86_64 won't do that. It's not necessary as the native type is already
64 bit.

The most tricky part where the __RT(), __STD() and __WRAP() macros.
That has been solved by redirects on linker level.

To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (20):
      lib/cobalt: Introduce cond.h
      lib/cobalt: Introduce mutex.h
      lib/cobalt: Introduce mq.h
      lib/cobalt: Introduce rtdm.h
      lib/cobalt: Introduce wrappers_time64.c
      lib/cobalt: clock: Move all time64 related services to wrappers_time64.c
      lib/cobalt: cond: Move all time64 related services to wrappers_time64.c
      lib/cobalt: mq: Move all time64 related services to wrappers_time64.c
      lib/cobalt: mutex: Move all time64 related services to wrappers_time64.c
      lib/cobalt: mutex: Provide time64 variant of pthread_timedmutex_lock_interruptible_np
      lib/cobalt: rtdm: Move all time64 related services to wrappers_time64.c
      lib/cobalt: select: Move select services into wrappers_time64.c
      lib/cobalt: semaphore: Move time64 related services to wrappers_time64.c
      lib/cobalt: signal: Move time64 related services to wrappers_time64.c
      lib/cobalt: timer: Move all time64 related services to wrappers_time64.c
      lib/cobalt: timerfd: Move time64 related services to wrappers_time64.c
      lib/cobalt: Move XN_USE_TIME64_SYSCALL to wrappers_time64.c
      lib/cobalt: Finally build the native time_t interfaces on top
      lib/cobalt: thread: Cleanup and reorder includes
      scripts/xeno-config: Allow disabling the y2038 / time64_t support

 include/cobalt/pthread.h      |   16 +-
 include/cobalt/wrappers.h     |   13 +-
 lib/cobalt/Makefile.am        |   27 +-
 lib/cobalt/clock.c            |  309 +-----------
 lib/cobalt/cond.c             |  154 +-----
 lib/cobalt/cond.h             |   78 +++
 lib/cobalt/internal.h         |    5 -
 lib/cobalt/mq.c               |  151 +-----
 lib/cobalt/mq.h               |   34 ++
 lib/cobalt/mutex.c            |  211 +-------
 lib/cobalt/mutex.h            |   90 ++++
 lib/cobalt/rtdm.c             |  105 +---
 lib/cobalt/rtdm.h             |   32 ++
 lib/cobalt/select.c           |  108 ----
 lib/cobalt/semaphore.c        |   67 +--
 lib/cobalt/signal.c           |   26 +-
 lib/cobalt/thread.c           |    8 +-
 lib/cobalt/timer.c            |  121 +----
 lib/cobalt/timerfd.c          |   39 --
 lib/cobalt/wrappers_time64.c  | 1089 +++++++++++++++++++++++++++++++++++++++++
 scripts/xeno-config-cobalt.in |    5 +
 21 files changed, 1407 insertions(+), 1281 deletions(-)
---
base-commit: 363115d15682076ea0766a55c3c5b1eed87e1225
change-id: 20260219-wip-flo-fix-time64-32bit-native-8e5d8b7c7ca8

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

