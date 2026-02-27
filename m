Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC7361644
	for <xenomai@lists.linux.dev>; Fri, 27 Feb 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213307; cv=fail; b=QSWgcGxSTihEWEmsUf3HzGiLRqesyGqfGC2KwtI01M2hqjxbp13ePar+NNF2eS+4IjBRfUUp/bjT2smKY4zinAm7omuYMhUoJ5KH8TsGG/BrM+1+2GXk8zUP8a2Nr+34HST4sS7M+XZzK6jr7Y5qui9+Iy47QOHIY6hAAmceb1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213307; c=relaxed/simple;
	bh=h9jqFyfbz+s38s4CulSr/PECDMa1+9lRQZsvIAcX5aI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=NCjvLD0J83Bo/9s9Hbb2+PY/cjFowuH0jLTAQ/7QOQk7fLjsXsNhIdybuVFbHyM6L7WJfaZ43N/VXHOhcPJvYNZjYfSwGAEcV4C3l7T1PQTK3fwFWbde60htM4zAxz+lEkiSGubOjBMsvf8CcP371qNBeoLOGfJjXjMRTHwFptI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cs4ZqPKL; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cs4ZqPKL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se5MErytljPR2iDr88apugMRkkvE4M0ctFBOcmjnqP6/YiMQk8j4LcJFQrrSZB0UlNa+rEWImHC56n7KRymOaBBbAg3OfgRiQFIx2+cNlJKEU/buSVE3QyLozboXXyzuAf3bZcgmpZamKRAGxeg8cjOJ5ElmiA/e0M0YZVUjRF881wRUTEkh3Bk1dcZBzWNyVnx1twtXfvwQuSob9fN8Kwia5fAGYWed8duaSFkeSbsLSn8pUQvd32OtihFJRWnyNiUg8QgInEdhItLjj6lQAK6czswx5W9Ky/ApiyXNSP3dgRkI+52YbzigB/ZlxMd62PTzBrlI8EAcNkGOlTyRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l48LnmgVOdV+p9bvbf8N8ahAEj9MrZApvFP5cDSXrco=;
 b=I5/Yj0cDHFYapVJtMtCKu2tGDsqjN/BMdxIb2mE7xhCvRrBjVqIZaUKjJKfoQ87E1xe9fJ7XM9/rEYAUq4T4wtOpw1Tk/vv4wDiA1OINE21TlP+phsa37MbqK3CdlGV1ry7WqY6PcO4IwytE77OmNmJerL3xyH/kCkZoF9OYXe1hbNsXtqIOy4bK9XqequdVYBbO0GrXG+u0h/4Ob6FDthbxrGVSW3JZb/3pkn/Uoi6xE4NEFdVBA5ncoxqrBwEoTjb85sx+WzaYLi9tRPFUJnhMYuakM5GIVX9hBR+PgibsDS4XVZoF60/r2q0b6P3q1C+lIwFpp/AzL+wid8WI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l48LnmgVOdV+p9bvbf8N8ahAEj9MrZApvFP5cDSXrco=;
 b=cs4ZqPKLcSUJqPX0LJsCy6lYuclIl//Iu7ZjldeQ2yHfSbinSEAzxwU1SxB0lkHRsT15WwexY7WGj1oUNnysq5ZQYOyMBU+df1CsAOwuTwRIdso3utZY61U09df711fwBUQHcEWDUAw9klQU6TwxRbO4kQYZX8yu3yeB3IfYjbwmCdlJ9mM/Yvm+1xXudo5bIqBxgsKCUuikp+2ODCDuDwlou06RPi+kzHd9tEiSOGw9MPLlxS+N9KcbF2sjVixM21KXNEQqpvztx6D87UA8BeOvdb1Ut/8iFxTKKsZ0r6MKEcbIGwwRUzLEY/x4+prGY+rMc/EkwPD5fi2MKJVASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:390::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 17:28:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 17:28:22 +0000
