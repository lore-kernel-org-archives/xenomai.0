Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848120010A
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680006; cv=fail; b=A+RMpTqB8Q9sbfAKwbYomXjyv+mUiieqG2ItnkdCql0To/Bnq9SLOMTfSpCzTpQUl55Mn+Sa/w5ED1jlvmkMjzrd4yz2k+E4MTpg6aHhOIpLvvkCeOw5Lk2GYw0TY+mUAHZ7qmYr+opiTn3+fT6pGYZCbesCv3xM5bm2aeNB9p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680006; c=relaxed/simple;
	bh=PQS3Bm8o/7kNMmrH2a+V8RtcNEZMlc+UY1Au9HABjbo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5VLGQrbJ5bA3rfj6J0sDhbFD/M3yGYlVp4AUrT/f1qJ278c4+Dk6ebbESBv7kq7+9xK+6PQjaFpGIGJCL9NoFmq2BBrl3XzMrGoWOhIgYw7emAmBo5JQTB70Q+8a3mHJ3Igdxm/DmB3EYHOTdc5NBesyM8wjw06FuTqfo+dLoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lNE5VjwX; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lNE5VjwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2+CfgKYh1HYc/gR4avwYi+V2G/IY27uD+youC32Ipq3UDdCghuu17TAdn4jTMHouCUzC8CUbXLNGs1w5Qe0t9lSUpbvWxKX6M8rJKv6Bji+AAif5Hy6RRFGE682ZLv2YGUFVgz+03hKBH/yqkg/DfbatL2FEJ5TbwxexNpmmP5yl50igmUFToA4WfHKEOoAbSEkXsJ1UKGL9jsbSlrmshG/LBdjGV1xnb1o23k/Nn/CmeCiukgSlg/Sfei68gZsrXsHHrXPrOnbqxWM0e2L9JfzdacTVz/Ejrb6WR5JTbBW26sic/oMmMLQqgaxG1W16hGZkmOyzcbYzU1Kb5jSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6K3t6dTNNlbfTCNkkVzWgqNuHCgiVXDZABGFv957sI=;
 b=Rl31uvpVz3bMV02Pxc511xKbyehNjeOo/SEZZLnluHxF8GIUNJqpZ9N8pfkoQyhIBC0iV3JL/x76Q4lB1Kne6vlak+TnmXy1LVWuSYI3yqbFBbksudJKsCEfvHgO1GCwNBS1DIsFlxYMnxhZKRH9gi1Mp6s0QRTRDEVlfWqTyAqrLOZ/U1XlVVtGiofz+RI2YOK8TWOxZGGqi32n2PtWtHw3hQoLAFypFEnFm9wwpT60HIcCHIZjn3KJhUBvD72plJ7sUYTe6zCsyEXQRu7CS3DFZPzy2wSRoBgPeZph3sCvjcRzy+fI27FSSZJNDItD/hDQkCRgEeDL1M3EK7Gkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6K3t6dTNNlbfTCNkkVzWgqNuHCgiVXDZABGFv957sI=;
 b=lNE5VjwXawwZouT95O7LkqXwhDmHsHDdcG9vjb23zKQ+vFbaBHU1Si2bVyOds4lv0bdNMOw1OaGtzGdgQS5jVRWoDUZ9pvGO1vpNGyzsHgfHnpISS9Wpr6vVBdzaouLeSj5+4LnZ9foqcMHxLA9dzzsNFDeLa4avcmEMjNML06wpmNWb34J5/sZM4ojWzljMqtqJDPI8jxa6KjBxsTxU+jFlfThfG4toStmD6vLImHTIen5YDiPPjZGBEmCUDbd31PLhUtp99m+U0vpwtHQ5twc5tibC6mkxb6uN8BVTgBCts5B5NTbyJ9pYoMXmYHcZ6yPbuu0ZIm5sgRlmj3zVxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:46:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:46:42 +0000
