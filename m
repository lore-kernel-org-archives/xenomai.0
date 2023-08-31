Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843919BDB
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:49 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230831203741ff1d8af5cd80fac228
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=j/GTxWvHkcW+1FKoT/vpn5Ic8fioEkx16KNCpXdqwOE=;
 b=R00JJMuwEgvyU295IJ+He1TtD8dr9GOouMaWcH/jUqPB5kfSt5WvZ+nJTltBruqbttDb0o
 iRPKeb/w4sZsTaU0WsGHwMf3RRTGgrKj6itwEqcJHYgBh4Vwsx/+zAJeLWnsBfMzqoHcrG85
 in5FiXhgQCzkxHTIpyykn1IHbuozU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:28 +0200
Subject: [PATCH stable/v3.2.x 02/19] Use linux/stddef.h instead of
 toolchain header
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-2-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit ed213eca23696cd4194e5ab8bd149d56863480a3 ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 6fb4dc2c2..71b8c52f5 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -17,7 +17,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <stddef.h>
+#include <linux/stddef.h>
 #include <linux/err.h>
 #include <cobalt/kernel/time.h>
 #include "internal.h"

-- 
2.39.2

