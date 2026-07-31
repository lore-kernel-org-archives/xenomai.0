Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0429DB9A
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488627; cv=none; b=Apkml3JSOer6UWwhUnORsCCXpLTn5BTlClyHtsfFzWYzNzbSnW9VqnbDlWuMfwPLBmtZyHw88R342kV4D1HdI1upAlJorI77lAKn3Hl6mwH8RIp3rd0B9iKomk8WD/2At7DUIrLcgM5e58GonXrcb5v14oRj2wSK/Vz/brUZmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488627; c=relaxed/simple;
	bh=UtdaPRcXWKOqJFDg6apOLpEOh1TjxfdkHwBErIc2jEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jGhz3cw7Jbo1sJjS9HzU2DiDzXp1fYpsKhIe6InOXYYOodkTBwVXteaNyAfLuo5+syEWleokVhjIaUCZbagmWUDfekdyjlh/iaWpkHWAs6swcY3Sszef2lPRDuUAVsTOs8ebvwmwUqoRyxmDa+4v7wKYpnLzVr9TlpwYiYJyUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=gAzZlaWq; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="gAzZlaWq"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260731085326cb587df9ce000207ca
        for <xenomai@lists.linux.dev>;
        Fri, 31 Jul 2026 10:53:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Op+Ve589I8UyGH3F8SFkT7ogbibDEk5lWtV16n5qd50=;
 b=gAzZlaWqUh5quZj+PxIblqA9cHeECt21x+KF9vdJk74UPG0kjNe5gorYAfSeUGja7iULGH
 85/ENNPGl9IB0iPffy6aII1Aezo9DE/9nqmTbNxtxT/bCSJ++q0RfJzQn6LfClLzuRLPAp1R
 Dl51h8TEvy600twiwIa9tyKuPplqGHW16rXiCgJtJKUS7q/Hgpm7Boz2w0oaKHVeeKBzGtJv
 JIoX5TIpWAbYZdDKUQ6aVdEy0xzcrA+eOCLERO2roz0p6VZ0pQNzz7duiidFL4ZWDoEEFYbt
 Cd4wHYQgXZ6HbjR3TpNI7XhEjwyjLw/LbJamBJ4m581ngXkSRwn1AapA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2] debian: Replace SysV init script with native systemd unit
Date: Fri, 31 Jul 2026 10:53:16 +0200
Message-ID: <20260731085316.4122942-1-clara.kowalsky@siemens.com>
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

The systemd unit uses the script /usr/lib/xenomai/xenomai-group for GID
handling.
See #54.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 debian/libxenomai1.xenomai-group   | 26 +++++++++++++++++++++
 debian/libxenomai1.xenomai.init    | 36 ------------------------------
 debian/libxenomai1.xenomai.service | 12 ++++++++++
 debian/rules                       |  3 ++-
 4 files changed, 40 insertions(+), 37 deletions(-)
 create mode 100644 debian/libxenomai1.xenomai-group
 delete mode 100644 debian/libxenomai1.xenomai.init
 create mode 100644 debian/libxenomai1.xenomai.service

diff --git a/debian/libxenomai1.xenomai-group b/debian/libxenomai1.xenomai-group
new file mode 100644
index 000000000..ecb99ff20
--- /dev/null
+++ b/debian/libxenomai1.xenomai-group
@@ -0,0 +1,26 @@
+#!/bin/sh -e
+
+GROUP=xenomai
+FILENAME=/sys/module/xenomai/parameters/allowed_group
+GID=$(getent group "$GROUP" | cut -d: -f3)
+
+test -e "$FILENAME" || exit 0
+test -n "$GID" || exit 0
+
+case "$1" in
+  start)
+        echo "$GID" > "$FILENAME"
+        ;;
+  stop)
+        echo "-1" > "$FILENAME"
+        ;;
+  restart|force-reload)
+        "$0" start
+        ;;
+  *)
+        echo "Usage: $0 {start|stop|restart|force-reload}" >&2
+        exit 1
+        ;;
+esac
+
+exit 0
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
index 000000000..50ca3bcc1
--- /dev/null
+++ b/debian/libxenomai1.xenomai.service
@@ -0,0 +1,12 @@
+[Unit]
+Description=Set Xenomai group
+After=systemd-modules-load.service
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=/usr/lib/xenomai/xenomai-group start
+ExecStop=/usr/lib/xenomai/xenomai-group stop
+
+[Install]
+WantedBy=multi-user.target
diff --git a/debian/rules b/debian/rules
index 9e56de260..0ef5557fa 100755
--- a/debian/rules
+++ b/debian/rules
@@ -75,6 +75,7 @@ install: build
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done
 	install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf
+	install -D -m 755 debian/libxenomai1.xenomai-group $(CURDIR)/debian/libxenomai1/usr/lib/xenomai/xenomai-group
 	# remove empty directory
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
@@ -103,7 +104,7 @@ binary-indep: build install
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

