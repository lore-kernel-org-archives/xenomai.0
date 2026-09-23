Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321A3264DD
	for <xenomai@lists.linux.dev>; Wed, 23 Sep 2026 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129310; cv=none; b=FVMEVrgyKgxjN0HfXUXNs09GwaIv29jNehHVZEw+YdE5VXzuMll6PlCfern/c/JCYgnTuzXHE6QFgLWd1avFhk4uDI7zOZZtmcWnk2ZyxQQNZN85V5OnzPHkmWLr12H0frbt4o6tzN29urwwb39xqU5rWFJog48frl2JyjCe0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129310; c=relaxed/simple;
	bh=UYV1w7fJPUYrcP+NJa6kYmt8eb2NYDVHPEpDWyqe4cg=;
	h=To:Subject:Mime-Version:References:In-Reply-To:Content-Type:Date:
	 Message-Id:Cc:From; b=CVmFJKK8AInWAeljfUs9U1H9bC+5pSHccL7IbujbR8NkXSMxDNfBKqam2JjtilmfPLaQQLkGXEwSgR7mbUg73q4jdgo31fAE/AHI4AQuSIrLg70jrX0BATQFc0LcCag9/sjoEEh62zvjSWQUdA5VjF2JMZ1AzDkMWT7kwlAhr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07693502|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.193946-0.00168261-0.804371;FP=16517928081414842336|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jKb9yPT_1790129302;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.jKb9yPT_1790129302 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 10:08:22 +0800
Content-Transfer-Encoding: quoted-printable
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
	<b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
In-Reply-To: <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 10:08:19 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, 
	"Philippe Gerum" <rpm@xenomai.org>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
X-Lms-Return-Path: <lba+16ab33494+c074a2+xenomai.org+liuyang@sinsegye.com.cn>

Thank you for your reply. My test setup is as follows:=C2=A0
We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD integrated=
 GPU passthrough.=C2=A0
The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue I encount=
ered was=C2=A0that=C2=A0about one minute
=C2=A0after the virtual machine started, the entire system would hang. Afte=
r I tried applying the above patch,=C2=A0
everything=C2=A0is running normally now. I'm not sure if there are other pl=
aces that also need to be modified.
=C2=A0I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
You can use an AMD platform and start any virtual machine on the latest lin=
ux-dovetail kernel.

Thanks.
> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> Date:=C2=A0 Tue, Sep 22, 2026, 21:15
> Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handling duri=
ng vmentry/vexit
> To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.dev>
> Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
> Hi,
>=C2=A0
> first of all:=C2=A0
> Thanks for reporting that issue. Highly appreciated.=C2=A0
> Some comments below.
>=C2=A0
> [ Cc: +Philippe ]
>=C2=A0
> On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
> > commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
> > svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
> > raw_local_irq_disable()/raw_local_irq_enable().
>=C2=A0
> The translation into the dovetail world:
> commit b2a37d35 removed updating the hardware interrupt state.
>=C2=A0
> The code below now touches both states, the hardware + virtual IRQ mask.
> That is not an 1:1 replacement.
>=C2=A0
> >=C2=A0
> > As a result, the pipeline may still believe that physical interrupts ar=
e enabled
> > while they are actually masked. If a physical interrupt is taken during=
 the
> > VMRUN/VMEXIT window, the out-of-band stage can observe an inconsistent
> > interrupt state, leading to a stuck vCPU.
> >=C2=A0
> > Restore the explicit sti/cli around VMRUN so that the Dovetail pipeline=
 stays
> > consistent across the guest entry/exit path.
> >=C2=A0
> > Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in svm_=
vcpu_enter_exit")
>=C2=A0
> The Fixes part is not really correct. We never touched / supported the
> AMD / SVM part of KVM on dovetail.
>=C2=A0
> Looking at the Intel / VMX part (see commit=C2=A0
> f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of-band
> scheduling") in 7.2-dovetail-rebase, I assume there is more work to do.
>=C2=A0
> How did you test that? Did you (IO) stress the host as well as the
> guest?
>=C2=A0
> Seems I have no AMD system at hand ATM, so unclear how I could test
> that.
>=C2=A0
>=C2=A0
> > Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> > ---
> > =C2=A0arch/x86/kvm/svm/svm.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=C2=A0
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e02a38da5..0e19d42b7 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct kv=
m_vcpu *vcpu, bool spec_ctrl_in
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/disabled. =
=C2=A0Note! =C2=A0GIF=3D0 for the entirety of
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't actually=
 unmasked while running host code.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_enable();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable_full();
> > =C2=A0
>=C2=A0
> local_irq_enable_full() enables both, the hardware as well as the
> virtual IRQs. The virtual part of that should be fine, I'm unsure if we
> should (unconditionally) touch the hardware state.
>=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd_clear_divider();
> > =C2=A0
> > @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct kv=
m_vcpu *vcpu, bool spec_ctrl_in
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__svm_vcp=
u_run(svm, spec_ctrl_intercepted);
> > =C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_disable();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable_full();
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_state_exit_irqoff();
> > =C2=A0}
> > --=C2=A0
> > 2.34.1
>=C2=A0
> Best regards,
> Florian
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
