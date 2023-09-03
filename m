Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2694524E
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230903150502e76f468775d5d4666c
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=49YragBrcqkIWz5qyPh1qLvSA48JdKin2lUMinm9ZFg=;
 b=f1nqwv7FT9hcMgDTSBLfKMj0BSchg+MVY3YqHa/jJo1gCiPA4OuiuV7vwEouQFY5Nfb74I
 4lRkkMcZA8xLe9XAOKt2SqhJN+SMJA5gIWi8ItClxje+O6Lkgnk0E8UiW7YcW/3K/DL9/NMF
 HD6MkUzUz6KOpa8tiXQc0AzWn1FKQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 19/20] ci: Update comment
Date: Sun,  3 Sep 2023 17:04:56 +0200
Message-Id: <9e5221e52d93876ee9e6bb0f09b5cf40aa49e78e.1693753497.git.jan.kiszka@siemens.com>
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
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5c8e01f098..8c1cfa2dc9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -73,7 +73,7 @@ variables:
     - make -j $(nproc) ${KERNEL_DEFCONFIG}
     # Generic settings
     - ./scripts/config -d DEBUG_INFO
-    # I-pipe and Xenomai settings
+    # Dovetail and Xenomai settings
     - ./scripts/config -e DOVETAIL
     - ./scripts/config -e XENOMAI
     - ./scripts/config -e XENO_OPT_SCHED_CLASSES
-- 
2.35.3

