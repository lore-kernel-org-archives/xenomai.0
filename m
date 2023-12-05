Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072252F73
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IfyY35Hf"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023120512414388e2def8baed8809e3
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vR6moqKkcrfZVFXQdfNaSu47AKO9IByaFzD6ylFmZSE=;
 b=IfyY35Hfesk3gC16nuSORtBaqL+hnvTxX/T4tJP9xTmLpx4bJofws7ZaMJIDkT0/gxOt5B
 9XhxQQMjSikUuKGuVRpMkTeFRx/3vpaE6g2PRjCgq3labXWyLdI3c/RorMPS+mYYHfqa+p9o
 QDcHwUNCk3z8XOtprFkSN1dPxSwoA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:44 +0100
Subject: [PATCH 07/13] lib/analogy: Cleanup includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-7-3e0abd7c68fa@siemens.com>
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
 lib/analogy/calibration.c | 2 +-
 lib/analogy/descriptor.c  | 1 -
 lib/analogy/math.c        | 1 -
 lib/analogy/range.c       | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
index 9fa3ff5a6..7ae5ef61c 100644
--- a/lib/analogy/calibration.c
+++ b/lib/analogy/calibration.c
@@ -19,6 +19,7 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -28,7 +29,6 @@
 #include <errno.h>
 #include "iniparser/iniparser.h"
 #include "boilerplate/ancillaries.h"
-#include "boilerplate/list.h"
 #include "calibration.h"
 
 #define CHK(func, ...)								\
diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
index bc4d7bd25..de3ef9e99 100644
--- a/lib/analogy/descriptor.c
+++ b/lib/analogy/descriptor.c
@@ -20,7 +20,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
 #include <string.h>
 #include <rtdm/analogy.h>
 #include "internal.h"
diff --git a/lib/analogy/math.c b/lib/analogy/math.c
index 2e6e47555..8a26d2e1d 100644
--- a/lib/analogy/math.c
+++ b/lib/analogy/math.c
@@ -21,7 +21,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <math.h>
 #include <assert.h>
 
 #include <rtdm/analogy.h>
diff --git a/lib/analogy/range.c b/lib/analogy/range.c
index d9f7a4872..573bde327 100644
--- a/lib/analogy/range.c
+++ b/lib/analogy/range.c
@@ -21,7 +21,6 @@
  */
 
 #include <errno.h>
-#include <math.h>
 #include "internal.h"
 #include <rtdm/analogy.h>
 

-- 
2.39.2

