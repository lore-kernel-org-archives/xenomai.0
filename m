Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D010782
	for <xenomai@lists.linux.dev>; Thu,  9 Nov 2023 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Xk5GpbLE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOkG5HOfZmaQ49WxNmtyE1zyIou4y/7waa/0UF5m+3jc6pGwN0Mi6Dm1ASThbV3K9n7JdM1bwNdZTN+z/jJo2rbRlDiMMa/ed6eOkfuI65/1xvu9yVbOxZbxyoWkE631qjwu7JQN5m8LMfA8buBZc5FVjnL1DB0fwDWCWshdtFkIbsJAVEXnUoAHZkkIJaC7PLLlviUQaXeikVJASFtK9LJf33o4ut1vqCTN+SPimbTkfGtDOsJXgC4G7ee+n1HjOVurCJod5t/051CjX9i3XN/itNt7Dd/sISLT1vN8lteSIcuFGkM3/HVuftvbXfBDBy8K0GylAB4y90iuRFGTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZDGxUivWBf4qceaqD740mG59OxF+NXT+ben80Qyung=;
 b=Fp6zhja8bFGE/Z/ruR7O4qo50OmlgUVdbR02syF3pSqTmCJoY+ZdcGcs2DX95DQRpeflezJhYyO5g+73DAIIW2AXWFulB1mcY8igdNQlq91a1ltKxXFs3Ht2GR0cK7KAbnalKm00ICECSNlzFTkeFcMatmVPomstQGlD4a9F6T44u9QpSi+/OH5zFtdmslEOZp0qTgdF3fWJgLIgKAr2JPoqEWUZ1Mn4KHkc+3+j3ab8UG1kooF1888JuZ1URR9on1TFHvIR9kHK6U0sAQ8zjow6ywiBqG9WUYL/ZUkH7OFkH+0tiDE2fhfud9BSZizxOoicNrY8LS1T/uwwYub1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZDGxUivWBf4qceaqD740mG59OxF+NXT+ben80Qyung=;
 b=Xk5GpbLEciLYustEz4WB1QemlyKwV4ttH0zo2D5XKVTOPSBfywTT37Nypphy4H3Xnv4A8FSxDQLvvEdUctP6fh/Zsy/s95c34mR8YNwCiUvCI2JjhhJIhF/otAAdab/WrnCoG7ZD4vUpTWfyG3yBaHtbkZCW/iWG9nDsseynBb3gWFEfU/RCodh6Nw3DSmKRN9SHunrgO/2oSUQt8mI5klXlTMwPbHMcJrIzYg86+UhpBVUlDuy4eu1mdU3fExjK8DgUKtu4UIjJ2Fb5F4ddtuITJxoz+JHFLeai1TBOFifiaTM6BNyALcL2h1byLZ8RwC6FcCyt0BRhU8ZzdDrJaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 08:47:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:47:45 +0000
