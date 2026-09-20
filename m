Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BB33B6F1
	for <xenomai@lists.linux.dev>; Sun, 20 Sep 2026 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789874552; cv=none; b=JLw8nxT1tJW7F2oo0/T/ANWeHuvrcz/TbvRUWlDavgxHRYXQFAe7SHYpZFTyy3CLPItshJIce/2fxKllfLIT+zPNRqqxSBy1rPrMpSkizeKjdF8EdZwULyJ9OGYw53SNDn3JY65n33aBIHyUGEaJh8LGyznHZIimd7GD5UgwVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789874552; c=relaxed/simple;
	bh=AhEVHrPAIZJK3ivA/QwDWF63z4qT55giUSG+oeZos30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bia3gfU6fHcv/wLxiz2GtEDb3iNDROb5nWnpyR0hyVOi5YMXA1Pro1og3BsMDDLSMz7huXJ/d8dU2rWQLGzuTfnr5kGa79lRMSg6hHmbHttgGtDqMe3JoVywTMJ0loee1D4iJkSSqOPIiD39U0eCZqKgmLxE4Im8P3Ktuy3v1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.404954|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0868475-0.0138493-0.899303;FP=16698074300429520353|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jHpqDUR_1789874538;
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.jHpqDUR_1789874538 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 11:22:19 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
Date: Sun, 20 Sep 2026 11:22:19 +0800
Message-ID: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
raw_local_irq_disable()/raw_local_irq_enable().

As a result, the pipeline may still believe that physical interrupts are enabled
while they are actually masked. If a physical interrupt is taken during the
VMRUN/VMEXIT window, the out-of-band stage can observe an inconsistent
interrupt state, leading to a stuck vCPU.

Restore the explicit sti/cli around VMRUN so that the Dovetail pipeline stays
consistent across the guest entry/exit path.

Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in svm_vcpu_enter_exit")
Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 arch/x86/kvm/svm/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5..0e19d42b7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
 	 * this path, so IRQs aren't actually unmasked while running host code.
 	 */
-	raw_local_irq_enable();
+	local_irq_enable_full();
 
 	amd_clear_divider();
 
@@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
-	raw_local_irq_disable();
+	local_irq_disable_full();
 
 	guest_state_exit_irqoff();
 }
-- 
2.34.1

