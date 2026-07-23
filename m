Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A942AFAA
	for <xenomai@lists.linux.dev>; Thu, 23 Jul 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819295; cv=none; b=ntmj8XLvvbmRBShiNvVDsaUPXk1//mRoqgGnWoEo2QvE8VlR9aM0I4qBXxoiGFJhft3sQvX9G6rgHxsJr8HijLEfb9mvK4Qb2Iv5mUeV5KQqEseHxrnzMJFhkfW2RDm9eAJulk3/deF1mrZnATE0PXOT4O6pbKc0Jd/wfBbuGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819295; c=relaxed/simple;
	bh=2DvGlwqz6duyCVaDGUWGVng5Tqdcm3pk16IvTPsY5wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2EFGdQmrVg0L5cc8Z+Y/fHg99NO40VvP1bsilc8ZTcP1Y/WVQUiXxhiiqWIc2mhv8ad6Z1RxAcYFk4wWI6dGR+lK50p1As+yFfxtp96exo4ISEhvkASsX0CvDY3baklq6wFmAFrJOWGub+NlNs+WrhTUf5mDCUemt4oOISOe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QQDeJK/Q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QQDeJK/Q"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B43843EC40;
	Thu, 23 Jul 2026 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784819285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+uua79h4xflA/h9dXUyuGDUKuSjR+XY5MN2khx9EmQ=;
	b=QQDeJK/QtezWzFHWBf6ckrUIaosfe9kCQXXWLNocDpqEOpufvH5LJZJiNWEQPjZhutT0UY
	euAH3nrYZZELGHqVPefsnjQAFnjFIW5d2GsRoK2NLj67C9tqpPmT4klAIGV8qNuQqFo05H
	yfxfUpYBR5wj4Xz7WGPXoahblkn9F66ldtPIcUpX1kBLn3wPFz88GLr7xwcRqSVqRA2WV/
	T+yDYVO7bB+ZW5jNcpA8FQhPjfR+xuSAMk/7LWPcO33ZyTZfAdgwbNMMglB3WqV5/lh7qf
	NlRf8rfn1lOCiBYeaAAaCJ5UhaHlvbdsdWi2mjrG5i97+EPJTWl0dJT9TtfjvA==
From: Philippe Gerum <rpm@xenomai.org>
To: linz <powertree@163.com>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,
  "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
  "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v3] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
In-Reply-To: <30686e71.2228.19f6df11b6e.Coremail.powertree@163.com> (linz's
	message of "Fri, 17 Jul 2026 10:39:05 +0800 (CST)")
References: <30686e71.2228.19f6df11b6e.Coremail.powertree@163.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 23 Jul 2026 17:08:04 +0200
Message-ID: <87bjbxzquj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTE7FpF3r45DL/jYVWgrb4eH392giMkBsQL5TJmRmHwFjBsiw9eFqEpp1KrQKxRbbKx5+XAYTGEBjLVP11zv3j18mc9RqIxyBQzDZ8hWRSYUyW/kwgl8lrNhAaO1VsDV4YENzMFQ+CKxqcHY0HUDvovQutcijjbvl3714TtAq5Lvf/pnH5/XY5xDfrcz2HquUBVrKThMiL6Z4l0DS7bRTM+UBYPbXREqnKmz8mZAOitXgJiaGifzI8Yaa3/6GfJmoWH92/YpXSfp7q7zsBIXmQzN8w43Zl9eJHLeR0zvqTKZ3osELf8r6pAGPPIrxKTtlh53goTAUVrqOIbHTZaMjf1gJJSvxA6QKcf1bpwpHBDwMLQAub0Q0BepO0FijinOd8b3MSrDS5ECz0vNQBFbhjoU/HodRol7OvxYLOoJUdTcHDDjJ4ypz639yazAN96/iKXxwYFh9Xt0lpVANxYgXeMtJT1OxjGLTuIpcjVvJfxDXYXcShD3/0rH5pAG6RB36HjZxhLAKpSJ8zyNV1tuIWJYWlmRLg8RGfn3w8RjAnx113hezUOYc44cnziet6UNZDkfWqfxNK1LFB/DWTwc1C2HJvEOw4kWojPsE98BmeEEVR/jNw7pp/spdVNfj3nl2ZTf9r+CAMiCjKSlQAWpyraE8Xkf3tArn6O0mELl7QA3XQ

linz <powertree@163.com> writes:

