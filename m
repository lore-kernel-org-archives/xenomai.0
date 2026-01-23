Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDF33E34E
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180449; cv=fail; b=odneAgk/XsBK8JvyZX/L6mzVCL1A/9Z8RWtQcxAsIuyuHHy3Av1rGvJQLrrlWtbeGf2aRaveqFYTTd1YtHwfjpDjX15UWG39lCtTRXLjxGxp/qZhHlxaU2xNpGVa3bijzVQl/lIzpfTGCCXZmV8BiwVF9zQkzzPsIbz5n4YrzRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180449; c=relaxed/simple;
	bh=LcWCgsyF1ZzKeJsWxrrhjlByv9y2VaKBU+6DEzZ2dSo=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=B+uoO7p25iXuu2ZvaUdlUtUGq/2gHFZtRoUFUQaZmApHLlvT7fLjG8Unb9C1ZZu2suLMAjeT7YsW/Lu3ZOS2Zby22kgFgFhTjWrmf2oPaZmwyLPcGQVF06tHdqC3SuqEImRDFezpzuZRvb4Q6DrV7xZnArK0ULgS9WRyPRt+TT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NrIaeU8M; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NrIaeU8M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLucjfRozDdOU0gtbpC8PkSmhsCpgroZAxio9CFldUn6sbPZpMF+db3UNZ5GL36zxrr32v5Cq/QWpXJUnGU422f16X+FyKXDIlXcqUmNOZQZJDYjK49IuNUIuQev9hG60tef2gUfdpVgZV+w/EeP0wzrZkDLBL0nKC6cJnJXZHEny4QiS+ne1vl8mOiy9GbcnNVvA58fvJ0zpN/2/YvUppiblxlgHe7IRUmpTnnJWH75/kBVxzhvg/YHz/HeGqJFf3yFsq+G2T6TXYs6l/x1evJRF5oPwulOeav5SY2UCPolo1962D+55ZJQfu1AMiUskraMCwJnNd7/72f2oSKhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvedgQW9ym9vv6te+Rz5+8ELYNm80sdnL2jz5viHJGE=;
 b=P+D/+N//msSVz1NxNLceVHZircvUID9UB6QIQ/TzJZZS+T+e388r9jGd/uXgIi8aFdqi0X0F9x369grqvo4ZGAqP+loHwGJ8s6EaqQttDEcwVHO/07+y+xTB81NuR/S8pIBEiajV9MJZaZkGkGJe4Y+40Hd3lU9nYDuHuOTQao/ZJ+rk4WlVtzHB5RCJ9G6midhwy99x48vV59n1Jv1vAw2oMByuB2H6MGSpepDN3IYcEMEgkOY1r3JRCNcFhPJ+asFlREBuDNmmyNrXFDEcGkYEZOEONJiNRlgQ+qoIGYaoxGqxo74BbKVTVxqSLHDzyr+CH7xCRn9LCo5DdJLLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvedgQW9ym9vv6te+Rz5+8ELYNm80sdnL2jz5viHJGE=;
 b=NrIaeU8My4bMUsNUlqyjiO4UUYhtQlyjoORuTrUVfbaTva5kPTb/3SEfv6NOKuUWXTLnLVxaVIzpWh97+l+nW8LXt6fOn9Cu9boXsT4rTQvdWtC7p8xTDSlRYyGez4aGJIrIJiWVbc7YAf+Ma/FzE+dX5Y2kHbhxBb91C7hfUHLKR0u5wSdQXCs2Tsb0Y759GJJqZEruhuB9BcyQL9tiOW4tFQXLQ1szdhxhxcYzLVzNvM3qBohuKzl0Rd6GFvoilqwOysfPHF7pO7zlcZePU3aS5VBFc7dE4qPqZ5EZi4504LM5ivjaNRVjWpTjFKeBq/DLETNu4YNkudHY6upT3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:00:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:00:45 +0000
