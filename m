Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4583CBB
	for <xenomai@lists.linux.dev>; Wed, 21 Feb 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540250; cv=fail; b=KR3MFfDdtn3D3VJzjf0M94BYszmtr3xa4d6S0dY8A+TemXmhepudN9OixZ2VJ7zlFwc1HA2RpymqCaPC17G/VJIgyHGAU2tQLwcsU8DJp/b4Zc/7b9nBV+MmKX5siuwdFNWCmvDQUAju1WRr4CIN6C6Da6abg14FQHAojqPnO00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540250; c=relaxed/simple;
	bh=4LPTMe/4FFzELwF56f/evHodm/21HIRWRoIRvAqSUOo=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=AW/8m/ToQTnoY4JVg4AkxlbhiPQz9yUpsLVeyMqcb1ssOlFupdj6IIZf8HOGaAjWVOGBCKpdV50nYLNPOS9e5L4fljXeSwWV2d7aD9Ha13S+oOftv8/S6MFZga/56r8Lud5LVlL/Pww2sxQLrvoJi2rXeDdPZfBlAYy160RVCgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Y+I/c3eT; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Y+I/c3eT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E43WXuRJjhNWPgXnT4BWKPuiJQ/g1ye+MZ5BTzqBBANIZmqfWbBUJNfoPMs5hFyft6BfEQ5gtAjtI0uw16OntRkLNpk9QQtw08H6mAe4oI9w1HhLPIbbVBX16JeUFjQc7IiLrWmJMMUxh3vfFb2H/zFr+z5ISldkn8CHKmfN7gYLa6cbL8R/ijjTYdu0JIRh2rBdo+YzmWP5LvtaX5IPpdNmKp1jLyjk1AfoDJo+DNC/L5H39PbJ1nCywXGCh4epSH7p143EzUbCcqpPjUyFy8CEloZmIdOgQr7wh++TIVB87gMRR88Z21Me3OQ7b7fF6NGK4vvXmDVTCeDbKZVvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6CzjmbFKI0IaGNhsbzle1sXZIoxcYkDkM4outA1rWQ=;
 b=bJALlPxxdCFtEk9x91BxozZUrm5D3F8LQn0AyI1gi5ClKEBFyHuqtLBIwgNElO/Gm/LEK8jsg63+t7rx3tuXwmv31AkQmja+cIWAZnC60XsYT44xCEptQA9WCFWkvztn14xzYknSKou2Yffo7KimeTkbmXxFblCwm7en5FegOuXZ6eC9MaPSgdJs9tObSMC2qSvWUTZa1GCed62edAvZEkskEcbCxs+BuD5QWNuk8nfB+oWdaEqm1yTE5J91ttZqZihAqfVf1MH1mdE8YO7WczpLaD4kWyFXPKmak4CFLduicD6jszI+7l6viw63rfWrf33eFCtYSRpaS3ig0Yx5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6CzjmbFKI0IaGNhsbzle1sXZIoxcYkDkM4outA1rWQ=;
 b=Y+I/c3eTzekovRunsJUNuHoMKABy9A5RrEcWscquBJIfMB6REQDP5OJuihfCmFYqg5SUluX9pa/iMmLgGOhXmO2cTGkwl7RrelS2Nmkqvlh97f507nOs9wMUiaWRxZ/9e+JPc3XiH/6d6HKMIZ3MGkiWZ0BIJ97jVI9V8zx4qgV5ZfAIda/lVHDAV0LDxUq0TewwUeB1UPLjA8KiG/dEoYrnzpNICOCkoM8YQzYCM03wobmwvxPc6G270u9B+2sHEn2vAvKHWBpeMlcdu5TqOJ1HmqP7JgLfNBmYjfE/vM2MYDttb24eUmatUIhMuC2Bqv0MYU8C/62t3/a4XWRPIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:404::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 18:30:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 18:30:45 +0000
