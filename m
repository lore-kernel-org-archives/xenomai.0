Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF5A93E
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 10:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHmqMOv/SnjWbnT2OxMOIVvlHvfdeq16lJ6pNcUU4s9TA3ZVJNG0owxAKib4lqTXkgAwVFA3iqiYZSCzullhgCyTO5qVBNqCGnq/Ge8omt64Xa07sJ99YE0gyVUlXURZRGSbxkum28UZabLpACrZ+oMu1m6b2wyj6lBhxAvJTHrozS+FsJLSW/2VdihgJWcDhNencZg0jPU8qsdsi/3sQvvknS2v/I9Q0NvS0gY/MM5MRvy+fPfOUA/u8Y99cARXAG0LIAHMzQDbwMWtVH0l6YdRsY97KvLKUhwB6Ojneg00FRXOJR/MRDAdbhdPlxdQy4858gzeSZSe6KM+oHcXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HwVtoKSo9AXJJGDehUKXGMLA7dgqmf4+fnGJrmoDLw=;
 b=B2cpj/+pk+tphLzgvFD0sIxVaph7TisH0pvu9rOO3MQ1SpL6pCB0euUuUfn3/Nq3ne6KuzC7iCtA89wyTTKjnj/YYdfQWKvz/JKDj5MlQFatf9rnzYBjJ5TlW3TsKPRCL8IBkIgbkpfTlC79Sd/Ey75X+yOS6gM995aB4hyZ9CbK/Vwvymbqh0RI6NSTHHV2/Gqp3szXXsULzUDuNdASBA406ipAn9A6XvOzNoEY+wRyUguRpOWjrnn+oBLZ71Zn9esU7QslBGvFCvghC9cIUWE7pa6H/p6Yts2sqNjv8AZHdYcmm1RP2QmAALabkqf7ByOjGDKt8Z7Xd5MzQP8PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HwVtoKSo9AXJJGDehUKXGMLA7dgqmf4+fnGJrmoDLw=;
 b=R5pFGyZS4qyDE54PoI2OWPRZ5mpeZ5NzetGeP2X84k6Ms6/iGYkAHNSFk9juyk+6UnPAI4C0HBcyoNN3M5tifx2+3oAOaC82HcgrSRQv/kuDMHcMRNJclvF4r8ts4rzliN+LLKrvRLYivxOkCc5WqvI76/VppSyggR0JgKashcd8IB/MviYD1OHzp47exJ3/aGSejhz4GIYmt2lqlIQtTx8ccLOfBstpfjbEBWPp0v0CaaLIHDe8TT8pM5Nw+NOKK1oVrShxPWvff3HsCEyk+LPSgu+Ad34AoVdRXhxbj8ULdEq1oCgFnXOzGQU527WE8l/YXtTxnOXe+fFcRPUdqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:11:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:11:46 +0000
