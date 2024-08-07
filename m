Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419415359A
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066167; cv=fail; b=sxw0ifbT167xIWza7kxZKrsVzorZ/EV/hRNDmjtQj6+pDxMXPul5Gd2UsJUW3fSWIRN50CD7LMZb5YEIrvr6G/EuijWDdFBB6JeXDkgzs+Z12iFfW73vGcCYPEiBvVqCktK22NlqIdQmJSgSTqctn0YI2KSRhVXFEykT6t9gbR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066167; c=relaxed/simple;
	bh=iGpaV2ebYT3S4qioAFSO+cphwlFRYcsSnEFzXlX/NBI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=L7ytnmAEA/lOEuYWYVlFk87dNy5grilICA0y+i1Sid3KMcYm8Cm6bPo46+CoK4KgG15K7JZiDqhew82cqOB3va0uoiCLloSyzICC/SWxi9RivVIruRqGFse+V2OWSN5DawVTdnDm2NrceWnYMMt/W1N7uaa/42y/vgg4uRIVCW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VB+oiJsz; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VB+oiJsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhithisEoqyqVHsMvXOms4wFDxJRi5pFLnAWA2oXRzxMSfUkh2RkBXCpbkoZHfpX52Gsu1lo2UPUGxSaJ0MMSUGX5gYZE9noMwRLMMrg36GeX2E7JK6lnuQac+JKxbyZV60wwGqm2e9wnrHH08Mre/9nDuEXyWZOPJcvbfp0K4hlaoCIiU3qceNIEz2/AK1i5LDjUZ+YrYIjvawSY2Li34oqSwRUe4ymuLLCXuly+TAbD0KDQ4vqtSQCfhWBFeZ2yi12kwduA+ZvFfm6SvIDWSlSHoVL9LtZHOOHgLpNvfYOZ94ojIjwEVcWVHi7rbYN9c72gj3EaluyJkRUqpypvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFbp3vZk1JDZ93WzkgjI08EnnW2z8rij1rxe4llYM+8=;
 b=u4Hrp85fdyfiS7SJQDDprYdeoq93ab2qE4WFZPaddlTvFMZ7ikij4j9Hg9TOrAIKBz8DKt6LETc+BaHPuJwiW/YdIhPJ16+cyaEfEWlR+mQEtXDlgDBhC7lBjgM4Bmj1wWUYPFOOUkNAbEyN/t0SQROfLmPbM/p9PkJQ3KLjcUivmzrJQwekN7HnB/A+OxtrQTrn8Hc7vFcUMti3dkmiEV5WPJzl2tLc6asGimdOolUIJNWKfB3cpRZ6mcKQ1BaX7KpDKfuioPmuJoxpf3vaqq1wiUGLyC4Z1lEbX5f3YKemIuGXe/kzPUlWwmamK268V3umQmslkcO4Rh8CfYxghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFbp3vZk1JDZ93WzkgjI08EnnW2z8rij1rxe4llYM+8=;
 b=VB+oiJsz3/yPvWFzvB46izNDJtFxWCRKGkU2t0hwvelzivwCsO6FA2zLQRrHvIzKy+QjyPTuepVgnST28fGJsKctsnPzliuNTXJRsmLAFWiH7LVA+sGA0e5C2EMMrjodHxX3h+OPYYz3VyymFUNOohIO2kptUPERumSpLBA0495lWbSEQEUohoPMxnQxe4YUxY2lSH8q6flJp+3OcHwSMV1+4rHBB5suqmiEz8xKz1NGulUMeho+MH/bMVohsh268R517tWjZ0o1davD7SSVroGLFYtJYpCyvMP7oHVqZnLVOtS0XQNjX9PgtNmTNEb8A6W/qv9xh6qwdANo6/aMvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 21:29:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:29:21 +0000
