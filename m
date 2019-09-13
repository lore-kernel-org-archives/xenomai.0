From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 11/11] drivers/can: Convert to module_pci_driver
Date: Fri, 13 Sep 2019 15:19:00 +0200
Message-Id: <280643e3dd929d59e734cc0343791037b8b2db67.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
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
index 26f81ecda8..bfd7f088c1 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -355,15 +355,4 @@ static struct pci_driver rtcan_adv_pci_driver = {
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
index ca85b1d4e3..e63bb7d597 100644
--- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
@@ -388,15 +388,4 @@ static struct pci_driver ems_pci_driver = {
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
index 97163a2228..b5961fa906 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -340,15 +340,4 @@ static struct pci_driver rtcan_esd_pci_driver = {
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
index 3172c78436..2837a7d7f9 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -294,16 +294,4 @@ static struct pci_driver rtcan_ixxat_pci_driver = {
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
index 3f9e40b53a..85288906f4 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -351,16 +351,4 @@ static struct pci_driver rtcan_peak_pci_driver = {
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
index 3ede0faa95..5df4d927dd 100644
--- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
@@ -594,15 +594,4 @@ static struct pci_driver plx_pci_driver = {
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


