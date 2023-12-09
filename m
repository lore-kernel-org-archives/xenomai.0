Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99991FCE
	for <xenomai@lists.linux.dev>; Sat,  9 Dec 2023 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rR3QKhf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU2mNUJlE2IASEGeZQvEjaQ/a7LkDlha3LPs57fcFPVRCOO9XUrs9Ivw0SoAoNoVSrN8LgQrhJjvp18WAoKTcImqUchEhXmrgWEn3Iv/0o4s2RK8vvqius9s1yvQBmy3R5HCr6TwaPutGxVDRAuY7I2dQBxefMOQY7WFU2X/JCAbUUMgJ2kCcvAFFIvL5usIzIGrvjQgVFeOPwY2iJSoWDwqHXd7xDmObvqKuTbEB81Iet+Z8hsZpb0EbHT7VkRCpWChIZAXk0+YKPmFrBm/QTUa1V6iHenjF4bcvdd/VCinkCz5u6ij6amycIwtO14IojFoYayjKInP20qeJJ3wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNeCjjfAjllr6ADSMIc9xNjZoRnBgSTjZp3/JRhWGVY=;
 b=OMkRA5a7MvlW1n9Zgxqh9EoWXn+tC601DE1zL4OX+5hFb84BwE9E+ON0eUohr1USIvmAUzDh8byFmpGHS7QDvr2kSpPZHBpjK3j0d6m9kFLpW9fj9QmeQRFsLABkjssJMJI0ux7+2pC+KhacenjplmeheumCkYSFMnXdCPjoPScHBkHF9gzcAJLmE72Z9/UA+QorfvYxpsWMFRtTRLt5Q5hFM8zRAYK7VuNaxDRJi9lI4pFFDfwtpV9nbmTR6l9AuMNV6RhQ8hDg3Sfm9wNu8NTIv8A4n84ihOXPqnblT9WGfG1Peb8H928CYXwVkrpOQIQ6Vb8v/WqAZgz2gERShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNeCjjfAjllr6ADSMIc9xNjZoRnBgSTjZp3/JRhWGVY=;
 b=rR3QKhf702PySSVf6Hlx2wn4yWqbcgpN7gnSh6S3TR4nzC4Gg9RMeUOx7db6jj190QrhNf44/U2s0SnvNrJ9Vjf0OROULBJBJmbMnZfQGk+77FFJgBpjbEGHB4ZWEQnCTMLAklN842jLnjeBbao+V5E5TN7EeR2NdmEudCt/0WKFxI5UiE47ttzJlHuWgCjHiPfPfNKk/PM2b8+rEzqwe/8m71UTXZ4wW5s2foXcm5sMc3xWd1iFJSnI24WR0zVSeYw3OAUeorbrCi7zZr6q5C5PqL1+1GAVB8ibPcK3/B6MPsScPPAtZg0gzqiXWgXPSzP4zI1otetk0J2Wa2Ys7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 09:04:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 09:04:24 +0000
