Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072669;
	b=m8IZVLsyAfIv6jMXYR+BsTiQL4q/ikH7ts23oGhMhhY2KCK+bG4LLnCrLVEOgDlmqSUv
	 OK0oV6sHubcayac3eAXM4sSXnwfvndycNTNq1IfI8g6yojlWgfqlYIIlXjVS4lO9KZvqG
	 RXx4MHZwQ7/DukuSkIJDRsVmQJyzsVNYPuD64vvREKJZWIEM7ekkpsSBYZ+K36wkFK/KA
	 cCuSGc6/PSQ9AuXGP2xktyUjiaxT7qL5pYkBHc45Fho59tRGzj8wKT0ZQqRe/8QVW70++
	 h0oB4APX6/661zWCAvEj9I4429Rt0ueG0olLeSZ6qYZnkir3ROxfE6710sQUYaaXLEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JgJDWYNADp+yLehL10sYW62QKv1gHMy/6cSpI4tZtXo=;
	b=GiZJiKTGLAZ/UeBHW82OV7dY89Gty2YOIxv2sUJSHdfD7A3TUB5VO1iyly7YneU5Ut6T
	 bIzevGPCV1tzActS31vE4z6H8Pt9ks4GbVp+w9afXRrnnBYYpwi6YKoLI97rZ1ysCuyap
	 cYpCwD7C7IUPoCH/fp+TP0eTMKPOYo43/Nsy6AoFjxLP3QBmEYUVPiuOyOiqfWAmfB0Rl
	 RSC1w1YBR6cpWONuHuoDrvqQ51MznppiRyYAUq3Tq8BYKlpbQFb+zforkNP+fHpvkmplC
	 4Ko6LUGp//7tNFvlV+NGLzLCaj1B9k+SNXO/2eEeeeobHHEvi1qc7vxb54QaiU7VXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=dvPMa01X;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036D606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7036D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=dvPMa01X
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so1405573a12.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072667; x=1795677467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgJDWYNADp+yLehL10sYW62QKv1gHMy/6cSpI4tZtXo=;
        b=dvPMa01XJltOHvh+A6y2iyA0yB1xY/Q6/kmzMjkWTbnqMq54bzPavKhZpnkKO551zL
         R4mzmqCtghsunytCEX0dyAOxgTsGm1o4a8s8haVcMv2YN0j5cbDn/aMhPabl2W+PvFab
         3x5t5n4DmBQgrx57V0R6xIsQWUcpt7+UzZ71Vq8iZnukc7YvqxQ4vN91D4SKs/9SF8Ky
         nY6wCpvv3sNEFCwAxKPeEHOE2Ld5jr0sicpRXR9TWso8NOu8H+7Ad0m+KIJyl+obNQ1J
         mbm85xDt9h9+7L42EZBwtUcE5gQVIz8WkBOdSFmhwtkQ3JsDnXsTMT77D8hzhTdvY3uj
         /qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072667; x=1795677467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgJDWYNADp+yLehL10sYW62QKv1gHMy/6cSpI4tZtXo=;
        b=UeN9zBqDs+DVZ7CFKFM7sOe0haSyL/RBZOzjWDOVR/7XsQuSGnU/HEkwD89QanGIHH
         YuNQvU870ltG5rd9N4guZXfbcNQbwyXogMS5xVgQ5kR1KPkTJ/d85J3/CVl8n9JyvptY
         2ffr0++tJtKGfuscxn6jPhK7mYlM7jeoxYikmzAdDC3Fa8aq9Byw3bi/8TapZHAnEpqs
         y4jqfZXUIK4DY+xS2MMxWk64+euwVBEY4G9kKijbjCAy5YC9vCw17sYYmIRPlZFBES+Q
         FPfoWMwOOjRNip5SxHDNTu2Fo129qhYP2VjOn1+j/60i90w6TfykdVXiIdy6rNj7wfFR
         +/5Q==
X-Gm-Message-State: APuU4Z9F4GF45IQamAFYwBORXZZhYRBG4p40FzWOkApfYjUocpDdJ+VP
	J3jgldANxeVzB1WJxg3PfEN4E5m62t7GNM8HLR7TSM7xYIAXeWmn2da0TORm/g==
