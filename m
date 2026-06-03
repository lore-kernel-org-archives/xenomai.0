Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E233EAC65
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511948; cv=none; b=ltgQ0dHalb2+g3WKteqnZ9YyjMBVxAOgHzQVh69SxfvBsLiPBqz3q6cDOvbzERz6w1ZtjbfPtmteAka7/ss/eE3nEpRlFj26kVUt0Pp5u1LhOQ5HPbQbXtKzBQUzSSSCb5dThrd1aTGiCfJt6ssALaB2S/K5zNdCbWYJNm3hiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511948; c=relaxed/simple;
	bh=anMRjCwz9HkyuBwCt9AMcl5zX0gEKPOu4KghYZN65sM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpfXHp7qWN50WPakBbMkycK4YiGKaXwspZEofqkLv9dcfJHSqG8cxQ75yQfWuzx1Oq+aTS6IZ0V/f+RpD4S6KXqz5uMVia5ETbBX9wizVyNyX2+sBkte9eIfqDFcOb1NvrLFQ2p8GeIjUR8J0NiZEl7LB6O8cTQjvmNQp8w7ycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QuZG6hHL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QuZG6hHL"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0AC23EE02;
	Wed,  3 Jun 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780511939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BEVuRKwNf3fCIjcOwIrARxrkrGfpjlnr4a0mZf87P40=;
	b=QuZG6hHLgliCtUBdI58tkY4dxxKx0Fbwzv6/sEe+6ymv9ZHcvHphfIQIK4ZplNosV5nQUH
	rc+pijCHsw6ZrWxxagu+yn9+K+6xHrTWAu0FS/gDc/Q5vODMpPo3gD4Usfz93F/yesDoKx
	FokUtD23/0EHgHoBLWVAVGqWFqqIw2Aau1pA/EWYV1fstAUZsxixWm5lJM1daQTPqLQbkY
	d6DVU62J1UxGbgc/nDTzKvmTSPHuTEhfno/oLYCl89hJV8u+1mFMY/upsUqbGNpxyMYX01
	kETgyY7+1c3KluDmVGPtsNLKdVDUiNskDhPm56XNfe07ysiY6GJFj5On+XDeJA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 0/2] arm: Review irq pipeline
In-Reply-To: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
	(Florian Bezdeka's message of "Wed, 03 Jun 2026 17:07:14 +0200")
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Jun 2026 20:38:50 +0200
Message-ID: <87jysflb9h.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF7phc7uGOGsa0A5eBy5XFnbFX7wQl6BuOK+vyYnTRxwWBdTUtfSz+okMLaKyEY0ECaHjTddnm3sNK+jG72/QSTIvJTLJC6l+nYLvcDB6rrWYbIrQdPJAn2dJPuwSoI3JT8N97CuAKkoidBuv0oqjEknKneamOfE5lkprxyCb4nGI1/N9ZoelJGOpt6LMJkVUPeQckl1Jpy/2A1MT6XFZdrn/GuJqKXsjYLWBcTdfEkmtVVG9I6olFG18sSOzfHWTrZ6c9CCeZgZUABmmF4FpWENa+D5T0IPjUebjmQtyQ6EcHuqCwMPpscNYry+wQV+t1pGlktZjuxogjl44wfaRn5J4tRmR0QIloeLLOx8SAm/lePuk6rRxcfFTmHAKJ+/pgyGuvfcgI8LxQA4GBWSV7s9bra3FaDD+tSxnoMuU5y4TQu2hFiABEwQgFb9WcuXr0W3Pprl3bsGEL3TdlezXd1MYWTEnacYcqoT38CqkZfrZjR19EP0ATbkHsul8NUj0tDCAJV7FYVtMRMumDiPlrYLiV7Hwrt74jwhYwuq0i3yP/mUt2dNfzt+0g/TtIpMblV8lIP5KO0dE4CXZtbhEkmvdz/jlDnLivOezbZ8nQQ9JAoP0raGorPenX/5tJ9XwKm6Qn7+BQVhYn1ovgYuwKBKUB5sCe5hkwFe9WBDg+8mw

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> This is the result of a review of the arm implementation of the IRQ
> pipeline. Triggered by some risc-v reviews.
>
> I'm sure about the two easy fixes, targeting different Dovetail
> versions, so split into different patches.
>
> In addition there is one more, I need your input here:
>
> We have two calls to interrupts_enabled() in arch/arm/mm/fault.c,
> both in the do_page_fault() path.
>
> Assuming that we are handling a page fault over kernel space,
> inband stage stalled, we would leave the kernel with the inband stage
> unstalled, as interrupts_enabled() is checking the hardware state (as
> pushed to the stack on entry) instead of the inband stage stall bit.
>
> Is that correct?
>

Nope.

> I'm quite sure we have more real problems that in this case, but
> maybe we should fix that up?
>
> We would have to call something that does the HW check in case
> CONFIG_IRQ_PIPELINE is off, but checks the stall bit in case pipelining
> is enabled.
>

Instead of checking for interrupts_enabled(regs) in do_page_fault() and
do_kernel_address_page_fault(), we should rather check for
!(arch_kentry_get_irqstate(regs) & KENTRY_STALL_BIT) when pipelining,
which would give us the virtual interrupt state on entry, provided we
run in-band.

Inner issue: since do_kernel_address_page_fault() skipped fault_entry()
on trap from supervisor mode, we might still be running oob, calling
local_irq_enable() in such a case would be wrong.

-- 
Philippe.
