Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7931391
	for <xenomai@lists.linux.dev>; Mon, 23 Jan 2023 12:25:51 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230123121541bc0cbd3b54432241b0
        for <xenomai@lists.linux.dev>;
        Mon, 23 Jan 2023 13:15:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=40yn11XT/R4VFbAQs4JZMnc8Elf1kgO4SeWIGhaqFeU=;
 b=c/B74+gk1IDkXn1B6SfG/Ipx570RNHqQ+E/fyO1SCIWCebNM4LMJtayqphnRZObicv7wYi
 7ETollrlouDJHWyjDr6EHcTjuQwtC2ZswAf9/BRrgfGIh/BGxaAcv8yMHkZtw/53/XycrVwe
 XnQZNh4AcWafKKDWpRPgiTi8/OaJM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] Mount rootfs for qemu based tests read-write
Date: Mon, 23 Jan 2023 13:15:37 +0100
Message-Id: <20230123121538.2256043-2-florian.bezdeka@siemens.com>
In-Reply-To: <20230123121538.2256043-1-florian.bezdeka@siemens.com>
References: <20230123121538.2256043-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Adding "rw" to the kernel cmdline for qemu based LAVA tests is a
workaround for a current Isar regression. The rootfs entry is currently
removed from /etc/fstab so the rootfs stayed in read-only mode.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 tests/jobs/xenomai-qemu-amd64.yml | 4 ++--
 tests/jobs/xenomai-qemu-arm64.yml | 4 ++--
 tests/jobs/xenomai-qemu-armhf.yml | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 166d472..b989576 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0"
+        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0 rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index a1dcc1c..5bf513e 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -50,7 +50,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vda"
+        image_arg: -kernel {kernel} -append "root=/dev/vda rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3b5bc10..1ab35bd 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vdb"
+        image_arg: -kernel {kernel} -append "root=/dev/vdb rw"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-- 
2.39.0

