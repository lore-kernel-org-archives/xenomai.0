Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0585C093
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KH59Vw9x"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231205124145dc9e8593cd0f3b2817
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p62wykBkwNR5Lu3WV8pq+nLsDqF8KvGNtDDR86W2SjM=;
 b=KH59Vw9xh6sxh15tJSTrba7jyhRffYwgJ4gJfHhzSja9oJtYilkdIaBUdk3YXDPcUTM4o+
 qyFKQir3irvUmCHf+N9rxxAq/cey4mFWYdlnBKIr2HwsniFcL/q2ig4BteNkpl6sHwmjyv1A
 tYvyhXAyib0s/rDeczQz/DiVNfcrw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:49 +0100
Subject: [PATCH 12/13] lib/trank: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-12-3e0abd7c68fa@siemens.com>
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
 lib/trank/init.c     | 1 +
 lib/trank/internal.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/trank/init.c b/lib/trank/init.c
index ebb592509..cbd034e03 100644
--- a/lib/trank/init.c
+++ b/lib/trank/init.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <xenomai/init.h>
 #include "internal.h"
 
diff --git a/lib/trank/internal.c b/lib/trank/internal.c
index 585fc36ec..391fd9a06 100644
--- a/lib/trank/internal.c
+++ b/lib/trank/internal.c
@@ -15,13 +15,13 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <xeno_config.h>
-#include <stdio.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
-#include <memory.h>
 #include <boilerplate/signal.h>
+
 #include "cobalt/internal.h"
 #include "internal.h"
 

-- 
2.39.2

