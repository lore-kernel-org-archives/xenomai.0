Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531910;
	b=YL1rSKl9L56rvcEH9AB72wwAtt93iCuWA62ujW0mVjdbYEuATOmjWKQ0Zv5R5gcP+Swj
	 FMaUDntYC2m35IZVLvwdaGFGXwtNdEqWV5+gIy9q9NPxO4U5maqH71oPJf+K09ZTMxW4S
	 C39Vyz5mSppO8VfWMoedzs4Ovt4x0Q6e3JzbUDGAn3bFU5RhQN+pY+3Woyvny6qRPL76b
	 twSx1MI/OftwLhb7kaacDVquSPIM4LmXGtPQc/TQvmynp+PtSC5v9TW0GmISOBHKdsvzv
	 meeVGQlZ6l9gWg0AUFSz0jK09QaxWp50Rg7RMzgWsBhIO8kL4NXC6ACHRG/k1U8Hwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BvdMybXpVDbNm7Nq4/RGkosTbWPNsmemJDVrhwb859g=;
	b=zPNaNxfCECfxN+FBGGu4IUzm6xdBI9oWRaLohRhMJOFiDVguuLPcYVPynG36b744ISYz
	 TcM+gvRMNiLqNyPdEE+KAsXw8raJuA8Y+huApE8FBwMGtbIDeORwIyqaFODS0eyfXdDap
	 QwtsohDVsvnXk/DK9kupo7IiVSGyCbH4DZUo6BFxBfYxHkS17jzg1SdHiGqUEK6UuN1mj
	 BUiK9UjdKqiC9k/Sotf6YrmPAYmqKRbsDxl5P45dBtFJz/Obf12cwJ9UEhEoOqGd7/Hcx
	 IKXcOwOYahkNQfrinrtyr4R+B4qNi3mZAFkEPsM4anY5DLRXjfD3p+V0GM02mAEdIIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=SbUvpUn4;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9B606A331
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A9B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=SbUvpUn4
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so6881585a12.2
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795531908; x=1796136708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BvdMybXpVDbNm7Nq4/RGkosTbWPNsmemJDVrhwb859g=;
        b=SbUvpUn40GRokvMtzhX07WMtowW+dsHVhR9pE1II8CltwW2QAW2cAoiFSYMvnGfmFP
         Ws/29UiYQT9X+RgcJocPCCSd1B0z5UpZCUOOH4/msDKEBP2mxvhyewsMLG0SJBmNUg0o
         dRpENVDhtRL9gOAlYDcrHq+VzHsGSeL8uuwuWhYMFsyc4DsSWdaYMqRdH2PP9vabFn8J
         pL+MV1JS5nwDDj/MTd6u92GGZyhv0KGCw4x/a5jsNn7XRMRbd52A1i4EdBEJNITb+DAY
         EMajsie9QxkLXwl9ae44wjje4a4t425t+Aw54hLM5c035jzpFnooE6OjXLETcApGM656
         qTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531908; x=1796136708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BvdMybXpVDbNm7Nq4/RGkosTbWPNsmemJDVrhwb859g=;
        b=yqJOhksG/1X8fixnBs+/WoEWyhzHgPD4F8N29abHGXQxSUOm++SOGv969lLDI3deN5
         BOgKlWqMnijuV49jBE5wrEgjQA8/iBRueVv5F2viZH+odQ5K/ag2hqN9QTg5sICW9eBb
         eS6nev+sq/aSQubyClbxpV1957rpX3q21NNWW35H22KS6LDKpc+Gq4QjWoun+eX94/Yg
         ls4vv3cvAG2TWKNs2lqLjovUptcucyloWCzwaOcTUu90TjTREyJcQpC9kHaL56EZfpQm
         FqL3DyCb7pq7e+8QF8lVC36TBBhm86IeT23C2ZkV1wQh8tuTCa4uiVlTiPs3ptBX2JCs
         gbPA==
X-Gm-Message-State: APuU4Z/wejIUYQTHOT8v9JfbipW1eQObhhc3qjuCvdrXFg+QwgbI3AMe
	Y9DtRuvtSkqxCj+1VoX8VtdCyr5kqrOb2FqUPHFmtRDqADdNM5rJtyFC6saKxA==
X-Gm-Gg: AZFdTZcoyUrFcMEgr2RRSpwJfuctDfD18Kz61s5Y9Ot1y2KpiSM2jvo+T7cAJhPk6u1
	wV2WL6MwAwe2edvGPUE3qE1w2h0jP0KfhQkFF6Hs2aeFN5m2iLpazamWfb6B4kiRWLNPpUS4/qL
	TfWBaA8sJwlZ5oYY67OjDk0q2D/uScFUh7XOqe5xUjvLOEeZgYs42sEZGw/dU8LPO+9O/RvujPO
	NOZIx+9swZKxkxLMZzaW5If6d0bq6NUtqb8cCAfmgSBn/eHAWh2exnQLFvf4zvlYFCfMFDGoul3
	S1X8mKWujv3L7fRpZ/Jimp/4hvWXjismccC84zmu8n5735U9EUtIkJ/YG+GXh7N0qOQ4E9T5pak
	SyShs89xPTUZy3yBaQNMG+ZxsQq4lsjDAOQ0WXhTB/3l1ENe7n0TJhS/vWZiUO6vj1dcvvbSCbW
	oZtf4WeP3GfF2MoaINaCpGeMBzFg0uj/LtWK/vr4GyxK1HvLaAII5DtRFeP/dLPWb5Fd6hJv2hA
	IjleFpbxe8gbuhkP5LIr+gW5jEO6hMuqenrKxah9MVdcvDS3ns1yinkyBk92DrN0C/4DuBkTI4V
	FGuOiNzpsIt8sgoJslHQmW9PRlKlblncVLHB4UuC4PnV1eDbSwGkBYMf5rG1HNdI180NN4BU0PY
	r2xHgQSsG
X-Received: by 2002:a05:6402:1cc7:b0:6b7:bffa:6f24 with SMTP id 4fb4d7f45d1cf-6ba37ac5eb3mr10171954a12.0.1795531908208;
        Tue, 24 Nov 2026 06:51:48 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm6937861a12.18.2026.11.24.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:51:47 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/3] lib/cobalt: Select the time64 vDSO call without __TIMESIZE
Date: Tue, 24 Nov 2026 15:51:43 +0100
Message-Id: <20261124145144.3411177-3-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124145144.3411177-1-yegorslists@googlemail.com>
References: <20261124145144.3411177-1-yegorslists@googlemail.com>
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
(__UCLIBC_USE_TIME64__, as e.g. Buildroot builds it) and musl >= 1.2
define __USE_TIME_BITS64 and use a 64-bit time_t on 32-bit targets, but
have no __TIMESIZE. libcobalt then picks __vdso_clock_gettime, which
fills in a 32-bit struct timespec: the seconds and nanoseconds both end
up in the 64-bit tv_sec of the caller, and tv_nsec is left untouched.

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
index c260acf46..014668b6e 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall back
+ * to the word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
index 06992e709..d6c5880e0 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall back
+ * to the word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
index 36e027329..91993d99f 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -12,7 +12,13 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#if __USE_TIME_BITS64 && __TIMESIZE == 32
+/*
+ * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. Not
+ * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall back
+ * to the word size.
+ */
+#if __USE_TIME_BITS64 &&						\
+	(__TIMESIZE == 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ == 4))
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
-- 
2.34.1

