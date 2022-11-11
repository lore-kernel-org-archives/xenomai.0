Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704F1EA00
	for <xenomai@lists.linux.dev>; Fri, 11 Nov 2022 14:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+jb+UVHOdqAXT1KHwdexqBaL0cBnFrtTcQepvoKymUPvMytGNObNmPqjUdI8u0ZLopY5LCJSsFYk8DtMbH4iT8kAFow8od6DZj9Mi1hqFD7qKFAwVznU9vAarv7Xn1M00xDznVZ51+NJl+I/2oLr4/eYG7NT0kiFn2Av6cfs0AWT2+DVogaDfS9dnr1TM0j3XNEl4icq3PHK6oEAYn4HTIC4S7x3DeiAG+L0LvXBmiLCizvUKUWvd8FzCPhT2DAW0u6ZPbrG28fr87NTuy2RtZzARRkCdPMZ9R4yawfxcDpIfzyNpYx55HlGC39HMs+RjrJP+iYZTvdYhzBTDrJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU1wY9VUd0QGNIu68C7JOmzZf1L3H8laKgtDG4GFelg=;
 b=YmCSXnge7awLtFS8EUCzVBd5wCoYZ2LA/XAiXLfhJiQ23aBGsydvTD96+8MzGs19lQ6JpqG6tGxGyt3kn4G5vXG7BSxxaAMEW4tVdixz8hR2nCbYOTTLLJqJq03zdZoIXnGsWzqma19J1bMDg9AtBDrpnMH9r6VOVpRJL065qVqhv5SwuHy4qma9ylEUJlAXb/DyB0FX0qzrG6ZAKIfHgstcSmvWsSTWGnBQnotqHihzF52bBYZDhXF/l9EE4aZHE5kK4KgC21R5SQ3xqYUy6EogyuI2LqdlHKV0ESGVL8mYJfxalcFblPL37qcu9HaEI2spXaD6tHVz2WuWQ699sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU1wY9VUd0QGNIu68C7JOmzZf1L3H8laKgtDG4GFelg=;
 b=gxnasd9yDc/ZehxYPp1p710F/8vSNaGCEZaWKOiic30vLCW14DJ+fzyNSa3IyKY4wStfYsMHYTHQ3hCYfxOF/MUzsV/o+RZNza+DMhqeupr2DMkNYM5A8yhzK3vuaGdSvPBCKUJGwDVVZTEIA5yPz9CFIKViSjHZD+oD3AoHhA6vzuvHPi8WBs9iL0A50OnlGojAfnKqiWGT8PGR0KYunftqZUsVQkmt2fAFzyuftLx0burETO18FGinmkgzTBJ1Czb3Gom01CFxk49AwgqkpWulHHL8xqr3BHv5hS1ijXmvzPVMzopMIoDA4f7n5IgRY2KjE8yrB1Bi++/30oqk0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 14:47:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Fri, 11 Nov 2022
 14:47:00 +0000
Message-ID: <29fd6c4f-65cd-3961-99d0-aa1bbfc542d1@siemens.com>
Date: Fri, 11 Nov 2022 15:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread hardening
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
 <2934513f-c67b-35ee-e72c-dbebd23a432d@siemens.com>
 <FR2P281MB2654EB01BCBD13AD63A59326FC009@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB2654EB01BCBD13AD63A59326FC009@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:610:77::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3953:EE_
