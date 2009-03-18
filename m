Message-ID: <49C0BE25.6060706@domain.hid>
Date: Wed, 18 Mar 2009 10:25:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] x86: Fix miscompile of strncopy_from_user
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This merges kernel commit e0a96129db574d6365e3439d16d88517c437ab33
(x86: use early clobbers in usercopy*.c). Without, gcc 4.3 may have let
these functions return 0 even if the actual length was > 0.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/usercopy_32.c |    2 +-
 ksrc/arch/x86/usercopy_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ksrc/arch/x86/usercopy_32.c b/ksrc/arch/x86/usercopy_32.c
index 3060cc3..3bcecde 100644
--- a/ksrc/arch/x86/usercopy_32.c
+++ b/ksrc/arch/x86/usercopy_32.c
@@ -38,7 +38,7 @@ do {									   \
 		"	.align 4\n"					   \
 		"	.long 0b,3b\n"					   \
 		".previous"						   \
-		: "=d"(res), "=c"(count), "=&a" (__d0), "=&S" (__d1),	   \
+		: "=&d"(res), "=&c"(count), "=&a" (__d0), "=&S" (__d1),	   \
 		  "=&D" (__d2)						   \
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src), "4"(dst) \
 		: "memory");						   \
diff --git a/ksrc/arch/x86/usercopy_64.c b/ksrc/arch/x86/usercopy_64.c
index 1b1da41..5867483 100644
--- a/ksrc/arch/x86/usercopy_64.c
+++ b/ksrc/arch/x86/usercopy_64.c
@@ -39,7 +39,7 @@ do {									   \
 		"	.align 8\n"					   \
 		"	.quad 0b,3b\n"					   \
 		".previous"						   \
-		: "=r"(res), "=c"(count), "=&a" (__d0), "=&S" (__d1),	   \
+		: "=&r"(res), "=&c"(count), "=&a" (__d0), "=&S" (__d1),	   \
 		  "=&D" (__d2)						   \
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src), "4"(dst) \
 		: "memory");						   \

