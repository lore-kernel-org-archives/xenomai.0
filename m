Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E9515976
	for <xenomai@lists.linux.dev>; Tue, 13 Oct 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904163; cv=none; b=TZkUTRj3bWw2ZEvCzNtWr7EDMeGhQWYy2wTN9ELA9zhK0VSE3Q7uoCFXs0ldlf4tdGoME8UlF1rP7O+i5M+1wmNp+fyXqzVWB0p8d5OqcMBK7g1qLiXctCG7YCn3vgM013yze1Nk0QT2oGKAO+BYVfq5TeuT22+btEHzQ84vhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904163; c=relaxed/simple;
	bh=h/D4/c7f4s5cDxtAvd3OQTVA4mTxrqJBgmNz5DHMJI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlSjJEiXx0XVNjkNzcHiQkVOsDMYHtXk2rmOzgjWNgNGtlnSUqZZm8ErkxtFm7zok7mszd7JoM0vaynxdTckAamV+XIE+3yYO04IR+8fFsaeavzd5iW0Dm19bGS/N5YBofxKz1II+P/bAKRPRu73r/pzDPjFntQOo/bCOTHsefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VAR5//mV; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VAR5//mV"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202610131428576d0e9d9ee700020740
        for <xenomai@lists.linux.dev>;
        Tue, 13 Oct 2026 16:28:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9djDFb3ub3vQ01JZBqSKkcPz9lupwRI91+T5nPwAjCE=;
 b=VAR5//mVv1/rDr2RY+c1muEdIH9IeS7S3lrYXbbVNkoEZD24UraruRkuCeUqdRG2YpfceQ
 WU92GEeZTguYwlK2X/RzS9RFoLbc9R34yMamBNCCcklkRnhZzEu0ns3peyWlexN5SFN4iMY7
 YT3AV45pAkpMKCBoFrxKbPpOD08vxsQz8WBe+xPlFE/f/MroOiXVZtrY6TJFF6L7kMsTWShq
 /MsUGNQCMW9bH6sgGj7OLj+mX6K+oAHuY9uABhsGxwhgnxoU5malqbupwkJvG06U9Aj66zpB
 CFQlK2IaJTmhsT3+OO9+koTkCggYuQ3tzA7Eua0IgTJlVte2M/9QYOHA==;
Message-ID: <e8d56be0e119bb0c7fa030eb23d3e899e9ac20b8.camel@siemens.com>
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during
 vmentry/vexit
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?=E5=88=98=E6=9D=A8?=
	 <liuyang@sinsegye.com.cn>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, songjianwei@sinsegye.com.cn
Date: Tue, 13 Oct 2026 16:28:57 +0200
In-Reply-To: <00f73467-9ce0-44fb-b969-9861f415cc46@siemens.com>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
	 <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
	 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
	 <8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com>
	 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5bb5075f.c6ee.417d.8f02.9923dc98b410@feishu.cn>
	 <00f73467-9ce0-44fb-b969-9861f415cc46@siemens.com>
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

Hi all,

how do we proceed with this patch? As already expressed, the patch
itself looks good to me, I'm just a bit unsure if that is all that needs
to be done to properly support SVM.

@Philippe: Any comments on that from your side?

That brings me back to the questions regarding testing.

@liuyang:

- Did you run more stress tests in the meantime?
- Do you plan to bring in a proper test case for SVM? Maybe something
  as suggested by Jan based on qemu/kvm?

Once merged without improving the test situation first, the "test
improvement" will most likely never happen.

Best regards,
Florian


On Wed, 2026-09-23 at 08:03 +0200, Jan Kiszka wrote:
> On 23.09.26 07:52, =E5=88=98=E6=9D=A8 wrote:
> > Hi Florian, Jan,
> >=20
> > Thank you for your feedback and for reviewing the patch. I would like t=
o clarify my test setup, as I may have given a wrong impression earlier.
> >=20
> > Regarding stress testing: I did not run any stress or IO workload on ei=
ther the host or the guest. The issue reproduces simply by booting the syst=
em=C2=A0
> > and starting a virtual machine. About one minute after the VM starts, t=
he whole system hangs. After applying the patch, everything works normally.=
=C2=A0
> > I tested this on AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
> >=20
> > More importantly, we have been using linux-dovetail + AMD KVM on a 5.15=
 kernel with Xenomai 3.2.3 for a long time without any such problem.=C2=A0
> > The hang only appeared after we upgraded to the 6.12 kernel.
> >=20
>=20
> And that is exactly why we need test cases so that it does not take you
> to update to 7.4 one day and find the next regression only late.
> Anything which runs as part of CI can catch things already when we are
> porting to the next kernel version.
>=20
> Jan
>=20
> > Best regards,
> > liuyang
> >=20
> > > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > Date:=C2=A0 Wed, Sep 23, 2026, 13:34
> > > Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handling =
during vmentry/vexit
> > > To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>, "Florian Bezdeka"<=
florian.bezdeka@siemens.com>
> > > Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, "Philip=
pe Gerum"<rpm@xenomai.org>
> > > On 23.09.26 04:08, =E5=88=98=E6=9D=A8 wrote:
> > > > Thank you for your reply. My test setup is as follows:=C2=A0
> > > > We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD in=
tegrated GPU passthrough.=C2=A0
> > > > The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue I=
 encountered was=C2=A0that=C2=A0about one minute