Message-ID: <741e9423-0601-4b98-9255-b100b8cddfbc@siemens.com>
Date: Fri, 27 Feb 2026 18:28:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v2] Update releases of dovetail, evl, and
 libevl
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: f55e1f6d-0ae7-4f07-a969-08de76259b1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	/pYMaLkut7KL3C78PwN3qugRpt5KbXyW9rEL2I0JmBCr0H5I6E0lTUl1kUHVOh49NxwU0/q9J+drZgBnyWkaSXzrMZpBym7bRBd8eKSanOV/AorOh6VfbDfdGsaNB6i1Ls2KsqlqTbrA42StU2PKXkNwu3p7rDgXwi5m3AXV4M6jdy0YjSHU6/F+Iv+Lf6EyjA5F2ckM3vyU3uR7wI+IiXG9cKcJP+tiu4MXUrDU18s1frjy2e2zGJ0zCSkmhdIyA8F9bRdHzX+PE0e8anD/5A9Ob6EBWrq7SUyMt0m+8wKtCGaUtD2U8kSF/KTLBcbC8oZPjW7inpvkJsV5lrksKUDng510u1BrDQmbPp9PtbTdcLC8QIMUlF9VjqfBolB2jNp0IZhSC5DJwON7g2Kh+kton3/z+5pV3W7kDWmNDZaCy39NRV1VmF6k1GtiEP98x6cc89qUm1hCtyKVODkpgAHCCR/qlstOmn4msAVme90JBVZV5KtndlfLXDKhfXCrwROTZFuImThDeWKEK6AhgRC9ny2pcyyTOD/1gb/9drlVMdoV3wxdigUW440W+eI24igCLONNej5nqc2Z7ONbiA5/8pNu/n1EDSj8b35SQv6Hgt4Vl+9jYakqt2Qgu8+MQw6gr8GRZQ8RJ9PvkuvvfQHb5VcCFeNef6ELCEn2QMbZaoVG8v50mZ+VpK52gThRUzTFIv6fcXS6OgdmRqY0vZ1d23Y9QfHLgX7/yHYsHew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhHT2lPSWpLL3BVcDFqZEJpMms1Nk8yMEk0Rmc4K3FXZnlJbmVEQ09vdHVH?=
 =?utf-8?B?NkFzVTNLQXQyb2JTdkc4eXNjMmwyVDJlclk1V2RVRjF6d1gySXhLcmxDVk15?=
 =?utf-8?B?cVptRFk3T3NrVXhQeFVvczYrQXhBL2Y2MWFTeXVObW5zZllFdmcxSEJnUmhJ?=
 =?utf-8?B?REovQVgwZ2VBTE1GdTZNWFRkMW90VDdCS1RJZlpIZ0VwVDVVUjExZkNZTlYx?=
 =?utf-8?B?ZURvUXpZRjdMRUJpL2lJMEoreHI0RmhZdHB4TlJwUGl2K0kyOUNRU0NSRmtk?=
 =?utf-8?B?VkFwZWJYOEd6M1pjUXR3OU9nQWZrRjhZRDNJOHFlOHQwNlBpcXloUHZpeVNL?=
 =?utf-8?B?eGNhUE9WVVZHTy90Ym5NaDJMbEhmQ1YvQjhNaVVzbkpacmN2aGtva2JkVGFE?=
 =?utf-8?B?ZndrNEZuNEs5TWxBU0VFNFc3MzNWbFNHQ0R6cXhkU3dleXdSQUxKakRzK1py?=
 =?utf-8?B?d2FlSWU4elVYSmRadFpEQm5lUXlRckl5MUh6Y0FDdEFzbmRJeUcvWjZIS0xB?=
 =?utf-8?B?SzVYclkzMUxySldOMnJETUJRcSt6dFpOd0QveUJVVzhqd1NzMXJnelpYMkg2?=
 =?utf-8?B?bHVDWUJLMUFQeTJhYWptZFIvMWxlRFVCSkJ5ZGtEazZ1RmZocC94aFErOGFG?=
 =?utf-8?B?WlRuKytrdzBpVnZmR0M4TXdlSmpXNE5HNVR2NEF5Nk8rZE9vQUZsb3dJOFY2?=
 =?utf-8?B?WEZWYjFsamNJZTlwZTlZY2R5Z3ZRZGtxVjlMc3JtakU4U0JWVFRsc2c4Tkp2?=
 =?utf-8?B?NVE5dWRlMFBITi9FbjI4UXIybUVTS3YweVdMdnVRUHkzOU83SGd4cForelJ5?=
 =?utf-8?B?KzVkR1pVbUIraTR6eFJOTnhLYyt1blNXN1NXWDJiS2k0TVdoRnZPY2V6MnI5?=
 =?utf-8?B?R0RXa1NTRTNzTFF0elltMWVPajFINnpkT2sxSzlzUnM3TUxxdzRvKzBPTXcx?=
 =?utf-8?B?Q1VKRjlFQkJuUVh3M2N5NUh3QjMrUnltQUF6NWRUSDRFMElqVlBVNDBLbG9n?=
 =?utf-8?B?dWdqQlNUUWlsL2tTeVF3SFJ3WTF3US84YnVNVzQ4TzFsQlJQbGlKNG1DUkpm?=
 =?utf-8?B?amNxS2JlT0tscW9oWUpqS3UzYlVWUFdKdjdKQ1JmbnI3UFVZeGw3Y3Z3MUhN?=
 =?utf-8?B?c1QvYkNUSWlZaVczWnVhWUNObVl2eDQ0aHlId0xQbE1sK0UxdE5JQ3F2OTl3?=
 =?utf-8?B?NGRoUE5WZWFZa2J5eDJxai9WVG1KUUdvV1g3alViZFVJMDl2SFJqN1N4ZkdC?=
 =?utf-8?B?UDhWV25aTXNVZzZKMTNvNFBxaVN3eUpaRFBvcnVrK0RxY08zbjRMSGlGL2F0?=
 =?utf-8?B?aWpwdi9wTkFWSzJpeEY0aWJuUUxmM0FWL2xZTklXQVFoVE9ERi9OOWMrTXpF?=
 =?utf-8?B?ZGlCZmthR09RMXNrK3JoVG5ZdExFRUUrcFJ1NUNRalNOWlpJNnIzcmNWMnkw?=
 =?utf-8?B?UFRPOVhLeUZlcHJldW5XbFB5RTNJakYvc01nREtjdnFUcCs3M3FNSE9TUUxF?=
 =?utf-8?B?WnBUTXBCZUNmTURKcFBJZzlobExweXI1VzF3bnF1aVFuQmdVSjZTTXozeGN6?=
 =?utf-8?B?UG9oZTdvRzBSRmJpVDIxSGdQYXF2a3RwYWpvTGMwa2VjUHBIL1ZPcHlUclJK?=
 =?utf-8?B?M1duMHVxSURQSWpFWXlVV3hhaVlYb2U2cXJhNW9GUktGMEQwMGpoQ2ZzSHFx?=
 =?utf-8?B?RWVQbzlTZ1pkNkdKRWg0dG11MWxZcE8yZEt4am02djN5SnprTTZOV05EMVJ0?=
 =?utf-8?B?WDk2djh3Nm13VEEzQm5TUWt6dkthR1VBbktPNy9IMXhFRmhNOTJsNTlsSFE3?=
 =?utf-8?B?YXFpREpndUVGdkZ6Skk5S2o4SVBUNlc5VU9weUhXVlBqbGlZdFpYMFFacDh1?=
 =?utf-8?B?amdDSVpFSnd3V01nbzk3QXdrRjZUMXdwTmtQeW1jeUQ3NitNTHlKanZiNnBQ?=
 =?utf-8?B?cHJWdFNFZEdjWURZR29PREJpYWFPcVhhYWcvWGtFUWdyaWhEMktPbThySE1R?=
 =?utf-8?B?RTQwZXU0TWdPbVR2Vk12R1MrZkRHTk9pcWNHYnhZSWN5OURpeTVjWG1OOHlY?=
 =?utf-8?B?MUNWTmNhY1NNQVp5NWlKQmNrZTBtc3FkYWhVNC81aUlqdERrd3c0VFJ3Si9U?=
 =?utf-8?B?VklnL3lYRWJxVGUwbTkxRGU3Uzg4VW5TcDhuWS82OE5GZXlOUnpZK0hEL1Q0?=
 =?utf-8?B?aTBVUjZQMENkeDdLWEpHclZKRHJsbjArVkU4a1UwdmFzbzA2MDVGK1JncWJL?=
 =?utf-8?B?ZEdNRjU5ZXl5UkN4ak14bkVsejVtUG5pVU8xNTBsTktLMHcycTduelYyeFNy?=
 =?utf-8?B?d1R0MTFqd0pHK0hHY3k1dExnRGkyM2pUUVVycVdCYWt2MkpQaDZBZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55e1f6d-0ae7-4f07-a969-08de76259b1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:28:22.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJtFZgXf68W8kgkG9faBB7tekL+uYIaAyZZPSWIzEh9jQppSW3Slyj21CvyLc68M/Mvx/aWjBomvWxvPy9sZ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8092

