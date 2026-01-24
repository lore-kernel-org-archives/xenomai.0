Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9E27FB34
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168841; cv=none; b=fNnR4tMKOK2Qws9NFaMiszGm1I/6/Ixko5KMm+J6rqZfDj1wp/VvOF6hLVOl6iHDdOueK/hf8zz6zxB/WAPBXJH35nie6RCDoZjP04lB3Ps3gTf1kUJtCy0ltGpRDhgFoBIO/yczxUP1nWXdhjay5sUu56a/RfOH0p5f7lfTT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168841; c=relaxed/simple;
	bh=6P7CjnhxH+rl248eqiCL2Xw60m6k3TOhrgartIoWcTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXBI3BzIM+ys0jJ9cvhTIJVOqT4xLWkRpvezwC+Ul0vS8jSl/B+i1Km6Crg6Y/2X+0EKHQozaQvj0Ih2wHYN6SGLJHqwet5iL06YPIbgQIjla23ZDiRg5SI80yy+At9gv9BPBIWRxkgZYouI3sIBd9oCPBD8UZLLupz+G9RmJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIPiioXP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIPiioXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769168840; x=1800704840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6P7CjnhxH+rl248eqiCL2Xw60m6k3TOhrgartIoWcTI=;
  b=TIPiioXPaiFoTU70jradnorq34z0pWBIB3lrPIea2xxRcziJpX7cBSIG
   jk0kvM1MnXxQgCaySzIJ8BRaVpPREZTheGSCCFNSO+ugole6lUHbfSjGU
   nY4M0aEu5DgVyoAwzRy74Y5X9jMqiHq70yicAAGOt6aYcJmO6gPhBNwtn
   gFeJfvjMpzK0WJ2AlaQIuiSkhWMRgZArC2sfP19dUBxSCgtHuEQmEqFMV
   m4NRgb3E2FEXjIRGw1c8HeNSHLLtLNCfbc+Sfne9SShJGsa940FmtBcBC
   aKEbpX8XR7F7BKwYfOKcA4GKxMjfsNGp96fS06XIAFEbgnhonATsttHCI
   g==;
X-CSE-ConnectionGUID: WSQwApDDS2G1qxzICdDkWA==
X-CSE-MsgGUID: TVMCY/U4SMuTwwq7VKyImA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69616603"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69616603"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:47:19 -0800
X-CSE-ConnectionGUID: MmrYPbkjTdqefp9gmyFfYQ==
X-CSE-MsgGUID: TCvvrf7/S4W4nSD1MXarZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207349761"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:47:18 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev
Cc: yuan1.wang@intel.com,
	junxiao.chang@intel.com
Subject: [PATCH libevl 1/2] tests: ptrace-sync: skip SOH and STX in pipe message
Date: Sat, 24 Jan 2026 19:42:31 +0800
Message-ID: <20260124114232.1186577-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes there might be SOH(Start of Heading) or STX(Start of
Text) in be beginning of message. It needs to be skipped, or else
regex function might return wrong result.

This issue could be reproduced with gdb 15.0.50 in ubuntu 24.04.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 tests/ptrace-sync.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/ptrace-sync.c b/tests/ptrace-sync.c
index ec6fbb3..68ce353 100644
--- a/tests/ptrace-sync.c
+++ b/tests/ptrace-sync.c
@@ -40,6 +40,8 @@
  */
 
 #define CONCURRENCY  2
+#define SOH          1
+#define STX          2
 
 static struct evl_sem handshake;
 static struct evl_event barrier;
@@ -153,6 +155,7 @@ static int consume_and_match(FILE *fp, const char *expect, bool verbose)
 	int ret = EXIT_FAILURE;
 	char buf[BUFSIZ], *p;
 	regex_t re;
+	size_t len;
 
 	if (verbose)
 		fprintf(stderr, "EXPECT {{ %s }}\n", expect);
@@ -166,8 +169,14 @@ static int consume_and_match(FILE *fp, const char *expect, bool verbose)
 		alarm(0);
 
 		if (p) {
+			len = strlen(p);
+			if (len > 1 && (p[0] == SOH || p[0] == STX)) {
+				/* Ignore SOH(start of header) or STX(start of Text */
+				p++;
+				len--;
+			}
 			if (verbose) {
-				fprintf(stderr, "<- {{ \"%.*s\" }}\n", (int)(strlen(p) - 1), p);
+				fprintf(stderr, "<- {{ \"%.*s\" }}\n", (int)(len - 1), p);
 				fflush(stderr);
 			}
 			if (!regexec(&re, p, 0, NULL, 0)) {
-- 
2.43.0

