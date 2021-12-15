From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: x86: Fix include guard names
Message-ID: <4abfdacb-93ef-221f-dbec-9d0d1899bb26@siemens.com>
Date: Wed, 15 Dec 2021 18:29:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Once derived from PowerPC, apparently.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/arch/x86/include/asm/xenomai/syscall.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 2e02b9983b..79bf17ee75 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -15,8 +15,8 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#ifndef _LIB_COBALT_POWERPC_SYSCALL_H
-#define _LIB_COBALT_POWERPC_SYSCALL_H
+#ifndef _LIB_COBALT_X86_SYSCALL_H
+#define _LIB_COBALT_X86_SYSCALL_H
 
 #include <xeno_config.h>
 #include <cobalt/uapi/syscall.h>
@@ -213,4 +213,4 @@ asm (".L__X'%ebx = 1\n\t"
 #define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)	XENOMAI_DO_SYSCALL(4,op,a1,a2,a3,a4)
 #define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5)	XENOMAI_DO_SYSCALL(5,op,a1,a2,a3,a4,a5)
 
-#endif /* !_LIB_COBALT_POWERPC_SYSCALL_H */
+#endif /* !_LIB_COBALT_X86_SYSCALL_H */
-- 
2.31.1

