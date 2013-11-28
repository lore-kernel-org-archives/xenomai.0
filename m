Message-ID: <529701A6.5010100@geral.com>
Date: Thu, 28 Nov 2013 09:41:10 +0100
From: Alexandre COFFIGNAL <acoffignal@geral.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtcan_flexcan: fix devtype_data initialization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

|fix devtype_data initialization when using CONFIG_OF and dtb file

Signed-off-by: Alexandre COFFIGNAL <acoffignal@geral.com>

|---
  ksrc/drivers/can/rtcan_flexcan.c |    6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_flexcan.c
index e97cd92..8f0e8d1 100644
--- a/ksrc/drivers/can/rtcan_flexcan.c
+++ b/ksrc/drivers/can/rtcan_flexcan.c
@@ -1055,8 +1055,10 @@ static int flexcan_probe(struct platform_device *pdev)
  		devtype_data = (struct flexcan_devtype_data *)
  			pdev->id_entry->driver_data;
  	} else {
-		err = -ENODEV;
-		goto out_error;
+		if (!devtype_data){
+			err = -ENODEV;
+			goto out_error;
+		}
  	}
  
  	if (!clock_freq) {
-- 
1.7.9.5


