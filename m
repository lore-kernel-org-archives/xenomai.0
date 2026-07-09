Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF03D25A2
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578720; cv=fail; b=ZHsvBm1rZ+dbIe0djxLROHXZGckbf/FIIubDM6XgRgp8KpysInyfKyQ23j2+CBUC6fszm/rUnn2aBOBxQU7COcIWDCpwsOX1ypart63SmQ421zH1vxaeK8xJMYgBXYWbk3Ksp7iQYF+qPewPROSyD3d7tKAHYMBCFVwJF8Qvboo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578720; c=relaxed/simple;
	bh=moHsCrDr5vkal3gQf8Ci0FVGFMwu1txEfDYJSs+lqDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fw+/ZJzwaC3tRrNrFHeMgJRZcnqFM56RraJ0FIEqtakDGfWBmF93rdMFPwQj5J/R4ldus/pJViBDpz6421DQz+1mZarSouhavlHct6LMDAOPTYHPUiJ5Qd3tR7b9pGc70eMYD/3GmtVo5nvOv0320abO6nWEPiZ9WXDYAqxXoMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aP8+m9Wu; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aP8+m9Wu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3zqKVP2hQdbHsa8POIPf19TBEpZ0CmoBGAxYbXPCpTY0s33/Wsj0Gm9MLiEPReECh+60yf3WuebLizUPmC0XNRltLzV9cWIw2eWr2W5yah2TwwV8jLUWcixBDxyKLM62hRXJRLppgTCSpY73y7mg9SNPoBTjkmTqcVzFPGHkQYxoqj8EZOX7mjLAMuuQiTdZC25zc/g2zo2DfZuOLk8wtdqeEmQL6MJqgCL0D529vwwtzjAtD82rl99S2GkiOpKgJi4uTuysEX09aDBRVOVoY8I6L24rqQhhAyrgzLPTNijkbun3udziZJPgLovhTU5sS8Uf1PZvs0osKfHUPyuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuNkjxLgl3yp2Ipbm77GoWLvZkpbIlngAZeNcVr3v08=;
 b=iQwEBbX+C4so9QnpDQVnqBjxdzSKy+XSbyx83kZWy0bwHx6PKYV+i+pTGd63oDWN6a/AD0AeJeXS66kdk3vabUlHrIjhG1BFt8ixHpBsJnC9oTbKKyAyWTB6zgRfzZbChNH7malv3QGIgwy8bgRSB0aE6fKm8ipZars09CrlmDTfHAsPV+nvaDs27ZA7TRgXuoMnTfLTIPOsHMvj8Cg67IrSsA/NLs9NV8YykUgVCnKp9Ivid/ngoEVyeH6PQvVSDcQRgOHmJ+2tBgC6g5e2I/AwZ50385ZnSByHSjnFnqmtIaZhdHpjlbGYmZXjIObThEtzZdg+TVZ6nUcT1QEl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuNkjxLgl3yp2Ipbm77GoWLvZkpbIlngAZeNcVr3v08=;
 b=aP8+m9WuwUTlXKCOkxpbXzRdHBESQcjJXJajP9jxsp+OGR6BW+WRCqSG2oOjiX2ZlFa2v9ANtDgx58z8mJsL6l2MKW83z03CvNUuqwo+AVjKEe8zyvzKnuxVXaxZbXmaEK0TfPjAgQJCgo5cxT2o+8oqjFmQg5Br5ooNKJb+eTWHGKqSLC1v6LpdR2FVPYCwFPLRGvJR1Rc47tpS9oUuCUWS04AjPuIFP+D4XxI1Wu1sxRTUOgp+docwugimq4qbwGKKKMwKPnwRDhPptddTTFP1LyeZbkZSr6N0a1k0dVr40c27rfK9bpw/kvpmN3FtoqKlaXwpm1buxVXQPKaFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXSPRMB0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:31:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 06:31:53 +0000
