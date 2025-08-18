Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AC3203AA
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520017; cv=none; b=FVsrBo6J50gkL+r3fm258Gb2EUmmLhOlXXqIeNNcfkX9n+K1toJz2FOPpbzaMYvE7FBFFF9XwIOe6noU5268GtTQurspt30akjZTo9wsRcsUxgxLkshs4/HU7sQqH/KZ4woCpwGxe0hJSVi2ct8AQH7neI6jn9RnLe1lk2mMdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520017; c=relaxed/simple;
	bh=Q122OCIGvI60F8gEOeoZi1hYQuzXJG1nYm45DkG35qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbVq2PXNCtKU11mENo7GJpsXyp/Gmr+tiGDzXVL2hRC0KoGTYSlNB7fiiw31huLXSgSB1L2ReRImsDNRFJ88u/oL0PmMz5dtbMbl0pVCOmcvWl8R7TdPmENTFx/T/M+khmBlakbXLVteiUCpWRSXW89bYZFP7DJzaHWQUdOZbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Wuhwwg6S; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Wuhwwg6S"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202508181226459af10027ca9f0ddd28
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XC7YduSVlJPUWAWNMFuXFVkX1zvWhmU3DxokhmqGgs4=;
 b=Wuhwwg6SYVpZP4noO6yjm328BzBbhrjkfxcq/xz6NkOA1alqNaAAOVJ71XPWnC8zdlfy6Y
 PhUJafKYjeyJxxdTv9v9RmHue4QNYlpCDUNyKF2Z/0JOE/XG+bOlIG8ScqHaGBXUJz3o4pXz
 DMoXoGIds62GFmcQA3mkU9ldOAU0UPRgBz02nBiYwM7HlqGw/jt1i089FWiYbxSAz/1r45fi
 YwaPV8oozfsDDDpjRD4QQL12dA10vA36GGaka404tQpKeqV9e5SamCxY6VDNPlLOKgLRtMtV
 MZerBiM9WHyx3ydb6/eAbvno5FD2sq6rjC8GC3y92KrJQ1VdTXHyumbg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:44 +0200
Subject: [PATCH 02/13] drivers/testing: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-2-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/testing/heapcheck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index fc6e91d3a..00577fee6 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -548,3 +548,4 @@ module_init(heapcheck_init);
 module_exit(heapcheck_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cobalt heap test driver");

-- 
2.39.5

