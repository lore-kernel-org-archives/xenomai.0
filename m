Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528991;
	b=VIpnwuI+QzQxZf8whVSfrOnEVOGKt5MzT0lO8RRvyg5A/XgEh6nX53k+O4D3Es5te70y
	 1q9Co6Jx9qFgwdUafi7rClUV7c3Mk/qKSbVArg5vNeReffnxrshnrBrzVhoom4PWVaf/I
	 qcXyljr/PYqqZiIbtsO78aAb0oX8i4GZwbI1BgKi24OINcOcFA2uswbc9RM9EChhvftga
	 1NRTcm8Ay4vSkE2Sh4I8LNoYcbTjku/iyPv8gOQtqgyBIVYEfLJxj/xDCAZEmxg5Xcn/y
	 orKjq6s0POlzaPn1cI//5Jih5OY5sm3CXJhUbPnT26ZiXWVol6Q7/A9jSRZLt6+yYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C6m6Hursx0rGz2OyuhTbRKg1Q0Lw4T6aap1gaxd9jKs=;
	b=raVO3FI3hnbjY0YKbMzHu/lxW2Uvx9ePGWC2YhprkQx2m8+1pZq6vBzxBPZtEmMvh5Lh
	 EC9pSFOPFrs8PYixp1MwDG8rBwcN/FYft1CBX6Fxn8ap26BM/LBJRPAEcH7LDhaJKo555
	 Gd4s/tyVqEAB4Ujh586Se+2ees/40GY70Z8/rtuOVx3+9HlJrsh3GH0YFiDD/Q+W+x8z4
	 g1gRmeh+zZNMo9Z0lnCvkBPJOgGFAoNDxBXoUd0+UzdQwLm/RQUf4Cg8gjBs8kf/knMHy
	 1yPUU0aZxzadAXtICfG1o0TjWwcrwUfNIVLL0dmB3+PA88ORvhiLiNBO2MMXWG0Ivcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=cdrHevhK;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1814606A685
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1814606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=cdrHevhK
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50a4a2132cso662777466b.3
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528989; x=1796133789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6m6Hursx0rGz2OyuhTbRKg1Q0Lw4T6aap1gaxd9jKs=;
        b=cdrHevhKnOBl2ny4aOPx01+EukSrdr8fUS2n7B04S4SkePOwMO0VPCLkFv9MIwN4r8
         xb/NOlTcfoFYv9DWZqYjfi9YB4VmkJOztG8jtYbIpygEL2AAnm223uZIpwAw9PASYMBn
         B+PdVuuQJyAYWOWcuWfojwIttp/zoe+BAS9Jv8/Qz5Q1672t6CcdiTaSKW7zN0dCCUqi
         rI1sxkY48XK/MtCmHjEftNlXhHrmqadSfwWUkbbgqZOFVRLR6/HcZ9G0fk4P1EWuEV8U
         HQ68+FkHCdI8BZ2uGqDPEbOgljBG07e0dLLXsa9doXl5m6oQ5R94dcL6pVuS6Qh7a0hp
         kjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528989; x=1796133789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6m6Hursx0rGz2OyuhTbRKg1Q0Lw4T6aap1gaxd9jKs=;
        b=lYQ/0uNGaBbPo1Dkt4Ix19YFs1FBQn4/bcPt1KxIdU41HJet1g049obm0KYZQspM2V
         cHJKXcONKSJRLVcJtY3jo2VNxdjARA+swA1/M3miWEyvMHiS3y6WMpVlRcwtqravtyCl
         mpP6Q+hO6Smv/n4mowRTp6osAQ/VA920cDRPRj5hsPEuLkppIft131P32h5UnV8YzlzB
         CHaMgrA7Knvf9AWNU+QWC5pzEPwlnHrsTKel9YuiMgyOsV2fahwbckKso1+l/f2WL/ET
         iilHeZy7oHvSoBpAkh7HMfe8vJ2auIfFZ8uWDDbkAHvShAKFhgp84e15O3pPukcTvGi0
         nMKg==
X-Gm-Message-State: APuU4Z9FtXhkXfKVmFhSrs14jyvCPoNeo5g/gqVBUNMgimS+27n87why
	r0ivTva1dJxdZ5ngICNNCo6703oeKPciqqGDq8upBZaXYotg+dzmEXZp03X05Q==
