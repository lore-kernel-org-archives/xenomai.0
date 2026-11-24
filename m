Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531908;
	b=uhCbWgJ/DiPUgdGiPIBcP/5VtDgEfB7i6B944yMeQQiPJ+0/de/RggYTgWg84MalQz1t
	 JBnUTscFTEevb3jWMnNpMqubke8mfSGp08CPhQn9IhW549qcPI8oKGI8xo1Kdn7VYxO0o
	 hLHZ0+kKnaTiupo/1M8ZmeZsvU3Mi2eqzVAW1ndlkJ6CVxIwZwFqqKC6FeTsQBfswHApH
	 AZVRJhW4C/0r7Sh4er8DKc3plG6xfUbrAyPOpGeaTQ+bKpo7UKKHdk4WmXtAGkMdiPcIa
	 G1rpgSIRaCzRJyxaYZQquuAqnvTk56e5fK88gsLSE/x5tY8702vFjBL79QNSkvCp2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sZBHTqZxDzbzcijZrIWs3+mMMGQYVCjnLOQNQf1t4YY=;
	b=yxXVg3KHewSZBzBbLwXi3qxRQeyfVnlAxrFwQ9YWxuv/ezycG3dmqT3zY6NGpXeIepJM
	 1Y6xf6cWRyzVjQOkxl24SEepIDkimLar0BhSz5FxyQjBqWFVTNBCANKB+z+KvTD9CAa1S
	 gbVDKTcjYYLuMF/XnK3xL73+IaHt1v6+BmfTsIWihQbi/vNDt2IXUEh6mLAv0iIQR9ftp
	 I21YZSUhv3wnEvoNlvfzhOiHjVTtBcVY0Q/N/GlNi4pt5HhPsFpT4bQq5bYUKL/t5cc52
	 1OofStFNw9VHnp/59zsI4g28ki31UxyZqgrBqQ3AViNncyIO3D67Z0P/jaKK8FEkI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="M/HH+xWm";
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F6606A329
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 759F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=M/HH+xWm
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so3309643a12.0
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795531907; x=1796136707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZBHTqZxDzbzcijZrIWs3+mMMGQYVCjnLOQNQf1t4YY=;
        b=M/HH+xWmbN3Qy0qri6ajuDnpXZpU/OixSTUvv5LpHwt3RodqaBpchcP+2Rxylvvgrh
         JnCc1xhzQ5ms52pn9vTI8h1n1v1eu0eW3rU/ohr9dnsP42yovcDjwz+EqLRT7yPkiiUG
         4lF78AtFkzyqrW21PQxCaLyBniGCgYF2oKwXrL65KsWW+Ly8znDrjkhw8sODM1JjO/gT
         LP6y1CKrzKVx+6gCEMCQWfYD5QNSPPHvIecYPiEpm1p/INU3N9xLrZHqgvNd/4cRZdCj
         wrF8d6+lV7zCDK1lpi+6ItUsLfEuAa8LPVa0sHZVHImcYClQRMCUdXkP+7ID8rxoXDh/
         kNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531907; x=1796136707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZBHTqZxDzbzcijZrIWs3+mMMGQYVCjnLOQNQf1t4YY=;
        b=ZNMLyknV36nArbbtfKLEEZ4ssAE0O/krQhawwkGWwoPyk6t/dGfiXL0bopsKkh11pu
         A3ZW1h7/OpLqao/ehW/A0TpWySq4zjtWZfosQPUpFAKmlsP4Z6xvSWLR1l5VkY56BYAU
         jf0TiDbaf5YnVBfk/4KH+b0MCyEcIS/b6jkXUXQH9gaBKYPuESWzGLwjb6dkgvIauD+n
         4BnbjA+sbkg7EEyinPVA+6PDt/+xI2BbQSosjjr9akYKhSgYlLE0NGpvAtGl0HRKHAMR
         b4Bh0RNlEJZJ4pylwtWDdSYOgGXFsJdF/dP8b378xQNN83CiXBK4Uty7TQF/yMQmJjO2
         RnBA==
X-Gm-Message-State: APuU4Z9w9gtYYONWLgRh2/TSDps+oT17T4lCuurJYBL4fZKaWOvF23kZ
	0vfzD04rks3oAcItbpIOJl+eMRueq2U9Ks7PdgUlJLWyY8cMooMnmMHZI9rrOw==
