Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954031BC068
	for <xenomai@lists.linux.dev>; Fri, 13 Sep 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212197; cv=fail; b=i1nne9EWGI/EiOs7jFN2DPkzTHOHoHkr53gfSPdqIf9DkleQiqac2qj7pq0qRXPUBDIwzMgAGKi7K4F/aqtt3lbauoh5G0JjAZDbhWFEDWk4lzjRQPMV1vTlLsnQY7xvpeOl9bY/lssLMPC7WSquTihlGPxuu4kLjww6w9AyPds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212197; c=relaxed/simple;
	bh=ybAAK74JC6XLE5vUOeJLAdxRWK1I7KC7CegBVh7LWeg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDZixSlE0Xxe+ZkJd1Vj8KCoxCMz63hQwU0JxVlP+nx5he7Eor+4hMqEGb85ogaKHl/GdULzDQCPp0UR4EHrIW/GrUXpvDyb5T41EVHXZ55om84WC7TuQGhs4cVGyeFjeKrwiGq+2ynH+5qQte+qjlV0TPKS16BXla17dAPTKR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=x4kwolZ5; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="x4kwolZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiMt6JfB4YqdOCjJX9JBRvFWxeeLFIAxMW73NWkGatgOFFIZ5cGLKiCKKVGJ/6ePdsBJtlaJyjWkt9RICn90ycfC72HggDyLQEbht51yc1KJEuY4ydzD9uZGXWQ+tgkmNi6eaI7RQcfFkTcfDHQ9LstiyGQnhe0Yk6SN1bEQnJVktfo0FG8H6+R7m3RrX0B4hlYRui1cyoaTrOqis716uaOyz7v3Q5WbMp6zBzMSVzwWIWYqq+qywuB+5wc6c8m/DwizvNUWJgjdZsgLQ1rsAuf9uHNuZdCYR4kBLJ+IhqT7BLv/YhOnsS/nRnWG3jRNw17unn3XcQqU6a/FNs3PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/USIBqUI5URkBQadULyp269+eI1PyoKyuJ2mBZdMNSw=;
 b=rEA1DA4CDSYmasV1xY5ntyZ/vZuftVM+3DSSOovRUtYIvPAlqVH+QpuRVyDDIqSYt1H8idxt3yk30WWYmuuWEujt4e2lduxQQ1LZieX/HJ5whzQEr7j+EqLNGHq7WbbsctSXe4rm3o+gMVGDbvFgW0/JpwgtgNUtWtoD7fnLz7mxOM8Qa7+cxWl5eu3zcIkR9T6TAqWwQIV+57J/DRZVIDkSvcboFH8qvOgKVB8b9O4p2cBVRgB/1fmiwurmkFwAjkCBJhajXr5tS31zFb94lQaMTYA3BjU0n1M3U66VM+puzvqev9kLeXNwIfXoM/iD5hITRhX2ucTC/FgiezL8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/USIBqUI5URkBQadULyp269+eI1PyoKyuJ2mBZdMNSw=;
 b=x4kwolZ5g+vfhEOpaRXmoi+n3U3TDsIpMFSL6reA1vS4ucXIL/UsZpYr5uEGUH4j+vWstSg68UNGrMTz6QuC1kfRKBErDaSMosqgkfAtc/0lDun4I03WyRXZFKqbrWI4yqHw6Z85XoIq0xzi4yP3M0h69yVU7AJckj+mCaaFAd1l4oUGZOlZDUMk+SV5uQVI7GleVExQ0aFlb5V6ig/RFCKGbtdAdLIlSgumdoNG5MYm6R+lQ/affqOvRA1R4xNL2oW16nGCewUOdp0BB52Lp0jcHelgIoLGtCfogwiCryfJg6GdQap9uaGQ3nr+Y4TOT5O8p0hk0tzvz5mQNeKPHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:447::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 07:23:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 07:23:11 +0000
