Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFAC8EC
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:31 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230901194528d208b922a38ebd0a44
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=j/GTxWvHkcW+1FKoT/vpn5Ic8fioEkx16KNCpXdqwOE=;
 b=WkbZJcR7UV+5pA2aAT372V663thNTbEnqMehun9imbb0iE7tRw75BmVZDEvVBFmPo4IWNz
 sAyywLfj/rrZ4k8cEXP2Gy3qpLfG/Q9C/upi2KwkAJqvVe53fc3NAXpq0kTXKQLY/HVsagUh
 oGoVu+9UlQ3K4MTMG1OQ0AZrOsUIQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:25 +0200
Subject: [PATCH stable/v3.2.x v2 02/17] Use linux/stddef.h instead of
 toolchain header
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-2-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
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

