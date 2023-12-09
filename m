Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286879FD
	for <xenomai@lists.linux.dev>; Sat,  9 Dec 2023 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VjMKq0E3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoiEg7WxY2MMQ6rszR8WE+bxPDZefwXG0yCaoVJ6EFCTF0L1UyqBcAh4bv/pKH+Iojt9TMvjYV6Y3/hkBxINnuwe68nOmYAjDWsHyi+BCUr6P9J9XHull6q3FUMP/QdS+WnTPp2W/kzNa6g9bebnERSiptjmzcPf3+pgyAMGM4P3TDTNkALMb6X33bRNs8yGzrNybNitXRY5gUTo6e5ELXlGMBLoLdPp3qdTVOvPtLXxnsank3V2KL3h5RjmmA4W2+YBoyfnbqez7ns/jmpySrMcKRcpEpbwtlwFewKzbu7lB7PoynWFOYj/DK5kpPqDeDa3ayjc2nC3CL40WhA9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKew3lLj7nAQ0fWN5cq+LbGR5i1Pa3wHv9AGGwDqKMk=;
 b=C5hsmcDGH0UZmHSiUttYA+cG5D4gv9HoZS9y29Ko0guXWgikzoV8CNLNz/CSVyH8jjahG7LWkpB3z/eYVaHW9hlJSZkRm3EdJXwi7IPY/KSBWt8dqQdg3/mVNEdWN+7xTb5C+4qM3G+I14LijyjPEEnyGTJ9JDjw5Tjw/PjG2HO/nOE3DIiRS6XNSCcpIsS7ARlRdrn8fQXdHMKRjW/sbauVso4ydLR6wu7woII6rXwjGoPGMe+JoelWgaYBkJdJnDNLrpb0M26CWgwkVUWXUVoTdIujDgC76Q+R47ZAJf764xsnCKfvEnep5qltXxb96/kM6s58hGVw/V7+9XCq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKew3lLj7nAQ0fWN5cq+LbGR5i1Pa3wHv9AGGwDqKMk=;
 b=VjMKq0E3+W+uBNXz6Q1TGv6uIusK/5/Yf+jNyhOfOu0ArnuKE3/2AMHW5pHo09TYGxa1oCD0tAb3Mzy45gbPoiLWWSZnt1cZXaSKdXHSGpnlj8j+HN6qqMowHtYCncnnZoLfoymeF/vcqCSwuw2ebMDOTEUIm4+Mub/FHkpxYm8ZF6NKhCPquwLXr7a4GDqDkL9KQW+EKtt58/IhzbI6mz62nHnT2MbgQee3kkd7SyPKQAlTRZN6Fa1YYdJ/RSyNufyB8ZsPGDDJe2UdXId5qEIccN+n+z08C8xaUoLEr8+AOq929DC/WvDJiAauXVt4kfg/Bl8KEe3AIEpcR7B1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 09:03:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 09:03:00 +0000