Message-ID: <c91fe1f4-5f33-4bfd-b869-be2d9ba352a2@siemens.com>
Date: Wed, 7 Aug 2024 23:29:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers: Account for different platform driver remove
 callback in 6.11
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab973c8-c452-4f71-75ef-08dcb7280078
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pHaWNreWJyMzdRQmdnYTlIdjJWMkZmWWx0WTZFTkI4djFxREFBRzZwcTVT?=
 =?utf-8?B?L3NCNnVpZGZFaHJ4S3V4SVNCLzM4dHRTTElqaThOVVpnN3RBMkI0YmFwbXBt?=
 =?utf-8?B?eVF0NGlkNmZ2clZuMVo0cnpLQVhmaEcxM3RGTTNycWNyWnJRN0t3elE5OVNn?=
 =?utf-8?B?MnpxZ242bDFPYlJhV1V1WFNZZVNrY2MyN2IvbnRTbjNHV2RTZFVCejhEYm1k?=
 =?utf-8?B?SFJkZGdDUkMwM0dQQjd3UFhJMjNJSnMybjA5b1JGUkFEMmY5VzNrY3Q1TS85?=
 =?utf-8?B?R2tsTTdORStWVDZ5czdPV2s0RnJHTXJvdzFLM3RxWjNGSkZxYzZlUnBucG9G?=
 =?utf-8?B?dm9FQ2VZalN6akRFK084eUxFV3Bvam5La1JlVktSSWR6RlFlczlJY1pxbng0?=
 =?utf-8?B?TkkvdXMrNU1RUTEwOUVDdTAyRTRXNHlWQWJoVHh3eWQya0R6eTlOY0pINGw4?=
 =?utf-8?B?Z1FtdzNkSjNjU3U4VVUyM2ZCSElUUFBrbjRXaDExaDhQZGZ0dmNRQSt1OUFL?=
 =?utf-8?B?UjQ4b2poVXkvbmszMkVPS1ZYNno0Qk1IZm9heURqck5oQmJQY3FKd05xNkRn?=
 =?utf-8?B?SExjU1pVaVhkUytOQ2lOdVV0aVJDTFNWamg3TXVaTnV3OFFkYVlGdWV4SjlP?=
 =?utf-8?B?bzFPUHVVbEI5T0NVRVFEaFdaUUFBZ0Q2ZUlpWFY5Rld5WWNPRkV5R2xLelhm?=
 =?utf-8?B?Tzc0MWNjVDJJYmhQM2RNZklDTDBoS2hiRHk2Vk52Qm1iRFlpOHZzN05kZjFM?=
 =?utf-8?B?NkxUajdveVJ0cFVUQzlTdlE3TDh6L1kySFIrYy9nUSswSldwMnlMNUNWZm9I?=
 =?utf-8?B?M0l1ZG11N2piWDN1Umo4VS9uSlFIeXp1OTBLeEFQempDUk5sZnJseTA0bXdY?=
 =?utf-8?B?Qkl2RlBCWThiaWovTUZ5dTNscklVVURINW1kUGNoTEJqc3NOVlpUbWU1MUtQ?=
 =?utf-8?B?bVhJMFRiWk00MGhVeTlseTZqRzJoWkFtb1BlaHlOZmNZV0hndUc5ZkVLSFVC?=
 =?utf-8?B?OVM5Qk93UXBrOHVtWnRMNVh6cXBsSk5SNFJtRlJXWkFCbjArSUJ4YnNZcG1i?=
 =?utf-8?B?VU9wZTd1dm05UGE1Snh1SVJyT29zYTRkWG1SU0J4R1NuZldWSHhndVl2aVg2?=
 =?utf-8?B?SVJraXJXR1RvNTRnWTlnT0I2V0lTbFNJWGczM2pNeDJ2RnlvN28vZGhNK01i?=
 =?utf-8?B?bHBianQvZmVTWHRGT1gwbSt5REs2WkdOTGdVUE1sN2VrV1E4d01KcmZudEww?=
 =?utf-8?B?eHcwc0NBeWF6RmFWbml3TVJBVzROSTM0N0lnY2RiTnB4YkpPSE1ZQ05QL1No?=
 =?utf-8?B?R0ZpL1JBS29RMmJuY2s1OXY5a1ZqTHljdW93S1pNWHpYN1hEMlRWYklFUWcr?=
 =?utf-8?B?ZTlRU3hLYWZhYWxSRTRaNHdtRlY2cGs2WTlyMnVQM05KSUpEb3lDcWtjeWF5?=
 =?utf-8?B?NUFMZVlGaThSUEhuNjVHRjZZREVTeWhYZndCRkYyNHBwVy9sREVNWjRZb0NW?=
 =?utf-8?B?QUZLK2VJK1NXTGVSVXlrV0o4RXpmV1lWekVKSDFJZ1lseTJVdHNqUFRpQ3dn?=
 =?utf-8?B?cjkzanZCNWtFUytvQUcvT2l4UTJWL3haYnYwbGZUN2xrbGpOdXEwT3NMdTh2?=
 =?utf-8?B?QXlGY2o3b1lHVTBoRnVJWTFpUFhyODVxdnkxVGdWTkxQWGxWVTN0Y3JyaXlT?=
 =?utf-8?B?V0VWWjkrWUVSUXphQXBWUW5OOER1N1hEZnpjUGxxUVpiWUMycG5zV1EvbUxr?=
 =?utf-8?B?TXM1VkcyKzhTT0FUcVVjMFlXbmM3SnBOTGU4WkhPU044bjIrb3kvcm81aHRI?=
 =?utf-8?B?M0UyQ3V0dzVlYjRwQW5Cdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlROGNDdWZsYncyQjJUc1RtRE81NFlNZ3YxbmsybHFyNFdrTnRRWlNRK2tH?=
 =?utf-8?B?ajBmSEgwTjFyL1dzNjBoRnJicHdpeUdPVXZuaWFjOWVCV2NpbGVTYjR1OHMx?=
 =?utf-8?B?QjdTZHhVZ05zc01vZlA5YUJSVmNYQ25FUndCN1BzenNaMlIwdEgvVjIweEpM?=
 =?utf-8?B?MkVHYUdGZjRRdk5HQ3VNS2l0VWVBY21YVXRpbkY1U3B2WElvMzR6dHRab2dw?=
 =?utf-8?B?ZkdORkdNd2hsQ25PYllGQnhOb0U4S3ZqL01vZkVLYmxIT2JPTDQ0dU1yQng3?=
 =?utf-8?B?WDBCaUVlRHh1QmloYXh5WVBnMzRvS1V5VUM0R2lEZ1FNS0FTRHdPY2F3Y1lY?=
 =?utf-8?B?czdTcU1rTnVETXd5d3NHaGVERkxSL0NHcmNuWlg0Smh2UG5qRXByaGdmU1U5?=
 =?utf-8?B?RzBKR2pNbk9UUlhpdENqZFV5dW4xNkJJN1hvbDZJS1V6Mml5NlF6RUUyaEdx?=
 =?utf-8?B?OENUTmFxbUNaRTh3OHhtT0VFbmtCeHJHQnc1eURYenZ1QnYxYm5RbmRXWW05?=
 =?utf-8?B?SnVFbnYrV25sdGM2dno2eGZldU12YWVucWVZRjEwdEt1S2tKUHNtKytCMG10?=
 =?utf-8?B?K2NpNmZEd1FMM1diaUJ0dE9iTDRaSUVXbEpxVlREQnhjQ0dqQ0Yzd1Z1eTVE?=
 =?utf-8?B?dnQ1WEtxdGF2ZVhrMm1reTQ3djR1aXhOc3RJdWYrazdQRVF6bEttcEdGZExl?=
 =?utf-8?B?M2RUYkRLYXFVMmZmd29mMGRlQ1MvQWdFMFJueGtoRG9QSlVJK0lmV1Z4dUlJ?=
 =?utf-8?B?cnpXajVkT05VMDJ1WTdBNEJhUG5oSmlLZjN2Qms2VGR6TU12OUZpT1R6dmgz?=
 =?utf-8?B?eGhCYjlORmVYaXgxU0RSMkk3RkQ1aDZxZ0hJSDIwRmUyWXdPcCtvTHNCT0dI?=
 =?utf-8?B?SEV0dEpPL2dCNFU4Qy9mUmJJekMwNnlCa0RTbVFiZnlseEJyVnBrK2xuWmhY?=
 =?utf-8?B?N2Q1UVJCTWhFTVpqRmZoTCtoSURWNTJpbXVDQVl1NUF2bHZSUzdNcnVFN28z?=
 =?utf-8?B?cUdKZTNSWURneGZXWFpXRjIwM1dtdGhXTFJtaC92anBjNzI4QVB5cjRObzFN?=
 =?utf-8?B?a0ZDZkswalNER1lGUXFkU2NvbjdWYzdpRDNQQjRVbFh5OStsZVNCZDFWTW9k?=
 =?utf-8?B?UksvbmlncS9GN01uMWZOMktNcHFYT2huOXZyMTBBcFNkeGpiUEg0WnlHRU14?=
 =?utf-8?B?cS9GSUZsN24vNUVEcHc4NTFLY2o4SU1nYm9VMFMwcTEwN2pDcUN0YkE0Qm0v?=
 =?utf-8?B?QitwSXIvQzZUaW4xUmlEZHlNTysxT25RMDBva3p4enZVcm9jOVE4c0ZxVTBk?=
 =?utf-8?B?aFJUT2JxL1M3azNxdmk2Sk1uUEJPUG5ueUllTzFjT3ZZOW0rN3B3VXVtLzRG?=
 =?utf-8?B?U0IrckJCcHpDUlFka1Q1Z01Jd1RGVXMrL1c3RzRSdlNrSS9jV1NGYVVaSHVW?=
 =?utf-8?B?Y2lpemhZVC9CUUJ6ZHNEc25IUkUvQ0JoUzRsZnZpOHF0eGpyTGlpTXlIcVVj?=
 =?utf-8?B?RDRiSlBpSHhHeUhSdDIwRXZjRmhDTjRXN1YzZ1V6ZjNpK1BDZlY0dTRIM0hQ?=
 =?utf-8?B?MXRQNXJwQWZaQTdUdlJWZzR6bEhqVXFETHBPeUd0NmpxZmFscGo2MS9pNUlP?=
 =?utf-8?B?THJUQUwxK0dKUlhON1VzaXA2cTFMbnlkV1JLMjg0cjYxczlPRzhLVzR6UkE2?=
 =?utf-8?B?U1IrSU9VSkJlWDhXVFlTMHpLcThHNGUzS0NPWG5hQVJLZitKbnowSDV1a0cz?=
 =?utf-8?B?cDJUOUVnQy9pbE80TnRWdFJ6d1NrM09ZU3NjalRXdk9QUXlqMG14WmdYcHMr?=
 =?utf-8?B?ZVpDb1BSYnllQzdEcS8yby9iQ2VBLzhQVHRjSk5rK29ZcHdSVGxoNnpaQTFi?=
 =?utf-8?B?RmhJdEx6a1dpQnhrS2NtVUlKNmx5SkNJL2tJOGpRMkU4dThTWitXdXhUOHc5?=
 =?utf-8?B?elBNRnlqTlhCZ0pCemdnemhEbjhCUzlZMFNBaGpEUEYzZkUrVjRCSmtDb2V5?=
 =?utf-8?B?dGl3MnlRSGYvSTFwK0RtamxIK0l6a2NOU3hBdmZDSnU2UU9sQWEyWDJtSXRN?=
 =?utf-8?B?b050TGpVYWpweE56RkphY1hMMG9SRjI3ZFdVT0c3MHZ0SDZqYUc4RXV2NUZT?=
 =?utf-8?Q?Qs/qu5/JQ8l+owYQJMGMAD2Xq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab973c8-c452-4f71-75ef-08dcb7280078
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:29:21.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiHtzxJQcU3f8/BtiGZqp6POkhhZISGdKZSVkwrygOQISoz+TQkvpM4WL0YHXsToO1/CRnrdcBie1EZHP0/u4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8084

