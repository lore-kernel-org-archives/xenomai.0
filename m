From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 29/31] Kconfig : enable fec for ARM64 build
Date: Tue, 11 May 2021 18:05:33 +0200
Message-Id: <20210511160535.26580-30-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Jean-Baptiste Trédez <jean-baptiste.tredez@alstefgroup.com>
---
 kernel/drivers/net/drivers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index c36533479..60889aa70 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -116,7 +116,7 @@ config XENO_DRIVERS_NET_DRV_SMC91111
     depends on XENO_DRIVERS_NET
     tristate "SMSC LAN91C111"
 
-if ARM
+if ARM || ARM64
 
 config XENO_DRIVERS_NET_DRV_AT91_ETHER
     depends on XENO_DRIVERS_NET && SOC_AT91RM9200
-- 
2.17.1


