From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 12/12] drivers/can: Convert to module_pci_driver
Date: Fri, 13 Sep 2019 18:46:55 +0200
Message-Id: <b8d510c708ebf963b7066b4303e75ed84fc98c8d.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/sja1000/rtcan_adv_pci.c   | 13 +------------
 kernel/drivers/can/sja1000/rtcan_ems_pci.c   | 13 +------------
 kernel/drivers/can/sja1000/rtcan_esd_pci.c   | 13 +------------
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c | 14 +-------------
 kernel/drivers/can/sja1000/rtcan_peak_pci.c  | 14 +-------------
 kernel/drivers/can/sja1000/rtcan_plx_pci.c   | 13 +------------
 6 files changed, 6 insertions(+), 74 deletions(-)

diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index d33e79b3e7..4637ff742a 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -358,15 +358,4 @@ static struct pci_driver rtcan_adv_pci_driver = {
 	.remove = adv_pci_remove_one,
 };
 
-static int __init rtcan_adv_pci_init(void)
-{
-	return pci_register_driver(&rtcan_adv_pci_driver);
-}
-
-static void __exit rtcan_adv_pci_exit(void)
-{
-	pci_unregister_driver(&rtcan_adv_pci_driver);
-}
-
-module_init(rtcan_adv_pci_init);
-module_exit(rtcan_adv_pci_exit);
+module_pci_driver(rtcan_adv_pci_driver);
diff --git a/kernel/drivers/can/sja1000/rtcan_ems_pci.c b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
index 57e0f36762..ffd91235a2 100644
--- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
@@ -391,15 +391,4 @@ static struct pci_driver ems_pci_driver = {
 	.remove = ems_pci_del_card,
 };
 
-static int __init ems_pci_init(void)
-{
-	return pci_register_driver(&ems_pci_driver);
-}
-
-static void __exit ems_pci_exit(void)
-{
-	pci_unregister_driver(&ems_pci_driver);
-}
-
-module_init(ems_pci_init);
-module_exit(ems_pci_exit);
+module_pci_driver(ems_pci_driver);
diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
index a383d1d372..538c0c8ac3 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -343,15 +343,4 @@ static struct pci_driver rtcan_esd_pci_driver = {
 	.remove = esd_pci_remove_one,
 };
 
-static int __init rtcan_esd_pci_init(void)
-{
-	return pci_register_driver(&rtcan_esd_pci_driver);
-}
-
-static void __exit rtcan_esd_pci_exit(void)
-{
-	pci_unregister_driver(&rtcan_esd_pci_driver);
-}
-
-module_init(rtcan_esd_pci_init);
-module_exit(rtcan_esd_pci_exit);
+module_pci_driver(rtcan_esd_pci_driver);
diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
index cb5169c80f..ca3556adc2 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -297,16 +297,4 @@ static struct pci_driver rtcan_ixxat_pci_driver = {
 	.remove = ixxat_pci_remove_one,
 };
 
-static int __init rtcan_ixxat_pci_init(void)
-{
-    return pci_register_driver(&rtcan_ixxat_pci_driver);
-}
-
-
-static void __exit rtcan_ixxat_pci_exit(void)
-{
-	pci_unregister_driver(&rtcan_ixxat_pci_driver);
-}
-
-module_init(rtcan_ixxat_pci_init);
-module_exit(rtcan_ixxat_pci_exit);
+module_pci_driver(rtcan_ixxat_pci_driver);
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index ad7d46bbb2..50f573ee6d 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -354,16 +354,4 @@ static struct pci_driver rtcan_peak_pci_driver = {
 	.remove		= peak_pci_remove_one,
 };
 
-static int __init rtcan_peak_pci_init(void)
-{
-        return pci_register_driver(&rtcan_peak_pci_driver);
-}
-
-
-static void __exit rtcan_peak_pci_exit(void)
-{
-	pci_unregister_driver(&rtcan_peak_pci_driver);
-}
-
-module_init(rtcan_peak_pci_init);
-module_exit(rtcan_peak_pci_exit);
+module_pci_driver(rtcan_peak_pci_driver);
diff --git a/kernel/drivers/can/sja1000/rtcan_plx_pci.c b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
index 61ae6a2b66..30255626ec 100644
--- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
@@ -597,15 +597,4 @@ static struct pci_driver plx_pci_driver = {
 	.remove = plx_pci_del_card,
 };
 
-static int __init plx_pci_init(void)
-{
-	return pci_register_driver(&plx_pci_driver);
-}
-
-static void __exit plx_pci_exit(void)
-{
-	pci_unregister_driver(&plx_pci_driver);
-}
-
-module_init(plx_pci_init);
-module_exit(plx_pci_exit);
+module_pci_driver(plx_pci_driver);
-- 
2.16.4


