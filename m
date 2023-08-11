Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC6539F
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:37:58 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023081107374963aa24845348dc3044
        for <xenomai@lists.linux.dev>;
        Fri, 11 Aug 2023 09:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=J2sqFq9w6cVf9RjnE5NCZgcXdRcRy+0q7FVIYdjHunw=;
 b=TxCbKazJrXyBvWgQAwjKrVMdvyPnL8HhrDRm2yh72/Yf1fuDkyW5klVOQANj9r07V5U6CT
 imYI8MGwPA10vv4Y2YruxhYnns5SBNzB5hVYdnaxxXDJOdH6YyNiUNNCG5n7pVb1xBL66wdm
 rjH1qxxDrk79+Kd5n7vwrEH06iStg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/7] y2038: Finalize and enable y2038 support
Date: Fri, 11 Aug 2023 09:37:35 +0200
Message-Id: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/l1WQC/x2NQQrCQAwAv1JyNhCziNWviId0zdrAspUsFqX07
 waPMzDMBl3dtMN12MB1tW5LCzgeBsiztKeiPYKBiRONdMFSFzdp+GVKIzJySpREzifKBaKapCt
 OLi3P0bV3rSFfrsU+/83tvu8/f0Vfd3YAAAA=
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,
    
this is the final y2038 related patch series. With this series applied
y2038 support will be enabled by default for all affected
builds/architectures.

There is a kill switch (--disable-y2038) available in case unexpected
problems come up after merge but that is not expected. The y2038 queue
was regularly tested over the last two years now.
    
Short summary:
  - Implement y2038 safe ioctls around SO_RCVTIMEO and SO_SNDTIMEO
  - Enable additional function wrapping
  - Fix some smokey tests (reading of reference clocks)

Fingers crossed, seems the y2038 issue is solved now.

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (7):
      y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
      y2038: lib/cobalt: Switch vdso to gettime64
      y2038: testsuite/clocktest: Fix reading of reference clock
      y2038: build: Introduce new build parameter --disable-y2038
      y2038: lib/cobalt: Add additional time64_t related function wrappers
      y2038: Route explicitly requested stdlib calls to time64 equivalents
      y2038: lib/cobalt/select: Fix __RT(select()) routing

 configure.ac                                     |  63 ++++++-
 include/cobalt/mqueue.h                          |  11 ++
 include/cobalt/pthread.h                         |  10 ++
 include/cobalt/semaphore.h                       |   4 +
 include/cobalt/signal.h                          |   5 +
 include/cobalt/sys/ioctl.h                       |   3 +
 include/cobalt/sys/select.h                      |   8 +
 include/cobalt/sys/socket.h                      |  15 ++
 include/cobalt/sys/time.h                        |   4 +
 include/cobalt/sys/timerfd.h                     |   9 +
 include/cobalt/time.h                            |  35 ++++
 include/cobalt/wrappers.h                        |  10 ++
 kernel/drivers/ipc/bufp.c                        |  34 ++++
 kernel/drivers/ipc/iddp.c                        |  34 ++++
 kernel/drivers/ipc/internal.h                    |  27 +++
 kernel/drivers/ipc/rtipc.c                       |  29 ++++
 kernel/drivers/ipc/xddp.c                        |  18 ++
 kernel/drivers/net/stack/ipv4/tcp/tcp.c          |  31 ++++
 lib/cobalt/Makefile.am                           |   7 +
 lib/cobalt/arch/arm/include/asm/xenomai/time.h   |   5 +
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h |   5 +
 lib/cobalt/arch/x86/include/asm/xenomai/time.h   |   5 +
 lib/cobalt/cobalt-glibc-time64.wrappers          |  23 +++
 lib/cobalt/select.c                              |  15 ++
 lib/cobalt/wrappers-time64.c                     | 203 +++++++++++++++++++++++
 scripts/xeno-config-cobalt.in                    |   5 +
 testsuite/clocktest/clocktest.c                  |  11 +-
 testsuite/smokey/y2038/syscall-tests.c           |  46 +++++
 28 files changed, 669 insertions(+), 6 deletions(-)
---
base-commit: b6c84c13785ebb2c5493bdfe8fad50974eda442e
change-id: 20230809-florian-y2038-2-23303aa750cf

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