> The warning shown below could be observed on dovetail 6.6 with arm64
> architecture when CONFIG_DEBUG_IRQ_PIPELINE is enabled.
>
> The reason is the usage of a raw_spinlock_t in hard IRQ masking code
> path. A migration to hard_spinlock_t fixes this issue.
>
> [=C2=A0 =C2=A0 1.510903] IRQ pipeline: some code running in oob context '=
Xenomai'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0called an in-band only routine
> [=C2=A0 =C2=A0 1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06.6.63-dovetail2 #8
> [=C2=A0 =C2=A0 1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
> [=C2=A0 =C2=A0 1.510920] IRQ stage: Xenomai
> [=C2=A0 =C2=A0 1.510923] Call trace:
> [=C2=A0 =C2=A0 1.510926]=C2=A0 dump_backtrace+0x90/0xe4
> [=C2=A0 =C2=A0 1.510940]=C2=A0 show_stack+0x14/0x1c
> [=C2=A0 =C2=A0 1.510946]=C2=A0 dump_stack_lvl+0x84/0xc8
> [=C2=A0 =C2=A0 1.510953]=C2=A0 dump_stack+0x14/0x1c
> [=C2=A0 =C2=A0 1.510957]=C2=A0 check_inband_stage+0xb0/0xc8
> [=C2=A0 =C2=A0 1.510965]=C2=A0 inband_irq_save+0xc/0x28
> [=C2=A0 =C2=A0 1.510971]=C2=A0 _raw_spin_lock_irqsave+0x14/0x90
> [=C2=A0 =C2=A0 1.510977]=C2=A0 its_send_single_command+0x24/0x154
> [=C2=A0 =C2=A0 1.510984]=C2=A0 lpi_update_config+0x9c/0x144
> [=C2=A0 =C2=A0 1.510990]=C2=A0 its_mask_irq+0x2c/0x64
> [=C2=A0 =C2=A0 1.510997]=C2=A0 irq_chip_mask_parent+0x18/0x20
> [=C2=A0 =C2=A0 1.511005]=C2=A0 its_mask_msi_irq+0x1c/0x28
> [=C2=A0 =C2=A0 1.511012]=C2=A0 handle_fasteoi_irq+0x1cc/0x2b4
> [=C2=A0 =C2=A0 1.511016]=C2=A0 generic_pipeline_irq_desc+0x6c/0xa4
> [=C2=A0 =C2=A0 1.511021]=C2=A0 generic_handle_domain_irq+0x18/0x20
> [=C2=A0 =C2=A0 1.511028]=C2=A0 gic_handle_irq+0x4c/0x120
> [=C2=A0 =C2=A0 1.511032]=C2=A0 handle_irq_pipelined+0x40/0x64
> [=C2=A0 =C2=A0 1.511038]=C2=A0 call_on_irq_stack+0x24/0x30
> [=C2=A0 =C2=A0 1.511044]=C2=A0 do_interrupt_handler+0x138/0x158
> [=C2=A0 =C2=A0 1.511050]=C2=A0 el1_interrupt+0x40/0x110
> [=C2=A0 =C2=A0 1.511055]=C2=A0 el1h_64_irq_handler+0x14/0x1c
> [=C2=A0 =C2=A0 1.511061]=C2=A0 el1h_64_irq+0x64/0x68
> [=C2=A0 =C2=A0 1.511064]=C2=A0 default_idle_call+0x30/0x78
> [=C2=A0 =C2=A0 1.511071]=C2=A0 do_idle+0x128/0x150
> [=C2=A0 =C2=A0 1.511077]=C2=A0 cpu_startup_entry+0x34/0x38
> [=C2=A0 =C2=A0 1.511081]=C2=A0 kernel_init+0x0/0x1d4
> [=C2=A0 =C2=A0 1.511088]=C2=A0 arch_post_acpi_subsys_init+0x0/0x8
> [=C2=A0 =C2=A0 1.511096]=C2=A0 start_kernel+0x504/0x5cc
> [=C2=A0 =C2=A0 1.511103]=C2=A0 __primary_switched+0xbc/0xc4
>
> Signed-off-by: zhanglin <powertree@163.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 0e57735eac..3f2b02b8f4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
>   * list.
>   */
>  struct its_node {
> -	raw_spinlock_t		lock;
> +	hard_spinlock_t		lock;
>  	struct mutex		dev_alloc_lock;
>  	struct list_head	entry;
>  	void __iomem		*base;

This is correct, but we need more changes for this irqchip driver,
particularly for handlers mentioned by this document [1], like irq_mask,
irq_unmask.

For instance, anything which calls lpi_update_config() needs to be made
oob-capable, so it looks like gic_data_rdist_cpu(cpu)->rd_lock needs
care too.

[1] https://v4.xenomai.org/dovetail/porting/irqflow/index.html#irqchip-fixup

--=20
Philippe.
