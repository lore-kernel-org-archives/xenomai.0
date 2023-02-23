Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4231FCC
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:14:29 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202302230704191a1270aa1fcfc9b31e
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kjhmSp4ZvW5wUrpU7i1RPcaUR49Z32AbWwMSsDxj6Bw=;
 b=a5uNu9LLqPkQsDV315B0wHNU9fx8Gts34TpI6PBw2/EI4yplzJJYQrzSG6onzNyxzAIaG0
 wdWcANGQkuqhggd+MtGUABQOFaE0cJmQfDps8B7c02svMMGmXCtFAf4KBzjgXGRjhIfi/icx
 DKEYvoFEDGlB1Nbu7dQNrDU6SI+3c=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [stable 3.2.x][PATCH 2/7] y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
Date: Thu, 23 Feb 2023 08:04:12 +0100
Message-Id: <20230223070417.3969366-3-florian.bezdeka@siemens.com>
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

The compat syscall was previously routed to the native entrypoint
which triggered a failure during mmsghdr validation.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index 3c9c287e1..1c83ff4e3 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -64,5 +64,6 @@ __COBALT_CALL32emu_THUNK(sendmsg)
 __COBALT_CALL32emu_THUNK(mmap)
 __COBALT_CALL32emu_THUNK(backtrace)
 __COBALT_CALL32emu_THUNK(mq_timedreceive64)
+__COBALT_CALL32emu_THUNK(recvmmsg64)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
-- 
2.39.1

