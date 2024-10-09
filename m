Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044F18785C
	for <xenomai@lists.linux.dev>; Wed,  9 Oct 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473430; cv=fail; b=To6eKDl/jj2Vr1N6U3IfPun+hkljwL+vWv329u41BnhS4vsBRKVuFD1kxwluuMX1ogVp/VvVG+1nKkB44X0+dZxL9jM5d8PVdbzU/jaIChnVQ4/ss6F4B04OIVBhtrAhZfyRC8br4x0S49XzC1CJJFqei4CX3Fj5tshAxh127mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473430; c=relaxed/simple;
	bh=E/id9xK4A1bljPNTbjJ5OPVYhdXrCwx8MJ9HYCrjonI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jh0jgQWjR7otJGKTjH4jTAyl0K8CVzCI2RYtdDqg/eUd/O5Tw3xS/v27X86s3/RF7V+csx2EkOR67OBt7kUNC6VkG8s+yDQ/rNszAuEdoJ6FMPR2/OhXSHr1YObAniyoGEqxDTG3XHovy4ypIOjL15Zzi0z3oHQBZSBYqZziWos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EOfocmEZ; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EOfocmEZ"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id D95BB80009;
	Wed,  9 Oct 2024 11:30:25 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f403:260d::60c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1AA20D807AB;
	Wed,  9 Oct 2024 11:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI66YiOCtBWvHIEyrtm+iIQ0uqXtLgUa/6f0VcV12M2MRbABT2RxhdXlY08buHwesvbZdBk7yJbTdMEG2Bc8+rlUHdiH3z3mmZAq5XNVb45EvMZapGSMOuAHXOyeXIkdXTTElLy6cwuSQJg+6eTTbkvLXYNRSaZLIokFxSTMp5I9ZmUkT1tba9O6BAIKU+6nbtPgtQ+2sirl9mSXtj43o0fFaDVncF3kz07Kz7yPoF6G4w1/0lx5lnQWu0cXEjLGgNpV0G/6et327Q7Kl+78JXaMTzR2+KZdx1EyvjNB2sW4K9iofwg0f+bVdtRpapvMbyjPGyNu2cG/8UFLYS5T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7AuAHiwWsNgtjM9Z5Wg9HzACIiIeT2cW505dRZeuxY=;
 b=Hqyg3RP9f1nxR5oNcctnBIcAv7yHvaofRsqJHh9YcH/4Btk/ESkqEi5L0UlWZgqnWEMt1u339NpEIpCffdFioRDvfRuqpiUHvgdqo1XOZRFd6XpdIPAaOWu0ngsVlAm/43yIcsIcLwEz/AoqjIfb7F5rq1f+bqkuyNu0ytzW2VQagmjmVu2S2FKybQ7nI583vzxLswEE/eT3wsGS66sLBNGAb/XSmhj1YpFbp7gXK2zJ92jsyuvx+CLmygL3pPjK3LMf+dXM5l+ShNQj1BfoVZQL1s5rPO1Fs1p1uGRAwEh95BwgNe/ptDuZanCEjiFslNOEjYkWFAAjpcbtSHIZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7AuAHiwWsNgtjM9Z5Wg9HzACIiIeT2cW505dRZeuxY=;
 b=EOfocmEZss+tX8tig+AeKnIBLcEQ5uXdCk8VK8sa7I+gUO/gqrF8S5PM6jcDUGOb44dNm+3Fkh3SpV34e1+r5vgcG3ElUqxmv/zg4g1P3kLah5LofiAdmCGdlnwzGqgr48kEfDidbY8gx4kjF/svL3nOdRu4Zy3rXRx0dKQKhLFqJYG8LQt3ArN51E1xgVjX4Kb+HcxisiExszbsx0DiCm93PaWfv7Pd5bfSksPXyCb2SM6L2lNqTfakKW+FZYgEayIv+G/7DZ2enCUS2eopGZQtLg2Y/Y2qEhFAy6/dvCE3n4imubmaNufdt7oNdEvSESGByu2TJez3D193F1kk2g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 11:30:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:30:22 +0000
