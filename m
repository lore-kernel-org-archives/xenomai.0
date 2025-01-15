Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712D24A7D1
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950218; cv=fail; b=suRDW+c/Ts9e9/Kh697Wp8clpzL9ZP75t4tVopQUIV9b3kaLjdiUpurYpkKAzUHw57loQKtWmRrA2eWwcie13FZzh2VBlxgNGALhr6W39wN2ZnkZdVtHESvq1Gd3fDttESVNtY+m8Lu0qP1E08l3ZiVGSHU70F6muoBpRw1nP98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950218; c=relaxed/simple;
	bh=mWqq1Ome2afq+Ox5iwGg7cLgZ9t5444SzeC+12ejIDc=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=ZgW1HhKWt9z37V2V8Tuj66HzvUx4ZCLWJNVEkrgel8a3D16t75kGjvxXAmNYzb2aHDgajhjHisBok49tk4B5CDWOhZ6/6T2vBP98FEXJ/8iLK1S33YiHhQFXNmCtABV4GbO6wMDFgM5WYrhtyeQk16TEKf569yC+qLkjmlCL9PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kSeEBxQa; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kSeEBxQa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJpSs2zxEUQWcziI7o7uXRWDetokq3APVCsq0ObJaS0Gf6hr+hXeeSLUVc8rM6aeAMiNF01AUqyFRD+pI8EhrZDY1yEwxJO0QwZTX/+Cm6RJrYRjj/vpRvVDPTUDMx/dH7vMSSr5vX1eSYYOjq9VsAGNzNhA5evhrXNe8PWn5OI2pYEN9L1uT9AVwMNcB/QQuxr/HhexKpb2+KOETAq7TtELhN8QZf4Y6vXzsB/FUhAERbfuTG5zmUfmrxQTyaDUuhPJCciv835okDiXAQzrvOrxV96DP0Jy7Zt3wtcmYmsyoiwCX53w1n0AmZ0NXJpMBp0Sz2OPGrEVWjtBYT0QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqoP2p/F7CPSyNTtaTHTp/jnYNL5T5C79Y9wU8Ztyok=;
 b=W1p5l5z6eFfszQ6wmDInkY2kHIl/x6JQrAGnSimgTJSsby5Cvo+MczgpSl/POCNmEmY1pTeX45PMrdTFbsBIK8JKQfblWPEhjitG2lkpmP8tEH/j0Xmjerm4idjx/W17Dde4l1+O6M8gx0COZrpv4Z+/22h6JwTywlW+bxVfd5CYZ2BYcjH0MbRutxobGGBnrDvC00ykAiinP1wuhRCikHc8VfyS4TAF6G7WYzHfRbznFu6jIta51QVYwWbeOMjdvA/0BfqyMkcMxwmnjaMhzTqn6b0d7jArtLYmEpl69EIHgO89AGmdd4kwAs4pU28/iGBb7wkrazEcKI2Dv7zxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqoP2p/F7CPSyNTtaTHTp/jnYNL5T5C79Y9wU8Ztyok=;
 b=kSeEBxQaFuRK9gNmpMpSrsyk+ORM8RdLWj84VLHVKtn8UcNZW+HmZi3+kbVRAj1VXGPOaZNYCbQhX2IWHCwXGVbzWsWBJXOoiaEDwz5IuDEB+gfimIzZQKzIj1Uk1MCMKwmu/3tjwckGclj05d9JugNCCvSviPXDwWQhiFmH/gQaKMVtjVCse33gJZpYUXslTFDdJrNrGr41cHRHflYgOaP9dhQIXFNMpN+SkNEQK+Qdlb/ocDpgHTXS615nWzq4DKK1OAawdv/5Wxq9F+LO0yGT4m58OqgaWnHsTYqfgyVL7sBrLzDeS2RyF7kwpS+AN1pAzC+06IDM/on+MIthzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB7938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Wed, 15 Jan
 2025 14:10:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 14:10:11 +0000
