Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2904CDF7
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LiJ8J0um"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20231205124145e702eddea01a4defdd
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qtriV40jOIaU4TLF+wQdLOXxLRqwG1vDhImqARe7g1Q=;
 b=LiJ8J0umOJCiLKdpOhIg8MZFwch0kaTzX5YgU4Lws4FrUJNMplb7+yLp1GJRZ6discDH2R
 KMrFb80COlqLMEkpKxqo6tYiNYt5Yh7ttv9Yqe+JG5aRt0U2c5/+yMViHusjDXLiAJ+dgH2K
 ydnOcLdZOM9WL22y+lPTKl8EmM1sc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:48 +0100
Subject: [PATCH 11/13] lib/smokey: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-11-3e0abd7c68fa@siemens.com>
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
 lib/smokey/helpers.c | 1 +
 lib/smokey/init.c    | 8 +++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index bc4b3f9bb..f4b9ee1fc 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -15,6 +15,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdio.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/lib/smokey/init.c b/lib/smokey/init.c
index e1a133ee6..19e47f1fb 100644
--- a/lib/smokey/init.c
+++ b/lib/smokey/init.c
@@ -15,11 +15,10 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <stdio.h>
-#include <time.h>
 #include <stdlib.h>
 #include <ctype.h>
-#include <unistd.h>
 #include <malloc.h>
 #include <string.h>
 #include <errno.h>
@@ -27,11 +26,10 @@
 #include <fnmatch.h>
 #include <boilerplate/list.h>
 #include <boilerplate/ancillaries.h>
-#include "copperplate/internal.h"
-#include <xenomai/init.h>
-#include <xenomai/tunables.h>
 #include <smokey/smokey.h>
 
+#include "copperplate/internal.h"
+
 /**
  * @defgroup smokey Smokey API
  *

-- 
2.39.2

