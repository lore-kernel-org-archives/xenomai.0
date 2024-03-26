Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEB84A5F
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=Sl7jSwmbkRT5fOrXU7y4hYsfwb399vwpsifwoKPLXgoEzzbGwDCxN+aZgXBETq11ayM3dxinRjj0ocsWF9R87sPLOwM+MoKXcvtsejfQV/3kg189/bFTgrYYk5eeDIBZJAlUEjGHwHjpnm0J03i3skvJk9e4BEidzt49GoV8MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=bOb56sNpzjGZF774QteJvnRvSeBAeybjDaFLgm3abC4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDE9n/y/E+lpv1gtLEd5/h8tn2SYUVKD0NPZX1VZBMlFbJfa2i78KMXyrPKeowbuR0C+dqAPMaH0Aw1ZpJeQI96kuMGsphFLGGlIDRnKTcWVcDLZSEaVEzsU3sjL1A8JxfMbBdVWcyZthIJiphTeKdmAMrKZtzC7I+WmblYsGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=RqeEZV+2; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="RqeEZV+2"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024032606311101a48625eedcf95e19
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6orDzceP3N/Eud1XWwjfeh0ZCy+iFayqMMk8VooUQmE=;
 b=RqeEZV+2AUX/FIZ3qhsA2nIGR2xWHbZASkfR3NxCeoV7JEhT1LzZzbGj1O6wRF/zCyvgqX
 JwsWMOFgbc0W/foeFo76AdLJCjlGlS4a9nOXg/AzwZdyyYTe5RMCsJSe2HSAlLFXhUP13ieq
 WfCH+HMSDsEOQMKAp5blGjOJ5S5LM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 20/25] drivers/net: Make rtdev_init private
Date: Tue, 26 Mar 2024 07:30:59 +0100
Message-Id: <12098fa1e4fc6a02fcd8c9937b6a7dffe68f74df.1711434664.git.jan.kiszka@siemens.com>
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

541f99a2aabe introduced, among other functions, rtdev_init as exported
interface but never provided it via a header. Therefore, make it a
private function now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/rtdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index f639cf6403..a5a854a563 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -236,7 +236,7 @@ static const struct rtskb_pool_lock_ops rtdev_ops = {
 	.unlock = rtdev_pool_unlock,
 };
 
-int rtdev_init(struct rtnet_device *rtdev, unsigned dev_pool_size)
+static int rtdev_init(struct rtnet_device *rtdev, unsigned dev_pool_size)
 {
 	int ret;
 
@@ -259,7 +259,6 @@ int rtdev_init(struct rtnet_device *rtdev, unsigned dev_pool_size)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtdev_init);
 
 void rtdev_destroy(struct rtnet_device *rtdev)
 {
-- 
2.35.3

