Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B12BA20
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279881; cv=fail; b=i1VBniGn5LePvW1fPn0xC5M+w1k67uMdsU89IGXXTR+J4C05NEw2w7TPy89PUGACsdo/HtzXo2AgrVZJ8gmUPdeu84YOXiwETpv0zBfgJCnXDg1EnWSomeYJcfOciWVeQpjxZvvCTzKwsu9NUJqafPXZdSmINNkbkxEJT0elXR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279881; c=relaxed/simple;
	bh=yvisEe26FKAnC0gsZWCqgKYeqU/atrjNkij00eO6Rp0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pmi5Gvizan5ApqzGbp1FxOH01q/6xounqR6VEAFE9lrJDyb6bUITEuCm7YudHwyfWsjGh+gmxl6uVCmQYeAW/a5t7/38/llf0R5QCNgNl4DEdQafViU0h+wvBIHWiaUQEMZf5gawXDjAGD3OejgqgqAs11uqBv74hdGQ132wet8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NJqHeLVc; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NJqHeLVc"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 10F80200006;
	Fri, 22 Nov 2024 12:51:11 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20603.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::603])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 43F039417E7;
	Fri, 22 Nov 2024 12:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/bqAKW4JPtXOIlNtiynfkuwItOYAn/u5MStnj+bdcy3lTuiUj7uilSgNOzaRNBEL5l+Z4MNOWtU2rn9br0ekpEf56hMhcNpAdBlMYmSKb3FN/Xvo6CGiLF5Dz3YNAMkCLv5P6iCIcCNEjy9BoCqKbGv0Mb5bqHQifLqsYTZ56Z2ilcj1VT9DOkgFloP3JxwdnLpDATxtAr47Obgj4YpEFNTY2AoIY9UkJGKEGnHtN1JVJL21fAbaDAE+rkC39h5V4NoEVSR4ZHvyKY6q5yM/+8WIEgFjPiWfaKfiJ1jvzrt6fookLYiGUcinM/fDotIkn7DoCnZbSnSdGNGcRW59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE1p5lQKhoM793jU4xUVQIRfqOw99Gh29/uQgCF/eaI=;
 b=yiConF6RsC7KB2k77ohnE+qL9HVuicW/HrpgWCJRprEjTxs17vTCfx4BAWQ5kQBbqxlcHictdrkr/rnHqQGolGNHDMTbviEuqL0naFdBbyiZJE9bYpoAXKttUWbIP9zYTGVQ4B1NAacwyTRKm55DPouaAoRoRDrzrpKc+jOh2mLaAKw9G9A6Lk5toKYKVWGrd+rq1MscnB2/+YRZFqOZmDv7+fUFpnEzYnSTWVUVrTUROIAL+vP+vCOo/lefbCgmMyAXkcMFZRzCbVVQfxWHxEQj0+yy2AsI9dWS+v4za6ynoh8wMxaGwGO4I92pH3sJ3jl488kkn9RG8Dg8EBZqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE1p5lQKhoM793jU4xUVQIRfqOw99Gh29/uQgCF/eaI=;
 b=NJqHeLVcaRrfy8/7w79f9MvGZFujWxLKfeGsQLxY30EQ5RiZ+p9Z86b4CmebvM9+l25bHbhDXgRHNKcS/qajE6wjL5MzHhg77WrbiZb5jiH7cTSU/oM6mmuAS7nRz/kKigdluSlUJ3ajqabVETlmhOMggln033KHaBWIFUZ0AMy8lzITTLyj6KuX/uyEGeGrlf6dRf70cjkiFPIEttvITGQDQpVejqlHvr7uffL8ivkpPMSrQGLIr7sO1BleeRvRoKMsNuJRFG2SF7qKnht/WC9JpyQ9yCmBqIWqs5v4HQmJhlrw48UYIkTX6JC1jSlF9mke3WD3vw1ajnSEqgOmAQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 12:51:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 12:51:07 +0000
Message-ID: <c0d68831-8391-480e-94c3-b5666edac991@siemens.com>
Date: Fri, 22 Nov 2024 13:51:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai.org + Giltlab
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>,
 Philippe Gerum <rpm@xenomai.org>
