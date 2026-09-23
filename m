Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDE3DDDB1
	for <xenomai@lists.linux.dev>; Wed, 23 Sep 2026 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142782; cv=none; b=UDwS74wDuPluKjbmgOURCcIIM+X4CDukriuZUp1W/Y0RZoe4eRFS202AFtmsw7TkEzhamgjRsoZazswv+jsaW7jYY60Byl0NbiCm81K63WNDWXiE7sa5O125H5C0ZjcfK40Y+f9Cm0dTVZsngXQaNQvYbWvlgKVN2xpUlsu3/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142782; c=relaxed/simple;
	bh=K2RGwrb3Na9ciYJ2OXSvEwLSd1t/cESa25CgesapiWo=;
	h=In-Reply-To:References:Content-Type:Date:From:Mime-Version:
	 Subject:Message-Id:To:Cc; b=ef4BE8F68BQiXl/HwBSRy+jicaXRL8265m6AGNGh65OPfwQKz5lOocAg43hsuNhB2gf7ghjOoEnq+MIfaP3GkaRKjEpnJ2C7VSGvbbIPPR7S2I/fa2TvlRWQvqQdazTC2GpizEaUyJCQ1lYnLsluKxu8WpDD5HUWpmOWPUMt/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436762|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.380666-0.00087229-0.618461;FP=17147869044933158378|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jKmgdy0_1790142774;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.jKmgdy0_1790142774 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 13:52:54 +0800
In-Reply-To: <8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn> <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
	<8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com>
X-Lms-Return-Path: <lba+16ab36934+f397e7+siemens.com+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:52:51 +0800
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5bb5075f.c6ee.417d.8f02.9923dc98b410@feishu.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>, 
	<xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, 
	"Philippe Gerum" <rpm@xenomai.org>

Hi Florian, Jan,

Thank you for your feedback and for reviewing the patch. I would like to cl=
arify my test setup, as I may have given a wrong impression earlier.

Regarding stress testing: I did not run any stress or IO workload on either=
 the host or the guest. The issue reproduces simply by booting the system=
=C2=A0
and starting a virtual machine. About one minute after the VM starts, the w=
hole system hangs. After applying the patch, everything works normally.=C2=
=A0
I tested this on AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.

More importantly, we have been using linux-dovetail + AMD KVM on a 5.15 ker=
nel with Xenomai 3.2.3 for a long time without any such problem.=C2=A0
The hang only appeared after we upgraded to the 6.12 kernel.

Best regards,
liuyang

> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Wed, Sep 23, 2026, 13:34
> Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handling duri=
ng vmentry/vexit
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>, "Florian Bezdeka"<flor=
ian.bezdeka@siemens.com>
> Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, "Philippe G=
erum"<rpm@xenomai.org>
> On 23.09.26 04:08, =E5=88=98=E6=9D=A8 wrote:
> > Thank you for your reply. My test setup is as follows:=C2=A0
> > We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD integr=
ated GPU passthrough.=C2=A0
> > The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue I enc=
ountered was=C2=A0that=C2=A0about one minute
> > =C2=A0after the virtual machine started, the entire system would hang. =
After I tried applying the above patch,=C2=A0
> > everything=C2=A0is running normally now. I'm not sure if there are othe=
r places that also need to be modified.
> > =C2=A0I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
> > You can use an AMD platform and start any virtual machine on the latest=
 linux-dovetail kernel.
