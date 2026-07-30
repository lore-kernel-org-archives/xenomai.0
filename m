Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03213442FC8
	for <xenomai@lists.linux.dev>; Thu, 30 Jul 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432519; cv=none; b=nsbw3WUCaqGsZd7DiZuanbgzLJet3fE8twMAtt2iOfq8Z5gTvAod6cYiMTJHPovm+UH5bR+mQtQDle1NKsvgAxLGNSb2wtCgFSh+Szwt4H2HMMSzd44ZVrRjK9wLPlH65Mxu3I5iOgL++UDLCpr8XC/ma/c+Ow1bjQbndjny8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432519; c=relaxed/simple;
	bh=EYBNb+vJGZoVYznpV/keUBTHdGA70okcxKlmoErpncU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bmt8NfGo3nREMuPZhSyji+u+m66yorhBmZVV1PyrUWJJqCnCrcGNuMAfbfIH4Ir6B2hD8alKmNAJh3/x12CQOx/Nl2R6fo6RlWehJD2l94nQpn878ck15EpUvlVqLnwwPeyR/h1H7tmiPqHBBTq3aYBNedung0jI9FH4R1DJJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=brgo1i1z; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="brgo1i1z"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260730154807c7c46b4772000207b9
        for <xenomai@lists.linux.dev>;
        Thu, 30 Jul 2026 17:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ruBK+n5SWG3pWC5F4R6X0LWXdyV6ApFmzja4yWedYSk=;
 b=brgo1i1zVXUzl89s50l5jqg7LGhI3s08misPb1bnnAdzxcK5dZX8Py03UPZjEW08qQESrG
 ORNbp6O+JzQrZlH6dXF8C6YDafGXWfRN5trqEJ0h5K1Z9A7oiXHXifAWrce+nua8n9lbYQeB
 +ncnY60xMmXNuDbOKvFzplCw6HjEnbJx+3L3b4zjY6XhQni+2TTbPx/zv/vOzqXMYirghhPu
 R807XeJ2WGjJgbcSO7h4HkJOETPn5+5Gjs5zAUg+vU8IGd44O/BSFUyD3rth7+wTDg2on8Q7
 zSax8k/8yvXF2dFuQVHwuMLQhu/okueNdEnL9EjrirDOS0vhsqwGTyJw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] debian: Replace SysV init script with native systemd unit
Date: Thu, 30 Jul 2026 17:47:48 +0200
Message-ID: <20260730154748.2343236-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Debian trixie warns when relying on the generated compatibility unit for
/etc/init.d/xenomai.

This addresses

systemd-sysv-generator[1423]: SysV service '/etc/init.d/xenomai' lacks a native systemd unit file, automatically generating a unit file for compatibility.
systemd-sysv-generator[1423]: Please update package to include a native systemd unit file.
systemd-sysv-generator[1423]: ⚠ This compatibility logic is deprecated, expect removal soon. ⚠

See #54.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 debian/libxenomai1.xenomai.init    | 36 ------------------------------
 debian/libxenomai1.xenomai.service | 13 +++++++++++
 debian/rules                       |  2 +-
 3 files changed, 14 insertions(+), 37 deletions(-)
 delete mode 100644 debian/libxenomai1.xenomai.init
 create mode 100644 debian/libxenomai1.xenomai.service

diff --git a/debian/libxenomai1.xenomai.init b/debian/libxenomai1.xenomai.init
deleted file mode 100644
index 811fe25fd..000000000
--- a/debian/libxenomai1.xenomai.init
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh -e
-### BEGIN INIT INFO
-# Provides:          xenomai
-# Required-Start:    mountkernfs
-# Required-Stop:
-# Default-Start:     2 3 4 5
-# Default-Stop:      0 1 6
-# Short-Description: Set Xenomai group
-### END INIT INFO
-
-GROUP=xenomai
-INITNAME=/etc/init.d/xenomai
-FILENAME=/sys/module/xenomai/parameters/allowed_group
-GID=$(getent group $GROUP | cut -d: -f3)
-
-test -e $FILENAME || exit 0
-test -n "$GID" || exit 0
-
-case "$1" in
-  start)
-        echo "$GID" > $FILENAME
-        ;;
-  stop)
-        echo "-1" > $FILENAME
-        ;;
-  restart|force-reload)
-        $0 start
-        ;;
-  *)
-        echo "Usage: $INITNAME {start|stop|restart|force-reload}"
-        exit 1
-        ;;
-esac
-
-exit 0
-
diff --git a/debian/libxenomai1.xenomai.service b/debian/libxenomai1.xenomai.service
new file mode 100644
index 000000000..4494dc00c
--- /dev/null
+++ b/debian/libxenomai1.xenomai.service
@@ -0,0 +1,13 @@
+[Unit]
+Description=Set Xenomai group
+ConditionPathExists=/sys/module/xenomai/parameters/allowed_group
+After=systemd-modules-load.service
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=/bin/sh -ec 'gid=$(/usr/bin/getent group xenomai | /usr/bin/cut -d: -f3); [ -n "$gid" ] && echo "$gid" > /sys/module/xenomai/parameters/allowed_group || true'
+ExecStop=/bin/sh -ec 'echo -1 > /sys/module/xenomai/parameters/allowed_group || true'
+
+[Install]
+WantedBy=multi-user.target
diff --git a/debian/rules b/debian/rules
index 9e56de260..dd52cbaf0 100755
--- a/debian/rules
+++ b/debian/rules
@@ -103,7 +103,7 @@ binary-indep: build install
 binary-arch: build install
 	dh_testdir -a
 	dh_testroot -a
-	dh_installinit -a --name=xenomai
+	dh_installsystemd -a --name=xenomai
 	dh_installman -a
 	dh_installdocs -a -A README
 	dh_link -a
-- 
2.54.0

