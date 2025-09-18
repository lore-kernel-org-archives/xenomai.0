Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE66313D44
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210975; cv=none; b=RLv+VLixm0NOtxXDi+z7gSDojAc9YF8dKC1a9OTCKDvQU9mTo7eu22cMiIQqnOL+cGJ+ArGWGrgnl+jTHYRaslixzGMeRQxavPBqA1JYZRorR2Q5gdoBl19iIe2UnnKPgezFh9o307QcSdhMUSLIf2HSIxqTS3iOmcJTJyWLb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210975; c=relaxed/simple;
	bh=u6Ku57HqULJDk0EzZl2/QUb86BEt80a4cQ1hcSgnSmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLJec8s11pqgvstDNG9GLkzmf26lXK8lYZ3FFlEE9sR/YaVJkn4FeaYkyhYolSCVq5nOQ/DkjOmwu3Qk0m0oNZjTJPgdyIH7ToljFRy/1aDrb1Dn0wDi1ZvF1yNuRgeCOPc6LW29dUBa17WYRWB/tqM5/qUbAA3OkaS8Jx29F4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=DVZDnc9O; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="DVZDnc9O"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155609745086420b00020703
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+16uaJ8exNcKj38VSAZcKuryCAaR+3WhjM9JeGSCzE4=;
 b=DVZDnc9OA0rs2S3kgj1vuN7P0ZEK5cFTL3IAE1VZ2956sryeMXeFan1xz3FX8tkmrG0vE/
 BhvqVJY3fxSemEnf/qrs9ywmBMqB1Euv20CiQ6Hx8BC4KH+2jnXSiVvlXfi033S8GBACYTAT
 sH4Lqm1CA9HusdiGm4X9uX+hKsUoaFIyuT24BbYSkK9xrAPjj5uRBF2Iy0DCFEy6i9uaO1XW
 kmVdxq9AYOo1gYpUy+6H09ir8Nh0eNTUKu4bQYAtFV5c+/R06I5KBzdEKWqgUzA/cYet6Mla
 em0N8t82oxj/QkQ7p8dihKndlmF/bS7yMbROtE07ASaI2h9EAgAjCCjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 02/13] start-qemu: Fix grey console font for x86 machine
Date: Thu, 18 Sep 2025 17:55:44 +0200
Message-ID: <2229dfe7fc3e5866324fae65ec59908dc838e7e8.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

This must have regressed recently with newer QEMU version (seen with
8.2+ at least): The VGA console with the old mode started to show the
font in dark grey on black screens - unreadable. Fix it by adding more
color bits.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 1be31cb..7c3b842 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -46,7 +46,7 @@ case "$arch" in
 			-device virtio-net-pci,netdev=net"
 		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
-			root=/dev/sda rw vga=0x305 console=ttyS0"
+			root=/dev/sda rw vga=0x317 console=ttyS0"
 		;;
 	arm64|aarch64)
 		DISTRO_ARCH=arm64
-- 
2.51.0