X-Gm-Gg: AZFdTZez5DOJUpBQ3YZwRwcUVLdKpJAo9RaZZg+Z5ml5U6lUHwY2aV0EafeSx4bcVqq
	FBOqIbaQ9skg6D39D41RhP3RB3P29K3B+qf1miED4ju3kEQDJdtIj2GxZpVLUqGN1LEfg84pDNA
	7gM6WrIXa3cuwZ/o2rcsdZOAhA+xOPY7eRzsi9N8DiyjtzB7jAcahlVi4PKYELcGnF0YeYgxTSq
	nC+VLyXFV6rcoKm/67RQPZqNW4DrEgUvOxsCbz2vV6RqvEkjoHpUb7EZoddT+MH2jfVPtoRz5Jk
	KDBxGSPDEQsD1SNqeaUSd/s4LHlyxbjbhSLHarzTsV7OGw6eljoxqgEQHnhm8TDorSQNkk26y8v
	rZVzw6oyfzQz35ps1x6wWvlKQVIFZO3aHVIfkhNmBcDLHYBLdcgchX11JTA+unBGThHnllfVEao
	znTCiZ6RvCTDxYPIkzHv4ZoM+hV8L530AshGYWdUurFLwwudpvBO9mrdX7O2o4kjVxX5LreZgUk
	EcsFp8kYjJJMtK15jbGOaVKQhZtUyyjCS+EB0HialynyBDHvSxHHpI98WAYGEaetFVdCamgG8Iz
	sQSDp8awOIcEC7D0EWy+6uV3Fli0edbp/lVeG2DI/2fkyG58vdgPts9a3pTWiBenJ5tYgpTfFEc
	1fFPFeRbR
X-Received: by 2002:a17:907:608c:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c513a1f5c8cmr1239372866b.0.1795528988047;
        Tue, 24 Nov 2026 06:03:08 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm510486566b.0.2026.11.24.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:03:04 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/4] Cobalt build fixes for uClibc-ng
Date: Tue, 24 Nov 2026 15:02:59 +0100
Message-Id: <20261124140303.3336015-1-yegorslists@googlemail.com>
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

Cobalt has not built with uClibc-ng since v3.1.1. These patches fix
the build, plus the clock_gettime() vDSO selection, which picks the
32-bit call for uClibc-ng with 64-bit time_t. They complement Jan's
mmap() off_t fix for uClibc-ng >= 1.0.58, now in next.

Patch 2 is only needed for uClibc-ng releases before 1.0.43, which lack
getauxval(). The Buildroot autobuilders still use such a toolchain
(br-arm-full-static, uClibc-ng 1.0.36).

Tested with Buildroot's test-pkg on next plus this series, building
Cobalt with the testsuite, RTCAN, Analogy and the pSOS and VxWorks
skins:
- armv5 uClibc-ng 1.0.59 (time64), GCC 15
- arm static uClibc-ng 1.0.36, GCC 9 (getauxval() fallback in use)
- armv7 glibc 2.44, GCC 16
- aarch64 glibc 2.24, GCC 6

Without the series, both uClibc-ng builds fail on __OPEN_NEEDS_MODE,
and the older one also fails on <sys/auxv.h>. The ADJ_SETOFFSET error
only showed up once these were fixed.

For patch 3, I compared the vDSO symbol the preprocessor picks before
and after: __vdso_clock_gettime64 instead of __vdso_clock_gettime on
uClibc-ng time64, and no change for armv7 glibc with or without
_TIME_BITS=64. I have not run it on uClibc-ng hardware.

musl is not covered. It defines neither __USE_TIME_BITS64 nor
__TIMESIZE, so libcobalt would use the 32-bit time syscalls there as
well. That needs a separate look.

Yegor Yefremov (4):
  lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
  lib/cobalt: Provide getauxval() fallback for the vDSO parser
  lib/cobalt: Select the time64 vDSO call without __TIMESIZE
  testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing

 configure.ac                                  |  3 +-
 .../arch/arm/include/asm/xenomai/time.h       |  8 ++++-
 .../arch/arm64/include/asm/xenomai/time.h     |  8 ++++-
 .../arch/x86/include/asm/xenomai/time.h       |  8 ++++-
 lib/cobalt/parse_vdso.c                       | 31 ++++++++++++++++++-
 lib/cobalt/rtdm.c                             | 14 ++++++---
 testsuite/smokey/y2038/syscall-tests.c        |  5 +++
 7 files changed, 68 insertions(+), 9 deletions(-)

-- 
2.34.1

