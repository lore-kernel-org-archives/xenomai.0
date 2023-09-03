Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F605249
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023090315050160b5a6c6564eb842e5
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aD6oyhSR0oRDe2SayqjuKozv3zXoE/ELLsraW42b+Ps=;
 b=LWh67YjLNsb6oJOr0gqZjH6/L7GRJKgAck1OatHKXYXgzJNn6P17wL1QaVMBkRPDj8s6Yx
 NptWzFgkp1eMzG4DtjMADb+PcMVB8Fz/c4AsAqy1xTwqWSDeC1G+n+g2A+BQgTv+q1qtmusi
 CnB7eDGiGjJU8bh2jYbhFKYN9z/GQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 18/20] include/cobalt: Fix inclusion guard names
Date: Sun,  3 Sep 2023 17:04:55 +0200
Message-Id: <8ed2bc9dc0b3d259986226e76435367d0994c8d2.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Copy&pasted from their former I-pipe sibling.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/tick.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/tick.h b/include/cobalt/kernel/dovetail/pipeline/tick.h
index 372d8323fc..2670a7d339 100644
--- a/include/cobalt/kernel/dovetail/pipeline/tick.h
+++ b/include/cobalt/kernel/dovetail/pipeline/tick.h
@@ -2,8 +2,8 @@
  * SPDX-License-Identifier: GPL-2.0
  */
 
-#ifndef _COBALT_KERNEL_IPIPE_TICK_H
-#define _COBALT_KERNEL_IPIPE_TICK_H
+#ifndef _COBALT_KERNEL_DOVETAIL_TICK_H
+#define _COBALT_KERNEL_DOVETAIL_TICK_H
 
 int pipeline_install_tick_proxy(void);
 
@@ -13,4 +13,4 @@ struct xnsched;
 
 bool pipeline_must_force_program_tick(struct xnsched *sched);
 
-#endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
+#endif /* !_COBALT_KERNEL_DOVETAIL_TICK_H */
-- 
2.35.3

