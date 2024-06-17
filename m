Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451D194135
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615934; cv=none; b=VpRltdqPzv4N42hITc5o9YmsPud3Gzy8gJ74iOorx0xPTAU9ggzQRCxW7ADtHI2qNPgHhfi72VTBZByTON4mbuoV04qtr+vqUWSh5aDTBD/UCsFOOjhdsGktMLl1+GJZzkBWZ/+FcRg6QaZbsOmEm3htfxvLSZ3GwLWsE7RyabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615934; c=relaxed/simple;
	bh=04uVhmXHYUR3NKibUxCthywr+4GHPnh2VV4ZriI6S/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlouiANrsiV2MK3Rvuk64fp8OtnPb9H+C7Jo3KfOxuXKHtXy0z+Bq36dVeMtit3AZcLrPN5bh59237D+jI8ZxdEWIdOeNNE1pcd5eFy0jl4hzwux+0jnaMbcS1mMuq+c2WnSBxYw4Mf+ItrG3EEFnXKv2/ksSHmvT5/0x3KWfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=S6SBSAZZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="S6SBSAZZ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec0f3b9bb8so25844211fa.1
        for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1718615929; x=1719220729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVk6+ouNndJTKgszp5uCz9Vn9H6A0Q2oMy0OzxMeiAI=;
        b=S6SBSAZZxfcz1fJBBGXJWxMMH4iqlDvE4fLQJQzxgfNN4MWPLZ74v91j/9ZAQOBfyU
         wxUCse54cAf5bFLbh/FdBLNCEgSkBtuTE8Tt4G3jys/O9mqq16R5OLsbZrrPQmrNGQmE
         B3zy3VpppkVb1d3mJZn+1F1FIgmsPFbByCq0RLQ+wWE1vd/VXeBqxtryx5lPYHlcdrPX
         atsIv9yieTF5hNvW4XTzR8IWQ1iFlooHXTuBArF7zrpXPIYC29SxS6ylETLwQ8uJA5/n
         QWL+ngfCJcnhLlQNrFh8h/JylhBiyPkqI+ssDgC/ziDeNqMMYsY7hjgz8+6bmTNAlZHz
         skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615929; x=1719220729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVk6+ouNndJTKgszp5uCz9Vn9H6A0Q2oMy0OzxMeiAI=;
        b=UGlK4X9Z5lb4vizkA3hmLru5PtOFT7fhsMOCOMXvvDn5VnUFlPebDX5AIkOIVh01RF
         6dZa8k4Kdt+fpvcWN5f6ypEGojnAbG8mR5jfxmaYgZxiny1BwTZW+ScrOT8KjV07EFAx
         +MFAlh6sT0YdPQE2Lk9FhW1BK5vjitcjOE6yqg82jJ1IFDOZ/UjG5/wtfkNCbrt2UKRx
         MqqoHrJsviA2qMP/jo3QvPDx2HyR0MwtSaBZLbxq8859gAkO0CYNqYRg4Ce/FP1GEPA0
         s9gD18aDjXQ1/zqML/5LCB5Ve7jDJNVK23PeMPRSQpw0YR6C1su3ssqppbUEp005SCwY
         xSQg==
X-Gm-Message-State: AOJu0YxLFGOQW4krl2BdkwCFqvf1SkKoBkWdA9bzeAbykuhYZxJa4zV7
	70Ce1sLri073mBFWnwEjE8SkGOk1XGZqn40CLR6Ckykkk3Zv1K1eZlJUrYaWVzlOnkEXrSJ88tW
	g
X-Google-Smtp-Source: AGHT+IGGGe9luQV72RB66/W7fyU+mJ4Wd2OruRvRyI4gOYGGijy+h06nYIVM040kdDozvbiPW738gQ==
X-Received: by 2002:a2e:968c:0:b0:2ec:434:2ca9 with SMTP id 38308e7fff4ca-2ec0e5b5f10mr60999291fa.6.1718615929028;
        Mon, 17 Jun 2024 02:18:49 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm75591125ad.181.2024.06.17.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:18:48 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 0/4] Improve period adjusting support
Date: Mon, 17 Jun 2024 11:16:50 +0200
Message-ID: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2 [0]:
- Document changed behavior of rtdm_task_set_period

Changes since v1 [1]:
- Document changed behavior of rtdm_task_set_period in MIGRATION.adoc
- Remove confusingly named variable from xnthread_set_periodic

This series is loosely based on the RFC patch by Richard Weinberger
titled "xnthread_set_periodic: Improve period adjusting support",
posted last December [2].

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

[0] https://lore.kernel.org/xenomai/20240608195337.11137-1-david.oberhollenzer@sigma-star.at/
[1] https://lore.kernel.org/xenomai/20240528070432.6669-1-david.oberhollenzer@sigma-star.at/
[2] https://lore.kernel.org/xenomai/20231220194855.8684-1-richard@nod.at/

David Oberhollenzer (4):
  xnthread_set_periodic: Improve period adjusting support
  lib/copperplate: Add threadobj_get_periodic
  lib/alchemy: Improve period adjusting support
  testsuite: smokey - new testcase alchemy/task-11

 doc/asciidoc/MIGRATION.adoc                  |   3 +-
 include/copperplate/threadobj.h              |   4 +
 kernel/cobalt/rtdm/drvlib.c                  |   4 +-
 kernel/cobalt/thread.c                       |  18 ++--
 lib/alchemy/task.c                           |  31 +++---
 lib/copperplate/threadobj.c                  |  21 ++++
 testsuite/smokey/alchemytests/Makefile.am    |   7 +-
 testsuite/smokey/alchemytests/alchemytests.c |   3 +-
 testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
 9 files changed, 170 insertions(+), 22 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/task-11.c

-- 
2.45.1

