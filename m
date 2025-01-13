Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7822CF31
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775696; cv=none; b=AcrE23m9M6+wm2NBLbaj5DPS9i/wesxUtDvIGLOiwdQZLmanDZt0dmhJh4udiMabG6HqBNoyig7bNOpw+TryvG4RyEFHKg5Zq2Mmjt0u8oatl1I2QtfT48PPkA4SHgrSKDyycRf+SwM1avNULlgI4EdijuBfNUUxEYQwSt2orfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775696; c=relaxed/simple;
	bh=gT5f78haOTxDIb1yFDXyojYqOiOlE659KFY8aqKeiYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T+0Ix65gidbsFScD84Qd1tsxhnYLIrAIeYZ3XkXSQXGNTmVRHR+ILH0u+yJJNIWuE0fHDv1BvPHSmpSDD9h5OpxT/E3U0oGzq7NXzFfpRWJRKVy0fGTwXk6e9cX8P6I0wdyJCEtgFnPGSX50gmtACud0vFcPYQ0mNH37pEIhzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=xxzYagGo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="xxzYagGo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43616bf3358so5509605e9.3
        for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736775691; x=1737380491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7024GsBRJyyEENABbOJKs/2vJHwmGK7WrBEUx1pe1O0=;
        b=xxzYagGovoDj+0dX3gB3XmRfCaGfvYFR/6GdVzo//qqTOQoS8W4vo6ugQTm6txf2jB
         47uOZg0+VVz4C4b3I20qPujY/9v/oF0TCI669BUHJfeQBgnaEKh+D+PLXbp7dnL48jlh
         kIIuuu0fLTMa0FCp2GKIMqd2c4O5LFDwlYag0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775691; x=1737380491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7024GsBRJyyEENABbOJKs/2vJHwmGK7WrBEUx1pe1O0=;
        b=F7pojosmWLDutJW0NOd56s+xVuSN8axQFSmqV+pr0D8DV5HtxYODPxotgr1GUmTsMJ
         Jgiv2mURLjOl03oiPVWy4c7MjJM9SgMQcfIM54wiFG2MbVMuNpsolZE5tC1nD1250g7S
         epNmDoDBPsV+WSTs1vXxAfBrIf5QcpynGPtmS4WdGyhF65tA5TteKhIbv0QlreXMXcSd
         cTBulJUNMlBb4KJl2lgJ5qsZSJmiznm8Xrb06DYnep4y9RA0czvTN+fmGHk+w8EKByXj
         4fAHYyMGZcNPzmyom8WSINqRGyT6hv6rdlS8yxJpugvzKt5You3zqwwf/JlFQhxxui51
         8bSg==
X-Gm-Message-State: AOJu0YxmDlieDcFXNX9NpRHHpiDg2ZpBSDck8AXg60j3K9e4p4ZaK8zL
	JU3NztVVQC2V2+YNqo0UokXA5A6ywpT4KBi7zSmByIAIo6I7SRDqVI81WG9bUG62riGL4TXdIIy
	N
X-Gm-Gg: ASbGncsLMS+7//LMkdaT/Y7wvF92j0cUlQjycYfb1f8B4jB9waLwM6mwRVZuiJtsoYj
	TtOps5v/FAtBEmSLY3JMoKb9PvMLAbPIRJPmlb0s+NJleFsUoDe06an7rb/t1OnhYUcbtF6RILg
	mn8wHBHBu+m8g9jIojVb0tRaflH4Iu/XvDV4c1+GESPFEbrPIUXNy6abcNtzI7OQMbRxAexAPbJ
	WpjK/E1XalgrJXNmoTFzPNpk4M4nB5cbD4bPC8lYZCctCJtw62EboIpvg3eobXsWNfjqKGHDoYz
	fSYvUUDE8OLm1U+qx7itz8qWRqFSa+u/MRa9Xc4ewgh4dOObW7bhd5pXHVk=
X-Google-Smtp-Source: AGHT+IFM+KsBdL+KBfDM8K7AWs1Iz1aHirxs3mI63HsmKsCTl+GV/JX1d8Gt8uSeVz8jp3iZvf0xGg==
X-Received: by 2002:a05:600c:4455:b0:434:f9c1:a5b1 with SMTP id 5b1f17b1804b1-436e269968amr77172055e9.3.1736775690827;
        Mon, 13 Jan 2025 05:41:30 -0800 (PST)
Received: from P-ASN-MORITO.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8faa5sm145836995e9.1.2025.01.13.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 05:41:30 -0800 (PST)
From: =?UTF-8?q?L=C3=A9o=20BRIAND?= <leo.briand@smile.fr>
To: xenomai@lists.linux.dev
Cc: =?UTF-8?q?L=C3=A9o=20BRIAND?= <leo.briand@smile.fr>
Subject: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on arm64
Date: Mon, 13 Jan 2025 14:41:28 +0100
Message-Id: <20250113134128.3132911-1-leo.briand@smile.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Issue:  Runtime error on arm64 application:

        root@ls1046ardb:~# latency
        latency: __vdso_clock_gettime64 not found in vDSO: No such file or directory

Reason: Due to changed __USE_TIME_BITS64 behavior the vDSO init fails.

Fix: Adjust the vDSO configuration to correctly handle the selection of
`__vdso_clock_gettime64` or `__kernel_clock_gettime` depending on the environment.

Impact: Resolves runtime errors on ARM64 platforms caused by incorrect vDSO function
selection, ensuring compatibility with 64-bit and compatibility tasks.

Signed-off-by: Léo BRIAND <leo.briand@smile.fr>
---
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
index 9577aa773..06992e709 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
@@ -12,7 +12,7 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
 
-#ifdef __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
-- 
2.34.1

