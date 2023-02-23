Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A21FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:04:29 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230223070421748f618c9dad44f758
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+xmHNg5O00dA27qYK08h6VQBxUqLen/F8XGl13ZB4FM=;
 b=acbTZJszERwxMN9Wx/F9ljunIqA/2LhnkB9u87rQzpZVP73K0Q0VTAynwcuGCxP/GPr0Xt
 WtEI3rDXVTaDejiWa/sjkR9dPSDDTEa3rHH5Kow5njOzX5O8D8aAWtnrTNaEVESxWCRLApfk
 jFGbI79QnKICgcLtZb4orVngdPRXY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 4/7] rtnet: Enable compat ioctl interface
Date: Thu, 23 Feb 2023 08:04:14 +0100
Message-Id: <20230223070417.3969366-5-florian.bezdeka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Running rtnet for compat applications failed because the compat ioctl
interface was not activated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/rtnet_chrdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index 9457661a1..fa859c3bc 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -195,6 +195,7 @@ void rtnet_unregister_ioctls(struct rtnet_ioctls *ioctls)
 static struct file_operations rtnet_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = rtnet_ioctl,
+	.compat_ioctl = rtnet_ioctl,
 };
 
 static struct miscdevice rtnet_chr_misc_dev = {
-- 
2.39.1

