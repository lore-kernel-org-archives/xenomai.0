Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585F31AF3D
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=YJ3Z9QGeuz5Sf6L3X4Jw038mPmmflrtxLvK/KRd4yyKfy9t9Y2oIW9tmyHfElWRhhTDyNHxPItJgzWGCyqYvk0iVFn5uU0hX9RkpOrSgaGQVBQSTVXeLjVfFRrUGOGSyGue7jrdB8hyhI31D/dQkCdngF+38Y9CGGduZK8Jtyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=1QMf1C6/Hr+Z6FGOg487icwIPqqvIZtb7BdAs3yRtGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTrjFIVPJqG7uxl/yv/+8H2HiM/E5G0RGgIzxLJtdB5xpxvwTwjzuptDw2DYKiYmX7eU4XEX9jmvpz0vpmpMC47ojUv4TFmdygR2AudLyqTjcRg+yIvzmGHDxhN9Pj3hbwzQqmPlJ/dNyS721gLAWPML46jM2dY7ILpF6J3pMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Kw0+hv8g; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Kw0+hv8g"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602200908494b94fc9639000207e6
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z9JUEJ/ubwjk4z9ytX5mGXVf8H7z9avGrYmBXCmTVQ4=;
 b=Kw0+hv8gORGQVgjG+p3EyMuGV35iheG2LZ2CDwmqPZuWzTiLUjcMxtJql5l1d+xvHTxVjj
 zp0Pt1H6R+hl72ScJs3sM2QQ/KsS+Rqtm5eQeY2B2VbTdZUJpZMKjZSRuDd0dWDhc6hHbudJ
 P2qMstwY3HQi3FGy3JgksjFvOcuEq3xEZZULPs5gCnnGxXWH4kE+Eh+nPhATJZBfQD3UHvBB
 xeg8jrFBa4/MHev+lT74hzAK2RhKBwF36BxoqWT9KPGA4GBvRxmQgLX6jY5r7aAkKp2ysFPl
 rTSk7uBiCAoAfAYq6mftMnTpLKksZqBe1An9Q/nn0GO8RitX/6i673hA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:09:02 +0100
Subject: [PATCH 19/20] lib/cobalt: thread: Cleanup and reorder includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-19-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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

