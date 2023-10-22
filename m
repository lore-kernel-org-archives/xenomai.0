Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61086133
	for <xenomai@lists.linux.dev>; Sun, 22 Oct 2023 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zJBMEz2C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcFEE8ZpoAEbUl2buNqlaK9jkbRPFzEXJeEBX8n/tjtYdjB284HDzZeFBbxkUrzVB9DjFgSwlDGruTnnF9L1f/dV6YNwBY+Mhdjz1ktbzNWs07SHPS5Fi3+uw2Nkcb95vmMShFPByj82cpHz7UmKpqDXOkCR65giyppHt+c0yXsGpmMIvhID/GULaq5Wi+AX4NKKhP6Xqh1TjwxXPEl40NJjgU89W5XL0h6Hh31SGlq4EPn+XdTXps8eoWi2ojBFdFy4X7g2mOPreoUHLZK3dqapNcxYCQSsowCo4lXhCnsOTzffcH7AZ768do4sBuydcocCxr3P3kAOXsGC+FONog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owToHFJ1Dde9FV2u9SyLGoFZjR7ipy5va5T9wbeNMY8=;
 b=nJ0KX7V+tHoWR/Q9VuSUS79Ip+G1YMuwSE7WedAbiIaanpVt1LgjaiAz0Pa+TRPhXrae1jnJDO2YDWOskiiDIOB8rfCD8mTXNG6lKxGgzOctUG8esVryliBLD+wSnj5nlsk0BHr+7eijNOQ04I2GHPMaj+prGDAuGuzpR3WXrp5JvhV9uRuSxfVUDoRp0cOZnJUiX4UZ8wh4R2y6+f0koGN9z9WDoUUaSeg1SRPynv36sG3MxbKsCI154RJYDJPAPO8LnEWuMXMdBRdRoHxSgm7f5y/MU8dELu0sQiUF5K004Cbxu4zx5CAX1JI5G1GkO704N2yJcUIF6PSBxhy04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owToHFJ1Dde9FV2u9SyLGoFZjR7ipy5va5T9wbeNMY8=;
 b=zJBMEz2CGH1wxBdnWEtvhNh479Q2tEtKkg6uqeIqLwPZ5XmU6wZe9k3o4vXMpjL3BV/Qhl/9/wIDRrtHtORvLdTMZ8sWbzJFGinXtXmJavH4awcNqBV5IwF+D4xHZPCCoJJqUyzMT66gXH4GtL01JqZ2VyS7y5K5nghryjpe1IrfHx6PChJJeXZ4bHawyRZH5Oi3mkaHEqEwa+LgUeXmiyV8fjZ+C746c6cxY7cNtLIhEoMgSO1JueQ0G+wlU0uLNwZGGWa2VLJI+OcjuPaBDPMwbPt566csXBzqkuPF7hU0PQKuV9zePHXrTA3qaweZS3SwGB4Qkyn9875MjxPfCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 16:05:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Sun, 22 Oct 2023
 16:05:15 +0000
Message-ID: <36aaafd1-85a6-42aa-b3fd-9e2d430074b6@siemens.com>
Date: Sun, 22 Oct 2023 18:05:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Call for Participation] Xenomai Community Meet-Up in Wuxi
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>,
 Daniel Bovensiepen <daniel.bovensiepen@siemens.com>
