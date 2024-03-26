Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B0745D6
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=nUQo61/BVHA0WAq+Tr+WfinTtdKuTulKwMpVmFrHx8OYBgYBVtR8zfuFqlmH7pdNR5Os5A9mlNi8SskFbl3umoZdi5PGoMYpXbwcEt2aGQrCXUZHJ758hRR8iNthE8vjHMHK46999jXl7fiSGCaPEy2Z3pNQc1LVe5qTlF8q7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=JsU94gnrWNFSjQhsXSPLcLBNZcwkGKpKN7zzyYtzhF0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUzJ5NtAbG468bPYWkl2bJ99ZKDFb6qc1BAsCYItzJXWzEKFI8eyzVcOHXfYw3+gH0gQKY+mMyI1+oesmIoP9LukksQJOCeE3E4drmaqRd6k1WI2FhM4kvwd3neizDFgW28B5dSxt8i1BAww+EnsrnO4Lc/lV7O0IYWjlbAxBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=PUzzBhn2; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="PUzzBhn2"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024032606310706709795dee5d33272
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rWNHw0wqLzLbjsj3wiRkWFfugE7S0Km8jURwR8mC++g=;
 b=PUzzBhn2WgLVF+NaE6/qZUlyerWTa9Gv6gZsUBEZ4WCvkuRa/TRU5FrFAkrhVhCtbxNR9d
 32IYZmcqwYLX2Zfb2CZCvoM9LXvN/TdSKKBAIp0Y5v3ONeyVcawRBfG4yS2zr9wIdQx/vS8m
 y3jdeMuyNKxIP3QTZeo2E/2WO3vcU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 08/25] analogy/national_instruments: Drop dead mio_common_detach
Date: Tue, 26 Mar 2024 07:30:47 +0100
Message-Id: <420d62543f291793da1bbb32b07efc2e193b13d7.1711434664.git.jan.kiszka@siemens.com>
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

This was never used, also never exported via any header. Let's drop it.

Still, this may indicate that we are actually missing some cleanup work
or API somewhere...

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/national_instruments/mio_common.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index 92f403d7b5..c41ec506c7 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -3833,15 +3833,6 @@ int ni_serial_insn_config(struct a4l_subdevice *subd, struct a4l_kernel_instruct
 	return -EINVAL;
 }
 
-void mio_common_detach(struct a4l_device * dev)
-{
-	if (dev->priv) {
-		if (devpriv->counter_dev) {
-			a4l_ni_gpct_device_destroy(devpriv->counter_dev);
-		}
-	}
-}
-
 static void init_ao_67xx(struct a4l_device * dev)
 {
 	struct a4l_subdevice *subd = a4l_get_subd(dev, NI_AO_SUBDEV);
-- 
2.35.3