X-Gm-Gg: AZFdTZdLm9yDjjDHgul+b4wL6zm5Tzzsj8BVdph+dLaSC0SARkbPo/SJvPN9DBfHSqn
	lqdwCaJyc7a07Iy2iyjpf9hF+VthaDd1+Y13c3J6EsOXnU8nyu1DqPN2JDFLENaBXaXovO4MVxc
	snCLv1m9hEnI/YxpL6rRBruCQitQKbKL7Np1WOELP8UxQ3DLil8ixsJQwrDkTCsVjel4ztJRk+v
	Bp3TCoahnAQgYJ/8J/5RY0XGyGns650Oap8Xc4U9RkrcseRcGd/mglP+G099aZVV7FXw1W91pti
	KFrbFFix/jiVbCypE7lOemMTfvDKCvriTSagEbzxYzYfLdMR8eP7KuQ9XQcIS5y2e85Fmc1qNZU
	7WhAVLbGWeBx18Yun7VEOTj97Zux9QKi4uGOaPrQmc2sDF4Hrbvm4rMX9ukIt8lKANu9yPs+BS4
	eC0szl5sp4UWA3iHZY7XwnYivvTGCeOzFtZN+kdUPWWzx5MWaDVsrX3htx5dKcZKPZrKBO3U478
	t80ZYSzvbWXAoU08BihILQ0X27MTp7hgagDmhXFTMdf0lKqpPZULKDrCl3WXl4Mr44RXR3oGHhx
	yqjTHGc8t3TJn4vTA03p2o4JjYULyOCH4vHgcX1qkdvpTsYJPWNBEWSwNdJRKMY3kovKTPvLeAW
	nm2Zoq2N5
X-Received: by 2002:a05:6402:2046:b0:6b7:e902:5dfd with SMTP id 4fb4d7f45d1cf-6ba37ed33cdmr9219329a12.41.1795531906417;
        Tue, 24 Nov 2026 06:51:46 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm6937861a12.18.2026.11.24.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:51:45 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] Cobalt build fixes for uClibc-ng
Date: Tue, 24 Nov 2026 15:51:41 +0100
Message-Id: <20261124145144.3411177-1-yegorslists@googlemail.com>
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
32-bit call for uClibc-ng and musl with 64-bit time_t. They complement
Jan's mmap() off_t fix for uClibc-ng >= 1.0.58, now in next.

Tested with Buildroot's test-pkg on next plus the series, building
Cobalt with the testsuite, RTCAN, Analogy and the pSOS and VxWorks
skins:
- armv5 uClibc-ng 1.0.59 (time64), GCC 15
- armv7 glibc 2.44, GCC 16
- aarch64 glibc 2.24, GCC 6

Without the series, the uClibc-ng build fails on __OPEN_NEEDS_MODE;
the ADJ_SETOFFSET error only showed up once that was fixed.

musl (as asked by Jan): I built Cobalt with configure and "make -k"
using the Bootlin armv7 and i686 musl 1.2.6 toolchains (GCC 15),
without Buildroot:

- Patches 1 and 3 remove the __OPEN_NEEDS_MODE and ADJ_SETOFFSET
  errors with musl as well.
- musl also defines __USE_TIME_BITS64 (in bits/alltypes.h) but not
  __TIMESIZE, so patch 2 applies just like for uClibc-ng: the vcall
  changes from __vdso_clock_gettime to __vdso_clock_gettime64. The
  time syscalls already pick the *64 variants via __USE_TIME_BITS64.
  This corrects my v1 cover letter, which claimed musl defines
  neither.

Cobalt still doesn't build with musl after this series. The remaining
errors are the same with and without it:
- <error.h> (GNU error()) is missing, used by lib/cobalt/parse_vdso.c,
  the utils and the testsuite
- off64_t and open64() are gone since musl 1.2.4 (include/cobalt/
  sys/mman.h, lib/cobalt/mmap.c, umm.c, wrappers.c)
- PTHREAD_MUTEX_ROBUST_NP (lib/cobalt/mutex.c, lib/vxworks/semLib.c)
  and PTHREAD_{RECURSIVE,ERRORCHECK}_MUTEX_INITIALIZER_NP (smokey
  posix-mutex)
- basename() without <libgen.h> in lib/boilerplate/setup.c
- __STRING in include/copperplate/traceobj.h
- the static pthread_mutexattr_[gs]etprioceiling() fallbacks in
  include/boilerplate/libc.h clash with musl's declarations

Also, musl redirects clock_gettime() and friends to __clock_gettime64
etc., just like glibc with _TIME_BITS=64. But configure only enables
cobalt-glibc-time64.wrappers for glibc >= 2.34, so with symbol wrapping
these calls would bypass libcobalt on 32-bit musl.

I can look into these separately if musl support is wanted.

Changes v1 -> v2:
- Dropped the getauxval() fallback for uClibc-ng < 1.0.43 (Jan).
- Checked the series with musl and mentioned it in the commit
  messages and comments (Jan). No functional changes.

Yegor Yefremov (3):
  lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
  lib/cobalt: Select the time64 vDSO call without __TIMESIZE
  testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing

 lib/cobalt/arch/arm/include/asm/xenomai/time.h   |  8 +++++++-
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h |  8 +++++++-
 lib/cobalt/arch/x86/include/asm/xenomai/time.h   |  8 +++++++-
 lib/cobalt/rtdm.c                                | 14 ++++++++++----
 testsuite/smokey/y2038/syscall-tests.c           |  5 +++++
 5 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.34.1

