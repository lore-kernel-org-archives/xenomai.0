Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E92BF3CF
	for <xenomai@lists.linux.dev>; Wed, 31 Dec 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144972; cv=none; b=j7Av6O6Q18VdQOVQ8w3y9iy9iyS+1TUU3LLxMxISnnQ/bkj45w2xcVyMwCQjP8F3gAUIXwJ8sgKywUM3bobA2Low1ksjUzH4dva5v0kru1xpuhQ8m+gRTUOQiOp5BZaF2au/4b66d/C0rwr6dHl9k/Eq2gQwCKzDBXbK8tIqz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144972; c=relaxed/simple;
	bh=QiBOxp01ilGkRZ3caKbxjkzXaOV5gURZApAJoGkjBJA=;
	h=Date:To:Subject:Message-Id:From:Mime-Version:Content-Type; b=XFXzENDU2pB98FjwDbdhLsBJR3cNEgV7J2P/Vk0dMRKg0T/tAyZRjxVeUHMy1NEy9XlwAhxpvcbB+mBEr8xKT6uDWJ4siFVffj6ME31OM2b1582caYyHK4jq2ymJU+D769Yy9w25qitblTUz7zUHa2+4GPOQsNnatfmfR038yqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.fwnsuLv_1767144956 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 31 Dec 2025 09:35:56 +0800
Date: Wed, 31 Dec 2025 09:35:53 +0800
To: "xenomai" <xenomai@lists.linux.dev>
Subject: intel kvm 
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.13316acb.1fd4.4a20.9ef0.8d11f911eed6@feishu.cn>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+169547dfa+c9946d+lists.linux.dev+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello xenomai,
=C2=A0=C2=A0=C2=A0 I am using Linux 6.12 with=C2=A0the=C2=A0Dovetail patch =
and Xenomai Cobalt 3.3.1. When testing on an Intel platform, after starting=
 a virtual machine with QEMU + KVM, the kernel prints the following message=
:
######## irq_pipeline: unexpected event on vector #f2 (irq=3D524554)
After investigating the code, I found that the do_sysvec_inband function us=
es #ifdef CONFIG_HAVE_KVM, but this config option has been removed in Linux=
 6.12.
It seems it should be replaced with either #if IS_ENABLED(CONFIG_KVM) or #i=
fdef CONFIG_KVM_COMMON.
For example, make the following modifications.
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.=
c
index c58e6099c637..8c9d587bf188 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -143,7 +143,7 @@ static void do_sysvec_inband(struct irq_desc *desc, str=
uct pt_regs *regs)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case IRQ_WORK_VECTOR:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysvec_on_=
irqstack_cond(__sysvec_irq_work, regs);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break;
-#ifdef CONFIG_HAVE_KVM
+#if IS_ENABLED(CONFIG_KVM)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case POSTED_INTR_VECTOR:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 run_sysvec_on_=
irqstack_cond(__sysvec_kvm_posted_intr_ipi,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 regs)=
;

Would this kind of change be appropriate and safe, or is there a better/rec=
ommended way to handle this in the current kernel?

THanks,
liu yang
