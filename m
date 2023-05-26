Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9E23AD
	for <xenomai@lists.linux.dev>; Fri, 26 May 2023 05:46:09 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230526053558b436af9fe9ba43dd0e
        for <xenomai@lists.linux.dev>;
        Fri, 26 May 2023 07:35:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wCRAl5xAdmJSQlHL8hSNOaK9nDXiwzzB93QUH0MFZNA=;
 b=FuC5OmXLae2RnmniLzxwBgCIHrMkxfCI2a1rIMn8Fj/9o2C+1drfScIsMCSr9ikhYTXexj
 V53PaOSh5USHPzNaaRztOfEyFKUDgTWDLYkHnrypoaOBT/5AqRJ3WH2/1dNol9bwOodEV2T8
 UnBFBSk4YBySsR5o8Cjz8f/2vYOVs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/4] y2038: Part three - support for select()
Date: Fri, 26 May 2023 07:35:56 +0200
Message-Id: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADxFcGQC/42NSw6CMBRFt0I69pl+FMGR+zAM2vJqXwItaZFIC
 Hu3sgKH5yT3no1lTISZ3auNJVwoUwwF5Kli1uvwQqC+MJNcKn4VNbghJtIBVslVA5NOM8w+IYL
 irep169C6hpW50RnBJB2sLwfhPQxFTgkdfY7esyvsKc8xrUd+ET/7R2kRwMGIC5e3xsja1o9MO
 GLIZxtH1u37/gWUlKWD1wAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
next/master branches. The full queue [1] holds ~7 patches. I'm trying to 
split that up to keep reviewing efforts low.

This series brings y2038 support for select().

select() is somehow special. Linux does not support a y2038 safe
implementation for select() itself. If the application needs y2038
support the application has to use something like the pselect() service.

To make select() y2038 safe glibc wrapps select() and wires it to the 
pselect() Linux service.

Xenomai (cobalt) does not provide pselect() yet and it's not easy to 
implement that. The reasons:

  - The underlying xnsynch infrastructure is not prepared for waiting for a
    combination of file descriptors and signals. (Let me know if I
    overlooked something!)

  - Implementing pselect() would require up to 6 parameters that need to
    be forwarded to the kernel. Xenomais current limit is 5.

To get select() y2038 safe a "pselect64() like" service service is being
added. The signal part is skipped.

The wrapper for __select64() will be added later and will convert 
struct timeval to struct timespec64 in user space. This way select() 
provided by libcobalt gets y2038 support but pselect() is still not 
supported.

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Patch 1: Do not skip updating the timeout if fds changed
           Fix is in all entry points.
- Patch 2: pselect64: Same as above. Do not skip the update if fds
           changed.
- Patch 3: unmodified
- Patch 4: New patch. Fix timeout update in case of -EINTR

- Link to v1: https://lore.kernel.org/r/20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com

---
Florian Bezdeka (4):
      y2038: cobalt/posix/select: Refactor __cobalt_select()
      y2038: cobalt/posix/select: Adding pselect64
      y2038: testsuite/smokey/y2038: Adding tests for pselect64
      cobalt/posix/select: Fix timeout update in case of -EINTR

 include/cobalt/uapi/syscall.h                      |   1 +
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  22 +++
 kernel/cobalt/posix/clock.h                        |   6 +-
 kernel/cobalt/posix/io.c                           | 102 ++++++++-----
 kernel/cobalt/posix/io.h                           |   8 +-
 kernel/cobalt/posix/syscall32.c                    |  22 ++-
 kernel/cobalt/trace/cobalt-posix.h                 |   3 +-
 testsuite/smokey/y2038/syscall-tests.c             | 162 +++++++++++++++++++++
 8 files changed, 282 insertions(+), 44 deletions(-)
---
base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
change-id: 20230516-florian-y2038-part-three-3093da9fecf8

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

