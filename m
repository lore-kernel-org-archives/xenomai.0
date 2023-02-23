Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE661FD1
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:30 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230223070420406310df24d1a58c5d
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=viZVc1YS5cvXQPK5k1PqkEKlFS2yvpxqGzSQ/lx2/94=;
 b=mB1V/jMJs3cqwOhKFNbozKpuZeLfVyCgP6W1WyuxlBKAPpuA7uTo96HBd3ELbVRFtQYEz9
 mJDWOJ+i1bwKCPKeM4idKuio+lMdIjOsVS/YuH2E5Lwm/EjTajolsHYMwZgqMLwO9pDCJux/
 /gVAyGrPobn1q+oGR6wm89RTfQOcw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 3/7] y2038: cobalt: posix/signal: Take care of compat mode for sigtimedwait64
Date: Thu, 23 Feb 2023 08:04:13 +0100
Message-Id: <20230223070417.3969366-4-florian.bezdeka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The compat syscall was previously routed to the native entrypoint.
While the timeout is always based on time64_t the siginfo has to be
handled different in compat mode.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index 1c83ff4e3..3986b227b 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -64,6 +64,7 @@ __COBALT_CALL32emu_THUNK(sendmsg)
 __COBALT_CALL32emu_THUNK(mmap)
 __COBALT_CALL32emu_THUNK(backtrace)
 __COBALT_CALL32emu_THUNK(mq_timedreceive64)
+__COBALT_CALL32emu_THUNK(sigtimedwait64)
 __COBALT_CALL32emu_THUNK(recvmmsg64)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
-- 
2.39.1

