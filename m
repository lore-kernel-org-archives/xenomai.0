Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA03FB1B
	for <xenomai@lists.linux.dev>; Sun, 12 Oct 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275188; cv=none; b=TbT0lLBURVaEI6tAkixcdRg0Jl5IIKaBRiDF3VasTOluy7HrL7S8Z3Sy5G8Pu/6Uo95DgQB88Vju+gSPltf2SnP8LagJxklcPjeX+n5p6vwA5pwr4E7wJW468ZyXjgKeglzxSH2cTf0myfOGVh+d8sEbD/Mvl8mBsmH4kbQkkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275188; c=relaxed/simple;
	bh=qI/Rj6vqxEWXvGuZoK3UpOW7lDd3qysuFr9u0oDTYiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4TXM0Rf0Ao6d5tnsI4uF4Qki+owZUEnZrUis7xygSTR0Poh+I3pNfzezljnJ/liHKDOFKkE5fH/GxtDja4J+W2mLj80Rxmd+leilXFQEjJQ6jcJVoh2vJHikwDIscW7/g5VyVMMOTS3tIvBfCpjpJ/M9ceHgA1+2y5kXFe8PXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIGoMAvh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIGoMAvh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e504975dbso19054405e9.1
        for <xenomai@lists.linux.dev>; Sun, 12 Oct 2025 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760275185; x=1760879985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u98eGleWRttmaMoNVArYw/xxor+n1vhzf+9Y0UWv8iI=;
        b=BIGoMAvhKEXJqhIBPtH2uxIhWzyiRWsTV+WEuYP5W0dBFNEVNzitx640ONLbYVN7Qy
         ejXIaQph4oPNSgnZUymdBl5kHx1oVJmKBXmmFHP2WUOhngncE49TXL3feHdI3PQ/r6HT
         EsudJmW7Oz+X80MIXlW6AZHoZ0eTE/MsDeL/zw09iIag4c+yJVnJX5Vm8buWNxzBKcpC
         pdcqltzp8BbD+gyZrX1+ztSc3St6URXwB7VPOQFcN0Ky+abAY6LApjIaC+00uTl8tsvZ
         T3MSJ6ZBMdpDNq5+o3h/u/pq/1/5ODMhKBq+YWDexiTB5YV6SaqVKALdIgBQ4cygH592
         L5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760275185; x=1760879985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u98eGleWRttmaMoNVArYw/xxor+n1vhzf+9Y0UWv8iI=;
        b=I64EceQxpd6cev3w4p5MOLTkUXvfxaacclNf5Q2qmDjp2A0BTpOazydtD0Ncv/2ci8
         7lgUntA1Mh+4OzFaO17UsYrgTyGqep7crf78VIKhXTOU1x0km19NGxghRafgdY4GjQB3
         W2NVVNr8pMeole9DpoUJx9Zlo2PVykKrKU8yd2L3l+zwpoYUKc/Ry4ojxWieOGCn3BJ4
         9QkD6NEvGfM0nSFimzanX5QIfxGvv54M5r/dmeU26gCAV3pb2OUy1ZRf85GLIQbK06r3
         LU80/1wzLWTL4osGH2wRL9Nlv5qfvF63kKGU5kud2r9DNAFd0ltQif4+3zJpK943s6jG
         LmOg==
X-Gm-Message-State: AOJu0YysiUtQSAhm5dOC+/f2xHRv8JpCKy6LuWXeuHk3U3tKB+C4uFv0
	qyPDXl9HHQTH4UW2oyjl+A9KTqua7OiKgax8nnMP6tpFVbjgAQ0Sz2Y4SpzAiWJA
X-Gm-Gg: ASbGncuILROFZc/kRuv8uZuJJ2sTy3LH9O9D+MyyoP1w/05bRANiMDqhUuPYQk78KO9
	sveAWmk1/r4XZDaKnd+L39lcAqjTyaiM46Zf0KCB4DMeYqiRjBxHH3jfJaYrxwUAYgSAfgka349
	trJT7X6ZpfMEn65zrHn8MtCmXq7JSdznRKg3BORoA1/bjaWdfoTNQGaPnyMmV/HyNYg2mkSfg2c
	9hN4B858J/SRO3T9psh2jErCuPEeF4+rwjFF8AZCwVL8T/zxf9GBo3C1oPNzGZ5suRZgzV3OfS1
	9Rwn/tBp3MslxdEO5rJkq3CGhV4jnF8MSFK0DMq7N4ymyekcJe3lbrAfBfZolZLfBefoBl89jkt
	+TrCHh0npAFEjWURUopGaTBJfdq9+oSOMEbCaAHSWZc6HrL7OitAOhcmWeRjMFBse5bD7SHUfqA
	RvVp7bxRU2iuoMtg==
X-Google-Smtp-Source: AGHT+IEza34YAI0+gYGDCakTQOErLH1iGx/1HTfuxKpU6pOMp87aQxn28smFsd4+9oBN5FFk9fHcDg==
X-Received: by 2002:a05:600c:3d8b:b0:46e:5208:ded3 with SMTP id 5b1f17b1804b1-46fa9a98dffmr123583155e9.15.1760275184738;
        Sun, 12 Oct 2025 06:19:44 -0700 (PDT)
Received: from pop-os.. (82-194-152-106.dyn.cablelink.at. [82.194.152.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1206sm12948053f8f.43.2025.10.12.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 06:19:44 -0700 (PDT)
From: m.kurz92@gmail.com
To: xenomai@lists.linux.dev
Cc: Markus Kurz <m.kurz92@gmail.com>
Subject: [PATCH] fix typo in lib/alchemy/mutex.c
Date: Sun, 12 Oct 2025 15:18:15 +0200
Message-Id: <20251012131815.9094-1-m.kurz92@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Kurz <m.kurz92@gmail.com>

Found a small typo through the xenomai api documentation.

Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
---
 lib/alchemy/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 6bec2d9bb..408bb2f25 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -28,7 +28,7 @@
  * @ingroup alchemy
  * @defgroup alchemy_mutex Mutex services
  *
- * POSIXish mutual exclusion servicesl
+ * POSIXish mutual exclusion services
  *
  * A mutex is a MUTual EXclusion object, and is useful for protecting
  * shared data structures from concurrent modifications, and
