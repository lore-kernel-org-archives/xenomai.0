Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000ED46A7
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:09 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D2D97C785F
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 91196C0007
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 79EAEAC11F1
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:36 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220704130835b75122dbd4519cfc8b
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B8XcZM0glbawTuGrVyGULaNHbxyn3vW3kgmqCZTekQ4=;
 b=lg6dyf03wyBH7MuQYHN8qzL8nIHG2h0vPmr7KRKHCC2l8zenf7M/ywJDC1cG8B38N3Zxgk
 dh80tFRI2HIRysjHQoukbb+GGT58Htv+cEcwA47j0qXxPuLzB2pq+lDt/OZETbOiOqUzlsAu
 lQLFTTRCRjsfaBEkvE2QwgJAcllC4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 02/15] Use linux/stddef.h instead of toolchain header
Date: Mon,  4 Jul 2022 15:08:22 +0200
Message-Id: <ed213eca23696cd4194e5ab8bd149d56863480a3.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool3: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-20220704130835b75122dbd4519cfc8b-ohF6Ri@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=lg6dyf03;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220704130835b75122dbd4519cfc8b-ohF6Ri@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-20220704130835b75122dbd4519cfc8b-ohF6Ri@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 6fb4dc2c2a..71b8c52f5b 100644
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
2.35.3

