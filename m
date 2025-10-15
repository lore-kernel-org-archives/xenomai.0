Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545C17B50F
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568857; cv=none; b=kIEXRi7Wc4Uz9MfZI4D6zhPNB9fStKOkXj/EkDd4V6Njdvts8kb064lEqk1rYe2jXZX7F1J6rVEjCcNHemO3Wy56kMFvikwol3QHY4T+HAPKjO6CFEplURY+gvNd/bnIfWWkxhpPLj7qi9ooxuCiHFG0ouCukqGXO5Ma1URCp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568857; c=relaxed/simple;
	bh=xzKeIOk/Lzsz0J6IAOcrOW3TPgHbfJO9QzQnIm43AL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PO8pU8w4oPXjWMC5ouqeMFm+9/2fhZKf64u0hujwbIdWZFAlhD5mGR4WIAjp1Uw7hAeRO6AjN/1+nVT1oiW12+YxcGZIVsy5t4jeWK1ACd2XsZKYdSJCWnLNh324QgegzZdMnqSew7gtYqnajEvDNyPXPlRwfdDtThbRLLkXDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UubVTOqP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UubVTOqP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e542196c7so8063865e9.0
        for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760568853; x=1761173653; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItNY4K88E2EhJKdrvaVVYuT2LR2MspLUAZGLYyPhhBc=;
        b=UubVTOqPXDovqalWzdZV1V1bSbtrPi5+teZq68CnGIIJmL5tUvuaF01ZexpXJqDTQW
         1BQ0GhF63+7jTPmUUL2+1Sns5IblDasypBmqtZ22+y7E7IelbNrLI9JbkjgOlvXQF7hC
         /or+NzMTtv26alhS4P9iEKpSFxbRnKJlmoJY9DFuO2sw9pNHBtwoqvOgnHO3t0Kq6lhH
         3Bwu3C93C3v4Fn6yrCoTJ+oTNzIT2eVuO2p4uhSKhcJzzwTEHqthSBNYJvQQhxC5+9G+
         YdZkPVhRikEFc6Tey9QwzmrLlHB0KZPdlPZurrT+2kOKHxNBDsyEVAMBFp8VOjbilj5V
         RTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568853; x=1761173653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItNY4K88E2EhJKdrvaVVYuT2LR2MspLUAZGLYyPhhBc=;
        b=Y65eJ2fwgO/FAUlPAnwRW8d/A11hl9qoqGHlfhxf+rtKfQakxNNxj/wYAnOGljtIcr
         hdS9liuP4H1fc7lbUgNyW1Lk/rPZITpns+wBeBlYWyEkm1GzMgqUB8h03Ef5YJBY/341
         yiTWBDfkBo+g7BAVXM7BsYUuJn8m2j9o+9gno5MCTD5UYNibrwYXF9zePrukVHyTIeT1
         llKYzRJ7xy71yxuKD8fiIY4+qRDKBVJdL4zeygK8IaiVFuH1cC9XHTUY7RWdsuhweykT
         m8eU8MbySAQFM+eF4LsBUSz/5tkQu/IPEXsRLOGc2GrowIvql06ni/FjvadxJ1sRYEdg
         XebA==
X-Gm-Message-State: AOJu0YyWglrafnLrt2QN/URb8uJDs75RJsqqd22SFoTvZwZ6vAVT/+f/
	g1MPQwEoE1lrw43SyQH72DZ60MsriIPZxSXhVuYe+r15sqg0Q38o0QrIixbYNJSa
X-Gm-Gg: ASbGncuBHxM3Nr9Ehl+JndhTY/g6tX043kG3EuA0jQBV0cyqxH4Y/aLvICiOBuPB3bB
	F6Lmjlub9FJFOQm5ETwvFD8ElUGyMY9cId2PpYO3XP9ydyn2EOjfH6DSpCGjElwn2sePfFal7/f
	nB3hG90gWuj1Y1ekHold2Hjf2tjzMgPrDEtV5tzQfERltqaXxZquE2Ja7NMMprAejuHnLGocds0
	zZo4wXcmcM6Jz7ynFMoBAktMWTtn+yO67h09ve+LczRgWwmd3ptS220TmupxGAWJengGAHcf4nz
	tBcNG1fjffr7Iu9QkB67BFQMuuKXC2QNVn3FEuiivJjZ50yyhBLmg+R2BKqADWEQGsRL8rGyTdY
	deFe3LX/3ttbujl0H1cFzVddIB4daoN9/vK4qG7P5/vlFWfnX32PbQdVNTZVVPCedceiH1EMpSE
	aiR14paGYTTPhUCudu0slHIH+VnaDG7HKXbXwlOZ3JieyYYJpeAdAI7MpNREJDPwb72Gppu3EVf
	w==
X-Google-Smtp-Source: AGHT+IGtTRNmdlFF57NJWhFMmsRwRFgedPk+GGfOOVwUluNNBPFKN7xHSYAt6zrIILclcPREQduTdQ==
X-Received: by 2002:a05:600c:64ce:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-47109b2838emr11036975e9.14.1760568853503;
        Wed, 15 Oct 2025 15:54:13 -0700 (PDT)
Received: from pop-os.fritz.box (ip-046-005-139-119.um12.pools.vodafone-ip.de. [46.5.139.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710fa76fd0sm2105955e9.11.2025.10.15.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:54:13 -0700 (PDT)
From: m.kurz92@gmail.com
To: xenomai@lists.linux.dev
Cc: Markus Kurz <m.kurz92@gmail.com>
Subject: [PATCH] docs(xeno3): change to client-side search
Date: Thu, 16 Oct 2025 00:53:45 +0200
Message-Id: <20251015225345.66662-1-m.kurz92@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Kurz <m.kurz92@gmail.com>

The Xenomai3 documentation is hosted on gitlab pages which publishes
static websites. With the option SERVER_BASED_SEARCH set to YES, it
tries to tun a php script on the server side, which just leads in this
setup to a download prompt to be shown. By turning this option off (and
keeping SEARCHENGINE on YES), the search will be performed on the client
side. This makes it at least possible to find symbols and have
livesearch enabled. However, it does not allow for full-text search.

More information can be found here:
https://www.doxygen.nl/manual/searching.html

Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
---
 doc/doxygen/xeno3prm-html.conf.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
index d9907b99d..d8f8fc397 100644
--- a/doc/doxygen/xeno3prm-html.conf.in
+++ b/doc/doxygen/xeno3prm-html.conf.in
@@ -117,7 +117,7 @@ SEARCHENGINE           = YES
 # full text search. The disadvantage is that it is more difficult to setup
 # and does not have live searching capabilities.
 
-SERVER_BASED_SEARCH    = YES
+SERVER_BASED_SEARCH    = NO
 
 #---------------------------------------------------------------------------
 # configuration options related to the LaTeX output

base-commit: 1969b54822ea29c22e1944e450b0c0b34a33ef53
