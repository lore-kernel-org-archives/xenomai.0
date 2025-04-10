Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F528CF51
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294601; cv=none; b=BSq9QyRTfWrgGVWeKLcXtecjPFU83RCja6d8yQAz50bOhbJ46cm9Qi4Cz7yJnBVavyXwST03AaGU0QrJySKxy+iyWpzzWwhtpFJ+TLg8HpYqQF4P++DHJjjdsATgFNmKm29Zbs4WEhXUY3bgdidRl9lw1jljWIZMdStlODUp4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294601; c=relaxed/simple;
	bh=hfvPAynjGj0mErleX1AbxizKsKP6hTAYsjKHvDqr1H8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAET1I6KO4dZLrhjpXhTYHmWvvImXEsrZ05UTPHkw0t5szvFSFgGltnb/UoPcZAJfWncgFYmLyvGuLdaz7zHZS7nDb68OCaVK8wK9i+EFZHIM/4W4D5iBQnc0rIctpIQvFTimlIzsjMGvT7KE4Zo4c4rYqKMLg2bIwYvFQI4IFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=cyf09MQU; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cyf09MQU"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250410141631f02f32af9f29b3761c
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZEmV4yMJFq3UFl4XblHU3NaJLZwdNXpBoegqg2fK0hI=;
 b=cyf09MQUUEkdQci8Dw9ELOnWHuvkxmmKZp5+5KJvRLZOi6oZuql/CPKjsjR9szU7wjgL7D
 mlvqrDj1k0Bdh8FfP3Jt4TdToDcDMJC9tI8EsMtaQ7iY0opsTRXJ0ITOapA91/5IeWaKrI3G
 MYqqV/8ZixGTzO3vnXxkSVQbhaU5REo30AvUzXwyl2qsuVoRflJE6Nz+IBmLFFazadUpCGTJ
 Sx2cOTIyCKb5PBaLdVsyx8FnNh08GlCgH0mVtXt0o0kyzG9FGRqt23Z9JlL9XEIqD0wTizLQ
 SQihdlY9vf9SCUu1Iwbk/Tb3nFq2ufBLjMUMMMq6bZR8szVbDotoKPZQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/7] libevl: Update to latest release r50
Date: Thu, 10 Apr 2025 16:16:26 +0200
Message-ID: <939a06154f3e4eb2315ed082404d6e9e304c84ba.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
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

Allows to drop a locally carried patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...i-Take-Debian-multiarch-into-account.patch | 40 -------------------
 .../libevl/{libevl_47.bb => libevl_50.bb}     |  1 -
 2 files changed, 41 deletions(-)
 delete mode 100644 recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
 rename recipes-xenomai/libevl/{libevl_47.bb => libevl_50.bb} (77%)

diff --git a/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch b/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
deleted file mode 100644
index 3c1f48c..0000000
--- a/recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From b4447250c7fff6940c1bb6f0308da617bebaa643 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 2 Jan 2024 14:01:19 +0100
-Subject: [PATCH] meson: setup-uapi: Take Debian multiarch into account
-
-Check also the Debian multiarch include path for the chosen architecture
-so that we can support (self-built) linux-libc-dev packages that contain
-the evl headers.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meson/setup-uapi.sh | 12 +++++++++++-
- 1 file changed, 11 insertions(+), 1 deletion(-)
-
-diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
-index f2d0774..633c5ed 100644
---- a/meson/setup-uapi.sh
-+++ b/meson/setup-uapi.sh
-@@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
-     link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
-     link_dir $UAPI/include/uapi/asm-generic .
- else
-+    DEB_HOST_ARCH=$ARCH
-+    if [ "$DEB_HOST_ARCH" = "x86" ]; then
-+        DEB_HOST_ARCH=amd64
-+    fi
-+    DEB_HOST_MULTIARCH=$( \
-+        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/dev/null)
-     link_dir $UAPI/evl .
--    link_dir $UAPI/asm/evl asm
-+    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
-+        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
-+    else
-+        link_dir $UAPI/asm/evl asm
-+    fi
-     link_dir $UAPI/asm-generic .
- fi
--- 
-2.35.3
-
diff --git a/recipes-xenomai/libevl/libevl_47.bb b/recipes-xenomai/libevl/libevl_50.bb
similarity index 77%
rename from recipes-xenomai/libevl/libevl_47.bb
rename to recipes-xenomai/libevl/libevl_50.bb
index 1d93e1d..26bcc2e 100644
--- a/recipes-xenomai/libevl/libevl_47.bb
+++ b/recipes-xenomai/libevl/libevl_50.bb
@@ -12,4 +12,3 @@
 require libevl.inc
 
 SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
-SRC_URI += "file://0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch"
-- 
2.43.0

