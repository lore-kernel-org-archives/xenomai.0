Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765954EEBF
	for <xenomai@lists.linux.dev>; Tue, 22 Sep 2026 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082938; cv=none; b=hWEjM3BxKxkg4pnOH7x2xJ6qYuDeTdrZZMtRJqdkQAIAJhp05Lsjb/VJJ7LhNEnjHvOGb7KSw3GippmEJC8Q60T+vmPH/Vw0PTPMbOBmZLjMnmOeN/Ah79PxFNlDNeEnewY5/btNTjkgH3PmJIXwh+7kKv8wepz82vCqoQI3iyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082938; c=relaxed/simple;
	bh=H5PbneaTTJTbB7brc/PGQEqAjpl0wbTia4DvaZvdqNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9xSmG3XYw66Vzp9yvh7Mg4sYTAaQ+dIyK4jsdysivX4USGAgDqfl20beLMJpxYfGnLp4/MFhiorgKro1VEq8etquCLYqBwnjGS0mvSaeUYT9SDRtSm3AVQ/20BREKuQSqK9FCcGXHn3i0WFNfzByAONTQxkBe1dFhx+cTA+Shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EPfr4vyV; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EPfr4vyV"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260922131523acda0059f700020758
        for <xenomai@lists.linux.dev>;
        Tue, 22 Sep 2026 15:15:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cNQiXWXw5MAZwD5MusfgoRB5phWBsiBE/O1cQbmQZgo=;
 b=EPfr4vyVDIpyFdRJte/Mf0JVXbzCgx/m1zFSGwEnf6L8lpC0+Rv1WxbxsQuybU3bXZOjuV
 amTmSvRXJ4dK3lTl4B+Pf/tolAPhUsUiYcdQD8o7WG1HDMG8i/RvPQoXYToG0Vl8V1LAVFVC
 xfTPJXYPa04oIg+WQyfWJC60Kkf9kmu7pEyB1nOphiD57bXssF5rIGeAyZkDcf2TPyxqgeQO
 GKZkdHyLp9E4W76cJnzLMlvYjdS8cnGqQJuq+DRWtJhASdyHuuEnUjPFitQz8ggRfWR3zB9/
 vq6GJw66RagIouSFK5Kazc5SGYPEwWT/FsflTZrKCAgue6j1AIzeepoQ==;
Message-ID: <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during
 vmentry/vexit
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn, Philippe Gerum <rpm@xenomai.org>
Date: Tue, 22 Sep 2026 15:15:23 +0200
In-Reply-To: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
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

Hi,

first of all:=C2=A0
Thanks for reporting that issue. Highly appreciated.=C2=A0
Some comments below.

[ Cc: +Philippe ]

On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
> commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
> svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
> raw_local_irq_disable()/raw_local_irq_enable().

The translation into the dovetail world:
commit b2a37d35 removed updating the hardware interrupt state.

The code below now touches both states, the hardware + virtual IRQ mask.
That is not an 1:1 replacement.

>=20
> As a result, the pipeline may still believe that physical interrupts are =
enabled
> while they are actually masked. If a physical interrupt is taken during t=
he
> VMRUN/VMEXIT window, the out-of-band stage can observe an inconsistent
> interrupt state, leading to a stuck vCPU.
>=20
> Restore the explicit sti/cli around VMRUN so that the Dovetail pipeline s=
tays
> consistent across the guest entry/exit path.
>=20
> Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in svm_vc=
pu_enter_exit")

The Fixes part is not really correct. We never touched / supported the
AMD / SVM part of KVM on dovetail.

Looking at the Intel / VMX part (see commit=20
f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of-band
scheduling") in 7.2-dovetail-rebase, I assume there is more work to do.

How did you test that? Did you (IO) stress the host as well as the
guest?

Seems I have no AMD system at hand ATM, so unclear how I could test
that.


> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  arch/x86/kvm/svm/svm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e02a38da5..0e19d42b7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_=
vcpu *vcpu, bool spec_ctrl_in
>  	 * IRQs are being enabled/disabled.  Note!  GIF=3D0 for the entirety of
>  	 * this path, so IRQs aren't actually unmasked while running host code.
>  	 */
> -	raw_local_irq_enable();
> +	local_irq_enable_full();
> =20

local_irq_enable_full() enables both, the hardware as well as the
virtual IRQs. The virtual part of that should be fine, I'm unsure if we
should (unconditionally) touch the hardware state.

>  	amd_clear_divider();
> =20
> @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_=
vcpu *vcpu, bool spec_ctrl_in
>  	else
>  		__svm_vcpu_run(svm, spec_ctrl_intercepted);
> =20
> -	raw_local_irq_disable();
> +	local_irq_disable_full();
> =20
>  	guest_state_exit_irqoff();
>  }
> --=20
> 2.34.1

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


