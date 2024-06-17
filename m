Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB717F
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636173; cv=none; b=tIn2RZEyrLGXqFgXwLAORrHY5QXgH9MJZ76OcRxIlKafBhVltdZPouHQetwJNFRBHUl4fXchpDzQGYi/c9h53uzqaxZSleJojolMpNGXZ6459t0QdBtl4uxgfbtMAjOtARD4bxn4HxflP9U1DNM/YODqgB1L2fHrJorRyknGX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636173; c=relaxed/simple;
	bh=cDw49oDAGRtcJbFblhDh1PV/FyU+vO0RQJ5ON8NSlZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJkUJYhOOrbV+66w7ANGkHbDnBVpXqrwLYQ78CQYMg9K/pkqyZSzQJucu142etshYYeNr1P5XrWQ9CgdEGYdHIP+KELBI9J9gQk8SVEt8GrZUi+XC0QK5Zti8XL+Z0ofs/OL7F7X7ZwnTJD3s8vOFCYLJ07IXQ6Rc9moSS9Ms4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=fFYr7ILt; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="fFYr7ILt"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240617145559564ec81e69342e0de4
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jun 2024 16:56:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=y/AKD+EfAlXJQbn6F9LBQb7Owgp7XrsIwTaWLY4ePAw=;
 b=fFYr7ILtuhJhyQVFg5X/jY5oita3zfqQ7x7MtOkkUoCl6/cI8nGPYyEoQr89U5QJyLj7mt
 qaoP8r3DaPFx6li+0qnz8piWNpfKVxDHwbTdeKGAlx3o3NLNOhPDxATUJNhfN4wDOotxNuhe
 bK203z7aLkSiRbMdQBbS7TNxfnVZE=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH] rpi4: fix arm64_defconfig CONFIG_BCMGENET
Date: Mon, 17 Jun 2024 16:55:55 +0200
Message-Id: <20240617145555.29385-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

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

