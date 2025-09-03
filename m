Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8B2DAFC3
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909800; cv=none; b=iIOOOFvnjnV0VAzo1EGTo7xp23o35xot4zdcRn5F1MdNaOY6TwB6UndOq4aEHlj1ZlFfmky9gFt5WqsrJFaRbY3Rh57J2K0ZbNe7u7IX80qRDQqrmXVxEisHxgHCGtAy4rMNWY6lWkiFWqPr2DryBlo0JJBDQ9eIGNmWYyGS1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909800; c=relaxed/simple;
	bh=dYk0mwWNbbDIYdU4jt8pGVZ6BpXHPGRYxsIFJYDECeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSZdadly9A2TWs5wcZ8mZA+N1r8zMdSwLrospZfz2ZAE8cY+LO6vWQDvynSrOqF7yUxw+TaoEmB0xBDERpoLRtl4g1qVu8U8zHY+RfVx0IOofT+m/Z5LWVS//EEXIYIBO7RqX3Xr2uW0o3zRrvbmgT5EaT8HTul9CH0dF3VZ+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BRQmlx/e; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BRQmlx/e"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250903142944e0115ec77300020777
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 16:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4/x8sMXdnYiNeB3i3NqgOXOokMn2u3PY1WO5yXAWXqM=;
 b=BRQmlx/ezYVlXdymeIjfWvGtRN4cK6W1/6AMsjlc1/KWbok6cFN1w9B2EgxKz8/m4DKNoP
 LSBHZjxR5vBM3pejYOLMFyOVB9P8D5zbRaXvA1gcOutovngxSyqrnfd5Fu3o9ZXco2vKvsbf
 IgYcrXuLwQhIgUdPGh8ewt0Kd+daiPPT3gu3fWkyFZY7yBBDrvTuMJ1koEw2tWNejnjB8qPZ
 a4tITBR2ZDAvYggmSppV3JrQKOP1HeWmOgrLFHh4gkk0avIAcR1gMG8q6hYL4zyPYEED26wS
 YIUxNdSGsNDmqqWDHaxENAltOtRi9kYLDFmvgIYrGiceg+qMhgWUf60A==;
Message-ID: <2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 03 Sep 2025 16:29:44 +0200
In-Reply-To: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2025-08-20 at 01:08 +0200, Florian Bezdeka wrote:
> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> is interrupted while syncing the IRQ log - for the very same IRQ - as
> hard IRQs are enabled while processing the IRQ log.
>=20
> The pipeline entry code will set the IRQS_PENDING flag and bail out
> forcing the sync code (still in handle_edge_irq()) to loop to infinity
> as the (periodic) IRQ might fire again after calling unmask_irq() from
> inside the loop.
>=20
> Delaying the call to unmask_irq() until the loop has been left fixes
> this problem.
>=20
> There is a "race window" involved. To trigger looping to infinity the
> IRQ(s) must arrive while processing the IRQ log for the same IRQ.
> Enabling some debug options like CONFIG_PROVE_LOCKING widens this
> window as execution time increases.
>=20
> This time the problem could be observed during IO APIC initialization
> on a virtual machine. That simplified debugging a lot.
>=20
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
>=20
> the problem could be observed and debuged quite well on hyper-v with
> lockdep enabled and a slightly modified NMI handler to print out the
> current call stack.
>=20
> This seems to be a long standing issue for Dovetail. We had several
> reports in the past that debug options (like lockdep) on hypervisors
> (like VirtualBox) ended up in a boot failure.
>=20
> Once we agree that the patch is correct I can send backports, if
> necessary, haven't checked that yet.
>=20
> Best regards,
> Florian
>=20
> CC: Philippe Gerum <rpm@xenomai.org>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/irq/chip.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 8a0831193d74..578e79d60de3 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1010,6 +1010,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
>  void handle_edge_irq(struct irq_desc *desc)
>  {
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	bool delay_unmask =3D false;
>  	int flow;
> =20
>  	guard(hybrid_spinlock)(&desc->lock);

I spend some time today and trying to understand what is going on here,
but I'm still not able to fully understand what exactly is killing my
IOAPIC uart IRQ while everything else is fine (when this patch is
applied).

Big question:

guard(hybrid_spinlock) (see above): This is "new". Older versions (like
6.1) were using raw_spinlock_lock() which does not touch the IRQ mask.
That is relevant while syncing the IRQ log on our way back after an
hard IRQ delivery.

Hard IRQs are always OFF now. I always thought that this is the trick:
We allow hard IRQs to be enabled while syncing the log.

Is that a big misunderstanding on my side or a BUG?


> @@ -1054,13 +1055,24 @@ void handle_edge_irq(struct irq_desc *desc)
>  		 */
>  		if (unlikely(desc->istate & IRQS_PENDING)) {
>  			if (!irqd_irq_disabled(&desc->irq_data) &&
> -			    irqd_irq_masked(&desc->irq_data))
> -				unmask_irq(desc);
> +			    irqd_irq_masked(&desc->irq_data)) {
> +				delay_unmask =3D irqs_pipelined();
> +				if (!delay_unmask)			=09
> +					unmask_irq(desc);
> +			}
>  		}
> =20
>  		handle_irq_event(desc);
> =20
>  	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq=
_data));
> +
> +	/*
> +	 * Pipelining: We have to delay unmasking until we left the loop above.
> +	 * Otherwise, a pipeline entry could interrupt syncing the IRQ log and
> +	 * trigger looping to infinity.
> +	 */
> +	if (delay_unmask)
> +		unmask_irq(desc);
>  }
>  EXPORT_SYMBOL(handle_edge_irq);
>=20
