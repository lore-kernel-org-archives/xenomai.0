Received: from out198-4.us.a.mail.aliyun.com (out198-4.us.a.mail.aliyun.com [47.90.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148701C84DE
	for <xenomai@lists.linux.dev>; Sun,  4 Jan 2026 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493706; cv=none; b=EHTFVMWt0Xo0JPmfWqckh6JRGcOr1QJp8sMMsBumWEFKeOA2HAskyaoOnb14A8end6yfqEx4NiXUT2ZHVQvnMdMPjVWo8ln26YQ/waxYFeCVI7/hSjNjawJ7VnTiYAwu9tagwDCOR2huiwrI6wENgkUYizYEFi3anx/b7weFUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493706; c=relaxed/simple;
	bh=O7UfcP4igZ5rzZQAB7P7ZpZs+GJHx/Is1RSsqubXqiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCIVixgNN7MYjrB9kQcVGKtCUF5dAPZaLrVgJb3XVkVR3RP6B5ImPqmwQ4wttJ9fKOs+m+LcVnnUauxSHZYO3x/+sgAR/FbjmUp+JAUQ8tXna8LtKiV+7oGLmT7Ixu+OeYJ5tdAN8JMKGYUpYLjk1xPDyG1UyJ8P3DsCEmdqstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.fzHSLXo_1767492749 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 10:12:30 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v1] x86: fix stale CONFIG_HAVE_KVM reference in irq_pipeline
Date: Sun,  4 Jan 2026 10:12:11 +0800
Message-ID: <20260104021211.548905-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_HAVE_KVM macro has been removed in kernel 6.12. 
Consequently, the code block for POSTED_INTR_VECTOR in 
do_sysvec_inband() is no longer being compiled even when KVM 
is enabled.

Replace the obsolete CONFIG_HAVE_KVM with IS_ENABLED(CONFIG_KVM) 
to restore the correct behavior for KVM posted interrupts in 
the interrupt pipeline.

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 arch/x86/kernel/irq_pipeline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 7a64af5dab73..8c9d587bf188 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -143,7 +143,7 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 	case IRQ_WORK_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_irq_work, regs);
 		break;
-#ifdef CONFIG_HAVE_KVM
+#if IS_ENABLED(CONFIG_KVM)
 	case POSTED_INTR_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_kvm_posted_intr_ipi,
 					regs);
-- 
2.43.0

