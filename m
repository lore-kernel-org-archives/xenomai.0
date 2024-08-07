Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8035149E16
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066158; cv=fail; b=HAxwoBpbKHmzcM95pgheEtAo2sxzHr72naQj1/vfk5R+JvZ2IZ9W8gaGzKbBuwBByur/42GQ/kgv4dOzJi4umaT6UcQklAF8E54tj2bzMo7tQHxYjUwr9Cc47Z1CGlgIwji5gtep5k2VmxjGPhO+yyELKhr2VdIAembkgzJeiAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066158; c=relaxed/simple;
	bh=7pcTZ6Doh7h5xVakp8kYt9Ook/2Y3VPEcDEJoljH2tA=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=sT/CAP2u7EcFg420zebuAtRyuUrDBG8UZGDL05kFiaHYQa/YJPoBoFVuUwXds0OyDM7/DwicWuuicYQrUWP/8aXjuu+pVNhaIOHGEDbVI5OuIg6CvuJvlbitizJQl5EdKN4qhJhvC7MFlGnxL4yTZGWxa4Q7s6/bKvtssH5kUvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SCH+ROu2; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SCH+ROu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU5YoqjVoIxiOCmZRUeNkq0klJUM9p/+7MoqoN1zrIfFXd8ZH6Mu3XPDxKCczol9AHCxFHjJWh2YeobR19FJ4Udr3Y023X6yoDSgElSuy2skMhx8G2EGmLPy6e3AmivDA4RiePb7A5QsX3ZTmygKXizdEVB8P3ThzUnHP1LqQbKRPGV1Emhb22R+NCX8+0p5hn5kCVX9qOuPppx5vSj50oS90gWXJj7nC5ZD6ydSmH61cfBD3TuZe8vnXodLO8qvCxkLLigv2+OCh0P8kNSXP4GPy/pZDb4tXXTHK1otL9xZII9c5GEDaIS5oYfyQqTZUM9G2uqps/Rq375CC/xZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdvnL22uFNHflmNhNzI2C5qHaSmrU7LMf2uO1N63xiA=;
 b=kGz1rOjaqvjhBQGMt5TZvWZJl0qAZE2ty53vl0EoI7N9Y3Q7PPQUaAnV95EeAAtMnxgMfugqSG4NRZNOtq+OlZwBxPhnGcaW7czk8tsQMw9CgkvPKv7m8PX7GfHmxF6CVFivFV5ZTSfz5jPq6+XcmcIRFdys+kcOyTsS5aLTjbhrMoy0tJDj2US1bAav1a4vx6DhqASvfNOazGUcoM3M1zhJ89rCX2W94QRPDIDRjXhOHz/JWw2WqFFQheSjUp99+DEfFVJXruB4Tr7qUZGciryAFQ7D7YYSVCFnQHx6EoviOgHWew/Ds2CnPpxOENwhF6whb9sFc5AB1eTVbMNpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdvnL22uFNHflmNhNzI2C5qHaSmrU7LMf2uO1N63xiA=;
 b=SCH+ROu2U5cJX0OB9GAEB0WIRpLij7HpHy7kiyasIEJQCFOuRjDrFR35LcSWlD8WZ27iaQc1rCJUtvLRXhLXiSxL3HIeug4OO9j0VKkVQM1BtWEEIrLn1zBLFXQnRPcbJKv6sVdB/0eWahYZLN5ML3C/zUIsn6XzMpC6PMs9M7W0yzeBkdmevwxT+3e2pkfvwZBpiYuSjvcwah3bp2Uy09MMpB9w+ENFOZChkW+e5DPgfu1X14LY+K/kkjpfi0Q/WD59z3CTa/TaZMGmrY3alp/UkuWjzz7yu+x6coR59NDWOvZKN2bKL5YcVzSkDm4Oa4WpGuQy7vhIlM6Fm6Nyhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 21:29:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:29:09 +0000
