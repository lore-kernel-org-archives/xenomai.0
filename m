Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB083CAF
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434681; cv=none; b=ZY1yHSKI4eETT6aabFs/cpcofma/voldmh9JXtlSBytmO9SSBoyjXCwIpmnTHZo7/xrq5cjTepMUyA7hsO6HJXW8bNkFBsaczEEq5b4ScUYE8cBD3Af1qSIZsdHjHfPfA9SZtT63vrrXM52CUpz5yyNSMPrAAEE21Ft0woyClgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434681; c=relaxed/simple;
	bh=GuX3WxS8QdidZ90hwW4fiLOdPKiqgvbCYu+qRFljxuQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHUDgUsCXCerbE5kX6FCn+53EuLoOb5BlAPiZIqmvfl50UKJHqWM/d93gdnlPeNupgadxX1XMuGqrL7v+tZUSwDaZfBuDAm+aVIqcGu0sKAqSvcOIwiED5sbaItgRFYNR+P4lMplJSeiAJp1O7OBfFbZ9yr36pksH8Qoo9OhDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=iOwDXwSt; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="iOwDXwSt"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240326063110254fa6de21f434d9fd
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SIVOVFkoJhx7M/+Onm9kjfYEd2Pmsyv7Ml+qg0d44qs=;
 b=iOwDXwStuzqWEBH9MdkfEATn2a/rwV0FZRD3IVai/oMJRW8psSRZ/lJxllufwdMscXDROz
 JwCdhiFoIHiTd8KZV2KJD9H+cGTkUpPkKdJ9edQrEDhu1pp1vQy2rSkLj0ErwE+DQtvLhTMG
 J2I2f6JY1R4LYMQujtGEvIndOKlcQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 15/25] drivers/gpio: Make private functions static
Date: Tue, 26 Mar 2024 07:30:54 +0100
Message-Id: <dc33a612f2d16c784007cdd6e375d42ab37312bf.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/gpio/gpio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 74ce94408f..5cf59c4688 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -307,7 +307,7 @@ static int gpio_pin_select(struct rtdm_fd *fd, struct xnselector *selector,
 	return rtdm_event_select(&pin->event, selector, type, index);
 }
 
-int gpio_pin_open(struct rtdm_fd *fd, int oflags)
+static int gpio_pin_open(struct rtdm_fd *fd, int oflags)
 {
 	struct rtdm_gpio_chan *chan = rtdm_fd_to_private(fd);
 	struct rtdm_device *dev = rtdm_fd_device(fd);
-- 
2.35.3

