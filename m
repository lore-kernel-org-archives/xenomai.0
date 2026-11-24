Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529006;
	b=PPRW9G4M49u1qxhgqZ1eV6J90RqzOZCXNNz6styzRr5VpGjW2clHDt19XFasCKgdtwYN
	 kWtbHs3NhEW4SYNJ7qi2TK/zzh+VIcE6MzFZz/egJesOiLnIWuUdtJiAsGXkf8xdqTk+A
	 hMFSYxnOWruPyKMtcCpoNLu5Tl9gileLTrU3+wWnw5mq9WOLcxpYhVdvyWAl8tcVyTdqO
	 4KIL2uiHwCFwR14G+wtNmDBkxywEDorPLg+1ANyVwV2DypCOrqkwKcTMtYWcnQ0NTHtgc
	 auX2IL2aTOHqnXDSurMhLF4I6EVrHepdMtRZ0MpkgBZBT/mQyVbIpGREat38fFfLZWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pyDfk0vAcK0Uh6tddPJyQvjWQJxYON2wIsnt59jF8PQ=;
	b=aoAz0q2KTlbiIMFd5vhXwDYBBYZL/ttBIf5oJ8HM8jEiDnFk84XXBfYTeG7krW9TsYq8
	 hp/jtiaBeU9DYPJIGQC5Hnx23UX5Lwzhnp0/+TT7ZKFDbxpVjvP9iSzgtv/0ksNa1+1J+
	 WRtd96ujRzw+VLF762NaSf96zVg23FarKLaxV5nd24TJAYu1NmjFYeDkJApjK4xrG9LNe
	 HD6vhLe4FdNTcvkdHvXrBdKfeUtLUuZrcBPDSMQ/ZnxAH+NUOHEjWFl7oS38Txkn/li+T
	 OWv7jW/Rw01hATCD6x96/dii0L/lTNIHa68s53T/TCipLhu4fBd3UkiWwaolySfn+Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=kygIRlij;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08433606A338
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08433606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=kygIRlij
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso6384426a12.0
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795529004; x=1796133804; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pyDfk0vAcK0Uh6tddPJyQvjWQJxYON2wIsnt59jF8PQ=;
        b=kygIRlijJ1f0/rp9jXjB30+fX4B7e7kls2rFa+kzNuw1YuW3JB8mNGVCqHYT9q+s9U
         d9SwpjQIjv60CmK302uQ0y4JNgN0o+ZWqTGFvDpdf3XbEE9QIFQ21UwqUk1SAa4fH+4n
         /vUyAM0zk6p/wlqQ3jLhr7VRjzfN65+X1RikD9lbRqXdBn8EA8PHIXqZme0cbcivGr9d
         fE89W7djlqpL/Hu6GLr+HZuU1bciMxbed/EuL3DHxfpJFtcyKZytJcN8WuazXycpA/4g
         NO1+1x8vG19c4+1pB2O3xgu1Bg2ayIgiimiCl9Dswh13YMCJM9nCcrX1tyaNe6NUts7p
         9uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529004; x=1796133804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pyDfk0vAcK0Uh6tddPJyQvjWQJxYON2wIsnt59jF8PQ=;
        b=0LF99Paa5ho9lEl8ZvwYryaT2od9eenu1fol435qwiHl0VamupGdKyr2kDlddi9YxW
         Fa8MUbgzfxWhfXxyNmMl4XFoxas/IcEcgNgokPNGEH5rhsBqUXelQpGWznUgvvx0L1qZ
         mlkBxOQKY0uXvyGw2cpWLRKX/spwfK927InoBu59Z71hBS+ThjVdZ4yMgjeSAAF1yFLH
         /rTJo0SnteFzNDa4ewXZxxUF7pKPUjAfFDIfGUTYBRxuYQqI/RineU/ZOi2bMcj9On2A
         5BLOJoG6MZIY2b2Coz8lnknj4gmyssCwcyI/RC2pvIQ5DUTZie97AJA/+8CCuwBZBjQU
         ncrw==
