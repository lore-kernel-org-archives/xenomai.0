Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753802BE657
	for <xenomai@lists.linux.dev>; Tue, 30 Dec 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767059047; cv=none; b=o+m1JSScAByVUIfq821c7njhVT1IrDcAyrz9SnXiczmNwFsaZAISo+LRR9p9S8iopYdzFuiBOwAfzhbeQXTrgWXiW6lYZg7MI+lZ0VOOS1yPdfxCsPh315epjoqVLixjb/1910JlG5o64dVr5M4psET5+BIBivTaJrdRhCQEQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767059047; c=relaxed/simple;
	bh=mhey1d+23s+wMT0DixpAiFNgkxpDG9fes2X5aLmsvAg=;
	h=To:From:Date:Message-Id:Cc:Subject:Mime-Version:Content-Type; b=BcOXuLKMYbrvSB/r8XmoavGn30D58RjrL6g491MzPRqkf1P3Wv0iXcBLSYAvXtkYUmIEAmNXvgHEDdKLLUjwJxaxohg3CaMRNS5AGAA0PQJ5E4W9An1aYR/JZW4j+TVhq6sKirtAWuPRLQhflOQMCEA+USrY2+jSGDj7OIZ5hx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.fw.UCgr_1767059033 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 09:43:53 +0800
To: "Jan Kiszka" <jan.kiszka@web.de>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
X-Lms-Return-Path: <lba+169532e57+0b3796+sinsegye.com.cn+liuyang@sinsegye.com.cn>
Date: Tue, 30 Dec 2025 09:43:50 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.826af7c8.0b55.4bf2.be4a.fa1f1797a58c@feishu.cn>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E5=8F=8C=E6=8B=B4?= <guoshuangshuan@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E4=BF=8A?= <guojun@sinsegye.com.cn>
Subject: Re: the kernel hang with kernel 6.12
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C2=A0=C2=A0=C2=A0 Thank you for your reply. We will continue to verify whe=
ther such modifications might cause any other issues.
Thanks=C2=A0
liu yang
> From: "Jan Kiszka"<jan.kiszka@web.de>
> Date:=C2=A0 Mon, Dec 29, 2025, 17:04
> Subject:=C2=A0 Re: the kernel hang with kernel 6.12
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E9=83=AD=E5=8F=8C=E6=8B=B4"<guoshuangshuan@sin=
segye.com.cn>, "=E9=83=AD=E4=BF=8A"<guojun@sinsegye.com.cn>
> On 29.12.25 07:53, =E5=88=98=E6=9D=A8 wrote:

> > Hi xenomai:

> > =C2=A0=C2=A0=C2=A0 After testing, the kernel hang problem disappeared a=
fter applying the following patch. Is this modification safe/correct, or ar=
e there any potential issues with it?

> >=C2=A0

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

> >=C2=A0

> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 amd_clear_divider();

> >=C2=A0

> > @@ -4290,7 +4290,7 @@ static noinstr void svm_vcpu_enter_exit(struct kv=
m_vcpu *vcpu, bool spec_ctrl_in

> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 else

> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __svm_vcpu=
_run(svm, spec_ctrl_intercepted);

> >=C2=A0

> > - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_disable();

> > + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_disable();

> >=C2=A0

> > =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 guest_state_exit_irqoff();

> > =C2=A0}

> >=C2=A0

>=C2=A0
> Sound reasonable. But given that we have zero patches via dovetail on

> top of arch/x86/kvm/svm/ so far, the entry/exit paths need a second

> careful review. Studying what we do for vmx and comparing it to svm

> would be a starting point.

>=C2=A0
> And, again, we need CI testing for this. I've just created

> https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55.
>=C2=A0
> Jan
>=C2=A0
