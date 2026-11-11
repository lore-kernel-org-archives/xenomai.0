Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794401926;
	b=ItBNkh6UlV9sWtFuD+aJVRCBCDUJoYW9B4xPlVUvZuDuIAhkTSljXOv+L3SXvUG8kNt4
	 NecPnweKzqsv7Lf0xMbnMPSXiUXNqTt++4ZDYFGMrOT/7IOfLxPvCkC7edzZ5hfSB05qC
	 ki4IgZUqnX/wzxhHfd9SWmXCX4TqZU7LGf2/jbNiFkuxIvGHl4+Zu80YGKo++AUx8cpHE
	 STFDQ8AvKBf3rfrlNVBLylEfiKcVEmL8JOkvbbNotlIVeougRNKspUEBXvVeemKlFdWPW
	 uOybe0iYwkjRwuFUu5/QiobshOV4EGjMR0Jbr91+ujg6RiH1dxM8EkpLjFCgrrbWPiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401926;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Content-Language:To:Cc:Subject:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0FuZ9EZ3Q+ldIhkWkbGUS/MhPJ7dkZeYjEdNm+rlrXg=;
	b=4hmfMsbH53IempObkoX3gIN+wpdN8b3iQtK6G+ymMsvPDz4dD84Ld/3oOGMkItkg0PT4
	 /aKuLmnLxF02rXoFS89iHJyz8I4dBE+I1PfQ8KpuZcl71Ih5pVfORr2I9SvQW4M6sAAHD
	 CJEnFrGv7n9lvvQM3dv15uXCH98UHJyxc4zyVZbXPOviBE8G1AJiU/poXtazJCuLcYnkj
	 2R8d0pmPO4l1MLo+rV2cC5AwfVmsHT4QSQDO/J/1J0gqC0i/xLaL/6mlpzDeKv86cDPvi
	 lfS+Av7HgKvSi8jB7TLJ4hiAGgup9BOfe/OEzI8P6+BpjVt7Vzg06Bll/mXbivk88tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=nZjO9Hkx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.33
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE3606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09CE3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=nZjO9Hkx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtTm3VQaupJzbeXEQHIytTlzVbLxfrnq/oJxjhpiUPvoeLFo0iPDO2rol4M7GmzCeihSX35WRa4dHtoV4jQZrVByBh+jgDKTXQFYUoTACcvDNTUonkLozefYdlKBTKR5BXBLJHUf0UhQA4irY7x3LdlCreVJ8SszYwNoTWLDXI5Rwf2wtcOy1m830an36pPRGmw2zq6wXdxboXh95Vh90RZYHvJ6eJRRRj5JzLOtuT+wie27Wst+fCsY6itPkm7ZDcZUn+b5zGOuMfmKXRofsyBJzVjAOCMExWh1weMi+mxwbee8TB3zWNQX9noxZcAhPQr9RPAmsiLKTk6jS+I5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FuZ9EZ3Q+ldIhkWkbGUS/MhPJ7dkZeYjEdNm+rlrXg=;
 b=eBLGI2YIWf7x4KG9cw5eQXadVxlkdTizy5KFykwfljCW+Mc27vD5hTiTWC8c9aFr6Eio4NGUbFd9h+TKo4xe7Rm7H6nrEezgVgwyUb57py2orteqo5VPkvwkZl7sE9exZfo+YxBsSTwpHy05CFlGoGWGEXdPxMj+lwt4D+0AdEeWOEEr7emxdPOyxQt6+TuhzEsFGBOq38HfErvp2/7ldwTOEOAdOQ/Oz3Z6zs0d3o5XRQnH9YkPrHlN4aCcSZfZSCbed8hYgUR+J7AB/taAcS+mLAeRW9tDw8ruv5BRGBcZ9Kbx9wRLA6pdlEBdp94RarzW/QZsAfAZOdqwqMWqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FuZ9EZ3Q+ldIhkWkbGUS/MhPJ7dkZeYjEdNm+rlrXg=;
 b=nZjO9HkxCC/OdwDYpSd1wAC9y0lKKpt7StgjLRMaeU4AiX/b8udJIxaqc9T/FcNocHcMYWAgSmQLmsFYxDnPaU9hS/3f+F6DPQRvN8YpvZf07l2748Fx8nkKuONGWP2/5fD+BERqqJW7etQnE7Qmln+n/2brvXlyPpI2IDqP4COJ/8QVp+tZxXP2PD5IGMLbs1u+YHdZcz2qgBLbopaZHMITx4lj/DHy/Y3BBKqL9efmVkCeAedOJwf6YXKWmecQUmnKCKWyp+3WvlcIu9els5x1JEUWN8mv5LTzCdG2xyI7gEp0j2Y0EtC9ynWxoFhlKXLXczMIvVVKvp7m26nVug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9500.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:30c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:58:43 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:58:43 +0000
