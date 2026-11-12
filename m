Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488965;
	b=Yi4NfhAe/gSd34dkgdj6w+Z2yzicaML1eRCS0kQx9ftE/+IvPRVPK/CWNwayH8POGl7N
	 jFQ6tQLQR0GsaFX3aJ813vMIFRS6PjW9db6EhS9IjToyMsfvOpkOMZoTuCmJHr8jczKnM
	 yVw0QKsqGcTxQjBKZjZhmPmPmuKGWUl/R2n0JyfoRUNsktm9Tj2WeRfT/phExmYkJW4k9
	 5RUCkhN0kapcHIgg4YoQ+JE/myrWs4bZZ76PuAiD6sY2w6Vjgxd7OjjgMlKMVDD/W6CCp
	 26aJi6SW3IHrwoaVzev2uClVBVdZqNfhHnvYj/6LdBiDOiPIDeBN8URKCr5EoEREQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488965;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=TiAa5z3mg80itqPeUqpJso7DxOstVB1sthMkWmtve38=;
	b=bgMEg9TITSKy3nq3AS4z9j7gqHiflCaD+k0QAuXcc9qtqnQkGrJZv/G3kj8yetB1o8Ga
	 bS9Hny9c1hsyXZi7XF0ulH02/lU8dFbRTWroyAAXNmcVirdhXwTfHm72LLQdI3bXKA1US
	 9bvwf4MGs16j17zAE/pvTRq7DwPLRi2oFmBAE45zCQUtczRFVWvLKwO8YqUNr+CgYK1qh
	 dgkJnCqSQgqFVj9PTgU2frTRYKBE0Qas8vGdhtgPE9Fg/OGKqblcF78q4WIMcWVixcBUV
	 nQ0zAUpY4d3MMgqKxcLdyDDRzBooXaA2amOhnsuXfb7ODWf6c+M9TDVdL9Ujtwweang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Zmwb5xAf;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D0606A323
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Zmwb5xAf
Received: by mail.gandi.net (Postfix) with ESMTPSA id 972911F654;
	Thu, 12 Nov 2026 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794488956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiAa5z3mg80itqPeUqpJso7DxOstVB1sthMkWmtve38=;
	b=Zmwb5xAfIQwY7+rk9e/TqI+eohSD9ibEWZK4fg6y0B7IGEtVyunW+868E0HtiakB0w5q1B
	yoWWBTG/72JGDhNAvXraCULvTnGXN+OlDqjEhtkxWC3oplNRwlHMVcuGHjS/se3cpkaKaf
	gVN2LPy7ZX4zdw13hAmAv4jcMiL7cl+Tk10VNWbBiShDXou2s5uNcqKszm2PqoIdG78vDx
	lfp49QSYH0jA9K/Cob16HHr998X3LWF+V92IF+7HsYZrUCK05dlR0HXcHI8PlBduIQibOt
	7VxM8eLF+sWqDJQa7N3Fwu7OuQopoGsaOK1GW+XmzKCDIWOJJFQPUHrsLcWrGA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] x86: dovetail: Drop bogus
 local_irq_disable_full from __bad_area_nosemaphore
In-Reply-To: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 12:32:25 +0100")
References: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 14:09:15 +0100
Message-ID: <87v76219j8.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGnbZr0ZNHcy9aRLH/Whf6k4tmKmOrAJKEes/BlqRXhL6k/ZQfGMH5dbdquE77o+rv0CnkS9U80ovJPDCUbQuwj5XBwyf3xlRJQ+mUebvP5shGAuS2jle3zHc2A62i9pS9DGjLlKrPPK9V/izUHFNpl17KRz3k6ABXYa0XPmYnOnEmUKhRcmw//m5gUVlCM92OSaKkWEYuYZ6AT7gvianieb/WaojiFMFWlhfudU51IXP5B+Q7TT1d/hhuHjQKGQeaVzwrdXdHcUOVDsMNPg8Vdj9cCyyXJEnvIAyBtPF8gDzPrxrr/gMMtznMG9KIVga2HhPiFH9+17IK95LSbiV4OtJAXyi7AB5grQHZwWEULKE5g6v0UeJKXhKjMVVUipod65ZM5QDwUcHWBN7RQIhO/iRoQvOWIDonRkJHMhEAkXOtxUboAboveMWjEMAkzrp2HnMNgpn4uaN90MX5/g7E1DO3JdIu4KHitvBKvDtPanBPgF8CslhvPiKM8iSFDEa2uCCwg1JLK2tkn5KQ1xVUJ+XlCnB4mnTZKB4CaQEcJB3dfM3QKwqLjdTOw6omTpCWgGqSfNqjbkH2pRedsvcdjO9whnQ/6Cr7xcyINyhT35qmqo3wmgNToXaN5/GAgt5SLXeo87S/htWFS9T89OtsOynCIGO+R9EbwWa/ys9svNQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> There is no technical reason to disable IRQs here again, neither when
> the IRQ pipeline is enable nor when it is off, which this change also
> causes. We are never passing this point from OOB because of the
> !running_inband check and jump earlier in function. The inband case is
> identical to the !IRQ_PIPELINE case, and that one does not need any
> additional IRQ disabling as well (upstream code path).
>
> The addition was most likely a mismerged during the forward-port from
> 6.18 to 6.19. Remove it.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/mm/fault.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e41ed2092730c..e9a08a5d26e60 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		force_sig_pkuerr((void __user *)address, pkey);
>  	else
>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> -
> -	local_irq_disable_full();
>  out:
>  	oob_trap_unwind(X86_TRAP_PF, regs);
>  }

When removing such code, replacing it by an assertion like
WARN_ON_ONCE(irqs_pipelined() && !irqs_disabled()) would catch wrong
moves.

-- 
Philippe.