Message-ID: <90fc15bb-312a-46ac-8064-edd3fcaf8562@siemens.com>
Date: Sat, 9 Dec 2023 10:03:00 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail-6.7][PATCH 2/2] pinctrl/intel: irq_pipeline: Fix hard
 spinlock conversion
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
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
X-MS-Office365-Filtering-Correlation-Id: 5ceb1329-c95d-4d35-b1f9-08dbf895a51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qhz91z7nyEgJXQ2Tg8zkpBYRkNz75OzJ8+P+UjIQmwimWGpKLDa/kWZrblzXhc4G98uDloJ13PNtzJ2cVcxpRLPeIOfIhMjG8jYYfTIScWiW0hi0ypDYu2yPI3/qso8MH8wMVc3z9y/xjTYLGs7NJ02BH67hC1oEPfj8SpKNK1rViJvidV6n07fikJc8l207bYh7AGSQON0Kn3qw9Y0x7RG/oDYJQZMZOGT6bGmFGYE7fO+b8ZQTF0TzP2SIhA3f9/Y02sc7NnSomqJMri8EV1n7iDwDiOQ3iW7EyYfCjxcN0AbQd+ynJelAkJqwHL4eFKsoI3LdxfPZmZprLoRV2PnNH7mmWJu2kWEOjz5wm9CX5K+q+6YpjHIbidiFfwR9XA2jCusCEIZhNykY3DtCbDy6RWrKwn8vezzvvgvFo2D0MM842Autbw0OgedI++Dq0WhsRvFIQQmb1DQNkaVu8WPbr0wFnRN2mloWtQJnKG0s3SHR0HQCKbmOkKqGC+gKBiBtHgYbFw/j2jQJjeM9KEJIAZbhG08FKqpFhJYdXxp1rZPmyCWCOXGLB1BGCwWKbtnPJydpoHnTZVeo/k2olYUY/2y+DvpYqnpJGvQg3VzGgDFiaIs3sS4o6ArtbppmDfFVLhlD5puW4bUACcCiog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(83380400001)(2616005)(6506007)(6486002)(6512007)(44832011)(5660300002)(8676002)(26005)(8936002)(41300700001)(2906002)(478600001)(316002)(110136005)(66476007)(38100700002)(66946007)(86362001)(66556008)(31696002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGNxOXUxbkhtZklpK21lcW1ZeGcxVmJ0VkdkZmZaMWRxbUM3R2dZb2JUQm11?=
 =?utf-8?B?N1Z3Q2RKRWdFNG1pQVJzL2hGZHdqUVdycUs4MzFBM3NYZnI5UURkL0pKWS9Y?=
 =?utf-8?B?Qi82NkFEdmMvNGdvS1dxdGIyMXNNWEtvcS84QmZIZXdmT25TVm9vZzRVdUZN?=
 =?utf-8?B?a2pFR0ZXYzFkK1NpNHdHVUh3emFVVFlreXo5QmtRTWtWKzhyOVdGeWc2ZWdp?=
 =?utf-8?B?UGk5SmxtNlJNTzJkOGJhVEpic3VzekRaQWhXMHRNczl0cGVqV0pGYTJMd1Jy?=
 =?utf-8?B?cjlkRHdrZldiemJacisrSXE5OUNUY0JORDE0VzV6MU9CWmF3Z2RvSmlCbDZ5?=
 =?utf-8?B?MnJhL0ZqRTluL1BRM1hRUEJWZjBWMHBnREhGMWtSVkFWVzYwV0R1TVNvM01H?=
 =?utf-8?B?K3ordWFGT2Z1TjBsZHpyd0x0ZEZ6K0hkWlNtcG12cnBEYVdMZFNYNUIrUXdG?=
 =?utf-8?B?RXRaQkNwOUVtdUlVS1NCL0tPUFVKM0RrU3hic2hZaHVHMFg4a2RZSk5MMXBx?=
 =?utf-8?B?MVl5K3VJaUZjcnhKVmZtV3QxQlh0anBmZzFxaEdKQ3VkQ2RjamZGaEJUUE1i?=
 =?utf-8?B?Vm01SkZzcDJGcHUrU2JhUVZ1VGxIVW9velE4YXVwR1h1VjhwTCtPUks4MnJJ?=
 =?utf-8?B?bklkbno4VVFRYlBJeG9rQjdhcWd4aUU0OTBTNlNCeU96bkUyMm1jRDJ4WHh6?=
 =?utf-8?B?dElFL1VtamdXYmxjQTdvRlRmL0xEc3d6TkNOc3NQVlkxOVhaL28rcUhNOXZo?=
 =?utf-8?B?aWUyNlVaN3BDc001enQ3RFdwQjVGSUtqdkEvZUhPbEtUZ254SmNvUE8zOVlJ?=
 =?utf-8?B?T3ovaW5Lb1M1SXNveis2TzJLRUdxN0VCbGtDZW1XR0srNnVIaTFJak1LNTl1?=
 =?utf-8?B?Y1ZNUkJQRFVtM1pLdHJpcjFtWHF6aEtxZnNGeXRpQVJVd3pqRDFBczJnMVdu?=
 =?utf-8?B?Vk56QnJyQjdCNUJibzlSRDdkNE42YUVadTl4azB6NkR4Mk54dVZqUE9MSmV4?=
 =?utf-8?B?b2x1MUtlK1ErUGFoNnVmQlhyYjJJaXlWUGZqMi9pU213VDdqM2RTUjNOZmlH?=
 =?utf-8?B?ZklvWEIxRW1CZW9lYS9ubkpSMFZUekUwYWVFQlJqQ0g3bmtDeWwyRGFvV0Y3?=
 =?utf-8?B?T2lPZCt2MUM1TFQ5dkQ5L3M5TmVCN0ZSVDdZV3FaQ2xBZEV1NWJsY21UWml1?=
 =?utf-8?B?bytQMVJoTkEvTnBFbGk0NEU2NlJONTM5djFobVlyNUlxbGlOQnhDSHI1NW8x?=
 =?utf-8?B?QU5BODg2R3ZqSU1qT2crLzZ2WEpITnE2dXRGaGwxSzFJOFB3MGt0WFlTVDZX?=
 =?utf-8?B?UmxQWEFacnJUOE91YktkeG1oOG9RclhscmpndWpCbnFEMDFaSXNFN0hOalEx?=
 =?utf-8?B?UU8rSEJwVTIrYjVPb0IyMmN3NDBGSnRaZkpOM0dMZXBjN3ZSY2t6Q2EycjN2?=
 =?utf-8?B?NytnZUVnNkVBdklucnUzd09NNkdFNUlIYkNSWlk3TzU2ZmlzajlyWEdQTDVX?=
 =?utf-8?B?ZDFNZ3d3ME5BcTByOUdaSWRCdis1SlJLWHZtMytGNThMaHJ5bktzT1pFanV1?=
 =?utf-8?B?NEM4SG1wdVlHS05SOTd6MGViYU4zWjk4ZTBVMXJWWjBQV1hnZ1B0U29qN2tV?=
 =?utf-8?B?eDZBK0VVUDl3RExIQUFEeGhVbmxFWndzVGhvQUluTEdMYkpQdHNaZmJ2UFR2?=
 =?utf-8?B?NUhweXZaVlowb2VTNlBMWmlCMnV2WE5DaWFxQ0svMnF2S01wdjVQNGlSTU5H?=
 =?utf-8?B?YUxYWnV5dHptSUtnQzUxZXV6ckRwS1RHR0F4Z2ZtTDF4U20xbklicFNaWnVw?=
 =?utf-8?B?aXk0Ym1DL3c4WjY3Rk9zeFlrRFMzdUZjbkVFQzFSVjVtdVRRc0lwR0hxZUxj?=
 =?utf-8?B?TVdKVXdtT3BrMkV4WFJlQzZpenkySExnU3YwbDJHcm9yckFWQkxtVVVzemlF?=
 =?utf-8?B?bHVoSjFTYUNnZmRTOXNxcjE0c1JLNWxoMjlzRmdLOXIwQ0E1b2l0V1dRbUUr?=
 =?utf-8?B?RGF0bWFwdlZ6ektMa1Nnd1NXek1kaE1XbTJZTDJtcWcvUHM0MitMSFNmQWlx?=
 =?utf-8?B?TXdYRExpV1FuK202SEYwU1Znb0hrZWtvRUVadlhGcHgveEFBZUFQTEJjdURV?=
 =?utf-8?Q?WwnSqWb/HDu5rjSdw3C0Kt0ka?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceb1329-c95d-4d35-b1f9-08dbf895a51c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 09:03:00.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fu0SczDZHy//d3lvGtlWBANQuNEIIduHLeKwFQUfbbAdzWJh8tvzC9CoGOcANqNbPqteVZ2dNX74hZU5qtcxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3860

From: Jan Kiszka <jan.kiszka@siemens.com>

guard and scoped_guard cannot guess which type of lock is passed to
them. We therefore need to call explicitly for hard spinlock guards.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 8f9e6cd8a2b4..0f3d99fd2914 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -629,7 +629,7 @@ static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	u32 ctrl0, ctrl1;
 
-	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
+	scoped_guard(hard_spinlock_irqsave, &chv_lock) {
 		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 		ctrl1 = chv_readl(pctrl, offset, CHV_PADCTRL1);
 	}
@@ -668,7 +668,7 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 
 	grp = &pctrl->soc->groups[group];
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	/* Check first that the pad is not locked */
 	for (i = 0; i < grp->grp.npins; i++) {
@@ -744,7 +744,7 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	u32 value;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	if (chv_pad_locked(pctrl, offset)) {
 		value = chv_readl(pctrl, offset, CHV_PADCTRL0);
@@ -793,7 +793,7 @@ static void chv_gpio_disable_free(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	if (chv_pad_locked(pctrl, offset))
 		return;
@@ -808,7 +808,7 @@ static int chv_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	u32 ctrl0;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0) & ~CHV_PADCTRL0_GPIOCFG_MASK;
 	if (input)
@@ -839,7 +839,7 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	u16 arg = 0;
 	u32 term;
 
-	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
+	scoped_guard(hard_spinlock_irqsave, &chv_lock) {
 		ctrl0 = chv_readl(pctrl, pin, CHV_PADCTRL0);
 		ctrl1 = chv_readl(pctrl, pin, CHV_PADCTRL1);
 	}
@@ -919,7 +919,7 @@ static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 {
 	u32 ctrl0, pull;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	ctrl0 = chv_readl(pctrl, pin, CHV_PADCTRL0);
 
@@ -980,7 +980,7 @@ static int chv_config_set_oden(struct intel_pinctrl *pctrl, unsigned int pin,
 {
 	u32 ctrl1;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	ctrl1 = chv_readl(pctrl, pin, CHV_PADCTRL1);
 
@@ -1101,7 +1101,7 @@ static int chv_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	u32 ctrl0, cfg;
 
-	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+	scoped_guard(hard_spinlock_irqsave, &chv_lock)
 		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
 	cfg = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
@@ -1117,7 +1117,7 @@ static void chv_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	u32 ctrl0;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
@@ -1134,7 +1134,7 @@ static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	u32 ctrl0, direction;
 
-	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+	scoped_guard(hard_spinlock_irqsave, &chv_lock)
 		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
 	direction = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
@@ -1176,7 +1176,7 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 intr_line;
 
-	guard(raw_spinlock)(&chv_lock);
+	guard(hard_spinlock)(&chv_lock);
 
 	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
@@ -1189,7 +1189,7 @@ static void chv_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwirq
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	u32 value, intr_line;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
@@ -1241,7 +1241,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 	 * read back the values from hardware now, set correct flow handler
 	 * and update mappings before the interrupt is being used.
 	 */
-	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
+	scoped_guard(hard_spinlock_irqsave, &chv_lock) {
 		struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 		struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 		struct device *dev = pctrl->dev;
@@ -1333,7 +1333,7 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 	u32 value;
 	int ret;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	ret = chv_gpio_set_intr_line(pctrl, hwirq);
 	if (ret)
@@ -1405,7 +1405,7 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+	scoped_guard(hard_spinlock_irqsave, &chv_lock)
 		pending = chv_pctrl_readl(pctrl, CHV_INTSTAT);
 
 	for_each_set_bit(intr_line, &pending, community->nirqs) {
@@ -1596,7 +1596,7 @@ static acpi_status chv_pinctrl_mmio_access_handler(u32 function,
 {
 	struct intel_pinctrl *pctrl = region_context;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	if (function == ACPI_WRITE)
 		chv_pctrl_writel(pctrl, address, *value);
@@ -1709,7 +1709,7 @@ static int chv_pinctrl_suspend_noirq(struct device *dev)
 	struct intel_community_context *cctx = &pctrl->context.communities[0];
 	int i;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	cctx->saved_intmask = chv_pctrl_readl(pctrl, CHV_INTMASK);
 
@@ -1736,7 +1736,7 @@ static int chv_pinctrl_resume_noirq(struct device *dev)
 	struct intel_community_context *cctx = &pctrl->context.communities[0];
 	int i;
 
-	guard(raw_spinlock_irqsave)(&chv_lock);
+	guard(hard_spinlock_irqsave)(&chv_lock);
 
 	/*
 	 * Mask all interrupts before restoring per-pin configuration
-- 
2.35.3
