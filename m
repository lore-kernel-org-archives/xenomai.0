Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD680F
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 06:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/1iu/v/BzajBXfQfJn6Ve+HeM1XWH9570OVE/PGb9cNCKCKxN0nWgprTrFQsfDd/ocrJ/ggtalIcAHQR5Efevd7ELRL8dGfA9untrNkHOMNR1nncpwcwdWev3FmIYrakYwGKbxyCPuDU7IiON+7kKHeE74bYAacx0WF86q1xWkJw3niN+aP5wkYZkdyhsWFPFSfD7fAYRi/5c6T+fiuXRyIyH/zLO2cmPAfptAVwI/+5rI1ptD25q65y1qNHu5RtsQlhLXnHteOVkrRyf7f0XjcUf0ipk3sw1f4muVhzNNhMlWQoDuoxZOOCYtgN77eSNVMuCn3CNCJeyXEONiKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+f8Dsh4Mdu6z2OVZfnfOKSRQiW/H6nJtWpNqQs7l4U=;
 b=Bwv9ewzSYrT91R4BCdz1wgdJtZemz236Gi1CHQK7M/Che2ywswlLK3LtRS4ssUsJy5lFNikXtocXDxfp70HYYjxcPtaWIgzxcy7EKYSW5HNxwGYwWscNZLOWK/cW+SKoXV8YDyob1ZSsBpYksEy4O10+adXINp3ZLdtKAFfcMp8MweuJq3mSXwsyRGQEF+8e54qENfrTKn/mvfXhyUJ7RJC1fR52cnHHnefNuhjJcukULdiAuDPUydzrN9XDtdKBZpKG/Ww8ChrKMXw4euLLrB8QO3GuwboVI/sdPHRPztn84etmwNbfz3Vc1pUKBAsEjGTZvPYOGC9dizzVxOx8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+f8Dsh4Mdu6z2OVZfnfOKSRQiW/H6nJtWpNqQs7l4U=;
 b=N0gslnMZ13EZdPEpRH9cwU0bXXo1x5VUKyYVd/jQfOVyBjIVSUh7fM3DYZHoY5Ubyqm0BDewbYuIwv9Q57gWJvDu59LIkOMcvwnfL/2Qk8FJOcQY9dxrUxdCDxC5BlhSslJbtdCDLxugi9I6T+znc4mh5XiM6pk/Kb6OC0RNT+r3Tk28KfDZkPa6If4Ocql44H048GzNn1uQLUnqG1tmwHH0/WfSfAhyi7KZMGTM2gMCCn5yNMgWwzJPb2JvG83GCtKR/FvOIccTSszGFHPHE/Rts8XqvrHLL8wPzvJkFBkwSN+s4iy2KxWC9FybJlo2K2cgEKEpc2yYyqt4lVYB7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:58:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:58:03 +0000
