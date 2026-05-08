Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED05378D8B
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221403; cv=none; b=I6KmQKU+MLMyFGEMEDHGWWPT87vzBvbfxLumH0u2PkmGUX9gUz+X+pJ9bjlqr/MByFgth5LFJQiewSalIEpnEOdnSQ7pwBDedI/B0E2TUy7onVdnnpcywLInC6z1dseEoWbmnpbrHUSVx5OTStb0tJyuhkRMcDgmb947hl+QadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221403; c=relaxed/simple;
	bh=A704rA1Kg01bvGe9Znmbsi5nxRIxv04I+HyuGSswHPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwlKuZ+KVwXIr1RsJWtSaTLDDSHPTd0oNnDO5SbOsC0ZuJ6kJC0IuAfYpg7sCB3xq0/F5jqkYPIaR9xiDfMYWYmSa7OxfLYLr90BjrWSdRmjAawRxTYDs+wM1sNQy+CCHOmJw3w3g+t1n3ybuu3yBL+VEjf+R4JstMXu5VYnHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Nwy7MhIn; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Nwy7MhIn"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260508062305ff04323691000207ed
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n3ly3C2cZ+RcPLWyc0tPJCcDe2BKlIi5GFi/bQVGi+8=;
 b=Nwy7MhInbgc7Fd8H9qEDu3BicXEXoy71SjkAXkY0zLcb9ozSo8gN56sLwOSEuzfMUnKOPb
 Ol+B+9KLeGzCj2qe7UNibWh9529n8wp3HnQg2YdCF+CMfzaipUfPqdNQmi/c+BkVhrfPkHrR
 CmB7YBvWHCOxToxdVU+euZ0WyO06+EOc8Hhzxvopds2wytReEgQ+hMkHMZ543OqRsa2bwGW3
 CvKbTO9csPS7ybWvSb4F9JXJbeOYr7wmmJGHUWzDUoTXZ+e6QBYKsXTQW6veLJJFpCA68560
 KlhhQVcwWVvw9wwOqSrizAqBOkmVRlsjAyEKyEDSEvTJ2JXE5x1aUSeA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:03 +0200
Subject: [PATCH 30/32] utils/net: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-30-e449f2bd4fc2@siemens.com>
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
 utils/net/nomaccfg.c   |  8 +++-----
 utils/net/rtcfg.c      | 17 ++++++-----------
 utils/net/rtifconfig.c | 17 +++++++----------
 utils/net/rtiwconfig.c | 12 ++++--------
 utils/net/rtping.c     | 16 ++++++----------
 utils/net/rtroute.c    | 13 +++++--------
 utils/net/tdmacfg.c    |  9 +++------
 7 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/utils/net/nomaccfg.c b/utils/net/nomaccfg.c
index f0b5dafde6dcef2b8d9f3494415b1a7d38acd79f..97a1c657c53194742ede378ab6fbc32d488bc2cd 100644
--- a/utils/net/nomaccfg.c
+++ b/utils/net/nomaccfg.c
@@ -23,16 +23,14 @@
  *
  */
 
+#include <nomac_chrdev.h>
+
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <sys/ioctl.h>
 
-#include <nomac_chrdev.h>
-
-
 static int                     f;
 static struct nomac_config     nomac_cfg;
 
diff --git a/utils/net/rtcfg.c b/utils/net/rtcfg.c
index e68bf8786cc2c1c688a3dc486674f1e66a0d52bf..4f05a2a23b7e81c5afbfa780c5f853d021317296 100644
--- a/utils/net/rtcfg.c
+++ b/utils/net/rtcfg.c
@@ -22,24 +22,19 @@
  *
  */
 
+#include <rtcfg_chrdev.h>
+
+#include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <netinet/ether.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <net/if.h>
-#include <netinet/in.h>
-#include <netinet/ether.h>
-#include <arpa/inet.h>
-
-#include <rtcfg_chrdev.h>
-
+#include <sys/stat.h>
+#include <unistd.h>
 
 #define DFLT_PACKET_SIZE        1500 /* Ethernet packet */
 #define DFLT_CLIENT_BURST_RATE  4
diff --git a/utils/net/rtifconfig.c b/utils/net/rtifconfig.c
index 9a9abfc4c9b5ec2817acd0844872d1ec07ea1300..84e127215b752f805cb5fc56de5fd65503f4c934 100644
--- a/utils/net/rtifconfig.c
+++ b/utils/net/rtifconfig.c
@@ -23,20 +23,17 @@
  *
  */
 
+#include <rtnet_chrdev.h>
+
+#include <arpa/inet.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <netinet/ether.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <ctype.h>
-#include <fcntl.h>
 #include <sys/ioctl.h>
-#include <net/ethernet.h>
-#include <net/if_arp.h>
-#include <netinet/ether.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-#include <rtnet_chrdev.h>
 
 /* Some old toolchains don't ARPHRD_IEEE1394 defined */
 #ifndef ARPHRD_IEEE1394
diff --git a/utils/net/rtiwconfig.c b/utils/net/rtiwconfig.c
index eecb2939b1c27f8d1a807f8c29344851d031fa0a..2d4dd2a20fc755aa0fd40b32059c6a588e56801a 100644
--- a/utils/net/rtiwconfig.c
+++ b/utils/net/rtiwconfig.c
@@ -1,15 +1,11 @@
+#include <rtwlan_io.h>
+
+#include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <sys/ioctl.h>
-#include <net/ethernet.h>
-#include <net/if_arp.h>
-#include <netinet/ether.h>
-#include <netinet/in.h>
-
-#include <rtwlan_io.h>
 
 #define PRINT_FLAG_ALL          1
 #define PRINT_FLAG_INACTIVE     2
diff --git a/utils/net/rtping.c b/utils/net/rtping.c
index bdaf6cb15a3e8b981877bcf3884851a3c315e083..fd3e66e6a7c2f5f1745da97e66fa4f878f8156c8 100644
--- a/utils/net/rtping.c
+++ b/utils/net/rtping.c
@@ -22,22 +22,18 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include <ipv4_chrdev.h>
+
+#include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-#include <ipv4_chrdev.h>
-
+#include <unistd.h>
 
 int             f;
 struct ipv4_cmd cmd;
diff --git a/utils/net/rtroute.c b/utils/net/rtroute.c
index ef6b56ecf023d2c6733dd8caf476f21bbf4103ed..a8eecf3a0b04ac85aa6dcdedc36ea24a48a74896 100644
--- a/utils/net/rtroute.c
+++ b/utils/net/rtroute.c
@@ -22,20 +22,17 @@
  *
  */
 
+#include <ipv4_chrdev.h>
+
+#include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <netinet/ether.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 #include <sys/ioctl.h>
-#include <sys/stat.h>
-#include <netinet/in.h>
-#include <netinet/ether.h>
-#include <arpa/inet.h>
-
-#include <ipv4_chrdev.h>
-
+#include <unistd.h>
 
 int             f;
 struct ipv4_cmd cmd;
diff --git a/utils/net/tdmacfg.c b/utils/net/tdmacfg.c
index b1937b37feb8fb3bbadbefebdf459266e93a7b15..053b07b7e980a12c47b1bb99e22597c4ce534e28 100644
--- a/utils/net/tdmacfg.c
+++ b/utils/net/tdmacfg.c
@@ -23,18 +23,15 @@
  *
  */
 
-#include <errno.h>
+#include <tdma_chrdev.h>
+
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
-#include <arpa/inet.h>
-
-#include <tdma_chrdev.h>
-
+#include <unistd.h>
 
 static int                  f;
 static struct tdma_config   tdma_cfg;

-- 
2.54.0

