Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4453016EE
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239543; cv=none; b=b2wx+i3zu9oDMmu4TFiF/glFLk2PpsWoAByvgNZUkl3SYi974DG0leYqF+yX+h6ZuXeKVx6SdB5Cf4tE86n0izTRPYWkUQ545vZTawIofcJ7U4KYnv+90a/3UTw+6O5i/jztrMQUY8wIOAJkU6Vwzl8YxQivTB+hoyja1YeYlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239543; c=relaxed/simple;
	bh=3MOh+daK0YFTeneLkoooOH4hZRFRIiLrhEEFpGqKjLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ra6LtXSstOvQe2XZ9+P207Dspj/MBeWkSTljsyWX7c4uvHMTMLQJzFFxAt49/k1FDebjBLV19SVCFtj2snzTaBAfScPnQqnGqzzbfAFfiZk0dCInFXMkfXIQleCjr5ctaCOtp/5yLZdPqxXscqc87bgYCO5VCdDR4dvp/qPw51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=c1b5C6ms; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="c1b5C6ms"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026021610585631d9276c0900020707
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 11:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xjhtgW92/QCnMiyHO061tUeJvcM/wzXmIQPMyLgd5oc=;
 b=c1b5C6msQK+lIse7AFxvfetyvpfJxrk19m+34rejhNt1vmmC/CWkgjk7Wh8RmJBXSebOpg
 Pzp/g8QFfW6bJpRpuX6B/9bZxnE5s7s7BHh8UUmXwfXx7H08FAzoA6LrKJFh6pnakkksuAAL
 TCOPW3PXoSX3AXh7eOs0zxt6V73e3EsqOFEGzww7Dz+Y7c8XKfURY6qV3aYnUq2prO35lq3f
 jrNDyI1sX0ootfGxnuwf2A4OrJllDRM/An5THDmkPsrGIBdVygKpr0iT4RXG1jC/9GKxl1Jc
 T2NAeRGLQSwAeot4eIPney6l5SaOY5YZxJqTTSeFDAigqLsKUTKpjl4Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 16 Feb 2026 11:58:52 +0100
Subject: [PATCH 2/3] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-wip-flo-prepare-for-6-19-v1-2-f7362cdd2532@siemens.com>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
In-Reply-To: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Since 6.19 the signature of mm_get_unmapped_area() has one parameter
less. The (previously) first struct mm_struct *mm parameter has been
removed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/rtdm/drvlib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 86788743fe47b228662ef16831b4281ddefd04ff..0258100db5bbcc04880ddc71632b7992e50168dc 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1907,8 +1907,12 @@ driver_get_unmapped_area(struct file *filp,
 
 #ifdef CONFIG_MMU
 	/* Run default handler. */
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
-				    flags);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+#else
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
+#endif
+
 #else
 	return -ENODEV;
 #endif

-- 
2.53.0

