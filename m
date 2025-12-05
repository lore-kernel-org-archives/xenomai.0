Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4A304969
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927825; cv=none; b=ZkJDkwFZtGK8SfT4Y7FJ2qMHh+W0x9h6X0jsy//wxLbH214yKLADEWgqcrY+8w0db9SGqrqNaVwbEkmQGTP3uYNhBJv9LTabUZv073p07L5RQfUHyT0DmAZBmOd1SmxDHRDkdh2Ls0/zAOU1bG82TgI2Dk16z3dZUhxAy0qOXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927825; c=relaxed/simple;
	bh=iEQ1dDBO50HrilXB8lj1QfBNL/z2T263pOnGDsDOtfY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IANltIjtkrD9yoz8ClvPFTIU3xT3QxARqeUUJUmtEX+eyTGkUtM0RE7c09iEPwSEG7J+ToRaZd8vRWy6hXbCJ0NmR4TS6GoSWo74AQN8YGB0r92eaHUT6yvCn8BYUuyxhu8Lg6OedCISbw1r4lsQ5HMsPRkJYe+2pJQkPwlC8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eedl2eEd; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eedl2eEd"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251205090312021451168b000207de
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=4tT/iSXxEjDBp8t4nandBjp5dj+0tNyyH2bDxNkN1kE=;
 b=eedl2eEdbRDZfbqcCQoCPvvr3eo0APIOfzWRrfilYnfBgr3lFjeR9F2OoOhbQFT9qSbyl4
 RzI8z/+bCswVUCp3gFSYdmLX9V70UjPbkKg2YS0dzhLS88zx05yyQQ2q9YfKJ6rycnv6LqgO
 YfeCRMf5ULRcdVMWENDG2RE8g4SM7ev3iKpKLv59uTE4InKyv9y8im+/EAEkX9VPEH9aPuR6
 BGEC9TWM/Q5Ox4RPBWrI+ZsSDtoYr9bWgaXnZ+tgjxjfCUsrgO15Qy3ISdm2lUClA9+6dxVr
 G/NqTwBQyXEgMYl7sPWEI+AOCq+qtIDLA1zb6O2w/I39o4vB0vzqfQsA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/6] Some fixes for the select syscall
Date: Fri, 05 Dec 2025 10:03:10 +0100
Message-Id: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6fMmkC/x3N0QrCMAyF4VcZuTbQlk3UVxEv2pi6QOikUVHG3
 n3By//Ax1nBuAsbXIYVOn/EZGke8TAAzbk9GOXuDSmkKaYwYtUFq3zRWJleaD+jrIql0hRP52O
 okcBxycZYem40O29vVR+fnZ3+3663bdsBR9HCgH0AAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is the result of a short debug session triggered by Andreas who was
staring at some strange select() behavior.

The issues were introduced while working at the y2038 support, so
backports should go into the stable 3.2 and 3.3 series as well.

The testsuite has been extended so that we cover the missing case now as
well. CI test runs were based on dovetail 6.17, covering all supported
architectures, compat userland included.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (6):
      y2038: lib/cobalt: select: Normalize timeout value in the y2038 case
      y2038: lib/cobalt: select: Fix timeout writeback of the compat time64_t case
      cobalt/posix/select: Optimize cobalt_timeval_to_timespec64()
      cobalt/posix/select: Optimize cobalt_timespec64_to_timeval()
      testsuite/smokey/posix-select: Move message queue test into own function
      testsuite/smokey/posix-select: Extend the testsuite by invalid timeouts

 .../cobalt/include/asm-generic/xenomai/syscall.h   | 25 +++++--------
 kernel/cobalt/posix/io.c                           |  4 +--
 kernel/cobalt/posix/syscall32.c                    |  4 +--
 lib/cobalt/select.c                                | 15 ++++++--
 testsuite/smokey/posix-select/posix-select.c       | 41 +++++++++++++++++++++-
 5 files changed, 66 insertions(+), 23 deletions(-)
---
base-commit: d557f120bf73a0e467196c99e9de210244b29774
change-id: 20251204-flo-fix-select-syscall-bfc518960f1c

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

