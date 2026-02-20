Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EA2E8E09
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610993; cv=pass; b=VhLEFe3URxyCI+MCvaFxlL2m/VS5rf3UfzKjTrPc9/j4LumqAV/NopYYJejHnMsTXmyBsZBDj+5hgaQzideM6OpykNqbFEFa2vzbyDgfltjyPcYycN6RzlLPhauLm0hcRtDFrH4CNisGsbNQ2dGrJx56yiG3PhMaq3V+8y4dbwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610993; c=relaxed/simple;
	bh=4vcSUZtuPj40HO3nd92gs0InYfY104nOMGwpzbdiwQs=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Ss8jTkMCqTTmvKboa7LcS6eiCihw5naDn0uBmQuQ9V+Zd4uQA3BfMk/G9y4F6eldds9Vu6zrjdjqnhlFuEwPzd8NbbbgswKGW/C6z/UnBrkjAcDDPMWAASI7WTVtbgZp57UarB6Zd0QkTxQvU4WZgHBb/OLruoPNXLeNHTYYcY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=w1V7pnb0; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="w1V7pnb0"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DCFF0822765
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:04:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (100-97-187-84.trex-nlb.outbound.svc.cluster.local [100.97.187.84])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 540C08217AA
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771610677;
	b=9KLcP9oYB8TxI4xmzLaw17bUdajewJ80HE3Odguq67aS19UqacOTG/geefI5QNds+B/m74
	OJtBRtPnThPelh5k0a16U3DXB0BEOdCkqfy9zsAWYeuy6oaAa4Z3bSDSK3Esjxs/4RgRyC
	xfmNMxwnbjNoQLUaME1hUENwJkobKXcMcBZ/FxmR8nN6ktXQt+dOrWjB7+ZopZoVGfqGOL
	QGSu4UtaHGj8Aune/X9nxUCw/U0M6xGmTYivLKea3wNjzP5Zp4qhNgIQL6HpkI8kjce3nB
	to4sam41t6jFckK+rPtA0fT2TyxikNgHcaQTm0z3ZqhNp3UkvDO4dAZg1PpU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771610677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2VCwFB2kCk2U/OcHmCNp+dK4wxO5cxgQ8YlIuPkjazA=;
	b=vuQVn0Pu/3ZfqR8hZUwqroKKzmPlRyXGxsFHyoLNgP0Ih35Q4/hilKf5//2SziBMeIrkEF
	zNNR2AX9mk0gPCLomXKnbdWlmKVmp+nzaaenDhASA2xzIndHufVXRBKbD7b0xSlfbtk47S
	gBF3Zr546kolV8mnSJMdCONCogo+ZJN6XLzfYzssrVIgqiCQseQ/vi5l/EZq64HTVJJ7TF
	/2TZ9cHRw6NjgD6qZbCL2Qkf2vNyx2Dxq+7VIz9IDNsjaa24/ZLgAwRpcp7pZcAsgjkn1/
	kMdeYsQ37z09FqRx6AKEbFKxwGl3X7s1hfu5Qwtatkmnam5sgnPFzWGb37LpwQ==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-24gmf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Celery-Army: 05ff8cce23cd9f0f_1771610677751_3109209471
X-MC-Loop-Signature: 1771610677751:3030240892
X-MC-Ingress-Time: 1771610677751
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.187.84 (trex/7.1.3);
	Fri, 20 Feb 2026 18:04:37 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.59.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4fHdS46Wpcz107w
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771610677;
	bh=2VCwFB2kCk2U/OcHmCNp+dK4wxO5cxgQ8YlIuPkjazA=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=w1V7pnb0rq9WhgkWJN8M2tD05/M2R3BKcZuUvMbyW2pCEKgb/3FUrSg1ETUZKcN83
	 PBMvpMXX+PffqACwBpohwtv1eP1Wua0CLNYiNhf3P8DqZChBhBzGihas/+HFja8y3E
	 lF3SzguznafGHT/xUU/cjOYLttaJEe34HWcJ5lHUX/ktxIydSLkQPncGOfMZ1QkpMG
	 qIk7+GMLEyexSii0YRD/7Ltr5bAXR+omeM0CgaoFxMDd03tOgyPmURDghhGdCG5peQ
	 7TMDiquBkuon44UcILHolEdoDmnZPDUgtJtFm4d1iHTQqUiA/219sMk+9qL8rZtsyg
	 /n8/UGa3/PLSA==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: evl ps cpu time reporting issue
Message-ID: <21b140ef-69b2-6dbe-f12c-c4c46a28a67e@bela.io>
Date: Fri, 20 Feb 2026 13:04:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hy there,
I found a few issues with the output of ps -st.
The most crucial one is that sometimes it reports excessive CPU usage, e.g. (running watch -n1 evl  ps -st):


  CPU   PID   ISW     CTXSW     SYS       RWA       STAT     TIMEOUT      %CPU      CPUTIME       NAME
    1   947   105     119       203       1          X          -           0.0      0:011.988    test-pd:947:1804289383
    1   952   2       2         3         0          X          -           0.0      0:000.087    systemTask
    1   954   2       2         3         0          X          -           0.0      0:000.056    WSServer_40100
    1   956   2       2         3         0          X          -           0.0      0:000.070    WSClient_signalMonitor40100_bin
    1   1003  2       2         3         0          X          -           0.0      0:000.054    WSServer_5555
    1   1004  2       2         3         0          X          -           0.0      0:000.054    WSClient_gui_data5555_bin
    1   1005  2       2         3         0          X          -           0.0      0:000.044    WSClient_gui_control5555_bin
    1   1006  15      15        47        0          X          -           0.0      0:000.594    WSServer_5432
    1   1007  504     514       505       0          X          -           0.0      0:021.035    WSClient_scope_data5432_bin
    1   1008  2       2         3         0          X          -           0.0      0:000.049    WSClient_scope_control5432_bin
    1   1009  48842   73393     123151    24420      W          -           0.0      0:380.085    scope-trigger-task
    0   1011  6640    31157     37608     23656      W          -         1193652.1      0:642.101    thread:947:0xffffb3c0fe30:2214587712
    1   1012  774278  1546216   776625    0          D       001.393        0.5      7:690.643    libpd-fdTask
    1   1013  0       2         4         0          W          -           0.0      0:000.081    touchSensorRead
    3   1019  2       28822348  28885721  27                 011           48.3   1092:295.224    bela-audio

note that thread:947:0xffffb3c0fe30:2214587712 has 1193652.1% CPU. In another case it reported 1405727.9, in another something like 16000; some other times it shows between 60% and 150% ... In the instances I've seen, it was only this thread that was affected, no other one. The thread should never go anywhere 10%: most of the time it sleeps on an evl_wait_event(); when it's woken up, it reads 4k of data from disk (thus switching to secondary mode), puts it in a buffer, signals another evl condition variable via evl_signal_event() (thus switching to primary mode) and goes back to sleep in evl_wait_event().

Now, I cannot exclude that there may be something wrong in my code, which may justify the occasional 60% reading  (I didn't write it myself, only ported it to evl, and I didn't inspect it closely), but there's clearly something pathological in evl's CPU reporting system with anything above 100%, I guess?

As usual, I am running this on ARM64 (PocketBeagle 2)
evl.0.55 -- #98a8b88 (2025-10-08 22:41:39 +0000) [requires ABI 42]
Linux bela 6.12.49-arm64-ti-evl #4 SMP EVL Sun Nov  2 19:24:32 UTC 2025 aarch64 GNU/Linux

Best,
Giulio
