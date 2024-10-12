Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E814D433
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728815; cv=none; b=m41eIOCgU5Ys03OGramhyRHG6RFSXV1Ug/ODKRM7PGSCPtyOuviRcVh8jvVhsnlZK8SBQ3aZ+Jp9AJ7KhwTFNo5xEFSNBsfAilZa9DrbvzKvEnelBi1E2CxeOe0ReImoo1I5z6V3LJqWtP0gm9nh1ApiLCKQwkDG7xBkV1bwkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728815; c=relaxed/simple;
	bh=012o/p5Dt5wXoOIaISUJ+8EDzuhAWO2wPq8BXNvFMAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIGU3WIh3QYTZxghQ4zz75Z8JASDatE95F69LvmOoHIHhNNrsXM/1pHMfOmS6VxdyN5LjBqXcsA4IBfMn3MD/r8ep4zPvfln8TBeyomJSzrwkTFfxMT8EkA/kuh9mmAk/DjsUkwjuTtFSxzc7HqVldlVjHa1kdwI2r96V5bvULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Sfl3HWkp; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Sfl3HWkp"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241012102644f6959851e5fe2e39e5
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qxuGD9tWyO0KgN9itCyWS5OJ+j9n3DMFd/jaG9XA8yY=;
 b=Sfl3HWkpYxFE2s4ZuUMz027a47IFjc6yvu+Od5cvCO2deYY53eFFXk7w6dyJF883OW3v9W
 LqWKe3g+kMziy8pGRm2wwopbmLfmoovoWr6J13lbP4OJVXcsk5OtmvvChueb01Gc1XBwTwVr
 fZzSjRQBvfGn6aRlStzeilN6RdUb2F+IVG59HhfuZ1Gg8mkWznMRqvI4ay3Lv8XktbzBz8Gs
 u0+k2hSomX05j3fFB4mNvZPyrEmnZ43alVBMa2MyU7JJG9KW0zmQoTbr6d8y4aBAgHCMkToE
 hX8Rl2kHmJik5jW6t7ZeIYC7vTVIUKfeRT7hXEo4zSEL6Q0l0XIv26hA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:43 +0200
Subject: [PATCH 4/7] libcobalt: arm64: Cleanup unused includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-4-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change, preparation work for the asm/xenomai/syscall.h
removal.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/arm64/features.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/lib/cobalt/arch/arm64/features.c b/lib/cobalt/arch/arm64/features.c
index 044c95db3..e16486531 100644
--- a/lib/cobalt/arch/arm64/features.c
+++ b/lib/cobalt/arch/arm64/features.c
@@ -14,21 +14,12 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <string.h>
-#include <string.h>
-#include <unistd.h>
-#include <limits.h>
-#include <cobalt/wrappers.h>
-#include <cobalt/ticks.h>
-#include <asm/xenomai/syscall.h>
+
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
+#include <stdio.h>
+#include <string.h>
+
 #include "internal.h"
 
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)

-- 
2.39.5

