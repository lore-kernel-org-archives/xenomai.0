Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274431A2C0B
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444298; cv=none; b=HiY9pawhIWf9hwY2WN60a76H+2oavbFKsdaOjr/l2Htqgx9pIZzwq4u4I3VqTm//oRpzHiri4P1Rpfvjr0MOPtJZFo/gRV70O+5Y6m2i+M/E2TM45z3HcbSENjHiPqIlXooUWTiHuX6SBW2GVZzLLcxgOptWo+3E7JvW6dhlQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444298; c=relaxed/simple;
	bh=mWRbIcz5CDyb+XhxOpHWrgWVG1wVfslKA1fwIHRrkps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QP8taYsYB+zr/ttlh5Nd32tKYFy24DHwiFwmqEMj9Xxu4ThyyMGuKRowkLTa1NQU85DuRRFOFgq5uABykyKqEi5vVSGvX1ZcWLSr5DwO7uOzTn8nF7VHhRcuuxuBHsqyN/wq4eA1gmZy+smSfMCwI1RLwAkCGUWXQL0Ll5+GYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aTrBmQG/; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aTrBmQG/"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260302093805596c4b0cd8000207d8
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=alTgug6htUonAY9xWZ1rDG+U5PYWfdQfJqhYruHKb6o=;
 b=aTrBmQG/YYTEH8F8n/SDWdoRnTGuKG16YU0cEm+5IU8JvIMU8IvCVmfm8oHP+5jSlqyL0N
 9u1V/8g5oDtbk2dWb/ZoplsLa22J6fH6me9kUCvdIrNv9yJImePiryp82RKgXy6lPuuJ1f6O
 wNOIPhyyxshobShA4YobuPMA+l1m2Tj5eT7Vrn3Wof2IUmzZpt+MnJWavgm4p/2Af+VbUNAk
 8k+fBKycHGdPyknA7KUUC3FgqGv2r9HeIzyHAdxd4F33sXxWfJs9uKNuPuwQnj7nYos83tLz
 pvjZKvb2hNeoO1xtMAcvDBu6oiYFBR3NpkK4LopudH06QAzOCE8TbffA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
Date: Mon, 02 Mar 2026 10:37:59 +0100
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdapWkC/4WNQQ6CMBBFr0Jm7Zi2KEVW3sOwgDLIJNKStqkaw
 t2txL3L9/Pz3gqBPFOApljBU+LAzmZQhwLM1Nk7IQ+ZQQlVCSUv+OQFx4fDkV8YeabqhKXqOaL
 tIifCms5D3WujTVdDtiye8nUv3NrME4fo/HsPJvldf24l/rqTRIG6lEbrkrQy5hqYZrLhaNwM7
 bZtH4zUrAXQAAAA
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
Changes in v2:
- SPDX headers for all created files
- Add copyright notice to all created files
  I checked all moved code parts for their previous authors and in case
  there was a copyright notice in the old location I copied it over
- Link to v1: https://lore.kernel.org/r/20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com

---
Florian Bezdeka (20):
      lib/cobalt: Introduce cond.h
      lib/cobalt: Introduce mq.h
      lib/cobalt: Introduce mutex.h
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
 lib/cobalt/cond.h             |   85 ++++
 lib/cobalt/internal.h         |    5 -
 lib/cobalt/mq.c               |  151 +-----
 lib/cobalt/mq.h               |   39 ++
 lib/cobalt/mutex.c            |  211 +-------
 lib/cobalt/mutex.h            |   97 ++++
 lib/cobalt/rtdm.c             |  105 +---
 lib/cobalt/rtdm.h             |   37 ++
 lib/cobalt/select.c           |  108 ----
 lib/cobalt/semaphore.c        |   67 +--
 lib/cobalt/signal.c           |   26 +-
 lib/cobalt/thread.c           |    8 +-
 lib/cobalt/timer.c            |  121 +----
 lib/cobalt/timerfd.c          |   39 --
 lib/cobalt/wrappers_time64.c  | 1097 +++++++++++++++++++++++++++++++++++++++++
 scripts/xeno-config-cobalt.in |    5 +
 21 files changed, 1439 insertions(+), 1281 deletions(-)
---
base-commit: c7226edf0167451a290b9a82e7331a15cc88122b
change-id: 20260219-wip-flo-fix-time64-32bit-native-8e5d8b7c7ca8

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

