Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8D55783
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299335; cv=none; b=p95SXcaTO9Fc4yd8/3GJuS/8PuH8Yj7VdajeoGxfOjAHWbsNfLBWYmDd2ssjfaZ4AzpuoLzT69mXHuMnbY02RmzFLadEbBt5A2tz+xh7sqYKcrQfFH8Wdxu+rpvX6fPYHT90TKYltL1ONCOaiux1g+FAwwI9fwz6iCWAf6ErfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299335; c=relaxed/simple;
	bh=jxLwaAVKxezPEketh+I2s1L8eGt5UI9g5GZfuyfOzsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIuIiASnsvP+zvoJMyKsAUDWcRRfM8ckwqE5s4p/2ru5nxCzi+yIiFTu4/L6OVHQjdVn5YjijGL/frocYIsFvYU+Pn+THcPLdco9jj8am3+tRyBj1+5rJ8ChMKMHj8wErie3UY1oe5BEu1xiHOlpSrczNcNpAKz2nEPUIZNLbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=h/sIkgKa; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="h/sIkgKa"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240521134845bcc461aeadedfa25d7
        for <xenomai@lists.linux.dev>;
        Tue, 21 May 2024 15:48:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yxK32uztXE8ZNdzxc8X7GY31uL6KkbrWAlhAgVzBuo4=;
 b=h/sIkgKaE1MrLGOiCX6mbEynn+4zZjDl/JGyhtxS0ZR2iFyeg1Nn6jnPAM8roFR7BufpqK
 IvcFppWlFtPROq4IF2sjCI8AkNSQ8POqQNPVGy4qTWVZRZavBt5QDiVmj/L92+aFSeRPvkNY
 f8wK7zfjCpiA9MmMizX+9yMqsTKoc=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 3/3] rpi4: add building options, remove old kernel and Xenomai versions in kas menu.
Date: Tue, 21 May 2024 15:48:41 +0200
Message-Id: <20240521134841.21749-3-yi.jiang@siemens.com>
In-Reply-To: <20240521134841.21749-1-yi.jiang@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

The following kernel versions are removed from kas menu:

 - Xenomai 3, Head of stable/v3.1.x branch.

The following Xenomai versions are removed from kas menu:

 - Xenomai 3, Latest 4.19-cip I-pipe release;
 - Xenomai 3, Head of 4.19-cip I-pipe branch;
 - Xenomai 3, Latest 5.4 I-pipe release;
 - Xenomai 3, Head of 5.4 I-pipe branch.

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 Kconfig | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index 669ea65..13699bf 100644
--- a/Kconfig
+++ b/Kconfig
@@ -45,6 +45,10 @@ config TARGET_HIKEY
 	bool "LeMaker HiKey"
 	select ARCH_ARM64
 
+config TARGET_RPI4
+	bool "Raspberry Pi 4"
+	select ARCH_ARM64
+
 endchoice
 
 config KAS_INCLUDE_TARGET
@@ -55,6 +59,7 @@ config KAS_INCLUDE_TARGET
 	default "board-beagle-bone-black.yml" if TARGET_BBB
 	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "board-hikey.yml" if TARGET_HIKEY
+	default "board-rpi4.yml" if TARGET_RPI4
 
 choice
 	prompt "Xenomai version"
@@ -85,6 +90,7 @@ config XENOMAI_3_2
 
 config XENOMAI_3_1_LATEST
 	bool "Head of stable/v3.1.x branch"
+	depends on !TARGET_RPI4
 
 config XENOMAI_3_0_LATEST
 	bool "Head of stable/v3.0.x branch"
@@ -141,19 +147,19 @@ config KERNEL_5_10
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_5_4
 	bool "Latest 5.4 I-pipe release"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_19_LATEST
 	bool "Head of 4.19-cip I-pipe branch"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_19
 	bool "Latest 4.19-cip I-pipe release"
-	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
+	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
 config KERNEL_4_4_LATEST
 	bool "Head of 4.4-cip I-pipe branch"
-- 
2.39.2

