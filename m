Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C347D1
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:31:00 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023092713504110950fb9e8741593d1
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s+IiZnUuzePDbtclpmfq9VkJxblCw5Pt0izIH4+W3XU=;
 b=AjUV+KqMizcpTZLfXW19vfIZB0QYYokKXQPrU0hdCvYM+bFUvlgKKWgGawyucsDZTHBj2i
 rJ8I3uSGFz1klOYOj1eQq4pl2Vo9BAOY8MkEyypokpI6pbfqqaO+LP2jAKt0c0Ru0d1aziYN
 tRSqtXYQTK943XcvGPH0X38orvOu4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:15 +0200
Subject: [PATCH v2 2/9] y2038: lib/cobalt: Switch vdso to gettime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-2-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case y2038 support was requested we have to switch to the gettime64
variant of the vdso interface.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/arm/include/asm/xenomai/time.h   | 5 +++++
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h | 5 +++++
 lib/cobalt/arch/x86/include/asm/xenomai/time.h   | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
index 34df7e9df..1b4947b2d 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
@@ -11,6 +11,11 @@
 #define _LIB_COBALT_ARM_TIME_H
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
+
+#ifdef __USE_TIME_BITS64
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
+#else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
+#endif
 
 #endif /* !_LIB_COBALT_ARM_TIME_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
index d0dad6d88..9577aa773 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
@@ -11,6 +11,11 @@
 #define _LIB_COBALT_ARM64_TIME_H
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
+
+#ifdef __USE_TIME_BITS64
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
+#else
 #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
+#endif
 
 #endif /* !_LIB_COBALT_ARM64_TIME_H */
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
index 693be8736..18eb76697 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -11,6 +11,11 @@
 #define _LIB_COBALT_X86_TIME_H
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
+
+#ifdef __USE_TIME_BITS64
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
+#else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
+#endif
 
 #endif /* !_LIB_COBALT_X86_TIME_H */

-- 
2.39.2