References: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
In-Reply-To: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 423a5435-042a-43b7-498f-08dbd318addf
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lgBGYlWOnv92GJUXUt6ITaEA7p59WGfPQE3xMXVShhNRJNCMrnW1TpHvkrtqPwoKDiEj7EHf/KeE3jh1FpVZXJ1omc2N/JeaBiCL7rAdnQHaLZLp+gJABtXshJ10tvvOa/YZu5/iAvCUAauODYdbGiU//VKHJcHm6/6lewkqzmjNrI+4udZGn5rR2MuRZlW9TllIOqfMMCza7yPILrBwmQJfJGNGCZD/n7dzKYPeWAI4GHefDpyAdr3BnnfK9oRqupVqTjf2c19kIt3aWDFxjTFfovVWaGDJ+Mcd1TvQIabDoip9Vj9qpFqs6uP6xTPmNsEu9VMCbnr8gvFDGKwlAjy1tNNO76KbhXcNe+LHkNbCXi7W2AfuC/HhKOEE7INfZtnuy4u394BlWPvAjO1dyFYLEbhl4rL+R0SOtx/inyyv7g3zPcisdkbyWFnPYlO2z/XS/yZT+dU4jRo4FpgyUk5FJdO7lUyu4MNtaV8FDukeG8KixPio2A2irlKSLKp7E0cC5ojv0SfwAUERcsK/10tCQlweHFjlTj7V8CY/4a0Pss5lDfIwn1aljwGh/tY/RAtWs3Ye7L6oVH+bK0PmC4Gm5/Z4ljzSYba2ym/A4RvVD1Xdfk9Ox+wJk6LscBx8e+36z1fcrKazJveBDF7Skw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(41300700001)(2906002)(5660300002)(4326008)(31686004)(44832011)(8676002)(66946007)(6512007)(53546011)(2616005)(66556008)(316002)(6916009)(54906003)(66476007)(6506007)(6486002)(107886003)(26005)(966005)(478600001)(66574015)(83380400001)(38100700002)(82960400001)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3FXZ2llVUkzeGRXU2NaWlExcU14V2FQMjNzaFh2ZVdEV2xyc09FK2w0SU9Y?=
 =?utf-8?B?WlpXenhDMFhHa2hXMVcvK1MzNU5lSkdnVzNvc1ZkTEJuelBvZ3M4NWp0ejJP?=
 =?utf-8?B?c1VnY3ZXWkhscUdoUkJ3djh3ektvdndxbWZud1QzcnZLQ3FNUnN5a0YvOEhX?=
 =?utf-8?B?djZKbklleGJJM3g4aU1qVDJ2N3VpUmIwcURVZjlJdmEwRFZBYWNBME81Mjli?=
 =?utf-8?B?R1lJR05Pa3lRUzJvMHNhdXhkcG1zLzJwUUdPRjlwRkRNeUc5VU54czNCYTJp?=
 =?utf-8?B?eHlFTHlqdkZPWTFJTFl0dmFUWEtRdTVUeU5sNHNVZ25VVXlHSXVkUEVNVkx5?=
 =?utf-8?B?WlBKU3V2bytQUEFITjR3anJnZWpYV0tjUzltWXQrS1AwVDVYeWtScTljV0lp?=
 =?utf-8?B?U3lWY3pPT1lKdTZZNWNPRy9hcURxa3daM0tDaTVEQzliR09yZTBRQWduSldi?=
 =?utf-8?B?ZVFNTGRPd2VJMkp2SWlvVEFhOGwrN0FWT3VWK3lBWTM0bWdrVG5Vclp3bW9H?=
 =?utf-8?B?a2ZWbkpXMzVRNEQvYzJpbHQzaVpZeDJvb2dkZnJjRnpnNXl3bXE5K1B3b056?=
 =?utf-8?B?dDRxNDBrMVVpQ1BobXJWTURZK0g0Y3lnTys4N2loMjRDSmpoUTkxZllqdmdH?=
 =?utf-8?B?RElZRkxLQU1tZ3ZUSksxQ1JVMXNCTE52TXo3czV2QVZzUmhaMkdHRW5ReWZR?=
 =?utf-8?B?OVdUV1lDMFF6djlvVkluTXFuTnFMdVk4VUMvUjVxc1hhKytGdWpwRDVSdjJs?=
 =?utf-8?B?cWpPTS9LWnNqT0RVazBVOXBjYWFSVk1EZi9sY3BIemltNVRvYkhZcG5UamV0?=
 =?utf-8?B?NE1ZSmxmMEZxRGVzbnFmSENhUG1BS2Z2UDJwUUJMaUtPQ0M3RFZGbGhvWDhL?=
 =?utf-8?B?R29ySGVtVkI1L1YyMlhWMHF6cHkxWlU5d3NVL2FGaEVsNGx1dFV5U3ZQWWVq?=
 =?utf-8?B?Ym5lTk1iT2FiWnB4VXZUWmZOcm9iUFMyOGFRSTAwTUROM0lUVUFSL09sbjVY?=
 =?utf-8?B?VDZ1OEc1U3hySnZKb21wQmxPdXJNa29ULzlRRkNYQndNOG9oQzlUaVA2Tlhw?=
 =?utf-8?B?a3BweHdaZG1rd0piSkVLZXNtOFkyMkREanpGeGIrazJMMzZoVnAyZWpWendK?=
 =?utf-8?B?M1oyYTY3UGxycGRzVCsreEMrWWJucXBjVndaQmViZ3VVS3p0Ri9xWEQzSFYv?=
 =?utf-8?B?MnNjMU0rQTJja28wYitGZUtzd0NIQUxodTQwVHZTd0ZlWVVEbEh1MWZKS1FL?=
 =?utf-8?B?QU9vanZVQVY1RzBMS29neVR0ZDM3eG1HbkNSUXpOZ2NaZ1Y4YUkrWGhOY3lN?=
 =?utf-8?B?VU82ckw0SFVpZXJUNXl2N0dsTkt1d1FraDUwWUs1U3ZUeEVQci9INHN5c0d2?=
 =?utf-8?B?aUxhYnVCaG5EVk11em12UXQ1cEZkL3FPYjN0ZmxzZE9LQ2FJLzEvWEppOEJp?=
 =?utf-8?B?Q3hTNC8vM08yMFVCNjBKY0RPeFJGdkhkRmUxb1lXbFhiOUtFOTlROWVyWUww?=
 =?utf-8?B?TXhoT3ovY0daKy9SVWgxb0w5enFjaDVTVXJtQW1neThaT3ZDY1UydXV5R2F5?=
 =?utf-8?B?Y3dIK1Y4UDZIVTRkdThLemJlVFdrSlIxRVJhRjV0UHBsRGRXQVdMY0NEQkJj?=
 =?utf-8?B?dXNGbTBmaUJPY0tYQzVobjd6OXdKaFJXYWhoMC95YTluWmxmdDNjYTJrMjAr?=
 =?utf-8?B?aUVXSngyOUNTSXY0ekJuL08vTXBadGJ4bGpqYmVPZ1hmdE5NZGF5MHJFaCt3?=
 =?utf-8?B?NytWem9CRGxGamhxZmVnejhtbnRYRjJmUkxoYnp5U3ErbWl5azZxdlZURGdm?=
 =?utf-8?B?M0x4TEdlZXlmTDA1SGx6c1MwUUlzYnZZbGdoeldHV2JLNHJzazd5WEx5NmV4?=
 =?utf-8?B?SjFaOWtFc2h5VFh5L1FRWWhoSkp5a2VGSk9iVGZJUUtocHRYUFRWa0RkV3hR?=
 =?utf-8?B?YWE5SDVTZ0dRWWlZTS9nYXBUSWY5Z29TNHZVT0Job0NsdVVJYmRmNFFMcHBx?=
 =?utf-8?B?TUZNS1hFQlA2bi94bUYwN05lRUx2Z0xXaitMVUZrQk4xenhIV3dFKzl6RWZL?=
 =?utf-8?B?RjZHTjA2d0dsNi9oYVBiS2k4Q0lPdWpTWjhHV0hrbXhBYll4VWVZeXczdzFU?=
 =?utf-8?Q?4W5TwO/hg8ha17ttX7zig/oW2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423a5435-042a-43b7-498f-08dbd318addf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 16:05:15.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEFsF4zeFWpHYwJzWHv51pbIN++AzjtGx0DPL+gvtXGFX4sD9nX8hh3eT7lg3gDEGG3NpXFPBDYlfsimPsWiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118

