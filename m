Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80AEED8
	for <xenomai@lists.linux.dev>; Sat,  5 Jul 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723786; cv=none; b=MgdYLri+qujmPm5q/456XuxKUboWeztdCVXtS1r07jVSOJIu169y36MhTeCJdtsHAUsGRDLvyi59u9mpRdg7ttPmhmBgZ7wNGpxjIAngN7DKyhnzBpxWIFgCk9FqnCwng6g2GATO/XP4UmLOrDugDGOr+vKGaNHMXaEhqjTQM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723786; c=relaxed/simple;
	bh=wNBCqn5npacr2a0vCXwHZ+vHjfCEpWrKtbdcxg6C75M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5ybuYG2raXp9VDpza4uPU6egq9I88UJ8fbELkDpn4BOW/zf+Zlspnn9AI+0/lzF9y1qGWeG6qYChsY6RULPZ/Q8hnlV8qnkOTpHoZYwddaJzy5tZR2SJvxOalHqeC8NU3c0n0Jp+BWGLKIf82uvsBGTOm/yc8E8fxS+95NILxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E2Vs6o2J; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E2Vs6o2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZG
	kWqaK15IFNEZq6pDP4Y2gzXEs7DTAlaJqg9BGy2hc=; b=E2Vs6o2JwSBPxf86mO
	jzXPCS66tFHzE3IlwLpQ8aqBgBq+hqvddSBiK28eiN4FI3tbZD5EwMcNk0HgO5ZF
	2VPIqbNWgaHuCvwGY/Lx8GzOxEhugxSaMy3Fg4xDY3mV7gFjcI1SetUXfYaknvAg
	zA3+zf1rKEVll7fzqukJrvu3E=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P838LmloZYkWCw--.22850S2;
	Sat, 05 Jul 2025 21:56:13 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] boilerplate: Replace strncpy with snprintf in ancillaries.h
Date: Sat,  5 Jul 2025 21:56:10 +0800
Message-Id: <20250705135610.217774-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P838LmloZYkWCw--.22850S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryUZr4rGFWkCF15tF4DXFb_yoW5Jw13p3
	Zxtr4vy3y8Jry5Gw1a9F1Sv345Wa93G343Ca4UGw1kAr12yFyjv3Zakry8uas7XrWUtw4F
	kFyUKa4rJr18uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_HUhUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBaBcWhpIwK8cgAAsU

When configure with --enable-registry, it fails to build regd/fs-common.c
caused by strncpy. Using snprintf instead of strncpy ensures that
the destination buffer is always null-terminated, preventing potential
buffer overflow issues and compilation error.

$ ./configure \
--host=aarch64-linux-gnu \
--build=aarch64-linux-gnu \
--enable-smp \
--enable-pshared \
--enable-registry \
--with-core=cobalt \
CC=aarch64-linux-gnu-gcc \
LD=aarch64-linux-gnu-ld \
CFLAGS="-march=armv8-a" \
LDFLAGS="-march=armv8-a"

$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.5 LTS"

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

The output of build error:

make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/copperplate/regd'
  CC       regd.o
  CC       fs-common.o
  CC       fs-cobalt.o
In file included from /usr/include/string.h:535,
                 from /root/xenomai-next/xenomai-next/include/copperplate/heapobj.h:24,
                 from /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:27:
In function 'strncpy',
    inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copperplate/regd/fs-common.c:248:3:
/usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__builtin_strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Werror=stringop-truncation]
   95 |   return __builtin___strncpy_chk (__dest, __src, __len,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   96 |                                   __glibc_objsize (__dest));
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 include/boilerplate/ancillaries.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
index c8c209deb..8de353ce8 100644
--- a/include/boilerplate/ancillaries.h
+++ b/include/boilerplate/ancillaries.h
@@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(void);
 	({								\
 		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
 			__namecpy_requires_character_array_as_destination();	\
-		strncpy((__dst), __src, sizeof(__dst));			\
-		__dst[sizeof(__dst) - 1] = '\0';			\
+		snprintf((__dst), sizeof(__dst), "%s", (__src));	\
 		__dst;							\
 	 })
 
-- 
2.34.1

