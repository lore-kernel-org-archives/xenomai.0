Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E93A920
	for <xenomai@lists.linux.dev>; Fri, 27 Sep 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460385; cv=fail; b=cnpPE+UM55ht8+tAtqmYfpoVjCaMbqzkTVr7D299k64RB4CzI1L7C4vNFzGFufluZTmWwPFt/qtq1Z04f41GxtDP+TEXE7uq7ugXsy7mqt3ub+YEMt9UDiSq+IF/+KHDOL6sPodlHdlVvx8snYTQzN+FZaIvyyP7qts/mznomZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460385; c=relaxed/simple;
	bh=GaTObMLAWVgPa70Cv7LpzuNW0apfoEdwapTn+LKua6U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T51OOtEad32CrcQw0EGkAjHJAfTEdN1NnbdmWt6YtvVBAJOXSJWGYIhEv/GTicnYNlCNdqYF4Gi2OXGDc665wQxFvgaNeHV0KYXo8c/uEiBKelhwAFsOuE/NGIFuq7zT/0jl55xIH/f2WeDOmp3W1JD7rLvQLsngIj1lJsi3fXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HxKoeYNR; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HxKoeYNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6vfeQVckebyEJtWYKa2qLcOekBJXU0yayo+uHJ9hg4nTVTwA8vm/OYtSkpPiiFD9/9Lm4LDMi9gjAFDj8Md3ZfIST6h3fRjhtk7bDQBmDutPDhm7/yCTRwYqPaEn4YywcHsgachw5pcs7TFevUsgHuJgKAhU3GtaCqyrIbviIN8y3lWVuU8wQNhqusY5ztJLDR1Hx5kJnq0R5wLfSemadsNlJTrp7BmkxWq80tEzhGSA2vcih1wFv74/9d35wcncv7nNCf+3TYHirOgYMGT35STUGlHmj2QoehCr0qrtpyx5a3PPmyUVnZHZ2NjHglsVkOkOVK05TZ7ocUszBrf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teE5ta2z4YT9m+q7dv6LbuU01tK+d0lraoUP/22e8ak=;
 b=HgrbmJ/bIH+MM26WdQYMffy617VHJzvbqHg/4FegQxnrczDbGuGbC+umcCLKmB9AhWjNCXE3mAH5sHly16rB/nMUXn2f03ZSOnHOCdWtPygUYb30vcOvSByXqujaSHaReWlPVXqv2X4Cpw/VT+K1WeyoWIiX7kVMldeD9n1ZZJrFzjpeCoL0nG1r66sMrAEW/o0LtjFgXmU2IInvUasFJJgaNLnaZK9WphofnrYeA0XzEPUbQ1o8sQ1N4F2TH6vRziEIfbBZDfTZRHGTysD004bnsINQ3ao58E0yPHSQ17rXrDCmRXBOzJJ+F3OlMsGxKJayWDSi/DaB42+qFLxOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teE5ta2z4YT9m+q7dv6LbuU01tK+d0lraoUP/22e8ak=;
 b=HxKoeYNR7TAdhIS4VoAojJsornpqR6f4tAeeFlX+HBrTVcXSDIvm+Ynqe29Q7jPvTYh8KH/I9cN9q2RUgINw+vXr5EKSngQZPt9CwYrQE5yfi41ui5MjSfbX9yCpOvFUBSM2EBnXHox/mW/BKXA9ulchO83JMpY3s5NrneJTBNNapLwGCbDkrTK2zcFuEz/C4bgfPkp/rxKP7/3jXQWM0Inbq2YedccfCuHX5r2Hl/5cE+tUeUG/ojuoI2VpCRUr/JkuqSJV1jHALDGr6MRJz1GA9tKXKHgUZ4P5gBhkfmQOJmoBSVkIBqRo9yi2/jD5QmNPJrCRb0asPkyBIwhS6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 18:06:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 18:06:19 +0000
