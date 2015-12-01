From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <565DF501.8060805@mperpetuo.com>
Date: Tue, 1 Dec 2015 11:29:05 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt: increase default system heap size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On arm64, running the included switchtest program hits the default 
system heap limit of 256k.

The program creates 97 threads, each allocating space on the system heap 
for struct cobalt_thread (3616 bytes on arm64). This adds up to a total 
of 350725 bytes required.

This patch increases the default system heap size to 512k.

---
  kernel/cobalt/Kconfig | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index afa62d2..24f09e8 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -257,7 +257,7 @@ config XENO_OPT_REGISTRY_NRSLOTS

  config XENO_OPT_SYS_HEAPSZ
         int "Size of system heap (Kb)"
-       default 256
+       default 512
         help
         The system heap is used for various internal allocations by
         the Cobalt kernel. The size is expressed in Kilobytes.
-- 
1.9.1


