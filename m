Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E57446859
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621773; cv=none; b=FXM9chVtUmz6QriBI3DcbXg8JFsQyXEvR7RdjxqdG/YIsaCsV5AnthNYExx0L4/na8No1sK9EIoxSRe0cM2Refu/YfnldDnGj2lf6EwLh93bA+kh4RT4RNes5VWab9evxlza+70GeIUf00Wls35g8oEg8C/Nt24HL3JXKqwKnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621773; c=relaxed/simple;
	bh=BGhkap/butZTzuua/1J6TwEEVJK5u4acHNSoAiehZ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNXn3Z+C4Knjaa72A2bRbci7us043pxu5R/dJyVhkIe9GiR0qvp/bpJ6W6fJXu44K+ROOQLAfvclketS9OQBlsio6VJLBYO6rY/LUsBQTYpQLVGnKmvMLCVPPRpXFkvJmj+asMqoEdxXt+ywFpEX2zzS4zG/aohckJ35wvFicEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C54FD1012E4;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gRyNcMtDPezM; Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8023F1012FB;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MKp-IYw0QK3L; Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 4EE122B4F67;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] mailbox: qcom-ipcc: Mark it as irq pipeline safe
Date: Tue, 21 Jul 2026 10:15:37 +0200
Message-ID: <20260721081537.809383-2-richard@nod.at>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260721081537.809383-1-richard@nod.at>
References: <20260721081537.809383-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the summary IRQ OOB capable, child IRQs can also
run OOB and the driver is irq  pipeline safe.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mailbox/qcom-ipcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index d957d989c0cee..c316d8b4c03c4 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -110,7 +110,7 @@ static struct irq_chip qcom_ipcc_irq_chip =3D {
 	.name =3D "ipcc",
 	.irq_mask =3D qcom_ipcc_mask_irq,
 	.irq_unmask =3D qcom_ipcc_unmask_irq,
-	.flags =3D IRQCHIP_SKIP_SET_WAKE,
+	.flags =3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
=20
 static int qcom_ipcc_domain_map(struct irq_domain *d, unsigned int irq,
@@ -322,7 +322,7 @@ static int qcom_ipcc_probe(struct platform_device *pd=
ev)
=20
 	ret =3D devm_request_irq(&pdev->dev, ipcc->irq, qcom_ipcc_irq_fn,
 			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND |
-			       IRQF_NO_THREAD, name, ipcc);
+			       IRQF_NO_THREAD | IRQF_OOB, name, ipcc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
 		goto err_req_irq;
--=20
2.51.0

