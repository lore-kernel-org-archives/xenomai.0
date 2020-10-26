From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 07/11] drivers/analogy: Fix unintended fallthrough
Date: Mon, 26 Oct 2020 12:04:53 +0100
Message-Id: <b6db45b61f1def8e4ca39f388f90802f75f1d0a8.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Apparently not desired but likely harmless.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/national_instruments/tio_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/analogy/national_instruments/tio_common.c b/kernel/drivers/analogy/national_instruments/tio_common.c
index feb6f41ca6..bcce728eb5 100644
--- a/kernel/drivers/analogy/national_instruments/tio_common.c
+++ b/kernel/drivers/analogy/national_instruments/tio_common.c
@@ -1666,6 +1666,7 @@ static int ni_tio_input_cmd(struct ni_gpct *counter, struct a4l_cmd_desc *cmd)
 	case TRIG_EXT:
 		a4l_mite_dma_arm(counter->mite_chan);
 		retval = ni_tio_arm(counter, 1, cmd->start_arg);
+		break;
 	case TRIG_OTHER:
 		a4l_mite_dma_arm(counter->mite_chan);
 		break;
-- 
2.26.2


