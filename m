Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD4188735
	for <xenomai@lists.linux.dev>; Sun, 20 Jul 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021558; cv=none; b=XLg/EPxdLqk2t627iDsvXbsJh09ri4l3teWAzqaCK89F6M3IXqM5odM3meHygix6K5RYaQZuvzTVpS73tXx63JpCuIL3PTDC8axk6+Gmqa0ne6UVlYTG4PCjltWWhNt0MU50miWEGUQqkw7D2s5cFsLjQx4Vvwd98ntNd++wqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021558; c=relaxed/simple;
	bh=dFYY6e9O2ir/kOFHn3kqZUL5iOLGPchaQYqUxgfytfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+XHSSwaFpOS0HB8kawLyj/ObEquGOKvezIbKWz6u+TJM9SULvwnEQiUZMWRN0vVO1FrqQwEuJ17s2uTO4S27nLFHXASnOSrtUzRMEtizCbqqq+ANoO0LTHeBYo9eyUTkIYVzq3OUQtUZRVGarq185wKobZAYvAXrwdzc74dd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Evi4t+9B; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Evi4t+9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lO
	7BwKa8RdNgFdaGnVj8/6Vr9zIvcSdbrvrcQcw2Wxo=; b=Evi4t+9BTwyMZyUQiO
	UZ4mXTu/X8jOzPlNVQ2lSqguUtYMBizpsw9nMIeKsl8GNGM5TO9OJPZ6THOhEAWC
	79mJWmQT+4tn5eoix5bt0WWIACS+8PmJ+3dAitdgK2QpmAWO8LwyfUSZgp9vrvct
	zNxJP+DasndKT/b+UQ8EGU6gw=
Received: from wang-Xenomai.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnxwlq_Hxo57gpGA--.64780S2;
	Sun, 20 Jul 2025 22:25:46 +0800 (CST)
From: guang_feng_wang@163.com
To: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	wang <guangfeng.wang@siemens.com>
Subject: [PATCH] Replace obsolete AC_CANONICAL_SYSTEM macro
Date: Sun, 20 Jul 2025 22:25:42 +0800
Message-Id: <20250720142542.12859-1-guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnxwlq_Hxo57gpGA--.64780S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUWF17tr13Xr17JFyftFb_yoWDGFb_Gr
	yxCr1DArW8C3srC3Wj9rW7Jr1Dt34UCw4YgFWDK34UKry2vFs8Aws5GrnaqFs5W3Z0grW3
	ZFy0va4jkrn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDEf5UUUUU==
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/1tbiSB6QeWh89SlJjwACsz

From: wang <guangfeng.wang@siemens.com>

The macro `AC_CANONICAL_SYSTEM` is obsolete and triggers warnings
in modern autoconf.
This patch replaces it with the recommended macros to silence
these warnings.

Signed-off-by: wang <guangfeng.wang@siemens.com>
---
 config/ac_prog_cc_for_build.m4 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config/ac_prog_cc_for_build.m4 b/config/ac_prog_cc_for_build.m4
index 8cba24927..2c78c3f6b 100644
--- a/config/ac_prog_cc_for_build.m4
+++ b/config/ac_prog_cc_for_build.m4
@@ -5,7 +5,9 @@ AC_DEFUN([AC_PROG_CC_FOR_BUILD], [dnl
 AC_REQUIRE([AC_PROG_CC])dnl
 AC_REQUIRE([AC_PROG_CPP])dnl
 AC_REQUIRE([AC_EXEEXT])dnl
-AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
+AC_REQUIRE([AC_CANONICAL_BUILD])dnl
+AC_REQUIRE([AC_CANONICAL_HOST])dnl
+AC_REQUIRE([AC_CANONICAL_TARGET])dnl
 dnl
 pushdef([AC_TRY_COMPILER], [
 cat > conftest.$ac_ext << EOF
-- 
2.34.1

