Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056531862
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717876427; cv=none; b=obrT/ZZnmEuRqTZEzYPZgyYY+PmPpfocRltUkXk7n9kjkPx4nGbwhSN4bfnFxYLUcg65A9MZ6bkMnF1s9G67HTS44+JUA+0G5tFJj4rwzJupp461KRtbYZ4ST2iRQQvpXVXYBxkOJcRw7JL7KKWT+uDu6uqVanuWc7fJpUbM4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717876427; c=relaxed/simple;
	bh=Y7dcbMtZqlYuOpPtJcKVyQ5q4swwXqevGDmVf3ETPHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLFwmeQiKO55Qb89cTSC+w+/XRpUE2IbNPX+2GS8o+XfSVgndd2yDSrbAZeAHbOf1pmXBs/+aM+MMSGnOe76cRfY7Zp1EwJejDRNErTLo4coo37xKsQABZXRgwufT7wWRLJXC2htP5TESThTzmUYuVBC6pQsrcyi5AJjG8mJcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=BDd3IIf7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="BDd3IIf7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f089e35e7so1229491f8f.0
        for <xenomai@lists.linux.dev>; Sat, 08 Jun 2024 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1717876423; x=1718481223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2xpkx26Ltkoq7sRNPCt9ZH8d8jnIH81Lvpwa3opv4w=;
        b=BDd3IIf7BXlS/QcQ4ld76vLsPtvsDxKkAmsGzfl6sdEY08u2w+1XdT5ayDaIiAW7RG
         WB5Njdsx7/iFQyKWR8OGbM2dphuN2njLR8SgKfuHForhL+MmURye3FA9bQemwLe9h9oM
         4GzcFseQKyX7QaTYK106NFCcxMqwrToxxEI7BiMt1x8ScpjZjPZo8ZTbuj6yJEZdotR6
         LmkWnULmV/KoSASgeIGDujKTwHC4TjRSriX/vqx5Z/nFU10JAWVtF/bCg/MmineYqhGS
         bgIGVmeZ2eelf/0nz2f12UkHGYx/7ZQHE8NnohdrTXLRcTE80wRx3I98vtcErMZzfMGb
         ImpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717876423; x=1718481223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2xpkx26Ltkoq7sRNPCt9ZH8d8jnIH81Lvpwa3opv4w=;
        b=ElfmbFbsuCgceXbTGGXLiTKg7Ydo2p47izwHoNJQdQMDfKD7r300hC8gvzJG0ibkva
         R9yeb0fDO5UJyuf7YrPkRQDEj8uUg1IDMIvd+qh3y/o2U2a0UsKAJSK4DUlh1os3jHLs
         c9fSTkXANZlApzJBzGzYo8lVnFq9v6fYrkkJYDvJnY2wpFpGWFYQb5rG8ORTvWz13ard
         naIOLAZp7tXuZuuMgiY/2S1OGX+lV7MSqHnm8UYAUmhw5vWsVigt2QnwIgQx6Ri9zTCo
         1r59a7gRuVSGbkRO0Nd5DjOV60W7hJzbyDqWhvgrmle0v1C68QBADFIWV/WOL/9nBh8p
         n2ag==
X-Gm-Message-State: AOJu0YxmpOdyEtv6Fsc2l1xsW/NtTDyB3jtNvJZgOPYyFRCQmBAD3q53
	GeowNoCve7ei/oqH3rtmvD6Qr1gz1D88JGgJMAoip5IyV0Vb0u5v/EdGOJYk/mU6wwc+GQW9c8n
	q
X-Google-Smtp-Source: AGHT+IHa9H/tc73hqXgsDhCG+mGqH1bkv8CKq09FOHAyWmQtLmnQ+4GYK9lj7kkbV1NuKmJfra0WBQ==
X-Received: by 2002:a5d:54d0:0:b0:35f:bc7:6e4f with SMTP id ffacd0b85a97d-35f0bc77ba5mr3101257f8f.64.1717876422193;
        Sat, 08 Jun 2024 12:53:42 -0700 (PDT)
Received: from localtoast.asozial.it-syndikat.org (212-186-38-205.cable.dynamic.surfer.at. [212.186.38.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm1149608f8f.114.2024.06.08.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 12:53:41 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 0/4] Improve period adjusting support
Date: Sat,  8 Jun 2024 21:52:48 +0200
Message-ID: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [0]:
- Document changed behavior of rtdm_task_set_period
- Remove confusingly named variable from xnthread_set_periodic

This series is loosely based on the RFC patch by Richard Weinberger
titled "xnthread_set_periodic: Improve period adjusting support",
posted last December [1].

The xnthread_set_periodic function is modified, such that for an
already periodic thread, idate == XN_INFINITE picks the end of the
current period as the start.

This way, we can simply change the interval with a single call to
xnthread_set_periodic(), without creating intermittent, non-deterministic
period lengths. The next period uses the new interval, while the the
current one completes within the old interval.

The documentation is also updated to reflect this change.

rt_task_set_periodic in libalchemy is modified in similar spirit.
A new helper function, threadobj_get_periodic is added to libcopperplate
to facilitate the implementation of the new behavior.

A smokey test is added to check for the new semantics.

[0] https://lore.kernel.org/xenomai/20240528070432.6669-1-david.oberhollenzer@sigma-star.at/
[1] https://lore.kernel.org/xenomai/20231220194855.8684-1-richard@nod.at/

David Oberhollenzer (4):
  xnthread_set_periodic: Improve period adjusting support
  lib/copperplate: Add threadobj_get_periodic
  lib/alchemy: Improve period adjusting support
  testsuite: smokey - new testcase alchemy/task-11

 doc/asciidoc/MIGRATION.adoc                  |   3 +-
 include/copperplate/threadobj.h              |   4 +
 kernel/cobalt/thread.c                       |  18 ++--
 lib/alchemy/task.c                           |  31 +++---
 lib/copperplate/threadobj.c                  |  21 ++++
 testsuite/smokey/alchemytests/Makefile.am    |   7 +-
 testsuite/smokey/alchemytests/alchemytests.c |   3 +-
 testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
 8 files changed, 167 insertions(+), 21 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/task-11.c

-- 
2.45.0