Message-ID: <d992ccd8-b509-40cd-83f0-704c24929688@siemens.com>
Date: Wed, 15 Jan 2025 15:10:10 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] doc: Fixes many broken links and some outdated information
Content-Language: en-US
Cc: luis@eichitek.com
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f2147c-464a-4042-60fa-08dd356e534d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHAraU1MeDJiRU91RXRiL055NTA5bFVnS3VlT3JXeXBBa2ZIMDdTYkphbjJS?=
 =?utf-8?B?cW5UN1UvTG5HOFVtZm9FV2duUFYzNFJXZnR6REVzNzJ5ZmlqK0dOcXZPeERR?=
 =?utf-8?B?amlEVXRZc3VJUUUvaGZvbGo0M0MyRnNScFFVQXE3RzlkZVRpWVI3eGFkRlMw?=
 =?utf-8?B?LzNtSzFnSndyVm5pZHpVQ0d1Zk5hRXVWajE2MWt2QjBobDhTVVIyMUhSR2N2?=
 =?utf-8?B?b243VmtjSFlqQ1c3SDFLOWNkVmllS29BZ0lGSG9XbTRGN2dWYUpsUGk1WSt3?=
 =?utf-8?B?VWp6WTZlOFo4N1ZGVlVLVjI0K1o1MjNGT0k0RWM1SGhYa3VrSHlPUzd5TWdy?=
 =?utf-8?B?bWRyT0hnYU5hbTlmaTN6Vmk4bUF2UmJqaUNjNzYyd2pyaERYUWY5Tnh4djJU?=
 =?utf-8?B?TlZZVExiNVpqdE1VY0ttMG93WDFzSGthdEszS3dCU3R5MldYZ1B5NkFlbHZV?=
 =?utf-8?B?ZGVxTDBwNUs4c3B6ckg4NHBwUGpaUkh6cFlsejM1Si9MdEJuZzNUNkF3VWFq?=
 =?utf-8?B?TnBSRE9zN3hzRGtCb1V2VTlubHdVTFJvOGtsWW9NeSs3WnJIS0tYMjg1R1Nh?=
 =?utf-8?B?akNMclhCd0ZYQUJjbU1EOWF2SXkzN0FSSEVjU0FNS2paV2JnNUpKamZMTlNL?=
 =?utf-8?B?UmJPS2lRbkNNRWZWMStyRmE0TDZ2TStnd2lUbWtseFVHTGc1eEk4SCtrRGg4?=
 =?utf-8?B?MFF1R2dzVXJWU2dEdnVoWFppYk1TSHhQSSszSG13QXgvMjlKcmR1cE9QQmpQ?=
 =?utf-8?B?MGxFd2NaUG4xdlhmUFdraExiT2pRZTd6WG0yQXQ2WWcxMUJmY29yQjV1Y1p6?=
 =?utf-8?B?VytITWVPS0tRTFZXYU91SC93MTJmaWxuVzY5Z0Z6UlJtb1NsRlBTMlI3ZE8x?=
 =?utf-8?B?T25QSDRnOE1rV3lrSGg3KzRhS2MyV1NxZ0JKSkNOMTRzYS9UY0o1WUJWT2V5?=
 =?utf-8?B?ZFdBbWNOVThPOHJQOFJSVHVQQmU3MllGVEtlTzdlTDVDMG01UXJuSHpYcFhw?=
 =?utf-8?B?WlFhRGtBS1pGaldwL0x3YkhocldHbEI3UFJmZWlpY3QwYzgyS3BrS1RQVzFy?=
 =?utf-8?B?VzdnSW1GcndQUStqMXNicm5YNjMrQmwwcTBmYUdBbG0yVVFWN3N5RHNOZmdj?=
 =?utf-8?B?ell5TWxULzlsamhObjdGMEpnY256ZkN6YjZlY21idW5STnUrTERjYlF6ZVdk?=
 =?utf-8?B?YmlSbHZzWDBxWUxyY3YxMnRQZEVoVVkrS3BqUUF1cE5zanNxWTFWeFFQSTdG?=
 =?utf-8?B?ZjRacjFLdytCRFdCYTlmcWhUMHlTWGJqeVFkSlcwamtUVFNmVDF0ODNQRTZn?=
 =?utf-8?B?WkdORWJSQTNzVHdmeTV1dWgzeG81ZnYyd1dsSGloQXZ5WXAzTFBtblRZbG5E?=
 =?utf-8?B?ajBTVmlmUDA1TTU0YktHSGl5OTk2TGlpNmEzNU1ZSk81L1JqZkxOUWp2VEdV?=
 =?utf-8?B?aGxpb3VmckZJbU4zRGNZRDhWeTBuWUxhQ2xyTUNNZlY1Yzk4b3lTbWNabGxO?=
 =?utf-8?B?cWYza1o1ZlZ5SlFEUXl4T0lXVU9LQnJWMEsrY21pdk4xWU8wMXpIVFZJNENL?=
 =?utf-8?B?ZWxJcGN1WTU3dkJ2aHZUSzlZWjVSVmpYS3l3clluSThXeUFESjhpbnkwdUN3?=
 =?utf-8?B?VTdLZlkwcG42YjViVE50KzRaNmx2K0pLOUNFZXNrd2djendMWm9OT3pSVUs5?=
 =?utf-8?B?a1BxQVBxN2dqWmxOeTdFR1c4S0syVXJrcXpPZUJXaGF5Q2RGNVFRYjN2UWt5?=
 =?utf-8?B?T3lNRWp0YVBVeUhsVVZvZEFwbzBLblBWRjEvaitVNHY0OHNDd0trZVJyN2Z4?=
 =?utf-8?B?a0Y0NFpzZGg0QytYbXFMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUcxV2lHb3kxQ0dNM0Vyby9UcEs2bG9MUXdod01LM2pXZ0V5QkZJVlBrQVEz?=
 =?utf-8?B?UDAwaU9mMHRKUG9taTR2OUN0RDRQQTRIOXo0WUdKdndNTE1WY0pJY2RFb3Zx?=
 =?utf-8?B?S1IxRGwvMUJYY0MxTUNwUy82SGVlTHNFT2V6RnB1d2dSWVNYSjhLS3NoazFt?=
 =?utf-8?B?QWxWMnBENHh6YzhGYWkzSm5PRXYzMnJUMnRxVVN4cTF6eHJEeHRQN2JLMVZL?=
 =?utf-8?B?OUZVVk9qaHFYcjd2enhyVjV2cFc5ZHdDQWFNUU9NME12djJ1N1R4MDNHcWd1?=
 =?utf-8?B?TGNNcjJIMlNUdUN2R2dKS2VoNzZpcFpYZ2lBaGNKRDE1Q3VLTGVwWkF5aHNr?=
 =?utf-8?B?YmhSRmx4NTJKQ2Yxc2RaYkFpa3RUaE5FbEtyZm9LY3dFMm1GcXB1OXRhWFgz?=
 =?utf-8?B?NUpTR09DaHhidEcrcjVZYjZJZk1ndjV1TCtHVVFkZXdHYUdMVU1pWnBjZFpq?=
 =?utf-8?B?eDNnOFlwQVBhT0RpbEt4b0JqbkFSSVZHckdvMTFKbG5lRllxb3cvRklROGJU?=
 =?utf-8?B?RkVRU3pYb2VLbE9ZMjhwZHc4aVJlc3hsc2tTWWNrQzVvbmNTWXB6Y1dDUUVk?=
 =?utf-8?B?QmwyNy82SDJhZkR2THNhbllqaWoydENTTW5tNjg5T1lXazNFdEFiUTZqdmlH?=
 =?utf-8?B?VkgyaGVlNVNCN3pTUHBCS3dNTDBuYk43RkNuVWFOdmtkbHlYL3VLNkxSZGFD?=
 =?utf-8?B?aGYxWUZxb0pTSTNhdEhVT2dLVWVuZ0hZWmNseXIzbUxWbDhtYzlFRGtJYkdR?=
 =?utf-8?B?YUtOWnAxK1RzbUdQZCtTV1ByenlqMjZyWkQyaVBCODVBN2xTbndmRURCd3dY?=
 =?utf-8?B?VnJ0bTNvN0xVQ0g2NVAwb3laMUtKUWk4QlIrSVFoLzlzTnJ3Z3BpcHNERU95?=
 =?utf-8?B?RXJKVzFqOVpBcDVTUjQzYllraW1oc1JtamlpZm12QjlQdTZQTEswL2grLzRQ?=
 =?utf-8?B?SXo1dHR2UktJMkVvRVVxTDQveHQ4bHZqYWJqUDdoVHBRZDF4SXBLWjRKNGhO?=
 =?utf-8?B?dVR5WnNwTTYwcFVtOFVaWnF4Q3JRUVZoNEJEeUlxc0dRemlOSmcwUVhGNno3?=
 =?utf-8?B?QU9wSWFGYXhnMENJakdmdzBXbks2eis2dzFOVU02Z2xPb1dSYXphdTlXYzR0?=
 =?utf-8?B?T0JmTUpSWThDVzVhUDRuNk16MjVtYVVvcVFuNVUybXhzRjhmUVpZdDljN094?=
 =?utf-8?B?Z0o2STJOYTA0UndUbXJTaW9LU2xLSkV4U2xqdUJpWmEwNUFXUzNhb2hZL2Ji?=
 =?utf-8?B?WVo4aUpEcWlGWG9MbkJjczUrTytIckFHb2VoR3NCWlRCY3A5amFQK2RhSFE3?=
 =?utf-8?B?eGhnL3NvWVk2S0RJNTNmMzlRRVNyaEJRcXowQlFaS3J0enhQSW5aVjliRWZH?=
 =?utf-8?B?SDlBUUVZc2JqT2cwaG1EWmpyclZycm10MGJ4L0dwVFZnc0RXTTgzbDVZZGRJ?=
 =?utf-8?B?WFlPUThBaDJxaU1qVUZrS1Axb0c0ekNKQVlGUXNocTVmRGgzY29WN2laSXlC?=
 =?utf-8?B?UVM1d1JMc2tqbEFraXgxWTRpemxKUG45RHBMM3JLakJ4Q3k1RUlWQThFQnZJ?=
 =?utf-8?B?NG5UeDhmcnFMQ01rcllra213RXBHODJ1OWY1QXEzWWFZWGdtc1R2eE5sRlls?=
 =?utf-8?B?amlGYWEvcTRmQS9BdVd2dmlHNWNJcXNKRVE1VTZ0Y0pEMncwR3RvbXE4SGN0?=
 =?utf-8?B?dGp6ZWIxcXJFd1owbW83NDBub3dPTWV3ZjZCcFA3QlRCdlI0VmNMV3pqbHZN?=
 =?utf-8?B?Y2haTVI0V0w4OC9KdzVzRWNCcmQ0eVJDbXdVZ2djQXN4SDFiWmYwbXI2a3Bi?=
 =?utf-8?B?RkVMejlCMHYyekk0d0VRa3F3cjVQREI2WWtXT05tVlZEMWpEMVFjVEhwbXI1?=
 =?utf-8?B?Y0k1aXZMREFOVHRMcmNHUHFiZEphQ0tzQjlzRDVBUFJpTXZ4LzBKMEZacWp2?=
 =?utf-8?B?RG9vK1lhYjJ4eXMzSHRsTWVWRDFySUFyWTZPaEtsK2FCaUlpNVhpTUdXcnpt?=
 =?utf-8?B?NERyLzhHVGxPRUNKVlFkUWVwWjJkajAyTW9MUU5YdDMydnUxVGtLRVA4TTZ4?=
 =?utf-8?B?NDhNVEpuRitqZ1VDcTNnMzBjVjN3Mjg2TVFkQ1BEeDJtd0FjNnVGeWJPeVkr?=
 =?utf-8?B?VmZJT016WWNSMUlnRkhyeUF2Y1NiSmROdUhlWVd1VnlDOHRFYzk3Qm1USDJF?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f2147c-464a-4042-60fa-08dd356e534d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:10:11.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+Ba1FCov85NnU2FOW8HyZZRTG4GSE8E+1o56KRm5o6XgDnuvzj/aD261GFxTjC/ECsw6nSzPc+SElLSrPIOnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7938

