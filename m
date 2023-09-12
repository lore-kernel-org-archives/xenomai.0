Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC88F40
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 17:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6nio6756IeH5SF0/DNkHWnIMhg//jrGKI7WqyuThjfYXCDrUCLp5dsVInwN8EvFUfnJyPdxHAtBF3eOlXkiIUC8febV0N4eWLM9lFGaQWcRvynnU209cIK4+GYFoOnKRbNJdGUkHuIe1qll63RB8ItAQ1h2U1yiCB+Xdi3ltzGLY7P/tn7mxGU9w3Js69BjsgCwmiiws1pE7gIE3mfRzdNZTS++gFzsk/EqDNkBegbpqCsF0xTz9nDG/IbN2PN3EIILKJQjE1QhL7deehffFu9Y8ctuwBjCVrZPPgnimhWmO4/IHMo/+ruJADZB83UGSBlJMCxb7VCCi6cF+wFckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlEaOv56yd/K4eTWh3C2UAYDX8nGpRvqEZws36x7MoM=;
 b=gDjxaJ3ayYjIB3Ktz4tZQvwTODGngK0tFNN5vjH4PQ8EcDVuSfjSZNCRJpCKLYaMEQoBWccbDmkk5tpAsPLkOw1yqzOmI9Z7bLzwh73WbPqxBn+enH+i0gnyPoiIpe1d7GsgzR199RZQ/cW9eeQFbt9LEdFBWvLoPsWsHkZNXCfLsFsEZS2C4MRX6m3c2I/gOpG71SsfRZcCrbSlUePnDAQX2p7iYdB/yXXxO8TQoa5EZEt3VXe9168Xy3Wh5D/uTUUc0cA19/vxTTEoAL2i26UqGy1NVZeGTXj0kCQb5bQU2HxxBf5EyFcsUWfyGcbpc3pQ+GfSVq5nnw02GLZcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlEaOv56yd/K4eTWh3C2UAYDX8nGpRvqEZws36x7MoM=;
 b=mxxl+DUjVS9JuAekJ5C3be342qoL89R/f0WJ7PL7rk9IJba4FI7xZfRv0Td8WRwsW83Xf6Bn4D7iYYixZBHYqLynIB8/hA0bTvzYKTuZ+phOtg05Yj7MXdTFE6kCHLX5pFdFpYHqJ5CfEgy4C2ZJVjDHQURV7Zeg7gOw30A3tZfphnzqTnyecmJYtbZybpcFBJMwlbAxu+B/ovlaopSixJyR/18B1+sOL7YjqfGiXe8gTjHjFZse6a7Svm0oGqC0gD+8dLRElUnew119db4sR09reQrjPguGwq5SeyBP7+khrlh9gIwdgaX2pB+nemN9yV1QE8MLny2bbkGsUB+F9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 17:21:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:21:14 +0000
