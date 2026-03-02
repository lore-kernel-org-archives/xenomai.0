Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBF38F641
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444304; cv=none; b=XvMNIA6A76pqGB5ePrWxSie671fYpYFckUO1mUfMdil+p93Hj08gYhqxpy5+ccAKnZCvHHo1BzhbFTddj1OdLMX+Ek9cHTGIGqRPzBpkTRECJ+GZstrOcPxmTaWHv6YDt+Sk2I4hsHy8Wv+lQr0noWcIrBM5wdLuQh124iIuyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444304; c=relaxed/simple;
	bh=1QMf1C6/Hr+Z6FGOg487icwIPqqvIZtb7BdAs3yRtGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUP8CfbkrBVaVj6rKCfe+Qss/nC6Rwv0ywcCIubkBcJHDE0w+yMEn/w1T55whTxbEAt5fHtYdeGIX7gSzfPPqnmgEkAvTdKbpOSQSAxJzwvu03cvWoGjzqo7vJkjUuYD6YwVheizxgNCKNfz/tzkZS09Jt6edBsbh2zzwFoaz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VPaZhegD; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VPaZhegD"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026030209381116afc6ab4900020719
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z9JUEJ/ubwjk4z9ytX5mGXVf8H7z9avGrYmBXCmTVQ4=;
 b=VPaZhegDdCAUi6sZp5A4E9yuNShSnfYTTPNidxNH5JWTQ31FqkBDIrPVy+zjSNyuvZzEwj
 +wvX3fm4Mgl2exkFRro4K69bz7Nnaa0+GPkVegOaYYWKdYsbw+kaY7I0Ka8hsT9i7miTpplR
 NZmeXhbviS4cddIgHPbbZ7s8HYij+R0h4XG0oa5376Vo1zgwBMEaQ65CssCBvu5LFO2zl+/y
 aaXQDr5npjx5en9m53ZeQmp9fpE4928pGq8R2JBecnarX5vYkKNEI9mo3aRjNrnWXGiRzKm8
 U/jBfaLdUd/AdlLb4cFwrDI69fbaMGRinfD7p4b7WNqRX/M4hINuhYwQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:18 +0100
Subject: [PATCH v2 19/20] lib/cobalt: thread: Cleanup and reorder includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-19-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving to "from private to public" order. Should help us to make sure
headers stay self-contained.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/thread.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index e237e7ba1e85166a7b39a62a6a2d35550a1df009..264fd6dda90e9afb82f5d6b7a7294928db6e598e 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -16,15 +16,15 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stddef.h>
+#include "internal.h"
+
+#include <asm/xenomai/syscall.h>
+
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
 #include <pthread.h>
-#include <sys/types.h>
 #include <semaphore.h>
-#include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 /**
  * @ingroup cobalt_api

-- 
2.53.0

