Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0906142659
	for <xenomai@lists.linux.dev>; Sun,  3 Nov 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660166; cv=fail; b=UVg3Y/yzpRKXv2mttif3bKKzgORWoK9U5VcnNM9LdfEE3pswMKOpJl3DImgDYs3gEXGOeRt7anCz2GeNa6dPe2lt5v4dJ13MQAJMxlPKnbyNlU1GKG/q7LdaxP3V5B878ZrFRYhJXDJqi8hUfM5MVMesJMEfKHOrAGP0htK+u+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660166; c=relaxed/simple;
	bh=fCLwcO2ls4qWVlJ2XqUOmqD2cdErzHksh7iLJDxOVmE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=j8RtLs5BGxWcgwPtxIk2DlOW4kHs6z63tWdQxsDwaSVVnC3F48p0WWVdm0xpgHGjpHiGFqEJsM1yi6p0CJ6ube3iaWJ66xWw2DnxB03bAZUb282fNANvZHCS38Irwi6xKh6fqiIANExjEqjwjov7k1sNWOVhN4EdSztB1uffoUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FhPi8+Jl; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FhPi8+Jl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9JiauLufTfx9icdZmfwNDuyeIfVjgw3sltGigdSl8KUxbIZiOUJajTe9o05yHFuksyBlljg0hw73fvgyV7scxgno8twuJzWj+TtSdpZKgVAyeSIHOX4eszdF+MeU1hMEbNUSEEpYzA69IHtY7FIFVbhmT6xGPkMySFXNi5wKRv/MJu924aQaGJTk4R8j8ZteY+U8GLOYQGjDla08IMtBKSmJCW3rhetehsRFfwQKXgIDHE68VwyaW8pLwUsjNcHu4JI4ka8gPKOcRpi9bOtmHQG64XD2d7jTuuXoD1RlHHgMnse6f8yPu7HJq6448rm/MHEvJlNOXMU3aetlTG62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIR9lecs5eWveIBJrew9T52tmjFj0OrW1gZ+kXqbpgw=;
 b=OjdYgxJxlYbIjW4VlylxecDqiSB6WxctQt5M/AldbTxCuHvV2Uo4SyYFCdnXF+5Q/sZc6duFABMbGDBQe8o5HoLOIkhWDbGkyhKCAixxutaBKJ2vOm9rue907hctBvaTtEJCLfIeEM9gQ7PpR8qrIk/U6JP7XAIyIVcH0Nmt1hFYtBd9jQUQL/sfpkm+4rvmqj26Sx+96JtEY5dYhcADrkbZ1W5x8fDamPAFAMUwpOv24vekEL9ddjUTx7VS+uPR0ETYPy+b8TD46NBu/wiqTCU4XAKcBLtTuGuS3scBGxTEvRPbHxsRXpyXvx0hLzRE3yftcwpCHSvAidyVYWdcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIR9lecs5eWveIBJrew9T52tmjFj0OrW1gZ+kXqbpgw=;
 b=FhPi8+JlYPUOdOyGWKMIjbumnvkJXmMZxgDgWe6PvftHyJcKsbgbgTV7oRJvOs6YIrWimcMPy0ZiPGnxhfCESUzQLNit6fj7SO3cvGY5a0qg4t99zLbik/xt85UL7/eIZX26/wSOEfvDpsVchjwpzASTMtQB5LJfed3j3XTWuksRZC8l4BXLQcFGw/zqlpdJejTAi3VT6oQHLPg+uxyjl/zrirmVbhgHsaJXR6vvxsx1p0XH/a0WL95gO2EY4eaYlTzP+WC9gFgUZGr8yGII8xhEEHi9RrNkiqk5foTAzm9LORJtB4/HyrODBoaiFXvVX1ZNgg5YgVM+8H87ZFnRUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Sun, 3 Nov
 2024 18:55:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.014; Sun, 3 Nov 2024
 18:55:59 +0000
