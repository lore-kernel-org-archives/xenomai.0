Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D4C8E5
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 15:00:30 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023051514502089dfd3e424aab86332
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6J42IVWrK5ODuQ3dqDJH1kOnM3yPTx7BlMGyLVemaDQ=;
 b=ekrl7Gwhn4SkrCTj3z/NCrjjX1/QBSO7nK3wBzdaRCi1pa3IhZyuxUvTuBXV6X5H6qrvZ0
 LQJBvtLKo/ck85i7jhkr/tpXSbpRQVi1moCExuNaKA1kyGs4B6QrP02L9Pv1L6Nf8WC2r+4c
 3q9frERpNJBmTDqobuDcZHK8RE/PM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 00/14] y2038: Part two - timer and timerfd support
Date: Mon, 15 May 2023 16:50:00 +0200
Message-Id: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhGYmQC/4WNQQ6CMBAAv0J6dk1bwDae/IfhsNBFNoGWtIgSw
 t+tfsDjTDKZXSSKTElci11EWjlx8Bn0qRDdgP5BwC6z0FKXspYW+jFERg+blqWFGeMCyyuAccZ
 eKofOGSVy3GIiaCP6bsi5f45jlnOknt+/273JPHBaQtx+81V97d/PqkACVspYpfsWbX1LTBP5d
 O7CJJrjOD6oIVGJ0wAAAA==
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
next/master branches. The full queue [1] holds ~20 patches. I'm trying to 
split that up to keep reviewing efforts low.

This series brings y2038 support for
  - timer_settime
  - timer_gettime
  - timerfd_settime
  - timerfd_gettime

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Patch 1: Remove unnecessary NULL check
- Patch 2: Split timespec validation into separate patch (now Patch 3)
- Patch 3: New patch
- Link to v1: https://lore.kernel.org/r/20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com

---
Florian Bezdeka (14):
      y2038: cobalt: Introduce some itimerspec64 related helpers
      y2038: cobalt/posix/timer: Adding timer_settime64
      y2038: cobalt/posix/timer: Use timespec64_valid() for validation
      y2038: lib/cobalt: Dispatch timer_settime
      y2038: testsuite/smokey/y2038: Adding tests for timer_settime
      y2038: cobalt/posix/timer: Adding timer_gettime64
      y2038: lib/cobalt: Dispatch timer_gettime
      y2038: testsuite/smokey/y2038: Adding tests for timer_gettime
      y2038: cobalt/posix/timerfd: Adding timerfd_settime64
      y2038: lib/cobalt: Dispatch timerfd_settime
      y2038: testsuite/smokey/y2038: Adding tests for timerfd_settime
      y2038: cobalt/posix/timerfd: Adding timerfd_gettime64
      y2038: lib/cobalt: Dispatch timerfd_gettime
      y2038: testsuite/smokey/y2038: Adding tests for timerfd_gettime

 include/cobalt/kernel/time.h           |  21 +++
 include/cobalt/uapi/syscall.h          |   4 +
 kernel/cobalt/posix/timer.c            |  45 +++++-
 kernel/cobalt/posix/timer.h            |   8 ++
 kernel/cobalt/posix/timerfd.c          |  40 +++++-
 kernel/cobalt/posix/timerfd.h          |   8 ++
 kernel/cobalt/time.c                   |  35 +++++
 kernel/cobalt/trace/cobalt-posix.h     |   6 +-
 lib/cobalt/timer.c                     |  17 ++-
 lib/cobalt/timerfd.c                   |  27 ++--
 testsuite/smokey/y2038/syscall-tests.c | 247 +++++++++++++++++++++++++++++++++
 11 files changed, 442 insertions(+), 16 deletions(-)
---
base-commit: 2a60f423f269539f1af0d261810644ed09ee494d
change-id: 20230508-florian-y2038-part-two-7d7864dadd71

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

