Message-ID: <50C73F51.3040702@wanadoo.fr>
Date: Tue, 11 Dec 2012 15:12:33 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH]  rtcan-flexcan: Add support for imx6q platform
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

This patch adds support for rtcan-flexcan on the iMX6q
Many thanks to Wolfgang for the original driver.

Regards
Thierry

Signed-off-by: Thierry Bultel <thierry.bultel@wanadoo.fr>
--- rtcan_flexcan.c	2012-12-11 10:43:58.066794062 +0100
+++ rtcan_flexcan.c.imx6q	2012-12-11 14:57:25.634571266 +0100
@@ -1099,13 +1099,40 @@ static struct of_device_id flexcan_of_ma
  	{},
  };

+enum flexcan_ip_version {
+	FLEXCAN_VER_3_0_0,
+	FLEXCAN_VER_3_0_4,
+	FLEXCAN_VER_10_0_12,
+};
+
+static struct platform_device_id flexcan_devtype[] = {
+	{
+		.name = "imx25-flexcan",
+		.driver_data = FLEXCAN_VER_3_0_0,
+	}, {
+		.name = "imx28-flexcan",
+		.driver_data = FLEXCAN_VER_3_0_4,
+	}, {
+		.name = "imx35-flexcan",
+		.driver_data = FLEXCAN_VER_3_0_0,
+	}, {
+		.name = "imx53-flexcan",
+		.driver_data = FLEXCAN_VER_3_0_0,
+	}, {
+		.name = "imx6q-flexcan",
+		.driver_data = FLEXCAN_VER_10_0_12,
+	},
+};
+
  static struct platform_driver flexcan_driver = {
  	.driver = {
  		/* For legacy platform support */
-		.name = "flexcan",
+		.name = DRV_NAME,
  		.owner = THIS_MODULE,
  		.of_match_table = flexcan_of_match,
+
  	},
+	.id_table = flexcan_devtype,
  	.probe = flexcan_probe,
  	.remove = __devexit_p(flexcan_remove),
  };
@@ -1113,14 +1140,14 @@ static struct platform_driver flexcan_dr
  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
  static int __init flexcan_init(void)
  {
-	pr_info("%s netdevice driver\n", DRV_NAME);
-	return platform_driver_register(&flexcan_driver);
+	pr_info("RTCAN %s netdevice driver\n", DRV_NAME);
+	return platform_driver_register(&flexcan_driver);;
  }

  static void __exit flexcan_exit(void)
  {
  	platform_driver_unregister(&flexcan_driver);
-	pr_info("%s: driver removed\n", DRV_NAME);
+	pr_info("RTCAN %s: driver removed\n", DRV_NAME);
  }
  module_init(flexcan_init);
  module_exit(flexcan_exit);