We are happy to announce that the agenda for our meet-up on November
30th has been widely finalized. Registration is now open as well.

You can find both under:
https://opensource.siemens.com/events/2023cn-xenomai

我们很高兴地宣布：11月30日聚会的日程已经敲定！报名也已开放。
您可以通过访问如下链接获取：
https://opensource.siemens.com/events/2023cn-xenomai

Please note that we are limited in capacity and would like to plan lunch
realistically. In case you have registered but cannot make it, please
let us know.

请注意，由于场地容量所限，我们需提前安排午餐等事项。
如您已登记但未能到场，请及时让我们知晓。

Looking forward to seeing you!
期待与您相见!

Jan, Hongzhan, Rick, Daniel

On 12.09.23 18:55, Jan Kiszka wrote:
> The Xenomai community is planning to hold an in-person meet-up with
> presentations and live discussions on November 30th in Wuxi, China.
> Attendance will be free for everyone, just a registration will be needed
> because we have limited capacity. More details will follow.
> 
> Xenomai社区正计划举行一次面对面的聚会演讲和现场讨论，
> 计划于11月30日在中国无锡举行。每个人只需注册即可免费参加。
> 由于能力所限，更多细节将随后公布。
> 
> Sessions will be live-translated and also recorded to share them
> afterwards. One session will be given by the Xenomai maintainer on
> the latest news and plans of the project. We will furthermore have a 
> slot with Q&A and open discussions. Beyond that, we are looking for 
> talks from the community, in Chinese or English:
> 
> - How are you using Xenomai?
> - Are you working on ports or extensions of it?
> - Do you have best practices to share?
> - What do you expect from Xenomai in the future?
> 
> 会议将进行现场翻译和录音，以便之后分享。
> 其中一项日程将由Xenomai维护者提供项目的最新消息和计划。
> 之后还会提供问答和公开讨论环节。
> 除此之外，我们也在寻找来自社区的演讲，内容中英均可:
> 
> - 你是如何使用Xenomai的?
> - 你们在做移植或者扩展吗?
> - 有最佳实践可以分享吗?
> - 你对Xenomai未来有什么期待?
> 
> Please send your proposals consisting of a title and short abstract to
> jan.kiszka@siemens.com and hongzhan.chen@intel.com.
> 
> 请将您的提案，包括标题和简短摘要发送到
> jan.kiszka@siemens.com和hongzhan.chen@intel.com。
> 
> Important dates:
> 
> - CFP closes:            Sunday, October 8, 2023
> - CFP notifications:     Wednesday, October 11, 2023
> - Schedule announcement: Friday, October 13, 2023
> - Event:                 Thursday, November 30, 2023
> 
> 重要日期:
> 
> - 提案征集截止：2023年10月8日星期日
> - 提案结果通知：2023年10月11日星期三
> - 日程公告:    2023年10月13日星期五
> - 活动:        2023年11月30日，星期四
> 
> Looking forward to seeing you at the meet-up!
> 期待与您相见！
> 
> Jan, Hongzhan, Rick
> 

