Message-ID: <4F1FD363.80301@domain.hid>
Date: Wed, 25 Jan 2012 11:03:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2.6] mayday: Fix code setup for x86 and
	blackfin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The code structures on x86 were broken as the compiler aligned the
internal layout. The same may have happened on blackfin. Fix it by
applying a packed tag on the enclosing structures.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Haven't checked Xenomai 3 yet, it may be affected as well.

 include/asm-blackfin/bits/shadow.h |    2 +-
 include/asm-x86/bits/shadow_32.h   |    4 ++--
 include/asm-x86/bits/shadow_64.h   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-blackfin/bits/shadow.h b/include/asm-blackfin/bits/shadow.h
index 3f7e4eb..58cfdc6 100644
--- a/include/asm-blackfin/bits/shadow.h
+++ b/include/asm-blackfin/bits/shadow.h
@@ -84,7 +84,7 @@ static inline void xnarch_setup_mayday_page(void *page)
 	 * We don't mess with ASTAT here, so no need to save/restore
 	 * it in handle/fixup code.
 	 */
-	static const struct {
+	static const struct __attribute__ ((__packed__)) {
 		struct __attribute__ ((__packed__)) {
 			u16 op;
 			u16 imm;
diff --git a/include/asm-x86/bits/shadow_32.h b/include/asm-x86/bits/shadow_32.h
index b7a0e87..43fc2d0 100644
--- a/include/asm-x86/bits/shadow_32.h
+++ b/include/asm-x86/bits/shadow_32.h
@@ -70,7 +70,7 @@ static inline void xnarch_setup_mayday_page(void *page)
 	 * Also note that if SEP is present, we always assume NPTL on
 	 * the user side.
 	 */
-	static const struct {
+	static const struct __attribute__ ((__packed__)) {
 		struct __attribute__ ((__packed__)) {
 			u8 op;
 			u32 imm;
@@ -94,7 +94,7 @@ static inline void xnarch_setup_mayday_page(void *page)
 		.bug = 0x0b0f,
 	};
 
-	static const struct {
+	static const struct __attribute__ ((__packed__)) {
 		struct __attribute__ ((__packed__)) {
 			u8 op;
 			u32 imm;
diff --git a/include/asm-x86/bits/shadow_64.h b/include/asm-x86/bits/shadow_64.h
index fc90b9e..3fa6473 100644
--- a/include/asm-x86/bits/shadow_64.h
+++ b/include/asm-x86/bits/shadow_64.h
@@ -66,7 +66,7 @@ static inline void xnarch_setup_mayday_page(void *page)
 	 * We intentionally don't mess with EFLAGS here, so that we
 	 * don't have to save/restore it in handle/fixup code.
 	 */
-	static const struct {
+	static const struct __attribute__ ((__packed__)) {
 		struct __attribute__ ((__packed__)) {
 			u8 op;
 			u32 imm;
-- 
1.7.3.4

