Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E910F9E1
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:37 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202309011945357c024e5159d12d0fa4
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1Sl4CpouAUq/tXT7Nxp0u0FVZgGoL4nB72/dPDx3teg=;
 b=HraO7T1sUxymWbRIqh9Dbc5HesEdrrzcbrYZkN9tO+k6RcKxkjn7I6mxEpNIMW4a9tVf0y
 qOMdHMyAuYWPILa3djB72EN9rd9zO0+8EvgJIVwfppKvw69nH6uHbf8vz3YpVvV+VOK5TfE4
 MVmsnHEkWuY7gTScnJ4Jf/QAro7UI=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:40 +0200
Subject: [PATCH stable/v3.2.x v2 17/17] cobalt/x86: Allow building with
 kernels up to 6.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-17-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

asm/fpu/internal.h has been removed in 5.16.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
index a4cc368a5..f8732776c 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
@@ -40,8 +40,10 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #include <asm/i387.h>
 #include <asm/fpu-internal.h>
-#else
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0) && \
+      LINUX_VERSION_CODE < KERNEL_VERSION(5,16,0)
 #include <asm/fpu/internal.h>
+#else
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)

-- 
2.39.2

