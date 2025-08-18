Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95A32038D
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520018; cv=none; b=XPitsRCDYq8WIH3cGdsynNXGgnX9NNlEuHjARS4yv+7bQWXtrVjWjI+prhvSU0S5643TM6d+iAf3XFeWbiKV6MrITh1zr5grjgxYrXflh0Scd89k2V0+Q1F5sATodrp7VzmWFPqDiZYc9VvTP/0WUAsv2fJEq9YUAG8vdaejNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520018; c=relaxed/simple;
	bh=lQo6jsvgbNjKmc+El8i3zkk1Zm6vgiFH5Szjs9IKyh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcAI8EirMTFkJ/FLYAqNuzMzE4F7rM3VL9V4njXeeRcyZXrci9v6/i61CbuGlRmSzuC2gCRmq5TL0FkoryCrpiv5uJHyxkDspW32BBcDSvA5N8di8LSu+eDFFkM1N/p86wo4xMqimT94UxqhHnSIo5hDbl7kURv7Exl0dJV9Vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=f89GjyaR; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="f89GjyaR"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025081812264716e4a5f510858496d3
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3cEJymNzgONeog6yD83UZCu8s0V8t5Q3ptB0JKhiJfM=;
 b=f89GjyaRj8MayjEqm7H+Bs1GLHkkB7Bp6Jq/q6v0X2QJa8h8ANoNTydDCCS7Dzhdiubxdu
 jcGzpvUbYzL9kkwuTUZSDCPCd/9AfuOv9+a+PCrPuf66Mj/uzOoqJMp59Pu7RwnDwg0uKHrN
 VSIXrn3WWxyyfmjtglzPbNX42PSMnDmIbi4lPATCXwMbwMnWAtmE12dnCpszCpE5Z/sx9V1e
 1BKxEOZMLvNyt66f7NgEVBhjtCfpezlrEUQjO6t1nOmd2ijTApIblQxkTrwy/iKIthi/yrTn
 55pwRHDtJMGFfpU6LdxRQtBL9W5kAuRDqPMxcan2MbWVynfaJDsY+mrw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:55 +0200
Subject: [PATCH 13/13] drivers/udd: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-13-c57f195e3f93@siemens.com>
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
 kernel/drivers/udd/udd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index c7b8f5c7b..70f6f1442 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -660,3 +660,4 @@ struct udd_device *udd_get_device(struct rtdm_fd *fd)
 EXPORT_SYMBOL_GPL(udd_get_device);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("User-space device driver framework");

-- 
2.39.5