Message-ID: <fcc7da6d-da51-6eb0-a91c-4a018529db23@siemens.com>
Date: Thu, 5 Jan 2023 07:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2] rtdm: Account for class::devnode signature change in 6.2
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <1922d6df-c8cb-0c4a-692e-4c43fe407fac@siemens.com>
In-Reply-To: <1922d6df-c8cb-0c4a-692e-4c43fe407fac@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6d67ad-ecc3-4aef-79ef-08daeeea30ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9aBjEK8+4/tbOPw40BNxkPHwkmDvCXvB2QTitkeDYj6r463zM9KttEeAlKHQ0CTtM7N7Kj1LJE1MidpxaeeZUuk7UXRpKx7XSePOnEt4+Tf5W7x91UmP13w5qQfDuCYPZlkYkzx7jf6hwDcyZNugye7aABfCwW90/Nua59z+MGYhzzYnsheAMB/xR7V3RsYqrK6AvN9H+Pu4KB6nhh6AaINyUwkB/b5iXm1dRVkHSzt2cPp0YPcUWDoiO4RgLoDj8KAmTrs5EfYqhzmemIlMbd86Zv9ROMNmYuUEUC5lJSmjxaXK2F5WyVaQYYKiHXok8nEz5D+FpsppQhiNLItMvgy+HvEOYHW3Z71bUP7jJ8LyMzSpRykPeh28flaev4x6Cc7hBSWCG/c5E8K2KD6XysHiDQ2SPlHb+q0rzlE97WkoBTA30JxY+tle+da09fAFGr00SfoXFUcCOqpmppvtWdQlkxdGAkSHpDloB1xTetcJvkL7nsNwRnptzDF135dT/G0KtakeWnMtuRyWLNNntCA/xrzFZaf1cbrv/WMoKOa+/KK1g9WSYLjHGgXW+xjLPS56KMZ5eI3sLCkyrZE5216GTpK9rsCC4ibwwKkwb6CLEKk8O+rKMp5/7nDPJEkzkJwFnUoRF+W9K60UFl36G1NrcHygaMyOtzimlBcLOnwUVXN+XLjRkHFZ9seFgmLVyqwIXhmMkk3XDBw4e6S+DdFGEPh2pDMmQirKhXjryw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(36756003)(6916009)(86362001)(316002)(31696002)(478600001)(44832011)(6486002)(5660300002)(2906002)(66556008)(41300700001)(8676002)(66476007)(6666004)(66946007)(8936002)(82960400001)(38100700002)(26005)(6512007)(186003)(6506007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmVxK3pWZjRNOVhoYStpekcxbzZHUkNzQlU0MElYVi9kQ3dpdHJocTNaM2Vi?=
 =?utf-8?B?ck82U003aGdEbVhWblR0NFlNN3pQaWlPNmd5dzB5eWE4WXl1MWJhd3pKajdZ?=
 =?utf-8?B?UUI0UnJqWlVuYXd1V2g2cDZFaFRibkc0MFlZMXpIZnJBaXJ4cElRaFZHMXRw?=
 =?utf-8?B?Z0poME9VVTJxbGFPOFE4c2krTU12MVloZ2FSYW0rNXA2alEyem5GTW9yK2hs?=
 =?utf-8?B?UmJlWDBSaldFNkZlNUJVTk95Wi9VUnRjNTNpaDFjVVQyMmF3NnBrYjRua0FQ?=
 =?utf-8?B?S1N5WDArNURDOWhudDF1NlNkaXQ0WXA0eE5HL01pazUrQUo5SWR6ZFE2K3o2?=
 =?utf-8?B?MGFoRGYrNnhEYytNZis3SnJuZ1BTQ0t6YTU4OWo2SUxRTnlrOHlwWHNZNkQ4?=
 =?utf-8?B?anR2Ni9UVUlOT2lpNG1uSmVYSDZ6akxxQVpGdE9TYkJCY2JIQS92akFOZHFC?=
 =?utf-8?B?cnhwNlkwa3JTME1yRTIzcHROZUVIRFI1Z3YzWHdiUC9HL2l4UHJWT2w1dkZ4?=
 =?utf-8?B?ZFpnbGVhUC85ZXd5NFlBcVRNbjEzdlc4cU45YXdEclpjSGdLZDRpVHlCd21s?=
 =?utf-8?B?UjRHSmJNaThkQlhpZ2RwVTlBUTMvdThHY1RiYWR4MWZ2NmVGTkNkdnJjWmhl?=
 =?utf-8?B?dERNZDNwTXlkME9RdWwvLzJsU1EzOHp5ajR6WDVNeEVHVWlidVZIQkdaM0Z6?=
 =?utf-8?B?Nlh3RGFDZTJ2V1pZN2UwZGdSNGtuRkZkZ3NDOXZ5WUMxQnRJU1JzMXh4QSs5?=
 =?utf-8?B?Y0Zpb3duM3VzcXRERFZIcEk4bWVYdlFKNFJCY2JmWG1JMy8zVzFQOUZGSFpE?=
 =?utf-8?B?aWlEcG1mUWJsTVJnVGV0YkVGdFNYUVh0SnVsUzNqTWd5NDlIcVR5aGhWcUl5?=
 =?utf-8?B?MDY2dkE1SFF1Wnl1MjdaMG85Q29VMGZsdFM1SnVqZFFidHFnQWswWkgxdlpI?=
 =?utf-8?B?cjFVb1dTQ1hwRXpXWjhhdGd1OGZnZk9SUk0rd0hJRmU0N3VpTTNnRUxCVm85?=
 =?utf-8?B?ek41SVRxTG1ZanRWc0JGM29yc2JQT3liWkdNMFJPUU9qNmk5R0w2b0tOR1Vx?=
 =?utf-8?B?TGYzRjFDVUJyb01XZDJrNkR5OTR2N1U4S0tDNGZtYWpGOWZhaHpFa3l2cGxH?=
 =?utf-8?B?YmswMWF3S1lraUZROGlHNmtidDJQbUNvb09ObWoxcmcwS3dSMW9lVE9zcWpI?=
 =?utf-8?B?MFQzdE9rUjYwcTNhRTVmbXU0NEtRYmEvajlCS2YySVdmcEdoU1pFUkJpR2FQ?=
 =?utf-8?B?czUzNmRxTUxhMWNlRTM0OTZMVUZabXhyUDJJMGxqTFRwNW1sY2MvcDYxTk52?=
 =?utf-8?B?RlNUMklPaWtnUDBxZjYwQnRacXcwN0pPNGE2UU1rS2hDeGk1cERZSFAvNEwy?=
 =?utf-8?B?ek9RT1UvWTlEMGJpWjdsYmdsRVJ3Mkp3cWRRVWVJbW8wOUlsRTMrMnE5N2dX?=
 =?utf-8?B?U3R6VEQ1Q2FJSnFrMGhuVysyZVN0L09PM3htTjlrZS92d1lRTDhmV1RKdUkz?=
 =?utf-8?B?Z2tDT3VNNUdwMjB4TngwV3hPLzZ3eEN4RWFGWi9xTGNYQ1FwU1gxK3Zjb0hC?=
 =?utf-8?B?bndZcC9oVStZNUFOV0JVcmlKVTZuSDM3Y09VRjZ5ZFA3c0R4ejVvV1RndDBH?=
 =?utf-8?B?ck0rTFBIbXhwY1FKZTkvU0dUc3RrdTdIQkdtWlRZdVZCVG0vSVVZTDcvSWZs?=
 =?utf-8?B?cE9YREZVRUhXRVJRL2p0YVh3UkRDa01IM3RSZHp4ZVdGY3dUdm42T3N0dVFW?=
 =?utf-8?B?d0hDaHRlWjBOdlhMcHhObHh1UUdTRC83NXljSnN3bm1KZmRubWp3Wm1HTVho?=
 =?utf-8?B?b2J6bTk4OEVnbUZsUmRoUWVtNWFZZERIazFQYmVpZ1FudW5tUjhvL3FRcGtk?=
 =?utf-8?B?QXpOTnRUTEROak1EVkJab0gvRk9ZVGp2d2ExSit2NmxWM0lwWXUveEprd3lP?=
 =?utf-8?B?bVNVSTF0dXpHemRwRTV1cFMzYWtNalEvTjQzQS96OUkva2JKS1c5ekltSkwy?=
 =?utf-8?B?ZnZFR1lrVnNET0tnaE9JOGhpZ3JhcVk3N3BtWm4rWEpPZmRxZVludGRBeXJG?=
 =?utf-8?B?NHZCRlhpaEtyYks2cFVEaExOOS9UOVZ2MzU1WGRBQjFxOUVIYWFwbDJvOHBM?=
 =?utf-8?B?TVlqbTMyUmMvcExNN1RKQmtYc0VsWHhSZDJvU1M4NkFadFgrM0t6cUF6cGp5?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d67ad-ecc3-4aef-79ef-08daeeea30ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:58:03.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d57jam+Xr6ESy0q3HVaWUa9nUW4li7fwk5avNK8D69taQVekvPYYi/XJ+GKYwIW1ubV3PKwmFTTX/+j/AO54Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6017

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - there were more spots...

 kernel/cobalt/rtdm/device.c     | 4 ++++
 kernel/drivers/gpio/gpio-core.c | 4 ++++
 kernel/drivers/spi/spi-master.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 12155157a6..33db21e63b 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -137,7 +137,11 @@ struct rtdm_device *__rtdm_get_protodev(int protocol_family, int socket_type)
  * @{
  */
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,2,0)
+static char *rtdm_devnode(const struct device *dev, umode_t *mode)
+#else
 static char *rtdm_devnode(struct device *dev, umode_t *mode)
+#endif
 {
 	return kasprintf(GFP_KERNEL, "rtdm/%s", dev_name(dev));
 }
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index a054328f3c..e58bce1616 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -399,7 +399,11 @@ fail_name:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,2,0)
+static char *gpio_pin_devnode(const struct device *dev, umode_t *mode)
+#else
 static char *gpio_pin_devnode(struct device *dev, umode_t *mode)
+#endif
 {
 	return kasprintf(GFP_KERNEL, "rtdm/%s/%s",
 			 dev->class->name,
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index cffeaf087d..ccc50eedee 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -338,7 +338,11 @@ static int spi_master_mmap(struct rtdm_fd *fd, struct vm_area_struct *vma)
 	return 0;
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,2,0)
+static char *spi_slave_devnode(const struct device *dev, umode_t *mode)
+#else
 static char *spi_slave_devnode(struct device *dev, umode_t *mode)
+#endif
 {
 	return kasprintf(GFP_KERNEL, "rtdm/%s/%s",
 			 dev->class->name,
-- 
2.35.3
