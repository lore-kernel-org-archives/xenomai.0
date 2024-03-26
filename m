Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D762745F1
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=XwFIDBcdI022xEEPD/Sk+nfaN+hKkwk41DIhuQIS5w/ijCyBu9S9SUuEVJpLCO18cRY3x76jLykWCDUoET6ogYtqupHWlz4Xpu/WJx4SvCRnXHTrtczAH0QtcQacT/zw3n+i9qhbKs5ALxKR5dkIWQpNZPdso1EUulHwFOOmxGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=e7MeahNani/HDWDqPze++GuRRBlSsxRJIZHVY/GRmfk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFGSDV1KCzyilqvMJPemPXkfcWiWCVcb+SdTgkYhHK0pyjG8vBzZEa26RiXMdUlntk9hfqYZfzrXveFFYAtOpGiVSFi34AxVeb+YUbXNyhYRPUat2udrwKoARAfR/WSuGbgxks4xZyIj4cbHPRTcG+xHrFn1AlN23/idlRuUPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=UVBDU937; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="UVBDU937"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024032606310870b2aed68920b10701
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LBerBMaeMSnUhZVzYXQMBOL1pQnp2gGnr3Thy0oKVIA=;
 b=UVBDU9379bS+evAVtz+TnAJM7wXO+4xJGHSC2LzcAWog0nDImaW/gcGiXlHvIfKeBi+5Hd
 EaGDnLKIwUd/0KtI70xX8WyqGvkddZnjiv2Lvjd9OPDONB4RR/lUDfSzR7bcyYN5WZI5j8et
 6mVQKnuNqit51wT6PWvkGIA0j7uXY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 10/25] drivers/autotune: Make private functions static
Date: Tue, 26 Mar 2024 07:30:49 +0100
Message-Id: <dbc395248452a332c77c14093953ad8d0dfa950a.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/autotune/autotune.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index d9208f2a89..03fd688de7 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -242,7 +242,7 @@ struct irq_gravity_tuner irq_tuner = {
 	},
 };
 
-void task_handler(void *arg)
+static void task_handler(void *arg)
 {
 	struct kthread_gravity_tuner *k_tuner = arg;
 	xnticks_t now;
-- 
2.35.3

