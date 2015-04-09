Message-ID: <552698E7.1080501@siemens.com>
Date: Thu, 09 Apr 2015 17:21:11 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] ipipe: Protect ioremap_page_range also against
 IRQ usage by APEI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>, Niels Wellens <niels.wellens@triphase.com>, Xenomai <xenomai@xenomai.org>

Commit 261a3fdbae added a check to prevent NMI invocation of the range
pinning function. But APEI may also call ioremap_page_range from timer
IRQ context. Therefore we need to extend the check.

This addresses lockups seen on long-running systems with APEI GHES
enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Jeroen, Niels, this should truly and safely fix the issue. Please give
it a try!

 lib/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index f5331c0..9b8e8d5 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -88,9 +88,9 @@ int ioremap_page_range(unsigned long addr,
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	/* APEI may invoke this for temporarily remapping pages in NMI
+	/* APEI may invoke this for temporarily remapping pages in IRQ or NMI
 	 * context - nothing we can and need to propagate globally. */
-	if (!in_nmi()) {
+	if (!(in_irq() || in_nmi())) {
 		__ipipe_pin_range_globally(start, end);
 		flush_cache_vmap(start, end);
 	}
-- 
2.1.4

