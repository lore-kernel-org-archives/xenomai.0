Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585DDDD4
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 09:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbzdolXblLQoh7eEFROQxvdA5igyUE5CHwZPpX5yY8bbSROLtA+IwdGd79QV8e+bmRIYJJq8G7Y3S51zRe+pmtepZqtz17lm92fZzkM6WmkPYG7YNBC20jpY5Crf/HMkK6UFotD9IkqOy8/0bX3MvH3qPgDDn1nJRJFYZRvAGmpG9scn01XuudRLVCzilpTQ8o7n7hkFVCoWhaQiJ1ca+/r3sL+0OznrC42hOQq/PL+iWBpMbGxHVnJ1qMHvl4NVYp62IDSEnz9EBSyUCunZtamACMMbpHKVtdKRnF7oWS3ScrJ/+cCTNBN69R4zwB/73YIXIFS3UkAFu2G4UF6FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIqeYpw310tft+WP0fI5ExrlODt8JiSyU7ISP4yUw4Q=;
 b=eTwvJbGynwmYTJTfEeD/NuB/AGacjul2mVqaBgcnEI/4G1IaqtatsYTzmFuSBwgDepYEA3puKR5tsCeZrkupHi6NlMrzowFCmnpZPBdJPodZqS2Zob9tIL11NEpA/YzfiB4JH7o9g7AwjncwaRH8wvA8t8Kfes2/XQZLGlyh5oqE2e1NZ0A5Hqu8pV90DCTd001Jmk8F+lj8KOXMgY5Aev0WNdo1XJZ7zMIoZ1jRcoypINtZ1YWnS4rU1y9N2UP29GW87AcG7JMeGOwrc17mMggsfyarv4u2wYVn1/ZcjHfL9MujbLkYS6TybxmXKHbG9YEah8GjyStvD+nkKwItDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIqeYpw310tft+WP0fI5ExrlODt8JiSyU7ISP4yUw4Q=;
 b=jpDfvwn5YzeBxBDZEt1vVcKVM7DnRrkWN54Bf687X9gx9S3ACCsHNTJdgtxhXcamthEoeubanLkxpFWcQYZYc/p835jGe6wxs0mPQifVreJFNBqUNJZTPKMi8aBR9vk9ZZGa0lA7rPi99AXXZ7XbcaiCv0o8vXu3uTQvdFqR0BAtNDrlDaDyDV07O4ql2cyrOQzGT3XhQZIJdTL+tfTTJ4ftd4i6fFy9/d+SQEeS4lCG7sGAqcPRBUSFzhD5aLO6udV9uYQjZHNx27x/bwxEjmK8xqbCN5KVR2qRV0POWi4IeSlOViyNHKJHlnxN4C+QQeo/gLoHNeQlh3hrfp4Tsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Sat, 23 Sep
 2023 09:52:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 09:52:37 +0000