Message-ID: <02919913-1618-423e-a7cb-43810e11a51c@siemens.com>
Date: Sat, 9 Dec 2023 10:04:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers: gpio: Start to switch away from gpiochip_find
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3860:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b82f46-253e-4cc8-4e23-08dbf895d727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7t2KTPXn7NTmc/mG54n9fNgmZbu9Yu9zV1N+B07KP5tdn0mg8kq6EcwYWWKLfekjAmYrBr6KIrHIRtt8GGIxUxu86sEhTKQI9lFED2rkfjsnwvuo8UpaB0dp8TFzoi2vuYlx1pOWRciywMh774Tb2DOKsvt+muJyODypRQC27YzW9CNS+NsOrrP4H/L9rxLY4hCgtA+qIx4hs9Di0n1Xg6Wb6kyHr4NmJJBKiAeEBYTOjmtbxOUbO6iC0febsLHVwxI3zFbCChO/e1BVUEWmLnUhGlL8vmhWCJK4vAGWe0hST045IKsC1ktKeRnpzIeLKtuteGqh2Oc90yVNKJ+uNdHOALJYh7vOCxpNt8BtSj3V6QmlB7uRDOjfryfk4cztinyOopq4pp92mexsQc44nlLr9rSy3FVOeJ10do4xymY9ei/hlQMveP590Efqxg6Ta6nNurWGzG8edtAnnRWaw0kDap2AyfxDsx8qL4dzBwtou/KEyEG2fu/1K5W1cBOlVF8E+5tX9mgLx3z95+HUasY1RrcgBHgjjnj45AgHoAp0FmPeZRTDSF05tft5pW/+JzLTSB6Ort47r3S0Tr8Fa/HBqEAVxmiZy1JhDylj9TW3GvbM4SbvY7bstFJYVaWVqiPi69+cqHKHlf/NWmY1rQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(2616005)(6506007)(6486002)(6512007)(44832011)(5660300002)(8676002)(26005)(8936002)(41300700001)(2906002)(478600001)(316002)(66476007)(6916009)(38100700002)(66946007)(86362001)(66556008)(31696002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXFLcUtCR0ZCNUc3Q2drOG5QMVk3RWZZQ1plOHpDZ0hZdnNxQlJkWDl2THll?=
 =?utf-8?B?ZW5tbWhqMkpHdnJlZkFnYnFHVGVoM1ZtUFhQaU9OOUhGa1ZLVEdPOVFtK0xD?=
 =?utf-8?B?QTMzaFJ3YXFxTkFxanJxWnV3QW9nNFRwR3hRY3RYQzF5R3pFWGppMXdYcTBU?=
 =?utf-8?B?T0JSaExDLzhQNzRXWUN3aGVDbjRWMnlxWFVCc3lZSzFmbmtzZUFpZWcxMlFl?=
 =?utf-8?B?QzhMckRuZXdqQ3YwWm0rTTNKMU1GM3hueHI3N3F2V2RGcldXd1Z3TThhTG9T?=
 =?utf-8?B?L2gxMFVGMFU0QTZqclBoYThtL3BmNGd3dlN4T1FUelNlbXQ5UzZLaks2dFRC?=
 =?utf-8?B?SkZpOUdBci9VNEsrU0NZSXZCcm1RUDJ1a1BlMWN0RURuRVovZndaME1tUXNR?=
 =?utf-8?B?L2J1MklEb3c0a3A1RFBEckhQdjFpQ1RZS2lmKzZLRjU1VHpjK29oRENPR3lH?=
 =?utf-8?B?cVk1MTdKSmFHQXh0V3U1TW5NK003dWNCM0M3UXpqbGdvKzM1blpDT1g3b1di?=
 =?utf-8?B?bFdZb2hQV21qU3VaRlZFTmpFb04zVHRFVTJqczlHREo5MjJhOHkyQnhXa3cz?=
 =?utf-8?B?czVKTGlJTHlEdHdVb1c2ZTlsUmxXWm83NzNQU1JmbUpPK3RNTUpscjh5YVE2?=
 =?utf-8?B?MEFtVlVCQkVPWlZvYlBwaXpjaG1oai9udkRMNTJpUmRhOTVnMjcvcG5BK29q?=
 =?utf-8?B?QzU2Yllzby93NzJsVmJQY0FqUlNKZjg1emNjdTVhODB2TlVxY1BMVWJicW5a?=
 =?utf-8?B?dGZFZGp6QkgwNXhrTlNZMUVDUlpvZnFueGxzMFd6WHlYeFhScmszTTdrRVdG?=
 =?utf-8?B?RHluOXo1aVhHdTNZV2h6bjBDSEQrc3REOGRCNHFuc3ZkaHk0K2V0b3pyQXBN?=
 =?utf-8?B?RGo3OWs3ekhjT01RbHJHNXc3ejk4RlFsczJ2ZEdXZFliVG5WSUIwYzl4OEI1?=
 =?utf-8?B?VG9qOHN5aWwxVGlQcGR3dWFZOXhVSER0aXNYQlBvSk1ZNmFjZWdNMzVSRmNS?=
 =?utf-8?B?UDdOdE9FTEhBbmF3eUtSS1V0aU1IMWt6MTBEelNDNVc2cSsvcU1ma09ZMFd6?=
 =?utf-8?B?d0NwNnVXWWdZTGwwTDdwM1MxTDhpWENndGQxRmZIZGlZc2ZlNmJZU0VpSUN1?=
 =?utf-8?B?cHp4YnIzd052WUI2bXdGc2hXSnJseFljZ2UzZkllQUl0S3VxaElHYzQwckQz?=
 =?utf-8?B?dklIMVRwZ2hWczZHRDk2U1ZXUHpXS29HOWZZcnFlbDhuS0s2ZjhXR1lqUG9Y?=
 =?utf-8?B?eGpZK3BZQUovM3FOYUdJcytOa1hvUDMwTG1acytZNEdpdnY2dzhScHoxZXJx?=
 =?utf-8?B?eG4yY1c3VTFML2hWMGdjZHZCUmVZZDF0eWFETVdtSE1MYk85c3puekorM1R1?=
 =?utf-8?B?cHZNdld6Qmt2Y01MaklqNGNoUXFjaE1RVzMxaThNTm9rZ3pPUWRvdXMrYUpj?=
 =?utf-8?B?R09JNzQ3a1dyYUF5b2pwRFA2Sk1xd0l3b2JHclFuWTBuYXhXOVd5cHQ4Tzdv?=
 =?utf-8?B?MVZScXJISngwQ2Ria0NOaUd6WDVNaWNCVUFqZy9sTXYwYVRYZHJVTVE1bVQ2?=
 =?utf-8?B?d3RIZzhydndFbXd0WjJDdFJHOVROQWtVMXVPRjFHc1h5Ly9xbFBjNGpFVzJi?=
 =?utf-8?B?VXBlcVRKREdJM3BRTjc4eGw1bmF5SXVsUXBmUEZYRVVzUWtITllKVndIOTBr?=
 =?utf-8?B?dmt5dHNSRkJVWktpOFhPSGNweXQ1MjlYZDhhWWVScWVybng1cWRmcVNYYWVP?=
 =?utf-8?B?OEZEQlpxY2J3eEFxV1FldXpEUm9XcVdvZlQzZFBrVWNOWXRKTTRzbUhSQXFu?=
 =?utf-8?B?Ly83Ung3dENtc1pxcll3SmFhOGtSTk9INEl0YllzL25CQnhBTzZwMXRUb0NT?=
 =?utf-8?B?RXhrNEREOVBMelVTTGdVSHZpTGVTUEsvQktoZVBmRW8yR1U3aGJ5dlVNUHZv?=
 =?utf-8?B?Z0M3NmcwQ3ZQdkd4TXoxWVVGWlpSY1o4d1VuY2xoQ2svdFUrRlhJbzIyckpT?=
 =?utf-8?B?ZU5nTkFBREU1WFoxTUYrOGJtbzZzS2VQTXNaMXN3dmZGUHdRbFRLR2k2VFhQ?=
 =?utf-8?B?UEpmZ1NxSGFXQ2ZxTTZtVi85VDh2bytKSVRTZ01XM2xOVmIrWDZQazBXT1Vk?=
 =?utf-8?Q?jLjwD2HFlei2KtHOJq68XSkS1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b82f46-253e-4cc8-4e23-08dbf895d727
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 09:04:24.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuqpDSrlhQNCyCMkZN5FGedxpy0hQcthMibdjLWtEzmjEuLYQnkAbSptdmMk1OHLvIqY6pSkoynS0ojrrzBqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3860

From: Jan Kiszka <jan.kiszka@siemens.com>

This was removed in 6.7 for the sake of safe reference counting. Do not
switch to the kernel model yet, just mitigate the API change. We will
have to rework the RTDM GPIO API later on to fully support this valid
step of the kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c  | 19 +++++++++++++++++++
 kernel/drivers/spi/spi-bcm2835.c | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index e12733466e..e41c640504 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -516,16 +516,31 @@ int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
 }
 EXPORT_SYMBOL_GPL(rtdm_gpiochip_post_event);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,7,0)
 static int gpiochip_match_name(struct gpio_chip *chip, void *data)
 {
 	const char *name = data;
 
 	return !strcmp(chip->label, name);
 }
