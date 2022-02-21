From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/3] y2038: cobalt: rtdm/fd: Take care of compat mode for
 recvmmsg64
Date: Mon, 21 Feb 2022 14:25:03 +0100
Message-Id: <20220221132504.55876-3-florian.bezdeka@siemens.com>
In-Reply-To: <20220221132504.55876-1-florian.bezdeka@siemens.com>
References: <20220221132504.55876-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, johannes.lauenstein@siemens.com, Florian Bezdeka <florian.bezdeka@siemens.com>

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
2.35.1


