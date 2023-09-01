Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DCBE5C
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKmy+cuy9ImO58B9d/GBUj3wtmzuedVhDH/3uSlFuJmRXvbhCCxF6md65/JaMnUDXU6gnRsMWZ7UIJc3FXEXKOTJuI2QC644zfzh3gl2Vq0DgiJ0LCozzjIaCaq8KXOXkMbWcTUQmQZobjeuQtHJ2udux4J2Ur5Rh09lX70uWynfMBwh9P0NMwU5TDknRLvOOvwdEF16AxltlSv0OkYjFVn9r9eOnBGb+PTOdI69zB+ji+SrQFQbNwc38LOyLvdcEesCr607erxWyb5jBwWzBe10e/JpB8D5a2cXP5KjPcRTRybjKKMfKQVadqQl+BzPQ3B4rpOxqstv1kXtSHgSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6jBgiOzggp5vm8tu/e5x5/NscZlSVLCG9uJd6oMB0o=;
 b=IogMfel9NDfNCTMpYIOE19xNOAbN/u0o2Yf0ZHem7t5aNzQYgPB+RuGxK8nOjjpwgfsUlv6/wkolL81e8Qpi3d6/OY37NzH0JYn0ee4j3jV0/tCifqDuvzWCm1IYyLXsWCE03IMKI0DbOwzxUUdC/RjclD1CPVPOxBk33goK5KFwOcwtvd2E4SmXTjh9tt/eCGAiUy+izzU0XOyjo9aKfYkmTsAVBQcDhAj+ikYwab23Hs94RNKERcQ8sUwS3aRDvD0vKGCDtnbtLXTVLF1I6D+AfgiWaqg817zxcDzUfv4T7VRmJH1QpzLK0/HW5Fxg3JyEbJgnVo1IiPJZK+/D0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6jBgiOzggp5vm8tu/e5x5/NscZlSVLCG9uJd6oMB0o=;
 b=bEhelgiQb/EavYr6UtkjN197ATHHN18cI9shgXVhxOUq/9gfhzheoNf4bUqrQKk9AA/LCbuVR/9W4WZwmJie9Jj7grCfA14u4HeJBNzkCQJ4BLKExrkaJqV3dpLkA/2dcu525dKiyT3wYGyChZnCiyocwA4rBgzDWDOf/Y/fkqTFRZT23Dz7g5DxcIn2J10PcPdchiNNS2KAsvPKX3QHoZMzjL9t9+wurmWPgR6rT1rNN6w5EoDTrcrOPDsZJ/cIHWTwVnAC30b5N5iWAdz6PFIDtfD78KWzVjXk7JagjtpQQBr7KBPVaOxXAQaMZPqQHTbd92/v//a60Rn52dqByw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6358.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 13:34:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:34:11 +0000
