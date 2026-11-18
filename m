Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992880;
	b=38/OppyrjD/la1imLAakXo7p1vprSIWMkq/fvMyAxDBQ7PTscKyzWHL7vAMPb6NtBBWN
	 324wR8H91I48EQXavFUe4gHKJ01wpnFR3EYX/UV18qf64nzW8qvwOe6KzUcRW4+2AK8O/
	 Nl67kS/awI+SM7E4+7qSNCaVPehz66H5rMAEhLsmM91Rek2DIuFAyIuMAFKx0Bb3MjHTg
	 nGbQU7xEF/ONDG5Yj9x4LC1MbMqImSaxTnItl099MVIyy0JtIEoNciNTNKZ+5hsFhNyX4
	 P7G6f4oSeEnzP9yzG2vlG2jB9ASJuhu3y3HDUFDXINoc8eJHp/FZa4uleA3ypQxSCag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992880;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=El0UwsZAM67WqoTzbdVYmDUYU2BJqfpR92eHeSQIQDA=;
	b=2q3W6yb95p9AZepSn5eIEal4R39UOo5vhImA98xDZT15gB2za8YyAkQvWXrp8NNZM5RC
	 w5qbYX6YgPOO+2g4a5X+BZjgbO/C8ZJULJkeYlbtoBP6DsEP097k567ZJMEUrMrTLJu98
	 ofoXJihh3/DYFyrFQxB/yWhYARJj/htreqEnPSiXhkYW2clYBwfB0DVoh7lcTq3s45GeM
	 oI43FxVAuIabB9jPfLOwpN5dA71zh1xZAtIvgV0GIc8Uu6qOpqljp9jKbZA2hxYbTuXx/
	 syTLz/EjOnKykLnHBJWIpK9NaYoQ2UvX1V6x2DeZetzkKgGiqcy3y1NnpD5lDMSLnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=QJz5usEi;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D5606A32A
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 09:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C69D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=QJz5usEi
Received: by mail.gandi.net (Postfix) with ESMTPSA id 294BA3E97F;
	Wed, 18 Nov 2026 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794992878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=El0UwsZAM67WqoTzbdVYmDUYU2BJqfpR92eHeSQIQDA=;
	b=QJz5usEibvGN7ugGmzYKDqaBUcj93gHIl8iAPF8d3kALOM+WBSAaO8gGf4iY7Ajdd8JkrW
	1yqSc7WJqQpnzmlYxaHRgQXDBj5dEV1wPJlkUiy1FKjyB/b5JfVCpNHUCMY7LZ8BNHrlqT
	MVdTrLRE4l15iFrb7yoIdIPymDVWccU2wVXSisXF5+msjcgLMsJdwh00T+gnISW8DwHwjo
	ZXHVAWe3z8jqyGsAtbHivqdj6yBoOlEExLn5BMnLGJ8KO21sLimqPrZAyRoqnnT08Dmpxb
	CkmUFpey5a2nPq5DjmBs3j6BD2YmN+OQBLNoScvlc311S3tfIf8ruLBzwxA6kg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] arm64: dovetail: Multiplex IPI_KGDB_ROUNDUP
 via SGI0
In-Reply-To: <1690feb7-cb3c-4e1a-9b35-0a564dc3ee9d@siemens.com> (Jan Kiszka's
	message of "Sun, 15 Nov 2026 15:14:31 +0100")
References: <1690feb7-cb3c-4e1a-9b35-0a564dc3ee9d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:07:57 +0100
Message-ID: <87y0aqeccy.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFGpuT/UoUoLAJQ5E5ox428v9dBEI2C/tTRwy/rapErHwTBS1dlwYX6UB2MlJwiAwrL90qrC2L7yHaexS63IXPZnKra+bia0DZWiMusPwZr2ovNUpBLjO9ZyBG4wvD569n6sd/z1gKA9m0IqqyBrVpjBe1dDVtBMuJeKZAEXQV5ExBAM5NgZRWXJOlBWbPI+7dyIfQfVJU3HGeIw7qL1sqpjmtag0MHWiRRHCnnkKzlegb556uLR5TSzCknBhRwdlIoPiiVHmW88PWSkuIlD9f1KGNIaXXsN8VzSHwNcxsVRrOJ1PBMb2scbaIbroEcrSjhiA20XqRz5IfL+sARbdlyqnkvt2QO2pjoM7p13NDL8jGp/vw+hiI6fWFUtohhhoEvtMSno3dumPd4El81TyAY8mdR3uz9SN6hOLpaIfIbC4dMcIZJKLCttjQa/RatxpOeyAoaslgCA6I9g1xlpZvOotRrjLY6A8QvwCV5p1SkdqG7uetzvpnmP78Xt7i5+XQdfFk4OTtsV/99G1cGpL0XAQFbVhSIIEdQsOhm3YZPRZihEa4V/YzJGNQNw1V4YxQ0w1Uzv7DFmztfpVXXOXkKETlbm8uJOozjU1elZp2NIx0RxVfXmXLTO+pwDtWnWBKClweaQ41h0l3+b18Bxtxut1pyiYtxHTYSDchPGc3qJg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> We still model KGDB as inband service, thus have to multiplex its IPI
> accordingly as well.
>
> Reported-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index ceb9840c35eec..be6b428e91e48 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -987,6 +987,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
>  void kgdb_roundup_cpus(void)
>  {
>  	int this_cpu = raw_smp_processor_id();
> +	struct ipi_index ipi;
>  	int cpu;
>  
>  	for_each_online_cpu(cpu) {
> @@ -994,7 +995,8 @@ void kgdb_roundup_cpus(void)
>  		if (cpu == this_cpu)
>  			continue;
>  
> -		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
> +		ipi = mkipi_inband(IPI_KGDB_ROUNDUP, cpumask_of(cpu));
> +		__ipi_send_single(get_ipi_desc(cpu, ipi.sgi), cpu);
>  	}
>  }
>  #endif

Merged, thanks.

-- 
Philippe.
