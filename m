Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E42580
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 08:45:22 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230419080503e2b981e56d740d3d44
        for <xenomai@lists.linux.dev>;
        Wed, 19 Apr 2023 10:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sLu89pqCNbFQOntj735ONIn4oHNcKNRVv1hQXIrpyfA=;
 b=SoCxXZSH3KQcQe6/KSe7XP/7bo1vB7O+P8h4JlFCi/sotexYCxPfOzFKoLSm+rQig2iATK
 JkqCep4xX3YPjYZ7XELPuu19pKGLcTZaF8/pXr9UHvKoIec0F+pOg9i3ZxNb/WZ8t0xGcYTI
 2UImX69d0zn2AwqHbpKBc8BmMyWRg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH next,stable/3.0-3.2] lib/cobalt: Fix possible fd leak in __map_umm
Date: Wed, 19 Apr 2023 10:03:07 +0200
Message-Id: <20230419080307.125787-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case the MEMDEV_RTIOC_STAT fails we have to close the file
descriptor.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Note: This patch applies to all stable branches as well.

 lib/cobalt/umm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index 944620fee..c30ada6a2 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -59,6 +59,7 @@ static void *__map_umm(const char *name, uint32_t *size_r)
 
 	ret = __RT(ioctl(fd, MEMDEV_RTIOC_STAT, &statbuf));
 	if (ret) {
+		__RT(close(fd));
 		early_warning("failed getting status of %s: %s",
 			      name, strerror(errno));
 		return MAP_FAILED;
-- 
2.39.2