From: Jan Kiszka <jan.kiszka@siemens.com>

This may be incomplete. Specifically the link to the SMI document cannot
be recovered - if that ever existed.

Besides that, this drops obsolete i386 installation instructions and
underlines that bootstrap needs to be done even with the tarball now.

Reported-by: Luis <luis@eichitek.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Philippe, we are missing a link to the README.APPLICATIONS on 
doc.xenomai.org, aren't we? And when will those changes here be picked 
up again? Did I have to trigger something? Problem with remembering 
stuff you only touch ever other year...

 doc/asciidoc/README.APPLICATIONS.adoc |  6 +-
 doc/asciidoc/README.INSTALL.adoc      | 89 +++++++--------------------
 2 files changed, 24 insertions(+), 71 deletions(-)

diff --git a/doc/asciidoc/README.APPLICATIONS.adoc b/doc/asciidoc/README.APPLICATIONS.adoc
index 4447bc05a8..0a4f109cb3 100644
--- a/doc/asciidoc/README.APPLICATIONS.adoc
+++ b/doc/asciidoc/README.APPLICATIONS.adoc
@@ -5,7 +5,7 @@ Running a Xenomai 3 application
 -------------------------------
 
 For _Cobalt_, you will need the real-time core built into the target
-Linux kernel as described in link:installing-xenomai-3-x[this
+Linux kernel as described in link:../README.INSTALL/index.html[this
 document].
 
 For _Mercury_, you need no Xenomai-specific kernel support so far,
@@ -17,7 +17,7 @@ latencies.
 
 Any Xenomai-based application recognizes a set of standard options
 that may be passed on the command line, described in
-link:application-setup-and-init#Standard_Xenomai_command_line_options[this document].
+https://v3.xenomai.org/application/#x3-command-line[this document].
 
 In addition, the *Alchemy*, *pSOS (TM)* and *VxWorks (TM)* APIs running
 over the Xenomai core can define the clock resolution to be used,
@@ -36,7 +36,7 @@ i.e. +--alchemy-clock-resolution=1+.
 Specifying a resolution greater than 1 nanosecond requires the low
 resolution clock support to be available from the Xenomai libraries
 (see the +--enable-lores-clock+
-link:installing-xenomai-3-x#Generic_configuration_options_both_cores[configuration
+link:../README.INSTALL/index.html#_generic_configuration_options_both_cores[configuration
 switch]).
 
 Valgrind support
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index 31ab801a50..60f1f9149b 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -16,12 +16,6 @@ One of the two available real-time cores is selected at build
 time. The dual kernel core is codenamed _Cobalt_, the native Linux
 implementation is called _Mercury_.
 
