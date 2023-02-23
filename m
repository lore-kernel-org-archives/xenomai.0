Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE41FBE
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:29 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230223070419d23326859ef3e2aa2d
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5oFrQapNB8DAuB1BnC/ZW8K502LhNkMpZkEvWWuzaj0=;
 b=ZPTA14JHC7rui1ckmwH2ij49XXVj3c5qLcn4pxpLKn2fspPoH6kvqo+7MlAfxvBAlz4DE7
 c19LUl48NfND1x5461wwsawdlO2T2fh3L9x6SuAaVCxa2hGMBvy1AesmeMX9+h5Zi6qCsv3G
 imX8VbZ6/IKtRnzgqfQQ0E0hK1ez8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 0/7] Add full smokey compat support 
Date: Thu, 23 Feb 2023 08:04:10 +0100
Message-Id: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

an internal customer detected some testing issues in the stable 3.2.x
branch. All of them were directly related to compat support.

With this series applied the complete smokey testsuite can be run in
compat mode without any issues. Patch 6 needed a backport (can driver
got a refactoring in next/master), all other patches were taken from
next/master without any modifications.

The failing testsuite looked like this:

/usr/lib/xenomai/testsuite/smokey --run \
                                  --keep-going \
                                  random_alloc_rounds=64
                                  pattern_check_rounds=64
dlopen OK
syscall-tests.c:712, assertion failed: !ret
xddp OK
vdso_access OK
tsc OK
timerfd OK
sigdebug OK
setsched OK
sched_tp OK
sched_quota OK
rtdm OK
posix_select OK
posix_mutex OK
posix_fork OK
posix_cond OK
posix_clock OK
setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
memory_tlsf OK
memory_heapmem OK
memory_coreheap OK
leaks OK
iddp OK
gdb OK
fpu_stress OK
cpu_affinity OK
bufp OK
arith OK
start_timesyncd
false
child 269 returned: exited with status 1

Best regards,
Florian

Florian Bezdeka (7):
  y2038: posix/mqueue: Fix compat case for mq_timedreceive64
  y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
  y2038: cobalt: posix/signal: Take care of compat mode for
    sigtimedwait64
  rtnet: Enable compat ioctl interface
  cobalt/rtdm/fd: Adding helpers for handling compat affected data
    structures
  drivers/rtcan: Implement compat support for the rtcan driver
  drivers/net/stack/ipv4/udp: Implement compat support for the udp
    driver

 include/cobalt/kernel/rtdm/fd.h               |  16 +++
 .../x86/include/asm/xenomai/syscall32-table.h |   3 +
 kernel/cobalt/posix/mqueue.c                  |  26 ++--
 kernel/cobalt/posix/mqueue.h                  |   2 +-
 kernel/cobalt/posix/syscall32.c               |  17 ++-
 kernel/cobalt/posix/syscall32.h               |   3 +-
 kernel/cobalt/rtdm/drvlib.c                   |  17 +--
 kernel/cobalt/rtdm/fd.c                       | 122 ++++++++++++++++++
 kernel/drivers/can/rtcan_raw.c                |  42 +++---
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  29 +++--
 kernel/drivers/net/stack/rtnet_chrdev.c       |   1 +
 11 files changed, 208 insertions(+), 70 deletions(-)

-- 
2.39.1

