Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE46804
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653877; cv=none; b=cfuCsqCN/vM8ozDMEToa5nFzFe+GleAikhO+HTz+hDEu9K3DwCuDnf3qh96ohh+7V/CAhDZgB/JVoRjbtK/lhj9GUpbY1oySqAJPGXszOpyVSkzicmeUg/4JASLG1zNqutYOI+YaAXQLSoXOvIY5qgw/0MhNpwiQ4wgG2JKDTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653877; c=relaxed/simple;
	bh=sjoqMIxflRDM8vBfxZGFamQwmX4hukmHRWbNbQM/51I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p99hSE6Y6m2SBaMUUZgCerOGbOzzTPB/8YRpCpBSi9qfDmhY6ZjMFqFBe5A2x1g3m81CwpNc5ERWLUMkSwly9k2yQS1lPsQ7wxjeKQ9LqF5gSiqramRiTffwPAtWW1HQszdTl87/FRw0a5IT6wNm5olMIBmkq+cESxlL92M8UvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mEIprmzC; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mEIprmzC"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024101113375069c154e474bd19774a
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WwDQTTf6pgkUzmMModHEwGBUlwbuU/FENZbJjzLrTTA=;
 b=mEIprmzCYkkVhnC8itwv2PZGTVFu6X5gG+F2iQtjiMp4uELRQGS5a/y+usJta906Cemog/
 mH++L0oIEI2FkfK4b7fYoh65vMycDU2BnNFWcBBe4Pm/RQWTf3+WNalIzxXLzMqh5Fx/ChnY
 OhbhuI0C/RCs5zZcgdFymPr8wmnRvd3aR9M2wABySsP8Vnu9OafvYDFsbLTzz2PXH+wjapga
 vNuexihtndZiDrkM3S7vfQx1sL6AbExgAAX7a/abMAEKRn5bVCjNrV0j0wM36Couh1w+a83M
 hzVU6CTEhfCBxEOFwlyXQSyQ6jMm7+jl4SxvaXjS548UctQOVcVT/EDA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 15:37:49 +0200
Subject: [PATCH v4 1/4] y2038: lib/cobalt: select: Fix compile failure
 observed on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-flo-cleanup-y2038-v4-1-788b3a4bf3cc@siemens.com>
References: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following build failure was detected on Debian sid/trixie:

select.c: In function ‘do_select’:
select.c:55:23: error: implicit declaration of function ‘__real___select64’; did you mean ‘__real_select’? [-Wimplicit-function-declaration]
   55 |                 err = __STD(__select64(__nfds, __readfds, __writefds,
      |                       ^~~~~

The problem here is now the changed behavior of the __USE_TIME_BITS64
macro. Up to glibc 2.39 this was only set/defined when building a
compat application. So when time_t was "upgraded" from 4 to 8 bytes.

From glibc 2.40 onwards this macro will always be defined when time_t
is 8 bytes. So we basically run into the different code paths when
building 64 bit applications.

For the compat case we were missing the proper prototype produced
by COBALT_DECL_TIME64. The macro has been updated to address this
issue.

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/wrappers.h | 1 +
 lib/cobalt/select.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 4fcb1c3b9..b6416ce63 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -38,6 +38,7 @@
 		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
 	COBALT_IMPL(T, FN, I)
 #define COBALT_DECL_TIME64(T, FN, A, I)                                        \
+	__typeof__(T) __STD(A) I;                                              \
 	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
 	COBALT_DECL(T, FN, I)
 #else
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 9577fa256..be8cf34b2 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -21,7 +21,7 @@
 #include <sys/select.h>
 #include <asm/xenomai/syscall.h>
 
-#if __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 /*
  * The time64 wrapper for select() is a little different:
  * There is no y2038 safe syscall for select() itself, but we have pselect()

-- 
2.39.5