Message-ID: <926e7876-c2b0-43eb-91b7-7b7f969ab208@siemens.com>
Date: Fri, 1 Sep 2023 15:34:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Status of Xenomai-images
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b62d83-3307-401d-ff2a-08dbaaf0205f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qqtyo1SdP8SYOMPsLGKk+7a+pBzSPCkQtxAX097RfT4tiUYAIajSxQxpXUZf6wb2RX9iV7YJioMLTIKE0QSMj4CAuQqdljqm2/WH6UA5OLCSfIJpHTsLFPZRaZDncnvVAUg4xMwg4I9/3BabDpQYWZTvLhCYHmysyukdVwgJa86/sTqQ4mI48o4/a8/0/M24IdQAA0hkw2F8QVjvy2E0fa7fHf8vBJQcaSG/3qnmyQc/RI8djZLMyGDN41/SV4qXvvbFFwrevOdUxU6FjBoQpcbxT38Sby6sAIeldKVwB4yfMFDKnifGelHqikrnqBAsOghMiWXEK0M3IxHaIqROhUnwChbXtyRluKFhEj3pKAYo3mqMqsn+qLu79SYo2FhsvPEHExNEY6+vvolEWfLKSwRwbyiKEAYArXEeuiOfW8KZdeg3V/lXUqfpxD166M3npT4Qz/TgUQuWrx5ql6S0N7ucyoGqCvZldcczRS6hYkuVgMNHNk2QAzr6LBUxH8e0ZnegE9GhO+hMtcogdeoKbhfR2K+ANveuD6Zu6b7ksDxSZ5W7wO4l21BP+R8okjYpoNUdupomNSb4ru3XEx9WhjnAT+zvRUf3rXolfr9QJc4Y9rbfR0p7KD8bmRQn0Ph1/bQj5Tp+P1Z3b60aQMcK5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(6506007)(6486002)(53546011)(31696002)(6512007)(3480700007)(66476007)(82960400001)(316002)(38100700002)(2906002)(66946007)(36756003)(478600001)(66556008)(2616005)(8936002)(8676002)(26005)(31686004)(83380400001)(5660300002)(44832011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVd4MUt4Q29YdDMyN1JiRDk5WndReGt3M3dQaWZWSjJFelc1N1U0Rzg3aG0r?=
 =?utf-8?B?WFg5TnJzY0JVcng0VEU2Q1p5NFBQTWFPUXVxOFJuNHRKUnpIeDVGbW53RjBO?=
 =?utf-8?B?Q0Y3Ymx3Rm16YnFyM2ZOWGx4c092ZXM2OXc5YmFxbUVIekRXUWpDbzZyYTZE?=
 =?utf-8?B?K01KZzFMOTZ4VEJMbVg5Q3hmL2lDMXZpT0ZCUlAxdTg3V1FaQU5LZDUrTm1X?=
 =?utf-8?B?bXJpS2Rlb1RLdms4bTFWQjRMZGxyQkNCNEVISXhnTUdKb25nbFRub3R5ZHhV?=
 =?utf-8?B?Yjh2eVRXRVloN1RYSU12bWtwR2pIOTJ5bjViZkhDRkJXUDVHQitjT2xWRDZq?=
 =?utf-8?B?MUhrL1h5MDRtSlRqRVRNRkU1L21sbmQyQmtPckd1NFg0cGdxTXl0a0s0cTJw?=
 =?utf-8?B?MVNSTFpVdFNVYjhhNG9RTzJ3TlNiRzFjbFJOTXVxUDdHbTBtc1cvZ3VycHV5?=
 =?utf-8?B?ejROeWF5ako1ZWRyNEJsWENxUEQxUkVVdHdGNkRHQzM3QTJaRnk2UFhPQ2lL?=
 =?utf-8?B?VENaK3BUTEszOHpzcmpSMVdZTVB0cVNLUTR1OXRUY3hnWXpCN3JQTVREWEN3?=
 =?utf-8?B?LzVxamROUVVqcXY3ZnEzQWpSWDJkeHVldGRFcUtmYk5CbXRGOCtyeVp3MUR3?=
 =?utf-8?B?YTgrdnhkSXdjTFZ5THg2ZHBHN1lOaUZ2c1JQOXhRamJjWTV2RUVPUHhHSnQx?=
 =?utf-8?B?TTJFZC9TRWZIdzRrMDdLN21ZNUI1OTJOSWlyUUpuWWplYTJCcEhQQ29VOVdr?=
 =?utf-8?B?NkJDelFFVjdVZGNPTWRabit2MWZETGlPQXdMQzE1MXBydkM4djBHTS9FMnYw?=
 =?utf-8?B?Y08xKzB6SUtDbTh4R0RmenlrNjV1YUI5eVd4aGFZY1NrenhOckNwSFZPcytB?=
 =?utf-8?B?NzlmZGFBd3puT0NQU3U4czBacWp1VFp5ZkVNM0loNXhiZGVzZTR5dnoyalVM?=
 =?utf-8?B?aDlGaWlNeGI5dEZGSjA0cEJXR24vOVIrdVRaZHh1aGNiR2o4MEZUcXRaYUVY?=
 =?utf-8?B?b2xVNGh0blIzd0hUaG5lY0lrSjRYODcxMzRtRWsyVm5FT1NTZmVFNkZ6YXFL?=
 =?utf-8?B?dmlabVZxVlRSZUNhZ2YvSTFuWnE0cWlySHZndFJMYWEwcmU3V0pVbmJZclVq?=
 =?utf-8?B?aUJOMTZvaHNNTHhvdzl6b0NlampnNndqRVg3SkN1LzVYWDZNYmxZM1JsWlZn?=
 =?utf-8?B?dnFSUE1DNU1wMEhsMHZ4Qlo4K21ZVzJYM3ZTVFAyMW5YNy9pYzdxakJNYllr?=
 =?utf-8?B?dDd0ZTdxVE51eldOcmZQS2NRMk5ObjBMOXNGU1pDdEM5L2t1L1lWdWdsRkxp?=
 =?utf-8?B?cXZka2xrUXhMT1NiTDE4RHhwZUZNZUg2R0Jlb3JWenNnTU92Qy9WWDA4eXl5?=
 =?utf-8?B?ZStGWXloQ3JIRWZ3d2VrL3ovdjN1L3VTOUtpNDJZRnRFMUlZUCs3NExlLzJp?=
 =?utf-8?B?ekhuT3JkQ3hEYU81ZzNXVTllbWhXVjNDWjRrTVp2TjJkNzVLcnhDWmlpNVlD?=
 =?utf-8?B?QVBNbkRSYlRGbGdQdGZ0cThsZ1h1dER4UFhRVG90a0xXQy9xdGxXSC8rQi8r?=
 =?utf-8?B?M014Vm5wRkI0aFprQlJVQUtFanVQRnB4ODliazhzOUxSVWRUUGI1RC81MzlP?=
 =?utf-8?B?OFNZc1pUM0xQWXJXbUZFajlWcmFwWExUSS9sUG9SRFUrU0dzWFdPTWNsV1Zh?=
 =?utf-8?B?SEZSV1pEeEJOczU0Yk94NnBpUU9ZeUd6Ni9HQ05RbW9LVXVkMlQzb3VrWjF1?=
 =?utf-8?B?MzdKbVYvWkgrZjI3a1E0VW5wUFVuRTl1Q00rOVcvdWc4dm1BbURCL3VnSjY3?=
 =?utf-8?B?N1pWS2x2VS8xM3JCWnF0aytkakhKNnFHcmRPc0VSc2x6UDZ2ZVlvL3dlQ2po?=
 =?utf-8?B?a0lBdVdISk1EaDBsdmJaOHNMR1k4Vk5TbUtwT2N3TDRuUjdyTXpZTVhsd290?=
 =?utf-8?B?UFdVMlVOeXpUdlJCY1JkY3R1aTBJV1NXMURNVGlkU0dsRmxZS08rQms4bi9N?=
 =?utf-8?B?aEQ1ZHFXdmtiNzJtUTJWYzJ6TXo4YXFnSjc5SmVhRDhyVnN1dmcwaTl0TjRq?=
 =?utf-8?B?bnEvc1F6a1BndkdERmNpcW91QkpGU3RVOTZkTEJhMEswczVPS1JtemNXbUFl?=
 =?utf-8?B?SFZCZ0Y0bk1BVFVocFN0dEpqSGRtVUNYalpJcGhCUnYvS3ZIeGNuSUlKMWRo?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b62d83-3307-401d-ff2a-08dbaaf0205f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:34:11.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2WW6uCHBWQqT3U6N1gBZTrDiEFIDiy2yI+Ne7+YRfr24IZPOhmKoEGmX9NfBFotKA6r7xTmhP9lYA6+MfDMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6358

On 01.09.23 15:26, Per Oberg wrote:
> Hello list
> 
> I just tried out the xenomai-images [1] but I couldn't make the images boot on my hardware. The qemu variants worked.
> 
> I used "kas-container menu" without any changes and tried a few combinations like
> 
> * Generic x86-64 EFI target
> * Latest 3.2.x release / Head of stable/v3.2.x branch
> * Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest 5.10 Dovetail version
> 
> The hardware I tried so far were PCs with intel core i3 or AMD Ryzen based architectures. I managed to get my USB stick flashed with the wic-file and boot into grub. But then it hung with a blinking cursor when trying to boot the linux kernel. 
> 
> Am I making some sort of silly mistake ? 

Maybe framebuffer output is not working, and you are only "seeing" boot
messages on the UART then.

Not sure if we allow for an interactive grub session, but you could try
adjusting the kernel command line there to use console=tty0 instead of
ttyS. If that was the reason, we should likely fix something.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

