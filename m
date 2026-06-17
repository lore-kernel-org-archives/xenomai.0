Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12973932EF
	for <xenomai@lists.linux.dev>; Wed, 17 Jun 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676706; cv=none; b=W7CV7++8iY1N9smcfHlFI2MmSCkJ+Ca/YfW5W2vsD4emF4isT/vW/wlJfBPi0LXDitwAjv3hGErvh4wdnI/faCzkx9sDYoEmpUO6R/D0lgPqlPNZaf9JDxK8zrQAlsSCKDBMVD0GIyCGk3nm3ymxYELimH5ttEhabNOoyo/HabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676706; c=relaxed/simple;
	bh=z191NIG5gBX5su0Szm5JZTzXKYBfRMZ5on71HODklx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBSRtdzr33NDOklIL4xsgrANa8lmobjjziil5Rz2yW8K2RZGowtFdlZC2/mTUvFMnewPNvP2EJm1lcz/LF9ODDzC6Po3VJfnYI5l+otnLgQQx3Tdv4soM/aFesRETMRJPlzM9QP8iH/SoAYl5NQodxy1nZH6bgVFr1yYk0lBKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=U5hEACHT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="U5hEACHT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 341543F5D4;
	Wed, 17 Jun 2026 06:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781676696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=px+pq4B0mXZmcStp3PwY8XcDwYK3BPhSlhXd3MZHqyA=;
	b=U5hEACHT1N8GTcxui6/f3ccB0XOD96TtCChNB/4NnOHuETtgWXVt+FHlF3jR420nyrPllF
	y+oRiuSzG4Qq7KYv+ma1YNY9YIO/mZP9PTGOLH8TzFCrNpt8x4p+2J4rxTgcy5Sy7/6zFW
	giZiaAcmJJukbPyqZuWo8BTMMEqpAFJtBWLWP+OjCEWdQhtBFb6Yqv90Dgo++EG+rlTYQs
	KoWUKXciDb0ac6Q1GxuY1YD9BzO4Ii3FD+R9ZW/kTm7DLjAuOXAKBfqQ1xrP3La06VlDD9
	LOiahJntay/kh7Wv7IGLJX4tvRys02nL/20rlNztQYcvht33jdbfB20wFUhrnA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v2 2/6] arm: irq_pipeline: Move fault_entry()
 fault_exit() into separate header
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-2-62c9c477f8f2@siemens.com>
	(Florian Bezdeka's message of "Wed, 10 Jun 2026 11:20:14 +0200")
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
	<20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-2-62c9c477f8f2@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 17 Jun 2026 08:11:35 +0200
Message-ID: <87ik7h7l2g.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFlMIr6klbdNH1GYruwgf0OA1hvBP+qmCeT7NoqI3pO40eanocqMTfXVYxPNuOme3rB6w88s17X7f0YbcscdmXTzD3tXd2OO1ufWIJGoLz5sTV0OdaWPSOWOWJj7EB04CIbBdAxryF5amp2w8AZCjRax2dHZiPUADQl6dh2/d6HxeJHihhRYXlJDCOBcCJwmFJE9M+wE4vAVEGCShp4NFHNhZuw7bW4wVPBmU9UHn+2Vdnx/lfsva7Q/0rxe3jIKYf6HD8sX23JhbhvYhYSy/QbecA16Yv5YmrP05bqgtlww0RVl749z1eNsmoKfXmdY3fnEURA0T4WL/cCC5a+lgGqVEnCuDSvBo9R2glAbJAwLWMkT42jiDsEXZOmtBa7TXALzBvBVNN1vDwkWagK9c+CSPiqX91p7GCgC4bdnOc5mKv/Kgn9DLJMR7j9hJVtxSZ8idhlAk5PAaXQPBVQXV4Y9zNLqniL49bsBTnxJaHsYjEesU/IHTbz4pmNht9TkdmMy831kbFNw504X9MoMiudSnMFeoLnls604QtozrvIX2dWULr+xzc6jUvf6ua7haBUAKrOJ8NUrD0Z4MQ6ZNYemubgO+kGp+YgeFfz9korSqWgV7q8VZH/wTGW5DQavWfduIconkD23ERer/6njn/OT0QwnO/JsVt7731oSu60RQ
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Introducing a new header allows us to keep the implementation as
> static inline function. Moving them into asm/dovetail.h or
> asm/irq_pipeline.h would require us to rewrite those helpers as macros.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/include/asm/trap_entry.h | 82 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mm/fault.c               | 65 +------------------------------
>  2 files changed, 83 insertions(+), 64 deletions(-)
>
> diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/trap_entry.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..56cf3352c38d9347e989f9b4f6be0b7d649d9b13
> --- /dev/null
> +++ b/arch/arm/include/asm/trap_entry.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASMARM_TRAP_ENTRY_H
> +#define _ASMARM_TRAP_ENTRY_H
> +
> +#include <asm/dovetail.h>
> +#include <asm/trace/exceptions.h>
> +
> +#ifdef CONFIG_MMU
> +#ifdef CONFIG_IRQ_PIPELINE
> +/*
> + * We need to synchronize the virtual interrupt state with the hard
> + * interrupt state we received on entry, then turn hardirqs back on to
> + * allow code which does not require strict serialization to be
> + * preempted by an out-of-band activity.
> + */
> +static inline unsigned long fault_entry(int exception, struct pt_regs *regs)
> +{

We need a prefix to fault_entry() in order not to pollute the namespace.

-- 
Philippe.
