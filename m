Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8043491D6
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131364; cv=none; b=KrZi1Hq1pN+kMgsVJDaOPEpklFmPyitGV7dUHGLQ2bujtZ3VVZTjzZzSFVy6+lwST/ky/zn1wL/aRTaczwvmU/NpDiC1DIfDXzm7FWvhJuw5cY8MEcQQ+0bf3nDrQUNn1IiaU917t/vmK4AJYMjNd7jc3NGRYUazDCCWxY7vtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131364; c=relaxed/simple;
	bh=fO8vSFP8pVeet+3SB9fadiya4vVQ+LC1fmXxtWjlbjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYrbBUGv8dzw7FR6i1m7DAc2CzSWmp3ir7Ue036DcUXI3v8taz140rNBNOggdVPoa8lbnvGzGY868Vw84K/lCUTD/ntyzIp4omPNMn8CrG0vz6L8NMQ765049clsV72r26lCLybuk7oanM5x5M1PAstRDpsjj9ud2VD7VaYSmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/YRC9P1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/YRC9P1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44136f7a169so738131f8f.3
        for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777131361; x=1777736161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiEnrn6T7VfECyRj7r9c9OeQwq26mNvUklnmePZH9Cs=;
        b=K/YRC9P1QvlCJWsvJBe0MZqvt0CuI3EbwnvYW2OmxjeaNlrjgLHvs98suIBOfd22oa
         Q2kPYQy4ukJisAcbU9bbkz5uabXpGKYuCIgAVdBaSpHx8uPjSxaUZ+PYs45eMtOf0u4q
         bw7g6fk2/dRvV1s3WzIutTmD8AMw6CGEfGpONDpqmi/e7OeXOx8e6aJJ2hyrH74BC3B6
         qo34hrO3d80FKn3dlOp2l/S1hbDObMOD7ph/EfQ2YV7JxUh6O1ZZTpvbjf6bhY05bPkF
         c10rY8+a0IVDrHR6gDJFb0stPy/TITSOWBrcq2h0Dwo4hs5n2/fPLGqHyN9AadWcfmp8
         yA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777131361; x=1777736161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiEnrn6T7VfECyRj7r9c9OeQwq26mNvUklnmePZH9Cs=;
        b=WGzr4QlAmh3m+Ge/UCsURAIqawqD00AAZdS5f2EesDFCAUH7oVtHrek7sFT4mc5253
         8MZu9+0rimcaDBYeBOgWG6KOgiUnyfdvyJr0ga7vDDZbQq5yAcBV2W5W4xQRWtYFiMHn
         veX7Kch2881UXMWI/AdXQKSy+tEVhn5g/3diWoTURa5Iy1uWw9KlJyNrwtxsQBqnMCvc
         nB1s90DhwMV+g3EsQ0aDc3M4VIIch5HioDmbUDbNJUEHGSSy7ZGTbkB641zahB/r23vD
         y2KnKZwyv7IyuRq5kxiLD+OA2+HafHh7ZTYATYNL1M3/1SdAGOj1uKw71W/BKJnObr64
         ffuQ==
X-Gm-Message-State: AOJu0Yz6Wy5fQbvcaYWYMeE+l30vymxtuVdAmoItQ+OjyCBsB7jPforb
	CMnvIa6+P5+pK7RTQwvNRlzmOTpopP3l4z0StnC8vANfy1nbkRJ10fY/xl3ENbs8
X-Gm-Gg: AeBDievh/BftV6u/5TtIv8FrBq38lBPI86kI48lSYaXIotaT98V5rBhSwARQtvmEss0
	QcTu3Uibf/Ii0q2yyT4R0pBvRRUapXK/9sJTdNU2u00kbdXgvVSi8JzzDLOXLldO452E0IKol4g
	qqYkJvjhgdcTe0PkNGXe5yqLrofwC1dAJHnXQrXG1QbTYGf9cPEZ6uCcnZjKX8PuHVNqqUu/GFg
	pYjwK63Z5OZkW8+sOF10jT98JFvvO1EN0fwMloKNqIVKhw0zydjXZAmgDC00gncC5R3qHNRH8o0
	o9B87geFw0t8U53cPzKr5Cwm7Zylncaj4oSvXlB9DZi4Bzk4IIyxqa+FEbk3sWbUu7W7MKOB6d3
	HLS4ePrYsQPu3/JV0ax0bS7/zKbUT08FeX0Q7G/fvQYbcH3bp44GykvNjTqtf/c4PqATc76hEJX
	zrZ5Y8irTJZl4YKCs2/vruQeiiM485aUUULAXh
X-Received: by 2002:a05:6000:2303:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-43fe3dcb1e9mr56180694f8f.16.1777131360840;
        Sat, 25 Apr 2026 08:36:00 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a166sm66567273f8f.19.2026.04.25.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:35:59 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] debian: Add rtnet.conf / tdma.conf to package
Date: Sat, 25 Apr 2026 17:35:23 +0200
Message-ID: <20260425153523.4935-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two config files rtnet.conf / tdma.conf where missing in the Debian
package and --sysconfdir=/etc was missing in rules.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 debian/rules                   | 1 +
 debian/xenomai-runtime.install | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/debian/rules b/debian/rules
index 225c743c5..9e56de260 100755
--- a/debian/rules
+++ b/debian/rules
@@ -15,6 +15,7 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
 
 CONFIG_OPTS = --prefix=/usr \
             --includedir=/usr/include/xenomai \
+            --sysconfdir=/etc \
             --mandir=/usr/share/man \
             --with-testdir=/usr/lib/xenomai/testsuite \
             --enable-lazy-setsched \
diff --git a/debian/xenomai-runtime.install b/debian/xenomai-runtime.install
index 77a4c445a..a9effa984 100644
--- a/debian/xenomai-runtime.install
+++ b/debian/xenomai-runtime.install
@@ -5,3 +5,5 @@ usr/bin/wf_generate
 usr/bin/wrap-link.sh
 usr/bin/xeno
 usr/sbin
+etc/rtnet.conf
+etc/tdma.conf
-- 
2.47.3

