Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945B17E8E2
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825783; cv=fail; b=pAWp3oSFJUhxcjeKfVWI6jhJCPtv9+mFq737ttb/jpnEFqPdMMl+pmx9qqWvQ1G8avibPyA0WResSmCXb+ediT/Od2qv8ozxRRuBxTpMPpWwp+6PsjG0ww9KBbapshkdjWeQkRAfy+s3L65QjYDr8fzDv9v0FRE5tt4qAasrTyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825783; c=relaxed/simple;
	bh=szQayqhVcBzVR698zARdrKIJfVcjJ5Le98xzB/FzPLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5C0VVy22X8gklVaDWJQ4colmu8P7o9TFDDwQji75s9atKW83lFbIq4y0/V20+3cL/6JxvruHzQ2bI+3kgMJAxwxzTVEu4ugWbjAFS7m+I6lkWKwXgN3jIyv2RyVjZP/aJ/Qyd59UPJ3WVD+tE8Sj72L7BJJ4t73k0giqxr904I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zRUJJ7F5; arc=fail smtp.client-ip=40.107.15.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zRUJJ7F5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV7eaIIfBf1EbzPzyvBgsq/yShKTgEP0qXmptnnrQdjPrOq21OVjrVSZp5uCxuFhspMmbqTOO4eOkhMLtDq78jvn+8+0WV0WFBhUqehjzzoZ1WdBbhQunDVzmBD1unAsapgejsGa2xVCF2vXoFc92TM2GSEp8d5O/LP/t/JMYunJ8SQQzbp65cbQZasN61ri4/VHGqqnd5ZJPIr3egPr/ReQxB1swmKLpEvh74rPKiFvymW4rqdvWTwb+FHmTNkmCTB6wI7Fvw9ib1CrhyrY9kwVAspKIaiXeoha77srBGFRt7K7KNzpwk08R1NdH+JxxIAcREURbSDcKEvA/d8J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgnX8PRoYPHr+3cW84EEK/y913zS4eGaSc/zsxbs9/s=;
 b=R0HglHY1LPGi+wSLXx5WnjF6grn/xE7ejoWXPTjk5E34fIHY7x0uJbp+sERxV8HrBUey4oxCkmfieN0O7VVXq7Yi78Bw2gA6loZRIQlEvk0xe8Bum/4bjHgFEnCW7/fKcVy8p8vt4i3/TaFPBWWzliWTsEHAKYsWw/kjeBRRIlw4mvxko3qqINjGrhOZtiZ9J6p61v9ci8eCAIZCoE/uJQER78zwsmMfFZC7NQ5B+nij/+RE/QFo8TrtuaZH+GlaGL+ut86x42OCCDcdXdU5wgCgxb1EIc3mqhB1RHPfQ3owbwpL8y4LNIfqI1KpjbjRkjOvaDz89SZ+ZVNAgqPcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgnX8PRoYPHr+3cW84EEK/y913zS4eGaSc/zsxbs9/s=;
 b=zRUJJ7F5mPibOk+3e05oxNKXRBi/qvnUAQFnGJgcV1oK0ZGd3aChGzu8wrFcTEW5ERNeMYOWiK+Udmc8mo1aHwubi5zXPBCUaW3oQtZnfjjgzW1JYDE37/cqYwzZI1mtjzHf2ShHN5kfBWMUw8n1Pb0xoqnWqPCcXPSFm2lUVv7P9hvh+Lwy8PZLVMbzemy7NSgQaqtJGLycXDDL4JkDYA5Ui+ygn08pvf8LkjYfDYpWY1JchzKTzsdckf40WwS+p6RcoKswVmMCOtcM+sZJ44LfrEPDl9J9PV6vJIxcNyUyXM+m3lS7fHdFOkmtgBcsjRTqzf40hDnJtopUXZVgHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 16:02:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 16:02:57 +0000
