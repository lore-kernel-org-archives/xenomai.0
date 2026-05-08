Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C035F60B
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221388; cv=none; b=ldwJ/abcd3rLkGb2vUux/VufCQ5O3fHht5eMOI4eyjKtoRMKJ2RZEUqUmQVMN14eWwQjtizrJb4lYs7JpA5cphAnfrBtjK9Q4w2DPWONzYbU8H8yekvt+cINpAHYAdEzVCRYMa0Y0I2U+7JdhKV8DjHi5tzm2Fm4STq3LDVD/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221388; c=relaxed/simple;
	bh=036CMW2GMP8DJPHM6nV8eZl1GV4Tqirmnu16wj1ehj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Apoo3F+IKYmfY/ZHwKiRbJH9kokaA5wYixTzr8cglliFa2JqXpdpmgTj2NS25pIPuy7gLiqFFooiey0ep/DBhT5sILwOOjeGTRGW07Xz+MVXCm9QgUo40rEfU98USffyAh79i4/G6br4HqLvrWvXE17gS2IuLZ1uHxw5kRSyoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mjHIok/t; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mjHIok/t"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062259c77da7458d0002074d
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3Zu1Z+VYvLLX4bc0f5EAtXkEWCM6+cwAVle/PuP9ugk=;
 b=mjHIok/tTWbvwIyYu19j3QfZY34l1jxvaCk3V2lOqMPO3TOWGRcMeCpmPwz4KaZySIzcxZ
 CC9pmhlR4PxD/IjXH62T+Ikk8bTvD8FylpuHQnH5aeG2FQxvFYQGDfUNl+wYq/+rhdIONGQg
 RL2GpTsWdXYflLbKw56a8DgT0EuuIQyajWjNdl63ARrfRGzAAWqyIkECQmh6J0EWXnHoWILU
 eRBPcqzeFunP6Rt4c+aKKzKsgUSIlqv0ZyHA8jc0E6sgHfhDyp6bSbBiR/Bxr5vBAvDJcoW6
 e0VsLbtYLwwz+JmJPjapcL4mdYYVFD8qQ1wMYg8knjGfzfC91vFAVirA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:51 +0200
Subject: [PATCH 18/32] testsuite/smokey/net_common: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-18-e449f2bd4fc2@siemens.com>
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
 testsuite/smokey/net_common/client.c            |  9 ---------
 testsuite/smokey/net_common/server.c            | 17 ++---------------
 testsuite/smokey/net_common/setup.c             | 23 +++++++----------------
 testsuite/smokey/net_common/smokey_net_server.c | 21 +++++++++------------
 4 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/testsuite/smokey/net_common/client.c b/testsuite/smokey/net_common/client.c
index 914bda4a49f93f2c8aac7aa2fdd5816d804f8f31..751c819d0503209590fd1d9b28a7d89f8c54df9e 100644
--- a/testsuite/smokey/net_common/client.c
+++ b/testsuite/smokey/net_common/client.c
@@ -1,12 +1,3 @@
-#include <stdio.h>
-#include <stdbool.h>
-
-#include <unistd.h>
-#include <pthread.h>
-#include <sched.h>
-#include <sys/socket.h>
-#include <sys/select.h>
-
 #include "smokey_net.h"
 
 static int duration = 10;
diff --git a/testsuite/smokey/net_common/server.c b/testsuite/smokey/net_common/server.c
index 42edb0f42716a51bce8dca776caa095a9256a915..2110a774b6bfac99c67dd6a0836147004095fe40 100644
--- a/testsuite/smokey/net_common/server.c
+++ b/testsuite/smokey/net_common/server.c
@@ -6,24 +6,11 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-
-#include <unistd.h>
-#include <pthread.h>
-#include <sched.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <netpacket/packet.h>
-#include <net/ethernet.h>
-
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
 #include "smokey_net.h"
 #include "smokey_net_server.h"
 
+#include <stdlib.h>
+
 struct smokey_server {
 	sem_t sync;
 	int fds[0];
diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index 8a3562ba9630ba73b3b9c96da4b8b7d0e8b6bd18..a06265afb1e384d60a31df92962baaec6dd63919 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -4,25 +4,16 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <errno.h>
+#include "smokey_net.h"
+#include "smokey_net_server.h"
+
+#include <rtcfg_chrdev.h>
 
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
 #include <arpa/inet.h>
+#include <fcntl.h>
 #include <netinet/ether.h>
-#include <netpacket/packet.h>
-
-#include <sys/cobalt.h>
-#include <smokey/smokey.h>
-
-#include <rtnet_chrdev.h>
-#include <rtcfg_chrdev.h>
-#include "smokey_net.h"
-#include "smokey_net_server.h"
+#include <sys/ioctl.h>
+#include <unistd.h>
 
 
 struct module {
diff --git a/testsuite/smokey/net_common/smokey_net_server.c b/testsuite/smokey/net_common/smokey_net_server.c
index 5a94126031e5390eed65ad9c33e1292a4530abde..ab3799f552d87cd3cc3fa76f1060bfea70717adb 100644
--- a/testsuite/smokey/net_common/smokey_net_server.c
+++ b/testsuite/smokey/net_common/smokey_net_server.c
@@ -6,21 +6,18 @@
  * SPDX-License-Identifier: MIT
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-
-#include <unistd.h>
-#include <getopt.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <netinet/ether.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+#include "smokey_net_server.h"
 
 #include <rtcfg_chrdev.h>
-#include <sys/cobalt.h>
 #include <smokey/smokey.h>
-#include "smokey_net_server.h"
+
+#include <arpa/inet.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <netinet/ether.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
 
 static const char *intf = "rteth0";
 

-- 
2.54.0