-[NOTE]
-If you are looking for detailed information about installing a legacy
-Xenomai 2.x release, please refer to link:installing-xenomai-2.x[this
-document] instead. Please note that Xenomai 2.x is discontinued and
-not maintained anymore.
-
 Installation steps
 ------------------
 
@@ -70,8 +64,8 @@ $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
 
 `--dovetail`:: specifies the path of the interrupt pipeline (aka Dovetail)
     patch to apply against the kernel tree. Suitable patches are
-    available from the project's link:/downloads/dovetail/[download
-    area].  This parameter can be omitted if the Dovetail has already
+    available from https://source.denx.de/Xenomai/linux-dovetail[here].
+    This parameter can be omitted if the Dovetail has already
     been patched in, or the script shall suggest an appropriate
     one. The script will detect whether the interrupt pipeline code is
     already present into the kernel tree, and skip this operation if
@@ -106,7 +100,7 @@ Xenomai configuration options are available from the "Xenomai"
 toplevel Kconfig menu.
 
 There are several important kernel configuration options, documented
-in the link:troubleshooting-a-dual-kernel-configuration#kconf[TROUBLESHOOTING]
+in the link:../TROUBLESHOOTING.COBALT/index.html#kconf[TROUBLESHOOTING]
 guide.
 
 Once configured, the kernel can be compiled as usual.