X-Gm-Gg: AYBFou31reo6Y4OhOcU+vB7MvEaegGztcaUbgwBfmhhKnhfyLR3sJR9sniW76msU7Is
	5VNkRNILk5F1ORma1J9porWOXsKeKMjDUJ/VZd5cCBCdB6xVO39uGEoLviBjRKj8EYNnerzyWaL
	X9jOpXL2iMxKfWOeUJMXPDBhfKTVBo4RTS6vWM7CHq3fkFAnoM/nuAR+Yq64RSi9lPLv564OCgs
	vwXiAKXfMSREpmGtjze5MkuWOod3ywzeVQsYx+EmCduznqdZutav0TPbHBND8eXGYVPojXUhYA6
	8Ui9Qu1b4KiJkKj3GsfGKcPOvNfSqezd1rsVEJsDsM8st7Y63QkRCIWJmraUfP5aoEtF7ac7vPR
	ni9BPaf74A+gPN6L4/1rXCsZpD+Sv954/hryA0GEPL9Zqqhgm57ZuLjlHFfIdKrvmVz+7yDe0KU
	N+x0XIcXL29tF0CP0LN0di+TbjhyrDrXHyXSMuPrUcjZVLGNinFC+QbNcSX6/6CFL8qOFoTVx6y
	3lf7lXScw1BMCQQgdbZEyoiSSv8ATohVV24EaonUvkKUWiDZkCOLBZ7YO9oUmRS0C/To7Hgm7y4
	VAupPb5YHszw8JEXM4BLn8ywaDjrLuS877ILmYyaMWY9tJxW8NPcZ0Rgay7KDaj0nT2bFoDGD3I
	P6SVTeSse
X-Received: by 2002:a05:6402:2115:b0:6b9:c43e:19e9 with SMTP id 4fb4d7f45d1cf-6b9c43e2317mr1386751a12.16.1795072666477;
        Wed, 18 Nov 2026 23:17:46 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:45 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 0/5] Mercury build fixes
Date: Thu, 19 Nov 2026 08:17:40 +0100
Message-Id: <20261119071745.2409665-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mercury core and its testsuite no longer build on next, as several
includes are only pulled in indirectly with Cobalt, and pipe-1 is built
although the Alchemy pipe API only exists with Cobalt.

The missing includes don't depend on the C library: glibc 2.24, 2.35
and 2.44 and uClibc-ng 1.0.59 all fail on the same lines. Only the
missing <stdbool.h> depends on the compiler, as GCC 15 and later
default to C23, where bool is a keyword.

Tested with next plus this series:
- Mercury with the testsuite, built directly with configure and
  "make -k" for aarch64 (glibc 2.24, GCC 6), armv7 (glibc 2.44,
  GCC 16), armv5 (uClibc-ng 1.0.59, GCC 15) and x86_64 (glibc 2.35,
  GCC 11).
- With Buildroot: Mercury with and without the testsuite and the
  Alchemy, pSOS and VxWorks skins, for armv5 (uClibc), armv7 (glibc),
  aarch64 (glibc, GCC 6) and a static uClibc arm toolchain.
- With Buildroot: Cobalt with the testsuite and all skins for armv7
  and aarch64, and for x86_64 with GCC 16 together with a 6.12
  Dovetail kernel. With uClibc, Cobalt fails as before on
  __OPEN_NEEDS_MODE in rtdm.c and on the missing <sys/auxv.h> in
  parse_vdso.c, which this series doesn't touch.

The series also applies cleanly to stable/v3.3.x.

Changes v2 -> v3:
- Added Florian's "testsuite/smokey/alchemytests: Fix build failure
  with core !cobalt" from wip/flo/refactor-includes as patch 2
  (suggested by Florian).

Changes v1 -> v2:
- Rebased on next.
- Dropped the autotune, sched-tp and pSOS/VxWorks GCC 16 fixes, which
  are already in next (thanks Florian).
- Patch 1: include the headers only for the Mercury core
  (suggested by Florian).
- New patches 3 and 4: further missing includes found when building
  the Mercury testsuite.

Florian Bezdeka (1):
  testsuite/smokey/alchemytests: Fix build failure with core !cobalt

Yegor Yefremov (4):
  lib: Restore includes needed by the Mercury core
  testsuite/smokey/alchemytests: Add missing includes
  testsuite/smokey: Include stdbool.h where needed
  testsuite/gpiobench: Include stdarg.h

 lib/boilerplate/setup.c                      |  3 +++
 lib/copperplate/internal.c                   |  4 ++++
 testsuite/gpiobench/gpiobench.c              |  1 +
 testsuite/smokey/alchemytests/Makefile.am    | 17 ++++++++++++-----
 testsuite/smokey/alchemytests/alchemytests.c |  3 +++
 testsuite/smokey/alchemytests/event-1.c      |  1 +
 testsuite/smokey/alchemytests/mq-2.c         |  1 +
 testsuite/smokey/alchemytests/task-11.c      |  1 +
 testsuite/smokey/alchemytests/task-2.c       |  2 ++
 testsuite/smokey/psostests/task-2.c          |  1 +
 testsuite/smokey/vxworkstests/task-2.c       |  1 +
 11 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.34.1