> >=C2=A0
>=C2=A0
> ...or fully emulate SVM in QEMU - much slower but possibly also exposing
> remaining races (if any) differently.
>=C2=A0
> In any case and I as already pointed out the last time KVM came up: We
> need KVM workload aside RT in our regular test pipeline. Could be
> combined with switchtest or at least become part of the background load
> that we run during latency tests. And if that requires having a physical
> AMD machine in test rack, then we need to add one. But maybe QEMU is
> sufficient for that as well.
>=C2=A0
> > Thanks.
> >> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> >> Date:=C2=A0 Tue, Sep 22, 2026, 21:15
> >> Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handling d=
uring vmentry/vexit
> >> To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.dev>
> >> Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
> >> Hi,
> >> =C2=A0
> >> first of all:=C2=A0
> >> Thanks for reporting that issue. Highly appreciated.=C2=A0
> >> Some comments below.
> >> =C2=A0
> >> [ Cc: +Philippe ]
> >> =C2=A0
> >> On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
> >>> commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
> >>> svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
> >>> raw_local_irq_disable()/raw_local_irq_enable().
> >> =C2=A0
> >> The translation into the dovetail world:
> >> commit b2a37d35 removed updating the hardware interrupt state.
> >> =C2=A0
> >> The code below now touches both states, the hardware + virtual IRQ mas=
k.
> >> That is not an 1:1 replacement.
> >> =C2=A0
> >>> =C2=A0
> >>> As a result, the pipeline may still believe that physical interrupts =
are enabled
> >>> while they are actually masked. If a physical interrupt is taken duri=
ng the
> >>> VMRUN/VMEXIT window, the out-of-band stage can observe an inconsisten=
t
> >>> interrupt state, leading to a stuck vCPU.
> >>> =C2=A0
> >>> Restore the explicit sti/cli around VMRUN so that the Dovetail pipeli=
ne stays
> >>> consistent across the guest entry/exit path.
> >>> =C2=A0
> >>> Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in sv=
m_vcpu_enter_exit")
> >> =C2=A0
> >> The Fixes part is not really correct. We never touched / supported the
> >> AMD / SVM part of KVM on dovetail.
> >> =C2=A0
> >> Looking at the Intel / VMX part (see commit=C2=A0
> >> f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of-band
> >> scheduling") in 7.2-dovetail-rebase, I assume there is more work to do=
.
> >> =C2=A0
> >> How did you test that? Did you (IO) stress the host as well as the
> >> guest?
> >> =C2=A0
> >> Seems I have no AMD system at hand ATM, so unclear how I could test
> >> that.
> >> =C2=A0
> >> =C2=A0
> >>> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> >>> ---
> >>> =C2=A0arch/x86/kvm/svm/svm.c | 4 ++--
> >>> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >>> =C2=A0
> >>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >>> index e02a38da5..0e19d42b7 100644
> >>> --- a/arch/x86/kvm/svm/svm.c
> >>> +++ b/arch/x86/kvm/svm/svm.c
> >>> @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct =
kvm_vcpu *vcpu, bool spec_ctrl_in
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/disabled.=
 =C2=A0Note! =C2=A0GIF=3D0 for the entirety of
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't actual=
ly unmasked while running host code.
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> >>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_enable();
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable_full();
> >>> =C2=A0
> >> =C2=A0
> >> local_irq_enable_full() enables both, the hardware as well as the
> >> virtual IRQs. The virtual part of that should be fine, I'm unsure if w=
e
> >> should (unconditionally) touch the hardware state.
> >> =C2=A0
>=C2=A0
> This should be fine, look at the comment of the original code above.
>=C2=A0
> I vaguely recall that guest entry has another IRQ mask that protects the
> atomic section between the host switching certain bits to the guest
> state and the actual guest entry instruction that switches the rest,
> sets the guests virtual IRQ mask, and restores that GIF to 1 so that the
> host will receive IRQs targeting itself (via a guest exit).
>=C2=A0
> Jan
>=C2=A0
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd_clear_divider();
> >>> =C2=A0
> >>> @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct =
kvm_vcpu *vcpu, bool spec_ctrl_in
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__svm_v=
cpu_run(svm, spec_ctrl_intercepted);
> >>> =C2=A0
> >>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_disable();
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable_full();
> >>> =C2=A0
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_state_exit_irqoff();
> >>> =C2=A0}
> >>> --=C2=A0
> >>> 2.34.1
> >> =C2=A0
> >> Best regards,
> >> Florian
> >> =C2=A0
> >> --=C2=A0
> >> Siemens AG, Foundational Technologies
> >> Linux Expert Center
> >> =C2=A0
> >=C2=A0
>=C2=A0
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
