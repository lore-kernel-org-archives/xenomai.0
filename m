Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34AAD38
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 15:21:39 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202301041521368dce046da759c91de7
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 16:21:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=KtaKUoszQOx915PpeBr0ccaSb0fhaEHb9Iu8t0vPBVg=;
 b=pWxe0+8w3e9KfPTF7h+zidQ3eHB8PZjnrfAI9MeAqCZ9PlirNMJcHQLi1XC7Q7v3uQbAGG
 c50vPvaKVsaehzx/vQkqLcY3eeVNBsNd2yHRRlxRQ+PqNALMMGt11iam41Z54DwkR0psntRk
 c3RfWYXXaK6Bk5BQxvq5odlg43WME=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/3] start-qemu: Start with read-writable rootfs
Date: Wed,  4 Jan 2023 16:21:35 +0100
Message-Id: <18e4ca3b65ab3881493b4e6a8d019cd62fe5efc8.1672845695.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1672845695.git.jan.kiszka@siemens.com>
References: <cover.1672845695.git.jan.kiszka@siemens.com>
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

This is needed by systemd to initialize the machine ID on first boot.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 33b6e65..51f71a2 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -33,7 +33,7 @@ case "$1" in
 			-device virtio-net-pci,netdev=net"
 		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
-			root=/dev/sda vga=0x305"
+			root=/dev/sda rw vga=0x305"
 		;;
 	arm64|aarch64)
 		DISTRO_ARCH=arm64
@@ -48,7 +48,7 @@ case "$1" in
 			-device virtio-net-device,netdev=net"
 		KERNEL_SUFFIX="vmlinux"
 		KERNEL_CMDLINE=" \
-			root=/dev/vda"
+			root=/dev/vda rw"
 		;;
 	arm|armhf)
 		DISTRO_ARCH=armhf
@@ -63,7 +63,7 @@ case "$1" in
 			-device virtio-net-device,netdev=net"
 		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
-			root=/dev/vda"
+			root=/dev/vda rw"
 		;;
 	""|--help)
 		usage
-- 
2.35.3

