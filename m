From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 08/25] cobalt/x86: Move shared headers out of pipeline
 specific folder
Date: Thu, 20 May 2021 23:44:18 +0200
Message-Id: <4fc4fa9d215d689f515e32fe95fd3b8374f937f1.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are not affected by pipeline differences.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/c1e.h      | 0
 kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/features.h | 0
 kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/smi.h      | 0
 .../arch/x86/{ipipe => }/include/asm/xenomai/syscall32-table.h    | 0
 .../cobalt/arch/x86/{ipipe => }/include/asm/xenomai/syscall32.h   | 0
 kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/wrappers.h | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/c1e.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/features.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/smi.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/syscall32-table.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/syscall32.h (100%)
 rename kernel/cobalt/arch/x86/{ipipe => }/include/asm/xenomai/wrappers.h (100%)

diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/c1e.h b/kernel/cobalt/arch/x86/include/asm/xenomai/c1e.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/c1e.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/c1e.h
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/features.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/features.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/features.h
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/smi.h b/kernel/cobalt/arch/x86/include/asm/xenomai/smi.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/smi.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/smi.h
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
similarity index 100%
rename from kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/wrappers.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
-- 
2.26.2


