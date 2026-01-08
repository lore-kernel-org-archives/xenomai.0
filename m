Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563E33C1A2
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861768; cv=none; b=UcPJnXosH1TbPYrPjoWtXdJbOKE49UY+/3SNvYzJpW8eIpS8W9KV5TAmJ2NfR6rH/rA1kwwFUhlEn43elyYRbpZaXyM52cKIIqLOAufeyoyhmcIDVMYg/KUBbp1xbcw7rQkzqCnRmq010o42vww5lHAQP1dCHvp/lkfdVcMROBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861768; c=relaxed/simple;
	bh=aqgrEjeHjthCJDGrAw3qUUXQvFp45Uy7+Mf/dgV3X5Q=;
	h=Subject:Mime-Version:References:Content-Type:Date:Message-Id:To:
	 Cc:From:In-Reply-To; b=gwR0MvGyLYmprx9sT9X6QUPBPa+YwAxV8Rxf+T2UEQ8CNvXOdHccw3RLvIPOnvcUluElRd0hSSBBfFKt6W+3Z61vBFW67ethnzhldZS7jjWLx9bdaZ/+rP0m6Mx2pDawCAJj+UlQ1VFsh4ESqUpfezhrtvrjBpTWATgQqDo8RGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.g16R3zM_1767861757 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 16:42:37 +0800
Subject: Re: the kernel hang with kernel 6.12
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.90c6520a.23af.43fe.9b63.9c6842941db7@feishu.cn> <9e679d7b-c247-489d-8351-5e5976ae40b1@web.de>
	<5f8f678655906dd33eb2b98b20d136822d4811c5.camel@siemens.com>
X-Lms-Return-Path: <lba+1695f6dfb+7f5170+siemens.com+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 16:42:34 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.a75ab7e6.df2d.4080.ba93.65d4609060cf@feishu.cn>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Content-Transfer-Encoding: quoted-printable
Cc: "Jan Kiszka" <jan.kiszka@web.de>, "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E5=8F=8C=E6=8B=B4?= <guoshuangshuan@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E4=BF=8A?= <guojun@sinsegye.com.cn>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
In-Reply-To: <5f8f678655906dd33eb2b98b20d136822d4811c5.camel@siemens.com>

Hi xenomai:
=C2=A0=C2=A0=C2=A0 You can use either Ubuntu 22.04 or Ubuntu 24.04, and the=
n replace the kernel with one that has Xenomai patched in. I think that you=
r point is correct. I will use local_irq_{enable,disable}_full() to conduct=
 testing and verification.
THanks,
liuyang
> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> Date:=C2=A0 Thu, Jan 8, 2026, 16:33
> Subject:=C2=A0 Re: the kernel hang with kernel 6.12
> To: "Jan Kiszka"<jan.kiszka@web.de>, "=E5=88=98=E6=9D=A8"<liuyang@sinsegy=
e.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E9=83=AD=E5=8F=8C=E6=8B=B4"<guoshuangshuan@sin=
segye.com.cn>, "=E9=83=AD=E4=BF=8A"<guojun@sinsegye.com.cn>
> On Mon, 2025-12-29 at 10:04 +0100, Jan Kiszka wrote:

> > On 29.12.25 07:53, =E5=88=98=E6=9D=A8 wrote:

> > > Hi xenomai:

> > > =C2=A0=C2=A0=C2=A0 After testing, the kernel hang problem disappeared=
 after applying the following patch. Is this modification safe/correct, or =
are there any potential issues with it?

> > >=C2=A0

> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c

> > > index c48a466db0c3..c5e0456b63e6 100644

> > > --- a/arch/x86/kvm/svm/svm.c

> > > +++ b/arch/x86/kvm/svm/svm.c

> > > @@ -4280,7 +4280,7 @@ static noinstr void svm_vcpu_enter_exit(struct =
kvm_vcpu *vcpu, bool spec_ctrl_in

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/disabled.=
=C2=A0 Note!=C2=A0 GIF=3D0 for the entirety of

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't actuall=
y unmasked while running host code.

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 */

> > > - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_enable();

> > > + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_enable();

> > >=C2=A0

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 amd_clear_divider();

> > >=C2=A0

> > > @@ -4290,7 +4290,7 @@ static noinstr void svm_vcpu_enter_exit(struct =
kvm_vcpu *vcpu, bool spec_ctrl_in

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 else

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __svm_vc=
pu_run(svm, spec_ctrl_intercepted);

> > >=C2=A0

> > > - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_disable();

> > > + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_disable();

> > >=C2=A0

> > > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 guest_state_exit_irqoff();

> > > =C2=A0}

> > >=C2=A0

> >=C2=A0

> > Sound reasonable. But given that we have zero patches via dovetail on

> > top of arch/x86/kvm/svm/ so far, the entry/exit paths need a second

> > careful review. Studying what we do for vmx and comparing it to svm

> > would be a starting point.

>=C2=A0
> hard_local_irq_*() will deal with the hardware IRQ mask only. Depending

> on the expected result that might not be enough as the virtual inband

> IRQs might still be masked.

>=C2=A0
> IOW: hard_local_irq_enable() will allow hard IRQs to be handled. Such

> events will be logged into the IRQ log. If the events are then served

> (means handled by Linux) depends on the virtual IRQ mask. In case both

> irq masks have to be touched: See local_irq_{enable,disable}_full().

>=C2=A0
> Can't say yet what is the right thing to do here. Needs a careful review

> of the call graph / context.

>=C2=A0
> >=C2=A0

> > And, again, we need CI testing for this. I've just created

> > https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55.

>=C2=A0
> Agree, we should really try to increase the test coverage here. It would

> be highly appreciated if someone could provide an AMD based system. Not

> sure if we have any AMD machine in our lab...

>=C2=A0
> Florian
>=C2=A0
