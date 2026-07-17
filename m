Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504A37E2E4
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321923; cv=none; b=VeOOiO0T9AVOibF1NKliN9xS9KKC8rlWxPCr9kzjZzahUq2VWcysdxmYEvBWgbpU+Nye+K0WZew2xdpa4frKzzboXXaIvwcSqy2V7ZWuv8HYCsj02h4v+VQaTZuZ2H/4A9hStD08Z8DIVQlqlkbpCRpVxTEf5vkcbM40YQ940cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321923; c=relaxed/simple;
	bh=JFmbQF1YdNBI1CSsN3XBXkpeK/PsObo7OR+T0WQOLnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avz5XZlf5+w5fH9LFaY4As1uQcIinXz48Ec2UCflDT0YPQnDuryiw+2N0DzgDCOBKTgY/Lriupxx8POeiSyrCDG4Q9MnBvrc0M3ROQipXv9WgFa4HiSljBVadTzyYMn1/YX5YTgx7Rla83jHQgCQpsk05sn5sr2v8QL0Lvr5ejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3/MkBhO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3/MkBhO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954c9f380bso5694155e9.0
        for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321919; x=1784926719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3OCwdStWMrdDwmnbg6SksGrpJZxE6Uf2tFPwe8kg8o=;
        b=K3/MkBhOnUXhL7nIHZLDRR+pW9z0vq9AMhxSuRkUGp/+iKEjZ6DrYcv0Ghx78AFXU7
         Rh6c43v64pQ9H1SAiogwPrV7GqejyCbed8yoinBjOHJ4dJ/dtoxCpyw4yr4d9ZRo/3A9
         n6xpy23WRERd7/FU4Ru2sEskCJHhxmpCtdMcWfTJ2UWkGlw+ufHjzsr55wmPesN06cPz
         jC8qnXxLj8lSAcwMy+Al+1D/SiPRQuVXv/MWlYIBFK+DrbpuqbyIgT4VG3BKCMuUevdc
         lmh9g7oEGl+0kjN9GtdtoudX+r9zxW/J0cGYh6468RobHvzmMlmcHrxhESODqx9RyMl9
         VHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321919; x=1784926719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d3OCwdStWMrdDwmnbg6SksGrpJZxE6Uf2tFPwe8kg8o=;
        b=L18mLduqj5BMWIYtd2OuKbod5WcWN4zE7tb1swSFGLjzMsC2OegRB55l7br6sQVZl6
         rnXAEVv8kpOvuemHANpqmy8doyle9nXkB2q8gw9to9YJQsuCa5Hew/GpUDajV9KZ9mrz
         PxX5dgwDo3eB8GLN4tHMUN0Rnbz5freEFEmNa8NAtZK6XP6k6ZXn0nHb2/fg03rp9mjQ
         SatTIB04i9JETDsMNkLQjWonfu20DVV9dxxBaQeEDLQN35BwWv1aFkleuT0wn7rzrQXe
         VZ6vFoKtc9ZLMtGjFca8SLFFHzDpXrMmTXMzQroGC/GEjKieo9/6YXECmkOOm2Imd0Ib
         Sj8A==
X-Gm-Message-State: AOJu0YyViicLWySixjJtZ7m75qmdTpBnpfxIGTICdxa50XUUc6fM/2wq
	O0Y2v1ATfWacoNIi2blsVUH5NFgUYcnop5dFmT/HCTU9nB8yehw6bwdQByX5iA9o
X-Gm-Gg: AfdE7cmVjf56rvg5Ox/3AHR+puE4uAdkUsmjRh8a3CGkB1YgIW2Cq5piOqBJOI+35IF
	6XR4PlMgkM3XNlcDii4BaTWzKw4Gxpb1vV6pSVnGxBPYTqxfHsvk9SVNLNRgLvlN4x0xn2CtNpM
	zfHvxYx4ZJVBVoh4I1N84gIVHik3s1LCMWVFANsTfieaIJQuAOTGX+JQnlPPM0Lx+SZch/7sHqE
	iYitn6rtr+W8yiJWY/A+7ksAiiD38Ta17+PJhE98kEIzZcyI50yoW7kDNbH7B0eSN3LsjKrFUCp
	2sIiYPsDExayE8Gu58qQKbu0nbjeEK++I6Kx/XEB966nOsIG26pE0HRfnyTJWVd0AzsAty0CSmg
	THQYhSW+gRsFLerV58ftYwiURVGT4X3KWx0c2aBuRKLTOTQCSa2VfuWLkL44PAVgTjyNgAAgu30
	4mfK9O
