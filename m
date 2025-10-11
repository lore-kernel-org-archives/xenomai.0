Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6604594A
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760197699; cv=none; b=HZyJn1EDhUqdKOFtcpnTS5l3vUiWbxRY6qqH3lEtlD5rOCbM5ft6FgUhN1xCUs8DXp4pHPv0eVohQKH7hQbM4aJdv0vFQyrRb2uTHrTM2ql3l2zaG8OG+tdRh9bVxxSQYfv2ieElteZuJ5rNxiJlzRxcLhjCdHs57QV8GPhsVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760197699; c=relaxed/simple;
	bh=jqv88WeRU1v3cTrB7+XAea1OVNSe92YdFEeWEtl/+0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouQSv5f6r1OyJGJd/lZoXjns029mQkArzhgLoE/W12lhvpymLQvop2DukF4QB9hjLQwka/YUVnrzENRkzUnm3f4MC5eY4pncAlZqsqf8wb3t1ybI6jqrTcKQJbeoT8HEqkhD5UIoz/LkKT6le4xuHmC4A6+U8ftyJq3oP/2GbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=RCx2pC7O; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="RCx2pC7O"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 0374B580210
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 15:29:41 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9653F442A2;
	Sat, 11 Oct 2025 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760196573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0cFwCwfOI/dClmMEfVe756qVLttlzu60UJAHT9EKpo=;
	b=RCx2pC7OfgQ0pAgXPEiTGNJhL6zOIPnz1fywMo3cnJ+gn05hVF2gb4XP+6vwEJ7+YDsYT7
	rgnYWs1DLFJF5pSHKD062KrP7DQT76Q9JKVlcCX7TrBuF0/oeS2XZljjU1vHbNSrv48yEm
	I3ESrJWOdU7fCbr8dMOfmLgbpA19hxykZGf8Pt5YoWx1mMd3AnUC7plsH7ISTpFos23bMJ
	JcnasfK5jBDo563/irIy2TyVT/LlnqHnwcH1cKO8k7Qv/WGRUGEkGCvMcqLa2Nf+smPsH0
	MD2DNVK2bWV2DbrMKCihj+0JivIzyAT8Y98fLGTVS2QLYhakup6P5SNv+2me4Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] latmus: avoid segmentation fault on cleanup
 when test_ulat is
In-Reply-To: <212b2539-8dac-c61e-0bf8-5cbcf4aad365@bela.io> (Giulio Moro's
	message of "Wed, 8 Oct 2025 17:42:43 -0500")
References: <212b2539-8dac-c61e-0bf8-5cbcf4aad365@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 17:29:33 +0200
Message-ID: <87347ptq1u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> From 98a8b8808cfc34e20684b4298f554f353eb1468a Mon Sep 17 00:00:00 2001
> From: Giulio Moro <giuliomoro@yahoo.it>
> Date: Wed, 8 Oct 2025 17:41:03 +0000
> Subject: [PATCH] latmus: avoid segmentation fault on cleanup when test_ulat is
>  not set
>
> test case: latmus --sirq -P 90 -T 1s
>
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>  latmus/timer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/latmus/timer.c b/latmus/timer.c
> index e496d0f..ce44ffe 100644
> --- a/latmus/timer.c
> +++ b/latmus/timer.c
> @@ -159,8 +159,10 @@ void run_timer_test(size_t histogram_cells)
>  	sigwait(&sigmask, &sig);
>  	pthread_cancel(sitter);
>  	pthread_join(sitter, NULL);
> -	pthread_cancel(responder);
> -	pthread_join(responder, NULL);
> +	if (test_ulat) {
> +		pthread_cancel(responder);
> +		pthread_join(responder, NULL);
> +	}
>  	pthread_cancel(logger);
>  	pthread_join(logger, NULL);

Merged, thanks (short log slightly amended for brevity).

-- 
Philippe.
