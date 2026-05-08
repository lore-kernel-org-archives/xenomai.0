Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C44355F53
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221399; cv=none; b=CiuzWZYaAv+FhM/OMkZ2cmyvcu5tZ5ZRZnuYhWFuKqGYbCJfo5yhah1kK+15IIG/uW77eGeWHIQ3woY3j/n3SXEHn0I4GXiHDvct1cpsBXGJz+XzBngqOeuvEnFM9YLNVvFjm9e4tLyI0PYPByspqcVEc/+h1pz5fEkpCpqs/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221399; c=relaxed/simple;
	bh=Mwbd+ej9FAE5NTT79N0TOnlFNjawCuFcs369L8AGaCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7vHEdR7SLxL5Seo4uUu+uvzr8n3IL6spseHz9gPSo8WkKQT/3Mx6BzmmTCCJl8ehyG7Lh80hUj6DAKdm0wEZblRn+lv1oWpYHAympXjZHR+D7ziCEQkbGVBakmJ2Gw78OVgX5OOMsxtX+1L/M0jke2U9+gtuuG1KWdjAU1PxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I+mevrn8; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I+mevrn8"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062305e2422733c90002074b
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=buzIG4vs7dRVt9lGzM/7sF957Jh4oAHQWMxceeabVO0=;
 b=I+mevrn8g6oY7bQ2uElrm99zGX2JwnYb1E8FriagV71sn63wSK170WqbVG/9Sr9nfb4e1z
 rqeVUjya1sSmb2Qyo8ppDBAny4FluUq/VPCQU2xcPtVl9ncS1uZhSHio8RQg4G0eI8EKFGsg
 S4/AqMOt5oG6lkW7B8M8ljWJ7sAImwJa+pcVcxf4TdE2Sz3OlkBCqFRX6TdmpXcP8GziWKcx
 kkX/Q7EVFzI7xXtUj6xH94Tbdhqx3q5D167DFhZA1uPjKGP1Axmn8mWWqjj8Rv7+H65wJ+0S
 lj8XVfZ7XhxOqD201QtP3U3oliLu3eD/POsPMW40N4w5ReJ6jmV4gfLQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:02 +0200
Subject: [PATCH 29/32] utils/can: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-29-e449f2bd4fc2@siemens.com>
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
 utils/can/rtcanconfig.c | 14 +++++---------
 utils/can/rtcanrecv.c   |  9 ++-------
 utils/can/rtcansend.c   | 13 +++----------
 3 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/utils/can/rtcanconfig.c b/utils/can/rtcanconfig.c
index 395e0368d041a087de8dd8738719fb394e6dafb3..9565ff9f0ea823c0495a16b320ce515b01d405c2 100644
--- a/utils/can/rtcanconfig.c
+++ b/utils/can/rtcanconfig.c
@@ -22,18 +22,14 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+
+#include <boilerplate/ancillaries.h>
+#include <rtdm/can.h>
+
+#include <getopt.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <signal.h>
-#include <unistd.h>
 #include <string.h>
-#include <time.h>
-#include <errno.h>
-#include <getopt.h>
-#include <sys/mman.h>
-#include <boilerplate/ancillaries.h>
-
-#include <rtdm/can.h>
 
 static void print_usage(char *prg)
 {
diff --git a/utils/can/rtcanrecv.c b/utils/can/rtcanrecv.c
index 1b7101dab74bd9d96d28c46205ec57e03112eb96..6c3029fa0ddacb5727842d1207574ef305f21c69 100644
--- a/utils/can/rtcanrecv.c
+++ b/utils/can/rtcanrecv.c
@@ -1,16 +1,11 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <unistd.h>
-#include <time.h>
-#include <errno.h>
-#include <getopt.h>
 
 #include <alchemy/task.h>
 #include <boilerplate/ancillaries.h>
 
 #include <rtdm/can.h>
 
+#include <getopt.h>
+
 static void print_usage(char *prg)
 {
     fprintf(stderr,
diff --git a/utils/can/rtcansend.c b/utils/can/rtcansend.c
index ac8f8c1914194b0a5ce0b42e1591a9dc70681db5..b70687f6dd7ee46097e052c91798e46daee2c888 100644
--- a/utils/can/rtcansend.c
+++ b/utils/can/rtcansend.c
@@ -1,17 +1,10 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <unistd.h>
-#include <time.h>
-#include <errno.h>
-#include <getopt.h>
-
-#include <boilerplate/ancillaries.h>
 #include <alchemy/task.h>
 #include <alchemy/timer.h>
-
+#include <boilerplate/ancillaries.h>
 #include <rtdm/can.h>
 
+#include <getopt.h>
+
 extern int optind, opterr, optopt;
 
 static void print_usage(char *prg)

-- 
2.54.0

