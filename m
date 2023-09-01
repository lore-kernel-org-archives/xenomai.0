Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940BF9C5
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:35 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230901194535318cdb4924fe2891a9
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xKKbLMgEIeqW16jvIPEj1L5KXrgVwZWeVcWK3Rm2UB8=;
 b=UivVcFDjKtA9BtnhovK6KZx5wC8ubGIL5iocdt+x4mOHgPlxsj6LOj9VsL8jm8iWG8rNKA
 hqbdB0TvpjbZeJWAQwCeqzZqV5PisM0qcLM/3LlRt95pmo4JLGh0FrhUMohaklFTf64Vu+fy
 HjIgIvXLsR/RDqcjLiQbfx3ixeM08=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:39 +0200
Subject: [PATCH stable/v3.2.x v2 16/17] cobalt/pipe: Allow building with
 kernels up to 6.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-16-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a partial backport of
0537ba93cdb3 ("cobalt: Drop wrappings for kernels < 5.10")

It fixes a compile error (compat_ptr not defined).

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 17aca5df6..e846303e8 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/uaccess.h>
+#include <linux/compat.h>
 #include <asm/io.h>
 #include <asm/xenomai/syscall.h>
 #include <cobalt/kernel/sched.h>

-- 
2.39.2

