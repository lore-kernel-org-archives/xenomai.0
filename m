From: Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] Fix building eth_p_all demo with Mercury core
Date: Thu, 24 Sep 2020 05:58:28 +0300
Message-Id: <20200924025828.21815-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Error message:

In file included from eth_p_all.c:43:
/usr/include/xenomai/boilerplate/ancillaries.h:56:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__early_panic’
   56 | void __noreturn __early_panic(const char *fn,
      |                 ^~~~~~~~~~~~~
/usr/include/xenomai/boilerplate/ancillaries.h:59:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘___panic’
   59 | void __noreturn ___panic(const char *fn,
      |                 ^~~~~~~~
/usr/include/xenomai/boilerplate/ancillaries.h:63:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__panic’
   63 | void __noreturn __panic(const char *fn,
      |                 ^~~~~~~

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 demo/posix/cobalt/eth_p_all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
index 91aef9fbd..ad4c54878 100644
--- a/demo/posix/cobalt/eth_p_all.c
+++ b/demo/posix/cobalt/eth_p_all.c
@@ -40,6 +40,7 @@
 #include <net/if.h>
 #include <arpa/inet.h>
 #include <netinet/ether.h>
+#include <boilerplate/compiler.h>
 #include <boilerplate/ancillaries.h>
 
 char buffer[10*1024];
-- 
2.21.0


