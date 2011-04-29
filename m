Message-ID: <4DBAACE4.9030307@domain.hid>
Date: Fri, 29 Apr 2011 14:19:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PULL] x86: Fix return type of DO_SYSCALL_INNER macro
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 985cf80d202f97e32ae45957f2bfca764e3eb2=
43:

  nios2: fix pipeline patch for 2.6.35-mmu -- take #2 (2011-04-29 11:34:1=
1 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      x86: Fix return type of DO_SYSCALL_INNER macro

 include/asm-x86/syscall.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---

x86: Fix return type of DO_SYSCALL_INNER macro

gcc will complain about 'conversion to =E2=80=98int=E2=80=99 from =E2=80=98=
long int=E2=80=99 may alter
its value' with -Wconversion as DO_SYSCALL treats the return value of
DO_SYSCALL_INNER as int. Align DO_SYSCALL_INNER to its user.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-x86/syscall.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86/syscall.h b/include/asm-x86/syscall.h
index 06195c9..b02c01d 100644
--- a/include/asm-x86/syscall.h
+++ b/include/asm-x86/syscall.h
@@ -386,7 +386,7 @@ static inline void __xn_get_ebp(void **dest)
 		: "=3Da" (__resultvar)		\
 		: "0" (name) ASM_ARGS_##nr	\
 		: "memory", "cc", "r11", "cx");	\
-	(long) __resultvar;			\
+	(int) __resultvar;			\
 })
=20
 #define DO_SYSCALL(name, nr, args...)					\
--=20
1.7.1