Message-ID: <c46df2fe-569d-4010-aa0b-65934d88a2e1@siemens.com>
Date: Wed, 9 Oct 2024 13:30:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: POSIX API for EVL
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@xenomai.org>
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
 <87set6lajm.fsf@xenomai.org>
 <CAFc1U0uaqt8Kqd3+nFijfukFousvWHmM3KQtRqYGRkezDgkQdg@mail.gmail.com>
 <815623d2-2222-4eb7-8c64-2f5f9aaf48fb@siemens.com>
 <CAFc1U0uTCHrAzUp=PKh8eG0QxHDc2yEEbPzbkTde=S_cVVw+JQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uTCHrAzUp=PKh8eG0QxHDc2yEEbPzbkTde=S_cVVw+JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b947c1-1923-45d7-1d3a-08dce855c35c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzY2bDAwUjBWNDczc29Wd1AwempNcE1FU0JMN2hyOVJMZzNrczMzMlBXNGFZ?=
 =?utf-8?B?RWZwNzMvUEJRZkZiWEJWTFRCY08zYWlsbElaS2xWSy9sZUlOd3BlREhTN1JO?=
 =?utf-8?B?dUh3MjFrb0FFeGNhMllDTDdHaS9PTEtHNkJpbzh5THBHTmhnV0xZbjhHV3JK?=
 =?utf-8?B?bm5STkR6bDhqZm5pMWJyYitLNmNPS1VYS0RYKzczR3dYOEZ2LzlqSDJhYjlZ?=
 =?utf-8?B?bmtzV1ZudXhrU0JLdElESHBiZVhiSkVoM1R2V3o0dVc2ejB0alhSQUgwS0xu?=
 =?utf-8?B?dTRIbWRNRkZ4OFc3czhhWkhtTEgrVWRoaVg3Tk5oTnZ4M0JpcnVLd1pPU0wy?=
 =?utf-8?B?R0xxOW5CRnlFVVVqeW55NUszVXZGZXF5T1Y5U1p5VW1IK0Z5bW9lM3hVb3Jz?=
 =?utf-8?B?ZnN0ZXVwOGMwNVV2WkhvWWQvN2VxUkoxcEt1UE4yMTQ1bGs2bE5XcGFwY1pu?=
 =?utf-8?B?bm9lMUFHZ0UwZGtTN1lLSHV0REVVVm9BclR3OFl3ZzljYy9sM3pjejJwbkl3?=
 =?utf-8?B?andUS1hnTVE1Vit4QmtTZHg5YzR0VTVFdDBRcmNkWldPTnllc1d1VDlwdWIx?=
 =?utf-8?B?SXZSL1M2L0VHNXVWaVhiRytuc2Y1MjVpYkhIOVFJSGdEbExoZndBT202UHR5?=
 =?utf-8?B?cWVhdS96MjAzY2lMbVhVYmZyUzFiY0lXNG0wWS9iWkUxNU1IaHFxb2YvRzN4?=
 =?utf-8?B?WkdVVW9HYW44dzJORFdsMFQ0MHRqWFZuSzF5eHhBc0hKUTNiMTY3a1kxQ0ZK?=
 =?utf-8?B?MWVIY1NSVzVrdk9YdGQ0YzhkSTlvWjFidnl4eXM1K1VmVmhxQTJMTHVZcmNl?=
 =?utf-8?B?UWw5TkFvN3FMSWx6NWpNYUl0UlZxQnVkb0lvUThURnM2VlNwSXM0QVpyblJI?=
 =?utf-8?B?dTRCYjZWRzZpRkVKRFpHYUZGb3ZMeGpKYlN3TkpnYmFHY2dwZHJIMTlDODR3?=
 =?utf-8?B?T21LaUV2Ri8xTlhOTXFTL1BBUVdHMUtaV3dJVHRHdlFRWjY4dnI0SGI2dEFO?=
 =?utf-8?B?d045ZlZwMkhOTHNxVE9QWm91VUFRK2IvZCtLdWE4UC9yUzhMSll4OVdCVUFR?=
 =?utf-8?B?ZXpCanYvcjc2MWZBM2cvK000MkdoWWNQckxJV3ZnODFCZUlWaUFsWGFES0VB?=
 =?utf-8?B?c0Y3ZWpaOFNWdUFueEI0c2NpVi9STDRZU0hkb3VCdFdUR0NwblFqbmdMbDNx?=
 =?utf-8?B?bFpRUTNMYlp5Vy9nWmRtOFRtVk1ZOC9FYlg2RzJjejh1Q1BQaDNCb1V5MzlZ?=
 =?utf-8?B?Ukl3VEV4dzIvZVptcXo0WDVrOXF4R1RnNjBOVVhaMndoYURUTmZhVmdiZGJB?=
 =?utf-8?B?c0ZwQXhGUEwxby9pc2xQTVdZVDdEUVNxYU9XYmFoOXUvVEZ4bncwWGczaHg2?=
 =?utf-8?B?cFFSK2lHODNwSS80Njl6WFhXc1JyTklGRDJBZ0VldVQwV2d1TnIxNndVU3JX?=
 =?utf-8?B?UzNZSHYrd1c0WmhuYnFTeEdOcWJVcGNjNGtNRlh6cVRKN1pUK2NKZndCOVpt?=
 =?utf-8?B?RWFvTEFtbUMwK2YyWjM2VzZjU2tTNFJqV1dubXBUZitHM0trS2laa0g2UGM4?=
 =?utf-8?B?REFTQWVheFJXTXkxemNtL1FYN2tZRnpVMUk0azBTZXlVR2NLS2pOdnlKM1BE?=
 =?utf-8?B?OGVkVVJTanhKTG1taWZ5RGduTzJkYkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck8rd1dLcGxOeFdudWpjWE15L0dSWU0rOFozcGZiK3hLVnAyMWp5N3ZjRFh4?=
 =?utf-8?B?NWFXL1FFWnVMK1Z3QmhjbTVIWFI4UlpMTDJRUVdKK21QNGZuK2pYZmIzVG8z?=
 =?utf-8?B?TFVHT0NMaUcrQi9UOWdKQnJzalNtY1VPckxUcUN2YTR5WHMzU251L0s0OXBQ?=
 =?utf-8?B?U3JOY1hGNCs1VXdkQ29PaCtjVHBhNkZVYitITjZFNExIVWRGZDkzaGUyMjFW?=
 =?utf-8?B?bVpHaDM2WE1pTDB5VkV2QXFLT0k2WEQwcEFWUUNQODhDZkgrVkRmSytRRW16?=
 =?utf-8?B?UURmQnE3bWRLNnMxV0xYNmJtQWFpWkovbFdSME1qYmpiMGJJT1pHZElHN0tq?=
 =?utf-8?B?SHh6WC9yRkVSNFAyRkFnT0tjYVN5SG9yd0ZrNmllZXMwbEpCUFBOaWdtMit3?=
 =?utf-8?B?bEJlUExFaHE0RVpMbUhLc3ZmYk10a091MHJlcktmL2hBRzE3clRXa0kzWTNK?=
 =?utf-8?B?aFAvcnppV1hrRk9ZREFVYlRoSjVuNklSZHFZQk04NkYvOGtQU21QckJ3eThp?=
 =?utf-8?B?Z3A5Q1VsV3F3QkpyOElTWk5YdnFpSmtPbHBWbklyUlg1cWhoS0hOVEFKbXJw?=
 =?utf-8?B?SU05cEk2cVJUNytDVU9CWk5zUklRVW9XdnRxaDA0enoxWFhUOFh3QWVIU3pj?=
 =?utf-8?B?Z3ZydHE1aXF0bkt2OVo2R1lHYjVubFI5SGxaWHlralJ5NzIwWjZSTHAyV2U3?=
 =?utf-8?B?d2N3TnV0dyt6aUFySkxOUnlKVCszaEx5SThReU5KQktsKzlrd25CUW9wNnJj?=
 =?utf-8?B?VzZRQUU2Sm9QaVJnOUY0MGtjM3F0S1ZhWDdzL0Z1cVJkT2s5NHNiQkFrUmhs?=
 =?utf-8?B?RjhxVTdRTHVVTWlUUS9IUklLcjB1a0d3WUExdGNDVE1DdGtZSzk1dTVIanlS?=
 =?utf-8?B?by9ENFp3cDh0M1dDQW1KUlhHQ01wQnltQVZIZE1hcm1DNHdOWlZMaEVScDVv?=
 =?utf-8?B?UFo4UGFUcjNzQ09kamE2OUhjVW5LNGZxazZ6SzJwQzBSNWtLbGdJTk5telNy?=
 =?utf-8?B?NFFCVHdoOXZkSHZmYk1xSnhWTmllRk4xMHVsMnVxS0lHRHZXSllHTnVHc0NY?=
 =?utf-8?B?UlkxdjJPSkNaWDlZTlVqdVdPUzN6QWIwWTM0SFFqSzRabXV5Q0RZMHhZZklB?=
 =?utf-8?B?dVR2S2JUVWNzQXplM2VVZW0zZ2FkZFFEckZ5T1pZM1Nnc0c4VHJpcTd0VEZl?=
 =?utf-8?B?Q29xMElJRnYrK1lIK0xYR1M3VGp6VE1sejhscjJkeE1nNmY0UWNEUWR3OHJ4?=
 =?utf-8?B?MWQ4QUNhSkhnVzJqTXNFTE1YemNUcDlmLzZsWTFEd2FUWlFOZlpNSUhYZnd1?=
 =?utf-8?B?dGlqYmJPemZqbWtZNE1UdXJ1azd1VXd0TU5JYlZEdHR1M2hUZURIZTNCbDBw?=
 =?utf-8?B?azVqT1RXQ0Q4YTQ4R0wvWlJ6ZnJ2bnlSR3BUNC84RjhhdWpIbU1qbDBzUUZo?=
 =?utf-8?B?L2hxVm5ieC9iVkNZWWJ6WkY1Z1ZtSkNjVHdsNHl2QXZnS1RoeVUzN2JRU1VD?=
 =?utf-8?B?a0FOM3JPQ1l2bzE5QkVUSHFwSVF5V2lGbGlrdjdVWHhzTFNKNFU5ZGRDc3pK?=
 =?utf-8?B?YkpjNGhRVldtUFJtTFd6ejc3cGRXeHpDeVN6VEM3eEdTVzZla0tNWHRVaGtv?=
 =?utf-8?B?VE5UdUpZZC9rK1oxaXdlWmFmNjU2KzFYRDBSemVxdWtVSWhMcGFBa3hMaEIz?=
 =?utf-8?B?NW52Zldyb2kxeVF6eThqdWVUMUljTTF0NEJxTy93dWhNZUZvbzVuUmh2WHR0?=
 =?utf-8?B?ZlE1TVd4dUczZE13eExWWm1kelFpVlFPbThLZTdRbDhRY1JzNjRpeWJBeDFa?=
 =?utf-8?B?S2VuS1JzbThKSXpwTUdSQXkwc3ZnazVyUFZPdHNsbWZOaHpNd1lET3ZGWmtt?=
 =?utf-8?B?dmNTSSs1OUpzUUgwR3ZGNjF0b2VqbkdHRnZqckZiaWhzajF3WEdZTTRqMVhS?=
 =?utf-8?B?OVNrWkhHMUU4Y0wrSU5EaittTjdzRmNhRmRyRnlqck1nUS9DMEwxZDdnazFU?=
 =?utf-8?B?Vmx4dVhFc0gzM0pEUUFOUk0zZmM1NUlXL2ZLL2l3bWhuTWpKclVmVzlFMnIx?=
 =?utf-8?B?KzFZcUJvUnZqd3RjSHZEUUZyZS9LTFVBb1BNb0VYa2hVM1F3VW5SZ2hrK1RR?=
 =?utf-8?Q?amoJuudGGaec5Tug6x0ZoTtuy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b947c1-1923-45d7-1d3a-08dce855c35c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:30:22.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMl4Etztp1Jd4+AyXdt3ZO+STr3woMGYctP0qW8/wJx80G3WX6VK2rBP+yioQMo1p41TGipmIx22ThN80pF/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5181
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=EOfocmEZ;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:260d::60c) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 09.10.24 13:20, Pierre FICHEUX wrote:
> Hi Jan,
> 
> I don't understand: how  can you  "enhance portability" without POSIX ?

