Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D1745F1
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=nIRjwIT2z/8aOLbZoDx4gVYCJc7yN0XxHXDntgZcp7Xf7I2+SsxoEP7AtnWvDY1t8xWVEzWP0GhQAU8iUmSph8vmBscjYbEFa/nIdTuv8TeW8XgdrVnS+HUVSr6UysyvLmlYWOKZnM3aiADdPWMOLxe/QiMEkLCzBueArB7OIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=ePMmP0GVnQKrP5euXSg2X5V72iEyPW6tZpjlqC9W56w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY+XJ2fKVS0W8SfR7QIDzbfNtEfHKTX3uNjBNcssjj2IEEXhFQV7Y7/Ywl9u+IMOyYMUWYuidQFH7fEUAXZkBdfWyqNKLtb9S1tCbPu5MZcBsA38SBp4RnBifPdEScFSI+MKwpx8LR9q8rCpPqClON9gv7aSgNepGECxYftmzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=I8kZx4i9; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="I8kZx4i9"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240326063111c9cfecaa081c2b5d1b
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GWkJKpbzz000MPlrXv4m0DFbtIVOcH05GLBTkDscuEs=;
 b=I8kZx4i9ErOYS0mFWpGb6LZQjSxbgkAWw9wamS/lGyAuLzjqjJSXUUWCMQPk/tismup+bq
 Gr5g4oJ6VHYazwIW2BeHe8NRPJNpaHkhRPkmOLzBYpmLUwxvbbCbBSlpLrIqbKhpxJbsVjxt
 3JjUUmOJrlsGUWIF1W4YsDRDAdbKc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 21/25] drivers/net/e1000: Move e1000_check_options prototype to a header
Date: Tue, 26 Mar 2024 07:31:00 +0100
Message-Id: <67d73da532f52ad5d9932965b1c2bca08454b8f2.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/net/drivers/e1000/e1000.h      | 2 ++
 kernel/drivers/net/drivers/e1000/e1000_main.c | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000.h b/kernel/drivers/net/drivers/e1000/e1000.h
index 44f1efa9a3..978b6ea9cd 100644
--- a/kernel/drivers/net/drivers/e1000/e1000.h
+++ b/kernel/drivers/net/drivers/e1000/e1000.h
@@ -388,4 +388,6 @@ enum e1000_state_t {
 	__E1000_DRIVER_TESTING,
 	__E1000_RESETTING,
 };
+
+void e1000_check_options(struct e1000_adapter *adapter);
 #endif /* _E1000_H_ */
diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 726b38ab87..bf4fadba9f 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -223,14 +223,6 @@ static void e1000_smartspeed(struct e1000_adapter *adapter);
 static int e1000_82547_fifo_workaround(struct e1000_adapter *adapter,
 				       struct rtskb *skb);
 
-
-
-
-
-/* Exported from other modules */
-
-extern void e1000_check_options(struct e1000_adapter *adapter);
-
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
 	.id_table = e1000_pci_tbl,
-- 
2.35.3