Message-ID: <b6b72107-bfc7-415b-905e-d0541861d557@siemens.com>
Date: Thu, 9 Jul 2026 08:31:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv
 branch for riscv
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
 <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
 <95f135cd-c4d4-4376-a72b-e301abf4dc8e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <95f135cd-c4d4-4376-a72b-e301abf4dc8e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXSPRMB0027:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b3f8b6-ccc7-4576-1496-08dedd83c40d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|55112099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uKqqlCVBy4ZCR1lGp52c4EcUwhuSx0FKxZnjDgnncJ/lOKlM4uCKIuXix+UjnD7rW0KbMHmTAX0JtuLC1fyIKxD2N0cXxC/ZfSL3P657NuHJO3Sj6QmRaNxpYdsWCbw+pjpw0tMbGFGF7wSZ8EeOfFamvRwoZSXCH1H7H6iIDqx4Wxj60krbs6Kyn/f2Mk0o5Zv73PDnA43F8GOhjC8tlJZ/tQZd8ZmynFEH5sraFHnI+JTuirk2rqiNS2svml5zQ95gbHP3mS3iysZPgtTrb+Uj81VwbJkS9wXIQZfIrl6xw4v3sab4xdPEUvA10/Fr+gtlIVDOOJ8T/32yyrUOR1OJuTJkUwSv4oJpkwF52Nnx+zOoNyLEpPQpEdFtN+dy3WmOWbASEqSXTG3WFklPjws7BRiPe4wgDVxKQZw3j78MdhEJRl4skjI6Ak4iRiJVrcJyO8q9pxs+8ClbKAypSNmRCL7TjdrUKisIUvhKxPzgYXAPW9mvy1ze1BOxrv5qWUP+YO+pIZQy5d7W0+Bf+egR2QiuQbGassQTlViBzbE9h6rAD/2Y6j/mg3z2UnG3xYYaGuD1PC5C3stUg/PBgRZqSUQRiWIhTT3teQachzJ9EIBzy46amapo1/L3hsH8M5rVYbbGMLbhOv5Jravfbqlaov5sPOtx7C+v8PMPwo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uld3VVhzL0U0N2w2ME1lOXZxVkNrclBDTS9TWVZOVUJhdlJnRm93L1krOVNX?=
 =?utf-8?B?NkxQVXArU0hoc1pMaEpLdVJhU0tUT2krOG1CY0FCSStQOGM3K0wxQW1rNjYz?=
 =?utf-8?B?cTczRUVQUUl6ZzZJbkhZRGVYT3VyZThvOS9KL0xuME9QWEZ6dTZMWnBqR2dV?=
 =?utf-8?B?aFpTdTVSSmdVMitFV3pUeXh0dVpuY0duZDRkSWFhTXJFdmM0Rjh4MFVNNEdN?=
 =?utf-8?B?bkdrWU41MGI5WFMvZUIvdHlnMDVpTDdQNEFSdlpWbCtPTDZRT2lsUjhDaGVw?=
 =?utf-8?B?L0ZlZzdUQUJod2lIMWtFOVFUMXZmYkhjb2ZOU2FBQnM2eUJ2cnhuWCtLZWND?=
 =?utf-8?B?K3VuS1JLTTlVY2hONnN3enNlS05sbmhtRW1VU2JOejZnemk5L1pKVTFVSUZD?=
 =?utf-8?B?QVhJeWVlbExnK0pIV0tUajlmSFBuR0VvblZrWXdNOFdaTHM3ZkRPbHFRYWNL?=
 =?utf-8?B?Q2JGWTlScGhpV2h1SEhVN0JqR2gwN1ZxdnVEQ011cDI5M0F0Wk1KU09jSGZH?=
 =?utf-8?B?dklDQ2dBYWE0YkluRFN5NlZ1MDBTZXhiSVA4QU0yVVl3VTgvcm5KdEtuMitG?=
 =?utf-8?B?NHZCTmx2NHhYZ1RHd0JYOTA5ejUwZXJJcVZ3dmlGTndzU0JGeHUrU3N1OW11?=
 =?utf-8?B?MWE5aWtHbUxXZ25oMnF5RGc5R2NNL3FzT1dOWE4vQ3A1RzZSdUs5U0x6UHFm?=
 =?utf-8?B?dVhmZFRnMVZKeCszR2s0c2JoQVQwMUtlRG5nSmgrS1JNUjR6MmlOVGhPLzNz?=
 =?utf-8?B?N25zVTk3UTlqK3IzVUc3MElSZ0Y4Tk9MMHNIMU5NdGZhcVc2SHFadkUvNnlS?=
 =?utf-8?B?UDAyZlhkNThyOThVMGNzWDg2bjlzQVRMY0U0NERvdU9CaGw1UlRvVGNxV0VM?=
 =?utf-8?B?cFhhMDBEL0swM3lvOUVTMXpnMmZuK2lwV2pyS1AyVzJaQlcyWkx2dko4UjBE?=
 =?utf-8?B?TFZaR1ZiZ1JBbFh1U1lYa2RwTUg1VnJMOXhuMGNLWm1pTzIrQnA2V3VybHRM?=
 =?utf-8?B?UXROZVpYQVo5Q0pvekpveitwbkZpb1ZJU0lzdGVJeVZVUFVMcjIyQW5ITURW?=
 =?utf-8?B?elVpWVNXYjJnV09JV0p4Y0tCdzNJV2tsSHJZUEFOT29td3pRZHpWL2psTlJG?=
 =?utf-8?B?SGx4TE5VS1h6SWpOYjhqTUs5elNiZ0JERFdxVlNPWURGbStWbksyR0NDNzJp?=
 =?utf-8?B?SWg5c3p2WnV2UmxRNDg4dHM0ZzNuUStWSjhzU25aemJFYVc1M0M1QUJpY1Iw?=
 =?utf-8?B?MmNnNUxQaVF2Z0pNdGJRaFBIQjdFNG1OUEkrQ29GdDIyMXV6dW5TemFiVnNM?=
 =?utf-8?B?V0NVYlFtTlFNMjZmbmZXNUNsU2VZUGg1c1doZTBRcmMvUXdwMGRFeGR2WVoy?=
 =?utf-8?B?TFJpMmViVUR2TGpPeUFwSHJqaUEwNFNtbER1ckRFM3ROamdXZE8yM1ZVU2gv?=
 =?utf-8?B?andxSW53M1A4eDhoTWlDdkE2MXdwV2FTeTZJdWZGK0VRaXVhM1BPM01kdlVI?=
 =?utf-8?B?MVY4c1l3VE9WWmQ1bjViOHNRbmFQQkVPT0RXbEdBRXpWZWRoTGpqVkcxakx5?=
 =?utf-8?B?WWZHbG5lZlpHRnYzVHdaQ2s2UjlCdWR5SnQ3TFoza3VMUnNXV2NHeTZ2aDlY?=
 =?utf-8?B?QTBOT1VuZndzY2NKTVlXSWozNVNSKzI2SHFjTXlSdkNxUGpoVzJFcTRVemZj?=
 =?utf-8?B?WHBBc1kwVXpXcGdjeXBBYm5sa2RsUVR1bzlrSFAxMWNVd1hlVFhIMGdtM0FI?=
 =?utf-8?B?UFpaaGlqOWdVVklQdEVLcVFXdjVlOUsyYnMvdm1ablV1ZUZWUlNBVms5NWts?=
 =?utf-8?B?RGZBbXBDODhKMjR1MzB2YVpicWJ4Q3dPRW1hbzVGU25YNWxFRWhzejNQYWJ1?=
 =?utf-8?B?anppait1OFF0ajdYYXpVQUJtTi8weVlGNFFzRlV1TTZDY0VaanB4RmlOc21H?=
 =?utf-8?B?T2lWV2pObTEwQXdub2Y1TGZqTjVZWVRoVkNwMzcyZmhYbjRPK0pmOUpBeVJO?=
 =?utf-8?B?dStXVjUrc2RuSTAwU0xIMzFjNmZ6cHplcjlvNms4cG05cWNGdjd4bEVnbnZP?=
 =?utf-8?B?bVlrdmFQYklyNVdhK296YmtjNTRMQkZCMzJzOGRoMEdSV0hsNS9SMlpkOWh5?=
 =?utf-8?B?ZTMwUG1BT29SUjJWNW5YQmZMbXBCbnYxaWM1THllNFlOd3BJN0VITFQ2Rzlv?=
 =?utf-8?B?YzJpTWgrbkRHbnVINmhDNXc2L2FsTXBnNEJxaFNPWGVGZnNkcWVCWGJoM3hj?=
 =?utf-8?B?Qm5iQjFQTU8wRWpCbEh4L2NhaXBCVVV1ZHEyaHdtUkRHTSsrcXc4RS9FVUVj?=
 =?utf-8?B?dzduNXphbytzUUdOUHgrYWg3Z0tZb3NUNG10bVZXY0I4SmtrUU1TUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b3f8b6-ccc7-4576-1496-08dedd83c40d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:31:53.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0u4jmg2Rb/8lFj5mdMqAysyBndimbrqwI5kzIveNn0X6QtCI0thualdgA5QLtTKTEwBYD/F2CXzXtNTbBjeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0027

