Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A535DA6F
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221404; cv=none; b=CLgzF/db3hkq0/zTrRAPr2RJc63DoCADmYxuiGnhkltwflX4z7C9S1Hm7JjXM709/8wMqHXZ2l/lo0jYfj3uhGULPYKn3LI14dptvDklcg3xhzBH/b9f5j9OqTupXkwB2LPekTUUPqz7+fpTpm+qgd62klVBMpH/tXRjYAKBzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221404; c=relaxed/simple;
	bh=g1VJIErWAsceGF6pYKRsggYI13xayEqj85/uxBHZRI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFYN8tAwhhq9Q1pv1qfDZJcZ2diCsUh1PwR9PosrRJRAYl1+j2VYF7OGx1wtu93D2RANXKgdSRoEsZnsRp7BVBChL8R/LHQVDYsdRCVhzVd2M1M9UYi1udhwYHJYSiBzC7DHhE3LDu5XvVnfRw5zXm6sO+x0Gc70FfeB0Uw2VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dNRmVLi2; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dNRmVLi2"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026050806230388ee2c100f00020760
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Nwe6KrpSe3W8LgK6nHMJl7HiKq86oin6YmKbjVhQdos=;
 b=dNRmVLi2+abyC52DRl5Ey2nx8RIqg4YVyZVn82t7DIwKaFflUmjrsV+W8nVoe9InF563eV
 A5mJyJCk/QFQWWcGo0DHzYtatKekNYcyAfEzA4Qj1ASLLm+0AxHuWiQHTDr4gwVA4N+2Tj45
 kangZGtTD7PqT2zBQuHYbPRiU+XI0j0Y4P5yoIDAVtZeH00wPbj1fkW6P98t8vo+A/bMdAP4
 IV/ZDUBBdPR7CHhx9byEH1AyVBoqkGS0lSOTmiGrDGoafjsZWYAZJiOAjbyvLzLOz7z/MvnL
 AhyyXXuzl9KJ8rgAPjS09gfw/5FUEPB825Zurme5NyPN0Pt0/DidtZTw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:59 +0200
Subject: [PATCH 26/32] demo/posix/cobalt: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-26-e449f2bd4fc2@siemens.com>
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
 demo/posix/cobalt/bufp-label.c     | 11 ++++-------
 demo/posix/cobalt/bufp-readwrite.c | 11 ++++-------
 demo/posix/cobalt/can-rtt.c        | 13 ++++---------
 demo/posix/cobalt/eth_p_all.c      | 19 ++++++++-----------
 demo/posix/cobalt/gpiopwm.c        | 22 ++++++++--------------
 demo/posix/cobalt/iddp-label.c     | 11 ++++-------
 demo/posix/cobalt/iddp-sendrecv.c  | 11 ++++-------
 demo/posix/cobalt/xddp-echo.c      | 13 ++++---------
 demo/posix/cobalt/xddp-label.c     | 15 +++++----------
 demo/posix/cobalt/xddp-stream.c    | 14 +++++---------
 10 files changed, 50 insertions(+), 90 deletions(-)

diff --git a/demo/posix/cobalt/bufp-label.c b/demo/posix/cobalt/bufp-label.c
index 7ed917fa532d5e6c5af6c04074b4520df1e638e4..c913651abeb38053ccd9d12ccbdc8470e12d0779 100644
--- a/demo/posix/cobalt/bufp-label.c
+++ b/demo/posix/cobalt/bufp-label.c
@@ -24,16 +24,13 @@
  * this port from a client thread (writer).
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <pthread.h>
-#include <errno.h>
-
-#include <boilerplate/ancillaries.h>
-#include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
 
diff --git a/demo/posix/cobalt/bufp-readwrite.c b/demo/posix/cobalt/bufp-readwrite.c
index f5ff8c189796516e7fd1ade70d59ea37a4a342e5..70f25dc9b40adc3cfea7bf513a70a0292c3b13be 100644
--- a/demo/posix/cobalt/bufp-readwrite.c
+++ b/demo/posix/cobalt/bufp-readwrite.c
@@ -24,16 +24,13 @@
  * this port from a client thread (writer).
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <pthread.h>
-#include <errno.h>
-
-#include <boilerplate/ancillaries.h>
-#include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
 
diff --git a/demo/posix/cobalt/can-rtt.c b/demo/posix/cobalt/can-rtt.c
index 13ad0bf56170cfef8d20f8a4753322949d4f8530..77726f26b812cf988ef71798f6cb73a5c569be2a 100644
--- a/demo/posix/cobalt/can-rtt.c
+++ b/demo/posix/cobalt/can-rtt.c
@@ -34,20 +34,15 @@
  * loopback messages.
  */
 
-#include <errno.h>
+#include <rtdm/can.h>
+#include <xenomai/init.h>
+
+#include <getopt.h>
 #include <mqueue.h>
 #include <signal.h>
-#include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <netinet/in.h>
-#include <net/if.h>
-#include <sys/ioctl.h>
-#include <rtdm/can.h>
-#include <xenomai/init.h>
 
 #define NSEC_PER_SEC 1000000000
 
diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
index 63acbf7eff5d4c2d335eaa5e90355d2039d9282c..8cd1ac6dfad36354c0ac30db0b5b7ae6c968fd2b 100644
--- a/demo/posix/cobalt/eth_p_all.c
+++ b/demo/posix/cobalt/eth_p_all.c
@@ -24,20 +24,17 @@
  *
  */
 
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <netinet/ether.h>
+#include <netpacket/packet.h>
+#include <pthread.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-
-#include <signal.h>
-#include <pthread.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <netpacket/packet.h>
-#include <net/ethernet.h>
-#include <net/if.h>
-#include <arpa/inet.h>
-#include <netinet/ether.h>
+#include <sys/mman.h>
+#include <unistd.h>
 
 char buffer[10*1024];
 int sock;
diff --git a/demo/posix/cobalt/gpiopwm.c b/demo/posix/cobalt/gpiopwm.c
index 9706e6e65e33212c1c392c1dc9edf4e017b12453..2bf82dbd5ece6fad8311b140a8ef04127d5566f6 100644
--- a/demo/posix/cobalt/gpiopwm.c
+++ b/demo/posix/cobalt/gpiopwm.c
@@ -1,21 +1,15 @@
-#include <semaphore.h>
-#include <pthread.h>
-#include <signal.h>
 #include <rtdm/gpiopwm.h>
-#include <stdlib.h>
-#include <getopt.h>
-#include <errno.h>
-#include <error.h>
-#include <stdio.h>
-#include <time.h>
 
-#include <unistd.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
 #include <arpa/inet.h>
+#include <error.h>
+#include <getopt.h>
 #include <linux/netdevice.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
 #define MIN_DUTY_CYCLE				(0)
 #define MAX_DUTY_CYCLE				(100)
diff --git a/demo/posix/cobalt/iddp-label.c b/demo/posix/cobalt/iddp-label.c
index 7916a72cf3a89812077556a2dac4fa637e0b1ca8..2ec48329a0a7a29543c196ff73190a9e5639147a 100644
--- a/demo/posix/cobalt/iddp-label.c
+++ b/demo/posix/cobalt/iddp-label.c
@@ -31,16 +31,13 @@
  * port values.
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <pthread.h>
-#include <errno.h>
-
-#include <boilerplate/ancillaries.h>
-#include <rtdm/ipc.h>
 
 pthread_t svtid, cltid;
 
diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-sendrecv.c
index 6cec083a4802510a728c761ef5129326ce032edb..7f9f97348f784dc830647b5b012c03e6be0c3910 100644
--- a/demo/posix/cobalt/iddp-sendrecv.c
+++ b/demo/posix/cobalt/iddp-sendrecv.c
@@ -26,16 +26,13 @@
  * optional.
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <pthread.h>
-#include <errno.h>
-
-#include <rtdm/ipc.h>
-#include <boilerplate/ancillaries.h>
 
 pthread_t svtid, cltid;
 
diff --git a/demo/posix/cobalt/xddp-echo.c b/demo/posix/cobalt/xddp-echo.c
index 67eef7cc2a0885665a8cb14a54de1fb0bd3999a8..06531193b088dbc418eb7aed835fb6a6280dca2e 100644
--- a/demo/posix/cobalt/xddp-echo.c
+++ b/demo/posix/cobalt/xddp-echo.c
@@ -58,18 +58,13 @@
  *   =>  echo traffic back to RT domain via write()     +--+
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <malloc.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
-
-#include <boilerplate/ancillaries.h>
-#include <rtdm/ipc.h>
 
 pthread_t rt, nrt;
 
diff --git a/demo/posix/cobalt/xddp-label.c b/demo/posix/cobalt/xddp-label.c
index 7ba895cc9707871921ce74fc4f46cb2bfd40f07a..544c63ddb406b72abf11560adfc4c113621203ae 100644
--- a/demo/posix/cobalt/xddp-label.c
+++ b/demo/posix/cobalt/xddp-label.c
@@ -64,19 +64,14 @@
  *   =>  mirror traffic to RT domain via write()           +--+
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include <malloc.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
-
 #include <boilerplate/ancillaries.h>
 #include <rtdm/ipc.h>
 
+#include <malloc.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+
 pthread_t rt1, rt2, nrt;
 
 #define XDDP_PORT_LABEL  "xddp-demo"
diff --git a/demo/posix/cobalt/xddp-stream.c b/demo/posix/cobalt/xddp-stream.c
index 575e7d9d10bf65432c1cb7764d801d90f97c6d62..61bb333591a2e9003a3d5109f255bbc07107725c 100644
--- a/demo/posix/cobalt/xddp-stream.c
+++ b/demo/posix/cobalt/xddp-stream.c
@@ -60,18 +60,14 @@
  *   =>  echo traffic back to RT domain via write()                +--+
  */
 
+#include <boilerplate/ancillaries.h>
+#include <rtdm/ipc.h>
+
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
 #include <string.h>
-#include <malloc.h>
-#include <pthread.h>
-#include <fcntl.h>
-#include <errno.h>
-
-#include <boilerplate/ancillaries.h>
-#include <rtdm/ipc.h>
+#include <unistd.h>
 
 pthread_t rt, nrt;
 

-- 
2.54.0

