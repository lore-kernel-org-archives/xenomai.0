Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47622CF12
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777410; cv=none; b=oXz3vcZnKvY3TZ+T7X6BsDZNrTrqXw0Tv0MEVwu7WH0wlhiCM2Q8yRI2UceUhp/znQ3jx6kHLvcjN8LJ4scsRPS8SRJ2apig5qdhYJKL4faJrHs+Rtl1P7LpRJm88QrWQQoEJSDbCBrAOiHmUyc0/dE1PgWbzgfmiiOpQG/ZiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777410; c=relaxed/simple;
	bh=6z7oHzEmWxqRsbNZ9Fv4IGTNz4Czwkbi4dJ8l2R/430=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UWnMLhmR2kdgZWczi31NgSJU9IZLk/9rbGwREIXTMqgPJnOJVA9ry2AQH4gN1OWBikwoT8mBETDDdJ75NocwMZp6e9Tc5TvclqEW4Z5kx10POe2uzgn21ZFPYy9zeA3lNcIRnWFxW0y/vKQT2QLmbsomoX8Es266R528dlCaOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=TDC7Y0lM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="TDC7Y0lM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385dc85496dso207581f8f.3
        for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736777406; x=1737382206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3FoIxr6vfGVFwoBS31uoCGWrizamPPY+XIOPFcPTes=;
        b=TDC7Y0lM9dGgNvLh4QVYsj5E9+Pj4szG3LvVQkRiVNFPMNWgZmR+rUXxKBcvl4Og2A
         7p2wg+OdhscMzBatzohXcmG6SAeLqPSSSJ7QFRV4S3AguRfzj5h90XS0fEpGuWgtRJpY
         lvNAlyTu8gANHwCL5m1pFm0fA/Yl+APAzJO0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777406; x=1737382206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3FoIxr6vfGVFwoBS31uoCGWrizamPPY+XIOPFcPTes=;
        b=OAqU+WFpi5Jj9PUyK29ZZ6OXgz3p6MIzOW2yI6lijQSQ2MI3OiCIxRnmvEY9KnHJD5
         5hlyG3d/Y+Ub5s+oxk+acQjuOzKQlL8iRPa5G2YgZXX2RN763Da44nfSJ98jArEdUgZz
         rbPRmLufUKSWeZ7phq2K+3+k24maL0wobhi6gkBD9z4G5FiHfnCR0WWTA4IW6NZsGr8n
         VjdtzOv5yerSGRYRf8zuLI+OL+hP1Ua0/tLW57u1WnyQVleUYslttJRDA5Sgf+HVIkB9
         I63oEhaoIE/PlBz7hx9RWfGbZCZv4q45NLKu6hK0/Fcu8aiiEGR0K6FcHduBwD6h3c2Q
         vKCg==
X-Gm-Message-State: AOJu0YzgdT1WpkE0B9SLD2feBJV65FetOKJ4HgXY5fzXfgAiHD/7RtUm
	BWnddAa53I/5AEi3kQcMKrNmiKJYvC/0rsfhljq3CtiFa9M3drxX2nzPgC6lCWMs+2hs/2QAdI3
	I
X-Gm-Gg: ASbGncsq7zEF1HDk9PZvXJiDjyd+bkZBnOfmOIWXwxyP+DgHBhdcEhVkywMZ5WIST7M
	LaSBp62lajGRPzAIxkmIhBv7jiu/x37JAyIm/PKD9ibONJj0jpzZHXwQ+lRwewEMCbp44yV08Wr
	E/wLBZNlwYiUvfWU82VfXYuN3DL968cruSZeQw1hQh15/JS5TINF1F+D6lQjyz/iTIKs6DGhGx9
	ugtCqCKSLXlsz0JOA2kfVclyiylshr+ZJJ7EK++db9xgbWYoYAqriK3Vky3KXD/fTqODUsX6+ew
	m6zvLSo+jqLrs7AM/GqpYaXCDh8wsweq/L9erO8AKOxyN7oqFIrkJsLKF+M=
X-Google-Smtp-Source: AGHT+IGq0lEmbuJX/ahyk9rImdNVcScTlCgwlAOZKuc8F3DMccgeSAt7pg6vZezwRKRZOgtY8EV5bQ==
X-Received: by 2002:a05:6000:2aa:b0:385:e10a:4d9f with SMTP id ffacd0b85a97d-38a87088249mr6779839f8f.0.1736777406073;
        Mon, 13 Jan 2025 06:10:06 -0800 (PST)
Received: from P-ASN-MORITO.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80b2sm12106104f8f.80.2025.01.13.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:10:05 -0800 (PST)
From: =?UTF-8?q?L=C3=A9o=20BRIAND?= <leo.briand@smile.fr>
To: xenomai@lists.linux.dev
Cc: =?UTF-8?q?L=C3=A9o=20BRIAND?= <leo.briand@smile.fr>
Subject: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on arm/arm64
Date: Mon, 13 Jan 2025 15:10:03 +0100
Message-Id: <20250113141003.3146947-1-leo.briand@smile.fr>
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

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
index 1b4947b2d..c260acf46 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
@@ -12,7 +12,7 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#ifdef __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
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

