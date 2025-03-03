Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AF1F3BA3
	for <xenomai@lists.linux.dev>; Mon,  3 Mar 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013326; cv=none; b=eermR2I2xqjFXIrA+9t5H42rtXgeIbk+dPEt1MlQKaGOxx9T3b3uFKzx5Tagh6ob5ttYNLEcpydvyXwGMdEkPOqcShOjmnVnISZO3UNSllQPt/EFfmKOIOXw2rqztIV3o/estkHola+eDZxF8zYj/DGjlbCrBfTVUvMDq+3kG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013326; c=relaxed/simple;
	bh=eBhW7DMPyi2OOfb1CPtT0nTqcAhKCCdGMFWjUFaBFbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m74M+F2/kgv67dSQsGiSWopWcHEHfFfNtwbouJkxqp2AB0i90JuFQXd+pC5C4nu84i1G0BAzBjDouBOJN2XcZ9sdgNdNdWaQaJuOvM6EwmmKGg/iJKKziCWTvmaR3YaGNBSiIJpNQOjz6Bf/ussJIr3mK+eS/WWOgRWyDH00Vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BP+Y8s7m; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BP+Y8s7m"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 119CD442A8;
	Mon,  3 Mar 2025 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1741013314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H9qTTCAK+geaRjWNbgMSdFGeMWTHWhc3aaqUeW64Yww=;
	b=BP+Y8s7mZkmbUKO26RaF7DSaMQAMdovuVhSMlLUerBWAzKpa5Y/sGhP6xdVsIxjMqRjtxM
	u+pnav5v7KCOxfrXwkjVUebr7PYufcMyCJPqduRaAN7QmJCAzIkVfkoDS7FFdb3WnKAAAP
	YPQ5/xVFzBD2obI+7DsoL9za7mqdNnLOnl9iGERv4+Re88Qycu9/rn2ljPxAiq918epDwP
	1+orzjEzBbEqe4Jmmx0FrGqdb9FKHkoLcdwsdEEf1Oze74OKqUzE0oaNK8ldpR0MUq26t9
	eTh/rbo3t7vC7q756pmrjOnIb1yERvWgUar3exSy3Cnp84j/7cF0uJD3zCjURw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: [Dovetail] v6.14: fix hardirq context detection
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Mar 2025 15:48:33 +0100
Message-ID: <877c562mri.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhephfegudfhteetheetudefieetvdefieffhfetfeefudegkeehteegveduudeuvdefnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org


Hi Florian,

As we discussed, this should help with the IRQ denial you spotted on
v6.14.  I'll take care of backporting this patch to v6.1.y-cip and
v6.12.y.

---

From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] genirq: irq_pipeline: fix hardirq context detection (irqctx)

Each incoming IRQ passed to handle_irq_desc() is checked for calling
context correctness, in order to detect invalid calls from
non-interrupt context for interrupts marked as
IRQD_HANDLE_ENFORCE_IRQCTX.

When pipelining is enabled, the IRQ context spans from the early
handling from the pipeline entry (i.e. in_pipeline()) up to the
completion point of the full interrupt path, which includes the
oob->in-band deferral path.

The test checking for the latter was mistakenly inverted, causing the
interrupt to be dismissed if bearing the IRQD_HANDLE_ENFORCE_IRQCTX
flag.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 151ed61a88ae3..110ceb75d0f4b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -706,7 +706,7 @@ static inline bool is_hardirq(struct irq_desc *desc)
 	if (!irqs_pipelined())
 		return in_hardirq();
 
-	if (in_pipeline() || !(desc->istate & IRQS_DEFERRED))
+	if (in_pipeline() || (desc->istate & IRQS_DEFERRED))
 		return true;
 
 	return false;
-- 
2.48.1

-- 
Philippe.
