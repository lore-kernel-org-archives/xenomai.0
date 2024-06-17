Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F72137F
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638150; cv=none; b=DKm3euW5ptA4eO8F1ST8Enah2kFaPd7pl+b/OPrlQyztWmKNkZM1XXB4OY49MN6jlD2W3IwbnecX8tgq4IqxZT4ouiPSnazl3zIF0Pc6SM//8S9VX5Cu2kxlVpbuViHb7sJ3PFyxsTSEuekxe8sSSGSLEONhH96wG4QWfHkOSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638150; c=relaxed/simple;
	bh=0fMrpeTnBA1N43yOsP6Bghlo1jmVId+N2iulsFRBYao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qARrNEyBCo0E2iBvjJh7gSShltLduOLnqW12ciBmDH79i3S/57Y7d0lV94wliDBD1u1jWwIm+VNIj6i5av7Z6t+2mCqCR2+mXZ1KnhpjevDcvj/vQtc+mmyRWj1BU1/eeZPh9MJVQdxyZBfIhGKsVoGN8SdIyoeeNkk4Jt/gLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=DEg9n9HI; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="DEg9n9HI"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202406171529016e486b709470cc7b0b
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jun 2024 17:29:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tb85SnX9z8Um+wUOMxMsgo5DnhZR7rT+iafZ1V3s9xc=;
 b=DEg9n9HIusOw0TZAv8+BZTs44bSyqihwzEc8WNeRAmgcbofF0LFDNg7XMvuLuufabcvPu1
 NtQ4KRUrmbARUd0Bot/rrQvRnC9Mr6RmbpesTEJ6e0RCSzeCHaYAnDkHvSZGxy0slLLd7Q3F
 2CHRp0lfwSdC+wFqy1krprPicpy4s=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2] rpi4: fix arm64_defconfig CONFIG_BCMGENET
Date: Mon, 17 Jun 2024 17:28:59 +0200
Message-Id: <20240617152859.32359-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

Remove the typo "space" before CONFIG_BCMGENET, so that TFTP booting can be supported.

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 recipes-kernel/linux/files/arm64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index 94f7b5b..1dc8b69 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -1951,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
 # CONFIG_MACB_PCI is not set
 CONFIG_NET_VENDOR_BROADCOM=y
 # CONFIG_B44 is not set
- CONFIG_BCMGENET=y
+CONFIG_BCMGENET=y
 # CONFIG_BNX2 is not set
 # CONFIG_CNIC is not set
 # CONFIG_TIGON3 is not set
-- 
2.39.2

