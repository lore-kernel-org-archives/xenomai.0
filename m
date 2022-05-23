From: Gunter Grau <guntgrau@bbl.ma.philips.com>
Subject: [PATCH 1/2] net/drivers: Fix out of tree builds for fec driver
Date: Mon, 23 May 2022 16:19:28 +0200
Message-Id: <20220523141929.2633409-2-guntgrau@bbl.ma.philips.com>
In-Reply-To: <20220523141929.2633409-1-guntgrau@bbl.ma.philips.com>
References: <20220523141929.2633409-1-guntgrau@bbl.ma.philips.com>
Reply-To: Gunter Grau <gunter.grau@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Johann Wiens <johann.wiens@philips.com>

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/drivers/net/drivers/freescale/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/freescale/Makefile b/kernel/drivers/net/drivers/freescale/Makefile
index fadab2e43..316d8c3c3 100644
--- a/kernel/drivers/net/drivers/freescale/Makefile
+++ b/kernel/drivers/net/drivers/freescale/Makefile
@@ -1,4 +1,4 @@
-ccflags-y += -Idrivers/xenomai/net/stack/include
+ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
 
 obj-$(CONFIG_XENO_DRIVERS_NET_FEC) += rtnet_fec.o
 
-- 
2.25.1


