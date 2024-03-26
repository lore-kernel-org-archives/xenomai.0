Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0381749A
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=ON95XiyTEe29soZgUrZWH69GAYuh5Fj6PmcyeLd2CR5E8vpgSbJAnTtkLaS5Scy9i9oOWxu81ojQpZzc9kcxF5LziRK+FG+uCvB7oaGzr3fCR8j2U7+kddZkZq0om86XaifoHr+Kmraghu3eE2Vp1StlFmB10iZsEyc8k/6KSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=9yi8I/FsAx0A1LIYlBc8wQBG0PoXbSrHUF4Xl7eZA3Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1RFAUsNZSN1mF9FIQeKxMlX/v6CmN5tYpVFwoJcpJgpIlds2XYve+Q2cUDNsWGIzJJgS29IHdAICh9+kjz6L49f+8qGoOmK6NYQtICa3F4r6d7Ma2OCp9f4G5ZHJnsdFEVOTx3LOBC1Hxa7gqwcTclOFcEbN07SzjYZSehSbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=oNLhVkL+; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="oNLhVkL+"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240326063112ee01006daea7da32a7
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KkE6uPzAdGGZX/Ykf1YEB6PehIjFCxaqdjUsF3zV8WE=;
 b=oNLhVkL+5i5hi6jq763WRRgNR4KvVGTOBK6CqmN9H7Cw2to/dKNMKrHmSi4AU98plG6hw0
 QkyMiD37JhHwqbt1Ewq+rRdo9rsAwsV0LZZ3D3EEw49tCIyrr6CEjGuHkIboD5S3cTCbKvg9
 DjBDAxfhFy8tAAG58bv/bta3A5cxQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 25/25] drivers/testing: Make private functions static
Date: Tue, 26 Mar 2024 07:31:04 +0100
Message-Id: <a34701b78e07c9157c10a888c53381b1621c7a87.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/testing/switchtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 674cdef736..f8f6c89207 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -723,14 +723,14 @@ static struct rtdm_device device = {
 	.label = "switchtest",
 };
 
-int __init __switchtest_init(void)
+static int __init __switchtest_init(void)
 {
 	fp_features = fp_detect();
 
 	return rtdm_dev_register(&device);
 }
 
-void __switchtest_exit(void)
+static void __switchtest_exit(void)
 {
 	rtdm_dev_unregister(&device);
 }
-- 
2.35.3

