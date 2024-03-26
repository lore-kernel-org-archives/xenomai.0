Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148C71B5C
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=NtHjTq1Q0yIOPwaupzLFj8L++lZij3PR+jg+SoFtnQGLj6XItD9L5Y5tU2hlo7gKZoVn1S0zs28zuQog78FSv8LOzhKq6g/+Ve2AVNSD21FWYUBepAsYONFF4zI52/EVkkDA8o7U9D1t9+bw2OdPr5TUOKaO51AWk9kljaZrnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=qb/tOk3v1a/2khxHyip0PNP9h0TCrM3OQxZRH3gQnhE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrOQ9wb/jI0+w1fRcRx67SJgzY7AjqkKvoROjirbpssKnJ5K/f3L0GlYGRv0ZH/xPHuc4vT/y2RD5OKpadmDuyCFwLXs4NL4bGmNQJ+S1ZPWJlP7J1FXrO4xHHSGeub6aXC3d68RUi5dWShXOkFZ5RU3VNaGJklnrli8GxtHTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Qlv889jO; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Qlv889jO"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403260631115410ff3c7ec84a2e2b
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=29sDZiOJwSM2RM/ksUjgoxOGX5/Afsop+jBSpkvG/TM=;
 b=Qlv889jO+dhW8TBNw9plAwXDRgCO0WqqtrhHlUOLgaWgD1JquQBM44c6fax6KT3dXJfqJw
 UiRnls6afHYRsgIn06AoxEW4Z6/vUAYmGPZxPahadR1YwnqfOLwQeTcsz+GcSr46oyggjdae
 pl75GWUmXI4BVktusWxn9qlvKcGg8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 19/25] drivers/net/corectl: Provide proper prototypes via corectl.h
Date: Tue, 26 Mar 2024 07:30:58 +0100
Message-Id: <7c7653e02bb847ef04cf9380ebf93d7ad2c3fbc8.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/net/stack/corectl.c         |  1 +
 kernel/drivers/net/stack/include/corectl.h | 20 ++++++++++++++++++++
 kernel/drivers/net/stack/rtnet_module.c    |  1 +
 3 files changed, 22 insertions(+)
 create mode 100644 kernel/drivers/net/stack/include/corectl.h

diff --git a/kernel/drivers/net/stack/corectl.c b/kernel/drivers/net/stack/corectl.c
index 9301defb27..52b5869ad2 100644
--- a/kernel/drivers/net/stack/corectl.c
+++ b/kernel/drivers/net/stack/corectl.c
@@ -17,6 +17,7 @@
  */
 #include <asm/xenomai/syscall.h>
 #include <xenomai/posix/corectl.h>
+#include <corectl.h>
 
 static int rtnet_corectl_call(struct notifier_block *self, unsigned long arg,
 			      void *cookie)
diff --git a/kernel/drivers/net/stack/include/corectl.h b/kernel/drivers/net/stack/include/corectl.h
new file mode 100644
index 0000000000..6dc7fadeb9
--- /dev/null
+++ b/kernel/drivers/net/stack/include/corectl.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2016 Gilles Chanteperdrix <gch@xenomai.org>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+void rtnet_corectl_register(void);
+void rtnet_corectl_unregister(void);
diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index 37c61289f6..f16becafef 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -27,6 +27,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <corectl.h>
 #include <rtdev_mgr.h>
 #include <rtnet_chrdev.h>
 #include <rtnet_internal.h>
-- 
2.35.3

