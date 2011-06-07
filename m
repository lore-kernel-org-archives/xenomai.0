From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue,  7 Jun 2011 16:17:52 +0200
Message-Id: <8b8ab428453ae4d414eebb715acf984c5f6b2c09.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Subject: [Adeos-main] [PATCH 2/5] ipipe: x86: Optimize
	ipipe_percpu_domain_data::status accesses
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Just like in the noarch part, drop the remaining atomic ops used for
status manipulation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe_base.h |    2 --
 arch/x86/kernel/ipipe.c           |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_base.h b/arch/x86/include/asm/ipipe_base.h
index 44c8c73..8fb76ac 100644
--- a/arch/x86/include/asm/ipipe_base.h
+++ b/arch/x86/include/asm/ipipe_base.h
@@ -131,7 +131,6 @@
 static inline void __ipipe_stall_root(void)
 {
 	__asm__ __volatile__(GET_ROOT_STATUS_ADDR
-			     LOCK_PREFIX
 			     TEST_AND_SET_ROOT_STATUS
 			     PUT_ROOT_STATUS_ADDR
 			     : : : ROOT_TEST_CLOBBER_LIST, "memory");
@@ -142,7 +141,6 @@ static inline unsigned long __ipipe_test_and_stall_root(void)
 	int oldbit;
 
 	__asm__ __volatile__(GET_ROOT_STATUS_ADDR
-			     LOCK_PREFIX
 			     TEST_AND_SET_ROOT_STATUS
 			     "sbbl %0,%0;"
 			     PUT_ROOT_STATUS_ADDR
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index cd63d02..b34cce9 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -420,7 +420,7 @@ void __ipipe_halt_root(void)
 	p = ipipe_root_cpudom_ptr();
 
 	trace_hardirqs_on();
-	clear_bit(IPIPE_STALL_FLAG, &p->status);
+	__clear_bit(IPIPE_STALL_FLAG, &p->status);
 
 	if (unlikely(__ipipe_ipending_p(p))) {
 		__ipipe_sync_pipeline();
-- 
1.7.1