Message-ID: <f3a5fcfd-2800-4688-8161-fb09a310983d@siemens.com>
Date: Sun, 3 Nov 2024 19:55:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] Account for moved unaligned.h in 6.12
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: e70ac6e0-8b44-4d03-1c4f-08dcfc3927ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anBWeDlCa0VzeVl5ZjBJdkNKK3lKL3grK1VaaXRlZVNTKzd4RUM5YTdZekF4?=
 =?utf-8?B?Y0lub0d5RWpSOFRYTjl1Rk5mMWZlVDRhL0xGYmE5ZVpnQW50Wk9CWFdMK0I5?=
 =?utf-8?B?c1o3VFEyQTBKRUJSOWJzTUVFci9COGxhMmthSzdtVFhYZnhPRUlYL3kyVFdZ?=
 =?utf-8?B?ckYxWGlKYjZFYU9YbmVOWDkzcm5OWFFYeVg2eU9mSHA3aExVajFEcy91RnBx?=
 =?utf-8?B?ekRhbDFFRXNLMkNNUm8rVWJYWXUzd1dBNVFMQlNKQWdJTExvVkhKb2tKamoy?=
 =?utf-8?B?RUJvbXNNaFFWRUZJaEx0dW5ML3pxR0JWOTFPVHpQQktqWVRjNVA3MllZenph?=
 =?utf-8?B?NS9WSFMvaHI4aEpZdkVvMFBhQmFCVGo5RHVveUVVT3Zkd3Rrc0h4QU85dElw?=
 =?utf-8?B?OE5uT0VNM3YzS3VQSDZvUVo2MldPa1VHRUdjQUwvNy9jYys2SXBxWEgveUtC?=
 =?utf-8?B?UjdTVzBJZXdJU2h5bWhTZVQzNzkwR1R2NUk5dFBwSDFkcVdEZXV1bzRGcjZ4?=
 =?utf-8?B?ZmNLbXNTNWQ1SGhHOTlsQlJIY0paeWRyaS83KzE3bzNlNTl5UTJrTVl0VnBr?=
 =?utf-8?B?bzdwV2VjZU0xVkR2N2JOSkV1M1ZnMm04VDFwZnB4bEZLVGpyMEVwdVNLYXdU?=
 =?utf-8?B?M1c1bG96UndVdWtSc0ZMNVE3RzBRVjAzYUVUby81MGRQNUZBME1WVHdBYTRF?=
 =?utf-8?B?K3RhWG0waFBDd1c3Q0Evdzk5MWdZYjE3V0hweUFNL3NZSVdiRy93L1cxRzYz?=
 =?utf-8?B?bUc5eno1WnlSL3owUUJidjErK0lZZExJY1J5amh6NDh0R1dSb1Z2TlA3aDY1?=
 =?utf-8?B?eWtqTnNadzhBbTNKR0ZDNFF1UXYyZy92Q05zazlvNk1EZThqN2ZFcjErNHcy?=
 =?utf-8?B?SHJQOEFJc2xheGVvTm5HM0JKdUl5WTNINDhTUzYrY3RGTnIvYlJzRHlmbkhy?=
 =?utf-8?B?VUhiaXBoWGVhSHZRMDhEdlhnbnJjWFVUQUJpNzB2cVU2U1NGNS9tSWNjN0xV?=
 =?utf-8?B?TlNHRkhvR0hvdmR0N01saFd0Z2pHd0s2a29IMzkvOGRlM0RsdC9NdUNJb3M0?=
 =?utf-8?B?NmV3Z1dRWTZ6aHI0ZUFRR054NWFTcFdQcDZoYlQ5amMwNE5RTy9GdWJFZHVy?=
 =?utf-8?B?RzJlUTRpRXZWMEEvZU9xU1pORkZpVUc5U2FYK3JnRU9CNGphMlJlcDBhMG1t?=
 =?utf-8?B?MjF0N0tOTk5ML1U1UHMyY3JuOFd3VDFIQW4vakd3TXAxUG82bC8vYnRUWEVL?=
 =?utf-8?B?ZjJWMVcvd2JkS2l0L21sRmx2NVlPSjVaRkpQRENlMGJLRUZQZm1Xaks4cG5L?=
 =?utf-8?B?TitvU3F6eStqV0s1VmNReGpiZzJ5VVBGZUxrQjNxakFIMTdPdGkvRGEyT1RM?=
 =?utf-8?B?czhJZTBuV2tsNFc0Zk96YzJMWkUyUmZwaW1XdzdQOXVPbDBqY2hHTG5kL0RK?=
 =?utf-8?B?YVRZQnRhNDE0MHorTGpLYUY4b0MyeGF3a0ZYMHlTOGF3Y0VnSmprZjloU3hS?=
 =?utf-8?B?SFRYMGxqbmMzUzZsV21vRnA5aTBBOG8rWUxmQlk1THYzVG9WTTZPNlpEMERV?=
 =?utf-8?B?cDlOK2xmMFpwNUxmUG9xaTN2d1p5M1pBY25UZDdTTXFYZGhrSTZEdlI1Y1Rs?=
 =?utf-8?B?K2pmQlpPb2w1TVNSeFUxSzJ3M3kxWHN2OFFKeDJpV3k3aXBXT25DWlcwaHc1?=
 =?utf-8?B?OXdrTWVtbVBHZk11VC9qdlo3OEw1K29rbTRIYUladjhCZUVDcHRhR2l2TTNr?=
 =?utf-8?Q?+GKgd/hOl3dNILENVlwFkYv/Zh+E1+Io4YWFDmS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJ3OXJjMHlvb21ocFFoVUV4UU9QZG5oRzltalhWb3dyRC9SenVqSmhzdDA1?=
 =?utf-8?B?UTR4YlhNMU1TdTVjNzZOa0NSblJsbElMYU9mM3lDM21Rb011TDAzMUF2U3g1?=
 =?utf-8?B?Sm1GZjhOTzBmck5sT1lRdGJ3cjllMTd6YkZuUjMzL0hFWjFyN3BJNGZTNkJz?=
 =?utf-8?B?R0JEdkxwOGlaQloySmhZL1cvU3Y2Vk9hSlZDVlBlcnkxeGoyVEdraW0xWnIx?=
 =?utf-8?B?MWZLVG51WWE1VWZ3Y2ppT215b3lhcDM1WnB0d29zdFg1RnpJR05yalV2SG16?=
 =?utf-8?B?MVFqbnZCeHBlWngxT3JVK1V3NThObnVDY3dMRCtsMEpaY1pjY3ZRRmJDazdF?=
 =?utf-8?B?cHZzbGFtSWxxdXJpYkZweFhhV3RLcDNuSWM5SDhrSDFGMWlKWVYzL3hoOXNo?=
 =?utf-8?B?cCtMVlBmOXZkNUpWOVFJZUZyMGxRK2JXL2JFQ3dOTzkzM01CTE4zSnphaHZi?=
 =?utf-8?B?RHUveStiM3NJZE9iNTVvT2JJSUpIc1N6M245NlBjYUdMem1FUE5wU21oMzVD?=
 =?utf-8?B?OEJDcjh3T0tBWWppVGhmQzlrYnY3ZkFLT2ZQYW44RHZ4eitQR25UZW1DbklC?=
 =?utf-8?B?M0lYamFaSUc3Zk1BRkF6eFl4dVR2QTBOVlpaZkovUE9kUUdWWnRXcUJPSXQy?=
 =?utf-8?B?MitDRDhVakZCbUlWTzdDWjdDdVY5Nkg3ZFY5Z0ZYM1RCdGVRUm9lQnJzVE1W?=
 =?utf-8?B?TStMR2tGWURKbVVMMlAxVEVHTEVwVXE5OHF4ZDBEVmRpbWhSemtkMUt5RU9n?=
 =?utf-8?B?OGFoMXBoWEhzbmNJMFJTWTF0elA5RjNrSEwxWmMveWJBL0NqZ3FBMURYZzB3?=
 =?utf-8?B?L0dvakc3NjNtczZhc3lIV2pNSTRSR3BkRnkrVzd6NVp4Z2I3dEdwQnl4K1N0?=
 =?utf-8?B?ZTJLamY4bDBGMEJkNVRTTXFJZlU3NDVualBvRFNZb2QyWHdHd2hzZ21keUJw?=
 =?utf-8?B?OTZiV2diakZRSHlaWXJaNm5CQlBFczF4M3E2YzRDOFRVSExIdE9hZE03TnNJ?=
 =?utf-8?B?WC9samVINnNIZDVWOTllUWNpRERuVDNaM05JdlhkSithREY1TUZaTkxtTU5V?=
 =?utf-8?B?N09aNmh0QlFFZFhYb0pnOENod1BVeklSWHZRM3U1ckpIdlkrRk9vNitCR292?=
 =?utf-8?B?cmJrVU8rdVFSQ0w5OUhhY1NmZ0VwY0pESUYyS1N4VVVlZzlvUVJvaENSZkY5?=
 =?utf-8?B?WG9mL1U4QVFLMDFrMGxvbmVxcFBuRk1aZGN4RDZndkdDK1lxcnYyaWNsWjg4?=
 =?utf-8?B?YlJ5Y1ZZRUtrdGMwRjZDdVlHUEkwdjNrc083UTRGSjJVbUcrSDFqeU5lTm13?=
 =?utf-8?B?VnkySVNoZHoxMVA1UXBWL3d4NHhTT1NLRStaSm9jUnE0cVNtYmpJVm01enpM?=
 =?utf-8?B?TFg4MnRUWnQ1NlJ3MlVGUjF2S21ZR1dlbXRPVVByOGQzUzFQVnExczIrWHFx?=
 =?utf-8?B?RS9IZWJtdGkrYVZXcFhUNktzcjk3T3BaS0dVT2JEczFsYlFPK3J6S3dqWW84?=
 =?utf-8?B?QVA2Mjg1WnN5SjBMSlRtaWFvTGlXaCt1c2VMZjdRdmI2WWk4TnFKMy9aV2hw?=
 =?utf-8?B?RXRNeWxuY21MZVZhVlNSdUNDVFpnR3NNcXFNK0RtUDFzQnlGTkE0aEZFcWRG?=
 =?utf-8?B?WVlLT0ZqaXRINkRwYk5IS3NTbXduQjFvRnplRWNvTGxSV2NwdlF1L0tjNzFy?=
 =?utf-8?B?bmFncG1CWGF6SFdoMmx3bWkxSEhWZ3NWZ2JPRkJyUnFrSWkvTnU1KzhzeWVh?=
 =?utf-8?B?amh3WklkemM3ODhqMG1lTG1uYUJFOU13VWkzUGNDNVFYazZCeHV4WFZpdjBH?=
 =?utf-8?B?N1BIRXQycXFQNUM2S05LUDk4Qll0aWU1dUR6ZVhYTHQ0akdKWjdSY0h3YXY4?=
 =?utf-8?B?SmNCcmtsc1BESk5TTExoOXdFYjR3ZXR6RU5vL0lzcklKeEJtV3FHenBlcmhu?=
 =?utf-8?B?ZXRBL2J5NzJXaXlvdWs3TStvZ3lCd2Z3N0YrRWtnQzZYT1ZoaTkvWmsrdEFu?=
 =?utf-8?B?OGZGakxndFNWYnZ5bjYzWjhMemdFYzN2RHFUNVJqdW9Zck1BTFVqRXBqRmZ6?=
 =?utf-8?B?TWd0cTBpOE5uUENlLzBCSHV6VTRtOXRkQXkwbElndUYzZ0Q3SGRHQ2orSnJZ?=
 =?utf-8?Q?jsKbEmW3QvoCr3sXPpulDTdpr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70ac6e0-8b44-4d03-1c4f-08dcfc3927ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 18:55:59.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76nv0Vb9+zsJs7wZVAGxHWBX+TFQ5zf51bL3CI3vOnmGt7RipSwtSfMG3RqfdxMhVkYAPSWeDiNWe9GZBwjHmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8571

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_flexcan.c            | 4 ++++
 kernel/drivers/net/drivers/tulip/eeprom.c     | 4 ++++
 kernel/drivers/net/drivers/tulip/tulip_core.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index 1658599232..48febe4d5f 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -39,7 +39,11 @@
 #include "rtcan_dev.h"
 #include "rtcan_raw.h"
 #include "rtcan_internal.h"
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,12,0)
+#include <linux/unaligned.h>
+#else
 #include <asm/unaligned.h>
