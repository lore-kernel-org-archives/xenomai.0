Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7620B218
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636683; cv=none; b=gA0uKB17nq8iRCx0Pb5+vHa8ol9vJtQ8IhBqVwqwdwgcPDD1haVMBJ+Ww8ITYPOK9ZUTSZJ5zlJOnA6LUkfLFLPaXVblt61clzsg6VpByK42QuK3roVtGHhUgIpsekaZLbnH92L/YpwMaPheHXEmjk7KDUdKOdsFdpGe8a4OZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636683; c=relaxed/simple;
	bh=wE3cklarJF9EN1I39mt6mu6UxNtJ1Z5OTyj8SN5BRJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLp0Ttc1xddLIMu+Im/zL2erjqf5mgBL4BeX4NyW7UAvIfgkI8ZvI0WXQtIoIMkirFisYN5YESq19DWsPtz2vcovZP9G5fF7OwH7kzcStFn97xLr/viOFyH8HKrnmQGVBHX9Zt80sylGNmqCbm3vUUkPerr3EJVVwt0C6cyQExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=loi/6VUi; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="loi/6VUi"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202410110851169d4ff2623f310833d3
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 10:51:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mOs7XhGT/+1/QmCc+NWTUBfoyE4LB1/YkOtcv9ZAzhc=;
 b=loi/6VUifOcG2yfMcrY17fgeYzs68nAKdQ71ZHUBCI1N2Gw23P8nfrqqWH25vKWBCTFu+d
 gASRYlKmHJ/OC9Ozq20ClHb+ORyQp+RmX3WV4EsFEUuYITFf3womg+X2yuNtWjqP1KKbTDo+
 BmSPm3SGYTQP9xD2dpig3kiVXjvQO48omBuA+GpGHHNV5axN1mDjwnTf0P65iQDYS6z02I5J
 KFILV5PjBXkqOL2F/MERzeH50TrsdGPOrFM+ZU+R2M1/tFzGH/H/cfjhnWEH0A7C0UPNbKSP
 zAmjpkbgFdkatQC6eAnaDvc5kCx7mHHMVjLO1lpMaUDzbf85wxNvb6VA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 10:51:16 +0200
Subject: [PATCH v3 2/4] y2038: lib/cobalt: Fix link failure observed on
 Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v3-2-2657330fad19@siemens.com>
References: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
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