Message-ID: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
Date: Wed, 11 Nov 2026 13:58:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: local_irq_disable_full() in x86's __bad_area_nosemaphore
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb406b6-6725-418a-123b-08df3ff383d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|55112099003|261009223027099003|10067099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8WqcsEbsQfKprJWTMW50SvOeq6ehmPf8QcBe6dwi0h9QYig+BFCVDSaDJjCUHAr3TDaf6fqCA5EikFmk9Zfn5rk/THfeqmgqkEE4J7+1pk+CDN9NzwfAQYUFyPwxoay3idLehlgcbjFeLfKcZnropemLjiWf53d/2McBObtKP/HmwaUKmVDxao6tOdiXBwJFDZ1+kw3s4zTbn8jyciZYWHvu7MJS0KTe2527ySaPCK8fwPm+b4PM3SuO2XZuxJ0X4haU+Bs4czn+aQG8I2T/U6/Fo8mRBLJKDVJGgyW4qd1YDYeum9dAYKReEDKIOqiuNICSBITfg6o/KCcKQ3v+L82+UzbmUXU9IR5qeXIgiTTKWreXLDeUMrJWPT8jh7gAdrFNfUnpJc3NXzClbdupl+Q9VxwzlXbysaB4ZM50WPBzeCw0k45h5qF2LGUwxS/NzgHDaas5E3XQZduWPShZJKPZ/JF7vQQ/fiFeIUh+inv76NbTNp/cT1ZcVwksYVryKK390W5uVmBihnNSGuFntH4ZBeXTV24ff/4RmhCYl9SJhWbx/n8jOwGXytc6b+RI9sOzc/w3PBwPlaVxVMWLzWUYTcTH/bluUZ/KDY6Q1P0ELpIHeaEc8PsIqwH7wuUKl3BdzjmxIgfONu7fm9nqQUXehjBnFeqYlOWv/effoi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(55112099003)(261009223027099003)(10067099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm15c3p0SENxNFhoeXpPdjdRRjRKOHRMTjBFTGpSQXNhZk9kUUk0WklyajlP?=
 =?utf-8?B?Z1hlcU54RHRiVjhsb2ZjRTVJZnJ0MEh2UXB4SnhGbHFKYjUza2dVRWdGbFI5?=
 =?utf-8?B?UkNHYU1QdGFpczM2Y0d0U2oyUFpzeTZQTXN0SlhXcmdoRlZ2bk56WWVPOEFM?=
 =?utf-8?B?RXBQakZERzBERTcrWHRma2FEczZ2QW9IMUI2SXRENUVMZWV6d1ZrMXRzTTBy?=
 =?utf-8?B?SlJRNmJydm90TCtCOFNBM3RwWENmQTJpUUNRaHVrZDEvbUpWMVlpUFZ3Y2kw?=
 =?utf-8?B?Uk1FRnpmYmhVUnVvSFdRenU0MXhqaG5GSnZPYm9ndXpveFZnRGdmM3dmdGVm?=
 =?utf-8?B?L0U3a01welFpK0dOaTlYMFlSVEttZzBHVkpaYXJUaVlybVd5em1BcHg0TG1q?=
 =?utf-8?B?TlM2M1hncmJGeEJIQkpYTUxaSHlZbzdWUU9KdkhrZk5aZHZPK24zbnZ3VU5s?=
 =?utf-8?B?bW9JM2NiWjBoYjBXMUVUNWRtM2ZVUlFNMmMzSDhHYktHNHZkL2pnVGZ2a2xW?=
 =?utf-8?B?ZFRaYTlqYjlaN2VxVGpqRmZTQkdKT3VIQUtHWGNaTmp5ZnczVllqR1prcGwx?=
 =?utf-8?B?Vm05MW84aTJnS3BZWUJZdXN4Qkg2YnU4OFRVNXBRV0xJNWNIaXNERnphRlg4?=
 =?utf-8?B?cEhkU2kzSUg0b3E3M29sN3k0VGNZUVovMG1QMklXaEhOZjZvWlpHWW9HVlhn?=
 =?utf-8?B?Nzd4dDJhRmV2czBZa3JGVENDWlFtRDBmRjdOQXAybkkrV1lKMkFOMTZyZVhL?=
 =?utf-8?B?YVQ5SEtQMTRtTzF3enlRMUx2cU1JSVVYZFlMdDVqMEJTb1cyWS8zb2Vkam9R?=
 =?utf-8?B?OXFnKzFZMDlFQTJnZ3Q2V2EwTG04RXRXRUZtOWc4N1dEMnFzcHZlMUEvNTBp?=
 =?utf-8?B?dlNtdFFPMkFVd3VyVGNkMkJ2UElYQ3Z3WkdkRW1OR0g2TlBaQlV0elFWcGxq?=
 =?utf-8?B?MGFzRmdPYUg2ZndrQnVwMDllYzllV0lsalpKYStWMWpNWGpSNTNFdU1Id2JS?=
 =?utf-8?B?ZUIwSjN2YVM0NCs3T0Y5TWNVb1Y0dEY1MTFERjR3SGJZSHF6emU5WWw5VitO?=
 =?utf-8?B?ZkRkcWJLUHhRYzREWUIrR3ZpVnREWit4NWRvTGRpT3lOQi80WmZIZmRYcWZL?=
 =?utf-8?B?ZlNLQU9qOTFKVVd4anhyTU1ndWtyaFdLRUZiNi9SeG5YN3M3QmFZNG9McHk3?=
 =?utf-8?B?MUlBSEJsYlFUbGZNVFp6bG5Cek5mNU1PZWg1UHJLRHdsQTZndkc2amxqT1h3?=
 =?utf-8?B?OXBFaStXcUhLVzNRTXpsMzYvRnNqdm1SK2pkUWZaaTFveE90SmMweEMzOVUx?=
 =?utf-8?B?YW1nZVAyeHFtd2JxZ0lTcVkwOXNlRTZRL0hVY3hQdFVKb2Rna3lxczZZRFNm?=
 =?utf-8?B?bUhyK0dxTnV3dWpPZWhBd1M4QzlYWEdZYlNlWUdwR1AxWTdPTkx3WjQvS0ov?=
 =?utf-8?B?YnJLeEJBT0VVcEQ0STVidmQrTVU4Z3NXenVXdTNkVzFUT2paZjNkWU5tR05w?=
 =?utf-8?B?aG8rTUE4OUp0S3NIb200TkZoZVhyb1ZyU21xSGNKVUxHUmk4N05TcnVUTjJa?=
 =?utf-8?B?aUppbXlmY3I5RnpiazhHZVV0b01oOFZiOEV5SVQ2Rm94MlprSlk2dEhWamV1?=
 =?utf-8?B?YmZPUWxHeDcxbGFUMW1MZ3JFazNuNmhiTFUzMGI1aGhZOUI1VkJWMWhLanRQ?=
 =?utf-8?B?d0ZiaHV1SnVlVWNVNGxObXk2a01rUWFHZlB1NHFCZVJtMWJUcmhJb213OHkx?=
 =?utf-8?B?bWtOd1JGbncvVE5mR0NMdzJ6NE10dUhsU1FnYkd6dUp0Y1RLdWQ1RG1HMXN5?=
 =?utf-8?B?aGlOLzRZeDN0NGN2M3FTYWo2elQ3QnhDdU1wQTdldDU5UlA3S3IwbnhZbGFF?=
 =?utf-8?B?SE5JR0FqS3ZXOEdMb3lVcGFXdHB1UnFJM2s5Z2ttY0NuQmJ1Z0Z4b3V4dFoy?=
 =?utf-8?B?NCt5VkpJSnNkd081RUNhWkNJYTNWSnAzbWxTYS9DR3pyMG5KK2RjM1RGNUxN?=
 =?utf-8?B?aGxURUF0UVFndzVNbkl1cmIwT1JwUHRIOWVKWU5pVEdEc2lDdTlZMm5vOUd6?=
 =?utf-8?B?MVU2T3VwVlJ0SUlCUW1qZ0g4MkliL0RHVzF3cEdsQmFXRWVrc09Tb1F6MnE4?=
 =?utf-8?B?UjZlSVpBSUNnZU5Jb0E2NFVqTjRwRGd4R3VrR05zQTFWUG1qMFN5TjdQcXRQ?=
 =?utf-8?B?LzJLTnZPRDA3RVd4Mmp6Mkw5T3NVZGl3S0ZBdjllcmZrMVFvTHE0V1BUcUNT?=
 =?utf-8?B?d2locG5GU25VWVpMemZjQnJFMnI2eFExYmV3TmYxTlZjVXNFTWUrR3JFbTc5?=
 =?utf-8?B?MkcvMVFoNk9MUGZhZmtqN0Y5bTd4Zng3bUFva1o1QUhHUDhaaVY1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb406b6-6725-418a-123b-08df3ff383d3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:58:43.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxNFOScwsq8tKE4AJE9pY3aNY1C/Ap6QCGQVNyJhrWMTcwR97tDq7ffJvwif2LWRZRp+8rH6TzzDYPMuDIoKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9500

Hi Philippe, hi Florian,

I start to love pattern-matching machines:

Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2, we have

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b83a06739b511..024a67bd2de6a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		force_sig_pkuerr((void __user *)address, pkey);
 	else
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+
+	local_irq_disable_full();
 }
 
 static noinline void

The final code is

...
	oob_trap_notify(X86_TRAP_PF, regs);
	if (!running_inband())
		goto out;

	if (likely(show_unhandled_signals))
		show_signal_msg(regs, error_code, address, tsk);

	set_signal_archinfo(address, error_code);

	if (si_code == SEGV_PKUERR)
		force_sig_pkuerr((void __user *)address, pkey);
	else
		force_sig_fault(SIGSEGV, si_code, (void __user *)address);

	local_irq_disable_full();
out:
	oob_trap_unwind(X86_TRAP_PF, regs);
}

Do you remember why? As this was folded into the forward port, this 
delta never made it into anything older. If it is valid, we would need 
some reasoning. But this rather looks like a mismerge to me.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

