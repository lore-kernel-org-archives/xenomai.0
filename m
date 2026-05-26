Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D43C0A1C
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820211; cv=none; b=bhL0UUfc5T5E7AVciNalRWAGQVf7BC1vfj4jTACHWs/w7ASCxJ8Xr0Gv9PHfMj+mmXIwUA6Rmhl/k0A/zgzwICqsC/1842SyscfPAhRTtzjs64utvZrmWXRjmqcLALXegaXmNiXkXNX37uwno91yQmjB03YBWzz9Wkf1PJbMH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820211; c=relaxed/simple;
	bh=fXeg9287IrZ8iIBS11hPErLFe5InysDs9CgPYkXWBz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbMOsul+RPLKS7C5aNw9w4XBI4PVFjqcRZ4Kw2DLT3YdlkSJAhB6HNwIstaCLbgMOA31IGpDLvhZQsRuzg/Ucc5+T25RTG/50GjecQ6eiATTSuPEiZb17Gt9VdWH7YjeEGwxIJD2NEhwAg7Fn03TqBlrHRmk8EtDHoJOsVczTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdSnePH6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdSnePH6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49041e84237so37210045e9.1
        for <xenomai@lists.linux.dev>; Tue, 26 May 2026 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779820208; x=1780425008; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HI7SdlZ2sAa0x5rHYiR1gObOpYTPrttHHTaKVZjc2Mg=;
        b=AdSnePH6SzQ7r6PRx+5QBOEo0C91e8qeWBV9NnZ/DIN/pkJ+3yjciOOTwWZSXSViDB
         vL/eS5c+dQ44JiDeuAi+XxbGsmERi+PeeEmcqnNgz+hlJGgF+86uVRnVwGdzxebw5gYz
         KezNdPnuBKsA0ctFDjzfKFu2lsba8dN/NVZqh+WVuR9sD0Yw6Kr/YOi0sGWpkcs9gD8I
         VLk0CVnbBXSrh6djVvDF3psykU0H4P2B2wphaf2czOew0+12jC/RHbzSn/c3GxjqZg+S
         nlvi0zd7aQCgYhj/eQh34/LiQW1QiYG4FErrEXutKydEoopOVX9/iFHHh9vhFdpSHbQy
         2Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820208; x=1780425008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI7SdlZ2sAa0x5rHYiR1gObOpYTPrttHHTaKVZjc2Mg=;
        b=SE6xnY51q6XZWB/CXiMiljK/VqpT3CsxCqkH8yuDo7vetP/ERUVNzmH0W99QMBh1EB
         eouf0vhy8QLpl06bLbkohz7WYA4tYzFuoF1L6EcvgooVkOMNRjUgpNJP4F+lp/MaFteD
         Sh++sqdcmc5OEgpaXxEMl0Al3LBGRtMf3D9cOq8pznEyLbIDUoIozdQJK1jVrAq6azhW
         Tfu0K51lfrGMLwV1+5FTSxlyLLUoq8ufspCXuT6BfNzJSfDo7MVJONcy+bH4wsJDQW6w
         GyCLu0aJ6jt0NHYF+Wk9coXDAQUUbuH3lhmTac8PaqXZ2WlbkwJl3BQE9YMN4nawJNnU
         9cNg==
X-Gm-Message-State: AOJu0YzPRb1xzr/2CKfZi4PlqReeYZjQYxGGjR5Zf0mSSKst4TZSo5+F
	OXepQcI93YxJOJR9EleS2xpphml1WYluP904V6xl7y9bnrwEoAjMnFRmmzOxTg==
X-Gm-Gg: Acq92OHrJIOyW8Vmb76iTRUmCgfGVPhM0hBkRWXoFYeKwhn8pGqkJU2G+X1dIvkZ7w+
	d9UsHPezRBtO2mdPDIRb+mtoWnW/6Y0Bgx2qfDuXa0x2fjO9qdAZqNEFPFE6HyoO/vCPKtzcUYX
	9OarV7R7sGrPKCzbFscad+4x6V9MNv6nmeDE4qn5sI2MVr4OVXVfP71VpiHtxgtGyz7gtscjNZk
	ZHuq3KIfrqacyN5VCTWDaoBDfvtzFos/F8Z4BL2n7NwhsyThoKIEBzx91q/oVYxTKUH0zhqBR94
	gj3mgPu5vj8674O41PKbnG/ZwIix3YOIYLXGkmVW2fG2TLPxroQb8J+Q01M86OZXaefOfCK+l2J
	0wLBCSVoAqYUm35lgTGP7ELtFnp5Hai9HIBazQxW6/9pQuh3l/VF1YK1wk5nXGBeMPXb+VPxcBZ
	US8Zc6NRO25Vj5bbqzEZOZI23UCUJL5n2gU+8z
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490426b0c92mr235100665e9.16.1779820208058;
        Tue, 26 May 2026 11:30:08 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49042ce923asm114428385e9.35.2026.05.26.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:30:07 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 0/1] fix error handling in client
Date: Tue, 26 May 2026 20:29:22 +0200
Message-ID: <20260526182923.4576-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello

While writing the doc, I found a mistake in the last patch. If desired, I can also resend the
last patch with this fixes in one patch.

Regards
Hannes

Hannes Diethelm (1):
  tidbits: net-udp: fix error handling in client

 tidbits/oob-net-udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.47.3