On 09.07.26 07:03, Tobias Schaffner wrote:
> On 7/8/26 23:26, Jan Kiszka wrote:
>> On 08.07.26 21:40, Tobias Schaffner wrote:
>>> The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
>>> for integration of the riscv patches into 7.1.
>>>
>>> Switch back to wip/evl-riscv which should generally hold the
>>> current riscv patch set ontop of the latest next.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/
>>> recipes-kernel/linux/linux-xenomai-4_latest.bb
>>> index 48499ca..a542e80 100644
>>> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>> @@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
>>>       'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>>>       else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>>>       else d.getVar('LATEST_KERNEL_BRANCH') }"
>>> -GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
>>> +GIT_BRANCH:riscv64 = "wip/evl-riscv"
>>>   
>>
>> This branch became stale, that's why I switched (535ce20bf0e8). You just
>> updated it to 7.1, but its baseline is again outdated.
> 
> Florian updates the Dovetail branches and after that these changes have
> to be rebased into the evl branches and I again have to rebase or
> cherry-pick my dovetail and evl patches on top of that.
> 
> What is your expectation here? There are three different parts and at
> least two people involved and I do not have something like a automatic
> pipeline.
> 
> I am still trying my best to keep the dovetail, evl and libevl branches
> up to date.
> 

Also because of this split between to persons, I was switching to his
branch, assuming that, when he updates the baseline, he will also rebase
riscv.

But this issue should be resolved now within the next 2 or 3 weeks by
finally having riscv as part of the latest evl-rebase branch.
So I'm unsure if it is worth switching branches once more or rather wait
until we can simply drop that line above.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
