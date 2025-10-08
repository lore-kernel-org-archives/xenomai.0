Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFE19FA93
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975902; cv=pass; b=Xob0thbxjnxDb9EqHdPzfCffTtHxgrvOaLgC7TcITQjl+AO9epOfWEwNddpiFKH+T4eVsjLNqkBC/4UjxAdueQueJ49NRky6KWP1ETVA39HXuUy5O+3mrWnEwF3iY4nqvrPwcrfeqBrVv9bWZEJlAZXe/9VFpQNk/ZfMPnet9Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975902; c=relaxed/simple;
	bh=2pXu+ZmbDrMR37JmIQ6znTKaPjSKHVbuSI82+hInLRk=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=BrSHMWaxh7D41QGqYn34i7w/rM8CesErTtlyFiSaO4dwgxrEAQqQcrO6wEANCd97+wXDaWAtm0Tjgbh+3TJFnJP9MBAsfa3k4IJkPwzPezSHl5MgziVnw3b9vIiZlfRs3eb29lnsCzHCyfr+HfpSSkaFiG2PAk7GlPOEX73KNvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=I3NM8yu+; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="I3NM8yu+"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B2A682E141D
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 22:42:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a244.dreamhost.com (100-114-102-221.trex-nlb.outbound.svc.cluster.local [100.114.102.221])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 21C542E1779
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 22:42:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759963370; a=rsa-sha256;
	cv=none;
	b=Y7YBk4Ei0VKqQ+x4TCCTQQvG55Rj9KmSqsz9XEy4L6/x5GduDRnIg6seRocihbQi+HEYFA
	TFY3r4UToTyx7PMu1WV8Kzx5V2T8EeXVWDMuE8/SbNqpiITRH9hZVW6xodxP6QQA8La2fV
	U2v1Ey6CuHSd5taP/tpWFg1Ixn0LVQ1KsIiKInk4XVg0+NE5OnKxh/eOY4iK8xlps4k84J
	sdRwasCk4L5giCX1JHBwx9O6lVKxfBqshYisNKTMOYD3O6VWfypNH+OxOcPacCMzv8xeqs
	3ZUYXoFdTerFxBfHZzFrvEP5IK9nQGA9dHSgVgGK4I6FjHx0wtdM08vDQskz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759963370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=PbuCzfx1Il35AWtdeukQnjKFvVbHfw/yuslT3JSXwAY=;
	b=TlGXaxBUCWgl6t0X/qxKhdB5p8K3zjIFot4AK/TJlqYe6GtsdQw8viEYXaVTTNAKWMx6dJ
	Gmqz0iEQezDseO92RcduKvxmMrmeVPSmkA3al6SCVtg5YHYbwbqWZab/nZuKZWtmFG7FZ4
	o/hHCyzxlUsAY1FuameieVe+3zrQaVtF9MEEKApH+62eyH+ECIMUJjSAmoYv3ZHT+Ja767
	t2d07fuZB05Bps0kLHjF0NWRU4yJ+0/WscpkHI9Jft2c9QskcJKqaZRr3WFEJVfdO3DSPm
	jNoNtBzTkI8vqE8KhcCvmxy+AHl/hc7AoljM0u3g8wzcorkuRfwMnWb4xHBydQ==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-jgrtf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Celery: 59c987cd12c86aaf_1759963370490_2018879316
X-MC-Loop-Signature: 1759963370490:1134516508
X-MC-Ingress-Time: 1759963370490
Received: from pdx1-sub0-mail-a244.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.102.221 (trex/7.1.3);
	Wed, 08 Oct 2025 22:42:50 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.95.48.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a244.dreamhost.com (Postfix) with ESMTPSA id 4chp1P3Rj7zC5
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1759963370;
	bh=PbuCzfx1Il35AWtdeukQnjKFvVbHfw/yuslT3JSXwAY=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=I3NM8yu+M1rVPYzJiO0b2SDp2S+4eJDk6B1VvYOy+NNu6H27T7xcKPa9LlvfJkWO8
	 lMOH7eo/Ymi/12BMH9hex1pTA6imOTrTjtU6OK8Jrj13KyasPEH8AmZwC5oYZjbmUT
	 ztdcFgYEo1AqoE6bAjlSBNfeBDaEJ8B2ILSBd77d1mKi3jIl/ruANHoR2QPS/CCpOm
	 qKfrO0+3Y+FDDhhD3UvOCqG5jteS2f6fn2OpTwSSEPdANAyk9oXs9+A0cdkmh9ig3W
	 dGdMryU07tSaNnXUr2BPEnIxkpIxjNiuPI5gHrnVbAd6taOQTicAdxYZbVqYwAJo25
	 uhcsavSRHdZvg==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: [libevl][PATCH] latmus: avoid segmentation fault on cleanup when
 test_ulat is
Message-ID: <212b2539-8dac-c61e-0bf8-5cbcf4aad365@bela.io>
Date: Wed, 8 Oct 2025 17:42:43 -0500
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

 From 98a8b8808cfc34e20684b4298f554f353eb1468a Mon Sep 17 00:00:00 2001
From: Giulio Moro <giuliomoro@yahoo.it>
Date: Wed, 8 Oct 2025 17:41:03 +0000
Subject: [PATCH] latmus: avoid segmentation fault on cleanup when test_ulat is
  not set

test case: latmus --sirq -P 90 -T 1s

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
  latmus/timer.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/latmus/timer.c b/latmus/timer.c
index e496d0f..ce44ffe 100644
--- a/latmus/timer.c
+++ b/latmus/timer.c
@@ -159,8 +159,10 @@ void run_timer_test(size_t histogram_cells)
  	sigwait(&sigmask, &sig);
  	pthread_cancel(sitter);
  	pthread_join(sitter, NULL);
-	pthread_cancel(responder);
-	pthread_join(responder, NULL);
+	if (test_ulat) {
+		pthread_cancel(responder);
+		pthread_join(responder, NULL);
+	}
  	pthread_cancel(logger);
  	pthread_join(logger, NULL);

--
2.39.5