@@ -143,7 +137,7 @@ is expressed in kilo-bytes. | 256
 |xenomai.state=<state> | Set the initial state of the Cobalt core at
 boot up, which may be _enabled_, _stopped_ or _disabled_. See the
 documentation about the
-link:../documentation/xenomai-3/html/man1/corectl/index.html[corectl(1)]
+link:../man1/corectl/index.html[corectl(1)]
 utility for a description of these states. | enabled
 
 |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
@@ -167,60 +161,25 @@ The examples in following sections use the following conventions:
 
 
 [[cobalt-core-x86]]
-Building a _Cobalt/x86_ kernel (32/64bit)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Building a _Cobalt/x86_ kernel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Building _Xenomai/cobalt_ for x86 is almost the same for 32bit and 64bit
-platforms. You should note, however, that it is not possible to run
-Xenomai libraries compiled for x86_32 on a kernel compiled for x86_64,
-and conversely.
+_Xenomai/cobalt_ only supports 64-bit x86 platforms. You should note, however,
+that it is possible to run Xenomai libraries compiled for x86_32 on a kernel
+compiled for x86_64 if that kernel supports compat mode
+(CONFIG_IA32_EMULATION).
 
-Assuming that you want to build natively for a x86_64 system (x86_32
-cross-build options from x86_64 appear between brackets), you would
+Assuming that you want to build natively for a x86_64 system, you would
 typically run:
 
 ------------------------------------------------------------------------------
 $ cd $linux_tree
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
   --dovetail=patch-X.Y.Z-dovetail.patch
