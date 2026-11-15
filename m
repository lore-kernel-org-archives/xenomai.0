Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794752074;
	b=JnCm15qYxK24+uiPzZ1u219+qHybrhDeoZDdW171sqns8COtLmBZPtz/n5QNJTgHZpfE
	 FBB06fmCfQ2IE2vI/gRcMffWzq3Pv4T9XfmYNOwrDvb6KdknbQBYdJYxKsVfIKuSKXqKE
	 gHqjzSxFH3q0T4R5exqdDIH7+pMV/P7GqwFoh5RKJbcIUWMzRyq+1gIhwcI3ELdEkdh4V
	 m+hYyjn6Ak2u3z+U5t4SIsFtRGSwf03DztPDqXb2UcS9EI3jd9D+HkW5Ao4k9oww/DF6+
	 RF2SNLbk8BS21hT9DWNXmzlIKopOa3GVL00XNAU/pWZlncr0Pi4VuUQxhsQrHx8YfNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752074;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
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
	bh=pxR2c6drqTjMVbiZwEmRZoDQIh2Gd9pkY6ZdiPH1fSU=;
	b=3OYBQVQLRM8X7mMCDs4yntbYUGpo4u+V0EXwleC17vwuPqIuFfEjgyH304DATgT9F49R
	 +yMfQf5+oPAOA5We7GJGOQK8BK7JHF96dbcyJvRSRgblnetYotzNUkzCUAgGdZkSoZMqr
	 3p+L5EdJBmZUxPVNW5iYCsWo4+dL4U72B1XyqeLKJ64HR2wMtpoYVgjyguzDjetKbuNQB
	 W8Jd/szkYlb5Q9q8c0+0nVBbtiwRNrtezwOiNWhJpBxGjT9MFub7cAEqgBpCoEpg7FcgJ
	 S5f46SlffwD06wUpphuY6b1bnDil5rni0tCCOJxcB6xp3H0sxe+ca7TLB0nhxOsV2uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=sT4pIGaV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CD606A323
	for <xenomai@lists.linux.dev>; Sun, 15 Nov 2026 14:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 719CD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=sT4pIGaV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFgWY6XrVIgnGg+xURBSzeHYqA2PC4HBVMFK8o8et5A79heRrzUCpKkRmfN3SKZ65WmX2vmS/Mzd5X4QLrSXOHyjpZdZ+Uv9s0Xas8q/acCM9oX+QmsxdBn2qnktkIYh05MDVtvjWymqS1Cw3fQ+FlG5xdX51/MxAHAsPYm1qCCh+67EloEizMvIxkjzQ1L6P5ZJEO2HybDBSGejViixdNShgct8uh91bT3FIlSDqXea3t5x7VlkI5quga1gp1QqrYGfTr+u2t29wNR28f9U9cySlxytHEAivt0wTOS9gSxbr9oC/JYZxjsj1WfyZZlOAbWXuTgrTQs/86jzHx+cBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxR2c6drqTjMVbiZwEmRZoDQIh2Gd9pkY6ZdiPH1fSU=;
 b=jMPNOfIAvEfj4OJ7FFKNciTIDfK8100a4fAKw/+1aZL3GQkXOTxZmR7zWdsHMftzzplcNIA7k8vn+siw/kMDjzv0RbN2z6fpI7vb8w3gkiz9ctmOgB5Eabs5f2lRtUTlD2OTUkx1fNwbo6W1IAEr/s8dsLjcCYSsesJD+ejky86c8aGnIGIiHXWLmWHY2Kuknt86LNSH4rg8Jx9djWkeI1swsIo3lBCULQEOpejLS/FJT+c0vURU9LGwNK3sbgF/X5rBizRntIT7DXdvyOeJN1CpCt5xekCNaVPat36gsYsU3MEyTyqBaEfF8/uON1NHV2ju8zgOqj7J1QrnHIUT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxR2c6drqTjMVbiZwEmRZoDQIh2Gd9pkY6ZdiPH1fSU=;
 b=sT4pIGaVDaGvLuWpDr5vjsW6alrGYMLCA+8ekvHoNXf2FZim3BV85VMLspS5O+77ocrC1PvhNF+HvoFT+UTTLgct7kpyUHIxuGF8D0zY80wJSIrj/VkOWcPMUYX2g58NTAWkgIxk63LRgxi7BF0908ebP5EHH48uwM+PFdvIqkI90VTpEiR9EIeNXc+ax8r7WhlGIxpZo3gS+YYL2zoIv8lNhPqemGcMuA26CPcZbmCKhoEZ7xzEDAynFgsJr6IySUjkcnZCkbL/47vyqPLBPICbQjugZw1QCDsRa9E77tLgl8SoWh9XzNpjRKNTtchxLo4dconL7t339azZrGw+bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3179.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:11e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Sun, 15 Nov
 2026 14:14:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.003; Sun, 15 Nov 2026
 14:14:30 +0000