Message-ID: <23f187f0-44b0-4657-b137-c0fded0671f0@siemens.com>
Date: Tue, 12 Sep 2023 22:51:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Wiki updates
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
 <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com>
 <1727274074.3200069.1694532621162.JavaMail.zimbra@wolfram.com>
 <418657333.3203498.1694533649042.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <418657333.3203498.1694533649042.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 054ad869-25fb-4668-e60a-08dbb3b4aaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YnW2nxF1YLOGCBeHgmY2kByNx0MA8bQ52yuDSrO4eMrhrYsJzBCsun/kCGUtqP0uUIZBGConcpxcxaMZJipePyYkBi5wfP9TyoYLuuVKLN1+9oZQIxkvKuzvPF7EMirMmL18C9JcEagJiVA5mc70NZzy9djecduFf3cwTfAxj1sbeV8nwg01gSQauaQVOM0k0OcXCNAJ9zzHFCQQirp/xttAiuF9/IjjQ/2WFltAneTZMdql001q4PmSLDx8RxlVBdKfVzhwmmuFbXXHtKblvFjq6ZAlH1Dv1n5ImzvlofAwNbpnYd9iURQcHxjaqgFcF4s9UpbPmDeP/qc/dMWOweFZP7xCkrXNaUefQBbSonvbA5yRcVb7lZzYBFalcV+O8LwInPUGxWhx8Bhd7BLy5OnJnuuB+ukhuNPu+EydBH3rq4WzGzGzKc2XS4I5Tm778hmKWbodWUmUm1KU7gHTlGAoYiX7cDQw5uJa9MQw4y8oZo1KVXvmvqXuJJI1dLdcRgBsPF8EVPI/WrlbprSc0rURpyfD4hJpdloSVRDrvfzLZPitNXDzHUmehNolDMsACDskm8zSOkHfNs1unTgg39BQVt1M7t0a1+B8BcdtuZQp8rs22KotbScO4/p8xQWIO53x2GiEL1W8ctE/cxboFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(8936002)(26005)(8676002)(5660300002)(83380400001)(66574015)(7116003)(2616005)(31686004)(44832011)(15650500001)(6512007)(53546011)(41300700001)(6506007)(6486002)(66476007)(66556008)(66946007)(82960400001)(6666004)(38100700002)(3480700007)(316002)(31696002)(86362001)(36756003)(966005)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzFjMGd5K1A2RGxoNW84YlZFdC9PU1REeGM3MG9ac1ZzNzdqa0V1a3RJZTlD?=
 =?utf-8?B?a0pTNFo3Wmt1TDM4VWxuZ3hKSnZGQTdpc3VuT0tPeStxaGIvKyswbkN4Z01I?=
 =?utf-8?B?OHVsV3hwQ2ZpblQxd1N0VXdjRXR3cmgzWVR6TXdFTlBINWtsUXlFNE1USVlQ?=
 =?utf-8?B?eWV6ai9uN2Z1TmtlMHpLYVhnRUIvUDJWYVJQL2g2WjNtcWI5SUQyTWQzNk1t?=
 =?utf-8?B?S2FPMnJLK2FCZnM2V2t1eTIvOHVHM0hkUWEzMk1reHBYV3A5VEFxQkNEdlBm?=
 =?utf-8?B?VEVudklnNUpCU3BVbW9jSG9qbkFFUjhrZUhyWm9ZWkFsNWpoUGkrbzFQVEV4?=
 =?utf-8?B?dDR0bFR1WjRweDFUZGk4ZXpzK0JOZ0JhdTlQdlR3dUh3YXZDdzNUWHphMGRa?=
 =?utf-8?B?ZTZXZS9qNHpUSjgwQ3FaWWxNd0xqdzhNZEUzdFpjVW10Rm4zTGMxZE9JZFdG?=
 =?utf-8?B?cjhxQmxXbnhCeE5QYzVQY1B6R2ZxdmcxQWJuTHY2dkREY0dJeGJHVzNjOUtE?=
 =?utf-8?B?cE5HVUloTEo5WXBRaTFzNE8rVG1ZK3ZITE9MYzRsakVHZFFKdnRVRWZ6VXor?=
 =?utf-8?B?eHNIc1hDRi9EU0I0RlRoNUtuUEVuUzIwUUlJd3JDT242OUNjblJGVGVTUWNl?=
 =?utf-8?B?Zm1TSCtrMlQ5bVBlWjdjSlhGT0JoTHhTb00wNmFoVGZrempNK3d0V0p2L2Vh?=
 =?utf-8?B?YTBhUDhGbHlNVUhMa2ZQN2xpMGtNcHlWdkttS0pzMGcraWpMZ2lYNDBoZE1z?=
 =?utf-8?B?V0JqNFdOWGRZMWxoSFlpR3M4L3NNVGpWWkx0REhnRE15VkpRcy9GM0c1cldE?=
 =?utf-8?B?aE1MYnY4R0NaVDJZMGJlTjZmdG5oTnR3dHJQZHlaRFF3UlhZd3hTRjczbTFt?=
 =?utf-8?B?T25PWjFTbzB5OEFRaDBJbDNqbnd1aDA5SDZtYmd1RERtS1RzSWZLY2locVdx?=
 =?utf-8?B?N1pHUWxHem1ROTY0NnNGMlp2OXRaby9kdGtFM29MWkdHcXRyWFRMN0xpQXVH?=
 =?utf-8?B?Uk11cWlTQ1k1S0p4RWRxbVBSSkU0anNmcmhGbTN1OTZ3SGt0R0k1Qm1ZbGIv?=
 =?utf-8?B?K1VCZjhtdkdVaU9lRXErTUlBc01aSW8ycDhwTVFRdmN2aWk2MGZZNGpqR283?=
 =?utf-8?B?ejVIVGxGYVFXWklUSFcyKzJHdktpZDRmQkNNeFE1UGl5Z21pMkFLbHIwTWtx?=
 =?utf-8?B?OFJRaWdBb2VJN1Vsa3NuOE5pd05Rd0JlU2lROXhPb0pmZ2JKR1FjOXhraHpk?=
 =?utf-8?B?RW1HblA4V2d5VHBFQUlZQS9rSzdUNkcvbis2ZDVaOU5TY3c2QzhZMlU1NXFX?=
 =?utf-8?B?NUlrRWJJSVNla25ZdXBDbkZyMW5ESkhBZGs1Z2ljakVZby8xNmd0eEN3TTBN?=
 =?utf-8?B?UXA1OE9oaFNybDVUclBzaUxxRExEcUg1V1dhVlJuUTJpMUVUUGQxMWRQNWFk?=
 =?utf-8?B?MkZSTklmcjk5SHFDc0ZhZTQ0cEs1QXRJWVhsK20zdmVMWjloMzhCTklNTXRr?=
 =?utf-8?B?KzV6N0k4WXhpVFZnQW9BRnByTEM5SXN2aEcvRGo3TzhFWWlxczRYVXBQckF1?=
 =?utf-8?B?WmtvcFF3UlMrTHl6ZFlzY3lINDNyNm43cEljUjloTUVqRk0wR1NUL2RaNGRO?=
 =?utf-8?B?YVoyTUpndDlyQ25qVmhQYkNoU2tEZnBIME9tUkpIQ2pxS01DUWxSVUtITHlv?=
 =?utf-8?B?dWpDc0R2Q1RXaE1yYnVRUWJxSHZGWHg0eC84TnZ4bUw1aklXTFZCVXZCOEVk?=
 =?utf-8?B?Z2poaXA2YXpKV1lnUlEweXB1ajZFVEI2dUR6RVdER2JqNmF3MStGeFVNUjcw?=
 =?utf-8?B?djZPbjdEOE9IdzNObnM2TFkyZVZnWVlST29jOHc4ZlNDTEpOV2JwRFZocTV4?=
 =?utf-8?B?bXN4OUpSNFBCZkY0RUgzT1gyUE16V1p4V21nM0hIdlZXWVNDNzI0S0R3V0Fu?=
 =?utf-8?B?b2Jha2RwUy9nNHNTaE4rMHpsQWx3ZWkyY21zTEhUbHl0QzJpUXIyUENSbW5n?=
 =?utf-8?B?ZTVmUzJkcCtxRnVwb3Vva1lpZGxCQ0pGTTNPWnZTdzhOUjRCMnFCWHA1djBB?=
 =?utf-8?B?c2l5NS9CdDEvMmZEWTRDK2RxL2Z4NFJ4SHpFNkJMOXBndXQwOWs0c2EyOXFo?=
 =?utf-8?B?SmpHMi8vSkZidG1hY0JRa2tZQklnd09Dakd0bWt0YWpBenpPY1FtMEYreUFO?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054ad869-25fb-4668-e60a-08dbb3b4aaf9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:21:14.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdpf34wahB/otubWYn6j5U4JnLtMgFsCQkUaWqXw2vbF40kxlaudYou4rfAuWs3qRQASL1LX+feg4i2NahYg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7412