-$ make [ARCH=i386] xconfig/gconfig/menuconfig
-------------------------------------------------------------------------------
-...configure the kernel (see also the recommended settings
-link:configuring-for-x86-based-dual-kernels[here]).
-
-Enable Xenomai options, then build with:
-------------------------------------------------------------------------------
-$ make [ARCH=i386] bzImage modules
-------------------------------------------------------------------------------
-
-Now, let's say that you really want to build Xenomai for a
-Pentium-based x86 32bit platform, using the native host toolchain; the
-typical steps would be as follows:
-
-------------------------------------------------------------------------------
-$ cd $linux_tree
-$ $xenomai_root/scripts/prepare-kernel.sh --arch=i386 \
-  --dovetail=patch-X.Y.Z-dovetail.patch
 $ make xconfig/gconfig/menuconfig
 ------------------------------------------------------------------------------
 ...configure the kernel (see also the recommended settings
-link:configuring-for-x86-based-dual-kernels[here]).
-
-Enable Xenomai options, then build with:
-------------------------------------------------------------------------------
-$ make bzImage modules
-------------------------------------------------------------------------------
-
-Similarly, for a 64bit platform, you would use:
-
-------------------------------------------------------------------------------
-$ cd $linux_tree
-$ $xenomai_root/scripts/prepare-kernel.sh --arch=x86_64 \
-  --dovetail=patch-X.Y.Z-dovetail.patch
-$ make xconfig/gconfig/menuconfig
-------------------------------------------------------------------------------
-...configure the kernel (see also the recommended settings
-link:configuring-for-x86-based-dual-kernels[here]).
+link:../TROUBLESHOOTING.COBALT/index.html#kconf[here]).
 
 Enable Xenomai options, then build with:
 ------------------------------------------------------------------------------