Message-ID: <83b1a47f-5493-4afb-93cd-525425db7f92@siemens.com>
Date: Sun, 15 Nov 2026 15:14:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] arm64: dovetail: Drop unused mkipi_oob under
 IRQ_PIPLINE=n
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3179:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a4e754-4e77-41d5-dfb8-08df4322c3ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261022075727099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	G7eqGwEej/HYbfkleg+z8LbVD+1A91szhbmBVZ6j9ECmeAF0XQPHhg3S4MqDT0AAsKI44RU/L6IKSxA0b8aAXIMYbGJDsKNm4bJUjd1Azmxr0I7ogqQpvBuj4qM6r9KD5VlWzVop6zpdr8BMHutFbbB5Uvlzj9maTGGu56jOOBubcjffaXrWiN0DaJJ3v6jbQmUfz4hg+oAWJZR7JnyQhZn8oX03CiEprJNWNVRLJSQm8PX6ve185NQVJqpSn5nk9sIwg/ZFYPh/ISPTDi/ZoBnAH00denfRfqXtmpISqAmX/QfZw8QV92pYD160Kdf2WyymZQ/cV0rikequAVJU+u8xIs6/Cc3IwUKuF9UbzsqUZz4L0fSdIeZYZYpBDAQbe2HuJyr+U9C1qqT3U9teut0NbIJY7ebaU4xXFk1aq+AEKeI69eWPcozUm7ioR1uLIsy3FhpH/wgQ2FsWFrA7lOGBlV/1lA4DcFmS1oGgpyHQZl9+lMrfTwt3BxiR1qy5elp4hVEdUJPyjfjHc4NcQthwnNVSqO5HfRNpcUDv1oSt5rQcBGSY6mbZymP9wOGhZWglzbAVU4aOSg4AneJeCdTfHtP52//x03Ub4BShFziHUAqRuMFs0gDtuwhEIyHQK9SAGp5+dpIBpR7CAI21ui3IK+mhYQSwI7/IAeLxICg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261022075727099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3R0N29Hei8vd1J0eWFlNmhha1RXb1JLekwwRXZHMytiUzYvTFdheW1lWnNH?=
 =?utf-8?B?OHEyaXRlZXoxTHJhbDZ5SEFtT2FjTkZGVUVXOHFyWGFEbVVBSFVvVitIWTJv?=
 =?utf-8?B?R29jS3lSOVV4MitKc3ZRRXpDTUtuZjlrdXQ0eUtuRjlNN2dDUmVFdXJTaEdn?=
 =?utf-8?B?Sm9CdUV0WXRCUkwzRGN4Mml6ZUlRTXRna05yQ1JWb0hkZjYwWFdjTXZ1ZXV2?=
 =?utf-8?B?Q0FzdzdXSHdiVU9oYnE0b3crR1kvOGFGMXV3cG5nWXhvL3NFVDVreFdaSTFG?=
 =?utf-8?B?bFYzNGM5Y2hObUxQOGZoYVVKSzlOUnZzZnhVUU82VHFNWk54YnNwQzYzVXZ6?=
 =?utf-8?B?NHdBZi9RbHcvczVwZXU0OTEybTVQWWplQ2RrRDBXYjV1c2t0b0VQVG5yQ2dP?=
 =?utf-8?B?MGlQNWVzY1JKSkRDeWM5TlNWbU91ZTgyaWY2dkxBVkgzV2UrVzhaN0xIbW04?=
 =?utf-8?B?bGErbnR1Y0h6NU1OT283SFdudE5zUkM0b2V1NXdEUHZrNDZZeklqdXREbzdq?=
 =?utf-8?B?WWgyandxZEJiZnN0QUx2ellnOEpzUzBVLzFLcnpSenIzbkNJQmtCdEdZaXFW?=
 =?utf-8?B?YVlRUGlkemR6WVRZOW55QVpFQjE3VFdPRlRFdndMWnBQaHljQ20yNjhjREsv?=
 =?utf-8?B?TVVYUDB5NVRvUWlUODk1b2hsOG00S2JjMDdvb2RuNm50cDRLZUJkVEpqUm5z?=
 =?utf-8?B?OHhtV0RsbHYvWDhpTjBSZFpOMERkbTMrcVEwMFlYYTMrYjVOdGJIKzlVemtz?=
 =?utf-8?B?MmJEMlBVRjhkK3poS2FnTjZkd2hXNmpSZUkvVTFYc3BnN0hFRG9QNitMVVZy?=
 =?utf-8?B?UVpUR2ptYmNEemxaemhFZDJXSmtBMVZwRkdyRXB4OGR1enViYnZ5VDVKU0FW?=
 =?utf-8?B?OUpET25nT01lRDIycUJYQUZIcDdWTklEclFZRFhuVXovZjF1dnR6cUovQStq?=
 =?utf-8?B?M2pxMEJDUlc4bEdTVTRzVmU2dVNFR3BHLzZKcVMvczh4L3RFV2IwZ1lUMDlC?=
 =?utf-8?B?QUErcmF4RnJyMkhpMDZXdUZ3TzVVK21Ka1FOQVgvakl3OTA2OXJHRTRiZE9S?=
 =?utf-8?B?YVNhT1ZRZThxc3lyU0lFbFl1cXFnalE1SFZHWHZKUGJYZzJ2M0JjQlgvc1dq?=
 =?utf-8?B?K0RZY1JlWVNubHJPNjFjWUJQZTBLdGkzUUR4TEgvckYrN1llcC9WcG5MdzJz?=
 =?utf-8?B?Y0pHazd6enpDMG9rOXM0V0VZRGJVd2ZGUG5NUUI0Q1lKTTgwRHhnYTNoa1pp?=
 =?utf-8?B?TFB6dWNTU0Fmbm5xZFUveWl4THA0em94K041aVhMMEplS3FvRDFTeTV1ZTNz?=
 =?utf-8?B?NlZsMzZiMko4eS9vR3kzQ05NbGZvWWg2OFVHSnNKYjVhQTNXV2ZNN1pURjNR?=
 =?utf-8?B?S041c1RuNkJqc05mM0MrVHo0alJ1WUtlV2M5akdrSDRiVFN2TnVVcWxIS3FI?=
 =?utf-8?B?MzNYdU5VdHZpUlNUYm01aDhPbC9qYjZNYUdpcWhxMnZCdmpkV2RneWhIbXpo?=
 =?utf-8?B?RjVVSFZUTkJ2cmQ3SjdHM1UwcmlzdDJoYVN2S3FDWGU0eDFhckdQdFlZWVJU?=
 =?utf-8?B?c0VUYXU5NU12a2NFQmorM3FzRWpVTGtXSkJXV3k1blk2QkJkcnZkenF0VWRj?=
 =?utf-8?B?c2VhRzMrbkhZb0RYNlJOQ1dLQ0o0SnFGV0g4VE4xd1phSkxCVS91RVltVzVZ?=
 =?utf-8?B?VE94bHVGcmc5cGt2MDVlM25sOG8zRlk4U0VFMW5FQmFhWWRCNXBBNVBUUlpu?=
 =?utf-8?B?K1llTkVBUUtabHgvWkxBcHVVd3llWXhzRzViQXo1aUwrMFErdDFYR2h0czRk?=
 =?utf-8?B?bmFxaWxIQTlnOGxXa0FUWnMyTElQeTZuN0FOamg3WDN6MkRHMVJSUHBiVzU3?=
 =?utf-8?B?VHU2anFTd3FuQzRjTDNOREkxdXF3V2ZPVGxOaFA4SlpFZ0N6R1ZCd2w3NHY0?=
 =?utf-8?B?WlVZOGY1Um5nZUVCek5obXVjRGo2THJhNXkzVUlnZCs4WUl0NmVWTGJBK2JX?=
 =?utf-8?B?d2pmbFY0WUxYOHN0Z2ZteWZvMWl6UTRQTm9jaklXdzZoWXFkcWQvMlo5NVRa?=
 =?utf-8?B?c2xmMWEwbUtYWHo1TE9rb3dSWjJPbXRGRGpKLzhSODhqaGF6eTA5VkFkWFJx?=
 =?utf-8?B?M0l0L0FXamVxblhIMGNxbmc5MnlLeVVieVpONkplbFowb3F4d3ZsWnd6MHp5?=
 =?utf-8?B?ZDc0bXZoYW9tRGljTDlLZjNzc0p5bWh1Yy9jaXdEQXZ2T3d5QWo5RVFydFpP?=
 =?utf-8?B?bXVadlFTaUZSTGxkbDN1N3Z6b0l0aXd2QjJFUGcrekRkUlhqSlVGc01rRHk5?=
 =?utf-8?B?cVFvOGRFZU0rVnJUd2E4bGFSenNuY01jakFERWhYak1RRDlJZWV3UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a4e754-4e77-41d5-dfb8-08df4322c3ac
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 14:14:30.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDUxBAG0DAz/1GERWyPBzoqIWVJEoKjj1NFv4ou/4alYfmv/aY21LadA0bZiQfSX0uWh1EIX4ql7g223gzwhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3179

From: Jan Kiszka <jan.kiszka@siemens.com>

Not used in this configuration as there is no OOB then.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/smp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d018226c17256..ceb9840c35eec 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1166,12 +1166,6 @@ static inline struct ipi_index mkipi_inband(unsigned int ipi,
 	return (struct ipi_index){ .sgi = ipi };
 }
 
-static inline struct ipi_index mkipi_oob(unsigned int ipi)
-{
-	WARN_ON_ONCE(1);
-	return (struct ipi_index){ .sgi = ipi };
-}
-
 static inline void ipi_setup_oob_sgi(void)
 { }
 
-- 
2.47.3