From: Jan Kiszka <jan.kiszka@siemens.com>

Most notable is that 6.12.y-dovetail switched to a cip baseline now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - switch to cip in 6.12
 - more updates for evl kernels

 recipes-kernel/linux/linux-xenomai-3_5.10.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_5.15.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_6.1.bb           | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_6.12.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.1.bb           | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.12.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.18.bb          | 2 +-
 recipes-xenomai/libevl/{libevl_55.bb => libevl_56.bb} | 0
 8 files changed, 13 insertions(+), 13 deletions(-)
 rename recipes-xenomai/libevl/{libevl_55.bb => libevl_56.bb} (100%)

diff --git a/recipes-kernel/linux/linux-xenomai-3_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 04d0129..0fdf535 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.10.245-cip65-dovetail1"
+SRCREV ?= "v5.10.247-cip68-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 87e7a26..d84de49 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.15.196-dovetail1"
+SRCREV ?= "v5.15.198-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
index 49e584e..c35cdb1 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.1.155-cip47-dovetail1"
+SRCREV ?= "v6.1.159-cip50-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.12.bb b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
index c066037..c73e72e 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.12.55-dovetail1"
+SRCREV ?= "v6.12.69-cip17-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
index c0ae308..2efe538 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.1.155-cip47-evl1-rebase"
+SRCREV ?= "v6.1.162-cip51-evl2-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
index 380c2a4..7281917 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.12.55-evl1-rebase"
+SRCREV ?= "v6.12.69-cip17-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.18.bb b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
index 3182404..a1ddad5 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.18.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.18.7-evl1-rebase"
+SRCREV ?= "v6.18.7-evl2-rebase"
diff --git a/recipes-xenomai/libevl/libevl_55.bb b/recipes-xenomai/libevl/libevl_56.bb
similarity index 100%
rename from recipes-xenomai/libevl/libevl_55.bb
rename to recipes-xenomai/libevl/libevl_56.bb
-- 
2.47.3