Message-ID: <16c73c36-f278-467f-903e-8579232ce16f@siemens.com>
Date: Sat, 23 Sep 2023 11:52:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/net: Avoid enabling/disabling AER explicitly on newer
 kernels
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 29aad40f-f350-497e-74dd-08dbbc1ad17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MtUvEmZ+5nF6ZoRTAw+eSOXd8aOBXFQvV5lVgW6LOBsutfWP3w3I9OWAqqEUr5Qecx14sypGSLKUsVxUCBZPGRSMMdANPYEbafstXe+Jk8n6fU4HrVqZE8pzBqVtfcxXVzi1z5ho7WkBNVkEszyDQlJd303ethffs1cFHzz4OO5HdtGngG1iaGRbOmmG0duYCbpqEvky2OyFDJ+k6JyslC/xssgVB/snDx+LBUNVIGMDlZcQTNNgFgVqEqoZc+C96tG9QSeHFCLT00ysAeOrANnMW3UevWl4S1+qRnDgppFojx6JrV6s1dEc2sDEv8YnrwErjIP8E+44TJyBNtImoybsT+E1i8eWy0uZgwXv2mmEzHkbw446ATXywhTE8NXqm4Wp1fFY1acseJONBhJCWdiwXmFABfgVMZoJuCgVvkjZSlVYqvCEhy5833r1l+yEuWUP/+brem4/kKeNHsvBk7dYvm/oza8+w7UwUQ9GHtNkpRotZjHFCV6Fu+ETy/93Fy9zqh4RnrNdZ2ktZOrRWjA3jCnqIUEABo/cCg9TXO0XJGgNQp2aVZFVhdI339DC6Xmwqy76EqJ/GE0fdAELaZo0EB5Uf6WI974NRTWhy1DzvPOd5p8Hs/tLQCznWBg1zYEU/cX7MiPLg/j+eBMJGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(26005)(6486002)(478600001)(41300700001)(6916009)(66476007)(316002)(6506007)(66946007)(66556008)(82960400001)(2616005)(38100700002)(6512007)(86362001)(44832011)(8676002)(2906002)(31696002)(5660300002)(8936002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1VZVFRTQUIrM1VJQy9HRGVLTnhqZHkrckxUcGw2cjlGb2xYdHU3dmRPQmJm?=
 =?utf-8?B?anozSlE4eklrUmU5MllxVmw5eTJwOEsvUHFDY01rTndSd0hLdnFNOC9aNDZt?=
 =?utf-8?B?RldhaFNQYWczQmlyK2VGU0R2c1NxMFJCRld2SDNtQ3k0bmEwWlpMaGIrZVli?=
 =?utf-8?B?bFNwVy8rcUZnNTdETUU5d0UvQzFtOG1SbldocHlvK0pBdndBTCtDRTFnN1lT?=
 =?utf-8?B?UDgwd2l4T1ZzUGRCaktjWEhTYjIyRUNpNVVqQXFKQkhsckcwaWlCVDNFZXQv?=
 =?utf-8?B?bTEzRFZ0MWUrT21QU211a1pKQlViN0xGcDZzYzYyQXVqdDNZUXFJS21xQTI3?=
 =?utf-8?B?VUdtNFhsN0pnMjVGMjFvYVZmWFFnM2o4SWdWcStSaEdNOEdmOXVlQmtwSEhu?=
 =?utf-8?B?QlRyMFZGOTU4K25mOU8wYm04YWQrUVFZQndUaEh6a1FNM1l4ZU1LMjhWU3JO?=
 =?utf-8?B?Uy9Vak0ybVVkTk5vYTJlM1NRUVpIeE1YVXozNGFCaXZSeXFKY1V5ZE0rbEhB?=
 =?utf-8?B?OWdEV2ZUYWZYejdWVnhOaUlWcWZQalhQbXVxdnkwV3MyeXdyUzcybnR0c2hH?=
 =?utf-8?B?blg5eVlBQnFDNDBtTXg0ZW1sMlFJUkRqVVBuSU1jYTdxbjl4VzgzYmYzYUhD?=
 =?utf-8?B?S05NajVhSDV2QzlEL1I5eUg0WG1hM3lPSUlyNnJXbURseTNtODNQemVLQkRS?=
 =?utf-8?B?ck1SWVBLbUxrenFuZTh2TUdQekNxdDMyZjNXbkptZmtSODMySjRqenV3aGUr?=
 =?utf-8?B?NFlrelRvb0xiQUZ5SGlEMXg4L2drUG9DQk83Zzl2Ynh4UGY4SjE2aFJxQnJq?=
 =?utf-8?B?amVuaEY0S25ZVTB3VDErUHR3RlNmeWRtRGUyRGVVNk5ZUkg1dnZPNEE4SkZO?=
 =?utf-8?B?citWY1djZXVBUkV1ZE5BUHNPTW9rNi8zQnAwK1hDZXh3dDhTV2JWTktYVjFW?=
 =?utf-8?B?bFdRbit2eUxVbGgzdHdIaVl5THVxZnZIZi91QzBab2poRlZEQzBhczFrclkv?=
 =?utf-8?B?NldxMTZDVkx5dVp3MFVweGwvWFUvRVEyTXpiKzRoSCtEd1JKKzZyV1dlWC80?=
 =?utf-8?B?R3FJQTVzZDFlaUhSaFR1QUErcmhvZlBGR0YrZE1vVXN1UmNSRzJiTlpCeFBF?=
 =?utf-8?B?Ty9rb04ycmdaY3hyMzdrSkVncVA4L055MWJCbXFYemhSWWlUbzJNdnh3RXJF?=
 =?utf-8?B?dXc5Z25QVUYwRDhubzk3VFRzV2RsNVN1MzVUUjk1NkJXT1VJUXdaaGRKR3NG?=
 =?utf-8?B?MHR1NUgrL2Y1dkhBZm9SdHU4NXpVbkYxUkFtR29EU1V5eHBLdFQzbDg0UkdV?=
 =?utf-8?B?MS92MmgwRnB1Q0hDRytMZmo2emRUS0sxMWh0MSt2Y3BJMFdIZThpSkoyYVFS?=
 =?utf-8?B?aU5ObjBsdXFNYUdGYUk2SXVMejNzV2diMTB5cy83b0tETGs3WWZQbW92STV4?=
 =?utf-8?B?QUxreHVSQVIzR2U0bGFGK2RjRkRYS2Zua0h3OTZHdDFwOUlJQ0ZsU3NZL2NC?=
 =?utf-8?B?cTR3M0E3UVRLejJkWStCMEVNZnc5S0ZhQU1jWE5qV0hHV20ybGpMUnd6bUZP?=
 =?utf-8?B?V0hNZDhFN3kxT1pDSjRoTk9hSU4rbmU0OS9iT1F1RHVTZUdnaVhLclB5WkhC?=
 =?utf-8?B?N0ZXM05QMndKV3NPdE4vanRnbTdvSGZwR1MyV1VQNWkvSE1MUFhPUVVIQ0RN?=
 =?utf-8?B?eEZIc2wyZXhwOWppY0ttcUJNN3ZTYVRUSXlneDZvejBQZEtCN0xhdDlRY20z?=
 =?utf-8?B?M1RUZHhsL3ZLd1VFYk9zd1lLc2NJUThtcVFEQVBxb05BSVNGeUZuQ0lDWC9k?=
 =?utf-8?B?OUtYblV1bXVtT0J4MmlxekU3NWp2Y1l4c2tiWVNWcTdiUWRHWkc3bVhFZHp2?=
 =?utf-8?B?ZVkyaVBsQnB6YmQ3MmZjdG5xbnNEQWttUGhzYkJUVGxYbkhpdDByR3lrUjZM?=
 =?utf-8?B?NFRoSVZxSnVPRUxmdHJyYWtFL1ZZN3RKZFZFYk5WZjlkdkxHdkkvcTFkbExF?=
 =?utf-8?B?NjVra1dvclBTa3BWWlFNaVN5NlpRVnlqektZN2dsdmJQVUNHYnZPbnBUQnZm?=
 =?utf-8?B?R2FUck5NbEpjM3RGd204Zng4ZXhxb2R5TWcyTithVVlHMGl4WkNqeStOTFJB?=
 =?utf-8?B?UmpDcThNa21ZM0pwZjdSbVNRQmQyUWozYk45Ujk2MHRDMHZkWS9HRXdVRnAr?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aad40f-f350-497e-74dd-08dbbc1ad17e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 09:52:37.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIazxqt/2Xc9kp0bj9vMx8EwV6mRhDDigXbPQd29FtZE9+f4XcDvzWSC2ed9X04pacBu7ETwHrS7Ltg34PhYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7692

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now done automatically, and recent kernels even stopped
exporting the original functions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000e/netdev.c | 4 ++++
 kernel/drivers/net/drivers/igb/igb_main.c  | 4 ++++
 kernel/drivers/net/drivers/igc/igc_main.c  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index acb8dbdafa..ea2f65d129 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -3931,8 +3931,10 @@ static int e1000_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	/* AER (Advanced Error Reporting) hooks */
 	pci_enable_pcie_error_reporting(pdev);
+#endif
 
 	pci_set_master(pdev);
 	/* PCI config space info */
@@ -4257,8 +4259,10 @@ static void e1000_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	/* AER disable */
 	pci_disable_pcie_error_reporting(pdev);
+#endif
 
 	pci_disable_device(pdev);
 }
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index d0f647c63e..15a4e9591f 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2029,7 +2029,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_pci_reg;
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	pci_enable_pcie_error_reporting(pdev);
+#endif
 
 	pci_set_master(pdev);
 	pci_save_state(pdev);
@@ -2465,7 +2467,9 @@ static void igb_remove(struct pci_dev *pdev)
 	kfree(adapter->shadow_vfta);
 	rtdev_free(netdev);
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	pci_disable_pcie_error_reporting(pdev);
+#endif
 
 	pci_disable_device(pdev);
 }
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 5b11228b05..1373412287 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -3692,7 +3692,9 @@ static int igc_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	pci_enable_pcie_error_reporting(pdev);
+#endif
 
 	pci_set_master(pdev);
 
@@ -3922,7 +3924,9 @@ static void igc_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
 	pci_disable_pcie_error_reporting(pdev);
+#endif
 
 	pci_disable_device(pdev);
 }
-- 
2.35.3
