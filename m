Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193219F115
	for <xenomai@lists.linux.dev>; Thu,  1 Jan 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767282721; cv=none; b=JEjKOT30DVcaqsI863fc6mBhklffCXjShTjDMR1ZVxx1rNp3Bn3Ly8pTTUaqXMoRaOpEKJRwYl9V0wpLfSdG2NUwjgMuIkAM56/5jnzlOS3g5EcPdLYAaaJ2Nf1CkiMn7WjtGencbyS1nAELlLBy36WkhKAhP+SubyorMLnchx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767282721; c=relaxed/simple;
	bh=9dP9o3nqlWE0Vup0l2RkYTxEVbJLQP5JrxQr3jBD00M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5/7XUDKNcdEM6OJdLoIMROGTIEN2yfLNGE5x0BJ6M3ROw+eTVsAAYWxf0gm8gy2qgiL721CdhmHGk2CeARhq7xf7NbPaWdTSytYSnT+4VWWkbeU0rrJu3F5rhETCt/6UGDt+Oh0eCecdGHOJ7eqr+fMgvzBA17BIKbpohRBkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ISBGin9S; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ISBGin9S"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202601011511381aa229610a0002076e
        for <xenomai@lists.linux.dev>;
        Thu, 01 Jan 2026 16:11:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=J0zWsQt30/YdspEkIhm9qr9CjmTOJcdLRmcbND435QE=;
 b=ISBGin9Sh5LAyLRpTm4m1OI3J8rFbyzaMZ/dqISUQcP3kqJ/lZFrB2Z1ThghVmNvvCtU+W
 ve5c/OVb6MEk+6yDHvYitj8Epgiiq1wFKRE2DLGWHZBs1QXTWYJYwtnoFcfw55EDnKqbeqD2
 YHGbzCzMQDx2PhTHNBYfmtp+CqpnLVLjaZvgZRngYz3KMtxolnHFWAGBBzNcLwSLgl92m2hq
 cVSVvUMivwCe0RWhKLrms/mnpYf9xHKlLvzicK9Ng0/0zAawLBVEemehTli60Gqg5oUCyxCf
 eWK3pMSTafv2MleohK6O1DknpVKHTU54NNE1ZziwLQ228tBukmBcWU3w==;
Message-ID: <687f2afc6f9b6048055bf2facffade2d22fff262.camel@siemens.com>
Subject: Re: intel kvm
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?UTF-8?Q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>, xenomai
	 <xenomai@lists.linux.dev>
Date: Thu, 01 Jan 2026 16:11:37 +0100
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.13316acb.1fd4.4a20.9ef0.8d11f911eed6@feishu.cn>
References: 
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.13316acb.1fd4.4a20.9ef0.8d11f911eed6@feishu.cn>
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

On Wed, 2025-12-31 at 09:35 +0800, =E5=88=98=E6=9D=A8 wrote:
> Hello xenomai,
> =C2=A0=C2=A0=C2=A0 I am using Linux 6.12 with=C2=A0the=C2=A0Dovetail patc=
h and Xenomai Cobalt 3.3.1. When testing on an Intel platform, after starti=
ng a virtual machine with QEMU + KVM, the kernel prints the following messa=
ge:
> ######## irq_pipeline: unexpected event on vector #f2 (irq=3D524554)
> After investigating the code, I found that the do_sysvec_inband function =
uses #ifdef CONFIG_HAVE_KVM, but this config option has been removed in Lin=
ux 6.12.
> It seems it should be replaced with either #if IS_ENABLED(CONFIG_KVM) or =
#ifdef CONFIG_KVM_COMMON.
> For example, make the following modifications.
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipelin=
e.c
> index c58e6099c637..8c9d587bf188 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -143,7 +143,7 @@ static void do_sysvec_inband(struct irq_desc *desc, s=
truct pt_regs *regs)
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case IRQ_WORK_VECTOR:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysvec_o=
n_irqstack_cond(__sysvec_irq_work, regs);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break;
> -#ifdef CONFIG_HAVE_KVM
> +#if IS_ENABLED(CONFIG_KVM)
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case POSTED_INTR_VECTOR:
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysvec_o=
n_irqstack_cond(__sysvec_kvm_posted_intr_ipi,
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 re=
gs);
>=20
> Would this kind of change be appropriate and safe, or is there a better/r=
ecommended way to handle this in the current kernel?

Yes, that is going into the right direction. We missed one refactoring
(since 6.9). See=20

dcf0926e9b89 ("x86: replace CONFIG_HAVE_KVM with IS_ENABLED(CONFIG_KVM)")

We have to do the same thing here. That aligns the implementation and
the caller of affected functions. Are you planning to send a formal
patch? If not, I would just take over here. Thanks for reporting that!

For completeness, affected dovetail branches:
  - 6.18 (not yet released), 6.17 and 6.12 are affected
  - 6.6 and below are fine

Best regards,
Florian
