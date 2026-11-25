Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616105;
	b=R0FSXoLrD20Cn9kmp1sYz6ujPhNKlZBt2Ttvw07ps19nDXBFSTRAnK6CTBeBZ8MD/T4h
	 lpzUkAx6LKriRxzYwf3zuek6hg6ZCF88x4xHqZyBTRAnSN0hL28lwD/ZX52Huf2eDfxae
	 IMJXW4NDJWyF7ZmgPc/Yxn8ElKQtQG/xlDb4PpLSLhTpmk26Ak0tKod20tWJXL8Onzv+X
	 D2GVxiM36OpekOUpEtqomXtcYes4eCipJTm/6XZaQU6uGN8/sZtQCc8fwI8h3Z4p/g4cU
	 MsLGIfEoc66aVl8a80woLVhrstbqxJrZv4wFAg8s+h/1Xnxp7BFLrjrYDssitCzmgVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616105;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=ZN/EJIUIdSuwCNUTT9uQsS8j9fhg2xELfvKOJaCUksM=;
	b=LjJmPPJSNeVj8TPm65rqHFYhdR0nbO/ubyFBfdE5ZMmhLFTvaiWu+2wmfzFyNckSNz0l
	 amE4Fnrw/cEjgKFS4OHQ38KeNu9JyL5ipsrySUxucMpKHwFO5KmlD/VOiuTCoJ8ZjwPll
	 2P5w5YPRSWoiPHskwMVuB0n37dev9BNy2Xt91aq+lxw3ZBUib2+E26/FIRdz1slCR7pj7
	 B52kRfIB/wxCaz4o89wvoVi+X/KkRG6/Mi6g+azr8RaslLcqKTgXpS1+9T9fAMoPWVLWh
	 k8ZupBhH8uPhNTTSTVuQBLuKZD4Gsc4JAyDCd+4NFL3tU6LRLxUkTjkg90ZpxqLmfOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=bpkCba5t;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327C606A33F
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 14:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9327C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=bpkCba5t
Received: by mail.gandi.net (Postfix) with ESMTPSA id 183FE21FD6;
	Wed, 25 Nov 2026 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795616096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZN/EJIUIdSuwCNUTT9uQsS8j9fhg2xELfvKOJaCUksM=;
	b=bpkCba5tDOFfZW3L8KuiVrV/1dK+o38Gvfm9Qm7FZ64KJlYePWeNbgFVLZhowktEGc+Mkn
	G/4RCvIoebiouEJzCBfzOWdq4+cWulfYmZxnwTJ2fKQkC7PTAAi4vdX80wk0C2SQd3MS7e
	7Q1cN0k9Msjq1V/ibaoFqhXzNWp/4aYCQJ8km1GJHxNo+kHOGE/lUVWtB+RXkCpsHlGsUk
	XQw30t6WnkGx4H57Tmk5IILaI3UVOvSEPDbyxlrvp6MF734fFgNv/Spkfm6Gc/xwVnX/yQ
	O4VXZgbCo41l7pVu2iRgmtPDja3doYMjIxIfxiI/jLIpTx/Y//o3ULzWi12EeQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dmaengine: imx-sdma: dovetail: Fix duplicate unlock
In-Reply-To: <5b39f820-a86d-4265-93a0-74b5569b71a8@siemens.com> (Jan Kiszka's
	message of "Wed, 25 Nov 2026 12:44:14 +0100")
References: <5b39f820-a86d-4265-93a0-74b5569b71a8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Nov 2026 15:14:54 +0100
Message-ID: <87tsl50zhd.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEC+nPDTban0y0SuokQkUKYraGkBNPMU4IxPNE/G+Ki0X5GifnZaBdddpMhpm9eisZHdQA5VBbtrWQo6bT2vTUpFD06VoXCKwFYdexZM76vEmHkFUdK8amKUuByxc72X6zBb5AhIby8xMHxb7jNyKiFGV139bkV7vXeTcgswI6CNdlLyRAspp1TvtpkucYv2J1u2JH4XUTKpc3gTwUwGFDqr4PAmPnKSBbFABTu3BO0QqJdtn95V6GoO0ofUzgXGciDB4G1NQK30RARZM/ZGBRrt7IrLE3hu5N3JxyKiLnvhj/jwBjkUiA1RgmXBzkapLKda81ejqRCuXnLbL0y71JKQ4/rG7UMAQt5Y99jaqvwrIFt/tLr8HnCyKBRc+nf9jcv3mJq5W2cq7CviW2o03drTWrXzba7jz1y566c6m85P37KvOQR4vlurP7SSdHpnVsgU9kdpqquRk1CPXDb6sJ1CGmzEcCvp6vApJeJ9EopHUApgcqGVbHuP6yYlSgtziKWyo7K+P+x5hVTBQGud1YIdAP3AIWKiHxMYKCrAufIocK7j/rxsd7gWtopBMix+fZq3oYT0Qdt5cCc2nxrJWjqN3YydKyB5T+rD5XvWTNILdEWblKkOy7J5XZ2bzmXC0I1NymTB5IDv7bjQrOJngk3KJWEutUVc1n+zZJTm8O5IQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The dovetail conversion forgot to drop the spin_unlock which is supposed
> to be replaced with the vchan_unlock some lines later.
>
> Reported-by: opencode:Opus-5.5
> Fixes: 187b1d6237e5, v7.1-dovetail-rebase ("dmaengine: imx-sdma: dovetail: enable out-of-band operations")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/dma/imx-sdma.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 22c7cccc60179..5414df2269d4d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -986,7 +986,6 @@ static unsigned long sdma_do_channels(struct sdma_engine *sdma,
>  			}
>  		}
>  
> -		spin_unlock(&sdmac->vc.lock);
>  		__clear_bit(channel, &stat);
>  	next:
>  		vchan_unlock(&sdmac->vc);

Merged, thanks.

-- 
Philippe.