Message-ID: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
Date: Wed, 21 Feb 2024 19:30:42 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: dovetail kernel maintenance
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e4e1fa-c0ef-4988-aa1d-08dc330b378c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T+BLOn4B5SiXVfY3FkFFAzKkIb5Nlw3mN3Q3ZYAaGAg2CqvSXspnjk3TPWaff4HmjOW6Yg5+1l3fbO7tKfv4fHP3h53wvykkneofsrZAUzoHyOwgtKasRozwHj97UmXU7V9P4GFMBdHXlat5R/fGQtw2TM3x1SFB+AKPkpwkMJWUSFD+yxfQAIw4gpGaB02N6VORygD88NDAvKylSpRz5EGfdseV8snBwXa9alp50YDlIpl3tu6O+B4T9t+YYRZBZ0UznNCBpCZLJvVhXaVuRFvhdFFl+KifMKMbBdJ7FLK+gbyyBASMJQJGaEVFmInpevY9R09xGUWZMeghePIBZUa9vO+nk1IPoCaWOXflco2nxIAf/JV6avB4nrsV0uBh84yoL+jA4x62rlP9UL1kgJ0HaiS9WFTMJ5Ueq1Jepxd3fNRGO2txLwkfsHae8Zj7aEFVfRDgijjzH88DtLcZyAz/H0XTxZ7rN9ZCmtGulLhDPBvaKFsMoVDAmTXfCrDsgWNbAUFvYoiCv1C/psBUJfUMy2P7LZaQoqWD3nwXoN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1NpNHpQMUcxWEYzeGRMTUhaUnNFOGVKS3pQZmJ5VjBuSFNCTWdKM2JDODho?=
 =?utf-8?B?MUNCUURRSW5UZVNEclFNaVRQMFhOMW5HanA1QTlmbW5Fa0VrRkFNZDJuc0dk?=
 =?utf-8?B?SzVudVRjano1L3QyRWVQRm1BZVdQRHlSbEIwUEVldFFZZUdsVlF5MkpRN3FH?=
 =?utf-8?B?ckt0TTFsZTZCeHpCRkpIb1IyMWM1RVdNUE4xelVPdkEzWFFiN2dvTTBGb1Z3?=
 =?utf-8?B?RDZmY1lsVnJXWGpnRVhtUEltdk52MWdMN2hINm5oVEtnNU1PUDY0aktuaDZs?=
 =?utf-8?B?aktoeU1wbGFwc1hxMzltMi9QWGRLb2NpNkZUNTJ5WmlVd1FSaDNjMkJ6ME5Y?=
 =?utf-8?B?RC9IckZEUnNnbytnMmRlQ2c5aU1XTkcvbGJPNEFjTmR1L1dTblpZZEEwSWN5?=
 =?utf-8?B?SFpvcGJPb04wa05mWm82cUdnRk83UU96WVBpcEhNdnk2a0JCNlpIekRLZzBO?=
 =?utf-8?B?NDZvbGljYmYyV0hEUGF4dFFrTm5BaXZpbk1xTHMyYUdJZ2tJQ0RjMjBNelBm?=
 =?utf-8?B?cExvSDkxSWo3QWtNWGk0bUxYam5leS9TUEFmMjRjblQ2UEpmNGVhYXJ4UnJs?=
 =?utf-8?B?VytBRjZHdUpkTlBKYTZHblRyQ291ZzlDNVdaWTZzakdWQnVRY3pMMHlyWUdW?=
 =?utf-8?B?L0xTQmpQQmRMcmpJakRwNGxUMnVwZlpueXlTRldJOTQ2NlNmRjdpcHhtYjNk?=
 =?utf-8?B?Y2ZmS1ZnQ0dvUzBxR3MvN2Y5aVpMVlRnTXhlMzRPQ3NPZkQzRjJJSWh2blUv?=
 =?utf-8?B?VGsxZFNlZ1N2a2Nrbk5KSC9ONllrKzdpMU1EK3Rrb3BGVTZaMkpZVkxNZ3Yx?=
 =?utf-8?B?RnhNMEVrTWNlVi9lV25LYmxBdnFHVTIyYmhSY2VTMXRQWFpNd0JReE03WkFr?=
 =?utf-8?B?aDU0M0JESVJEYjB2dDgwQnpQeFB2VCtCTDFuUWtXd1oxK2M0ZE53MVZSRyti?=
 =?utf-8?B?aXIvNnE2MlZIZmdpNkFpN3NlU3l1Y3hMV3VHSCs4aWJELzgxbUsvVTFtQ1Nl?=
 =?utf-8?B?ZnpoT2ovN05LL1pTRHRZTUhCbmIvL093MGlzK1ZMT0YzSm1FRzUrUStUclhB?=
 =?utf-8?B?MTU3bUU4MEQ3eFd5YzIwa3Q1bEZYTkNxZXdIeEpjamNXL3pEM0wzOG5ZMWMr?=
 =?utf-8?B?YWVCYkVYTXJVWmJ1b245STZZTjRNYWhBM0NUWFRHdEFOeXJsSCt3THFhTmoy?=
 =?utf-8?B?NTdzRWlXWStnQXVCVWtCYWFQVHRGUklJa1BVNmM0UzE3Uy9VVjZzck82ZGxu?=
 =?utf-8?B?M2xSbjR3VFhzZjc5OXpSbFVBcG9jbms1NCtkaHBsQkJhMlJuKzFyam5nZ2tJ?=
 =?utf-8?B?aWFURElyZzdiVmdWakxHOXFmOUowVUpEaWwzQkE4bFhacWs5cytOUTFMR1dr?=
 =?utf-8?B?WmNDZ0VrZEVGVDY3U2EwTUVmVGgwZytPaW82Ukc2cHNYeW5QWnNBVVFzcDhR?=
 =?utf-8?B?TXdqZlFtUjZEa3BDWE5KeXg2ajQ0KzhWbkxEaEt1OTFlRlJic3FTUysxU2k2?=
 =?utf-8?B?ZXYzUWFsUXRjeHlGMkpzc2xTdDdWZ09nemdlYUhwdlFucCtqM0NGT1JMMFNG?=
 =?utf-8?B?ZVdkMXI3S25MUW9Nc2tFUGRaMnVXeWtxNFZTRW5qYUYyVXVKZ3pjSzdXQ05W?=
 =?utf-8?B?RHgzRUdSaDVOaGR2UTZDTkxlN0NVTmZrNXBBaStSZm5KZjVMVmp5aGpJTDFH?=
 =?utf-8?B?eGQxdTg0dk5HT1d2eXBYUWEzUzRvMGtmL3BSWVFQYWdUMEg1ZXBnY0NUdzBF?=
 =?utf-8?B?TDF5UjlmQ2ovUC8yYmJxcXZ1TXBoSE8vamhkbEU0RnFFRzlkcTM3SjM3UGp4?=
 =?utf-8?B?NlQ0NlR4TFNXRE52dEVsbkc4NlB1VEFHV1VUTXFSYXVSWmxoOG5SeGl6Qno4?=
 =?utf-8?B?MVpJTkxIeTdYTENXQjh2OWRIYVI0VTNXT3Rod003dE9GWUw4aDVxNHB0bU1C?=
 =?utf-8?B?c0VlRkR0elBLTGJSdWVadTkvSzA2WHRoUWt5cXdmSkRIeXN4YjdCSE1SVGdE?=
 =?utf-8?B?YWNLSkpubkF2WDY4d3BTdE1LL3lKTlpGM1dXTTRrMEtmTHNadDU1VlJUUGtI?=
 =?utf-8?B?Y0UwRTMrUDc3TXlrT1NPVGdDOW1aalRCWGJTNDZ4VVhGRE14R0VNb1BZMyt2?=
 =?utf-8?B?Q1l5NEhBcUFYTTl5TUhuR1g1cFdBNFlFc2t1QzZIOXdYUUdqTVFoVE5aZ2F6?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e4e1fa-c0ef-4988-aa1d-08dc330b378c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:30:45.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFzFUgKUAvUgU+VzGiL2bZtFpo+EX/aGytucrZET6P9+YTBuy7IblBRu0zShLz+8vKlIgl1oegD2w1BmRgEQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6607

Hi Philippe,

people started to ask about updates for our kernel trees, and you
mentioned to me before that you would focus on the last two LTS kernels.
Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
then also in 5.10 (all referring to the -rebase branches). Before taking
over 5.10 and 5.15, I would like to clarify their state. But I would
also like to know what is delaying the tagging of 6.1 and 6.6.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