References: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: fe17caf3-610c-4a5e-85e1-08dd0af45504
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhuanFJNTU0dXhvejYzN2VMSWFVMWJ3YWJ6WkFOaDBTdzlzbERHVk1SME54?=
 =?utf-8?B?OEVRcWNGN3R2OGt3aHZyQ2UyQi93YlBaUUhpZ21pZ0V6T0FuUmk1L2pyazUy?=
 =?utf-8?B?T01SQm5wd3RpYnFUaVlqRmhKT1AyTmxPYm5JQXVINE42SFVwNTFORzl5VGk0?=
 =?utf-8?B?eDdRaXhRUGUxWENwNW5vWkk3KzV3RVNOc3Z3MG9EMlpMckR0TCt3WkRjZHJX?=
 =?utf-8?B?TkpOaXpML1lQU3ZudFNXUk9CVzVCdEtqL0VPRk9XUEZPQmNxQ0N1ako0cms2?=
 =?utf-8?B?Z2Mrd3JmV2tuTnFZVVFONC9Yd29FcDJEQkErV3puMlZIVm1LUTJBSjh3SUFF?=
 =?utf-8?B?OHNjN21jL1pteVpMWGUzZk9BY1R0UG40TlNCYXNFR3l3ZHgra0JudDJWYzk5?=
 =?utf-8?B?VDZSRTJOVHdhVkF2MVhCbnpIYXh3aGxCS2dpMHREUmNCQnphNGNaUjRMQ2Vj?=
 =?utf-8?B?VDY0QldGMzFTZ3JublJPbTErSmZ6Y0cvL2NFUEkvMld5Nnh2M3BpMVp2QU9V?=
 =?utf-8?B?QnBibnM0V2RVYzd2TUNWaWZmTEsrWDJFWUcxTllsUXBvZmRwVWMyN0RnVUFN?=
 =?utf-8?B?L1BFODVUK1FSVjJFN2t4aVR1UUwxRVJ5b0NxR2ZWaFhxTjZuMW5wa0xNN2lR?=
 =?utf-8?B?anh2YU9laHFkaFN1ejdYeU4wenVVeHQ2QlV1eTZyQmRuSDZObmNuR2VmY0xp?=
 =?utf-8?B?YmxGVGRvR28ybHBQaEtlTWFEdllOQjJ1eEJXSk80YVoxd2p5dUxOWkJaOW01?=
 =?utf-8?B?YWtINjVqRm1jc21HS0d2T0VOeFhTNzdGYWE3aW8ySjVBMCt1RDltRndLdy9Q?=
 =?utf-8?B?dWRiZXFzdVkrRC8raE5kZWJMdDRVWmhDWktxVU56dUFXWlhwc3NYSHZvdEJJ?=
 =?utf-8?B?U29jbVdSeU1QRVdOZ0RqSnRnY1pjWjRiQzRKZWcrUXZTUWpSUWtYUXE0TFJO?=
 =?utf-8?B?ejBPRW5ISU5VZ2FtQTBkSEhYSDFQdGRNNElZRkUvUWVYMTNteVg0OXFLVkIw?=
 =?utf-8?B?N3hFYTlDS2xqdndoZjIyeEtlVEZHL2kvTmRMOG9iTkdvWDZqTlp5SU9GUmQ2?=
 =?utf-8?B?UlBrdlhSL0d6UDFCYThlQi9NakJKUFc4SXhUL2d4T0ptMnMrS2N2TWlaSTVz?=
 =?utf-8?B?aEUxa29WUnNIVXhYYlNNYjJKb0pXNVZweWF3VjB0Ly9BSVVzQm9nMlI4TUVZ?=
 =?utf-8?B?VmJ6SlF6ZUJRWDEwTXlQcklUT01KZkFWeUQzY3pMbXNsQkNiRzZXcXdrMlp3?=
 =?utf-8?B?QVBVd1VoeCtFa0xNamNRWUg5UlA5WUdsWXpadVFDcW1tWjVIanlOVTQ1L3FQ?=
 =?utf-8?B?c3FvNytJOElsM28xc001bzFWQ1ZmTDY5K1RJR0xWRmY2TSt5aDRhbytPZXY2?=
 =?utf-8?B?Qm80eHlURitEblUvUDNzdHdBOWo5UDBjVjJTL01zaWs0Z1l2dTZvNjVZVnFF?=
 =?utf-8?B?ajVobHVHVHlvd3hKaGhISDJzYzhhMmZ4SlNnK3FMRWVDWnZuYjU3YVUzUGtn?=
 =?utf-8?B?cG1IbXhOV2I3M3p1RVgrU0pOMElFTzl5eWI0ci9BK0Qya3FOdXRJdlJ5UTRJ?=
 =?utf-8?B?VXVZY0NwNnpNZWdZcWdYM2dQUXV1YUM5eUtHTmdmdW9qOGlSdysxVW82UEx4?=
 =?utf-8?B?RS9XNnkzQ08xMUVTVldsQnpDTFUxbWdYMVdFcTAwY2xlK3dIcEpYVjd5SWJS?=
 =?utf-8?B?N1VPS3hiVlllODRjOTBDRFdXcitZSGF2WDhJZlJUM1dDUUZoeUp3b1dtc1VP?=
 =?utf-8?Q?62kGqtui9tvu37UfuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUV1REhUR0FEbWxDNU5BeEl4dDJ1MFAzMmFYOHZ3b29sTTJPeVFCL2Y0K3M0?=
 =?utf-8?B?VlJXZnpTTVhCaHM3a1d1ZlljS0VORU9VZDQxazV6VldueW9UK2hRM1I5dGJJ?=
 =?utf-8?B?OTZjQ3FWZTQ3SzBaQlZnSTkrV3pGaXVQN0lvZ0ppVDBmcTh4VjRKblhjano3?=
 =?utf-8?B?a04vcUxSeXI1aXVPMjk4LzU4L2M2NEVBcGNMMmZaOFZPekRWV2VranIrUktG?=
 =?utf-8?B?SjdESTNIV1hMZDRrT0lSSW5JYzR1alZmNm1iY2QzQWNhQ0R5ZmJGSnJ1M2lJ?=
 =?utf-8?B?cUxSUjFEZGgrbVVxU1lBNUdNOGFENmZiR2ZyaERnMndaZGJ4dk9YaEV0TURC?=
 =?utf-8?B?cDFGcTd4Q2pjWVhTT3lpN1BidC96YklCRzNNUDA1SVN1SW5vcUVlcUFOVEdq?=
 =?utf-8?B?UkdGb2habWlKSTdXNXJOYm1HRWkwM2VNcUEvZ1hhT2U1ci9FOTVMV3dsVkxI?=
 =?utf-8?B?WmphOVU4ajJWSmJJVGtWVG5kUFZnRlpJMWYyUlpxcWhxVDl3ZDl0dDB4VDlX?=
 =?utf-8?B?dGlCR1MvbnJEWkZDSzl0LzVYeFo1RDhaajZnRUlSejlJV2dMQWpJNEpNY0Fr?=
 =?utf-8?B?TXdlQkNhYU1GZXRPRVZYdWdhNTlnZFcwNUVyWHhza2RFVWJaTlprTS9hZjFw?=
 =?utf-8?B?ZW9oRnQ0OWg1UHh2cGlBcnhFMEx4c0Q3emViTjFUc0tkTEV4UXhMNlUyVWo1?=
 =?utf-8?B?azJhbGRGRndaM0kzaWFFMGhCcFQzYXJFdDMrdU8zS2Vuc2YwaEpDeGZrNVgr?=
 =?utf-8?B?SnRVWG5tN1ZrT0NGVHRGRDgxWTlxRytIcG5HWkp0a0dYQWw2MUtPM2szWjJW?=
 =?utf-8?B?TURMcXB4NlpjUTAvV0pBclE3RlMxMlhNNjdMWlpjc0V4ZTNrQndnVlJYelhx?=
 =?utf-8?B?NjM2Slgrb3ZINkkrYjhJQjUrSEhnclZZbUFSWHBkUGo1UURsQnhiTlpJMjFI?=
 =?utf-8?B?NDhvaWhlandscURtOCs4QlB6VkVGdjBrQ3hLVXdrN2JVN1ZiMlJjakswdys0?=
 =?utf-8?B?YlgvYlZQQXNVZ2xOdk9XaGZkUDRKQlJRdHFlK2N2SWVNRExaNmhqK3ZkNTlO?=
 =?utf-8?B?M1NyZzlYL3h4VEZuQWFvSFVQcEVOMnN0Z0NRZ1BnYVJKbnFrWmZSZ3JOenRO?=
 =?utf-8?B?RUdlcDJJNEFpRnh3cHV4TmRHRkFWajRCQ0ZIUys0dkRFWmNDWURaRngrdTEv?=
 =?utf-8?B?SUVCTlg4dzRXRnN2SC9KTmlaVU04RFh4c0NWVDViL3FLcUZWT2tVRGk0dDg1?=
 =?utf-8?B?UkVxZDBtNHZMMW04UFBtcVhQbWJ6TVpoSG5Cak15Y3VFK3JodCtxSnN1b3pG?=
 =?utf-8?B?VWE0NTYydHp5OGlxLzZDY2FKWTl6Z0J3ejJxekJzaW9VdW1wemFnMW1LdWlU?=
 =?utf-8?B?RG56UUVDbjZTT2ZTdFhYSG9pViswOFk5QXFESkJCbGlPVWdaMU5ncTBoeWcz?=
 =?utf-8?B?Vlo0Q3JSTHJCam1hdEpqYlUrZzBHaFlWdnNLUEoyL1k2MUlZTmJ0OWw0T1Ni?=
 =?utf-8?B?RnJHSjE5bXI3ZTJoajhPSVB5L0xiWTlOaUhyUkp1S0U4VVl2eXBSV2NvMDM1?=
 =?utf-8?B?Ym5DN0h2ZnZveGVhMGF0L2NIUnNJajlhaWlwY1FmSUdEeC96R0JtRitoZFRL?=
 =?utf-8?B?Y3B0bm53MWdaam96VW1tbGpVZ2g1bllIN1JpalB3Y09TUGNPdXJma2czRWxW?=
 =?utf-8?B?UkhzbmpqL0ljbVFtc1E3K0t4LzBJTU1RVENld1BNc1JPeHd0TUpuY1FiZjRh?=
 =?utf-8?B?N3Y4QVc0WStna0w0WGtFcDA3NExnRFB2MVhGZnMwSjVZRkFOdUE4NHpBY1pV?=
 =?utf-8?B?cXR4UElvczE5dzhsRVJpanpUVzVobjJiRzNCR0Q1MFVSUCt1Q2g5U2kzSHV2?=
 =?utf-8?B?OFpvc3JxT1p2b2RodjRDTnNSc3pzaHcxbUQrSTZ4Q1JzNHdQdUMxOGRXVHc5?=
 =?utf-8?B?Z3BWZ3l3VVRLT2gvODAvZzhwTk5ST3pSNzczeTJnUlVCOTRjQ0d4QUpDSVZu?=
 =?utf-8?B?MmhheTJvZnV5WGtqcmFEc3V3WEpRTnhaWFZ3Q2lsSjJHeFdzMGxDNm9RQ0d5?=
 =?utf-8?B?Q2NneGNpRkFWaDJWekxvUVUxeCtic24vMzFyT2VUZ1czcXV0dE4xd2QxOWNw?=
 =?utf-8?B?RlJGbi95dElFYU1yU1RRam9OeW11NWdoNzVvVm1BS0FxYXQ0cUt4a2hqZ1Vp?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe17caf3-610c-4a5e-85e1-08dd0af45504
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 12:51:07.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmnzV7BXoXWizLdzGOezsJM3JcInuNtOUi+CY0PdREwaeqIIcS7YHYdnw5yg842b4kp8uCfiyRt00U0aiVY5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8835
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=NJqHeLVc;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2614::603) smtp.mailfrom=jan.kiszka@siemens.com

On 22.11.24 13:44, Pierre FICHEUX wrote:
> Hi,
> 
> Looks like there is an access problem sometimes...am I wrong ?
> 
> Error 502 on the website, very long access to the Gitlab.
> 
> regards
> 

Confirmed. Philippe, anything related to you refactorings?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