@@ -293,9 +252,7 @@ although this is not mandatory if building with `--disable-tls`.
 
 - If you plan to build from the sources available from the Xenomai GIT
   tree (git.xenomai.org), the autoconf (>= 2.62), automake and libtool
-  packages must be available on your build system. This is not
-  required when building from a source tree extracted from a
-  link:/downloads/xenomai/[release tarball].
+  packages must be available on your build system.
 
 _Cobalt_-specific requirements
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -304,7 +261,7 @@ _Cobalt_-specific requirements
 
 - An interrupt pipeline (Dovetail) patch must be available for your
   target kernel. You can find the official patches issued by the
-  Xenomai project link:/downloads/dovetail/[there].
+  Xenomai project https://source.denx.de/Xenomai/linux-dovetail[here].
 
 - A timestamp counter (TSC) is required from running on a x86_32
   hardware. Unlike with Xenomai 2.x, TSC-emulation using a PIT
@@ -329,10 +286,6 @@ source tree:
 $ ./scripts/bootstrap
 ---------------------
 
-If building from a link:/downloads/xenomai/[release tarball], a set of
-autoconf-generated file will be readily available from the extracted
-source tree, and therefore reconfiguring will not be required.
-
 When run, the generated `configure` script prepares for building the
 libraries and programs, for both the _Cobalt_ and _Mercury_ cores. The
 core-specific code which may be needed internally is automatically and
@@ -776,7 +729,7 @@ $ dmesg | grep -i xenomai
 
 If the kernel fails booting, or the log messages indicates an error
 status instead, see the
-link:troubleshooting-a-dual-kernel-configuration#Kernel_log_displays_Xenomai_or_I-pipe_error_messages[TROUBLESHOOTING]
+link:../TROUBLESHOOTING.COBALT/index.html#kerror[TROUBLESHOOTING]
 guide.
 
 
@@ -792,7 +745,7 @@ $ /usr/xenomai/bin/latency
 The latency test should display a message every second with minimum,
 maximum and average latency values. If this test displays an error
 message, hangs, or displays unexpected values, see the
-link:troubleshooting-a-dual-kernel-configuration#the_latency_test_shows_high_latencies[TROUBLESHOOTING]
+link:../TROUBLESHOOTING.COBALT/index.html#_the_em_latency_em_test_shows_high_latencies[TROUBLESHOOTING]
 guide.
 
 If the latency test succeeds, you should try next to run the
@@ -813,7 +766,7 @@ recommended to calibrate the core timer specifically for the target
 system.
 
 See the documentation about the
-link:../documentation/xenomai-3/html/man1/autotune/index.html[autotune(1)]
+link:../man1/autotune/index.html[autotune(1)]
 utility.
 
 Building and running Xenomai 3 applications
@@ -823,11 +776,11 @@ Once the latency test behaves as expected on your target system, it is
 deemed ready to run real-time applications.
 
 You may want to have a look at
-link:building-applications-with-xenomai-3.x/[this
-document] for details about the application build process.
+https://v3.xenomai.org/application/#x3-building-app[this
+page] for details about the application build process.
 
 In addition, you may refer to
-link:running-applications-with-xenomai-3.x/[this document] to learn
+https://v3.xenomai.org/application/#x3-running-app[this page] to learn
 about the command line options available with Xenomai 3 applications.
 
 Migrating applications to Xenomai 3
@@ -835,4 +788,4 @@ Migrating applications to Xenomai 3
 
 If you plan to port an existing application based on Xenomai 2.x to
 Xenomai 3.x, you should have a look at
-link:migrating-from-xenomai-2.x-to-3.x/[this migration guide].
+https://v3.xenomai.org/legacy/migrating-to-xenomai3/[this migration guide].
-- 
2.43.0