Message-ID: <09098fc4-ec0c-4b0a-b207-5547481e9b62@siemens.com>
Date: Fri, 27 Sep 2024 20:06:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: f81601 rtcan driver issue
To: "liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
References: <2024092718562729740211@sinsegye.com.cn>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2024092718562729740211@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b77c8d-67d3-4209-aa68-08dcdf1f1696
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGQ0WlppSzdmbzdyREVvQ3lPV05wczlXLzRFb3ZKbFdhaVA1c3ROZitkQ3N1?=
 =?utf-8?B?ZFpBcVY2UGpjTUtzalVTTUpWOHpZWDUxRVBUZGR5bFVzbDdiOTJhVzdsd1Jv?=
 =?utf-8?B?eW8yZ1FDSE1MYWpodk9CN2g5amIvb25zT1pGaStoUjdSYTZ2N0Z0NDZSMVVn?=
 =?utf-8?B?NnJLTDRIN1JueVZkN3NaMXk0SzN2cUdWaS9CRXQ4V3FlQjBzdWlvcjZtREZo?=
 =?utf-8?B?bFROZnVEOVBnSnVjelJ6MldVS1BicjdWUWQ4NFRvTmZsLzdZY1hBZk5VODJQ?=
 =?utf-8?B?VnFuTFZmakRHanZaRTdLZVFjYzcvNXRjeElsY1NOUmVVdVdyenc2NmRnamds?=
 =?utf-8?B?TnFSVzFpK0Z0V0tQSEJyMk9DVlN1d2RkTWRRQ2VSbmdDbDNCT3dGeDdpT3Vt?=
 =?utf-8?B?bExWYnpMbHA4ZWhpajF0c0c0VnpRRTNqK0RQSmVXNlU0R2VvYjUvazU2ZkNr?=
 =?utf-8?B?aVVXZ3E1T0xESGw2UnN3LzJIZW9UUGFHcG5GUjAyUkJjSXkrVkRXNXVISnFC?=
 =?utf-8?B?bGNwYTJOc2t3cG9lTTlEWnpXUGFsUkpXUStWc3V4bDVyU1FrRmxQamZlOGgx?=
 =?utf-8?B?TVlaa1ZtOEhZV1BxcE1EQmwrME4yMkh2VHdBenpyVmRZVnc3YU00YlJ5VG5I?=
 =?utf-8?B?TWZCVFBrNWpQNHEvMHRRbWxEZHl0cDFqd2dXQ2I2WTlUbXVOSWVhVEJQK21S?=
 =?utf-8?B?Sk4yZHViTW9FV2tQUEo5ZW9DbUdpQWMwaXZoYzBjTld0VDhIUmtzOWg1cDJB?=
 =?utf-8?B?N3RhaWFVMks4NUVmL0NxYVJaZ0pSZldFVThDcG02WmFINjhVRVU0eklmR2RZ?=
 =?utf-8?B?UmtSZXRsbytFNHg3UmRjd3Y3aXdSM3VXS0ZmWitjYjFoSVV2WUpOZFBpQzBX?=
 =?utf-8?B?U1FYK1hNNVNhaWV5eDRLV3FuNDkxQVlXMWlzKytQZlQ5TGFvYmpqU1A5NGNC?=
 =?utf-8?B?bytDemR0UkJ1eW9Nc0drTlNzU3VtRHJ6L2c2NnpNMmRJaU9wbGVtM0lGTkNk?=
 =?utf-8?B?TnBEc0I2bWVURGF5U0JTcUE2ZXNYdjNGWjVBempYRllyTlhYbkFNT2dDVDFU?=
 =?utf-8?B?bGgvNDdNcmxlMVN6bUVKeXlXcHY3Szl5Zk40cWlZaVhtUUV6SkZqYkcwdytr?=
 =?utf-8?B?WGNxenlFVGg2cEJXUXV1YTQzUDdtUC9OeFpmU3lnTHBESXRDbituS3JaeVhu?=
 =?utf-8?B?RzIzalE1U0VjTDlzcTYxKzJJZFpCS2dEYlJXVFpUZkl5RThBNTlOOGVXeGl1?=
 =?utf-8?B?bytrR3BIMlptTTJGMU4ybGJ6YVM2TlVMNy9SaDdLajUyd1Z5Nksvd1RwQkZl?=
 =?utf-8?B?dmtHdVJPSm0vZ1FKQVlkVjZYdFF6QnFoaUp2cXlvVHBrUUl1Mlc1ZW1HcDlu?=
 =?utf-8?B?K1h0MUtvVGEzRHZndUFTY29Ob1h1NDd2clB0SzhYdjZjZ25GUXJuME1pNFUr?=
 =?utf-8?B?bFRzZFBiYkhiN1RxRnR6MGVDMlgyaG41SHRBRU80WFFsZmE2dHBFN1dyaXRz?=
 =?utf-8?B?bllsRVBMZi9pRzVrNUU3SXEzSzJWWjBacTJBK3dMVE5BT1BoQXdTTlNJdURC?=
 =?utf-8?B?eXF4dnJsU3RseG52clJ1TXcrTDJ1bGgwYXdud2kxSmxsYllDeVRmUi9jcm1S?=
 =?utf-8?B?UWZiWXloV1JEWFdKSWJNcUdmSVh2cHhqcFZ1UFJjcGplT0o0NzM0VkQ2VW1j?=
 =?utf-8?B?eG5NYnlHSE5ERFZ1LzZBc0pReUNodys5em5welluMkFoQWtGVHpYb1pFL1Vh?=
 =?utf-8?B?Y2V3L2krV21jR1k1NTlaY3JBMEhJd21EbFM2Um1ZS3djYmpVT3FVcFQ5OHFv?=
 =?utf-8?B?cXljakd6ZytISWdPQm54UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGFEcjlWNUNkeVp3clVPZnhuVzRHSS9LZTV5cG54ZmZZblZGZ2MxUlA2KytW?=
 =?utf-8?B?aWF1aHlPRVo5bWoxaWQzTitYemNTK2E1dUhPVk1RK3J1RWE3dWx0dS9ZNC85?=
 =?utf-8?B?M1pES3pUZWRkd3BkK1hDZDk2ZUtaeW1LUHR2RGJJTjhPRjYrZitOTXJjSkFG?=
 =?utf-8?B?TnR6aXJNSlhLams3S0wrdVM1NXdzbFdYb2cyZzIwSUlwOGc3SzIwTnF2bnJj?=
 =?utf-8?B?UUx2R0JmMjVmaVpQUzB1Yzk1azM4bnF6d2p0R3EyM3ZQejk0Ti9Vb2l5d0Yv?=
 =?utf-8?B?dUZ0ZG9EQ1BVM1p5VWtzbVhXeWJYRnFYS0JaWnBESXJiQWQ3N2JoaEh6ektq?=
 =?utf-8?B?Q1g1MFN6Y0RQNTE3b2pHVTg3aHQ4WXE4N1JOdEVhNlpCOFZXQ2JKRVZuaWZR?=
 =?utf-8?B?eFIyY25ISnFweGJQOGcwNHJUSmNINFlIZnptQk14TEVIZHIyNzgxS1dWTFZG?=
 =?utf-8?B?Y29XOFdhU01WQkxvb0JHcXlkL3pvSGdSRWxoM01xeURSQ2Z6dFNFTEE5aDJI?=
 =?utf-8?B?VkUyTnIxdk92RForZDFERTlNL0pSdXNQdlFLbTBORlYrdm52YVYzUlArOEFu?=
 =?utf-8?B?c25wZjkrL29PTVZVbXV0VTJaZmdFN3FBK0tQK3ZhdURNei9SZ043TUVKMVNu?=
 =?utf-8?B?SGRoSGhxRlBDb21JZkIrNFJHQS9Zc3puS0JoT1Vsclk1aG1yajNMSlp6dkFQ?=
 =?utf-8?B?MWhzdW9hK1hvY0xneXNzUUtOcjc2YktyOFdyaGZYMjB6TTdhZnh3UzRYQkcw?=
 =?utf-8?B?MFc5SmFaSVhrUWYvb0dadUw5SDJleUVISTMzWXM4VmIvZjdITHI4QTlpWGhw?=
 =?utf-8?B?SUJmcWRKUXllVHZJWUNEdlg2MVVtK1J1NHBXd05GUjdrNS9hRE53MXNWUjRa?=
 =?utf-8?B?dnhkZGRsRzNqQkYvM2hJTzlMamdUb1NaY2dhRytVRUhLU3dUZ3pROGJxdzBv?=
 =?utf-8?B?NFJDN1kxK0xLQTBSQzBwNTVzMURYWE9mditueENBNVdRRWpzRS9lc1dpeE5E?=
 =?utf-8?B?a0NFTnJwbXZWZXliUFRSZkxYYUxKaHlLc0NuQjJVWEVMeHgxVmtPUEpabjJ3?=
 =?utf-8?B?OGtGb2wzWWtzaklJcVJuRXh3MFg2S1BPNFhESHRaUE9pUnlFNDRvUk12UEJp?=
 =?utf-8?B?bVNaUVNONWU0MWZTd3d5d20vVUFibm42ZWsxYjBvRzMvd2VxWFJRS0l0RFBW?=
 =?utf-8?B?ckd4NS9CSnQyS0srbDB4NGlZaFJldE5JVEJFSUhENmMwSFFJM1U2dXo4RFgy?=
 =?utf-8?B?WkNvKzhZZ3h6dTJNeXJ2cUNZeEFrMFpGcnVQaWh6R0lUd1E2NWdIQkd4S1N3?=
 =?utf-8?B?bnVFN3BXSkloY1RWTUhjVTF6RjZIMnhSS0hNQW4rYSswK3BxNUdDWExvWFhL?=
 =?utf-8?B?eWRxdHZQMjRLL1MySVFvVVBydkpqdmhDTGNodUw2dVpoYUZ2Ym55L1pTQ2xi?=
 =?utf-8?B?RFdFQ3dGK3hKek5LeGh1OEMvbW5Mb3Rod1FyZE5Eb0lKMkVTU2ZuNHRJTi9D?=
 =?utf-8?B?c3h3cXUyNEhsUkFOTS8wWFlZREpXeDNrRFJuNFdrK0xCdFRQbkpPVmJ5eGd5?=
 =?utf-8?B?RXk4L3UySVdlZFZSMHFOa014dlZnY2c2NkE1MUEvdzlnRWE2d2d4MmJibXJT?=
 =?utf-8?B?SEU2bWJCVC9LblpaYnRCeWR3eGVEVjl4K0o0SmFZa082YUNXdk9DMUFTOGgx?=
 =?utf-8?B?TmdUN0dIWGcwZ3RnYVp0aXdFQSszdlFJQjdla2dkOTR6bTk1K1ZDbno1cnhk?=
 =?utf-8?B?aU1zVTdRQ3JHbWNvbzh4RXY4NTV6aHd2ZWtpVVlwVXBMNWdaTUhtT3JKQlpi?=
 =?utf-8?B?SGxBUzk3VGdXWkh0c2NvT2RIR3M5RkIzYW9BQ3VUQ0NaczdZZUZFSHdsMWtY?=
 =?utf-8?B?cjVnTERHMU9oRTVrei9DQUtPR1ZhOEhGQmpnSUtVNXBIV0NKMkV2ODZQNUk5?=
 =?utf-8?B?S2g5SVVraFJmQ0RpbmZGUzhTdHVYeGV3bGthNXFTdWREckp2U2JqTURtL1Fs?=
 =?utf-8?B?d3ZnQlFSSmZKRnd2d2JXRE4vSnZPaWJyTGpjaHg2eEc0MnROd2hZUWxqNWxQ?=
 =?utf-8?B?NGwydmM4TjYxa2N6OTZidUVCL2l0amxlQWpSSWVjdEcvVEdRTnBCTnZ6UjA0?=
 =?utf-8?B?LzdIakNoM1JETllUUjhvdTAwTDdqN2hiUFhubkpFNlZvSEVQcVhkNUNLMWNm?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b77c8d-67d3-4209-aa68-08dcdf1f1696
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 18:06:19.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otloD5ah+lVd+oUZ2d1fCpDmSVLf24pEHYL67JJLveabQseQLMw5PvF3qhgh5Y5SsjSqk6x3hddmgObyhkEh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5312