Message-ID: <bdc43e8c-7cce-4a94-a0aa-cdf2086c7ea0@siemens.com>
Date: Fri, 13 Sep 2024 09:23:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: testsuite/smokey: Cleanup coding style
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240911144452.182645-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240911144452.182645-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7b30f9-6dcc-44a2-ccd4-08dcd3c4ec95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFVV1UyTjJNK3lpalZFYm9NQm13OTlwUmN4bkY1YjlLcEJTMExHdHZrelMy?=
 =?utf-8?B?cjJ6SWRxM1hmTFpxNVY0WnRHb0dxK2xPMCtRV3E5eGo1cVFaMmZGQU1SbGdS?=
 =?utf-8?B?Ymszb3dMa1BaUEZ6Wkt3aURKcHE1REhqOEZIZk5nOGFUc1FpdDd3YVplNFNm?=
 =?utf-8?B?dTNsNi9XYzJKSUZ1QUxRRG9ETXVuU2t3ZXhxVGNONDBVWWk4NTNxR2NUaXB1?=
 =?utf-8?B?aVE4UEM5akdJdEFITCsvMHFySS9pMWY1SmQ3RVh2Qlg2dmNmUEFXNVJEK1dB?=
 =?utf-8?B?VTRmd1JlSDRjU2E4aTJSdnJoWGVjQS9mOUxuQWh1TUk1WVRJdzdkMit5RDBs?=
 =?utf-8?B?Tm1qN3RsZVRha2hPZlpJeE9HbWgwcWUvdXhiV2gwL0w5eG9OeDQ5OVlFamJh?=
 =?utf-8?B?S29ERDgrVFZVdTlicG03L21rOGpWaVRXVno5alFSbnVIanRVTkdNTGp2bllz?=
 =?utf-8?B?QmY4bzkwQ2FsVU1jUzJxWm1DbmZDQVJQSkY5bFlUY0ExTlVoY1F4WXh2bW1r?=
 =?utf-8?B?S0JDdUtFTXhyT0xjR2RQWXVPZkpuYXovOUhUcjU0blk2VFVpZVFaaGxKbDIw?=
 =?utf-8?B?dTJSWllPK3VtSHJUQlVZRmtDL1YzUGVaVWtXSmxOR2l5ZTNMY2xZektwUHQx?=
 =?utf-8?B?b1dsWEtJbUhPUWdMVjJEbmdxdmtrM2oyUEhjcE1HZ0N2VXY5TGd5R3ZYS3Fu?=
 =?utf-8?B?d0dhM21VNlkwOTJRK3FMZGk2UC9zR2FZdU9Fdk13WisvTWNHVHpRN04rRGJQ?=
 =?utf-8?B?MlZTSGU5dlkwTzNHaUJ3Y0xsdEhNZ285TXVHaDBzZEl5TnZiNU5NNDU4dUxq?=
 =?utf-8?B?WWttN1NEdHI0Y0tUNDFjOURndGpOaVhLSnp4eTJmZDNWMVJWZnE1Rk5zRUxr?=
 =?utf-8?B?TVZYTEcwZmFsRUZZenNSTG9jK2MyMHdlamVjOUlnTUdLRDA4N2tKNjV4ZlQz?=
 =?utf-8?B?ZVhwVW9iZXV1WHhiTlQ1UitmVVJRQ3QxaXZCaUhSRnF3eCttRXQ4UlZJM2VZ?=
 =?utf-8?B?Z1Q5aHBoNUYrTXZUamxQc09sYzBBZDVjMndTaXlMN2ZqK3FNc1FrbDBtanBq?=
 =?utf-8?B?REFhRGJEdWo0VXg2YzFSbjFMc296UU1oNGJtTnNzSVl4SVNQczVBbDQ5WGlN?=
 =?utf-8?B?bDlYTjVWQkFYRG1xeGc3bjlMQUJaU25ub25NMDNKUmdtMWxtdkZJNkcvbVJK?=
 =?utf-8?B?aHBJeDVHYlQ5TlBQeE9Sd2JTcXFFVXlWdUZkWExGeXBGQnNINzk5U3dsMjE0?=
 =?utf-8?B?TWtDemdnRVVFNGM3T2RtWTFTdEdoVEljdGNCQ2lQcjBGTm1RdTlZeDlkT0wv?=
 =?utf-8?B?ZDB3c0FkZy9xM3pTZzV0dUJxekR3ZUtraEhORUU4U3dRamJkQkpWdDh5T2Zi?=
 =?utf-8?B?UTZMbjQ3YWo3WURSN2RrWkhLS0pYb1IrNUZQMUJvWW92VEJDWEhpRjl3WlZZ?=
 =?utf-8?B?RUNrdmU3VE93NTZJL1VuUUgxQkNySlJRUS9Jc0J1N3ZCVDEwdXVNRkI4QTF0?=
 =?utf-8?B?RDNYOWNNM2cxMzZ3Vm9ETTcxTXJNaXVGM2lCbnRNbS9Kbm1BMVNOa01LMkhW?=
 =?utf-8?B?Z1F2d0g0QnVYTkpZemxPaWk3Q3phYmFaTDArdjhaT2ZKbWRuQUFldHlLdlRE?=
 =?utf-8?B?NndUZE00VEhrS1hTRlZwdUVqQ1pyWk93YldLb2hsTzV4MWo2Z3QweWJPa2Rx?=
 =?utf-8?B?TkQ3VENqaU9IVHVKU0MwbjZWV3hDT3IxNWVHMlEvMXF6ODRZR295cHNTRFBv?=
 =?utf-8?B?eXp6UEdNTzI0eXNTQU43RjlnQnRZNWxtdERZZ3hub05mRHVEQUg5TFZ2bENL?=
 =?utf-8?B?NWJRS1ROSkMvQVhmRG4vdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGQxcFBPUm9PYXFHZ2dJRjFzR2ZyZVpCYVh4Qm1hQnUrc0xTU0t0K294STQ0?=
 =?utf-8?B?OHpBd3N3K3VMUW5IQ1Z2TzNLeCtBeDNOcWhKYXdCSXdybS9xZGlxb0Q1Nk5D?=
 =?utf-8?B?dEUwSDNzcVlzMVduZUZNSEc4bE9PVkNxQkF1ajREQkNWWURXRklRZDJuaHpr?=
 =?utf-8?B?NlBQazY5K0hBeWNyRVVLbW1TKzloSThVOHp2bHpGcm4zQmNBVFpHMDFmaU83?=
 =?utf-8?B?a0V1U0t2R2tSNnI1alBtYkkyeUx4K055WE9abFhVY0svVDZtZVRRVHM1R0pI?=
 =?utf-8?B?TnhHZmpaSWZKays0Zmw2RTFpV3p5d25YMTBtRG9VN0FDSnRxT1AvTmQvZWQr?=
 =?utf-8?B?ZHFsS2Z6a1JyNUxsS0ZKVDAxMnFxTXBvWFoyZEZwVFRxTEkvQUlhMjczTzkw?=
 =?utf-8?B?S3J1aWRDVDBFZmFzbEU4cE83cUtwWGhUT3BnMWQxbWU2NDJPOTMxUVQ0UW1M?=
 =?utf-8?B?YmJDenlwMC9XUE5SVG00VmxSdFBJUGowZUZYZTNCMjk2dGVVcURRdlY5YzQ2?=
 =?utf-8?B?dFBNeGVVeTZxeGQvcHR4Y1VJKzF2WmdBN2RTNHVLRjRFMWVGbVh3eitPUEhW?=
 =?utf-8?B?cE1sZFZtNkVIZHBoVzhxcWtVSFdldGdEc0hEWXVyWjhkOUFWQ0dxS01hNTlT?=
 =?utf-8?B?WWI1VTNUU0NrOFV3NFdhOFBFdm43ays0V3hpWXNCYmdoQ3VrYmJLTE8vdFJL?=
 =?utf-8?B?WnQvS0N1Q053b05rRHNjTy9lc3VHRWFMUXVkREtkSDZTampNSzQ0R01vUnE1?=
 =?utf-8?B?QkJoL0hsUXU4d1BOZUVQYktJZFJsN0FlY0Z0RGQ4bHNqV3FqZTNMMlgwd1Fz?=
 =?utf-8?B?RGNTcDU4MmljclJMVlBvS3E5NFpTVXZLWlp2cXhLK0RnTUxYL0FQcGR6ZytG?=
 =?utf-8?B?cmVZM2ZwVkxIOXpSdlpyVE00d241VnhNdmgyOUxvMG5WVGpoQTBibVExR04z?=
 =?utf-8?B?SjZiMDBrN3VPcXRmQmJWQTJNSnhxUlZnc2tGNmpzRS9zOUdOUmZzeDFRYWxL?=
 =?utf-8?B?TGNDeGR1OWo0eTBRbGYyZHlDR1NqeFpwL3UvWGhubnJ5ZFB3dVFhcjVFNnI5?=
 =?utf-8?B?WnppTWNPMTVCWWd3TXd1RzFyUzR0aUN4NFIwbm9wMHpCNmF2ejBWL0RCaHhF?=
 =?utf-8?B?NUtjb1RaeU1Ic0xDTGhlM1l5dEFQemNQOW93bjhyN25qdE9HS3UvL0JGemZH?=
 =?utf-8?B?YkRqUEJmYm4xOC9jQjVMeTdLV3N0ZnNseTBOcnF1YS9NRndrZmRjbkdOaFZQ?=
 =?utf-8?B?emVHSHJ1QWcvdldwVWFhbFVZdGI1MGRlUGlkUmhlOWp3cm4rSXZKMkJPK0NR?=
 =?utf-8?B?c094V2pRU3k3V0lTWndMeWZQRHZzdnZ1V1IvNmV3VHhSc1dVZExQSHR6NXJy?=
 =?utf-8?B?WHJwT2I3WTRSNXN2MXRJQWlhYy8rNGF4QkVxVFBRNlZ1d09WRlV2eGVNeGRQ?=
 =?utf-8?B?SEg5SDg4TUtqSmU4azFnS3NiUlZhMFNldDR5VHkvNEhBZ20yb0tMMXljTith?=
 =?utf-8?B?Sktid1BJaVIxR2xqK3M1TGovcDJ5bjdIbVE4bGpMcUNsTGZ3WTNaM1N2VVhL?=
 =?utf-8?B?ZDQ4MVJqVmNSUkNmajZZZmFaZU1FOTAvV0F3czFaMnhjNjJRd0Z2aGR3L3FD?=
 =?utf-8?B?V0NKYkdsYzFwVERVRkgwSHM3VzVEdlpKQmoySzNmTlhqZjZLbWNlYkw3MmV5?=
 =?utf-8?B?VGNpNi9WZXI5MzkyYXFLeFZDTnJkdkh1UzhSWWJXUlVmQ0VCdDZLOWRiRm9I?=
 =?utf-8?B?c2c0MEI2S0RPbGlyc2lQbUZLYnJqT0pXKzZmUWZTTXQ1ZDVTUndVMHdUQjlz?=
 =?utf-8?B?dkhHQkxMaGxzNm9rRGxYd2s5NUlpZkxia2UwdGZjNGtSMEJrTDZMWTV4TXdV?=
 =?utf-8?B?TXB5c05ocnhGOFJQWnUrUmtCMTc1bmpwYURwSVhsZDdkQ004K2RGRXNNMkYv?=
 =?utf-8?B?ZGFoMGswREpJWlpNQlp0U2JiTlNnazYxd0I5QnlvQU8yUURwYzlFOTZOc1pT?=
 =?utf-8?B?RWJvZmQ2QmZRWHZ1OHE0OHJSK05ReWliVlFIMWtnMmU1TkZvVExVNjFPU1du?=
 =?utf-8?B?aTNIRlorRlhBMzJrekY1WVdiUlJ3a1EveGpxYjdQa3FlOEFTV2RFVEFaS3pw?=
 =?utf-8?Q?ut2grJjrB+emarj2cqcY48NJc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7b30f9-6dcc-44a2-ccd4-08dcd3c4ec95
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:23:11.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT7RrzJgr0XvGTcYe0GMemrtoJClowERlCkBb0R1wuAR2mX69UNzD12ny7RlhzgK1uMkREqJMs308o85xt4M0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8969

