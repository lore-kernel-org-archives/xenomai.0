Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BC1E8829
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599104; cv=none; b=WTULYLKIxc7qsLjH8H/DPbbt9VEJZPewl8TqM/RkVIxf13iJRVFLTNGzAdED98N84UAWsFNVYI9bVhW/Hm5CGJclN7eFdsbdOuW8QwemW2X5r+OymNQ0uueKrhQs2oExpEWLsKLM5xOvWuwGPCn/fJGxCG3NrJqQT/hmLGNOPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599104; c=relaxed/simple;
	bh=HW+O+zuQYgDG0XoZN9StLSc60kXyeYnOhPz8BmzYPvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnKeOVohw8IfIu27BMqKRFzE06uCNPT5jXlVdL6OdaPXcilPYZ//zbj1Qkc3ZpbVvlfQ8SiehqQjkiisEAQ5LWJNH0o2+BDFJixc0o00wpxiNoZEzBXJicz62LYqdWPUulHmHNL4iQakwYEXAAGlT8DoSbZX35KadOLFdMQXpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=P2k9BJkT; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="P2k9BJkT"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241010221449a1f31e2d8e0ce37d4a
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:14:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=naSJRmpTwTmshpStDvkEkyZdQ3/mdlvkOVg9Np0CfSs=;
 b=P2k9BJkTqYMFrGSFF6BEosMbHpqNotqANo8XF8O4bnDCX1mJ8PWOrkQ2uU3nGc33Eo2JYv
 dJGbU/fr3zQNTUGLI9rOvQehu4e402HnQ8X+xC5KqOlZUO+4pJewCEIItmCI0wZxcP4gpSAQ
 y0SbtzrDND1iAfnQ00t3iZr1QLBVO79X5F4fZts5ANWufrdHcUtakL7zC6J4INLhf54Q7vNW
 s4NGk5nGZJlYGMcN/RW7ItPWwWfNrLqfFcctCe0rgBRDV81XDQEPtOHKRTDLpSvDiX3dH//F
 /vWpyQjiuo/BzBKU1YqJZ4BydDK+IR9nHj/gMWKOsroKSXOmAzeoLJkQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 00:14:49 +0200
Subject: [PATCH 2/3] y2038: lib/cobalt: Fix link failure observed on Debian
 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v1-2-4b5b0078fa60@siemens.com>
References: <20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following build failure was detected on Debian sid/trixie:

/usr/bin/ld: .libs/smokey.tmp: in function `run_fpu_stress':
testsuite/smokey/fpu-stress/fpu-stress.c:84:(.text+0x51ed): undefined reference to `__real___clock_nanosleep_time64'
/usr/bin/ld: .libs/smokey.tmp: in function `run_sigdebug':
testsuite/smokey/sigdebug/sigdebug.c:281:(.text+0x1bd9d): undefined reference to `__real___nanosleep64'

The problem here is once again the changed behavior of the
__USE_TIME_BITS64 macro. Up to glibc 2.39 this was only set/defined when
building a compat application. So when time_t was "upgraded" from 4 to 8
bytes.

From glibc 2.40 onwards this macro will always be defined when time_t
is 8 bytes. So we basically run into the different code paths when
building 64 bit applications.

The reason for the linkage error is that __clock_nanosleep_time64() and
__nanosleep64() are only provided by glibc when building compat
applications.

We only have the additional time64_t wrappers for glibc in place,
so we limit the additional symbol handling to glibc as well. That allows
us to use glibc specific makros like __TIMESIZE to detect the compat
case.

Nice side effect: Should increase the support of libc implementations
where time_t is always 8 bytes, like musl.

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/wrappers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index b6416ce63..b5f4d1715 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -29,7 +29,7 @@
 	__typeof__(T) __STD(FN) I;                                             \
 	__typeof__(T) __WRAP(FN) I
 
-#if __USE_TIME_BITS64
+#if __GLIBC__ && __USE_TIME_BITS64 && __TIMESIZE == 32
 /*
  * Make __RT() and __STD() usable in combination with time64_t related services.
  */

-- 
2.39.5