On 27.09.24 12:56, liuyang@sinsegye.com.cn wrote:
> Hi xenomai:
>     I use the xenomai 3.2.3 with the intel J6412 platform,the kernel version is 5.15.51。
>     when i ported the f81601 can driver int RTDM framework。 I use blow command test the can.
>     #rtcanconfig rtcan0 --baudrate=500000 start
>     #rtcansend rtcan0 --verbose --timeout=10 --identifier=0x123 0x1 0x2 0x3 0x4 0x5 0x6 0x7 0x8
>     then i send the oscilloscope, No waveform. and the interrupt status register Error Warning Interrupt, Error Passive Interrupt Enable and Bus Error Interrupt Enable.
>     then I change the rtcan_sja1000.c chip_init code, this issue is solved. Blow is the changed code.
> 
>     diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
>     index 073a34325..90f6b3066 100644
>     --- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
>     +++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
>     @@ -737,7 +737,7 @@ static void sja1000_chip_config(struct rtcan_device *dev)
>      struct rtcan_sja1000 *chip = (struct rtcan_sja1000* )dev->priv;
> 
>      chip->write_reg(dev, SJA_CDR, chip->cdr);
>  -    chip->write_reg(dev, SJA_OCR, chip->ocr);
> +    chip->write_reg(dev, SJA_OCR, chip->ocr | SJA_OCR_MODE_NORMAL);
> 

You just need to initialize chip->ocr properly in your ported driver.
This is the wrong place.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

