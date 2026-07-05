Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB32DFF3F
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264224; cv=none; b=LDxs+Lt5enPmbHtSKd5IHzZO3bjf/XJP7Biw1EmDn4VohG/8xgkrhtbCNNkuDxmRGqBzw3zCNkGSDoRdXjK3GZ7/i82YPxRBR1IH7jYvZqEtYbP3Z5T09Stc1H1QYPTJkC7I+n+d0uvwIiQzhJWy358nQ3vFgEQ0I5jYrf3fm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264224; c=relaxed/simple;
	bh=Wscbr1eYTpH+b+83eLov8GJaM5hRG4BzkLy+FSeG3f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRPkCd+9oaECOkKoAIekgM8iCh51YFEPZ45PfNQ4On+/0f107KggJbWD8nhoJrob8ce6ZJH9zPJEx7a+X0W2q3lSyEkZClon2n8r67yTbf9CEoLa01nR7Fx/dEgSFU9yBcpbF2ddPAxVNUmIUb1d6dr1MtUeGYvlZODozyQmHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LyKL7yo4; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LyKL7yo4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 76C245801C5
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 14:58:01 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F2073ED8B;
	Sun,  5 Jul 2026 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783263474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqoA62/VqGGKaqq8e95YTasuAymbLpDybcol+Umgnys=;
	b=LyKL7yo4L2lDCNKoPQs2csVQEeDqIzbC1oXoNjJ4zTLrXONiXfwb2qudElzkYvTRupWoXW
	MP+4mMKL0qDJ7FKMa1+HRhBCMStEVNvhc5Brt6gyUhq0U+v+LvJIxs5YrLZX011v1YFeUj
	b2orXQdLex1YXGbbfA8vgtZpWxVJAVWPeGup44NfNx6RZCgEtKqHqHaQaCRnDt/qRzadFR
	NNdjRb8TPYmPKvGNRCZwua3vukcT+OEFdhlapRdNEciS3/LDoPRgm8ti4LXdZXj/WmzG6r
	6epvq+duHBuGBaTUPUMMAL0fg94ITn18m13609lHk/dSRuM7pzNMsz2tOr+xwg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-ping: add ping tidbit using raw socket
In-Reply-To: <20260628153956.1435330-2-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Sun, 28 Jun 2026 17:39:56 +0200")
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
	<20260628153956.1435330-2-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Jul 2026 16:57:49 +0200
Message-ID: <87y0fpmqky.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGga3Km2k4N1TrkgFXHisLexpx4Zdgds5crb0+qkGIxdXvJXVSdeckvYxXTIMKQs3IMCnyAR19z2nh0XvbD+3Jm0gE9+yYzmRMa/6gWi660vg7Z+gpcwjqNZAJ/djbcBowlWKzO+iCMaTUWg3XUoP/VjhS20QnjQEUkvKqzyzsp8YeYp4ccwlyTlWuSwkXPylEFWGry3LwajbeCwEinFnLVyIFQyvH1VY4hbQnFjFOtPrEOAiURBuFQmhfRzUMsETvEFTtHKS/AO6rGcd3SJ67i3yYebP0pQ/QQaRQc+NtmVWF+9KmMDwrIS3q1RXz1CnIPjE14G7KGohuh8ehNlPqQSDR/Azj+/PpX54mCkVO/KYtjvCmktQIcKtytTkD3A6vKaYWF+pRzi4YPZQ5uzcju5PuyBLZriiKc7yJM71Q4TgvDauuKXDxxeneHuQzH9pzra0IOOG24Y1gOFpfRLQVS1i9oq82I+2XleJl5uoQr5mlIBDCc1YVDll8tMR9oMnvbIjmngfyV6OTHxCScS0f0eZTpnq2qXhT5br3+Txvr5p+IvSwfVz7q0C7jaSS7TaYVmFTXABpa21m7SEARi5MgM0YMcTQ7g8wFcKh+qGcsl+yMnQUpRKUkAcDhkPLu5BVsz4KBVIOIpF0RGbHtLeY5hxEt4/RPuDCiXpXuOQcX8w
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> This tidbit allows to ping any host and measure the response time.
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  tidbits/meson.build    |   6 +
>  tidbits/oob-net-ping.c | 480 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 486 insertions(+)
>  create mode 100644 tidbits/oob-net-ping.c
>

Thanks. We need this to build on 32bit systems:

--- a/tidbits/oob-net-ping.c
+++ b/tidbits/oob-net-ping.c
@@ -215,7 +215,7 @@ static size_t build_icmp_request(uint8_t *o_frame, size_t icmplen,
 	icmphdr->checksum = cksum;
 
 	if (verbosity > 1) {
-		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%ld\n",
+		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%zu\n",
 			   sizeof(*iphdr), sizeof(struct icmphdr),
 			   ntohs(iphdr->ip_len), datalen);
 		print_ip_header(iphdr);

What about turning this code into the (currently missing) 'evl-ping'
utility? I believe it is of general interest to any user.

-- 
Philippe.