X-Received: by 2002:a05:600c:350f:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4954a50da83mr51560905e9.24.1784321919012;
        Fri, 17 Jul 2026 13:58:39 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e496ffsm7066121f8f.3.2026.07.17.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:58:38 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 1/1] debian: add debian package config
Date: Fri, 17 Jul 2026 22:58:20 +0200
Message-ID: <20260717205820.8359-2-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717205820.8359-1-hannes.diethelm@gmail.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 debian/README.Debian        |  6 ++++
 debian/changelog            |  5 ++++
 debian/control              | 33 ++++++++++++++++++++++
 debian/copyright            | 55 +++++++++++++++++++++++++++++++++++++
 debian/libevl-test.install  |  2 ++
 debian/libevl.install       | 11 ++++++++
 debian/libevl.postinst      | 50 +++++++++++++++++++++++++++++++++
 debian/libevl.postrm        | 41 +++++++++++++++++++++++++++
 debian/rules                | 22 +++++++++++++++
 debian/source/format        |  1 +
 debian/udev/90-libevl.rules | 12 ++++++++
 11 files changed, 238 insertions(+)
 create mode 100644 debian/README.Debian
 create mode 100644 debian/changelog
 create mode 100644 debian/control
 create mode 100644 debian/copyright
 create mode 100644 debian/libevl-test.install
 create mode 100644 debian/libevl.install
 create mode 100644 debian/libevl.postinst
 create mode 100644 debian/libevl.postrm
 create mode 100755 debian/rules
 create mode 100644 debian/source/format
 create mode 100644 debian/udev/90-libevl.rules

