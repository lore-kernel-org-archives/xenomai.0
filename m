Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EB3D566F
	for <xenomai@lists.linux.dev>; Fri, 26 Jun 2026 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454565; cv=none; b=fbW4/vU34a3m1UYGflfW8iEDr2eq0OJbbCg/g1dTYhuk9dR3TKqDKKaenhZ/c9+S4EZZz7aVpJvAVoYl6N7UZ8AnCRNdvkZxmXGbzjkODYurpA9Kx+oHpd2cPHptU8MGA3nBTh/Z1/uMGNJLhIr7AQHBUEo2Za19rxnW0GTukVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454565; c=relaxed/simple;
	bh=oJkiw2KRYkrG8kEPO/SO1ZE1XVJ3TYhZt1OGmWa7sH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENekuU544m32bo4JarMPfHYn0mbE13sQj2klzb50tDtG1TLwHudPfbUd7Ckpfn/OKGPQSoBvgRenW3qLKThl4sWNcMN2W3Bd48LlaqhUcqBvTDfJXzA/mWFs3Tdlck8fB0atiokKx3BwhXistMPHe0FaawMPCdnZmzz0hN7hz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bobZzoEn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bobZzoEn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21A763E802;
	Fri, 26 Jun 2026 06:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782454561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOTO6V99caGYkN/jKtLnnFy2b8rCZsJy0o4cM/1GUvQ=;
	b=bobZzoEnbJ3NzbWoiquMcg1647uFg6RZUT5CMeYOIES5xCsmeDkPRdNMqn1fljA/utMXbp
	SHftcY0tZ8olAtou+6Gp9hoZzqLWAT/8V3VeU74J2Q67Z4W5yyzN6UPpLsU4hpp5/BXM8+
	ZrNYGFZky2QN0Qw1rGdXYkoweuB2OdbagC0oic/P3RK6FG1idyYNi9UT8/NytuHX1LrriY
	3XO4B2OffU8gNbKVfcYC2RZJCuATj5tJcI5HTcJeAipP886h82QDqM7DR0PpgLHlO5QCfO
	07S5Sfsn9UKB38Yc2I2d1RHVmU7h+3H2sTWXKcDsH9qrhFoVMtgUCNMSZf+nWg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v3 5/6] dovetail: Decouple
 kernel/irq/pipeline.c from irqstate bit definitions
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-5-230f03227abb@siemens.com>
	(Florian Bezdeka's message of "Mon, 22 Jun 2026 10:05:29 +0200")
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
	<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-5-230f03227abb@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Jun 2026 08:16:00 +0200
Message-ID: <877bnlrfmn.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEXThQh8gjVsU/gA4FD50ZRfcVj2gMBSQpQdlFmyjD5heZQASEjgWwxdBLM0ITXlB7HmxF3hxnaDE5tzXXP/oMGc1qv9jNUv4SU4gneLFBgqXK4C4Qa/9zTFR5KWofYiqUIUVeXKD/655WZ9YVQt/FB7YFNbORUrx2HDiNFSthx6ke1zHa4XzDLgcnaOysbNyz0XScpeSgD1qcn29PgQw/w2AQw32SeLofv/McIV9IoQurfzagMcPQGLAUlg5GyKXKuAGg1PLUu4LYoLWzX93BlSP/N3NyBweV2nVhQ69vc7QE77WM+hWYfQ63X1XFytfUi5qbgpZJ31oGS34rbRWyiQD1NvfFS/+zXKuPFugySjESjbuwOdAqNmDsmQDCHImUKCOR2/QsUYo6oIBRYSTPSCEHxXBWCHKHFiuiPg/DmZM52vXmP/b9UV7xBTSltm1PZDxKsA28e/w9QEhFB9hIzBVu3tstNgBi+41/a/z/gbmkGZAcrBl3NzWBTQhH4GbpKMXd7X88Au3/Fv+XbVkh8UotgEMICQ0SRXTvqYSbc6JE8go+RdyfJEHMPixTJucr4grTEt353rVTr16ev+17HUetinQjPOwx/PzxX3FnNfmOKmkB0Dbm1BKSnWOkSNsmFNVaFRfnsTKfxwSx//CDKFMEseuo11c69E6T0vtgcFQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> This only affects architectures where CONFIG_GENERIC_ENTRY is not set.
>
> Moving the stall bit definitions into the architecture specific
> implementations allows re-use of those definition within the arch
> specifics.
>
> Moving the defines to include/linux/irq_pipeline.h turned out to
> trigger a lot of trouble as re-use will live in asm/ where including
> a "general" header is quite hard.
>
> The platform independent implementation will now need the following
> arch specific hooks, all operating on the platform specific
> struct pt_regs:
>   - arch_kentry_irqs_enabled()

I would go for arch_kentry_{test/is_}stalled() since this would clearly
hint at the stage stall bit.

>   - arch_kentry_lockdep_set()

Name could be confusing since you also have
arch_kentry_set_lockdep(). arch_kentry_test_hardirq() instead?

>   - arch_kentry_clear_irq_state()
>   - arch_kentry_set_irqs_stalled()

arch_kentry_{set_}stall{ed}()

>   - arch_kentry_set_lockdep()
>

I would pick arch_kentry_set_hardirq() to better match the general
naming scheme you have been using for these helpers, fixing the original
misnomer in the same move (the idea conveyed by the original name was
too vague/broadly scoped already).

> diff --git a/arch/arm/include/asm/irq_pipeline.h b/arch/arm/include/asm/irq_pipeline.h

> diff --git a/arch/arm64/include/asm/irq_pipeline.h b/arch/arm64/include/asm/irq_pipeline.h

> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c

Please split this into separate commits (arm: irq_pipeline, arm64:
irq_pipeline and genirq: irq_pipeline).

-- 
Philippe.
