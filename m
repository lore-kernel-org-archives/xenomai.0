Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44F28488B
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760211811; cv=pass; b=kMZ1KSwQWguOqyOsm/h3ONs7IABbF6RHzf6MBm2v/gV5IIGLKwoP2VERyRun68KYrZzAmRS0OhhoGR1AjvGK/RwpS/uxT0N/IhNXBPb6WAOQD2bwdhCRou0/sQZ2L6Q2TeFpiT9YG82nG/jMwtiy9UGz2oIk4865m+n3vZAY32I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760211811; c=relaxed/simple;
	bh=riuU+9HFpRjYHH+LlDRKSbhgr2Mrz7xpsA1Ftbb+1ow=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=onD0eSNfyCHvLvi/gUfR6ki+8MGQeRt4ZI5jITxQIpHwiihCFt7V8eo5lQqOktam8Zd987roSFFwrJRXAt20QKBYaZFvDSjgYbBdD+d5zJ5QZkt7pzioKEatOyTwHzunoOAzUCvDCoWIj+eSiJHYYPSCAynWWI7fQ55A2wv1okE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=ot0ZYtih; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="ot0ZYtih"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9A3E9101410
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 19:43:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (100-117-194-87.trex-nlb.outbound.svc.cluster.local [100.117.194.87])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D9983101449
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 19:43:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760211802; a=rsa-sha256;
	cv=none;
	b=haHLH5Ael/5ecEYmzYGLbvuejF1K88FEXM4Otc6qruoBef7IFfRIjsrN4ovQjw9pZ632NI
	6bpyeLFyuuBw1o/dL7LSSJcDI9EvcJdRHS9mU5It8E8BhdPGNkhdLO1t8ke9SB8t5Cqd4Q
	+3DaRPdUMInxBgcUIEXcZcFcEfmEkm41DLDs9Nz/pZRUyYami+1PLvWHiAYRC2Wvt8OF4i
	/FIK8fhSdIWsawjvf8k5lKYo3NVV3QhYhYiZxNN28f1FOVDomjOWNtJkvCirPPWl/wHp+Y
	Rb306OhFEARRxyMGNe8jdAtdTV7C5kSQPe14lPnhXcHg19qt0Kf0tgd05GuZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760211802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=kCqijUF69U/kNU/w3DQRUtA37SQtrqKylpGaxnwpBXg=;
	b=zHrLsZVi9QNvPrtQspzVBNpiYQtGdwTcBTCPWeNGLiGlSsBeKr7/ccLUIFZaVqzh3FIkpC
	u088kW0xymzLWFToTdqfYUWysQgwQx8sz6zT4XmQ098ZcuQ1q8ykcQ4l2xfTCUKut356v3
	ZeZBqLm0NYrUhZqKfLknmHPWK+m7J/Jr+J0HnySpXa+Qvh9ajk94RXNIxJiLCHNk2oUP/6
	iugJjqon8wPPGPY9gok0glnywcjj/1MJaavHbyAvjte4MPr8FBRGi0Cud/LjbVGVJTNaiI
	PjONn8kupOw4yHNykI/f8WXuUrPFmO31kpDzvXQa0fxjGqAllWtFcvGfRGBqkg==
ARC-Authentication-Results: i=1;
	rspamd-668c7f7ff9-2xpkv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Eyes: 712ae24515224e1d_1760211807061_1650918396
X-MC-Loop-Signature: 1760211807061:3780380101
X-MC-Ingress-Time: 1760211807061
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.194.87 (trex/7.1.3);
	Sat, 11 Oct 2025 19:43:27 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4ckYty3JZ2zGr
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760211802;
	bh=kCqijUF69U/kNU/w3DQRUtA37SQtrqKylpGaxnwpBXg=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=ot0ZYtihTKSFbCMJ29whJmZFhLPIbZBmu6NyJkrirRx7hG4XLyFQ5wnPFeR+FufQj
	 VuOiwUZKEqnNJIKs2LPAg60L3A2aQLQx6VSoWf6IeVT8Xt7XEDnVKhAWfXtlX6gIi/
	 VRUKowOiK5h2s1DV0QFjF2KI1Zlqb3S0lslNMIcSxjxZ/SnXOrvn7ZLYU+gtecbWVP
	 jmm+Zhy9fddIdGV4+3jdkkJKqvlvMPiS6vjq67qGMQohjYvHI8EnkkJ/S3Iwfxo1Ki
	 XAp9cxAPahcqkiPol5VVGJXw3syLblsI6WPQcBJQugGa8EJm1Pu45x5wv+kqdas57I
	 w0zYNm9GRQxiA==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: [linux-evl][v6.16-evl-rebased][PATCH] drivers/gpio/gpiolib.c: fix
 typo
Message-ID: <2458bd6f-cd9d-434d-4d85-95b553600b25@bela.io>
Date: Sat, 11 Oct 2025 14:43:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 From e8f89f46672796396d37e2af2c905f8c0e3e792d Mon Sep 17 00:00:00 2001
From: Giulio Moro <giuliomoro@yahoo.it>
Date: Sat, 11 Oct 2025 19:42:11 +0000
Subject: [PATCH] drivers/gpio/gpiolib.c: fix typo

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
  drivers/gpio/gpiolib.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index dcb44a428841..d13b0b82a9ad 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3872,7 +3872,7 @@ int gpiod_set_array_value_oob(struct gpio_chip *gc,
  		trace_gpio_value(desc_to_gpio(desc), 0, value);
  	}

-	gpio_chip_set_multiple(gc, mask, bits);
+	gpiochip_set_multiple(gc, mask, bits);

  	return 0;
  }
--
2.30.2
