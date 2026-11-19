Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072674;
	b=CZC6OzdtJkl/51WKmgRaIwN1m9b8Os8gQremrWR/I7VRpMhlvm3onWdcRXp8csFcmuJo
	 6+JQvO4ACEAY6py1ReS0TbQw98YmsjO2Xj2ZxbpMmBXZJCMn/GvGVcN6mLcZw5jC3jijn
	 MNyQs1CYpLh8oITQaM3tLGl2hO0dKbbe8aBgxa7wPcSGiP0MjzJf7KDHTFkLBFcddbYHW
	 hlT2a1JoygGEJOnqn6oJEr0VKdkhD2F9L4XROMhYwp2CL6O7J3ixiKNq/LAvkyVGj+1+m
	 7mRhXpgdgo05aMi/jsCNmD0x99rhV10RIBg2Npwag2EkK6gsDuiKmlIHlOzAVt1HjOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
	b=isifmwHPQEQIAmkvhc5cstm9WGVHgdyUqvzPc/56FXuuq+ZxxW/sf1syk5tMzM+RnQXh
	 ZVkS+p0M5Eo91TCPIcqu3sQsCDQF0TtjkeVmhuAUFKHzKAyZBGcTtmPP512N9z3HbjVN0
	 xH3Zv5xlHnfpuGX6CJFthjeF0V0ENhz++V9zylHi2bVcq+c8V76DC+COz58Y3AFZqyzWI
	 9sgDhzxDfvNErumbBd84OMBlDI2JhawE14K3U3xmgUk0ImoUGXXgwTITBCNmsUEfAF3Kf
	 v86CINXceKVoyRQpcYx5SNBzPScneD31raxXxb2Zf0ejRS7xjDiRhjvcgWxzA3cHzyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=0vGCHWbK;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB65606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB65606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=0vGCHWbK
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50933bdf4bso158133666b.1
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072673; x=1795677473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
        b=0vGCHWbKTQVAdepJOFz00WMaje8Bex6RfVTaa9k+7zSPYJY7lRGhkova98SJyXYv2D
         UjqTp/9CCvEx7+ucP+ipy3gcjmMmymZ562rUgPMsUagYYgxeGvJx/1VKLUu6x18F/8HM
         NY+U3vVNsKPMyQ98/anKIiYEbP1BMzBu8bSHS7oo4wrzXWEDT9thZXg8KM9ceLHEmalW
         D3VSX0sppT88EyyKhPNrlC5SG18E7lXgehjoD0oNuHKUIlFfaki+AF4LSPTWLiSlMdto
         h5i+FjOybi7nQ6qbaQl5xt4rSoT15nVp4I83m9E/hqHO8Ye0I+2lmiYaelBj8mZQG6ub
         Yktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072673; x=1795677473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
        b=g/XzI8jtOz+2aMPcCh5/wUG13ryyQerZi8iyb2NwffcbTV6d603Jjobrt6kgkZVJ0E
         fCSFWdRbVVg2KUjdBMMgvY3c0rgEmh+sf46L8tQsNHYvg5RG/+SHBO42PMxTfzpNyfEw
         N9Vd/9/r4JmIWf/+2K9nj+e96EK6bMhVyNmrzm0rs6x6d6mcA8eY75e8ZpoFobflrxvp
         6+aIeNCvplNnTQA4q2ZeUQEE+0Ih3igc4g+fa8ZisffTaqQ3dAbbqlzUOyI/UoxxREhk
         nDBPDYNvSoT2REVVJkd3E9qkXEEAZFZHerar1Ufro6VFng4k3M4s9qMDWj+oGX7hUJpf
         ovSQ==
X-Gm-Message-State: APuU4Z/LmXonN8o/oXe4jfcR95aXzU1Ty3QeMvdE0JebAkr8mTvG5S9H
	9Wc8TcVG9bLLAxeYhz7QqtwlI1rTI9z/UBhGGkqnsvQH9C0iL7OTqb3D/1Bcaw==
X-Gm-Gg: AYBFou1ldTc+2qp3W2Cpe2lyh8HQNWC257Cib5go7Svc6MdavYyz/l7LPK2jFvyvr+y
	5O9q9m+JIKVxcuw6NlP5E5i2K6MEt7eAEwYyEC/Ob8mfdphzbyzBQ5ZqIEOccQMM9tBC+f48r1K
	rHjgk/UiljLIrQZoHtBQG9FeB7mpm8UOjE262r1DvhcoJA8v67meOHEqlEdL23mzgU1aUO19BAc
	AW2PnoImpSG4C/L6TW2404dgmCT0vw25aASwzlC4lDrlN02zwC8S4NM/gbSNwRYIJItUvl/coaR
	1dlkaPZQyQouzNj/o0G1vVWrt+vfXelvgXpjSQKQKNZtaz+XiLgXZBGE7j7IblIOhjfo6Pv3rEj
	SbkzusIHA6CZHrRxwBr/cyzN9sHmqq4cAuquLQHTPtSiTJqpqQHzriDZse8xvCFNBeJwj3Z+Rf2
	7qHWDfDmtf729MWeKObWiyy3vu/rwBvK+nEe/Z+96OdGN2xn+Laum09f2+Gbi2uZTL+a9Tq42W5
	GFWwi09BvuV5QwdZ3kzjDPTXVX5pan7Ob1aVtsaN1Ycv3P0agHKvxfwJ/xDO8VrHsVwD9VQP0W4
	eVTt/kO+uWuNlFHcgP0nFmaIWCVCApYc8gy2zFNwiQAt4w/W9tI2cpe/zqmWP5wTjNl9KZyC+h7
	lGLy88f0vjw==
X-Received: by 2002:a17:907:968c:b0:c51:205e:6e8e with SMTP id a640c23a62f3a-c51319b6e77mr26035266b.24.1795072672767;
        Wed, 18 Nov 2026 23:17:52 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:51 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 5/5] testsuite/gpiobench: Include stdarg.h
Date: Thu, 19 Nov 2026 08:17:45 +0100
Message-Id: <20261119071745.2409665-6-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
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

gpiobench uses va_list, va_start() and va_end(), but stopped including
<stdarg.h> indirectly when <xenomai/init.h> was dropped. With the
Cobalt core, the header still comes in through other headers, but
building the Mercury core fails:

  gpiobench.c:268:9: error: unknown type name 'va_list'
  gpiobench.c:283:9: error: implicit declaration of function 'va_start' [-Wimplicit-function-declaration]

Include <stdarg.h> directly.

Fixes: 17defbb7bb64 ("testsuite: Cleanup of unused includes")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/gpiobench/gpiobench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index f2cbb2549..44f04ff4d 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -21,6 +21,7 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.34.1

