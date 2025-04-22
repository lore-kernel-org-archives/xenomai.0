Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1051F3FF1
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305247; cv=none; b=WNyDgzoUfGyEJtHPcYjPrwKjsg8eiv2PwzE2kJCrtcNGyvcWqEvtvlXX/KAouP1pqS4zbcMQ4vw6YNJTa6vR/ZDYOMggWcJF8JqCA+PbrH2c6nHXnRZjGuHS3zlphAhovmvoopHoy4O3dNES1CXtujHTYpPy5ihsiSXJWn7hvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305247; c=relaxed/simple;
	bh=7VVhZBmpnCd/fb6xnkgGOEsm5ftg6yBuo4Tl7r+8CZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMpH5M0QKbtTW88PPwN4VKJ4THkAir/gX8V+mP7T00yvYF3OQUj74yhLMyXzo0Ui7tdycb0GUYDfnuskdHy+PzJKwir21IdPHgfqaGAkiHitH9nrKsGRX1y61Z8EEpjw+Vvb0ibyA0byG4G8Zf2u76GBj6ATKn3l4nOh35B+c2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CWVV8iRw; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CWVV8iRw"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202504220700399b955e3974ad387f45
        for <xenomai@lists.linux.dev>;
        Tue, 22 Apr 2025 09:00:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=w2/XrDnvx9DEHWdeYKuVN9j3NR3p8dtzUwmcwl+AXYs=;
 b=CWVV8iRwOZZTzFZl1D8fkz7z0xfiIxA9UHeUZuGFt2DSJ1dgQinmvT9QRFb0pUnPRnqfHI
 Y6QRAbETZ8a6zHGQCV9NLgOkjOzgk5hXEwD4tq1O9mDgGRRb79VSqAqNVWOXk9+Ni/vbfIW7
 mAJRnRXOEs1o51wu/Bn5LzwzZVFvemecOF5+1N1qxHB6eHTXv41paw4qPgbbKxRgMwyJEm1y
 6+3Jv/Ss3miOCkVYI79tdvGW7FLIQtsvBSksmeqRDcNgRdun+vvrEoIEEj1qrWBUVlgkL+DA
 AI1PwATNdFr06c2Um0AdOTlO6ai/3qvNpOA4105OqK/vA12wY5w5WGXg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] demo/posix/cyclictest: Fix building with glibc >= 2.41
Date: Tue, 22 Apr 2025 09:00:33 +0200
Message-ID: <20250422070033.648810-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

glibc 2.41 introduces wrappers for sched_setattr() and sched_getattr()
with slightly different signatures, so gcc (v15) complained about
redefinitions.

We can remove the prototypes from Xenomai as we never use them.
struct sched_attr was only used by the prototypes, so it can be 
removed as well.

The only remaining piece in rt-sched.h would be the definition of
SCHED_DEADLINE, which is part of glibc since 2.26. For the Debian
world this predates Debian buster, which is currently the oldest
supported version.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/posix/cyclictest/Makefile.am |  1 -
 demo/posix/cyclictest/rt-sched.h  | 61 -------------------------------
 demo/posix/cyclictest/rt-utils.c  |  1 -
 3 files changed, 63 deletions(-)
 delete mode 100644 demo/posix/cyclictest/rt-sched.h

diff --git a/demo/posix/cyclictest/Makefile.am b/demo/posix/cyclictest/Makefile.am
index 248e40690..15f157ab4 100644
--- a/demo/posix/cyclictest/Makefile.am
+++ b/demo/posix/cyclictest/Makefile.am
@@ -21,7 +21,6 @@ cyclictest_SOURCES =	\
 	error.c		\
 	error.h		\
 	rt_numa.h	\
-	rt-sched.h	\
 	rt-utils.c	\
 	rt-utils.h
 
diff --git a/demo/posix/cyclictest/rt-sched.h b/demo/posix/cyclictest/rt-sched.h
deleted file mode 100644
index 064e51c4f..000000000
--- a/demo/posix/cyclictest/rt-sched.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
-   rt-sched.h - sched_setattr() and sched_getattr() API
-
-   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
-   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
-   USA */
-
-/* This file is based on Dario Faggioli's libdl. Eventually it will be
-   replaced by a proper implemenation of this API. */
-
-#ifndef __RT_SCHED_H__
-#define __RT_SCHED_H__
-
-#include <stdint.h>
-#include <sys/types.h>
-
-#ifndef SCHED_DEADLINE
-#define SCHED_DEADLINE 6
-#endif
-
-struct sched_attr {
-	uint32_t size;
-	uint32_t sched_policy;
-	uint64_t sched_flags;
-
-	/* SCHED_NORMAL, SCHED_BATCH */
-	int32_t sched_nice;
-
-	/* SCHED_FIFO, SCHED_RR */
-	uint32_t sched_priority;
-
-	/* SCHED_DEADLINE */
-	uint64_t sched_runtime;
-	uint64_t sched_deadline;
-	uint64_t sched_period;
-};
-
-int sched_setattr(pid_t pid,
-		  const struct sched_attr *attr,
-		  unsigned int flags);
-
-int sched_getattr(pid_t pid,
-		  struct sched_attr *attr,
-		  unsigned int size,
-		  unsigned int flags);
-
-#endif /* __RT_SCHED_H__ */
diff --git a/demo/posix/cyclictest/rt-utils.c b/demo/posix/cyclictest/rt-utils.c
index 3882d2375..cf3367b3a 100644
--- a/demo/posix/cyclictest/rt-utils.c
+++ b/demo/posix/cyclictest/rt-utils.c
@@ -18,7 +18,6 @@
 #include <unistd.h>
 #include <sys/syscall.h> /* For SYS_gettid definitions */
 #include "rt-utils.h"
-#include "rt-sched.h"
 #include "error.h"
 
 static char debugfileprefix[MAX_PATH];
-- 
2.49.0