Message-ID: <2dabc945-29ce-8262-ebdf-51ebf7410ce3@siemens.com>
Date: Wed, 26 Jul 2023 12:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xenomai-images][PATCH] xenomai: Update xenomai 3.2 branch to
 stable
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20230717125309.1423429-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717125309.1423429-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b21b736-2295-41ea-7b19-08db8dc0b808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tr33C3MJ4bivLU6eE0uydQ2o9BYQJ6/AEK76Krdv8s+DbvpgbkKsoeB2T2gQtHRnUkJi31UAAIpdpsXl3bJM+41MvkseGJlHbmyi9zuhrvPErZQmfqAlxqpWN6/xkqGjMIW3g0HE7pkywrHASOf+G2PqZ4m6FPhuBvO8BhE10Qc/xp86xtmLUQsMsuTDhvR3RybjdOIMiprvvCjR57JIAV1oLEUCKolCP7J7LT/VqkvmH4JWShO7sJbmOZGxsFc+lFxjCJqHhbDLoOF0nF7Gnaxd9aYHgkwkU1nAZ2pKJa14fB0sl6k0EBageaR+LYbZBXIlLN2t/+Faz9+/v9XYwf7Gy5CKH66y4tvvhdSOo/OYfA0n1bm0XhjOoMbV4/QrxwzbtGo9RcB+nyg9I8Ql9pN6y1oL0BzYOO3+at7hoZokQjyL6lQXLuYD4AE44pPDDdP+XT3DD6ygvUIrSH8db+mrBz40+YYkb49GPfg5ahR6oH7cKULap6g7qNx0N5K03K6ADMssjlVTXFDp144ix5Lq+dRtaBTVuSMbzcFHkzte0xKNng8Swug8sa/rmWO/JPRWyGQjtT6AYgYIt6yrqhfqAycMtuYlQM2z6bD0P5b1vl9tfxYtmMstawBtHe0cRfH6+TzWgwR/eeeeeuj1Fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(41300700001)(26005)(53546011)(6506007)(478600001)(38100700002)(86362001)(6512007)(36756003)(8936002)(8676002)(31696002)(31686004)(186003)(66946007)(66476007)(66556008)(316002)(5660300002)(2906002)(2616005)(83380400001)(44832011)(82960400001)(6486002)(15650500001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjE2Z2k3UVBaM3pjeXkyVjIzZjlNY29IeER0VzJjU2RBYkZIL2NzRE9qQVhp?=
 =?utf-8?B?N0V3ejFQNHRvcjRlZ2E0YitWQ0l1dVJHM0J2WkpESkFxeithQUhLSjBJUTRW?=
 =?utf-8?B?REpaMjJsYk04bS9CRzlIQUd3QzVSSFovWUZSeTl3dXZ2UHpSb1NuUk1oTzlG?=
 =?utf-8?B?RW9aSS8zZ1ordW16WnFFMVZZUDY4Z3BUa2N6RXh0bmRHbDZlcHBvZkFtTytS?=
 =?utf-8?B?WjB0dmFxaW9OVDlyM1J3aTF5a0QzaXlMbGlBMWR0L3kzaWpneGNvVnl0QVNq?=
 =?utf-8?B?MjkwdmJLNnMrSndKWTRyMkdGQ2J4eDZTNndhWnhXalBIZTZoRHpHNGhjNnRx?=
 =?utf-8?B?RGhhNDlqZ1NITElWVThCVHU2NDNBcmJ2bzJSNlp4ZmhiQzhOTGFUVmRlczE5?=
 =?utf-8?B?LzBUaHdyckVKTEQvd3pTbW80REMvTXFWZDhVOU91Wm5MNVpiRFBuemJNNktT?=
 =?utf-8?B?REFUNGdzUkk1bGJwRW9OcE8rWWNqbDJrSEx6UWtGdGNLQXlRbmgzK0tNMzlm?=
 =?utf-8?B?eW5oY3RKbUFteWxzeWU5Wm1XOG5FVU9COTFBM3U1QVNobjBwNkdzVWx0OFVj?=
 =?utf-8?B?bXpuOGZkcTdNQUFtV1lTZy9nWWkwbC80bGU5TjlIVnVuZDA0NFlFOGl5eFpj?=
 =?utf-8?B?eUV1d3ZKbjNRTHQ4NmtVUVYxQTZqNWJ0M3lFYmxRT09Ic2szMFVoN3Q1bGlY?=
 =?utf-8?B?K0paSXdOVWtLOXdtcTg4cHlmNTdydVlma2tRQzB4VEFSM1lQTThBZlpOdFJx?=
 =?utf-8?B?eTFDNUNtcUsremhxaThFZ1c3ZStoR2hFRGVHV2tTY0N0QmNKQVZPdnFDTDBM?=
 =?utf-8?B?L1RWMzlSdWVZUmxWVnk0aVNOL1YrUUxiQjI0SmdidnZ4Y1VjdHRMNld0bzIr?=
 =?utf-8?B?eGZ0NlpFRXFWNGZUNExkcThZbUp6ZkZtdjhyMy91ZHRFMlVISWxhZTlrT1ZU?=
 =?utf-8?B?dWhhMWovM0ZFSTV3aWtlOTBVK3Q5VXpCaEVER1o2Z2FPdnhtTzR3MTdzaEpH?=
 =?utf-8?B?RnVMaGEvTXZxQmt2MENYNFNIWUZTNkgycHNXOFpPZlVEZ3ZXdDREYjNWOG1S?=
 =?utf-8?B?a0R3eW52RWtMTHNqV21yaEdhNFpPL3o5VDB6eUZLd1QwK3grVkdpYnB6aHU3?=
 =?utf-8?B?dERCSS9GcmlXZjZvZyt6YUowU2pHbGNxdldiSmJ2UCt3WHg0SGYwOGRLWmxx?=
 =?utf-8?B?MUVRWEVmVmE5VHFXWlY3ZFp0b3NKWmY0U3UwbGZXdi94TWZpRzVYTzYyUGhq?=
 =?utf-8?B?aUprMEplZndZOFZhSy9oYVpkeHpqMWcyQTRpb1UrczhuMG1zSmwvMmxUbWUw?=
 =?utf-8?B?ZGxFOVBwSUd2Tzk4TElVUWhBSVlkUDBXNVpaREIzNEdCNDcvTmxOMDI2Q0dp?=
 =?utf-8?B?YUJUU2JiR3l0QlJoeHg1MEV2ZFI2K3NKemgvMjBURlFTNm5SeEx1MHJvY3dl?=
 =?utf-8?B?bUhYZldkZUtYanNyR09PWDBlbFJ3V2Rxc2pmc3d2b1p1eUdRdkpWRm1RMElT?=
 =?utf-8?B?bVQ1eXVkS0JlTkVRbTB6S2hZNFZ1VkFVR1dPMmdPQWR1RUxBT1FpQVZ5N09u?=
 =?utf-8?B?bHdJSTVvaGRaNFVqdFI5cFFlQktQMDFBQjFwU3NYSGpqbVlxZzM4RTR3MlhX?=
 =?utf-8?B?aWZTYkRaR05SdWRRSnkwL2NFTksvUGxqWTlKRE96bUZ0aUhoOUdyNC9GOFA2?=
 =?utf-8?B?STJRczZIVDhQRVRTcHEveDV3S1hPeXh6bWVmMCtVcGVQM1hseVJlRkRYY010?=
 =?utf-8?B?eEh5OGlaTmNOQWRWR0hSQzdnRUdrU1VyUDlaWm1hbUxqaUlaUjZ0WERIQmFn?=
 =?utf-8?B?ZkRraE91R213eGR4MUZUMU5uYngyZUU2OXMyd0RDUnJHL3BMZDlTT2U4Kzcy?=
 =?utf-8?B?YnEwRnIybDJwN1hwamQxbjVIdDlreDVHQllKZ2pZS3AxWWlhdjhyYjJCY2lv?=
 =?utf-8?B?Mk5UbTdOZCtpaFBTbTh5MWxCSnlwZ1haZmdZcXlvUWJLTVFlSTJmZ2oyWXl4?=
 =?utf-8?B?TllCWFlvdEswaHk5Uk55RXZ5a0xtQzBsenBiYktRSlZqUUN0WnY0VWppeit3?=
 =?utf-8?B?OFM5NE1aRW1qTUduL1hoWjBWaDUveEhsaEtMT3Jjc01Qd084ak9SQnNJZ2tp?=
 =?utf-8?B?RzNwTjUwaHUrMGdzbXlMZ2FkM1BzbGF4Y3pFQlh2V1M4bXhSUG8zc1V0RlhG?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b21b736-2295-41ea-7b19-08db8dc0b808
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:11:46.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkZ2ZT/Ph8MLa3m/4XpSyQ0oYLt5C6C62giZ7lDku4icI/qfPTPrR6bMTYAO/Gb+DlRi2+9nxkKDeL/0Cd5OlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5195

On 17.07.23 14:53, Clara Kowalsky wrote:
> Stable tags like 3.2.2 cannot be found in the master branch. 
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  recipes-xenomai/xenomai/xenomai_3.2.2.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/xenomai/xenomai_3.2.2.bb b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> index e99d7fe..f32cd06 100644
> --- a/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> +++ b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> @@ -14,6 +14,6 @@ require xenomai.inc
>  # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
>  
>  SRC_URI = " \
> -    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
> +    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
>  
>  S = "${WORKDIR}/git"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