Message-ID: <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
Date: Wed, 13 May 2026 15:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 06078d48-78f1-4ebc-2554-08deb0f61085
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|3023799003|11063799003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	OXZtm57plPLnzAZkWTJAKxPbZlAcgo9mvuFgeS5+YbhT3QQ1kRk1Tk+ITdZ7ZkcdtGT+nvmIGBIvj2a0nwPfT0naViATjExs3lZagMXR5BXqHklR6PavKOemCYsA3WNv25jEE5C3SZMpin9lCiJvzEB7bTBQTnHZ4tI9jJNOmjV76Av22BP639fn4JeB+RC6G9TdW/slfYuGC/ibkhOdPWV2k//qXY4KQMQNZGdTGvzGiQ71bV6Pzq0j1Xht8lBeKhWkZKtLGc2OGoanxm2pdYgWytA8nbKkNprVmheQlJEzOlcADqY47fO9StwIikoI+O4N+a+3NFmpnglHQ7mOhptf+Ayg2MTCn8Gx56jrI7JmfJJg51nOKEK1pfC1EGHYao+uqUEtJvRSic5SfEDAAdfU4s4joF5t0mEV7K+s+E4M+S59Ldan2ENg6ArRorERhbhHY+3gseMbLGlbYMO8kKccHdXSbeJyZI+B4IxNKhwsWOngTvJy+Jr0qY+gZZ4rmVeAWa3b93O6H9CG0fJsLEhsD1cbsGQfm9WZ0GAUnlRtTsGMbLbsZWNPfBFYMLQZwGe12S0OB5jezYrETJAbK9MpOTeu8ooqSeohj7Al1LDfwmL0HR4f99HT0+G+5mdRMVH79KSFLXiFTXOl37uMqXHZ6cfci2xdHlW5hcY0qC6upL5N8j4NhaZm8ak4wVFS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(3023799003)(11063799003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1o4d3g0bkUvVzNlQVBNMnNxWXdPcWFTUkorOThuekVEZTAxeHBtM0RUckE2?=
 =?utf-8?B?RkFKMHRBR2ZPRmQvcUdxVDRuaE55TW1qUWZpK2RMM0N4eXk2L05TUVJsQ044?=
 =?utf-8?B?bkVVWS9MN2tUWWZhVUYrT3VvaTY0RnhsZDlzR2VHNEFPa0FmOE83SEJQSmFv?=
 =?utf-8?B?elorZGFxS1RHLytnRHFQa0FkenVQZ3poWitlUFUxSUx4ajBsclZKaEpYcU5k?=
 =?utf-8?B?NStURTF2ZE83WjIwazBCT2lvUUZSQkhUWkJmM2VIMlM1VGRRNWdRazdUNnRX?=
 =?utf-8?B?TkREV1RwQ0Y1eldtTWZLRzJqa2t5bVBVUmhucnYvcWx4VlNzMjRyZm90N0dB?=
 =?utf-8?B?bnI0ejFlRlpmM1VwUHVoaTd2YkJmK2tDMk10SXZvZTVFYnpBQjNQclBWNlpt?=
 =?utf-8?B?dDVWV3RIclRmTUg0bXBST3MzUEtLNmNuYnhpYWFMOFVXTklnZDJjV2pBSGtE?=
 =?utf-8?B?ZVNzMUFnUk9YVjRVVXJaNU9nMjgzQTZaNHl5STQwYW5ldW94OHhRWDExZSs3?=
 =?utf-8?B?TlAvaFFjeERLNEdNZlI0K2Z1bld6eitwODh1bUFrYU90dlBTWHhTYUE0R29Q?=
 =?utf-8?B?MmQ0MHA4TGFocC9iRGZuczlsOEF4OS80c09ZZGhjTVFHMmdGMXl6bDFRL3Zv?=
 =?utf-8?B?SDJmeUFQYloydElGdGQ3MXN2U1ZlRmlyU3owM2FqSGYvNE1pUmRFSXVDbzlx?=
 =?utf-8?B?aVVIeUF0bnc2aWM1SnJTK2o3QVNmZ0hvZFpmcWMrVjFTeG4xWmFQci9PaDds?=
 =?utf-8?B?UXRSOWZLSTd5cEN3N3VMUUxvakUybVIvVldKaDArMEdYbzd6TzNESWw4RU1s?=
 =?utf-8?B?em14SDcvdzYrRzV4MjNsQVI4OUhMS2U2RUE5ZXhoeGE2QnVlMWRReTIvemI3?=
 =?utf-8?B?c1Q0TVNFSUFhaDJUZXBNREVHU3FLQ1RKZTMzU1dwMEV0emg4cUhPcEs2anpj?=
 =?utf-8?B?NmJId01FZFd0a250TlFWSU1MUk9QVDgzMFdVamNSRSt4OTZCMVY3MU1lT2ZV?=
 =?utf-8?B?b1k5S2ZjdWF3SGo4Q0Vhb2RNdXlIditqcUU3aTc3YXNOa3RBeTgwcW8xSyta?=
 =?utf-8?B?YnFoNXVCYy9uWHFDRmNaa1BzRTE0WHljdVhCS1VmSElKeEdLMlVhMSsrVjA4?=
 =?utf-8?B?b3MrTUxuMC9USENwMXk4bmpZbEtFU3NXWUFYTG0wSnRobHBsVXdvRUlaT2pF?=
 =?utf-8?B?T1llRXNvb2lDN0hoeXA0cUFqZ2graTdUTFphdXAvaTVrbzUySGxJMU5rbmVs?=
 =?utf-8?B?K2M5STNYM292R3AzVHRlS1FJUE1yTXpZK1RPT04vdUxEMko5SEpJV0FVeEYw?=
 =?utf-8?B?NUNBWFNUeGZOd1FQWXFzaEQzOWZ5emdvaGI4QWVwaDYzVVZ0ZllBaVc1cFYz?=
 =?utf-8?B?SXpnVkdOczZmZ2Q1elpzcDEvb0pEMFhEb3FPYTFmbmc3SFAzOUVNN1pQK3VQ?=
 =?utf-8?B?enRiZXhVaWwwWHJ0TmJ2WlNtTGVscTZBSUN6RU9Gb05mbXVFUEpSRzdwTzVK?=
 =?utf-8?B?MVovaXVoN1FBUHdOVTg2VlkzK3NrNkRBY0lobzJOdU00aUErYVFhdTB2alNG?=
 =?utf-8?B?OXUydFo5VmxZQXE5T1kwV0JneXlBMkwzbVNWSGtTWEtJR0pUSVlGMTdmRjB0?=
 =?utf-8?B?L3EyNG9VNXh6UUJ4azJJZ3NSYXBMY0Z3RE5IZVRCL09MQmVXRTRBajI1cjFZ?=
 =?utf-8?B?R1lGM3BPREV3ZG9MNWVQbkNoazZMM3BNNmxNd2ZTcy9jUHBpL3VYcEk5MlBT?=
 =?utf-8?B?aTdsU1BiM0loODQ5amNMUEpkZkVMRDB3cHhMb2RjMXFyUUVOQ2xUOVV4MkNi?=
 =?utf-8?B?SjhNejZsNUxaYlI1MjB6ZXNTWGEwTk5BbXJOak9OUDNIUkxHRnRHZXV0RklT?=
 =?utf-8?B?cUR6ckhXeTVGbUxXblBuSm9Bblh5bFloZUJJK0F3b2lxQXJuOEQ5bU13V2t1?=
 =?utf-8?B?djhVRlkxYzZCWHBJWnU1ejVieHJJNXpYbTcyUWtLbVV4SE9sZW9sS3lUUXNx?=
 =?utf-8?B?enAyNjV1Z3lNZ2E0bWdyd1NKUkVBZmcvbXR2VksvRGpsNEw1SXI0RFBMZGlj?=
 =?utf-8?B?NWg0dkVtYWFVWFBGL1VvYWFKUzZaLzhJSWJEWXFNbWY2RnRCRnVGYXRYdTVF?=
 =?utf-8?B?UzFMRUhWV0xIQmo0V3B3eWhweDFmSm95RUpOeGptWUdJNW53blNlc1A1RWw5?=
 =?utf-8?B?VVJMRThYSEJZWUtrdHlOTTBsZ1JvRmVuZExMaDd3UTVSams1ODZvZXIvVW1p?=
 =?utf-8?B?RW82VUhLcjBEYnh5RTFoU3dFQ0VUQ3VwdVFiZHRKWjU0L0ZSWXVsWVhzQnFq?=
 =?utf-8?B?R2xFZk9qWStxRndDQlBiT3AvODFMUm5qUEFYTUFNNWJkS2lsSE11Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06078d48-78f1-4ebc-2554-08deb0f61085
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:46:42.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gElC7k7f4Pfo3jHKqrHt8ftt4izMCbcmx1SiF2N8CBng1e9gyCo041xxCmZH75ApZtkDxVErdaQsLhGbsjl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8771

On 13.05.26 14:50, Florian Bezdeka wrote:
> Hi all,
> 
> Trying to compile the codebase with gcc 16 revealed some minor issues /
> compile failures. Fixing them up was quite easy, so here we go.

Is this gcc 16 generically, or are distro decisions involved here?
Primarily out of curiosity, but also to consider reproduction - did you
use Fedora or Debian forky?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
