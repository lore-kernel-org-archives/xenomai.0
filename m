Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D7154BD
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:34 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230508081325894aacfe06a62c8b64
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fQMsCt/l//gzmj4QD5vP2/aL8yL2i8HJQW2Qo5wlw6M=;
 b=RzELQjbHaA4xdZK6YAfUTcn6OAC/2gVnILF19WqqGrQpsF8Ol2r3n9C0iUjxjGoXDyO9A9
 oR+JU358k75QmaVGgUXOBb2DsW91Fr4isDd1J/msTRYvr1BwD3detBzJugla250elNw/fltZ
 8/8zhtdM8YwBs9K8DIyknsF0CzlyI=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/13] y2038: Part two - timer and timerfd support
Date: Mon, 08 May 2023 10:13:22 +0200
Message-Id: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKvWGQC/x2NQQqDMBAAvyJ77kKMbRP6ldLData6EBLZaLWIf
 2/ocQaGOaCwChd4NAcof6RIThXaSwPDROnNKKEyWGM7czMex5hVKOHXms7jTLrgsmV0wfn7NVA
 IroUa91QYe6U0TDVPa4xVzsqj7P/b83WeP6XaPJ59AAAA
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
Florian Bezdeka (13):
      y2038: cobalt: Introduce some itimerspec64 related helpers
      y2038: cobalt/posix/timer: Adding timer_settime64
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
 kernel/cobalt/time.c                   |  38 +++++
 kernel/cobalt/trace/cobalt-posix.h     |   6 +-
 lib/cobalt/timer.c                     |  17 ++-
 lib/cobalt/timerfd.c                   |  27 ++--
 testsuite/smokey/y2038/syscall-tests.c | 247 +++++++++++++++++++++++++++++++++
 11 files changed, 445 insertions(+), 16 deletions(-)
---
base-commit: 2a60f423f269539f1af0d261810644ed09ee494d
change-id: 20230508-florian-y2038-part-two-7d7864dadd71

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

