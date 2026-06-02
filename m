Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622F3E9F76
	for <xenomai@lists.linux.dev>; Tue,  2 Jun 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409414; cv=none; b=nln6QSRKHcQkdqKkjzoK/FV2CapD1W7JJTD+AZlshnwsHMjJ4akJgAvxl6x3zjY3qdjvGeAVKidv94SNYS/D53uyp/6IQH7IHsVEmJ2tXh1pbkD4MpmeRV9PFIpH6q4rWDhLnn2/JWNk7ubuAg8jkxiN41w3ZpdsdrrJyK3qIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409414; c=relaxed/simple;
	bh=7vCXVr9Q3t5nCeOnkYK4nIDDU8cFfFHKbMBUZ3WBbkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCesJb1WKomVg6Ri5EMkpUbRxMoR+VFa4BPXRaCN96wiGKVyjG0imvn7imaOhpu2NQdrAr4ayPcNtu9ozRmSNz2pg7QnnGj/vBdfeZym6nhZ2eIexSPADo+y09WwrJnoFHMjkVArE5xrwBWZlcgrMhkiZCVe3tvJAYIjSbv/FPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SJEZmrLJ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SJEZmrLJ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202606021410078c4faf8b5f00020766
        for <xenomai@lists.linux.dev>;
        Tue, 02 Jun 2026 16:10:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nfnxWAmgSJmzpuUUkdlrUpAobC3+Ne141JGLnlEZp7o=;
 b=SJEZmrLJ+rnESnolhUfkNHJIbGRFNVs5/SupmpVpIjelrjJMc0VI1NEluH0hHE9d7AL/w2
 pKo3P4yJ5l3j0eRT/84+tNmJoFDwAZTm9JD2VsAD7ygkuxThM7NBW0yRQVoA5Jt6G4N7e4mU
 NMVccg8rpbxWQF8VFUaPwwXqMq2YVRhd9ogK+4holJQL3Tr7pmHym7bUAnjsCQ0hbXu00c7X
 aL+b87ObEBm1MVHVekCFIExLig7tJQCJbi8bJsQePVV2GRVevhnHafT3TybgDT3rVbP9eIzG
 29zfGRwAUQV/5GcJiUz61i6wBPsLgWWYxCf3WKv518kvjIRgfEbBtQUQ==;
Message-ID: <a579710690aa3a24e008aac78568d69153842e79.camel@siemens.com>
Subject: Re: [PATCH dovetail v8 02/11] riscv: irq_pipeline: add IRQ
 pipelining core
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com, shannmu <shanmu1901@gmail.com>
Date: Tue, 02 Jun 2026 16:10:06 +0200
In-Reply-To: <20260531055304.2890455-3-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
	 <20260531055304.2890455-3-tobias.schaffner@siemens.com>
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

On Sun, 2026-05-31 at 07:52 +0200, Tobias Schaffner wrote:
> This patchset integrates IRQ pipelining into the RISC-V architecture,
> bringing it in line with the Dovetail/IRQ pipeline model used on other
> architectures. It adds the core pipelining infrastructure and adapts
> low-level primitives to cleanly separate in-band and out-of-band
> interrupt handling.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> Co-authored-by: shannmu <shanmu1901@gmail.com>
> Co-authored-by: Philippe Gerum <rpm@xenomai.org>
> ---

> [snip]
> =20
> +static __always_inline
> +bool mark_trap_entry(struct pt_regs *regs)
> +{
> +	if (running_oob()) {
> +		return false;
> +	}
> +
> +	if (user_mode(regs))
> +		hard_cond_local_irq_enable();

I had to debug x86 today and noticed a difference here:

hard_cond_local_irq_enable() and the _disable() part below are not
protected by the user_mode() check in x86 and I think that is correct.
We would like to allow hard IRQs to arrive, keeping the pipeline active
while handling a trap.

In addition I would vote for using the same checks/ordering as other
architectures do. I haven't checked arm{64}, but x86 is using a=20
running_inband() check instead of running_oob(). That should help to
avoid stupid mistakes in the future.

> +
> +	return true;
> +}
> +
> +static __always_inline
> +void mark_trap_exit(struct pt_regs *regs)
> +{
> +	if (user_mode(regs))
> +		hard_cond_local_irq_disable();
> +}
> +
>=20

[snip]
