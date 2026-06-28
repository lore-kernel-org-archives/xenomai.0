Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC05474E
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622283; cv=none; b=RSlSWj7W4xvN5jIoXvc03TxPFhJJitS9Cgnq9bpsF6YLZtNmI0+ksyTq7Je9vn4v2FUBtzSABVr0hB+ep3+z+lDE9sMo/rgbFERpSdyeb8JYXsfXvLepFHitJRz4bGGyqmDU8UZvKw8vzma/0edhery4jRNnQcp1bE0GsE12DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622283; c=relaxed/simple;
	bh=t/K7QYBysKMd2qO7dMv8wqMEcr+qSaCSa/mgJyYsv94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doBHnjpJCcpiW3RSEzz7lLsR9B07OfoiDI/3SqT/5wDuJhxeY8ZhMvBgIzT824vZG4sGc0Jbfo2xY49JabHukeC3rC1Hw1JMlG1qLpUa4Oa607aIowasnCoQvvAAq/YL7O7aHYa6EtLksXtB1BiR86d8pjnwWC/akeLmeNnpqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AnZdgTie; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AnZdgTie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Ul1ZWrIMc0kzt0M3Z/2BqCGXjKyoL1hMmlSyo/UUF24=;
	b=AnZdgTiekY04+Wv8YCiK9HTzolZmv5MtZgjDUAFZrY7B58rSNN+913z68BSeTD
	+TU9pED67f+oB6owrK/AqtQHJlPp+1E3svwbPrx8vetcGx2MJihQrBNQowkxiuZx
	5sOgB0ZkoRMZSgDM0onHuZpGLroyWFde0tqiBt1YFObpI=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S3;
	Sun, 28 Jun 2026 12:51:10 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 1/5] doc: replace legacy I-pipe usage with Dovetail
Date: Sun, 28 Jun 2026 12:50:55 +0800
Message-Id: <738207fd746e8996312b8cb4559c5642980e3c36.1782585785.git.guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
References: <cover.1782585785.git.guang_feng_wang@163.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF47Gw48WF48XFW3JF1fWFg_yoW5Cr48pr
	42v3y3X348G3WrA3WDKa95ury5Zas7Kw1UWryqy3Wkta45Ar4Iv3ZI9ry3Zr9rCrn7C3yS
	vryrXa4kKr4fC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWCJfUUUUU=
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+R7jXWpAqD4B7QAA3J

From: guang feng wang <guang_feng_wang@163.com>

The installation guide still documents prepare-kernel.sh and several
Cobalt kernel preparation examples with the legacy --ipipe option.

Update those examples to use the Dovetail option instead.

Signed-off-by: guang feng wang <guang_feng_wang@163.com>
---
 content/installation/_index.md | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/content/installation/_index.md b/content/installation/_index.md
index 0febbf6..673b51b 100644
--- a/content/installation/_index.md
+++ b/content/installation/_index.md
@@ -40,7 +40,7 @@ script which sets up the target kernel properly. The syntax is as
 follows:
 
     $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
-    [--ipipe=<ipipe-patch>] [--arch=<target-arch>]
+    [--dovetail=<dovetail-patch>] [--arch=<target-arch>]
 
 `--linux`  
 specifies the path of the target kernel source tree. Such kernel tree
@@ -197,7 +197,7 @@ typically run:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
-      --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+      --dovetail=dovetail-core-X.Y.Z-x86-NN.patch
     $ make [ARCH=i386] xconfig/gconfig/menuconfig
 
 configure the kernel (see also the recommended settings
@@ -213,7 +213,7 @@ would be as follows:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=i386 \
-      --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+      --dovetail=dovetail-core-X.Y.Z-x86-NN.patch
     $ make xconfig/gconfig/menuconfig
 
 configure the kernel (see also the recommended settings
@@ -227,7 +227,7 @@ Similarly, for a 64bit platform, you would use:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86_64 \
-      --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+      --dovetail=dovetail-core-X.Y.Z-x86-NN.patch
     $ make xconfig/gconfig/menuconfig
 
 configure the kernel (see also the recommended settings
@@ -250,7 +250,7 @@ cross-compiler:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
-      --ipipe=ipipe-core-3.10.32-powerpc-1.patch
+      --dovetail=dovetail-core-X.Y.Z-powerpc-NN.patch
     $ make ARCH=powerpc CROSS_COMPILE=ppc_6xx- xconfig/gconfig/menuconfig
 
 …select the kernel and Xenomai options, save the configuration
@@ -267,7 +267,7 @@ will look like:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
-      --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+      --dovetail=dovetail-core-X.Y.Z-arm-NN.patch
     $ mkdir -p $build_root/linux
     $ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root/linux \
       csb637_defconfig
@@ -285,7 +285,7 @@ follows:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm64 \
-       --ipipe=ipipe-core-X.Y.Z-arm64-NN.patch
+       --dovetail=dovetail-core-X.Y.Z-arm64-NN.patch
     $ mkdir -p $build_root/linux
     $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=$build_root/linux \
       defconfig
-- 
2.34.1

