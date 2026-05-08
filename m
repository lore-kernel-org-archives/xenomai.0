Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF229374E45
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221398; cv=none; b=bsv7c4s2rB1ssqzVt9ryefXutqoNIATHObV4oOCSLNufI0VAWK27eizOsQfuLsAXhzRrS5ltZIH2qyOnnKz0PJU2DT7kxejPkykb/x75dcFFGv+3VjRyJA+b2mUnFz8TT1IGWbTEm3I/3s+6CEliHHc8C+M7Pz9RkdgmBLBiOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221398; c=relaxed/simple;
	bh=jX0xgqKO7zXWnlwqDPiVSSM8oCbpTTIaClSP44b5hHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD/KTijyfckyGUtzzmADhThrYgGMzAkdvjkrQzlMWH8xd8j3KkA13KG2Gmcpl1g4p1Irq7PR02Ew+xiJU2e5ObI8wr8lRlrhZfOPpPvTw8UfhJDMRcAxVPj3MEreLavnHaaremkgnc1K0ZqxO+i0kJpHHHKgd/VcLbvrlRSK2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PEZf/rEA; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PEZf/rEA"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260508062302aea5f8921d00020740
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VXnMHZXDOn3WGN7r7oU+To6xWKbE5oPdacbkEE7T07Y=;
 b=PEZf/rEA1+hEhpUboEY7v9xHLfxHoGvXWjFGG8PhF3dOnHBBzPeFC9MwR4KeaXjKCOrSfu
 Xh1+f74fWtGlHuIr+XooMYjfDg5Jk8vC13e0oBOwJCAU3thjMnUQzb+2+Rv4L6+/3Xd2s61a
 +EbLwZGH/n/C4z675MGP2Rt3vnPS6pCpsr62EZM7F+Ww1o1xkYnd4tb7MJ1yPXfAri1COxBD
 KT3DGNABq6VRsYX4eVTxdYhqWTS2TvFNJG0pJ7StB83A6eZcIT/XEj7S3P1v3rqwR3r9uxUf
 Cq+HIlE5lj2EOYDHCW7aA07BOjsw5IjxfkgEwBPJ6F9G21pdNfVCoKmA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:57 +0200
Subject: [PATCH 24/32] testsuite/xeno-test: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-24-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/xeno-test/xeno-test-run.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/testsuite/xeno-test/xeno-test-run.c b/testsuite/xeno-test/xeno-test-run.c
index 6d1bb96c0c4bb90a4d2fbc47b9c58a71db2e494c..1ec2674a469e0a5a34d2712ac10c9b7e46534aa4 100644
--- a/testsuite/xeno-test/xeno-test-run.c
+++ b/testsuite/xeno-test/xeno-test-run.c
@@ -1,17 +1,13 @@
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <ctype.h>
-
-#include <sys/types.h>
-#include <fcntl.h>
 #include <sys/stat.h>
-#include <unistd.h>
-#include <signal.h>
 #include <sys/wait.h>
-#include <sys/select.h>
 #include <time.h>
+#include <unistd.h>
 
 #define CHILD_SCRIPT  0
 #define CHILD_CHECKED 1

-- 
2.54.0

