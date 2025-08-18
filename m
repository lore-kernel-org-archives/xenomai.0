Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E831AF22
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520017; cv=none; b=pq7gj0RPenYofdLixFQ+62kkHijjO7aV1IHRFyvTV0BN43LO7zh+/qPh56f4P7KZEM4hftR0YcpW7iyIZfqd4woWqRjNMavwwFbbStfx+oNdZUbFndUb0XLfInmSQxZ7blqweqC1WgYsessGIom2OVvuNDGIhXHFYjngtwmjywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520017; c=relaxed/simple;
	bh=Gtb26EJb8k/RH9FZL6HTXUsBE+q9ql/Qw9AJ8dD4mYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyZmdGTOqiwKJXkslnGvFLUQK9fVAfMuvvRlc4kKDrCB49pGUEh2BoZMrgPVWf7glupYzq/KSmMfJpFSj4SlmzAQ0tIu+qG829wol7LgjtG9cHRTW16/ZSw8Ot15z6ZhcVkGxddPJUndpTDWYNx3wI1RlWWkl8mX5jZ7ryP6pC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=d70VtXb9; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="d70VtXb9"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202508181226473e8b4a06e22550972e
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DI1KjdjzkiWkSC1j3SBMI79Iv23MOniX+86HWhhGovg=;
 b=d70VtXb96J/ptEesJh+peKZpYiUOwwnX3kdLFAnB0EUBwWOf0Vv5bvYmtgWXHX/KVNgD52
 PDnvhNSTaSk9PrC+XT41NgV7N5maq+0+31mqUvskJanH2WoMFS/46el9fPeNOv1X88Dcfz+s
 XpJAHAwJwomXlKqvnW+OmTuiEVnBtsQ5y4QLIuEOHLKYhpYbILDmgs//QXdsJQmHlW/IYWSK
 bEH3a7RjXiWLrPw32SPqQ1b2qh4rvW8SsHhRzjxkeZmEDOE3vnIZrsyG0InUmYSmtLZyGwjk
 6GirB/WINE1ftML70OIgUzqv5FM4ymi5m7GQ6zi2XnPNr5EWE0ddNtoA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:52 +0200
Subject: [PATCH 10/13] drivers/net/addons: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-10-c57f195e3f93@siemens.com>
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
 kernel/drivers/net/addons/cap.c   | 1 +
 kernel/drivers/net/addons/proxy.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 12cea2bf2..5ffd992da 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -35,6 +35,7 @@
 #include <rtnet_port.h> /* for netdev_priv() */
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Real-Time Capturing Interface");
 
 static unsigned int rtcap_rtskbs = 128;
 module_param(rtcap_rtskbs, uint, 0444);
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index 752cdfe9f..d63bb13bc 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -439,3 +439,4 @@ static void __exit rtnetproxy_cleanup_module(void)
 module_init(rtnetproxy_init_module);
 module_exit(rtnetproxy_cleanup_module);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver to transport IP data from/to Linux kernel mode");

-- 
2.39.5