diff --git a/debian/README.Debian b/debian/README.Debian
new file mode 100644
index 0000000..db81e67
--- /dev/null
+++ b/debian/README.Debian
@@ -0,0 +1,6 @@
+libevl for Debian
+----------------
+
+libevl creates an evl group. Members of this group can use the kernel realtime interface.
+
+ -- Hannes Diethelm <hannes.diethelm@gmail.com>  Wed, 25 Mar 2026 12:22:44 +0100
diff --git a/debian/changelog b/debian/changelog
new file mode 100644
index 0000000..099e5c0
--- /dev/null
+++ b/debian/changelog
@@ -0,0 +1,5 @@
+libevl (59) UNRELEASED; urgency=medium
+
+  * Update r59
+
+ -- Hannes Diethelm <hannes.diethelm@gmail.com>  Mon, 13 Jul 2026 10:48:21 +0200
diff --git a/debian/control b/debian/control
new file mode 100644
index 0000000..152b339
--- /dev/null
+++ b/debian/control
@@ -0,0 +1,33 @@
+Source: libevl
+Section: devel
+Priority: extra
+Maintainer: Xenomai <xenomai@lists.linux.dev>
+Rules-Requires-Root: no
+Build-Depends:
+ debhelper-compat (= 13),
+ meson,
+ pkgconf,
+ libbpf-dev,
+ cpio,
+Standards-Version: 4.7.2
+Homepage: https://v4.xenomai.org/
+
+Package: libevl
+Architecture: any
+Depends:
+ ${shlibs:Depends},
+ ${misc:Depends},
+Recommends:
+ udev,
+Description: libevl libraries and tools
+  Xenomai4 EVL userspace libraries and tools
+
+Package: libevl-test
+Architecture: any
+Depends:
+ libevl,
+ gdb,
+ ${shlibs:Depends},
+ ${misc:Depends},
+Description: libevl test suite
+  Xenomai4 EVL test suite
diff --git a/debian/copyright b/debian/copyright
new file mode 100644
index 0000000..31efcd4
--- /dev/null
+++ b/debian/copyright
@@ -0,0 +1,55 @@
+Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
+Source: https://gitlab.com/Xenomai/xenomai4/libevl
+Upstream-Name: libevl
+Upstream-Contact: Xenomai <xenomai@lists.linux.dev>
+
+Files:
+ *
+Copyright:
+ 2018-2021 Philippe Gerum and the libevl contributors.
+License: MIT License
+Permission is hereby granted, free of charge, to any person obtaining
+a copy of this software and associated documentation files (the
+"Software"), to deal in the Software without restriction, including
+without limitation the rights to use, copy, modify, merge, publish,
+distribute, sublicense, and/or sell copies of the Software, and to
+permit persons to whom the Software is furnished to do so, subject to
+the following conditions:
+
+The above copyright notice and this permission notice (including the
+next paragraph) shall be included in all copies or substantial
+portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+
+Files:
+ debian/*
+Copyright:
+ 2026 Hannes Diethelm <hannes.diethelm@gmail.com>
+License: MIT License
+Permission is hereby granted, free of charge, to any person obtaining
+a copy of this software and associated documentation files (the
+"Software"), to deal in the Software without restriction, including
+without limitation the rights to use, copy, modify, merge, publish,
+distribute, sublicense, and/or sell copies of the Software, and to
+permit persons to whom the Software is furnished to do so, subject to
+the following conditions:
+
+The above copyright notice and this permission notice (including the
+next paragraph) shall be included in all copies or substantial
+portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
+LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
+WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+
diff --git a/debian/libevl-test.install b/debian/libevl-test.install
new file mode 100644
index 0000000..f835c51
--- /dev/null
+++ b/debian/libevl-test.install
@@ -0,0 +1,2 @@
+usr/libexec/evl/evl-test
+usr/libexec/evl/tests/*
diff --git a/debian/libevl.install b/debian/libevl.install
new file mode 100644
index 0000000..6014542
--- /dev/null
+++ b/debian/libevl.install
@@ -0,0 +1,11 @@
+usr/bin/evl
+usr/bin/oob-*
+usr/bin/latmus
+usr/include/*
+usr/lib/*/pkgconfig/evl.pc
+usr/lib/*/libevl.a
+usr/lib/*/libevl.so*
+usr/libexec/evl/evl-[!t]*
+usr/libexec/evl/*trace*
+usr/libexec/evl/kconf-checklist.evl
+debian/udev/90-libevl.rules usr/lib/udev/rules.d/
diff --git a/debian/libevl.postinst b/debian/libevl.postinst
new file mode 100644
index 0000000..346e3af
--- /dev/null
+++ b/debian/libevl.postinst
@@ -0,0 +1,50 @@
+#!/bin/sh
+# postinst script for libevl.
+#
+# See: dh_installdeb(1).
+
+set -e
+
+# Summary of how this script can be called:
+#        * <postinst> 'configure' <most-recently-configured-version>
+#        * <old-postinst> 'abort-upgrade' <new version>
+#        * <conflictor's-postinst> 'abort-remove' 'in-favour' <package>
+#          <new-version>
+#        * <postinst> 'abort-remove'
+#        * <deconfigured's-postinst> 'abort-deconfigure' 'in-favour'
+#          <failed-install-package> <version> 'removing'
+#          <conflicting-package> <version>
+# for details, see https://www.debian.org/doc/debian-policy/ or
+# the debian-policy package.
+
+trigger_udev() {
+    if ! which udevadm >/dev/null 2>&1 ; then
+        return 0;
+    fi
+    udevadm control --reload-rules || true
+    udevadm trigger || true
+}
+
+case "$1" in
+    configure)
+        if ! getent group evl >/dev/null; then
+            addgroup --quiet --system evl
+        fi
+        trigger_udev
+    ;;
+
+    abort-upgrade|abort-remove|abort-deconfigure)
+    ;;
+
+    *)
+        echo "postinst called with unknown argument '$1'" >&2
+        exit 1
+    ;;
+esac
+
+# dh_installdeb will replace this with shell code automatically
+# generated by other debhelper scripts.
+
+#DEBHELPER#
+
+exit 0
diff --git a/debian/libevl.postrm b/debian/libevl.postrm
new file mode 100644
index 0000000..dae5827
--- /dev/null
+++ b/debian/libevl.postrm
@@ -0,0 +1,41 @@
+#!/bin/sh
+# postrm script for libevl.
+#
+# See: dh_installdeb(1).
+
+set -e
+
+# Summary of how this script can be called:
+#        * <postrm> 'remove'
+#        * <postrm> 'purge'
+#        * <old-postrm> 'upgrade' <new-version>
+#        * <new-postrm> 'failed-upgrade' <old-version>
+#        * <new-postrm> 'abort-install'
+#        * <new-postrm> 'abort-install' <old-version>
+#        * <new-postrm> 'abort-upgrade' <old-version>
+#        * <disappearer's-postrm> 'disappear' <overwriter>
+#          <overwriter-version>
+# for details, see https://www.debian.org/doc/debian-policy/ or
+# the debian-policy package.
+
+
+case "$1" in
+    purge)
+        delgroup --quiet --system evl > /dev/null || true
+    ;;
+
+    remove|upgrade|failed-upgrade|abort-install|abort-upgrade|disappear)
+    ;;
+
+    *)
+        echo "postrm called with unknown argument '$1'" >&2
+        exit 1
+    ;;
+esac
+
+# dh_installdeb will replace this with shell code automatically
+# generated by other debhelper scripts.
+
+#DEBHELPER#
+
+exit 0
diff --git a/debian/rules b/debian/rules
new file mode 100755
index 0000000..7028f23
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,22 @@
+#!/usr/bin/make -f
+
+#export DH_VERBOSE = 1
+
+#Default: linux-evl is in same folder
+# Use UAPI=FULL_PATH dpkg-buildpackage ... to specify custom location
+#Not recommended to use /usr/include with debian packages due to:
+# - libevl installs most headers there except asm/evl
+# - linux-libc-dev installs all headers but conflicts with libevl
+#   due to some headers are installed at the same location
+UAPI ?= $(CURDIR)/../linux-evl
+
+ifeq ("$(wildcard $(UAPI))","")
+$(error UAPI not found in $(UAPI))
+endif
+
+%:
+	dh $@ --buildsystem=meson
+
+override_dh_auto_configure:
+	dh_auto_configure --buildsystem=meson -- -Duapi=$(UAPI)
+
diff --git a/debian/source/format b/debian/source/format
new file mode 100644
index 0000000..163aaf8
--- /dev/null
+++ b/debian/source/format
@@ -0,0 +1 @@
+3.0 (quilt)
diff --git a/debian/udev/90-libevl.rules b/debian/udev/90-libevl.rules
new file mode 100644
index 0000000..2615982
--- /dev/null
+++ b/debian/udev/90-libevl.rules
@@ -0,0 +1,12 @@
+# Xenomai4 EVL devices
+SUBSYSTEM=="evl", MODE="0660", GROUP="evl"
+KERNEL=="realtime", SUBSYSTEM=="clock", MODE="0660", GROUP="evl"
+KERNEL=="monotonic", SUBSYSTEM=="clock", MODE="0660", GROUP="evl"
+KERNEL=="monotonic_raw", SUBSYSTEM=="clock", MODE="0660", GROUP="evl"
+KERNEL=="clone", SUBSYSTEM=="monitor", MODE="0660", GROUP="evl"
+KERNEL=="clone", SUBSYSTEM=="observable", MODE="0660", GROUP="evl"
+KERNEL=="clone", SUBSYSTEM=="proxy", MODE="0660", GROUP="evl"
+KERNEL=="clone", SUBSYSTEM=="thread", MODE="0660", GROUP="evl"
+KERNEL=="clone", SUBSYSTEM=="xbuf", MODE="0660", GROUP="evl"
+KERNEL=="latmus", SUBSYSTEM=="latmus", MODE="0660", GROUP="evl"
+KERNEL=="hectic", SUBSYSTEM=="hectic", MODE="0660", GROUP="evl"
-- 
2.47.3

