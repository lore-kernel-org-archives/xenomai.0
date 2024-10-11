Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496E1D52B
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653877; cv=none; b=ATpiixIhI+7pEPQ9ElhiRg0sqVCLIeIgS5nl+R2QJ87UQmLg4BBR3ALPl8Z47Eq1rtYjE86jftsu99eYj3YQL4LanHrl2u9D4yve0YpjRoYojW9jtIpKYcFCdpHUw7d2ubFB8Ci6DLkmdSP/40Wnv4WZnsnjY0EB8z1L1SDNgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653877; c=relaxed/simple;
	bh=5WX8ZFAWcWA17Ezuu4OfEo7jzHe1bDaLBERSUIeJCZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EK0JLoKoIoMNUQRq5DNSqnwcV3zeJIn9gOxQ/x8ZxL9NKqyKi70qFsuz49qAYD8cqKRM5meY+XaRbdlfhgNrLfR++Fjp0SUFTjyzkl+8igBZnMDhQmQZUgd5xc6ANXwH01NR59eg//eFoKaiCuWTN2keuJMTrPR0CQfQcCV8/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CDz6aAY5; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CDz6aAY5"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202410111337503e6cd61626d05f7547
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cMni/QZKMzI2i1SNPUvHTFisQcRxnEeJhH8BwyrnKdI=;
 b=CDz6aAY58q0ue8uny8OIpvwhCdzwvtlB5x6wFFx2blw9X/FJF1yM8uFGP6sViUPJUxZBWZ
 GAgpTbroKY11fBiQ/ktOmU1tv8zmeuak6oMfWjS9EGEz5PZczKPGt5rDTbtMWQZ4QaNIipbJ
 9fYI3rVgyHCLR1Bo1PwHM12UNzb1H+256MpnZtbO0GKLrJfUStHpkitkGDCKrQtdQ9kkkE9h
 XO9s3rY/hHgVsl8zD0nRCSQv6Y81RPEiofBMuaHRlj3gGZajXNwFfLrOUwB7yGHgWSYiELyn
 utI+AdTgOwN7iZf2dyKOGOBNK/GJ9d3PW89x/EwIaMhQNoAha8ZR6uCQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 15:37:50 +0200
Subject: [PATCH v4 2/4] y2038: lib/cobalt: Fix link failure observed on
 Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v4-2-788b3a4bf3cc@siemens.com>
References: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
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

The glibc commit that changed the behavior can be found at [1].

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9;hp=a0698a5e92ceeed3409d28623b1d599da6bc887d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/wrappers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index b6416ce63..a5645a1d4 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -29,7 +29,7 @@
 	__typeof__(T) __STD(FN) I;                                             \
 	__typeof__(T) __WRAP(FN) I
 
-#if __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 /*
  * Make __RT() and __STD() usable in combination with time64_t related services.
  */

-- 
2.39.5

