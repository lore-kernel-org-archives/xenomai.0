Received: from camel.birch.relay.mailchannels.net (camel.birch.relay.mailchannels.net [23.83.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7662F2E
	for <xenomai@lists.linux.dev>; Wed, 17 Aug 2022 15:59:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 86B4A4C173D
	for <xenomai@lists.linux.dev>; Wed, 17 Aug 2022 15:59:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a307.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 19B9D4C1AD5
	for <xenomai@lists.linux.dev>; Wed, 17 Aug 2022 15:59:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660751955; a=rsa-sha256;
	cv=none;
	b=OcQWKkhQ2mmlTqGHcMCCxsPX0bWtSRwMHi/D40YUKbmECU+KDty14PHaVLzpTY3LxTAPH1
	1x/zYGf5svFzb092RDSbUaNLWoItuk0y9A5xy3cUVcKQ4sI8XUWRljAkeMOS4F0Eqok59l
	e6qX8XAgGCCVF+KiLLrQpeq7dCSSAMOCjeO0u5UKyuacSD/Pk64yPt+SasbsAjcNGIalOB
	cWzM5sEf7A6BxURwnDXqcy0yNFgMdqPy9yEYNoeDt9CKgEsRV+GpgvK/dgIttLj+Adaqxk
	F9eRaBit6Ped4yDDxSgv6tpZztfbNlft0/PnJ1UCgN76F8cem/yZ1+YQmGmaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1660751955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8FQP6R6a0a/jATAwj9DIbEwPJ1CYnkb36iW08SAjZZo=;
	b=bSRgIVcr0KLi4FK7SIKAz+Yn9RfJUY+78cmZTZx87aGdW4t+/6D456bpcSsgRbI9wxLAYK
	qGnC7sW/cV60eyjKeT6uZhzTbypFOhZR7XNuqhYMdFcKmyRhntbbRSs8oLV6G8PiHPh3aI
	g7TCALR3shWNsGtIKSAEoxS8Yc8KfkuyNbu4jINLZqfojKGdci5WWo1ZfcTnSffmiW40x6
	j365S6UtI2kQfyjaNDNQJRjR1RT3FqlRIFSn44ZNY2JaVs1Py3f/qw8c0iUNQhLrjEJepj
	ULKWYj886ilHW5b/GSDUzOysvtIlrU2k6N6OcR+dr2KQAFXUa3lbVluR8pxQ/Q==
ARC-Authentication-Results: i=1;
	rspamd-7697cc766f-tph7h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Interest-Quick: 69b309a2481b456b_1660751955376_2404769611
X-MC-Loop-Signature: 1660751955376:1305423720
X-MC-Ingress-Time: 1660751955376
Received: from pdx1-sub0-mail-a307.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.161.77 (trex/6.7.1);
	Wed, 17 Aug 2022 15:59:15 +0000
Received: from [192.168.1.77] (unknown [5.77.81.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a307.dreamhost.com (Postfix) with ESMTPSA id 4M7CPZ18Vmz2G
	for <xenomai@lists.linux.dev>; Wed, 17 Aug 2022 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1660751954;
	bh=8FQP6R6a0a/jATAwj9DIbEwPJ1CYnkb36iW08SAjZZo=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=PfJsiQ41oi1ndwzNO3ZGn+pGFbhyk8Ujwfa9jI1RjopZGhSSxHMpgV1c7Akr0qPLE
	 uOjmksyUMrEcWhijnb+x83P7XThvHZq3UfO/bklZOu+0uP53kC3JEmFR2Bd5I7FvVT
	 y/bdhw2nUGi0LVXn5dRGE7uaWUgHVJcdeFHKs9aD4Is8oVYrXL9C7vJkG2UZKscSKs
	 VxZGQ1Uucz1ydlgR119irQbwMzpRAw8aJUHgphZwHvY2QRMyNj4sXDpp2yn/UWfrqH
	 oc08uulczzylF2zpu3hunvgjeprWuqL1EYxfh+cIOJToAzwjip2AsukuY/Y4bKbKI5
	 Qcr5VX81Sv7JA==
To: xenomai@lists.linux.dev
From: Giulio Moro <giulio@bela.io>
Subject:  [PATCH] selinux: incrementing the count of known PFs.
Message-ID: <2eba63d2-9560-b62f-b283-194b99692c30@bela.io>
Date: Wed, 17 Aug 2022 17:59:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Firefox/60.0 SeaMonkey/2.53.4
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This was needed for my bindep-pkg build. Not sure what config option requires it.

---

 From 62063ad20509ba448f5601343b44647a00f5fcc2 Mon Sep 17 00:00:00 2001
From: Giulio Moro <giuliomoro@yahoo.it>
Date: Wed, 17 Aug 2022 15:50:52 +0000
Subject: [PATCH] selinux: incrementing the count of known PFs.

Fixup for a24b313bd77a4b3e15168d8115a8d661113fac0b
   'selinux: dovetail: declare oob socket class'

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
  security/selinux/include/classmap.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8605d5fa893f..2112f07c36c7 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -257,6 +257,6 @@ struct security_class_mapping secclass_map[] = {
  	{ NULL }
    };

-#if PF_MAX > 46
+#if PF_MAX > 47
  #error New address family defined, please update secclass_map.
  #endif
--
2.25.1

