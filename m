Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D580056
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434680; cv=none; b=XDbw+vJACtNZn/g/vZm8BFyQBO6yPivQoobbun8czzhk+Vv9/MuAUuhxuFHb+ln297/G8/OVQuWvlm7T/ienv/EbapA7pKKGPM9OCNoigkA2dR7BR62U8q5kDTkiiaeSw9235QgOzaJRE2Qq4O+tv4eG6TOsgJzY+1x+2pQr0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434680; c=relaxed/simple;
	bh=MOWFsr7i4Y8KR4VkO+2fqQJIVz9GPFAkb9eb0Fyoy1o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGlCcO8qL4nFm8FFLoMI17ZXJDkKlU8TGbYvHjJpE2ueP2h9xzCm/iZjfW8derkEe0xbOUXi1At9g+5RbOo/T9sLrgfkGq7IbHKFPJJigO4iL6MV9gz5t7ewIy9e9Iy6QrMhSEs7f1QQGTo7P53wEGqi0HzbWqBOPN3EpMTunqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=cILZ3ZSz; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cILZ3ZSz"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240326063110d7510e555fecf5cb6a
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZxQr1GpVUXGFqoYeN23nT14kUdN0qc6qsDCMakbO9UI=;
 b=cILZ3ZSzixILscPm+fhlwKE7SMkDbjfPiY4FhH45u13hxqIPpLYeikwN9fxUIw8dY7MUJX
 rZTqh825svvutE0V6O8p1Kz1RrZXb7jyYuqyOMDVJWb/7A+o5j6z6GZNnR4crMxhg06VFV6C
 Xd4xn2k5V8j/ZCRdp2nWcXXc0/uhY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 16/25] drivers/ipc: Make private functions static
Date: Tue, 26 Mar 2024 07:30:55 +0100
Message-Id: <fd810d6f227951476d6db9467060a36fd1bbe6e3.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/ipc/rtipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index 66176adad8..a91a32128b 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -519,7 +519,7 @@ static struct rtdm_device device = {
 	.label = "rtipc",
 };
 
-int __init __rtipc_init(void)
+static int __init __rtipc_init(void)
 {
 	int ret, n;
 
@@ -537,7 +537,7 @@ int __init __rtipc_init(void)
 	return rtdm_dev_register(&device);
 }
 
-void __exit __rtipc_exit(void)
+static void __exit __rtipc_exit(void)
 {
 	int n;
 
-- 
2.35.3

