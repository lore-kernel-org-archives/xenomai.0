Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04944E624
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FfaoLkcV"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202312051241423868bb49908774683a
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=E9NIDnV77IRUrPPV+8YEQlpCyx4G311o/2TfKKAgH8E=;
 b=FfaoLkcVTsXCqfx8hOyF7aOVn8t8vJK51LmMDZXFhKlL62onT8KRw7CmrXt2KO9VmYKh+P
 q4GqN0vk2Bx22Qtq5mXUCw7VN1rheTQnFaX3yohXuD6nliyGnTttrpXC1laboIMQ40PBUmfq
 Ut7HqnJ4YW4yfHMdnlwB8hm8B5Brk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:42 +0100
Subject: [PATCH 05/13] demo: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-5-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

- Add an empty line between license information and first include,
  that is what most files already did

- Cleanup unused / unnecessary includes where possible

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/alchemy/altency.c             | 2 +-
 demo/alchemy/cobalt/cross-link.c   | 3 +--
 demo/posix/cobalt/bufp-label.c     | 1 +
 demo/posix/cobalt/bufp-readwrite.c | 1 +
 demo/posix/cobalt/can-rtt.c        | 2 --
 demo/posix/cobalt/eth_p_all.c      | 2 --
 demo/posix/cobalt/gpiopwm.c        | 3 ---
 demo/posix/cobalt/iddp-label.c     | 1 +
 demo/posix/cobalt/iddp-sendrecv.c  | 1 +
 demo/posix/cobalt/xddp-echo.c      | 1 +
 demo/posix/cobalt/xddp-label.c     | 1 +
 demo/posix/cobalt/xddp-stream.c    | 1 +
 12 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index b15930567..072d68f8e 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -3,6 +3,7 @@
  *
  * Licensed under the LGPL v2.1.
  */
+
 #include <stdlib.h>
 #include <math.h>
 #include <stdio.h>
@@ -13,7 +14,6 @@
 #include <unistd.h>
 #include <signal.h>
 #include <alchemy/task.h>
-#include <alchemy/timer.h>
 #include <alchemy/sem.h>
 #include <rtdm/testing.h>
 #include <boilerplate/trace.h>
diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
index 9b1fb348c..0a62c074f 100644
--- a/demo/alchemy/cobalt/cross-link.c
+++ b/demo/alchemy/cobalt/cross-link.c
@@ -20,12 +20,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-#include <sys/mman.h>
 #include <alchemy/task.h>
-#include <alchemy/timer.h>
 #include <rtdm/serial.h>
 
 #define MAIN_PREFIX   "main : "
diff --git a/demo/posix/cobalt/bufp-label.c b/demo/posix/cobalt/bufp-label.c
index 85984c7c7..7ed917fa5 100644
--- a/demo/posix/cobalt/bufp-label.c
+++ b/demo/posix/cobalt/bufp-label.c
@@ -23,6 +23,7 @@
  * is bound to a real-time port and receives a stream of bytes sent to
  * this port from a client thread (writer).
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/bufp-readwrite.c b/demo/posix/cobalt/bufp-readwrite.c
index 74faa5bc8..f5ff8c189 100644
--- a/demo/posix/cobalt/bufp-readwrite.c
+++ b/demo/posix/cobalt/bufp-readwrite.c
@@ -23,6 +23,7 @@
  * is bound to a real-time port and receives a stream of bytes sent to
  * this port from a client thread (writer).
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/can-rtt.c b/demo/posix/cobalt/can-rtt.c
index dd212d804..13ad0bf56 100644
--- a/demo/posix/cobalt/can-rtt.c
+++ b/demo/posix/cobalt/can-rtt.c
@@ -42,9 +42,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <limits.h>
 #include <getopt.h>
-#include <memory.h>
 #include <netinet/in.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
index c4cf0d696..63acbf7ef 100644
--- a/demo/posix/cobalt/eth_p_all.c
+++ b/demo/posix/cobalt/eth_p_all.c
@@ -26,8 +26,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
 
 #include <signal.h>
 #include <pthread.h>
diff --git a/demo/posix/cobalt/gpiopwm.c b/demo/posix/cobalt/gpiopwm.c
index b195d7e1e..9706e6e65 100644
--- a/demo/posix/cobalt/gpiopwm.c
+++ b/demo/posix/cobalt/gpiopwm.c
@@ -1,4 +1,3 @@
-#include <xenomai/init.h>
 #include <semaphore.h>
 #include <pthread.h>
 #include <signal.h>
@@ -11,9 +10,7 @@
 #include <time.h>
 
 #include <unistd.h>
-#include <stdlib.h>
 #include <string.h>
-#include <netdb.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
diff --git a/demo/posix/cobalt/iddp-label.c b/demo/posix/cobalt/iddp-label.c
index fe21bf77f..7916a72cf 100644
--- a/demo/posix/cobalt/iddp-label.c
+++ b/demo/posix/cobalt/iddp-label.c
@@ -30,6 +30,7 @@
  * sockets to them in a more descriptive way than using plain numeric
  * port values.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-sendrecv.c
index 0ce6be2a9..6cec083a4 100644
--- a/demo/posix/cobalt/iddp-sendrecv.c
+++ b/demo/posix/cobalt/iddp-sendrecv.c
@@ -25,6 +25,7 @@
  * different port, only to provide a valid peer name; this is
  * optional.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/xddp-echo.c b/demo/posix/cobalt/xddp-echo.c
index c76f9e7cc..67eef7cc2 100644
--- a/demo/posix/cobalt/xddp-echo.c
+++ b/demo/posix/cobalt/xddp-echo.c
@@ -57,6 +57,7 @@
  *   =>  read traffic from RT domain via read()         |  |
  *   =>  echo traffic back to RT domain via write()     +--+
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/xddp-label.c b/demo/posix/cobalt/xddp-label.c
index 52c898444..7ba895cc9 100644
--- a/demo/posix/cobalt/xddp-label.c
+++ b/demo/posix/cobalt/xddp-label.c
@@ -63,6 +63,7 @@
  *   =>  read traffic from RT domain via read()            |  |
  *   =>  mirror traffic to RT domain via write()           +--+
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/demo/posix/cobalt/xddp-stream.c b/demo/posix/cobalt/xddp-stream.c
index b7934edc4..575e7d9d1 100644
--- a/demo/posix/cobalt/xddp-stream.c
+++ b/demo/posix/cobalt/xddp-stream.c
@@ -59,6 +59,7 @@
  *   =>  read traffic from RT domain via read()                    |  |
  *   =>  echo traffic back to RT domain via write()                +--+
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>

-- 
2.39.2