X-MS-Office365-Filtering-Correlation-Id: 010f28f8-e904-41d0-b325-08dac3f396bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VgIX+/sQ11Ohr+OL7YJY/TXHWX/XbAIOKQ/9IRekj1CXdLK5O3ZyedfT6GUiFcwg3CBUL3fyz3xm67lYnoMO3wQoOJOB96oJw/9yBxorwR9TG7N8IrVFU9U7/Fy1uuzKv6qPU/K+PcJbi14HjEGMMfKo155hk98hkkd2bfsSdpeaoPxamSPuEcrQo/GzFeUuGaC4qYUn7M9G06b9q6VnVFG4CfKizUFDcEdg81bmZSDVxZgrvKjSGpN0nXMY+J6BjvUKUAeS8StJJfaOGU46vXxDda+Szjn2BOG2BvnxFkBSMWl/GFbd0+EmkzjCEv9uY52snnXPSUkAWKJgT+XdmGgmQmBSK5TM3N2KxJCPf9a++5NJ703vkXuMbE7Xij1gD9ukSBGiyh5gb7B2cnZ7arTMLbFoEA19r+ZUF7G6rkVKAvacvCc4Ct4aqUdKBlDPuCtB86KFhkDDMYhk1KnpJIyvJ1OpvrhCWeZfApkzF5226gQ2vG0nr8IgM8pUacOn1hOpSVAAA85Fo0STxMuxjuKXVMB4cSyREYBcgUqH3Gjr/2ZbqulGbrKUTTDszCMf+v/srEgnebxKDINDqDVCIgWrHJwZ0atH3QbInhpFXVmKhvyR67tK+uRZlbnukT7Hi0z7SxnjONI/GWAhFco1h1O++uBn2G+6aq4WsJOhSk4ZKSGSvv6TvPJ4Ltdp6qpfHxDd0gVGn2wt5bpyCcLOhjQBs1Wuvk9JnIPnfMbxPaVwZ/UuLAFlh/Fv9KffMxVGI0NnHKxlF2s0PiU5eRO7F3UovVFVFK5x4Y7h0inBKIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(6486002)(82960400001)(38100700002)(478600001)(6666004)(31686004)(6916009)(54906003)(8936002)(6506007)(316002)(36756003)(31696002)(66556008)(66476007)(53546011)(86362001)(66946007)(6512007)(41300700001)(8676002)(4744005)(4326008)(26005)(2616005)(44832011)(2906002)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtuY2swajFMWmNmeFRnV0YzRTQ4WDI2bWRCWlIrallrRlMwZENLUUZwMGpZ?=
 =?utf-8?B?TWRnNFVtZENyUlZFYm5kQlRkQm13d0R1akhjWDlxcW56Tjhxd3liZjBVZ1ha?=
 =?utf-8?B?SWFpN0dhZjk5M3NSVWlBUEExaFV1dVVJZlhYNDRENmZVTEtGMjRHUVJpRFpI?=
 =?utf-8?B?SlpQZlUzQlZWWDV3WmpOS1JudEprbHdNL0xpenlFWjROdU5zS1h0TEpjM2tn?=
 =?utf-8?B?OW5OeVVPN3R3TE40OGQwRWV4aE43OUNHZHZRNTdLVDFnMThzMUlESnBVa1JH?=
 =?utf-8?B?MjRkcU5DV201cjVXa1FSRWhiUlVXSExITE1OQkU3RXhDYmhQQkZ4Mkt4OEM2?=
 =?utf-8?B?Y3lOaCt6c0NDQndSd3lhY01XQUJybUZPYjNhK09QN002YkFuRERROFlOUksx?=
 =?utf-8?B?bm5iMXgwc0xVVFUyZVR6RGdrZTMyUDZoMUJHNXNEZG1PTWV3SEtuZWN0S2ph?=
 =?utf-8?B?NzB4aEhnZ1pHWFRncW0wZzg5VWd1OHZYTGJoV1hZQnZrZVpSN0RpWFFqWXNu?=
 =?utf-8?B?KzlVb1piYW5LOUJuZnNmeTV6VWRDWFNsK0RtMlhwbkNJeGhkNTFFVWhRV2FE?=
 =?utf-8?B?cENYcE9SRUtrYTVia2NTQ1VVRTM1dzZQWWhjd0VrNlhjWmxXRFJnRS9UbDNs?=
 =?utf-8?B?Wk9MMUJ5NVJTaEwxckhnemVnWFlRUEw3Q2dscVVmcHZidUJydGNmRHlOaUNO?=
 =?utf-8?B?MFFYOGZOdXZUWCtkZzhLVUJkT2hoRlFTb2ZDdXgzQTQ0aEcxWDlMOW5nQVRF?=
 =?utf-8?B?YXl1OXFLbTRhVjgvTm90ZFJac2RyQ1lSVC9iSWpzeUVyU2NlRW5HYmRPNXZ1?=
 =?utf-8?B?UlNES3MwbFVRRFVKN1JRTGkvNlNrN1FzSEgvaHcwcTEvSnpueDVsdWtJRktN?=
 =?utf-8?B?TGYyWTJwRnp3TmJwZ3lUSng1Q3pCeEdmakV0ZHU3ejMwb0RHdkUvR0hXL1lH?=
 =?utf-8?B?THVMdU5UY2NvME5MeFVDQTdTSE8yem5sSUpWR3pxVnZGQW81REdmSGRuZGhL?=
 =?utf-8?B?T055SzdZWElDdTVMUitYM25QTkV4OVdpZEVERXkzOHVQVFZQV2pFeG1SVkpl?=
 =?utf-8?B?YXo3YkNXcnN5UWJlcEZzRldYR0VZTUlycng5MnFvbWpIVWpTdUFhN3hJamIy?=
 =?utf-8?B?bUE0RWFtLzJ5U0YwTldubkc0QmVISVdGaGxjM3BBNHlyY29nV3I5K29rdWZr?=
 =?utf-8?B?WmU3MVZ2M3kwNStOb0dBS2x4S1FOWTAwcktyNDR4bysvMlZsRXVGUzhhckMy?=
 =?utf-8?B?MVNZYUR3ZFNIWFdYaFBoSE12TWt1Ulk5Szl4ZmpDT2lhbDNyRFM5Yisza3Zu?=
 =?utf-8?B?TDNCSmZxOXA0YlVFRm01dWVLb3RXYkh5ZFZrS2J3UEM2YktuNDVCWkxJUFIx?=
 =?utf-8?B?alBOTDVFeDZqOTRiTjFMMWpOc3lBSjF5WVpBQTM1b0E2OStKT01ja2NaYUln?=
 =?utf-8?B?N3BlU2JRakcyYW9pdjgwU1pveHFUOWYzZWZER1RCQi8rREcwZGc2R092bS8v?=
 =?utf-8?B?WTZqS1JzZVBmQ2FwT3htL3k1YTk0TE9WSlBZNi9RZklUb1BrY1k3Uy80UGtx?=
 =?utf-8?B?Ui9VeTFPaHhrWUNBcVNNRTFXOFVlVldsZVFyRjM0UUduTkduZGlNcW93bnB4?=
 =?utf-8?B?S0pqZEdCNnVnYStqcVdSb1oxcml3RG1mMlFVeEErYVVrbFJBTXYyMll0eHNG?=
 =?utf-8?B?QjBpVUFGeEtkZDR5SitZQWFmY1JCbVNYZll5czUzekNhOGpNM0tCYUE3R3RE?=
 =?utf-8?B?czFpQ1pwMjdaRG1tT0syQ3BpRnNJbUxlK3N3bXVGWG5jYm5qOURIOHJZYWwr?=
 =?utf-8?B?aEh4QTZRVmlobFo1SStyelFRWVQrYjV6N3BROWhOWVo1a0lRbFUyQzRGVGw5?=
 =?utf-8?B?OUloRmxhUm96T1pqUlp3S0VpNkpTZGFvMXBJZ2tNbENlNUQveDZRNmJ4by80?=
 =?utf-8?B?eWxWNi92eW11dk1TR1JYQUtyT2cyVlFqTGNMM1JnQ2lrcGFSajAwR0doUGIw?=
 =?utf-8?B?a054Q2FjVDZFMnl2bk5jSmpVaVJXY3FoUlZvTmIvelNob296VEwzSm9JM0Js?=
 =?utf-8?B?RHI2NlFHVVI0TFlyM3VralFCZjJ1MzNHMWtQa1JJOFZVVmtTSUJ6QWFuaVRP?=
 =?utf-8?B?SXgvNFdEUGRRWnF1K3RRcW9ja0NIV3JyZUwrUTRDNDh2dndnUzcwQWVEbTJw?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010f28f8-e904-41d0-b325-08dac3f396bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 14:47:00.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLkxahv3DSzaVRosT1RVSINBLGRYxn6j/a7jPIxo0m0MM5ikaqYLN4dZmWcXCDU1Ssje9O2XB+AMI8ujFo2hcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3953

On 11.11.22 13:45, Heber, Stefan wrote:
> We have set up our complete huge application on a system based on this variant of the fix.
> And the problems have disappeared here as well!
> 
> Thanks to everyone for the support and for finally fixing the problem.
> 

Great to hear, thanks for testing!

Meanwhile, I also pushed this change to stable/v3.1.x.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

