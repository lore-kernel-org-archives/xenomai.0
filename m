Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F732C187
	for <xenomai@lists.linux.dev>; Sat, 26 Apr 2025 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633723; cv=none; b=s4Zd/Ods5mQMoSrUdfDtZwlDzoqae13OaVw2EDDsaVR8BaxM6b3qmQPN45B2l+RMJ3/aT+NP5HAOEVUBcoeoUi2JEzTsfJXHVgqA1IDntmNrmCLj7wWX/CIF6J3pT7amz2PXWhlBB4VBDipUS1eewpVzaJsFMD/2/IioHl9pbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633723; c=relaxed/simple;
	bh=0EMN960+Xoq1L8/xEnZILQyiC1GKgWlfC3nAF9bRIUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egCtg8kW0IMt+6jV4sQ+EFNJ/OHPpmNpOpbuRPjav2AVkUmpZ2j4Vj6EVJYjgPkFCIOL+Qoqedi2Qi94dNS5MKejeeie9d/P/7RUWs6FWi01CJKEIpG0DGo5seVGOtpVy4bUHvZLh8dOOqD6poyGATC8GDIZkDIntVykuVfgfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cbmUh492; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cbmUh492"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gUHG+
	2ebhEmdL71wTB+ALIlXKrGuwJ/mQDEmrlSmUPU=; b=cbmUh492TlwAICa+LM8r6
	W6K3VCkgxhgzB8Wzk1YARtuMl1G2gMaPL33IfY47D9NbYa8zfrhbMHcGWWYUDoGN
	9Tk6W6pZynvr2qsQPtTi9elrM95SedNvmXGL2a5jLTx56W0R7mnh1SmAUPHKjPsf
	LqpSvnittqnwdkdgk+gtVw=
Received: from u2204.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXW5iyQQxomABwAw--.65225S2;
	Sat, 26 Apr 2025 10:15:16 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] Doc: Add watchdog_timeout param for Cobalt kernel
Date: Sat, 26 Apr 2025 10:15:11 +0800
Message-Id: <20250426021511.2349657-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXW5iyQQxomABwAw--.65225S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1DCr13Gw1UurWkGF1rZwb_yoWkZrgEk3
	Z5Kwn2qw4UKryfWFWrtr4fZryS9Fykur18Xw4rKrWjyr9rtw4Yq390q3ZxuF13u39rZF15
	ZayqqF17Gr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGjgx7UUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwI7cWgMQOoPpwAAsN

Add table entry for the xenomai.watchdog_timeout parameter, defined in
kernel/cobalt/sched.c.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 doc/asciidoc/README.INSTALL.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index 508e9b43d..b74079dc2 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -144,6 +144,12 @@ documentation about the
 link:../man1/corectl/index.html[corectl(1)]
 utility for a description of these states. | enabled
 
+|xenomai.watchdog_timeout=<seconds> | Watchdog timeout value in seconds.
+Requires CONFIG_XENO_OPT_WATCHDOG to be enabled in kernel configuration.
+This option activates a watchdog aimed at detecting runaway Cobalt threads.
+Timeout value can be set via CONFIG_XENO_OPT_WATCHDOG_TIMEOUT, with a range
+from 1 to 60. | 4
+
 |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
 workaround. The possible values are _disabled_, _detect_ and
 _enabled_. See the discussion about link:dealing-with-x86-SMI[SMIs]
-- 
2.34.1

