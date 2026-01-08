Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C4364EA2
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861225; cv=none; b=diyKp8p6abTCU20ZEpM1kPNcryTCpUWDbdu7L3DEMrNGrPiJvy37wk/ZJvVomnq++SZhA6kXF6iDEdlwSUTcn/N8glpeFK37ELdy5nI3INGh1SYXpjrcO1pZS0SSC8iZ6huz/PFAmQlihEeQrrXvXnb9wX2cIpwjPqTF1Edn4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861225; c=relaxed/simple;
	bh=W1QuckkYXP0/eH3MuVS1lZrOl6wkaU2c4+43HNHjktE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqpTbR+VmkE39H+wxen0+xHsXT9Wq2p/SV77b/FKRGg8RstFxYs+P5KpJXkFDwYZQfEw5wvE1p7XGhFH95nM63ikjKDyqFmoaQ3vh7NmqZLtlo8uNB4UCw6yoj5GMHBazl7R0t/RlOXEDQz869S1UXOyr4TNMzOKwV3EAqdPEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CFGNly4t; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CFGNly4t"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026010808332877a849608e0002070e
        for <xenomai@lists.linux.dev>;
        Thu, 08 Jan 2026 09:33:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=W1QuckkYXP0/eH3MuVS1lZrOl6wkaU2c4+43HNHjktE=;
 b=CFGNly4tD8DCUNe20KHf1bNEXyzobqdAwc+jgnu04u3ux2ozidTbST7HUxlrl7U+Du3JUK
 CytiOUgQ/y9skT8LTKxwcFG6GtdjK02oLsIMf6HB5ANIlDWaFGlT7Q00y+XWt4PSFZ7yrBXH
 6lIESJoHlHyE/FBZ/pbeDgvo4vMYIqfVDGvfQgEBZphWly8b3KS5kPIcIob8l5ut4uBzh79P
 IQuciyg7sXfG+IV1R/ArtgvJ5xEt9Jj4jxJ0hFpDPVh7qDKNN3fczFi1DBNOjLHReIHeMgIe
 07sEsNWJt9mBXZlRv6tmh8iIsNnW9SNcuqA3rgzPdDcA1d7DpExp5tGw==;
Message-ID: <5f8f678655906dd33eb2b98b20d136822d4811c5.camel@siemens.com>
Subject: Re: the kernel hang with kernel 6.12
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@web.de>, =?UTF-8?Q?=E5=88=98=E6=9D=A8?=
	 <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, 
 =?UTF-8?Q?=E5=AE=8B=E5=81=A5=E7=8E=AE?=
	 <songjianwei@sinsegye.com.cn>, =?UTF-8?Q?=E9=83=AD=E5=8F=8C=E6=8B=B4?=
	 <guoshuangshuan@sinsegye.com.cn>, =?UTF-8?Q?=E9=83=AD=E4=BF=8A?=
	 <guojun@sinsegye.com.cn>
Date: Thu, 08 Jan 2026 09:33:28 +0100
In-Reply-To: <9e679d7b-c247-489d-8351-5e5976ae40b1@web.de>
References: 
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.90c6520a.23af.43fe.9b63.9c6842941db7@feishu.cn>
	 <9e679d7b-c247-489d-8351-5e5976ae40b1@web.de>
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

On Mon, 2025-12-29 at 10:04 +0100, Jan Kiszka wrote:
> On 29.12.25 07:53, =E5=88=98=E6=9D=A8 wrote:
> > Hi xenomai:
> > =C2=A0=C2=A0=C2=A0 After testing, the kernel hang problem disappeared a=
fter applying the following patch. Is this modification safe/correct, or ar=
e there any potential issues with it?
> >=20
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index c48a466db0c3..c5e0456b63e6 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4280,7 +4280,7 @@ static noinstr void svm_vcpu_enter_exit(struct kv=
m_vcpu *vcpu, bool spec_ctrl_in
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/disabled.=C2=
=A0 Note!=C2=A0 GIF=3D0 for the entirety of
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't actually =
unmasked while running host code.
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_enable();
> > + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_enable();
> >=20
> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 amd_clear_divider();
> >=20
> > @@ -4290,7 +4290,7 @@ static noinstr void svm_vcpu_enter_exit(struct kv=
m_vcpu *vcpu, bool spec_ctrl_in
> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 else
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __svm_vcpu=
_run(svm, spec_ctrl_intercepted);
> >=20
> > - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_disable();
> > + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_disable();
> >=20
> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 guest_state_exit_irqoff();
> > =C2=A0}
> >=20
>=20
> Sound reasonable. But given that we have zero patches via dovetail on
> top of arch/x86/kvm/svm/ so far, the entry/exit paths need a second
> careful review. Studying what we do for vmx and comparing it to svm
> would be a starting point.

hard_local_irq_*() will deal with the hardware IRQ mask only. Depending
on the expected result that might not be enough as the virtual inband
IRQs might still be masked.

IOW: hard_local_irq_enable() will allow hard IRQs to be handled. Such
events will be logged into the IRQ log. If the events are then served
(means handled by Linux) depends on the virtual IRQ mask. In case both
irq masks have to be touched: See local_irq_{enable,disable}_full().

Can't say yet what is the right thing to do here. Needs a careful review
of the call graph / context.

>=20
> And, again, we need CI testing for this. I've just created
> https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55.

Agree, we should really try to increase the test coverage here. It would
be highly appreciated if someone could provide an AMD based system. Not
sure if we have any AMD machine in our lab...

Florian