Message-ID: <61671442-6d21-4ad6-b8cb-8d7c8dc93df2@siemens.com>
Date: Wed, 7 Aug 2024 23:29:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] net: rtcfg: Account for MIN being provided by the kernel
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 09376461-abf0-4e1d-f134-08dcb727f985
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUduK01ROTZvY0tZM0cwak1Pd0pUd1FTVU9rTHhoSkhZbFUwNjJHQTY3ZUxE?=
 =?utf-8?B?TXZDQ20yamF0Mno0VmxTSXV3TWtraEF5S3VUdE9MZjRUaFlNNDRSZFgxLzhp?=
 =?utf-8?B?dzFQQ2IzdC9KYkxMOXp3b2hPMnZkM0VFV1NzaWlYNi9kUFRZVkIyTFBOcThj?=
 =?utf-8?B?bWttOUJaeVdxWEI3WSt2V1VYWmk3N3pzOXlPOVVlTE1mWk8rNWIyT1oyV2FQ?=
 =?utf-8?B?aEc1NU40ZVlVRkFRd2xwSUJUM05VRHR2MUp3Sm42M0UvZVBXbk1uWE1qWmM0?=
 =?utf-8?B?TDBWcERlcTNadjYzR0FMY0ZsQnV3ajc5U0tPRFpGald2clBSSXRuRkxSeEow?=
 =?utf-8?B?eWFQQUFlOEdqNUFZeEpnNjB5WDZZMkthODVIYlR2OUlUY3hhc2FNQzc1YVhz?=
 =?utf-8?B?RzQrb3VxRmE1dDFHczdTM0hXRUNrbU1abzJSUFlQOWFMeGFQWW0rU3Zjemky?=
 =?utf-8?B?aEhsN1NRaEUzVThMWWhhc0lhWWRyNWxEL01oL0NvQldFdmZPSjVUbUtPK0Vi?=
 =?utf-8?B?MnNFajlOeGhIRW9sM3FqUTZyb1pZa2pnZzVTSkErcWY0bU9wVGVDSSt3Slhp?=
 =?utf-8?B?ZDcrVlVyNmZESWdxblZlK2tvUEtLeXJNRlY1WkJJbk5ES0JaVkEvZUQydStr?=
 =?utf-8?B?Vmg0aVBCYllTaGtBS0pZNzBIc1lBOTgzV2lyY1hGcTJISkM2UEl5N2tTNU9M?=
 =?utf-8?B?cUl2ZkNaTVdXazFNVGZOL3dWQXV1Y1RIVmE5NnZQYk9SdWF2MUtTWWVkQWxG?=
 =?utf-8?B?akU4RjJ4dUdFL2hvYW55bVZOeElmbkNPdnhWZHFPblBSeXhzMFlZbFdVWUpz?=
 =?utf-8?B?VmZiR2tTRUl6cGFxQ1lvM2I4cjVMMjZzaksyZkFqZGs2clBtMS9VZm40Vmcr?=
 =?utf-8?B?U3BzVGpTZnIyODkvSVJ6aWVOMzlyUmhSVjA3MUE3L25UMDFpZUlySHZVbHFx?=
 =?utf-8?B?d1ozc3dsemE4YVJXYkhkNkJ5b2wzck9wY0ttYytPeU14Zk1xcDJlcFZ6ODlm?=
 =?utf-8?B?YkhIanpIMVlrUDZ2Z0pUUFlFY2ZiRjVYa3ltN3NpQjQ5aTBkUGMzclJIRDFZ?=
 =?utf-8?B?dXBDMER6MVdCUUw2M3d2N2lrZTl3b1FCTGw4NGZiamlYZWc0NExaSG9PV1BW?=
 =?utf-8?B?RExWMThrTHkzVHgrRnRXaVhtZUsxQy9wWXlybDBENzNFdmh0NGFpTWVGZlNl?=
 =?utf-8?B?Qi9nckdTN0NJZHdZSGxqN1hzeWZadS95b1RKSElRbkJxWHlRdE42N0dpNGVV?=
 =?utf-8?B?WVc2RnkxQ3JJVUpjS2dNNUF2WTh2V2xORlltcnZNNk52RVZsN1B0UWM1QW9y?=
 =?utf-8?B?VFZGMDRGRnYzM2ZFUmZKTVFUbGRFZmlpaTd3QnU3UzBEdUc5S1ljR01CaUNl?=
 =?utf-8?B?anBYMHlQRmY1bzdIZ2hpQ1Zldmh0RnlQL09HclBIc1lzY1lKU0lyb0h5MXRW?=
 =?utf-8?B?K3VFU3pudmFLVHRGY3FYQ0tHS3BRa0JiWXdZaUVRQ0ZaQ0R2RTRpU05zOTYw?=
 =?utf-8?B?NzYxRUlWSFE0ZkVrRE5ib1hjUEp2QSs4YkE4QzFlcFd3VkgzRm1YQWhaUXhO?=
 =?utf-8?B?WWJpUmh5NmRxSU11WUphR0pTOHJSdXdzTUZVb2NYQVU5NzEySmlDaFhHSUor?=
 =?utf-8?B?ejRIMStyUmRyVHYzVmdEU0poY3F6QS94bTY1Uk1QS29MTUxUZyttd0xnejZ1?=
 =?utf-8?B?ZWFma2cyVnFxV1VOTnlISU1CaDhUeUpXZUFyWTNPWHkwUnE4QmVkL0tuK00r?=
 =?utf-8?B?UVIwbi9nRjVPdEUvUk9jNTNqQzlrNzRkdVpMZ3hPMFRoeWNvTGFMdW9QYWlD?=
 =?utf-8?B?WU5GSEo5YVROQVBENUVhQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3VRWlZMME5JQmdmUlpuOVhUeXlIcFlWdVhBK0dOUDQyejFIWitYdG0zRlFw?=
 =?utf-8?B?WWNHNUFtY3lrSll2UnV2YUlxYmtxL09OMGh1dCtaZ3JObzY0ZlJmNjY4OW5r?=
 =?utf-8?B?OXEwOXlRQUROcUd2L3lLbXp2c0JEK0h3TGtZT3dLeWtjSitlNkcrOURmZlVW?=
 =?utf-8?B?MG5zNlZzUnJpdEVxNDY4dUFwOVd2ekR5VWJSL2ltTmZ0OWc4MzVUNFJNWEZz?=
 =?utf-8?B?ZmtjNDNLWS9SYnlaOXg5b2pHalEzTG5PK3VtUmpJYjIxbTVlUGFDQ2EvNTl1?=
 =?utf-8?B?aFArQ2JkR0x4QUlqRWhjRXhyV1VSenFaZjVuNUwxSlpBUURLUHJkNGVzOFRV?=
 =?utf-8?B?WlNxRzZ5clkwZnlWUCtyNURRazhUcFVoYUdjSEVlWmNWUjJrc3BmT25JM0Yw?=
 =?utf-8?B?S0JuY3hRTWc1VVcrenJXVWNwTE9INnJqZ1ZXZE1QbkJZM1l1NVFLczZIdTY2?=
 =?utf-8?B?b1dTMGVmWFZuSTJxc0FNOUlDRFRCZUFyQXhQVFlPTE1nU1QwY2RHamFMNGpT?=
 =?utf-8?B?QVMxc3A3c2s3QlMrUi9WbUhTeHB5bXdCV2pxWmpuS3o4cEg0Wm8wWmNVZW9y?=
 =?utf-8?B?T1NiQnZ1VmdKRkwwREg1MW1MSzErZ1ZZc29HV1JVSTVTV0FzRXVrK0lIY2Nr?=
 =?utf-8?B?RnQwY1U1RjYrZkhXdkt3dnJVUVMxSndib005a2JpdUhrNlZjbVpIWVBZTU1z?=
 =?utf-8?B?MmZ5M2pkZjAxbWI4UGZjQXB4U3NxRm84MzNEeW9RV0pGdGwxUm94WnJ5NWdn?=
 =?utf-8?B?eE52ZW8rYS9nNW0rM0NlaVQ5WlRRQ3dtUXBaZjExa1RNNFQreXk5NjFWeW5y?=
 =?utf-8?B?bDI0d2N1Mzc5UEhaNDVHYXZLb1k1TnZrZlRtQ1RwTEVYVlZkM1NaVjZqWkt1?=
 =?utf-8?B?bWkzOVlCY0p0ZXQ4WlcxNHdZa2txWFdiUTBLVDBwVHNUdk9hZ0k5OHEwUHF1?=
 =?utf-8?B?RElXamRhTCtwMkljZ1JsNkdPSTEwaFNyZzVMb0JoSXV5SjNhTVNURkZaMC9n?=
 =?utf-8?B?dzZJVTIvWFU5bWNETVdDQjBPVFQ2RHAxZ1VtWnZDV2dUSmZEKzd1cnFqSEI4?=
 =?utf-8?B?NmVaUW0zbHBRRWh4ZUtzSUlyc2ZUclY2QVZkQ2xEbXBTS0t2NDBoMGFheUlW?=
 =?utf-8?B?RlNzQm1kNG9IemF6MW1oV3Q2M042U1dXdXZ4amdSdVA0Y3N3ZE44VEdCaTNa?=
 =?utf-8?B?MWIzMXR2LzUvdnA5R2R6Um9FSTRncExJUml6SU9sSktlcWNNSkowc01zRFo2?=
 =?utf-8?B?ajFvQnUxTTNyQ2JyWFZ1YmYxb1c2UTFKeXlQcmFvTlZnU3NSdGc5RytRdzJh?=
 =?utf-8?B?RjdNS2xwN3ZOa3JwZFFhTEh1c0prbUVoR0JKR1NCUjNsN3c1azd4OWk5T2Nn?=
 =?utf-8?B?NTgvVXlMVkxUUzZRa1BXNldzRFUvaEtEbDlBMEJPR1kvdFJOR1pJUXJMbS9R?=
 =?utf-8?B?bStkZHNoMzBkeGMzUDJMcjk2cTIvTTNtN25kRkpYdnVudW9oS1lIV1NZbUtw?=
 =?utf-8?B?Y2Vxc1hRdUV0Uzc0Q0pxL2pjdjRHYmlHNVRZZ2djK2REekhSY2lBcS9LSzY4?=
 =?utf-8?B?WGw0Q0RDaDZvWXBLZDdHVkhrRnB5K1hNMm1lZUpEZnRDYWh5VXI5cE5lVEZv?=
 =?utf-8?B?bXh4czRZWHVIdzVIVnJqWmxGVUkvRkxKbkZNTkhLakpNQlRGSWM5U3J1TUxh?=
 =?utf-8?B?Zm1HUjAyRGNxNHV2aXpnRnpPVCtsVEF4ZWQ2WGM0VVJmdkhGUHNMLzliRG5p?=
 =?utf-8?B?WndSSnR4cThVZVRDTHVnd2QwaFMrRk9laDBEakV3RkFRUzhqOFFUc3RlaHdl?=
 =?utf-8?B?WnlRVEc1YkRsRWVqUVNKaTIybFo3NGFxdTMzUitSSFMzZWxjWndhQkgrVkJw?=
 =?utf-8?B?M3FhZmo1enp4cHh1MGVLWkVOT3JSeVBPMjIwSGE0OWIrelozaHd3aU9lbEND?=
 =?utf-8?B?MTEwTGFLMm5CK3hpTHVrSm4wSm11blJMOVBCL2pSNmgrVTVubXFOM21hcVFp?=
 =?utf-8?B?SmVrRFd0NHdvWVZ1L0VJZzkrK3V6TDdRaVQ5Ym1EMlRzT0owR1ZSN0xiRXZI?=
 =?utf-8?B?RXNTeDl2OTlrSGVmN1FYZ0pBMjkxWGhqUElncDdtK3Bvd0l5S3hvL1ZRUXg5?=
 =?utf-8?Q?o4RNLFRfwF/KsTfAKj1Fg4I0o?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09376461-abf0-4e1d-f134-08dcb727f985
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:29:09.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw6ctp7W54QYMoFnvIuOyrlDBQPZQJWc3b/xsW5Ey7qP79oVS0i2THvkP3MEfIOb22UCP6Osnm65uDE17sSNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8084

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now available by the kernel itself since 6.11.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
index 6148019fcc..eb9ad076e1 100644
--- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
+++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
@@ -27,7 +27,9 @@
 
 #include <rtdm/driver.h>
 
+#ifndef MIN
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
 
 /***
  * RTcfg debugging
-- 
2.43.0
