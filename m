Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010796;
	b=RRnKy7tzvA5Kn/fJF4lKhLRvlPuPk6Bv9bxdJBRKe1bLHsFJ1LPVhSC4Dke6kNwRrHoy
	 imNgU6+PZXuwMlBusnUwi584ASsg7WeFLWtH8kSoxov3cj/qPSSvy02+FS6bVo1Y9kg+H
	 kr747Drvkl32u+ghgO0m25k+RLDuONLpuu7t4lt0jj2S82bmoVuefJ9MZBflJl0UCQ9cb
	 HhdDkEqKxCsFDDR0tlFeB7IXQM5FdNxXNeNhCoBVCxhKgNjbIoHKScKYNOpXvuI4k1auw
	 MTbBqBkDg4hyTlt3I0J6eI9fPZvlthX4La8c7+/kRppkdF0orS2JJH91UFEvBxYuOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CtgKZ0+uTA2KyOSygA1PHzXPKvPvyagHsIDLgV8fofE=;
	b=0uZbpH+c3sS5Hvu0IncxiU1sxO+Qh2DkaRwTDz6V8iUPEfqKKYRj7PBwUI2WFuitf+Fq
	 GSAmAI4FTQzZc5Lk0JANITmRv5Fh+SMDkwvmVIKF6grXznyiorhEUtNgIPcFgMQzuzmqp
	 FcZ/IJSDVKG7UQ+PojwFSev+8h5vHe8c+LJX6W/z8Ey8vpcua8M2Te57ywqhB1BaJEGTp
	 ni1NnmvJVQh4JK85d9SR8eL7i4ByVQ79IegGgNNAfGdd1URsP297olV0/Ce68eNLOihCi
	 /pHHbk3V9ZIlSyouFs8UmLgmYgkK6h38qsSrsdq9sbgPHMhvZw4q9WZ7s8y11yFvDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=llmsytRI;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D26606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=llmsytRI
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso227482566b.0
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010794; x=1795615594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtgKZ0+uTA2KyOSygA1PHzXPKvPvyagHsIDLgV8fofE=;
        b=llmsytRIM15UxEKD8+xuzkigg1tIcQCDn98m0zahO2mLr8oZ0GqJZgqolH3mw6IRzw
         BpW8G+lcHC2oiBYGkCHGjHQSmYtR1keYvohFbnemWnA8/vv5HizPgKsv/ryaO/Ccnq5D
         5byK/qUB6UX1/en15TeuDq260SNxDFj98lwf38Gk6BOMj0xJFHu7pVMBLvMeAHpH9j+0
         hihj06JoifKl+x6q2Fn1gRo1PMqv2lGU0GHjjHuuPrAh6JGdWoQMrL+xFSfU0KimLaYe
         XmpmMiZAVoANn40Dd7ZedWt9uRz7EYgh+YwBGEi/YtRcTMgXsKWL/N9MFo3VHS0PDFhD
         abwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010794; x=1795615594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtgKZ0+uTA2KyOSygA1PHzXPKvPvyagHsIDLgV8fofE=;
        b=v2PNlSiMwlWiOSKdub1dMH8d5UV10oBPiTZ93Zmt7rG7yy3aBlKJGiKVxLfyM5t8CX
         //pFMH63zvz3jQBgBOd1w2sVFs1R5J3Tx6h4eAPFgg2Xra3BdXqnvVJKaDUrUkicFxH5
         MUaSjjfxLM/DdonkmevMznEm61DlMSDtHsoxXyEHMaTQG4QNk5AtYTne9rKtreIJUsf6
         jwj5+Xju60RTqzrmfwQhDzvzFlrn301oAoybGR/Ou4OPWIKosw25FlbR/Iw/rLF4fcH2
         s4CFMoakonB7tEXHepR59Kad9MdRcd2xKSvK6YnFYNMjMOWVjyX+CY4TdU6Lo2q+4rQq
         sdEQ==
X-Gm-Message-State: APuU4Z+acVeWw6CNzhfwZsvc8oqVexSZWsG1vzXHYaNyTK6W+O+JLL56
	/i4DxFwys/ZXUfOvlPUHDWTFsB17nNgpoQz+AhuoMyHsNhEFf3SGNVzWKtTz7w==