POSIX would be a precondition for us to get any traction with our users.
IOW, when we have the time to look into that, we will do so - but
nothing is scheduled so far.

Jan

> 
> regards
> 
> Le mer. 9 oct. 2024 à 11:59, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> a écrit :
> 
>     On 09.10.24 09:53, Pierre FICHEUX wrote:
>     > Hi Philippe,
>     >
>     > Yes, I do remember.
>     >
>     > https://source.denx.de/Xenomai/xenomai/-/wikis/
>     Common_Xenomai_Platform <https://source.denx.de/Xenomai/xenomai/-/
>     wikis/Common_Xenomai_Platform>
>     >
>     > The lack of interest is a bit strange as the industry is mostly
>     based on POSIX.
>     >
> 
>     I would say the challenge of moving forward is right now that users
>     already on Xenomai 3 are happy enough to stay so far, plus some have the
>     blocker of missing POSIX with EVL. So, there is now an upfront invest
>     needed to enable POSIX over EVL in order to evaluate if the own
>     application works even better there. This is at least the case for our
>     internal users.
> 
>     But my plan remains to enhance portability from Xenomai 3 to 4 so that
>     more comparisons are possible, and we may eventually even consolidate
>     over a single code base again.
> 
>     Jan
> 
>     > regards
>     >
>     >
>     > Le mar. 8 oct. 2024 à 20:22, Philippe Gerum <rpm@xenomai.org
>     <mailto:rpm@xenomai.org>> a écrit :
>     >>
>     >> Pierre FICHEUX <pierre.ficheux@smile.fr
>     <mailto:pierre.ficheux@smile.fr>> writes:
>     >>
>     >>> Hi all,
>     >>>
>     >>> I've read some discussions (may 2024) about the lack of POSIX
>     skin in
>     >>> EVL.  Supporting several skins just like for Xenomai 3 is not
>     >>> really useful but POSIX is an industrial standard and so for people
>     >>> willing to use Xenomai instead of PREEMPT_RT.
>     >>>
>     >>> In the EVL documentation
>     >>> (https://evlproject.org/core/user-api/thread/ <https://
>     evlproject.org/core/user-api/thread/>) I can read :
>     >>>
>     >>> The main kernel’s thread is the basic execution unit in EVL.
>     >>> The most common kind of EVL threads is a regular POSIX thread
>     started
>     >>> by pthread_create(3) which has attached itself to the EVL core by a
>     >>> call to evl_attach_self().
>     >>>
>     >>> Don't you think a kind of POSIX "wrapper" could be useful or is
>     that a
>     >>> silly question ? Did I miss anything ?
>     >>>
>     >>> I'm about to start a study for a big industrial company and the lack
>     >>> of POSIX support is a real issue.
>     >>>
>     >>
>     >> Years ago, there has been a proposal for a Common Xenomai Platform
>     >> effort (aka CXP). Its purpose was to establish bridges between the
>     >> xenomai3 and xenomai4 systems, user space (e.g. POSIX interface
>     for evl)
>     >> and kernel space (e.g. RTDM emulation over the evl kernel API)
>     >> included. AFAIR, this proposal did not get any traction, no user
>     >> feedback showing interest on this list, so it had to be ditched as a
>     >> consequence. The only way to revive this effort is contributing
>     detailed
>     >> ideas, a plan and some code.
>     >>
>     >> --
>     >> Philippe.
>     >
>     >
>     >
> 
>     -- 
>     Siemens AG, Technology
>     Linux Expert Center
> 
> 
> 
> -- 
> 
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>                              http://www.smile.fr <http://www.smile.fr/>
>                              https://smile.eu/fr/offres/embarque-iot <https://smile.eu/fr/offres/embarque-iot>
> I would love to change the world, but they won't give me the source code
> 


-- 
Siemens AG, Technology
Linux Expert Center
