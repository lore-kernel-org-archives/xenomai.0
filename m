Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6B3B1ECC
	for <xenomai@lists.linux.dev>; Wed, 17 Jun 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676619; cv=none; b=oR3HVDSzHC4XH9dtV9PT8mH/FauDz/2gtcLYqWa5lWillDQDasgVdz5axxY7fEzlT86ldgmeSGnenH0X4s9kR7JTcxWRjj3X9UmEr9ZKXssMaRNqWoV6CC08VOs8SZuqbZUohW4Iem88hmoqWbJ8kEab2OhWw7N7VDz2yHf1PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676619; c=relaxed/simple;
	bh=1E5eunNUuRPDFKI6DqDy04VNFHQf+943VIp50al+khk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euZGUQRHNhqaJc2zAoaj2rXyBEAmSl3+z7XFJHCMhqF8wPoON65oNbgC7DxDC8nXddy/U3AlJ/6ZYPboS7GzX3TwmQGY0djQnf6+OY04QwBljX9WOWT3l8Ndvhx0Jo0+RaODcGv7fNiT4MiAMwIALErK3vBDyeltnHLmnOy/xDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=IHUBZdvS; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="IHUBZdvS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E5273F6B3;
	Wed, 17 Jun 2026 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781676609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmzVJpY3gGiLtaIYIwQKznZyIEc4JvfROwUyhJp2D20=;
	b=IHUBZdvSHX10M25GplzN3qPXWm+AnvEXgaOoiAnnAbavk5QqqiKCMcsxbOWK8gUaZuPlaQ
	07po5DnVf58hqyUF/+jJ8+vUGOspuPK7Ti7HzAHkfw36cubypSjU8gk9qPnGLwZcgeRNEz
	uSY0vubmfZLTqApJxrpuf4nT6eQ1JXERPk0TE285dn96gYKjlhGOUP/ExNUpmCNwLEAJcE
	b8PTZcumoRvbN2947OZE4B//CCmkvIfmVXCWED5FUbNquLy3ncIxKM0MbY66/+Z4qYYT58
	m6nIwrHHu7w+s43ZYiie9j02i4mey3aYB82TSteNy56JE1h8ttHp4Yb6eCAgDQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v2 1/6] arm: irq_pipeline: Fix
 fault_{entry,exit} bypass in do_kernel_address_page_fault
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-1-62c9c477f8f2@siemens.com>
	(Florian Bezdeka's message of "Wed, 10 Jun 2026 11:20:13 +0200")
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
	<20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-1-62c9c477f8f2@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 17 Jun 2026 08:10:04 +0200
Message-ID: <87o6h97l4z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGM4wseu1IhyD7YRSng1/SElgcaX5oWom1ycVk4q+rjtsnUB0sijWZ2zT9BhXoFBVERIZPQp9TldB+7MPm8Wqi6y4JIafslNZs8oCQLB4EQoVVTfV2Duf3HNy5k7apE6q+Qh6Sykr7udYW9U7vN+9c9HW56Dfj/T6FjV+NODTZF94zKEYHO1NbP+WY3gcMXxN7bU/AGYQcFZWy88lVu8n7PJc2kUiKRloa8an/scwly4sOGXcjs4okbWw82KTDSoheqlUKhAehivK0VIYMTeUOTC0loLoCwS+MMxkCfqLq+dM+PkHBtxE1w39nd9UoFMHJln16CoMHuM2VOmw+9hYD2cw3cK+FOOFhH2AcEptHwwt9ZkYUJpaAmHD6mZzz7MXyB/BEd08Xhd8HSdZPUXRUL87PuPNT41szWPfcrDkdLaE3HKI1WMbAl1XU3pKqffy5I6DQX99YgmLFrLOnzsYyWGXbLyigRub5qa87MfE/kxfw2sgi0ug+m7j6ixByuP+9GZMtrnq0BnfFBL+7gzS/atfDRZ5lg72zYt/gXgc+4otzWgqEMin1hhXUKWeJFjcTGN+OayCqTC2ObN2O7VMSxjaiGv/9tkV0G/3F/J99YI5OhJZ0Z+Tw0zLbKcsKMi7jxABqp1zrZSj1pnFPjtDeUKBF0WfyRrae8nBqQPygerw

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> In case do_kernel_address_page_fault() was entered over supervisor mode
> the fault_{entry,exit} machinery was bypassed. As a result the inband
> IRQ mask might have been touched from the oob stage.
>
> There is another problem with interrupts_enabled() in the supervisor
> mode code path. That one will be addressed in a separate patch.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/mm/fault.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 49f5d628c4c9a91a3e879af0d541fd76665d78fe..7a5c0a5a825df5f76eec6aa341d910c3efa63f88 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -382,6 +382,8 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
>  {
>  	unsigned long irqflags;
>  
> +	irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
> +
>  	if (user_mode(regs)) {
>  		/*
>  		 * Fault from user mode for a kernel space address. User mode
> @@ -391,9 +393,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
>  		 * Note that __do_user_fault() will enable interrupts.
>  		 */
>  		harden_branch_predictor();

By doing so, you move the Spectre mitigation after the fault entry
handling, which means past the in-band switch.

> -		irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
>  		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
> -		fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
>  	} else {
>  		/*
>  		 * Fault from kernel mode. Enable interrupts if they were
> @@ -409,6 +409,8 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
>  		__do_kernel_fault(mm, addr, fsr, regs);
>  	}
>  
> +	fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
> +
>  	return 0;
>  }

-- 
Philippe.