> > > > =C2=A0after the virtual machine started, the entire system would ha=
ng. After I tried applying the above patch,=C2=A0
> > > > everything=C2=A0is running normally now. I'm not sure if there are =
other places that also need to be modified.
> > > > =C2=A0I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 7700=
.
> > > > You can use an AMD platform and start any virtual machine on the la=
test linux-dovetail kernel.
> > > > =C2=A0
> > > =C2=A0
> > > ...or fully emulate SVM in QEMU - much slower but possibly also expos=
ing
> > > remaining races (if any) differently.
> > > =C2=A0
> > > In any case and I as already pointed out the last time KVM came up: W=
e
> > > need KVM workload aside RT in our regular test pipeline. Could be
> > > combined with switchtest or at least become part of the background lo=
ad
> > > that we run during latency tests. And if that requires having a physi=
cal
> > > AMD machine in test rack, then we need to add one. But maybe QEMU is
> > > sufficient for that as well.
> > > =C2=A0
> > > > Thanks.
> > > > > From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> > > > > Date:=C2=A0 Tue, Sep 22, 2026, 21:15
> > > > > Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handl=
ing during vmentry/vexit
> > > > > To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.dev>
> > > > > Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.o=
rg>
> > > > > Hi,
> > > > > =C2=A0
> > > > > first of all:=C2=A0
> > > > > Thanks for reporting that issue. Highly appreciated.=C2=A0
> > > > > Some comments below.
> > > > > =C2=A0
> > > > > [ Cc: +Philippe ]
> > > > > =C2=A0
> > > > > On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
> > > > > > commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} =
in
> > > > > > svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRU=
N with
> > > > > > raw_local_irq_disable()/raw_local_irq_enable().
> > > > > =C2=A0
> > > > > The translation into the dovetail world:
> > > > > commit b2a37d35 removed updating the hardware interrupt state.
> > > > > =C2=A0
> > > > > The code below now touches both states, the hardware + virtual IR=
Q mask.
> > > > > That is not an 1:1 replacement.
> > > > > =C2=A0
> > > > > > =C2=A0
> > > > > > As a result, the pipeline may still believe that physical inter=
rupts are enabled
> > > > > > while they are actually masked. If a physical interrupt is take=
n during the
> > > > > > VMRUN/VMEXIT window, the out-of-band stage can observe an incon=
sistent
> > > > > > interrupt state, leading to a stuck vCPU.
> > > > > > =C2=A0
> > > > > > Restore the explicit sti/cli around VMRUN so that the Dovetail =
pipeline stays
> > > > > > consistent across the guest entry/exit path.
> > > > > > =C2=A0
> > > > > > Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full=
 in svm_vcpu_enter_exit")
> > > > > =C2=A0
> > > > > The Fixes part is not really correct. We never touched / supporte=
d the
> > > > > AMD / SVM part of KVM on dovetail.
> > > > > =C2=A0
> > > > > Looking at the Intel / VMX part (see commit=C2=A0
> > > > > f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of=
-band
> > > > > scheduling") in 7.2-dovetail-rebase, I assume there is more work =
to do.
> > > > > =C2=A0
> > > > > How did you test that? Did you (IO) stress the host as well as th=
e
> > > > > guest?
> > > > > =C2=A0
> > > > > Seems I have no AMD system at hand ATM, so unclear how I could te=
st
> > > > > that.
> > > > > =C2=A0
> > > > > =C2=A0
> > > > > > Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> > > > > > ---
> > > > > > =C2=A0arch/x86/kvm/svm/svm.c | 4 ++--
> > > > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > =C2=A0
> > > > > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > > > > index e02a38da5..0e19d42b7 100644
> > > > > > --- a/arch/x86/kvm/svm/svm.c
> > > > > > +++ b/arch/x86/kvm/svm/svm.c
> > > > > > @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(s=
truct kvm_vcpu *vcpu, bool spec_ctrl_in
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/dis=
abled. =C2=A0Note! =C2=A0GIF=3D0 for the entirety of
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't =
actually unmasked while running host code.
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_enable();
> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable_full();
> > > > > > =C2=A0
> > > > > =C2=A0
> > > > > local_irq_enable_full() enables both, the hardware as well as the
> > > > > virtual IRQs. The virtual part of that should be fine, I'm unsure=
 if we
> > > > > should (unconditionally) touch the hardware state.
> > > > > =C2=A0
> > > =C2=A0
> > > This should be fine, look at the comment of the original code above.
> > > =C2=A0
> > > I vaguely recall that guest entry has another IRQ mask that protects =
the
> > > atomic section between the host switching certain bits to the guest
> > > state and the actual guest entry instruction that switches the rest,
> > > sets the guests virtual IRQ mask, and restores that GIF to 1 so that =
the
> > > host will receive IRQs targeting itself (via a guest exit).
> > > =C2=A0
> > > Jan
> > > =C2=A0
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd_clear_divider();
> > > > > > =C2=A0
> > > > > > @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(s=
truct kvm_vcpu *vcpu, bool spec_ctrl_in
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_=
_svm_vcpu_run(svm, spec_ctrl_intercepted);
> > > > > > =C2=A0
> > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_disable();
> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable_full();
> > > > > > =C2=A0
> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_state_exit_irqoff();
> > > > > > =C2=A0}
> > > > > > --=C2=A0
> > > > > > 2.34.1
> > > > > =C2=A0
> > > > > Best regards,
> > > > > Florian
> > > > > =C2=A0
> > > > > --=C2=A0
> > > > > Siemens AG, Foundational Technologies
> > > > > Linux Expert Center
> > > > > =C2=A0
> > > > =C2=A0
> > > =C2=A0
> > > =C2=A0
> > > --=C2=A0
> > > Siemens AG, Foundational Technologies
> > > Linux Expert Center
> > > =C2=A0
>=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