On 12.09.23 21:17, Per Oberg wrote:
> 
> ----- Den 12 sep 2023, på kl 17:30, Per Öberg pero@wolfram.com skrev:
> 
>> ----- Den 4 sep 2023, på kl 14:20, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>>> On 04.09.23 12:14, Per Oberg wrote:
>>>> Hi
> 
>>>> I was looking at the Xenomai Wiki and noticed that there were some outdated
>>>> information.
> 
>>>> E.g. :
> 
>>>> * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
>>>> Dovetail, kernel git trees and recommendations are not mentioned. There is a
>>>> section on the powerpc part which I seem to remember has been deprecated.
> 
>>>> * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
>>>> Embedded Linux distributions & Xenomai points to ELDK which seems to be no
>>>> longer available.
> 
>>>> I think I might find some time update some of the stuff. What are the guidelines
>>>> and procedure to contribute to th Wiki ?
> 
>>> The landing page(s) are being reworked right now, and that will widely
>>> replace the wiki-based homepage. Will probably surface other issues. If
>>> you like to check that instead: https://v3.xenomai.org. Feedback highly
>>> appreciated!
> 
>>> Thanks,
>>> Jan
> 
>>> --
>>> Siemens AG, Technology
>>> Linux Expert Center
> 
>> Thanks, I am currently looking at this and I will try to get back with feedback
>> and patches when I find the time.
> 
>> Some early notes:
> 
>> * It's a bit unclear the relation between dovetail and evl. It's not obvious
>> that dovetail
>> is available for Xenomai 3 depending on kernel version.
> 
>> * The Xenomai3 installation page [1] mixes "--ipipe" and "--dovetail" where
>> "--ipipe"
>> is used in the black box and "--dovetail" in the list below.
> 
>> * The installation page [1] only talkes about the "prepare-kernel.sh" approach.
>> I always
>> found that approach a little error prone because it is necessary to find a
>> kernel matching
>> the version to patch. Perhaps it is better these days but for very special
>> hardware it
>> used to be hard to find the exakt version as time went by. So, it seems like the
>> simpler
>> approach is to check out the git-versioned variant available in the tree.
>> Perhaps the
>> installation page could mention the git-tree approach.
> 
>> [1] https://v3.xenomai.org/installation/
> 
>> Per Öberg
> 
> Answering myself here...
> 
> What I meant with "The installation page [1] only talkes about the "prepare-kernel.sh" approach." was the use of "--ipipe" or "--dovetail" separately, I think. 
> 
> Per Öberg 
> 

Are you able to send merge requests against [0]? Otherwise, please send
patches to the list, marking them as "[website][PATCH] ...".

Thank a lot already for your findings!

Jan

[0]
https://source.denx.de/Xenomai/website/-/blob/master/content/installation/_index.md?ref_type=heads

-- 
Siemens AG, Technology
Linux Expert Center

