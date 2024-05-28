Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577045024
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879893; cv=none; b=XQlfqbpQDzoH0Xn/9FsyYznbNYClNbPi8+KWo/+5SpibIbZYgHQsNlBDcuhwU/eudlopwIks2UBc03CZ1dh2qQ1S7RQZX0g97r1LpHKxYZW49jUjdDUAX8Dy7x7CrRnfTdEW0VGabFEXQfWDyOCTmCP6x2eMSSEDJFg31fC06Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879893; c=relaxed/simple;
	bh=iPpcM0ou6R/PYOPTLllUv5CfAEa9vKU7590niQfg354=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj08HFbhqSaxGx0UIx5g/k8+I9E5IDqZDADYShDo+2qNNz1MAyK83bCtkWAKezbCSPxgfkWeX5YbeWrAKdN7cCgEzWhPYz18GZvqJjZWLDAsMnY7Df4rYYgANrRUpsxf2GHv9fqiojs4pFkXDX1sDR7rL1xnYLguMdBe4j+mTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=YaGN5uRe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="YaGN5uRe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35507e3a5deso2169353f8f.1
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716879888; x=1717484688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSqDHEDiEQUCh84/KfF9TlHAQjUel1qYDEgtlbjPDq8=;
        b=YaGN5uReavK7XMQffrQLrr7JIFbWxTCUfgon+RTh+gfxet/v5BAO99HGVvDiBVNuxq
         uIMFljvVScD2bvDQro+AHvrMxufFFklQcSsXcs5Jq9BHaaC+Ywrsc21EiQN1Q4A3gQ/S
         nirW4QBOiHH+XWCInLge9UQcvUdj+CqNRSZiUFAunPZzEAP6XOdk4ARE11dYu4NA+2Ev
         AOLcn4RQAal96kGFPrxiPmJdrsXjfrDU0rNostDl/pQImUj8u3v4eM/Rhybzr/LQXihf
         pt7xkYAQrNVYGia8xsiB6W4Mixfj6QCUw7k33tmHMYDC/gvvIlJiL8g0HgEMPaRWmgC1
         x/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879888; x=1717484688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSqDHEDiEQUCh84/KfF9TlHAQjUel1qYDEgtlbjPDq8=;
        b=tIXsvXA6a1Ummz87DNvs8FK5kPDOTkPd2BFRz4Ao+wZ6PydLm2jh4wIPCHJElpDmVR
         kef3lpSfL1uwVhz8yo8AUu2OX9+JQNupqo1+2+n3PoGqpnYcleAthhkqoL+1s4+qnsse
         tCJBkFvJntZISm8muW/8FFckTlEWU+469MmgjauieioPg7q00Zr3t0kU63TauXldSk7C
         ojaWS3v4OubHBrnFZletMHtyueuyShrfd9RRwrqmGsDS6cpd8pnyFyHdLHQ8En1Z9KfW
         dzgkNJsO80MVi2GTKcFPndJENKo5e/lUFC7zu3wngUgykydq0sAsvF7BlCAQQUfKm0v2
         1QLw==
X-Gm-Message-State: AOJu0Yz2gSmuaCmZQecXqvSVATgAtL7s8vQnnIr7ZMFmW1VjyfKX8T6h
	qkeqyMTsbacr6WjlPKnqyejGWZOP6EE22ERmf5EY1cZQD+ZGv0JAQ3vKS0358LB4Xv+6rsOU+q6
	V
X-Google-Smtp-Source: AGHT+IHYDs5aCmOZdLtE4b0lm9UTeTnbc7VzLV54AnYWkuQTCsDfY1+VqgE5HxHrX7zEGfEFhnjNSg==
X-Received: by 2002:a5d:46d0:0:b0:34e:3d3a:e144 with SMTP id ffacd0b85a97d-354f74ff762mr11672351f8f.2.1716879887915;
        Tue, 28 May 2024 00:04:47 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eecbd4sm164340355e9.8.2024.05.28.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 00:04:47 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 0/4] Improve period adjusting support
Date: Tue, 28 May 2024 09:01:36 +0200
Message-ID: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is loosely based on the RFC patch by Richard Weinberger
titled "xnthread_set_periodic: Improve period adjusting support",
posted last December [0].

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

[0] https://lore.kernel.org/xenomai/20231220194855.8684-1-richard@nod.at/

David Oberhollenzer (4):
  xnthread_set_periodic: Improve period adjusting support
  lib/copperplate: Add threadobj_get_periodic
  lib/alchemy: Improve period adjusting support
  testsuite: smokey - new testcase alchemy/task-11

 include/copperplate/threadobj.h              |   4 +
 kernel/cobalt/thread.c                       |  18 ++--
 lib/alchemy/task.c                           |  31 +++---
 lib/copperplate/threadobj.c                  |  21 ++++
 testsuite/smokey/alchemytests/Makefile.am    |   7 +-
 testsuite/smokey/alchemytests/alchemytests.c |   3 +-
 testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
 7 files changed, 165 insertions(+), 20 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/task-11.c

-- 
2.45.0

