Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC418626
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759969009; cv=pass; b=DJk74DQ9ault9qiAGD7knNblYbuLc6dPh0cfRY0Sq/hBRO56TNUFhLhaXhHYxKP1JN/pS9l3bHDoQtFRIoOyIhqGGJnBmX0OLQpuW1xLrknBlUqczd/84C7F+0lj7z/cLGAtb3FuNC0J8Ly2AUelc24NTE5mAuy7k35EH550mew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759969009; c=relaxed/simple;
	bh=pwIxTGn7lQbbL5NFLeWzkQ/GQt6z/Rbtx1BIS4IIqro=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=jE85esD3jI5Qk6YDpyuhD/6vilKC00NcBoePOzAWuMZx2X0UMHyNLS1DVG7AWZItTuljFSg/d0BekR9CMHc1h/LRfU3jgvhIjeI5mp626bqaBJl0JC1L2woGW10ujkVojMmmWb9Zqw99QFAenG5EeXMZB/NNEut16erYUgX3QLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=ErCWsbwe; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="ErCWsbwe"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 129D43613CB
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 23:37:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a244.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.113.157.12])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 996DF361678
	for <xenomai@lists.linux.dev>; Wed, 08 Oct 2025 23:37:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759966629; a=rsa-sha256;
	cv=none;
	b=joKhSaEhVPoObOG+IPeIHwM4Hf7vpZnTnQewm8gALaAZGIriotE+GQGWafRi8SRiMpWUs5
	71Xd6Q8ySSNUMXDmV7B4eOoEN4tK5C/g6DAu3dqO0YZQ/JJyG/9KPnlC+bXvm4eUNedlj+
	bysWmJljaO5wbG+YW/RF6Ozxwn8wz8Uwu3zOjxL7lwjBzAuRYbNRZBuuZjKw0sc8eJUVno
	N6/63Guhuzy+5J9Bslwxf44frHJPWBBOXlr0HlXzCXDbrMhOVRGQr168YMFyNiBZ536bFc
	zl0xVVdxtcqLZeYDYGxY/7ryK1auv0FqmmiAxdvlscNNfQDCyY1BJuYMj+yoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759966629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZrR5rgW8CllRXDfGdki/Ld+DwqR5PIeEyTzZXzhl7hI=;
	b=wVS0TEFURQ2qA9p1Yskc/ZpyxJx6sh0xhjt3iCGieysAZD3MDRynaQZdT+p00fAmQ2QrzA
	VAulst5iJS8V5jjKQ2ZL48PH+kdnWhYTDw3IqmvOxwSzRZLChj5xjYv7r+2OHxSLKzc7bN
	B08ciA1M7jgKNmUg3X3vfwwwQCVqRnUofHSclve0vnoE3y0zsXW4ykvz3z/iWSA5LBB6L+
	21sS0vqYvPLLbXvklVdcVyWItUV6k+whMUAtRuEZfAOqWLu8RxjN+Tuu6X92r9iKczELh7
	dC2AgLFhzlFZ5ahAycaOw5gCPRve05oidZ9JrSR8JGUAthHOYpoIh0B0O2LZqA==
ARC-Authentication-Results: i=1;
	rspamd-668c7f7ff9-j8lwd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Name-Robust: 1d29c1411cd835dc_1759966629779_3170256404
X-MC-Loop-Signature: 1759966629779:25101731
X-MC-Ingress-Time: 1759966629779
Received: from pdx1-sub0-mail-a244.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.157.12 (trex/7.1.3);
	Wed, 08 Oct 2025 23:37:09 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.95.48.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a244.dreamhost.com (Postfix) with ESMTPSA id 4chqD50xblzC5
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1759966629;
	bh=ZrR5rgW8CllRXDfGdki/Ld+DwqR5PIeEyTzZXzhl7hI=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=ErCWsbweKLLoPr5xvhioUYX8BkdeaaXmj53fK+jq0zJev8YTc+NiMfaAGDtnvJyaF
	 HvlHavYsHhlDi+VFzms02CQ/+7KOP9NrTsZUTJYZsh97rujm0iW12IKM9PEpM3UgNi
	 r0MHV0A/fQMgM0KR+qgue5K56JHpePMk5BBxwJCI9edv0ZyzCVZVUA3HrRpek2cpJq
	 Iq8HRM05FGG1hyo9s5x4Oo2aDWx+f8x3rzTOKaXGNKMnYTFMsr+/vQNa2uGf2Nj08P
	 fxmRsx57jIXOEfHfkghu/Zo19GZK6+zQeWdTxDDWNdXGWqJKkrvDN+SOMfpaeC1D3y
	 /5GAN1sNQqMKQ==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: [linux-evl][v6.12.y-evl-rebase branch][PATCH] Remove stale
 CONTEXT_USER (now CT_STATE_USER)
Message-ID: <9a8210c9-2eea-dac3-5bb0-31106897aded@bela.io>
Date: Wed, 8 Oct 2025 18:37:04 -0500
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

 From 728b86c0a1964f1a5f6b81b6e3f9807b79ec640e Mon Sep 17 00:00:00 2001
From: Giulio Moro <giuliomoro@yahoo.it>
Date: Wed, 8 Oct 2025 13:28:29 +0000
Subject: [PATCH] Remove stale CONTEXT_USER (now CT_STATE_USER)

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
  arch/arm64/kernel/entry-common.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 52a995f90..125de5b09 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -171,7 +171,6 @@ static __always_inline void __enter_from_user_mode(void)
  		lockdep_hardirqs_off(CALLER_ADDR0);
  		WARN_ON_ONCE(irq_pipeline_debug() && test_inband_stall());
  		CT_WARN_ON(ct_state() != CT_STATE_USER);
-		CT_WARN_ON(ct_state() != CONTEXT_USER);
  		stall_inband_nocheck();
  		user_exit_irqoff();
  		unstall_inband_nocheck();
--
2.30.2