+#endif
 
 #define DRV_NAME	"flexcan"
 #define DEV_NAME	"rtcan%d"
diff --git a/kernel/drivers/net/drivers/tulip/eeprom.c b/kernel/drivers/net/drivers/tulip/eeprom.c
index c86ee51ad2..52ba7b1dca 100644
--- a/kernel/drivers/net/drivers/tulip/eeprom.c
+++ b/kernel/drivers/net/drivers/tulip/eeprom.c
@@ -19,7 +19,11 @@
 
 #include "tulip.h"
 #include <linux/init.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,12,0)
+#include <linux/unaligned.h>
+#else
 #include <asm/unaligned.h>
+#endif
 
 
 
diff --git a/kernel/drivers/net/drivers/tulip/tulip_core.c b/kernel/drivers/net/drivers/tulip/tulip_core.c
index 23209f0452..b353f1502c 100644
--- a/kernel/drivers/net/drivers/tulip/tulip_core.c
+++ b/kernel/drivers/net/drivers/tulip/tulip_core.c
@@ -32,7 +32,11 @@
 #include <linux/ethtool.h>
 #include <linux/crc32.h>
 #include <linux/uaccess.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,12,0)
+#include <linux/unaligned.h>
+#else
 #include <asm/unaligned.h>
+#endif
 
 #ifdef __sparc__
 #include <asm/pbm.h>
-- 
2.43.0