+#endif
 
 static struct gpio_chip *find_chip_by_name(const char *name)
 {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,7,0)
+	struct gpio_device *gd;
+	struct gpio_chip *chip;
+
+	gd = gpio_device_find_by_label(name);
+	if (gd)
+		return NULL;
+
+	chip = gpio_device_get_chip(gd);
+	gpio_device_put(gd);
+	return chip;
+#else
 	return gpiochip_find((void *)name, gpiochip_match_name);
+#endif
 }
 
 int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
@@ -637,7 +652,11 @@ int rtdm_gpiochip_scan_of(struct device_node *from, const char *compat,
 			break;
 		match.parent = &pdev->dev;
 		INIT_LIST_HEAD(&match.list);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,7,0)
+		gpio_device_find(&match, match_gpio_chip);
+#else
 		gpiochip_find(&match, match_gpio_chip);
+#endif
 		if (!list_empty(&match.list)) {
 			ret = 0;
 			list_for_each_entry_safe(h, n, &match.list, next) {
diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index e8df8fe7e0..2d50b86080 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -446,10 +446,12 @@ static void bcm2835_mmap_release(struct rtdm_spi_remote_slave *slave)
 	bcm->io_len = 0;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,7,0)
 static int gpio_match_name(struct gpio_chip *chip, void *data)
 {
 	return !strcmp(chip->label, data);
 }
+#endif
 
 static int find_cs_gpio(struct spi_device *spi)
 {
@@ -487,9 +489,19 @@ static int find_cs_gpio(struct spi_device *spi)
 
 	/* If that failed, assume GPIOs 7-11 are used */
 	if (!gpio_is_valid(cs_gpio)) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,7,0)
+		struct gpio_device *gd;
+
+		gd = gpio_device_find_by_label("pinctrl-bcm2835");
+		if (!gd)
+			return 0;
+		chip = gpio_device_get_chip(gd);
+		gpio_device_put(gd);
+#else
 		chip = gpiochip_find("pinctrl-bcm2835", gpio_match_name);
 		if (chip == NULL)
 			return 0;
+#endif
 
 		cs_gpio = chip->base + 8 - spi->chip_select;
 	}
-- 
2.35.3
