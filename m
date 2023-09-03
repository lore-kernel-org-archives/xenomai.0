Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC73FE6
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230903150502700547b3302273ecaa
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wI6/kjfoGKHmKsGdNFs/bkqPuk7TJCe93eBU+6NudQQ=;
 b=Galy9V8AKef+nXPmjB38nYJKAWliWDYtvfp0BjCJt4M0apXL+6eySBoAzqaw+dbWpjOfl5
 aagwj4xTaI4fQ/ESiOY1+Fnkgcmr/WjA9wYRoI1vLiOmOxKWjSthWe/MiRrBOIp28JlIeDPS
 uYMRK3bJmwTNY4eULiCaKysaYKhdM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 20/20] cobalt/posix: Update comment
Date: Sun,  3 Sep 2023 17:04:57 +0200
Message-Id: <ab3a105522cfdfc8a1e5591831d4fdee1a2cfdfe.1693753497.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 23ed913bb2..7cfaa723e6 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -638,8 +638,8 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	 * ->map_thread() handler is invoked after the TCB is fully
 	 * built, and when we know for sure that current will go
 	 * through our task-exit handler, because it has a shadow
-	 * extension and I-pipe notifications will soon be enabled for
-	 * it.
+	 * extension and dovetail notifications will soon be enabled
+	 * for it.
 	 */
 	xnthread_run_handler(thread, map_thread);
 	pipeline_enable_kevents();
-- 
2.35.3

