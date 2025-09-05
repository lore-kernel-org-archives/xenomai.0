Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC02345730
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073198; cv=none; b=ZmKFGvG5afPcpXyMUNG01zrM9jE6dE3pLqECuSDuEFTWY8kffpNL7c1VpetdoLDQjyaRhFDoQ/jzzJKr76WY3zj+wGFxf+1czt5edlJc3nH3jM8gUo30DeZI7in2vhteTq0dwgOr3s304xfPorC34Jy9su7YI4z1K6Zv0nzO1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073198; c=relaxed/simple;
	bh=VzDPhU8ifUXLv1rUI9acO9JlymjZa/7HCoOLewjyh3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDIHTy9GfAWQ732Z2qvCpomeL+a0w4HnfwxY6g48kwRMmph6ho1TbqxRdBGy4C0Z0M9lhxwjwObbZ0GkMvvH3hpSTJo5hnBpciJ+Ib7CtwKp4+QVUuyGw4VbUrsUjNTb5Vw//kyoRcYJ/I6ecoBq0WjcTg9OQDNufD3CL0K+CPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=PfQPH5E2; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="PfQPH5E2"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250905114300cda23d7f8f000207fe
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 13:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fliM0cswhPdnz++csBBIOfjbTBOEq0qUFmVI1ALobkg=;
 b=PfQPH5E2NQYjep0fIG6ROODvzbaFk/hsVDoO0eq+dWSnxeV3GDdftvSvAsZLtzf1pz507j
 EKJfh5se3xwr2Y387cNg75/CVTn28YWv/kuEGm7AuLto76y8imYGWThtbwG6PdpR7+vT8ONt
 foPpQDWRHyqm/qJ0uIlRPjxlv/mRtq3pv802xQNBeTdV1hOq3E8W6LUiacDHhfV3xE2dGdE4
 Pz7JnE38YS2g1eXWLPU9e2p5M0UfSPKdDaO2eOO88xQ9XSfaZJmJBqjwLKRRgtcFXM25jNyp
 qEKLxyEknfXxfOqJgauFIrzn7NSSZBKy2060GFFJc0bd/HcYwRZGvgbg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/5] drivers/analogy/testing: Resolve FORTIFY_SOURCE warning
Date: Fri,  5 Sep 2025 13:42:56 +0200
Message-ID: <d1a0818c06fd740cb4371350cf194340a32f8daf.1757072578.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757072578.git.jan.kiszka@siemens.com>
References: <cover.1757072578.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Convert the private field to the right type so that we can avoid memcpy
and rather set a pointer to the shared private buffer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/testing/fake.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/analogy/testing/fake.c b/kernel/drivers/analogy/testing/fake.c
index cae0998be5..fd88ed99f9 100644
--- a/kernel/drivers/analogy/testing/fake.c
+++ b/kernel/drivers/analogy/testing/fake.c
@@ -555,8 +555,8 @@ static int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
 {
 	typedef void (*setup_subd_function) (struct a4l_subdevice *subd);
 	struct fake_priv *priv = (struct fake_priv *) dev->priv;
+	struct ao_ai2_priv **priv_ptr;
 	struct a4l_subdevice *subd;
-	unsigned long tmp;
 	struct ai_priv *r;
 	int i, ret = 0;
 
@@ -632,8 +632,8 @@ static int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
 	r->quanta_cnt = priv->quanta_cnt;
 
 	/* A0 and AI2 shared their private buffers */
-	tmp = (unsigned long) sds[AO_SUBD].subd->priv;
-	memcpy(sds[AI2_SUBD].subd->priv, &tmp, sds[AI2_SUBD].private_len) ;
+	priv_ptr = (struct ao_ai2_priv **)sds[AI2_SUBD].subd->priv;
+	*priv_ptr = (struct ao_ai2_priv *)sds[AO_SUBD].subd->priv;
 
 	/* create the task */
 	ret = rtdm_task_init(&priv->task, "Fake AI task", task_proc, dev,
-- 
2.43.0