Message-ID: <157b0d34-f096-4b42-b801-0227c0843bce@siemens.com>
Date: Mon, 27 May 2024 18:02:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] prepare-kernel.sh: Don't depend on bash
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>,
 upstream+xenomai <upstream+xenomai@sigma-star.at>
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-9-richard@nod.at>
 <fdfbe0c8-42c9-440b-bd16-0834cad46645@siemens.com>
 <73647592.154519.1716825655479.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <73647592.154519.1716825655479.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: ee60cc3c-c0e8-4f98-b4b3-08dc7e667972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE1FOUxxdmFOQVdvOGI1Z2JsZG11VWVNMHRWayt4TzNSRUhnSXFqSFRSeHBz?=
 =?utf-8?B?Z1dMOFcvVjluUXhrVzRBdEZVNUl4Vlh1ZEplUmRNOUpvWElpSmJEazlvUmhK?=
 =?utf-8?B?MGxhSXBYbExaN0dUQ1dVL09VdXh3RmdwUUE3VzhTSVY4NmFVZGU5YTdvWHJL?=
 =?utf-8?B?NnpSMWR1cytuaDkwUm1xbGcvMk5HVXhGekEzSnFGRVZ2WUhOekdMajhIYVRt?=
 =?utf-8?B?Rm9nQTZ5TVk1aTc2MWY3a2t3YmVMN2QxelhUeGwyVUxZRlJQMllSS0dnV254?=
 =?utf-8?B?bkw4WFZjMFZxVDFma3VaNStIOGNkSzlTUkUzRFhOWXRGVGFwdExNUmY1UmZD?=
 =?utf-8?B?WFg5TWZxLzg1c2YxMVoxS05NVnJkbEg5MW1XdjBWR1lpNzB3U1FFdjNnMmxI?=
 =?utf-8?B?RmNZbStSNTZVYlRKNzBWY3hoY2tnTk9IZzBKemxvOW91cEdYZWdQcGZrRUxJ?=
 =?utf-8?B?MlZGY1E0TnV6ZWg1SjFGQ2dSQUpXckJ6QnBkM3NDaURwSjE5ZEZsdE02NnVZ?=
 =?utf-8?B?ODF2TzZVN2xWWE9iODU1VGdjWUdGSHM3WHY0dXQyYjY5dm9xTmNhZUdaWC9y?=
 =?utf-8?B?eEVNZGdCSWVRWDltTE9FRjhDQWlGZXJZd0FYeXdWdTNVcTZTWUt4MFJPdmRl?=
 =?utf-8?B?Mk9Ya29Wa05odGREVVRGV2t0Ri9tVXBudFJDVnl2Q3RrK0NoQW9JTG9GWU9m?=
 =?utf-8?B?NHEraTk4WUl0YVUrVXVEYjJFNkpqdUNGSDNGZlhERXZEcXdZdVpjS0RNY1NZ?=
 =?utf-8?B?bm5FT1IxYk54a2VvaWdWRysvU3BxM2QrTE1wdHlWZi9QQ05MNVNMVEMweHl4?=
 =?utf-8?B?TllVWXZMRGduaUFKQzM5ZVZwL3NvTk9YWVFnZ1RSUks0d0xoOTJad05aR2da?=
 =?utf-8?B?VU1aU1ZLTG95Nkp6VWQ5NXc3UGlwck5peTBackl6N1d2S3F2cU9PMlY4Q0x5?=
 =?utf-8?B?SVJLWkN0NW5JK3IwYjZYaFp1U1hNQWd1TStpYWx4QjQ0WWpPbkJXeE1yOTRN?=
 =?utf-8?B?U0tjcnZVcGx3d0RjTWpqaG5KOWVjRS9Ld09FalNQdjhtelltNUhvNTlRMTcy?=
 =?utf-8?B?MVR0KytkN2sxbVNaMXFnRlhvSTFOYlJjRXcwRzNiT05aRkNpeGU4Ri8vY01I?=
 =?utf-8?B?MUIvcFBCbHI1N1h5eE0zVnU3aFlWUGlISUpGMGgvc0gxSWR6NDZjSDdCTlY4?=
 =?utf-8?B?bkhGeHhuUXAzRnNtbEh5eWdkRkJoZXd2MzZ5YTdzQVI5NmkwM3JCMC80Z2Rr?=
 =?utf-8?B?SWRSRjJheE0xY25kZEVhYWRSMERlUDUvLzhUMVBBamg0Q2VZemNlYmdZZklW?=
 =?utf-8?B?VUpUbU9EN3lTQXNneTNyTWhDVGVMeGlIaG1hUU9yQlhER3NnQktKS2ZySDJ6?=
 =?utf-8?B?bHFCNm12SnJ5NjJHVVMyVnNMWTVBakxrYnZRRFpsclNvbDBkcHlqVUNZcVo5?=
 =?utf-8?B?NDgxNkJabjRYeHhHSmZQdU4rRUJsV3VPQmFyc0drWDRyYVViTzFpZjh3UXhu?=
 =?utf-8?B?UEtyNHlXUmpUemswMTZ3enpGZXc2SVlWSGF0eXNFNHVlSCtnL1RpVWt1ZUxC?=
 =?utf-8?B?elFFdTQwS05qWTdWRkhEaG5ZTTJMeXlUSG1yQ2M5RlJKUk94YkNocWY4UDF1?=
 =?utf-8?B?L0tLRVhZSVc1TEI1VlBlRGtrQUJKY2srUnVPQ0Y1SnJLVDl2d2pYQmZRSlhM?=
 =?utf-8?B?Y21EOGJPZVcwUVJmQXQxcGdhZkFtcVJxa3ZON1kra0RkSHZwT3NGY1NRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJKaXVlWi82K1puanZHbUlydFBXV3ZGdXI0U1g5UUVpYmp2T3I3dWNIcVJQ?=
 =?utf-8?B?VGhHNCtsUkF3OUpLN1pHeFF6UGpjMGFHOVdENGgvRG52ZWhGU0lBT1VGRkxQ?=
 =?utf-8?B?b1RTUEhCTFhnUHpKTlFVa3hTWFRud1dmYlRjYmpqQ3hYR3lVM240NDdEMVdy?=
 =?utf-8?B?NVdqemJlZzI4bUVMR0orRHRtUGNRbUswZTJJZlRHOG45Wi8rakFtYW90ak1D?=
 =?utf-8?B?MGFoTVhDWnVlSnpLQ3d4c0xBYTNoWi9jdkJ6NGlmc283Q2Myc3RRblIxbUNa?=
 =?utf-8?B?aFVKVzRadytwdmt2eFdocWliYVRMSzZCek9CSWZ1RWQxcThRVHlvTVBQdnE5?=
 =?utf-8?B?bG5ibVBZWUpFVGVlalpZV1RaYyt6YmYxeDkxdXRjdWZNMDQzM3JwbzlmblRQ?=
 =?utf-8?B?NmxqUy9OQ2d6QzBrMlJhVGJaNDJJQWhzcmhBU2FBbUNsNC9PV0ZuU0w5YlZw?=
 =?utf-8?B?aWF4d0xLSytaNzVoOWg5Qk1GK1FYZ0JXN3NDVWRieDluY0RteFNxMkpwdlFU?=
 =?utf-8?B?TytaeUxpbGVXNWJLRTNPSXAwSGhkVUtaZnp2L2RTNDU0TnFTMXRZK1M3REl0?=
 =?utf-8?B?OVFQQkJSYmNBSlRaN1JNdHFORDViWTRyVU1zMzZHdWZXZTRBUnFBSTVTS3ZF?=
 =?utf-8?B?cytYT3JJanFacng5TmJlTkdsTTdURGN0Q3lyeVluVmdlTEgxRG00dkRNWDhh?=
 =?utf-8?B?RE4vbVVQUnNlbnZMYWQyN0ZSWG41bFNZUTc1cVQwNXVqeldNQSthQ3ZadXds?=
 =?utf-8?B?aVhBdG15bGVEZHNPQ0hrRDM4SlVCSXhvRTZSUzErSUhZNENYdWtoK0Q4ZkFP?=
 =?utf-8?B?NDZsVEdRZ1RLMDdndk1qN05jTjVnVDV1MEZuU1U1ZkYvdnFGalZmSU1rR1dY?=
 =?utf-8?B?QlBLc2paNHBWTTQ1SlZROE93OFhVVndZMmc5cFR1bjAyWFVnZit6ankzVWRn?=
 =?utf-8?B?dXlYK1FDamtnVXM3endId3lTa0prZGc5MlVVbDluKzE2V3lLUy9Ka09LS0NF?=
 =?utf-8?B?L29oNUNmbmFvdU1WMmZwaU9VTGZnTVlhM0E0UU1VRDhjakZvVHllSmNRYjA4?=
 =?utf-8?B?TDZTRmRGeHJMZElLWmlqandNTWV4b1h3Z3dEc3VHVDhRVDBYMDdPckM0TWpU?=
 =?utf-8?B?ZG82RTB3SWh1NURjN01xOGFCT0c3eTZnQWZMWHc5QkR0WjlOd243SzZ2NFNh?=
 =?utf-8?B?eGlOL043NUF3Q3kvZVdlK1JTeW1PTlRDR29XQkxxYjVYdmN2SnROZVpFbWdU?=
 =?utf-8?B?TTM0VFltZVQ4eHFsU3Vrc3dZVWFDc0VOSVdpaGtybUNFWGhEOU5GR3hsbWhE?=
 =?utf-8?B?MDNzNG0vanZQT3Jzd0lobTRRSkR2QVNxL0VEMmp4Mi9SYXlRcStSZ0hiRUl4?=
 =?utf-8?B?RFBhWUd6Y0hwdVRYbVVOMHVKYmRMVmZmOFhvNzBaUFB6WW9GZGZhT3MxNWhn?=
 =?utf-8?B?bDRvdkJ1K0R1eWgrY0Y2OVJWRVBSZXhTUUxXUlkwcmtYUHByeS81eGFoWWNH?=
 =?utf-8?B?M1lFa25rdGlFenVjbVphT1laTUVXUDBKYWZrVG5ON3Z1elg0bGhmLzdMY1dM?=
 =?utf-8?B?NmEvQjJFWHBidW8rbDBhSG83aWpKVWIrZEZEcXlnV3I2RkE1ZGlGdjBwY1NJ?=
 =?utf-8?B?b1pxNmJsZWcrYkRIcWk5K05MaFI5clhMQjZvNWdaZmNZQ1I1bGc4cHNCUDhT?=
 =?utf-8?B?VDhBb0tEd0c1RGdxMEJLK09rZUhMY3RsWTF4SS80RkF3UnFvMGczTWlUblRV?=
 =?utf-8?B?WGloMmF2aU40d0pFK0hrLzY0WlQ3dTZxcHZxQ1V3N3Zyc3R0ZDloMlNIU2VF?=
 =?utf-8?B?NHFYVHBTS3laQy8yMS9WbTBUSDZwNEVLZlQxdHVqcHRpNXRNdzBOcnV2U2JC?=
 =?utf-8?B?MGY4bkhrUDZnM3JOb3d3bEVNQ3FFSTErSUFzdWJEdFRaTEhLY2U3UnlqQi85?=
 =?utf-8?B?WkhxTlljWDVSMDFJT2orL285V0x6ejMrTE1EQ3ZSZHRRQjNoSjU2Ky9oSGdO?=
 =?utf-8?B?dWNmTzZqZGpOc1A1akRkY0pKTzlzV3dkTHpQaitzSjV4SW9wdDNFTCtMSWFm?=
 =?utf-8?B?TnpON3hQVHdYVGUxTjBZNUNJUGFTTU0zTVpEMUQxdjJPNEZrN1RlZStzK3R3?=
 =?utf-8?B?b0tiSkp4Sm9xMFJhY3hzWng1WTFOZDN1TnJ6eXZTMjJSWE5QNzJRWXR6VldD?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee60cc3c-c0e8-4f98-b4b3-08dc7e667972
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 16:02:56.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAG0rdRUG95Ux8b2j0vDDr20jA7OVTzAuS2X+A/DVu0GOkVtjCK2GNlixjGLCBVJbO2Jqoc6hu4mDNGxDm3hPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7228

