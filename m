From: Gunter Grau <guntgrau@bbl.ma.philips.com>
Subject: [PATCH 2/2] net/drivers: Remove ARM64 restriction for fec driver
Date: Mon, 23 May 2022 16:19:29 +0200
Message-Id: <20220523141929.2633409-3-guntgrau@bbl.ma.philips.com>
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

As described in commit 04fab252f5d2ec3fe47be266f94714c3dda624bd, the
fec driver was added with the intention to have it working on an
i.MX8 target.
But i.MX SoC specific quirks are also handled already since the driver
was originally ported from the Linux kernel.
It was now tested on i.MX6 and i.MX7 also (raw packet socket only).

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/drivers/net/drivers/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 3a90dd8ab..ecbad2cd0 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -101,8 +101,6 @@ config XENO_DRIVERS_NET_DRV_MACB
 
 endif
 
-if ARM64
-
 config XENO_DRIVERS_NET_FEC
     depends on XENO_DRIVERS_NET
     tristate "Freescale FEC"
@@ -113,8 +111,6 @@ config XENO_DRIVERS_NET_FEC
     For built-in 10/100 Fast ethernet controller on Freescale i.MX
     processors.
 
-endif
-
 source "drivers/xenomai/net/drivers/experimental/Kconfig"
 
 endmenu
-- 
2.25.1


