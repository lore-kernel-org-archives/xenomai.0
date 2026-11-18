Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002553;
	b=PVQ6ycGI7QgEMspvCNdbo6rUHA/5tEFtaVpB5j/SH7fbLz5ZHMitn+zfUXPlGFtT+WhR
	 Bnt9NJRhBJ+hij9HFTC1ufuqWaNQBa37eyxei8Q4AlX6d1W2jHXPPhe/9RuJ+l9jxMSCG
	 m1AE3403oPAZzpDCZ10MJTHfNm+rBPysHFITxaVYu12+n0QBWy5+zCZ9r31KSU9XU3lwn
	 KsXGNtDSYsNsg61gKDhZvXCuRRODO8CltVbctsHC04YUy3NcrkuUJ44gjomwpZdfLrFFQ
	 xGJx/iMCIaL2WZX1nlGNKNAg14FwzYJJ60TdJgMpBNnFqMNZXvrHvKcCqtaimRxCyHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=88aas5CcUBl+Np1bijcefp3spksVtXyim3z/oaYQKLc=;
	b=idEzwcAbX240ODhHFzgvQObem+oOStQ1d+iiZQwrH1UoKfKofhMmUhGcaX1p62s2eJ2T
	 qEKVUeF1IckO5hs4U0XGqYf3rYUToJMyiHT5Im9zRFG3+mRNz/dQoEaRDwvcgrGLDz0Mw
	 IJ9d247OOgV9etLzAoKZ+uZYeppOWFu+wTaFcugDWKX+wTqXf5KK6dPjbv1MkVXCPakIB
	 4Kl/YGGDPV9WDcfySizvOvmdQFW/HnV7BXzaEPQFQDrozu0ilG1bGv1KahTM0XBHqX/I0
	 VaPSMv6gzgXHYo+qCMH5DEovHhCKY4eFgRS1y6p34KaoGHg5tkHCQ215DnaRdqKEHPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="vjQBh//J";
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A30606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=vjQBh//J
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso1484515a12.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002551; x=1795607351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88aas5CcUBl+Np1bijcefp3spksVtXyim3z/oaYQKLc=;
        b=vjQBh//JDwanmAi1/z0H4iH5SJ+pJjsrI7yqjRH+UGC1iOPnCuK/nkRu1VrkhF/D5j
         zrPmO4UWFYIxvLfx2HzAkET9JZpRKESj2PLAtmxikhaCILpQ5fl8X+SAPUd6kIQd77U9
         5oQIW/qlqBPboJb5r0Yrc6ZX0Rmh1xN3k5IKtlf50N54KrsSc5lOS5pswPi0Ja9CCIkp
         KVFEib6gex5lLU7daSKBTq0s1nmkHkOEGJIk938hbuSQ6UyT153zXe7xrshAe7ziChNh
         gRVP0cYYMZb45Rm7R3K+8ev/jPsy1tZ/vRqjCwHxzETIkINTwfkOX8emhvBTYJJaeWgt
         vj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002551; x=1795607351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88aas5CcUBl+Np1bijcefp3spksVtXyim3z/oaYQKLc=;
        b=SWtruA71f9vE5jKel2yeZUIe3DKK2bJV2CPd8N2j4ozAcaog4awb2eWDeD1+53cWvr
         FbyJdUlOHwaczuPD4Q6I9lKLiVyHnFAFlLtnbkH4aMDyj4NQxSpTocZDjEpuQmOkns0E
         mM+blyrhgFrmClpH0kCk5L/Zm2vI4PgG6iivtRSZc7WIrCY4YW+hgh+7rowOJCyBE8h0
         opq60rF57gTxT/tLRwenMZWB/ZASGxxgsosNfcYXl/YeE/xj5u7mmGw8HHr4B0xBNWqa
         0f7AC2kpTeVTObzfxZVWJA5QGL3qVCeKjIpS0SSZ43wYHOJ/cUjRHZZJTeOOpvuyCNhe
         0UKQ==
