From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sun, 17 Mar 2013 11:56:46 -0700
Message-ID: <oqr4jdyggv.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] [PATCH 1/2] rtcan_module: Fix tx_timeout buffer size
	inconsistency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When formatting /proc/rtcan/sockets, tx_timeout is defined as
char[16], but a length of 20 is passed to rtcan_get_timeout_name. If
tx_timeout for any socket is infinite, this causes snprintf to zero
outside the buffer, leading to stack overflow and a kernel panic.
Make the tx_timeout buffer 20 bytes long instead.

Signed-off-by: Paul Janzen <pcj@xenomai.sez.to>
---
 ksrc/drivers/can/rtcan_module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/can/rtcan_module.c b/ksrc/drivers/can/rtcan_module.c
index 3ebc333..f270f65 100644
--- a/ksrc/drivers/can/rtcan_module.c
+++ b/ksrc/drivers/can/rtcan_module.c
@@ -165,7 +165,7 @@ static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
     struct rtdm_dev_context *context;
     struct rtcan_device *dev;
     char name[IFNAMSIZ] = "not-bound";
-    char rx_timeout[20], tx_timeout[16];
+    char rx_timeout[20], tx_timeout[20];
     rtdm_lockctx_t lock_ctx;
     int ifindex;
     RTCAN_PROC_PRINT_VARS(120);
-- 
1.7.6.5


