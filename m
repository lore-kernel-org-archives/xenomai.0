Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286828137A
	for <xenomai@lists.linux.dev>; Tue,  6 May 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540293; cv=none; b=c09gk4DuAUg9B+PtqaOiRnMs/fS6+Md+2OZ/QCTV/MpAQ/N38moVWNJxjyw24lpwb7aZlyyZgQ2XfuH7PBhngdp38aT23k8AWSyFyrKOnbH5b/PKe1o2NXodyK0Eiq+7OAz0Apk17+iTURlxiscrRoFmOa9izq5O5z+EeYpJqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540293; c=relaxed/simple;
	bh=nyonj22VH5tYk3AhiBmRDG4VluKqolZWHdN97W5Z5PA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKkgPuLq3Bz1tOfv0HONB5qdH4w+w94vmDNiZ2Xay+q44Xp0GwCD8WVNnLEc+5VgQNZLVmXDqWm1a6HRs6J3qC1RYIdhYRHkKk1QB6OMs9gKZmLeu9aZKgTODuK45H9Io/t04fSh0AJsjtuVIt35yMfP9Gd4ysyu5jJZOw/FMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QoerpbRM; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QoerpbRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5auyx
	UrGQb2AftxG4LF3mZYXdnP/gB00f+hjfwrlOzw=; b=QoerpbRMREHvrPOTHFS7o
	tBme8yIhplM2g/8BMUtbvO2xNRkYoNIt5czxnuhoL3cRhoW/qz0YBbAXbr0eEaYx
	L+44wwMyEv+hyzelQv8GAFuew9Xqpj4DYNLe+FTUDErMOAlL0TdiBAsg3XFl423g
	cJdMZvgBSHkkeQFZ79dbNg=
Received: from u2204.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnhQ79FhpoUTIxCA--.33688S2;
	Tue, 06 May 2025 22:04:46 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] Doc: Add fallback path for asciidoc-icons to fix install error
Date: Tue,  6 May 2025 22:04:43 +0800
Message-Id: <20250506140443.2492075-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnhQ79FhpoUTIxCA--.33688S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxKw1DWFWfWF1fZr18Krg_yoW8ZFWxpw
	4qyws0yFZ5Xwn0gr1vgFW09r1YvFyUW34Yqwn8J345try5tr18Xa1xtrWI9F1xAFs8Gayx
	AanFga42yr18taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUj388UUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXABFcWgaFR0gCgABs5

By adding an additional check for the existence of the
/usr/share/asciidoc/icons/ directory in the Makefile.am file, this
patch improves compatibility across different environments and
fix an install error due to missing icon files.

Symptom when running make install:
cp: cannot stat '/etc/asciidoc/images/icons/': No such file or directory
make[2]: *** [Makefile:629: html/asciidoc-icons] Error 1
make[2]: Leaving directory '/root/xenomai-upstream/xenomai/doc/asciidoc'
make[1]: *** [Makefile:421: install-recursive] Error 1
make[1]: Leaving directory '/root/xenomai-upstream/xenomai/doc'
make: *** [Makefile:472: install-recursive] Error 1

Environment:
$ dpkg -S /usr/share/asciidoc/icons/
asciidoc-common: /usr/share/asciidoc/icons

$ apt show asciidoc-common
Package: asciidoc-common
Version: 10.1.2-1

$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.1 LTS"

Configure:
$ ./configure \
CFLAGS="-march=armv8-a" \
LDFLAGS="-march=armv8-a" \
--build=i686-pc-linux-gnu \
--host=aarch64-linux-gnu \
--enable-smp \
--with-core=cobalt \
--enable-doc-build \
CC=aarch64-linux-gnu-gcc \
LD=aarch64-linux-gnu-ld

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 doc/asciidoc/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
index 2bacb7c10..782c7a23f 100644
--- a/doc/asciidoc/Makefile.am
+++ b/doc/asciidoc/Makefile.am
@@ -112,6 +112,8 @@ html/asciidoc-icons:
 		cp -a /usr/share/doc/asciidoc/images/icons/ html/asciidoc-icons; \
 	elif test -d /usr/share/asciidoc/images/icons/; then \
 		cp -a /usr/share/asciidoc/images/icons/ html/asciidoc-icons; \
+	elif test -d /usr/share/asciidoc/icons/; then \
+		cp -a /usr/share/asciidoc/icons/ html/asciidoc-icons; \
 	else \
 		cp -a /etc/asciidoc/images/icons/ html/asciidoc-icons; \
 	fi
-- 
2.34.1

