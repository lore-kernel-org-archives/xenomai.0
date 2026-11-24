Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531910;
	b=LqsggWgDR6DnDd1U7r5lKQAY6dAjOBiWUqv4aw8EPth+W+bL97K+FRz6CgTih0EXHoCA
	 +AWTMRcVeYWcqp0JtpfRVEnGlvG+2AqxaGNMyjQ90lzcBaRmEFoguomCkLLUzgCo/N8WY
	 IyKiFhAbcF7enjGVRqx7zDLDo6KTVP2WFTzjX0S6spNIvNzSHawLNfgxpC6XCqI3HxnEf
	 sGXWNh+Cq3+4aisrzzVKdEElm7VE8fURJC1v3qzoatodRvAtnmzy6ppIdOP/1QKR2rq3i
	 hAvJ3Y6m050/rgXBN6kl2RhlqyLFJFhAOijf9PvSwZomM1DDuIiV+36pZpk4n/j30kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BNBl41T24axJj+7RGimeQQqyb/HDH8u6of9d4xxwWqk=;
	b=QqflFE4CWL3NMJ+GWhi0aMi4GZS/OcFHfYSPAXE1p9Y+4OQnXl/e4IwQT1gSXKSbAVox
	 1mE1lCrfu3zf2K6eV5i+ruP5B2c/8A2JpSnrOOWeQG7jyP/vJXiihXYy8wY4pSnbCI6XZ
	 T/14l6Z2BiGwYLKEX1OvI8Im98SpK3mnPmRjiAs34AgtpNdf8f3WCQ8BDvjMkol/EemM2
	 4qgduldWcyWbYBtqnU52eiQxBbueqpvhp0ZMR3o9T53FjFSehWDGzdEAWKwG6+euD5KhI
	 7rpX4VRC1kY+dOmqlF1sZtnvjN/qlsBQtmXCxgiHtE0cSAI4H0sApA9IftyIa10jHKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KfU9SjLU;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63743606A32D
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63743606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KfU9SjLU
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso5369814a12.2
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795531909; x=1796136709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BNBl41T24axJj+7RGimeQQqyb/HDH8u6of9d4xxwWqk=;
        b=KfU9SjLUcxwbv6iOCjHyI8SgGZeI5QeQdxlT7f5QmDPWj0SDUyjtTPmr4ypH2pZkzA
         SE3U6aw6eYyMfjreoz7RUUHOrSejzLG5FizSlyJutJSspP0HczVseNBLTdE0HMuUeqRf
         fVSYy94LOuHVk696562BCKDKbMZrJUg9hRyQcuEARO99Udl5rukyHajZL1+iz3668T9o
         ri5dpzoVExXVLKMb32bZh3sU1y5N+pzNlOoxWmDpvo+yCGwgrrBhcOaSS9+6+cpf7TnR
         zwRPcxOQSHHd6SiRfM7pkbLSz960vzg6fosZ0amlvKSxsMOmmteY9htD9nvlF5ITXBx6
         RqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531909; x=1796136709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNBl41T24axJj+7RGimeQQqyb/HDH8u6of9d4xxwWqk=;
        b=AleITrE3C5gdrslKtmCeMVLvKkTMsVTxlVbAWzgOXx0/XJ5QY5LjxX7IqZ4XfVRP7c
         9wMctD7hSUeLzNnAw04AQ/k7Lg1MA05tFX4fk5rErtzj03wF9Ruj1wnduWYHEtnzSM8o
         XU9sRyPdb8ZnV3ZMxJXuSGECM1GMbF1551giONnaBQkq7SKAVCz5ejh5SU+QVfDcx5Wk
         c+ghi3pmiFj8ave8JbL0IVlN7ayGAI2wQXFUhIt0INPyFq0btL1JClOe3cQGl6FYMAw5
         8uffF9DnnQ1/+ng/YzCL8RMVvHIQ/XuTXBql7i9NKlPao9FJDjgmEYm4mMnYE3ZcSrZM
         pvOg==
X-Gm-Message-State: APuU4Z9zgdPCJLpM2ElY40Y7aDOuTpOYDHbM3zxLfHCYaMOt0EAOuafI
	CJV+5nObz29vNvZ/AYyUSKY3t+VePtzm3UqRm1+0DHQ13mn3Ek52BDJLSxWh/A==
X-Gm-Gg: AZFdTZeoRUjabJvThwrVt8OIdBf242XUkn2uUv7xjjXa2Eh92wLR0k9SaMEnDeMFu9b
	x74B1s2WzR4rbBpE5WWQUzHWsJGDn+db5QTrK+wdexrBdnIE3EkJpGVhxELMbtliRhNr9bzKhTe
	gHHaCnt4AqNHxz0QaeZbieHY4Q9006qqfvaFkSvVrvltZR4VCMgTrAI0/Z3T+j4D2bB5aJy5ALT
	Jx6mQCbdYuCp1qPQFH1trW6lYSpYMBzMiWpPJ/CZJhib8ocM1iRlAHcGcQogSFhaTDl5BpPbqt7
	eAyEU8+hXhYBisUI+1OVKooMUHf9s2K8hNyInIU/SwNnx4mSgHNm8icRUrqCXvjoGHxNpNs0qdE
	y3yeQrIjsQlEzdxi6NUVM13mAOV+cNJJ9lQIGlEw+uqnCPCFp++Pbop7KqIOjHpbHxdYxnYuBOo
	InzcN20JPowzaIkPU7o9l32CIbs1GiGOeLsLlw9qGTItiylN3kWsS4NVzKJ1X8pmvPQsXFVNUz0
	YjueuQ4CSXHMYmB5f9lCkXfL0shsFDhVbsYlc2bCa3anborUT3+FW8RzdYgCnAZjWG7NhTXR+HQ
	PFQ5ZKRHh0RqfWTOKw+/QgE3lqt0u1mdSGScXZOFv9Ng2Bt0qr5xuP6/q+RwjN+WXnKRIDxarnY
	/EAWNloCP
X-Received: by 2002:aa7:c0d0:0:b0:6ba:144f:ae43 with SMTP id 4fb4d7f45d1cf-6ba37c7b138mr7699149a12.6.1795531908788;
        Tue, 24 Nov 2026 06:51:48 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm6937861a12.18.2026.11.24.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:51:48 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/3] testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing
Date: Tue, 24 Nov 2026 15:51:44 +0100
Message-Id: <20261124145144.3411177-4-yegorslists@googlemail.com>
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

The <sys/timex.h> of uClibc-ng and musl lacks ADJ_SETOFFSET, so the y2038
test fails to build:

  syscall-tests.c:412:22: error: 'ADJ_SETOFFSET' undeclared (first use in this function)

Fall back to the value from the kernel UAPI, as the test already does
for the time64 data types.

Fixes: fa89ca44e33d ("y2038: testsuite/smokey/y2038: testcase for adjtime64")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 4318712cc..27deb80e5 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,11 @@
 #include <sched.h>
 #include <rtdm/ipc.h>
 
+/* not provided by all C libraries, e.g. uClibc-ng and musl */
+#ifndef ADJ_SETOFFSET
+#define ADJ_SETOFFSET 0x0100
+#endif
+
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
 /*
-- 
2.34.1

