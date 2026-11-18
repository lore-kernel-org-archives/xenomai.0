Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992873;
	b=AQQrJANgg3q1Ix690nyx/d5iO6g3+Ym7VjaM86blOd9AvIk1knCduTTDvPi9pFO0AWIF
	 a5WyiMjxfd70OG8Sxt5/RpeLv1ghQEu7hmYiHSDrEmoCwaLg1toXwW0QEhjNyCjnr+FEA
	 DOr+YyTOIFsEd3pW47IT5kMPZEddNlcvSoayP4/BeEQy+yt5FZ5A1ObbyhfGjHGa1Ct96
	 gDOPrYDjfMLhXSLuKKVzYEU8gyO2djN+9m13s15BfNg5x9BfCagumnifp5FRm0IOvwj8r
	 PO7idmBuedTBpHUxaBt1ZSMYaq+eKESBFbOMieqtMrHZll6wSLpPHpNUG94/kBuNnlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992873;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=ZuO3CixUoUprZHxogWZfzZt21jygb4IeP2kZOw5wQ/k=;
	b=nJqg0eI9yDPITEnhTmW4TMkCefzcBnDPBjStJ9kXjoZRRewLjBEulhl6DAqOdmcyoCUO
	 oVLcfW3RGI/DUMrEWgA5mKQsauoqE/Ym1m+aJWov25fqEHXcmbeHakrgJ9f8tc7aYG7rZ
	 r3p4ZTH8rqAsQUc/KwUr1VgtOeJm/ym+sBqM4qW2cWWnfQUjwqSNzDksutLAIZTgsxxcG
	 1YBo/d8UjjvyuxRYLgwGNgAJQV0aGJidoYx5kQ+YWLtuemZyvW5Kf1X5WljsvwC20IGgC
	 wne028afNBpa5MQAQhV/n1lietExwb18WNxjty6svSgy+UzaDn4htJWzdlKpZu6Mfyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=jkTus31I;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A5606A334
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 09:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2A5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=jkTus31I
Received: by mail.gandi.net (Postfix) with ESMTPSA id 122C93EBB0;
	Wed, 18 Nov 2026 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794992871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuO3CixUoUprZHxogWZfzZt21jygb4IeP2kZOw5wQ/k=;
	b=jkTus31Ig5MeZxqdOcJ+Z/O9SBF1MM4TTXgZJ2HsuxnoyzqtTVMp5xRq2NYsoUIWlVOpJu
	U7SeruwAmLx/U4PrGP+T+ry5bYhE66RGMbpvslH00XffJyGIFBKkyRRdD0b6OXk0dL64KY
	RUqCcYIZx/QULjJ+Hgk6n6wQIW1Wn9Yzkd/klipD+l+2PcbZVSs3ewdru6bGvU5ziy/la+
	10goHYTHfdKsGT9Ve8aEVggNpKt2DOGSBDMUetyRqqb5XuwvjMF/zYTm4GHyGSewVSnrYx
	p9PdMp4xR44NQC2nVqPFynMnunL2fb8flzbik4WAaA4I0U99DBePHW3pzEZ5/w==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] arm64: dovetail: Drop unused mkipi_oob under
 IRQ_PIPLINE=n
In-Reply-To: <83b1a47f-5493-4afb-93cd-525425db7f92@siemens.com> (Jan Kiszka's
	message of "Sun, 15 Nov 2026 15:14:28 +0100")
References: <83b1a47f-5493-4afb-93cd-525425db7f92@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:07:50 +0100
Message-ID: <874idefqxl.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFsHVTTHJicWckjnETr474oKXdEpNbpSO3FFzhI5p48mrkivAUBhC9FitF2yVZylEESOG9qMauLkuoGe6Lk+ZjoIoqqlsPi2R4UvJL0/9cKGUi0qhoQABWXqHJDn0v15RZNV7LVY/dVbU513xauMFo2wGKdEL4t3VUEKrmu+bCALtzLmuDShMhZ/SoSN1l7piyWwZw3XW0xWWmQ+sN7KGnU3gL/cUUCCf9d8IJ1Qxw+kIv5Mn/8uxdo6ZdJ8L8amt7AaUtdPxLbzaYvVStJF9Ix/6ANlZAQEoX9XZQtmhsCB+htBUn6Pmap0o40JxE5AEKUBBz4DoGJFDfniPX6lPpGPVP7zNGngf4Y/v3MQzUKDmPxinGGdl3fJi1Ey4S0bOTT3qbKc8Gyq2Q3cMNtKI7scYPaxlHK6a6GwP7ohubsS1qOsUW4Qr2bk7CGf/1DIt0vuBrIp6QIwXDbOwfQfiZpaprSmYJF3Qnj8H1DEr/l/r6deU55vu5oc+Q/nwq8tf4fszZx8j5xKQv3Yxhlww0lG4LhCL0yWvqOway0TZI2trMWQyxrlEtUHvtPgPQG0Cua2RxSOfsN5VdDHonqHZC9ABumgTDOnvu8B7ve9VVLsYDRF8mL8hW4Dka+X8LaiQBZjfpeFiVPWTWVB/scYeH5C+p+1TFNgwkzjzQ4pcUX7w
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Not used in this configuration as there is no OOB then.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d018226c17256..ceb9840c35eec 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1166,12 +1166,6 @@ static inline struct ipi_index mkipi_inband(unsigned int ipi,
>  	return (struct ipi_index){ .sgi = ipi };
>  }
>  
> -static inline struct ipi_index mkipi_oob(unsigned int ipi)
> -{
> -	WARN_ON_ONCE(1);
> -	return (struct ipi_index){ .sgi = ipi };
> -}
> -
>  static inline void ipi_setup_oob_sgi(void)
>  { }

Merged, thanks.

-- 
Philippe.