On 11.09.24 16:44, Florian Bezdeka wrote:
> Seems that we didn't follow the kernel coding style strictly in the
> early days of the y2038 implementation. At least we partially ignored
> the "reverse christmas tree" style for variable declarations.
> 
> No functional changes.
> 
> A redundant GPLv2 hint has been removed as this file already has a
> correct SPDX tag.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 58 +++++++++++++-------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 91ef5258e..0817d2004 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -2,12 +2,10 @@
>  /*
>   * y2038 tests
>   *
> - * Copyright (c) Siemens AG 2021
> + * Copyright (c) Siemens AG 2021-2024
>   *
>   * Authors:
>   *  Florian Bezdeka <florian.bezdeka@siemens.com>
> - *
> - * Released under the terms of GPLv2.
>   */
>  #include <asm/xenomai/syscall.h>
>  #include <smokey/smokey.h>
> @@ -161,11 +159,11 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
>  
>  static int test_sc_cobalt_sem_timedwait64(void)
>  {
> -	int ret;
> -	sem_t sem;
>  	int sc_nr = sc_cobalt_sem_timedwait64;
>  	struct xn_timespec64 ts64, ts_wu;
>  	struct timespec ts_nat;
> +	sem_t sem;
> +	int ret;
>  
>  	sem_init(&sem, 0, 0);
>  
> @@ -245,9 +243,9 @@ static int test_sc_cobalt_sem_timedwait64(void)
>  
>  static int test_sc_cobalt_clock_gettime64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_clock_gettime64;
>  	struct xn_timespec64 ts64 = {0};
> +	int ret;
>  
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> @@ -276,8 +274,8 @@ static int test_sc_cobalt_clock_gettime64(void)
>  
>  static int test_sc_cobalt_clock_settime64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_clock_settime64;
> +	int ret;
>  
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> @@ -294,11 +292,11 @@ static int test_sc_cobalt_clock_settime64(void)
>  
>  static int test_sc_cobalt_clock_nanosleep64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_clock_nanosleep64;
>  	struct xn_timespec64 next, rmt;
>  	struct timespec ts1, ts2, delta;
>  	long interval = 1;
> +	int ret;
>  
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, NULL);
> @@ -358,9 +356,9 @@ static int test_sc_cobalt_clock_nanosleep64(void)
>  
>  static int test_sc_cobalt_clock_getres64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_clock_getres64;
>  	struct xn_timespec64 ts64;
> +	int ret;
>  
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> @@ -389,9 +387,9 @@ static int test_sc_cobalt_clock_getres64(void)
>  
>  static int test_sc_cobalt_clock_adjtime64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_clock_adjtime64;
>  	struct xn_timex64 tx64 = {};
> +	int ret;
>  
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> @@ -461,11 +459,11 @@ static void *timedlock64_thread(void *arg)
>  
>  static int test_sc_cobalt_mutex_timedlock64(void)
>  {
> -	int ret;
> -	pthread_mutex_t mutex;
>  	int sc_nr = sc_cobalt_mutex_timedlock64;
> -	struct xn_timespec64 ts64;
>  	struct thread_context ctx = {0};
> +	struct xn_timespec64 ts64;
> +	pthread_mutex_t mutex;
> +	int ret;
>  
>  	if (!__T(ret, pthread_mutex_init(&mutex, NULL)))
>  		return ret;
> @@ -567,10 +565,10 @@ static int test_sc_cobalt_mutex_timedlock64(void)
>  
>  static int test_sc_cobalt_mq_timedsend64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_mq_timedsend64;
>  	struct xn_timespec64 t1, t2;
>  	struct timespec ts_nat;
> +	int ret;
>  
>  	mqd_t mq;
>  	struct mq_attr qa;
> @@ -650,10 +648,10 @@ static int test_sc_cobalt_mq_timedsend64(void)
>  
>  static int test_sc_cobalt_mq_timedreceive64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_mq_timedreceive64;
>  	struct xn_timespec64 t1, t2;
>  	struct timespec ts_nat;
> +	int ret;
>  
>  	mqd_t mq;
>  	struct mq_attr qa;
> @@ -746,11 +744,11 @@ static int test_sc_cobalt_mq_timedreceive64(void)
>  
>  static int test_sc_cobalt_sigtimedwait64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_sigtimedwait64;
>  	struct xn_timespec64 t1, t2;
>  	struct timespec ts_nat;
>  	sigset_t set;
> +	int ret;
>  
>  	sigaddset(&set, SIGINT);
>  
> @@ -821,11 +819,11 @@ static int test_sc_cobalt_sigtimedwait64(void)
>  
>  static int test_sc_cobalt_monitor_wait64(void)
>  {
> -	int ret, opret;
>  	int sc_nr = sc_cobalt_monitor_wait64;
> +	struct cobalt_monitor_shadow mon;
>  	struct xn_timespec64 t1, t2, to;
>  	struct timespec ts_nat;
> -	struct cobalt_monitor_shadow mon;
> +	int ret, opret;
>  
>  	ret = cobalt_monitor_init(&mon, CLOCK_REALTIME, 0);
>  	if (ret)
> @@ -893,12 +891,12 @@ static int test_sc_cobalt_monitor_wait64(void)
>  
>  static int test_sc_cobalt_event_wait64(void)
>  {
> -	int ret;
>  	int sc_nr = sc_cobalt_event_wait64;
> +	struct cobalt_event_shadow evt;
>  	struct xn_timespec64 t1, t2;
>  	struct timespec ts_nat;
> -	struct cobalt_event_shadow evt;
>  	unsigned int flags;
> +	int ret;
>  
>  	ret = cobalt_event_init(&evt, 0, COBALT_EVENT_FIFO);
>  	if (ret)
> @@ -972,14 +970,14 @@ static int test_sc_cobalt_event_wait64(void)
>  
>  static int test_sc_cobalt_recvmmsg64(void)
>  {
> -	int ret = 0;
> -	int sock;
>  	int sc_nr = sc_cobalt_recvmmsg64;
> -	long data;
> -	struct xn_timespec64 t1, t2;
> -	struct timespec ts_nat;
>  	struct rtipc_port_label plabel;
> +	struct xn_timespec64 t1, t2;
>  	struct sockaddr_ipc saddr;
> +	struct timespec ts_nat;
> +	int ret = 0;
> +	long data;
> +	int sock;
>  
>  	struct iovec iov = {
>  		.iov_base = &data,
> @@ -1097,14 +1095,14 @@ out:
>  
>  static int test_sc_cobalt_cond_wait_prologue64(void)
>  {
> -	int ret = 0;
> -	int err = 0;
>  	int sc_nr = sc_cobalt_cond_wait_prologue64;
> -	pthread_mutex_t m;
> -	pthread_cond_t c;
> -	pthread_condattr_t attr;
>  	struct xn_timespec64 t1, t2;
> +	pthread_condattr_t attr;
>  	struct timespec ts_nat;
> +	pthread_mutex_t m;
> +	pthread_cond_t c;
> +	int ret = 0;
> +	int err = 0;
>  
>  	if (!__T(ret, pthread_mutex_init(&m, NULL)))
>  		return ret;

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

