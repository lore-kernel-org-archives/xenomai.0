Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33917A2F0
	for <xenomai@lists.linux.dev>; Sat, 26 Apr 2025 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745635638; cv=none; b=UeKjmnHXwgw4Y1hWTHPNhh2H8I9d8oO0P3YsDFbdDn5xMk/wdwyyjHX0/2zRX35kHeJL8VSCYiZVX8MVxj6fRX4jlT9cav+jUyFZvmqm0SLuRHxxnOkFkixlGnDiDRDI+0ZY2jHtmAoxYXPGdSNf28Gq/c/el/c1VnLtr9BmQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745635638; c=relaxed/simple;
	bh=Gq58HiuhSGAMqtFaUeH4mHxJ3QLZxYqt/XGp/ENbKj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oR6RX4FM9L3dI8bDnJv6lTqG9qOgdcGACVA0dfRdpGlArSUY1pBQHFUB5qPNQeJ3wpB/Bixvpdc6suzQBKG375DbNaIIHgg1nNkTd8Tha2wufQYpzHEPG7pxVffKmhQe+NxlX2AE0bZB4U4W1uIGjkUVQ7sQn4YqXXikVt0MWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AyUfo+mD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AyUfo+mD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Swh99
	q7Kj+Gk7PH3T4A14JBYK2st+qQqvacnGNRVBro=; b=AyUfo+mDMdUdwofXxhsV9
	8aQ/oxoUtBpc7q1zkXW6vCnTJUP18LgQlWc7s5xQ4oiYYYGZZ77QQ3Ax4pAeXgyO
	oiwRYTp1lRZP54rfYD5SYLRyR8onEFVMtnUgGferZhzOa21oY9q21DxW29BBXkIu
	yvtpfU5ofw7ox2WnQXOOF4=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB38ictSQxoHK8kCg--.47215S2;
	Sat, 26 Apr 2025 10:47:10 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] Doc: Remove xenomai.cpufreq param from MIGRATION.adoc
Date: Sat, 26 Apr 2025 10:47:07 +0800
Message-Id: <20250426024707.2349986-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB38ictSQxoHK8kCg--.47215S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1kZryrWw18Zw4UAF4xJFb_yoW3Arc_ta
	n7Krs7W3y0yry5GFy8Kwn3GrW0vw18WF18Ar93K39Iya4DW34Fyr1UZF9xKayDu34IgFWa
	g3Wqqr1UCrZFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJuc_7UUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBw7cWgMPqXgRwAAsS

The Cobalt kernel does not provide support for xenomai.cpufreq.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 doc/asciidoc/MIGRATION.adoc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index 8dc7c7a13..6f6800754 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -75,7 +75,6 @@ System parameters renamed::
 
 * xeno_hal.supported_cpus -> xenomai.supported_cpus
 * xeno_hal.disable -> xenomai.state=disabled
-* xeno_hal.cpufreq -> xenomai.cpufreq
 * xeno_nucleus.watchdog_timeout -> xenomai.watchdog_timeout
 * xeno_nucleus.xenomai_gid -> xenomai.allowed_group
 * xeno_nucleus.sysheap_size -> xenomai.sysheap_size
-- 
2.34.1