Message-ID: <0b950981-1333-422c-afd0-dbaf0bfeef87@siemens.com>
Date: Thu, 9 Nov 2023 09:47:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB1330EB1FD1896D2A239CBF25D1C9A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <6dfcb5c9-8f86-4c12-9207-21b99bc22b38@siemens.com>
 <PS2P216MB13303009D73D26413933E76AD1A8A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB13303009D73D26413933E76AD1A8A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7685c922-3a8f-4408-df5c-08dbe1008b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XATrGXSGAsSAm81v3JWqE65TvuQ2wYARTnlMuErrObeAaZhLcx4cyZ7rpv/LsKwZPnVcCnwlUxYEURP11eHAOvjdYOV/YVtU3RU59671YCVch3RH2XffjL6Hqvr2z5AESrGX8JLkRLQWEfxaFQqTfy6nZPZziGTyqESK8ndyFZNzhSKqj+Dp1Mw5TUGndlV+AEmR8v2LJbVYwBbMTMFNQrkwjL8+02uJ4xSBvAmSZPrJnfEU9EWq7PAqxWXmXz/xLa79nLiff+3gFAXpzV6dvNDHlIA2gX9Y5umIvEpRdRE561TE3YKd2Y7J1RYnWczoMUqqW5E7Ztvplm27ltXEvRNQGEcrypobgKs3QiYxOm4hujRVyYILzoyA4hrRxeBlWsv+8WbILZXT832qgU+qwWQdC+a05v4G86Kdl0A+5wZfjBDGq14bCGENNg8rIqtU7+fJZTENowu+gTp4oLdKaECnLq9LySIQqVu7fklQthnKegf1LPIRsUiax5CLsYnRTY8Q0RW0ByQTTJG3KXDVzmzOlfXIv3RuZnFJMemk/gefD8DPf6CLp7qAvoJiZg/LouLeUF9ypzIgqvWS0heK+Wc9Ksa+EBKZgSJ7295SmneHj6GswaSpGam6rZGgSvDO5vLwVr+JDJLaqpmcJfV7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(53546011)(31686004)(83380400001)(36756003)(44832011)(4326008)(31696002)(41300700001)(86362001)(8936002)(8676002)(2906002)(6486002)(38100700002)(6916009)(2616005)(82960400001)(316002)(478600001)(5660300002)(66556008)(66946007)(6512007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2x4UzdzalBEb0hCZTNrMmw5ZkJHa21BU3FvNytTaWZBdEpKV2VhT1lVWXNL?=
 =?utf-8?B?UVNOQkdNbFV3K09GYW4vTVdWaHcrZ1kraE8xZnBCTkU2VVFXKy9RdXFUWThB?=
 =?utf-8?B?elU1RUxkKzFRRVYzWHJ1NzRadmFZRzZNMkJnTjdhUklKYjczdjdDN1hzNkln?=
 =?utf-8?B?SXluTHdHdXhpdGZBUEtvRWdITDAyTUdnUWJhQnNwVUdnbnNUMzE0cHRUZ0oz?=
 =?utf-8?B?UlNvZG9FUXkrV3RTMHc4K3hzcHptWDJ4N0tYeEUyd1lHY2VZU0pmd2hiS2cw?=
 =?utf-8?B?WWcyaUxqTDNHQlN6RCsvVFZXWGNrb1RLWTYwb2RqeUttOWZnK2NjQVFpaWx0?=
 =?utf-8?B?MzQyUVlpTklxOTVoTUJWTXRESlVDcEZ1MG1zVWswbTdvN3lFTFc3cjhCdmRX?=
 =?utf-8?B?Qmo1MHN5TVVja05Eb2F3ZlR3Nk9FZUV2bnYrQW5qaFZpTmlGbktPbEtCenZC?=
 =?utf-8?B?RG5JSEFOalpFd2Fkb2lDczMxSmI2Zk1rdTYwd3RGRFJPcUp3WFF4dFNPdHFz?=
 =?utf-8?B?bFR0OGVjcGpJckNtdFYzcnFhNEEyK1ZwQUozVmpNNTlXWERLbzNpNnNjbUhF?=
 =?utf-8?B?NDE4TkV4Y2tHRFloemlhYzR4bWRJUFJlK1QyL0FoVTJzbm81YjM0OXZnSjlv?=
 =?utf-8?B?cmhVdk0xY28zYkVFY0thL0cxRWtJdHlzU2FkNEdzdWo1VTNCWXRnL2pWVHpJ?=
 =?utf-8?B?dlhZbzZzS2RoSHRTeE5xL1dnVUJwZlRIMyt1TWgzSzlia2ZTZElmc3Q0Nm9Y?=
 =?utf-8?B?anMySnUwL3lpaFlrVU1QemkxZm9vRFZrTjRtcmpnRzdyVHhmM2lWSUt3S3hC?=
 =?utf-8?B?RjJvTHJFelcycGZ3ZytpWGxuK202K2FEdkZwZzhlQ1BZVWgvald0cHQ3UE9C?=
 =?utf-8?B?VTk0TmpacGtzc2p5Qitxa25pWWZGYXFpeWY3ZmYyc3NZS2V3NDhkSnNpbUxj?=
 =?utf-8?B?cHowZUw3emJvL05LNDBCZVBEdlRnam0vTVNwZENwd0pjRHpVc2tlODlmOHZE?=
 =?utf-8?B?d3hMblN5UFExOWhseGFuSVFGTFUwVHhvbGNTeVA1UUtsVVJpbU42WjQ5bFJZ?=
 =?utf-8?B?Wm5kTENWbUZzM2VxVzN0cXFMZEV1YURERTM2M3EveFB1WktvYnU1aVBwZldl?=
 =?utf-8?B?T2xQSFR4aFBZQXlFZDR0a0tpOXhXOGlBY2xnQnlLNUU3dkRBMWFLdEo0OFJU?=
 =?utf-8?B?S0NDNk5MVGJFNmV5Y3F3SlNHb0VWd0h5eHhRWUg0ejgzRFpnY01objU0WmlD?=
 =?utf-8?B?V2JzN3RkL2FLMnZ1bFR6alhVZjVnZFFRb2pGcS9IUUYveTZyTEdmN0JhVFNm?=
 =?utf-8?B?WEQxVy85blpEdGREeHJ3NEF4VVppNGtBRW1BZVVYTyt6OVF6c0hjS0pkRTll?=
 =?utf-8?B?bzZVNDN2eGlMcURGejErSVFWMWZsSkZXRnZUV2NZMDRuTWFoQkptWGFTME9P?=
 =?utf-8?B?bE1XQk5zYUVveFhCYzJzUkZURTE0b3Mvc25rZ3FDTW1aNGdVTUtWaUQ2ZzQx?=
 =?utf-8?B?R0tWYnBpSXluN1pPOHZkdnIreUMxUERhZGN4VzRNOExrb3NIb3RzUUkxZG9W?=
 =?utf-8?B?aXhEVUg1ZFh5eE9FVVc2bWI4RUdXbmZXcWtwbXB2WFhrU3lkTURITkltVGEx?=
 =?utf-8?B?Yng2WHA1akZiT1RFMnV0Q2sxcHBrczBXbGdMOHBqVmdEK2VPdXZnU0dzYzly?=
 =?utf-8?B?bkw0Q3FQMGFpWlVyQStXVDlMQUZ2OXJPZjdKbnlJT0xqS0x0TUNGdW1PMWE5?=
 =?utf-8?B?Y3JQa0V5a2xLSmVXYTBoYmxaZkpYL0dCbFdXZ21tZmdNSlA3dEJLc2Z6b05m?=
 =?utf-8?B?WjBzUVoxVzNnZElIaTlTREhualhMUDhNRUpWWEZ5TWl4T0Z0V2NyMUtPUXV1?=
 =?utf-8?B?djllUVRSTG5YZ0FSbS85aDJsZ2NPOGZMTWFOaE5iTi9qemtVSk80OVNrTTh5?=
 =?utf-8?B?NWVObElFZDV6K0h1eENEdU5FcEJjS05HakI2UTBlNHFuVTNkd3M5bUxHeFJs?=
 =?utf-8?B?amI4L2h1dGtMT3l5SmhFZ0NjMnRjMDhMajgyL3Y5RDVDZlY5eUxiVzdXK0ZC?=
 =?utf-8?B?RzM3OG9UV3gyUUMxdENJMjRVYzV1bDEvTUhBS0V1TDJrZG9aRzFaZE9ZdVYz?=
 =?utf-8?B?N1RzdjBtWENGL0hOY3lUYUoyeUY1cHdWWHM4YjVRd2dmT1gxZXpFTVpqRVEw?=
 =?utf-8?Q?IfC7lX5bK6lrk46jY2owZ/SzA6vYomxoD5DcJaXcIG9v?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7685c922-3a8f-4408-df5c-08dbe1008b47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:47:45.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAph+j5nT+1jMAj7UmLxBlTCUhkVc17GSewjGSSYmUuUpP0RhpY9R6LHl7LIC/cD+9IGXLmidN89p3DrcQ3GqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167

On 08.11.23 01:11, 박경훈(Kyunghoon Park) 팀장 두산로보틱스 wrote:
> Hello
> 
> I am contacting you because the xenomai watchdog issue has not yet been resolved.
> 
> When a task is killed by the xenomai watchdog, a dump file is created using GDB.
> 
> When I checked the stack frame, I found that the task was always terminated in the gettimeofday() function.
> 
> gettimeofday() is called from the python thread, and the python thread was changed to an rt thread using rt_task_shadow().
> 
> The xenomai version is 3.1.4 and the linux kernel version is 5.4.255
> 
> I know that a system call is used inside gettimeofday(). Will this have any impact?
> 

Yes, live-lock over I-pipe kernels due to inappropriate glibc library
use from RT: Kernel Linux mode tries was interrupted by Xenomai thread
while updating the clock parameters in vdso, and the Xenomai thread
spins over reading those as the kernel never completes the update.

This is solved by wrapping calls from your application to libc services
properly - which also excludes using Python, besides the fact that the
Python runtime is not RT in any dimension.

Jan