X-Gm-Message-State: APuU4Z+AY+m4kmHPcn4Vij4AvouUgPaJqpJF4IzavywHK4TaLKBC1C+L
	DBzEkIonniCvEwsiSvBuaOeF8PP51Ym4EODB5TOC63W613T9vRMYignxKU0b4A==
X-Gm-Gg: AYBFou2vcLXggc7o+MqWiif4cjGW5L5kIMgo4Whf9uMkXkGVUcUN8kiUArBUhalx7MX
	KcakoBHnj/T23dYtzCSwT5/QwXx/pZ116RHr6jXqbLh7GoYRqBINkkvUU93jDOfgbZoNFG8k7gY
	jbD5p2wPXwx/RbTGevxDk1Dyt2ObU/ksbiSgxqAoAN+unoJl1qX5A8C8Q7sxFyRiIom8HrwyNmN
	55IIFyCIvvs3B/WMMxr+C8tj0+gq3cadg4DEmcNRYTSkeuKUTrokjEQblhJk0YDS+mEc70nwF+S
	OWrQQCz0QklSUAm04tZEnaTaLKFmjLsCSkRk72dHHcn9psz4LogYPoZlbt3J/uaAO6xXNfl8ToI
	hasabCUitmfmN0pnIHbLzL8gPqFGbxlmil9UJcUUec6UEJNyDadONicSxS8lUgI/1BGYkqiIJkA
	+6fRjx+j3jbjgayYnuRu4FrNb7J00K4vOyuCN6xM7SEeX+x3RZZfx5Up+KEqpjAOToqPr0KquHp
	QknfYhI8/p0pnHciPOrRLXUZBoxMUQ8OrGWE1H0bZ0aEI1WydFJbQYWkcDq32m1ze6klBFQUeOE
	bgxjqcOTDedsivXAPYxqp5+0TjIj1H1oZUDGXRvYcooEBfxU0Eb6Yq/f0O5FZ1Vf0TOj+GeJIJG
	+bIEJAKc4
X-Received: by 2002:a05:6402:1607:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b887ebebb8mr1414133a12.20.1795002551189;
        Wed, 18 Nov 2026 03:49:11 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:09 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 1/5] lib: Restore includes needed by the Mercury core
Date: Wed, 18 Nov 2026 12:49:05 +0100
Message-Id: <20261118114909.3030884-2-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
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

Commits 41de7cc7196f ("lib/boilerplate: Cleanup includes") and
7b7ddf4a3658 ("lib/copperplate: Cleanup includes") dropped headers
that are still needed. With the Cobalt core, they get pulled in
indirectly, but building the Mercury core fails:

  setup.c: In function '__xenomai_init':
  setup.c:606:23: error: implicit declaration of function 'mlockall' [-Wimplicit-function-declaration]
  setup.c:606:32: error: 'MCL_CURRENT' undeclared (first use in this function)
  setup.c:606:46: error: 'MCL_FUTURE' undeclared (first use in this function)

  internal.c:108:24: error: '__NR_tkill' undeclared (first use in this function)

Include <sys/mman.h> and <sys/syscall.h> again.

Fixes: 41de7cc7196f ("lib/boilerplate: Cleanup includes")
Fixes: 7b7ddf4a3658 ("lib/copperplate: Cleanup includes")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 lib/boilerplate/setup.c    | 1 +
 lib/copperplate/internal.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 7bb24f6f4..7b21c0f1a 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -17,6 +17,7 @@
  */
 
 #include <sys/types.h>
+#include <sys/mman.h>
 #include <sched.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
index ed3f2e4fa..039767721 100644
--- a/lib/copperplate/internal.c
+++ b/lib/copperplate/internal.c
@@ -18,6 +18,7 @@
 
 #include <sys/types.h>
 #include <sys/prctl.h>
+#include <sys/syscall.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <pthread.h>
-- 
2.34.1

