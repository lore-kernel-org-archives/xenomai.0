Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943470;
	b=vYocfPA16KywjP2oAg7utbbgNrIA4wYKfYNk8nQxtDXs11CuS9BF20Vm/z/bMH8WbAVm
	 Ni5QCiFplaWuHyUVMd3xebAw4VsHA/yAeNZXDgmM+ot1MgtpwBFqzEayrH2kSk62iqdhu
	 zbU/AKuAvxhGHiCV3xf6zG0TriezxQkQWMsCIQvxG1CLvmpYaNKPE+/QkJUk1h8NrX7em
	 yJoQcEQihDxWBH8Fkjbg1gMmZPyfi+sgR7S8ZJjMFWJJEhx/qPhM3iiPSss1eFU/QELas
	 mCmtK6qIGfTMUvDdkv8gX5Bu5H6pHULxctj9Bwt3tdz878leCxL+bYbq2qIKvmZ0FXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943470;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=2ZkzjHHq1JatWbqVflijXbIkNUjSn9v6gjUKs7uFgFY=;
	b=1yQGUSztdkcdKHPHJQqyz81uBXAlcbzy4m8Xv0SxUQV27exoeMkvSRL1FhWMZ4ztZ4b5
	 LM1UlkbqoQHmIWXyGywZhcePxjblRgUFIRFT8v2FHun11I9UxK6DYG/gt/wyXDQUH7hyC
	 4s7EEFaT8iY69sZOwab45sF+kF/a1FLM5sX6MgQVK6JfHcnok2joM3+fVyPonTWNRNNBy
	 AZW5dbXoK9dT11LA5a/u4wvNaPyBT6p3fAj52KvCzewMRkolY1EWMxE6eMFa2r/LYgvZF
	 Dye3h2C+oqExxzrdoNoUwb+9i7B6gaKe5JqkMGYi8lcesIsC4xDs+FFHTf6Mv9IbR/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=nG6fM0bS;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45957606A32A
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 19:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45957606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=nG6fM0bS
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026111719242123254b324d000207b6
        for <xenomai@lists.linux.dev>;
        Tue, 17 Nov 2026 20:24:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2ZkzjHHq1JatWbqVflijXbIkNUjSn9v6gjUKs7uFgFY=;
 b=nG6fM0bSakqG4emzqUJLavT5f8N9+qziKGCABJcexD2gCYTQ1wU+bHeInHRmSAPVwAlwEK
 iVbS57fJuPeubiMRf9h8Vb8oHSt9Xae+PY1vLEKiwfu4SbytGl6oBQpaLYE8iltv4v6s5ZzK
 FsbyEW9V5eDyyD9xUSafEaGtxfuIlIrz3d0ax+dxqP1Z4h/HysuYakWWQIMpfbdwYagNqBKO
 hInpaJaWWy8hihAAJBFIxBtNI7FN3DPrv8xrFzhGCOr1AbGCbcZ9QKk1LUudZnViSMoU+peY
 UuEOnDWu54K8Zou0aKlcfotgy1BUDhxKNLnebS//FD2F8nE6bcsXF+Fw==;
Message-ID: <3b8d95a887bd9740e8ea877e0ac276d6588fc87f.camel@siemens.com>
Subject: Re: [PATCH dovetail 4/5] riscv: dovetail: keep hard irqs off for
 page faults handled out-of-band
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Tue, 17 Nov 2026 20:24:20 +0100
In-Reply-To: <20261117123925.597027-5-tobias.schaffner@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
	 <20261117123925.597027-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-11-17 at 13:39 +0100, Tobias Schaffner wrote:
> do_page_fault() enables hard irqs for kernel mode faults whether the
> companion core demoted the current context or not. A kernel mode fault
> the core leaves out-of-band, e.g. a faulting kprobe fetch argument within
> a kernel trap, then runs the fault handler over the out-of-band stage
> with hard irqs on, where an out-of-band interrupt may reschedule in the
> middle of the outer trap. With CONFIG_DEBUG_DOVETAIL, the BUG_ON()
> checking for a demotion fires instead.
>=20
> Toggle hard irqs and the in-band stall only if the core demoted us, and
> keep the debug check for user mode faults.
>=20
> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index dddb30711440..9f8dc6bd7b85 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -489,21 +489,26 @@ asmlinkage __visible __trap_section void do_trap_so=
ftware_check(struct pt_regs *
>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
>  =09irqentry_state_t state =3D irqentry_enter(regs);
> +=09bool inband =3D mark_trap_entry(regs);
> =20
> -=09mark_trap_entry(regs);
> -
> -=09BUG_ON(dovetail_debug() && !running_inband());
> +=09/*
> +=09 * Dovetail: a kernel mode fault the core did not demote for, e.g.
> +=09 * a faulting kprobe fetch within a kernel trap, is handled over
> +=09 * the out-of-band stage with hard irqs off.
> +=09 */
> +=09BUG_ON(dovetail_debug() && !inband && user_mode(regs));
> =20
> -=09if (!user_mode(regs))
> +=09if (!user_mode(regs) && inband)
>  =09=09hard_cond_local_irq_enable();

Handle with care, just a 30 sec scan:

That one looks strange. !user_mode() means fault over kernel code. But
what if the hard IRQs are disabled in the parent context?

We can only (unconditionally) enable/disable (hard) IRQs over user
context.

Seems that was already wrong during first riscv integration. Or: Wrong
API? _save() _restore()?

> =20
>  =09handle_page_fault(regs, state);
> =20
> -=09local_irq_disable();
> +=09if (inband)
> +=09=09local_irq_disable();

That was clearly a bug.

> =20
>  =09mark_trap_exit(regs);
> =20
> -=09if (!user_mode(regs))
> +=09if (!user_mode(regs) && inband)
>  =09=09hard_cond_local_irq_disable();

Most likely the same follow up problem.

> =20
>  =09irqentry_exit(regs, state);
> --=20
> 2.53.0