On 27.05.24 18:00, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>>> index 3c13d471f..f7aca804f 100755
>>> --- a/scripts/prepare-kernel.sh
>>> +++ b/scripts/prepare-kernel.sh
>>> @@ -1,4 +1,4 @@
>>> -#! /bin/bash
>>> +#!/bin/sh
>>>  set -e
>>>  
>>>  unset CDPATH
>>> @@ -210,7 +210,7 @@ done
>>>  # Infere the location of the Xenomai source tree from
>>>  # the path of the current script.
>>>  
>>> -script_path=`type -p $0`
>>> +script_path=`realpath $0`
>>>  xenomai_root=`dirname $script_path`/..
>>>  xenomai_root=`cd $xenomai_root && pwd`
>>>  
>>> @@ -220,6 +220,7 @@ default_linux_tree=/lib/modules/`uname -r`/source
>>>  
>>>  while test x$linux_tree = x; do
>>>  	if test x$usedefault = x; then
>>> +		# shellcheck disable=SC3037
>>>  		echo -n "Linux tree [default $default_linux_tree]: "
>>
>> Better use printf instead.
> 
> Good point.
> If you agree with "[PATCH 10/16] prepare-kernel.sh: Remove interactivity", we can drop this anyway.
> 

Absence of comments signals agreement in this case - ack.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