X-Gm-Gg: AYBFou2bujvjfSstQiX06Bx9ZygG/LSodB1FyZl1ag6QM4xEKFpqFNgSg0zKyd+mZm/
	K34w7EuqVGl+PCLWy8xYUMjzIT326RtO7iBq//mUhegMS+6X91Tq6XqcFPGjqm0hiIkiZOAoMGI
	EreV0UeSHDw/6c1kADQ6jWmY7eWqVD7vSeBLz4nNrw8Aj3g/vPO14wZDtwNtdErAD1PX3FriQGs
	m8zGmRmXjd5wE/8RA3LyY1NPFKcteRv6J3kmenVdi+d40mE0WDQK9b+2C0gFlari4z+bgPn0xx8
	ytyCq9QWnKM48MqO6IlIK3qkHSeD+Hzc14bYTBtm+HWCwbTzoKRo4+h4cWB0IKswRzgjyY99g7p
	x6IBw4aFD8k5HXW2+SuH4ZrAa5Rdo9vKce+CZFLrlihIK5eOkrkNdRthzCdZXO1PquT2cebPAFj
	mbeBzedyM4yHxisQ1/xGcP5LPj1PYVK5YYV+6efFL3zFyIj66kwMuPpGqZTpexeMFQ67J3tXfX2
	U92BQO6y2x8JNW88f4kwhPwo1CUSLhgGiRtnkCrqTVtlwljT8IvZAd89jmubFrAxsFFE2NzMmDk
	i0NBq6frwUhnw+kXssZz8cKjf+NY9GA600rR3dktskW0rDZmS09/a6ZKygalfzarE4eORUES43G
	37NUn5v8r
X-Received: by 2002:a17:907:2d9f:b0:c2e:4397:7c82 with SMTP id a640c23a62f3a-c510e15767fmr245999366b.6.1795010794100;
        Wed, 18 Nov 2026 06:06:34 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346c84esm1024966b.56.2026.11.18.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:32 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 0/4] Mercury build fixes
Date: Wed, 18 Nov 2026 15:06:28 +0100
Message-Id: <20261118140632.1080213-1-yegorslists@googlemail.com>
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
includes are only pulled in indirectly with Cobalt. This series fixes
that, based on next this time.

Tested by building next plus this series with Buildroot:
- Mercury, with and without the testsuite and the Alchemy, pSOS and
  VxWorks skins, for armv5 (uClibc), armv7 (glibc), aarch64 (glibc,
  GCC 6) and a static uClibc arm toolchain. The Mercury testsuite
  also needs Florian's 454ae865 ("testsuite/smokey/alchemytests: Fix
  build failure with core !cobalt") from wip/flo/refactor-includes,
  which I applied for testing.
- Cobalt with the testsuite and all skins for armv7 and aarch64, and
  for x86_64 with GCC 16 together with a 6.12 Dovetail kernel. With
  uClibc, Cobalt fails as before on __OPEN_NEEDS_MODE in rtdm.c and
  on the missing <sys/auxv.h> in parse_vdso.c, which this series
  doesn't touch.

Patches 1, 2 and 4 also apply to stable/v3.3.x, patch 3 only partly,
as most of the affected bool users were added after v3.3.

Changes v1 -> v2:
- Rebased on next.
- Dropped the autotune, sched-tp and pSOS/VxWorks GCC 16 fixes, which
  are already in next (thanks Florian).
- Patch 1: include the headers only for the Mercury core
  (suggested by Florian).
- New patches 3 and 4: further missing includes found when building
  the Mercury testsuite.

Yegor Yefremov (4):
  lib: Restore includes needed by the Mercury core
  testsuite/smokey/alchemytests: Add missing includes
  testsuite/smokey: Include stdbool.h where needed
  testsuite/gpiobench: Include stdarg.h

 lib/boilerplate/setup.c                      | 3 +++
 lib/copperplate/internal.c                   | 4 ++++
 testsuite/gpiobench/gpiobench.c              | 1 +
 testsuite/smokey/alchemytests/alchemytests.c | 1 +
 testsuite/smokey/alchemytests/event-1.c      | 1 +
 testsuite/smokey/alchemytests/mq-2.c         | 1 +
 testsuite/smokey/alchemytests/task-11.c      | 1 +
 testsuite/smokey/alchemytests/task-2.c       | 2 ++
 testsuite/smokey/psostests/task-2.c          | 1 +
 testsuite/smokey/vxworkstests/task-2.c       | 1 +
 10 files changed, 16 insertions(+)

-- 
2.34.1