From: Jan Kiszka <jan.kiszka@siemens.com>

Unfortunately, this requires a bit of #ifdef'ery.

The fec driver was the only one actually returning non-zero as well.
Adjust it to what upstream does.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../drivers/can/c_can/rtcan_c_can_platform.c  |  6 +++++
 kernel/drivers/can/rtcan_flexcan.c            |  6 +++++
 kernel/drivers/net/drivers/at91_ether.c       |  6 +++++
 .../drivers/net/drivers/freescale/fec_main.c  | 22 ++++++++++++++-----
 kernel/drivers/net/drivers/macb.c             |  6 +++++
 kernel/drivers/serial/mpc52xx_uart.c          |  6 +++++
 kernel/drivers/serial/rt_imx_uart.c           |  6 +++++
 kernel/drivers/spi/spi-bcm2835.c              |  6 +++++
 kernel/drivers/spi/spi-omap2-mcspi-rt.c       |  6 +++++
 kernel/drivers/spi/spi-sun6i.c                |  6 +++++
 10 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
index 0d29d98771..aef6f8895c 100644
--- a/kernel/drivers/can/c_can/rtcan_c_can_platform.c
+++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
@@ -432,13 +432,19 @@ exit:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int c_can_plat_remove(struct platform_device *pdev)
+#else
+static void c_can_plat_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtcan_device *dev = platform_get_drvdata(pdev);
 
 	rtcan_c_can_unregister(dev);
 	rtcan_c_can_dev_free(dev);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver c_can_plat_driver = {
diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index edaaad7031..1658599232 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -1482,14 +1482,20 @@ static int flexcan_probe(struct platform_device *pdev)
 	return err;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int flexcan_remove(struct platform_device *pdev)
+#else
+static void flexcan_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtcan_device *dev = platform_get_drvdata(pdev);
 
 	unregister_flexcandev(dev);
 	rtcan_dev_free(dev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver flexcan_driver = {
diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net/drivers/at91_ether.c
index f8223b0bc5..a5ef40c579 100644
--- a/kernel/drivers/net/drivers/at91_ether.c
+++ b/kernel/drivers/net/drivers/at91_ether.c
@@ -421,7 +421,11 @@ err_free_dev:
 	return res;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int at91ether_remove(struct platform_device *pdev)
+#else
+static void at91ether_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtnet_device *dev = platform_get_drvdata(pdev);
 	struct macb *lp = rtnetdev_priv(dev);
@@ -440,7 +444,9 @@ static int at91ether_remove(struct platform_device *pdev)
 	clk_disable(lp->pclk);
 	rtdev_free(dev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver at91ether_driver = {
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index d1b6fd166f..9561fbc589 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -3522,8 +3522,11 @@ failed_rt_init:
 	return ret;
 }
 
-static int
-fec_drv_remove(struct platform_device *pdev)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
+static int fec_drv_remove(struct platform_device *pdev)
+#else
+static void fec_drv_remove(struct platform_device *pdev)
+#endif
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3532,7 +3535,9 @@ fec_drv_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev,
+			"Failed to resume device in remove callback (%pe)\n",
+			ERR_PTR(ret));
 
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
@@ -3547,13 +3552,20 @@ fec_drv_remove(struct platform_device *pdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
 
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
+        /* After pm_runtime_get_sync() failed, the clks are still off, so skip
+         * disabling them again.
+         */
+	if (ret >= 0) {
+		clk_disable_unprepare(fep->clk_ahb);
+		clk_disable_unprepare(fep->clk_ipg);
+	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	free_netdev(ndev);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static int __maybe_unused fec_suspend(struct device *dev)
diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
index 77957d9062..6da5761479 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -1769,7 +1769,11 @@ err_out:
 	return err;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int __exit macb_remove(struct platform_device *pdev)
+#else
+static void __exit macb_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtnet_device *dev;
 	struct macb *bp;
@@ -1795,7 +1799,9 @@ static int __exit macb_remove(struct platform_device *pdev)
 		rtdev_free(dev);
 	}
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver macb_driver = {
diff --git a/kernel/drivers/serial/mpc52xx_uart.c b/kernel/drivers/serial/mpc52xx_uart.c
index 68d1a4cbda..1347ac0b38 100644
--- a/kernel/drivers/serial/mpc52xx_uart.c
+++ b/kernel/drivers/serial/mpc52xx_uart.c
@@ -1360,7 +1360,11 @@ out_kfree_port:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int rt_mpc52xx_uart_of_remove(struct platform_device *op)
+#else
+static void rt_mpc52xx_uart_of_remove(struct platform_device *op)
+#endif
 {
 	struct rtdm_device *dev = dev_get_drvdata(&op->dev);
 	struct rt_mpc52xx_uart_port *port = dev->device_data;
@@ -1376,7 +1380,9 @@ static int rt_mpc52xx_uart_of_remove(struct platform_device *op)
 	kfree(port);
 	kfree(dev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct of_device_id rt_mpc52xx_uart_of_match[] = {
diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 2b2dbeeb72..bc5f4a8ed7 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1597,7 +1597,11 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int rt_imx_uart_remove(struct platform_device *pdev)
+#else
+static void rt_imx_uart_remove(struct platform_device *pdev)
+#endif
 {
 	struct imxuart_platform_data *pdata;
 	struct rt_imx_uart_port *port = platform_get_drvdata(pdev);
@@ -1610,7 +1614,9 @@ static int rt_imx_uart_remove(struct platform_device *pdev)
 	clk_disable_unprepare(port->clk_per);
 	rtdm_dev_unregister(dev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver rt_imx_uart_driver = {
diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index fabfd4a59c..4a1a6f201c 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -670,7 +670,11 @@ fail:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int bcm2835_spi_remove(struct platform_device *pdev)
+#else
+static void bcm2835_spi_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
 	struct spi_master_bcm2835 *spim;
@@ -689,7 +693,9 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	rtdm_spi_remove_master(master);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static const struct of_device_id bcm2835_spi_match[] = {
diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
index 976d28dc5d..6b5c11b71d 100644
--- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
+++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
@@ -993,7 +993,11 @@ fail:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int omap2_mcspi_remove(struct platform_device *pdev)
+#else
+static void omap2_mcspi_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
 	struct spi_master_omap2_mcspi *spim;
@@ -1010,7 +1014,9 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 
 	rtdm_spi_remove_master(master);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static struct platform_driver omap2_mcspi_spi_driver = {
diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6i.c
index 72a4abd0d7..13dd325c91 100644
--- a/kernel/drivers/spi/spi-sun6i.c
+++ b/kernel/drivers/spi/spi-sun6i.c
@@ -629,7 +629,11 @@ fail:
 	return ret;
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 static int sun6i_spi_remove(struct platform_device *pdev)
+#else
+static void sun6i_spi_remove(struct platform_device *pdev)
+#endif
 {
 	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
 	struct spi_master_sun6i *spim;
@@ -645,7 +649,9 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 
 	rtdm_spi_remove_master(master);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
 	return 0;
+#endif
 }
 
 static const struct of_device_id sun6i_spi_match[] = {
-- 
2.43.0
