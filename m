From: Tormod Volden <lists.tormod@gmail.com>
Subject: [PATCH] e1000: Print mac address on one line
Date: Sun, 11 Aug 2019 21:07:05 +0200
Message-Id: <1565550426-4788-1-git-send-email-lists.tormod@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Tormod Volden <debian.tormod@gmail.com>

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

KERN_CONT is not multithread-safe but in most cases this will
show up nicer than it did.

 kernel/drivers/net/drivers/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 491b828..329c69c 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -918,8 +918,9 @@ static int e1000_probe(struct pci_dev *pdev,
 		 "32-bit"));
 	}
 
+	printk(KERN_INFO "e1000: hw ");
 	for (i = 0; i < 6; i++)
-		printk("%2.2x%c", netdev->dev_addr[i], i == 5 ? '\n' : ':');
+		printk(KERN_CONT "%2.2x%c", netdev->dev_addr[i], i == 5 ? '\n' : ':');
 
 	/* reset the hardware with the new settings */
 	e1000_reset(adapter);
-- 
2.7.4