X-Gm-Message-State: APuU4Z/rTMMUjt4mt8mayNe8x88RJIbfmcsQBjT3bsg7+4ggwLKkCYgW
	NIrdyYMxHeTX0YfzphAseq+4f5WNUX57yDu/H06JQuCsw85xFfM5kCNSbTNUgQ==
X-Gm-Gg: AZFdTZchusThONthwv8DScIV2PNHR472o45369iT9/ZGnDbxmWZpRzDC6JFY8iKnB9v
	/9dXzxYJErcbAxVtb688IgbstEQwGb94j+QPm/zGtDZxXrstTeK3ADBwM7tBTMGUP9Q3DXeg2tS
	qNzggAtQY+S8qEgoMRHvUfCWgqm9Tl8AZlU8UadEh3gKt+BAMKRa3HoruXSfkBPP/SqpO0I0FyH
	0M1SZturFvsHOWbLCXfy1bzHMcN7/B3JQ/YsphblYsje+0iL7aWYy+wnQxhRyQucP+TXZdOR17z
	A7hhNw74crrBBojrweq+R1/oeskpYwK6tloXmkj6FfQn/3WNv96O8tWlqtRHZKKvoVKaa2lh8Kh
	tubWP02WFghlbMObhe5jCo9fjkVVC+60Ou9emwhJ9Q9T7ekQCoziWcvameZpBQ6HiUteK9YIC9k
	qTBKFXqSOxmuG5UIzUowldJoGRVldQ1oFiUCx1UQYNH5uc27YiBiiTL0x+aNMjfjlNLNxXNO+oo
	QRXJTKHifRAZqEA6Jj41R+DTgn+CH1SCAze+VSzAG/CYy9Dt2zRMRH4tHgAVCHEMCNNz5i1cnrC
	Kav3+p3UIwLqv92UzhcqkvZDbLYMtGaoaHZ1zqL2Gks6FdfI5emwU6o/YRAaRHbp6zAprI8TFxj
	tLjzvLlHclyEZpFMS+vadHrb/jH3DqA==
X-Received: by 2002:a17:906:b195:b0:c4d:4be1:4197 with SMTP id a640c23a62f3a-c513aabb595mr916386266b.41.1795529004143;
        Tue, 24 Nov 2026 06:03:24 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm510486566b.0.2026.11.24.06.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:03:11 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/4] lib/cobalt: Select the time64 vDSO call without __TIMESIZE
Date: Tue, 24 Nov 2026 15:03:02 +0100
Message-Id: <20261124140303.3336015-4-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124140303.3336015-1-yegorslists@googlemail.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
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

The clock_gettime() vcall is chosen by checking for __TIMESIZE == 32,
which only glibc defines. uClibc-ng built with time64 support
(__UCLIBC_USE_TIME64__, as e.g. Buildroot builds it) defines
__USE_TIME_BITS64 and uses a 64-bit time_t on 32-bit targets, but has no
__TIMESIZE. libcobalt then picks __vdso_clock_gettime, which fills in a
32-bit struct timespec: the seconds and nanoseconds both end up in the
64-bit tv_sec of the caller, and tv_nsec is left untouched.

Fall back to the size of long if __TIMESIZE is not defined. Nothing
changes for glibc, and on 64-bit targets.

Fixes: fb112c2fdc69 ("y2038: lib/cobalt: Switch vdso to gettime64")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 lib/cobalt/arch/arm/include/asm/xenomai/time.h   | 8 +++++++-
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h | 8 +++++++-
 lib/cobalt/arch/x86/include/asm/xenomai/time.h   | 8 +++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
index c260acf46..3bdd6fcd5 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng), so fall back to the
+ * word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
index 06992e709..7eeae991c 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng), so fall back to the
+ * word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
index 36e027329..4febcf45e 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng), so fall back to the
+ * word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
-- 
2.34.1