Message-ID: <59c22e2a-2946-4114-93c9-5c7736d15c7d@siemens.com>
Date: Fri, 23 Jan 2026 16:00:44 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [v6.18.y-dovetail][PATCH] arm64: dovetail: restore lost debug trap
 hooks
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac690b6-0efc-4324-2047-08de5a902f79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm5YWjRnWHp2Rk8wRGxKdHZaand0WDBsNVNvQnFjM1ZQb3hJMTJoUmZ2RSt5?=
 =?utf-8?B?dzVCYmF6TVNMd3dUOUVQS1UwSW5zVHhsOWpaT0wydytoVmRHUWtQRkpaYkNQ?=
 =?utf-8?B?c014WCt1STJUMXBHUU1pR2NGd2hXdTlIbVMxU3RsbGYvMzJXYkJWZmJMbWx3?=
 =?utf-8?B?ZldpRHZuNytuS3h1bTB6dnVCSER0YWk2M2kvcy8zdXgrejJ6RkRuVlhvOXlR?=
 =?utf-8?B?UGJnUzVaTmNTcWNjZ2lVSkJ4bTNqMnZaRGpkRnNvTVA0U0xidzVQV2c3YkU0?=
 =?utf-8?B?L051N0VlRDJLWjRRTTY5a2dCZTdJckpPN2JzNkRZcjRGN0RTd1pmNWtyL1Rk?=
 =?utf-8?B?Rkx2d1R3cTUrdjFPajFPekkwWnlDWHd1VnR4QnIxdTAveXJySzVOK2ZyRDJa?=
 =?utf-8?B?TzZrL0w5K2VqaEpmbUlCa0h2MDNWTDFreFpvcTR4TGY0RTUyaThYM0tvaDhY?=
 =?utf-8?B?UFIyanNyb2VOQnUrb29IeGRqSFYxK0NoNjBWZVUrT2ZRRTlYSndFU1htenNi?=
 =?utf-8?B?UFJKbUdVanMrN29QUkFXZGgrZmpOaFlQK0NZR0dLalpsOG5ac3hvYXNPWlJp?=
 =?utf-8?B?RXJQZUNnaFBUY1JaaHVBNGxuZTFmQVBRVmd3QjlyQUVKUE1FdEgrdU5KTjk1?=
 =?utf-8?B?Y3BxZmJXQlIwVGpqcnA1RnBCbm4veWI1UU5hZUJ6MThhUS85bDR1b1FoQmJQ?=
 =?utf-8?B?T3lyK2lpRENXYlhLSkVLaVNDUkpNZU8vQk9TeHZvVklHZzN2Qm1CWXZmVzBO?=
 =?utf-8?B?cm9heFU4cnp0U2tQT2Z5blBBcmUrdTRrc3dsMkZwbU1pL2Jhd09iZjNrU21M?=
 =?utf-8?B?MHI3TkJINnpYTWUveFUzZkJxMDJOdFBXbU9Vemo4WExMY0RLZzFtaTI2OWVp?=
 =?utf-8?B?SmpRQVdxS0hISjNpeng1UzhQR29ubUZQemMwSVUwYUU2MUgvTkc0QTJMRnIy?=
 =?utf-8?B?NHZvdnRPSWd0MXpTR3cyYUZqN0VnMzQ2c0R0dFN1aHdEdUd3QlJURmNWVHdm?=
 =?utf-8?B?dWo3bEZTd0lXazU0UnMrSVJaVkRaY3lIV2w0UHBoL3E3SEFWYWl1djBCZCtu?=
 =?utf-8?B?a20vODk2bVZPV0dLN3dCdFFnaHFuOTBJT2pGRElScHBDOHBMY050TGZja0NM?=
 =?utf-8?B?VTFMNDJzQTl2a1JGNll3RmdOd2pNNy9MeUM1L2RWZnJsaGIzd1gyV0cyWlFF?=
 =?utf-8?B?OWtXL3RaOFNra2lEN205WGprRG15YWJJU3VsVk5sbTcvVVJsUmR1NGRpMGhV?=
 =?utf-8?B?QmNDQW1sdDhwNEJ0dG4zWlhRUkVqQS9FSFM5RWtFRVQ0TVhlNXZyc3R6K0hO?=
 =?utf-8?B?enN2eVZ6eTFPRFZrOTVZUmR1YzJoUnlmOGprMytZZzdmYjA4cit6SmNLbDUw?=
 =?utf-8?B?ZzZkU1JyVFFmUkdhbjV5ak1pK3g5NC9aL2ZaRVozR3M0THM4NnlwODJKZjkz?=
 =?utf-8?B?b0FsTFVKbjBlS2Q4UUlZTVFHQXFHZjlxYmZvSTBEZ2xmOGFiaGloazVjSEFS?=
 =?utf-8?B?RTJPT0J2aVprc04vZU5rMzNsdUNUUmVWNlJUb04rVGZPcDQrQ1VrSkY1c21J?=
 =?utf-8?B?NTQ0eEdvYVNsancyL0hLZ3ZDM0c0M3lVdzN1Ly91QVRZYnhsVTlvRVhONjd2?=
 =?utf-8?B?OVdnMjFrTFdKejgvazU2eDlCUFZITitqYWxta3RFOW02WUg5SHJmU2M4djIz?=
 =?utf-8?B?U3l1NFF5MWcwR2NjV3owYnN4K2psZmpVdUw1MTRNV2M2YjJ0bnREU1FOWElq?=
 =?utf-8?B?T2ZlcEx3VHV3c0JHUytOVWdtc3BLRVFQUTZrdkU1TG54M3lJMHlKWGVrVEdE?=
 =?utf-8?B?a0p6N3V5dm1VcnFuVEZ3R1NxcytqUkNRbXhGbVNDQk1NemV5ZjI3RHZjc3hT?=
 =?utf-8?B?NGJoYXpwY2l1VzYyc3BRdkwzMnVHWS9FUC9WZWFPVWt1RFQ1Z2xxd0xyYjdX?=
 =?utf-8?B?M25MZ2Z5V3UrRmVFZ2NTSk1rakYxaHd2Ym9xT256Ti9nNXcrL01HdVNZVlBj?=
 =?utf-8?B?UWlXRlNDSjZiOE16VkZFTk5TQVNtb1oxZ3BBMGpYUGs3OThocU1xbHZSMnpV?=
 =?utf-8?B?VFZod2xGN2VOaW9SbUZsRlFvc1B2RmowNHM1Tmp6MTNOSlZDUWNXQWdCVmNH?=
 =?utf-8?Q?uX6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdyWXNzOVllWHNyNi9hcFZyTnI2N3dEZVNHQ3NXSm9DYUhTMzM1WHp4ZWQz?=
 =?utf-8?B?eG51MXRTK2czMWl6UUxEU1VicWVOREEyQ3c0c0krb25ZTDlHeHZLd1FHYU9T?=
 =?utf-8?B?cDlhZzlvUDVwL0JtUmxuYlVYT0txNXB1TVgvTGhGSnh0eWhPQ2RnLzhTQjR1?=
 =?utf-8?B?cyt2R3JKMDZPNmJ2K3Nja0NYeVVJc2w0WE9uT1dmeE9IU29jWTNzNTYwd01k?=
 =?utf-8?B?UjlKVWFndzhTS1ozaEovLzI5b1JiKy8vcCtjVjVSN0tzM09aaHRmZG14SlZs?=
 =?utf-8?B?OHJrVU9qK1A4T3h4WkI3MTNiVnhOZkFCWTRkcEpZZVc2THp1MnBTWFo3aXJM?=
 =?utf-8?B?K0J2WTNuTm1hUUE5T3IvMldwU2d6ZWZBaU13STZOdDc1NkVNWjdmWXBUekxY?=
 =?utf-8?B?Q1E3bE15NXFkK3N2ZWh4VXdBNlJLSzhvMkp4MG1KQ3FQOXNqMWRYbm93MHpS?=
 =?utf-8?B?R0x2VmNKdjFCVCtrbkRna2JXQzNibFF4eGp4UU5JWFY4eU1xSTRtc0lteDhs?=
 =?utf-8?B?TE40d0toMnEzVDdRbXBmMUxCSCs5emljdnVaa09VV1g1OEE4RGxoSnA4Y2Jn?=
 =?utf-8?B?UGVldlhPRUQzLy8vWERyQWRaOEV5R2dBL0JUaC9UTjRXdGs4NmVMSmpjMTNp?=
 =?utf-8?B?NmpHVjFpV3hTVWMzYkltSnRXNjRNNjNpVVdSZk12d3ozVllCcWJmajJtNGZI?=
 =?utf-8?B?VW9VREcwa0ErVmZEMVNXSkxNN2EzQXFpMGNkWmlSMlFpNkhXeWxzNUdPOHM4?=
 =?utf-8?B?TTZOSXExQ0hmV1dmK3dvQTd0N0ZQWXJSSE4xc21rbHFQTlZPa2o0a21SQUNV?=
 =?utf-8?B?RmVoZW1MdVk3czczMHJDaTkxMW5xRkF4cHJpUkpyR09HUjFxYjVsSVh1Lzcr?=
 =?utf-8?B?aDJuSW54VVdxaUtqT2pLdGZ5OXQ3NEp1TktvMHVKOXpOQ1hvQ1ZYMDdOSGs3?=
 =?utf-8?B?cnB5M0JSMFVnL00vZXNYcWliZGpnS3AxSHBwY3NQc3VGclRIOGFuSWgvdkdX?=
 =?utf-8?B?dy90NkRRVm9WRmRtcXE2YWRyTFhBSUlldmw1VmFRR3Q4enZTMzN5MXRWcnlq?=
 =?utf-8?B?c2RWVFFZVzY4NnB6dXJ5VWF6TERZNTZHMlF1c244MzgrYlVJS08yR25SRm5D?=
 =?utf-8?B?aTR1WkJoWHBmdTJHK1B2bzdadk9XNTdQSCtReFozSUM2UHhnY1dOK2VKVnd4?=
 =?utf-8?B?d3g1eWRrQmV1VytZcXhCSnlka3V3YzI4dnZsb3laUHpGV3d2aVpQdmN0TmM3?=
 =?utf-8?B?OGxZeENrWUVBM25oMVVXOVNmeXJkY0gvZzRIUEdTbVJhVCtyK0xvd05xeDFk?=
 =?utf-8?B?c1FUbks4b3lsdU0zWHhqelNSOTdpM3BPTTAzdGx0T1V3YVBlaVErQU03NU93?=
 =?utf-8?B?Mm9tdUZYUlV6eVUvZ0RucGh6QkNDZ0x4Nkp0OFJvaWJhTTZaTy9BQ1d1Unpu?=
 =?utf-8?B?OG5lOHVVcFhoeCtnWVRZMVdUcTdQUmROekxYZ3VUNDBQd1Awbis3TUREQmJU?=
 =?utf-8?B?MXNSUEs3VWRydjdURHdmQnk3NXovQVBCL2JhMzBzRjY1K2gxVXpGek9kSUpK?=
 =?utf-8?B?QndPNWVDTGhldVpFT01pb1JhdFQ5alVHTHNSd0dwekhwemxjY0JEeDdtTjVL?=
 =?utf-8?B?SXVUSVFFbTlITjJ0Uk1XT0d0U1lnMHhoWUVHS1lreHpRemtrVGh6TnZWY0FF?=
 =?utf-8?B?ZEc4S0dlK2NOdWxSdE0zT1hIdEE5UTJZdjNvd2lZTGlCV3VuQjN0V0VrVkVT?=
 =?utf-8?B?UmRpdUsrd1FyUGpCR0RacTJiZ093VnNjb05UYjc1REpMd2Y1RXNXaFh1RG1Z?=
 =?utf-8?B?NFhvbXpBdmVOTDhYaVRiTTNNTUtscmdrSzZPNEVGNlQ5VkxYQ0RWcGFrK0tT?=
 =?utf-8?B?eDZOK25oNTc1OC9oNHVYZUo2YllaekNBdE0rSE1vN01vVmFPWHp2c2tSMUww?=
 =?utf-8?B?WmgxY1FyZkQrQ3NBd0N6TlhoZDlLM2o0NVRuVHlCMEZ0OFNVSXZoV3MzWHN2?=
 =?utf-8?B?NmJORUNyQTBhR0tLYjFQNzUzTGlQVHVMcUUzRE56bVZiTHYyeitjSUV3RWt1?=
 =?utf-8?B?MjBHWDBPdUpTVmE0MHVGTmEwQTJNbW4rMWplcEF0b2VmTHJrd2dCRFZIaGg5?=
 =?utf-8?B?RExOZitDbDI0czFBb3JqZW1TY2gwWWhoQURPa1lTRzl5OHUvNDZ1bjVIZDlC?=
 =?utf-8?B?dFBxQ0Nubmc3eE9WZVNITk0wc1hoTCtxTWxnQzJPZXp2MVBCbFRPVWhzeDNt?=
 =?utf-8?B?QzFoaXhJUCtrZ3JzSmFJNFZEM3ZBSUloTWg0ZjdjZXVMYUtKMTFrZWtrbDJp?=
 =?utf-8?B?TjVjNG8yZ08ycU0xd2MrZFNNT3NnMFAxUHVaUG5Bb25VbkR0S3plZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac690b6-0efc-4324-2047-08de5a902f79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:00:45.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxHKCbRBifsgQyRt1lqY5dJM9W5npaIQmc9BPdQsiI+Ju4xnLGSAiWKn/j6xmqb8Wou9TxCB5yd8YALUw+yVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7180

From: Jan Kiszka <jan.kiszka@siemens.com>

Apparently lost in the forward porting from 6.17.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Fixes the gdb smokey test of Xenomai 3.

 arch/arm64/kernel/entry-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2ae2f6898bd2c..e0227d467cef4 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -842,6 +842,7 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 		arm64_apply_bp_hardening();
 
 	arm64_enter_from_user_mode(regs);
+	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
 	/*
 	 * After handling a breakpoint, we suspend the breakpoint
 	 * and use single-step to move to the next instruction.
@@ -852,6 +853,7 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 	local_daif_restore(DAIF_PROCCTX);
 	if (!step_done)
 		do_el0_softstep(esr, regs);
+	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
 	arm64_exit_to_user_mode(regs);
 }
 
@@ -871,8 +873,10 @@ static void noinstr el0_watchpt(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
 {
 	arm64_enter_from_user_mode(regs);
+	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
 	local_daif_restore(DAIF_PROCCTX);
 	do_el0_brk64(esr, regs);
+	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
 	arm64_exit_to_user_mode(regs);
 }
 
-- 
2.51.0
