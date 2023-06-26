Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D4811
	for <xenomai@lists.linux.dev>; Mon, 26 Jun 2023 05:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi99x2noYM8H/gcY885onpMUd/HeA56u9n6EhNhRvYzqYTCr4ySC/b3nydhkvHS5bWmkLwhRDht5p2iVyQB6aE5MCjQcL4OjRmpRRbg4oeWbw6qfdrGhayu6SBEv973DxxyEMZEjJ2y51WwUb1tr3CByi+1444Kugwi3ZMa6qnQMPg2XtO1ekGS69SsFAn+OGiL22dXh9F9W/qKCTyvUQ6heIQTjii5sBAGnc8etQQbmGoLaeiCvq47NM5375gDDi0g4i7FZGrUixAud42/8VeBKBLbGgfun5DE07ArFJNt1foCPjge6EID81iHdl+11usAc8kepHGGmuozKyRtRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CDv1+jJZv3kIcScFo7qPlB+icNobWR4/+4HOVPK4H8=;
 b=EOIQGapGTIsL7IpADOvjEuSjHEL7DVyRPMF7JXjzvc+J4rhnV9yxiNa+Taq1o1Uz+V3dBxwOWr+N7WkDuXJs5Ers52o2tNTJNlPnAoRBQOCaXW0uPl22B9C0mRItt2sI9DOa/T9BnbyPQ5q75E91bW3qOJVnexFgkabB5qqQFsukTtx/AK9Z7el0L028LZU50ShxWkxt9SE2CZaqooK6hRI+3Gg+/gLa2Zxq8WqfwsBfw07/SBmj4yU8qiuHOqA/rTF4YyJ133b2V2V0vmdtvvKbxtt3KD5VZXgRjpqkdfUHSsq8T7n1h8CXzdDelFNAnTWbuofSUtt/Jhph9eP0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CDv1+jJZv3kIcScFo7qPlB+icNobWR4/+4HOVPK4H8=;
 b=UO1FeqMI0TaWslU0JKPV4W3nizT2a7N/m2za7w5mvMf3PG9fwMVTebaiwKx9mRhjJBF4xnjFbqN1y4R3+VK5Fj62JLJi/O+iLpKhe5V3/rAR98k7vbmSQ2m6LT6NywK6OXJPEwXQRynXH+3L0nxHM3MbaLk8wSQsPhiw43W85SaXacG+1yfB+BPOjFZ9sZjTxut4bejRQDDfDvn2T7alZK4DVr0c0wmEo6DVrw2UFkNfamG0wmKZjajASgLZEPolfSZao6CKb8UkDt/yYl30d8SbUeaApir4RTY0izxfF34tHA2ztT6YD/CdzOvmoH7Hok5s/CwNnSKSaForKF0sZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 05:18:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 05:18:13 +0000
Message-ID: <ad87cad2-be9d-c30d-2237-c80a26fb5abf@siemens.com>
Date: Mon, 26 Jun 2023 07:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Meet-up around EOSS (Prague, end of June)
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>,
 Richard Weinberger <richard.weinberger@gmail.com>
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
 <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
 <2f5af611-8f90-3446-042c-6ec33a9d719d@siemens.com>
In-Reply-To: <2f5af611-8f90-3446-042c-6ec33a9d719d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9aa398-a888-4baa-a952-08db7604bd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cUBAqH3XSLt6c51EUvNQaQ5N92ydzqcq9TtmqP4/4KfOJrmF2wBBf1Ef+XzNrhNcCzHZUYm8My+SuEbeLLDmY7+Bl5KbgInwQU+qZNsgEBmgSm8k2v+e5IWKASPEhqm2Hht5rTDhmnkykJiRFP+QFoOn8vzKeX4f8znG9enwg29L5sfIeWQn9+RdliLxWNCFSsVyr9Kj2KBNn0p7QHFdyLZ/Hnm1zIKhozAOfmX5OXkhGeM8iSJr3es8BSNdnPfTXTZzm+sfyZ9oiiKhbCaK0GinrW0khNQYE/UhPOYAGhimVo1wcgGy4ITyYKB6UMgS4d9ktQ1K6Dpt4nViPrrdR0Ip86EPL6wy1Bc6494la67Ov6/tL+sqgLHs6B7vl8RIBJO2aUiOtwyGosBW98OwXxmuFsPCFtQ9ygdx1zYu/qAt245vOv8IveEWufEZQKGbhwnAcfIQAjduouP1Kx1hUo0/+Bt4bg0cwiju9WXwdrb3p24v8YC1ehvWJsJqGOM5GTAtpMy3hkaBErKuWTqVEw15LkrL15O4qlqvB/j7FNyRLO0IF0hVboaQHHwcKHm7Ih1tPeKncNP+Xe4xzsV10sA78ilFethrKY4ybkY1y8p62EOVMurF8a06dnwV6ZTcsw+ZBPr2366pjC4R/PivlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2906002)(6486002)(2616005)(82960400001)(83380400001)(38100700002)(66574015)(6512007)(6506007)(26005)(186003)(53546011)(966005)(41300700001)(31696002)(86362001)(110136005)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(5660300002)(31686004)(8936002)(8676002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNzVU4wV25abzJ2T05FdWt1d3JMTDRTOEt2WUZUNEk1UlQrNkkvWUJkVGhz?=
 =?utf-8?B?S2MxdDZTbUJwUWFHOXlxWVJxenBPeGFOY0I1UUdLcUN5OFYvWnRCUnJIcVNS?=
 =?utf-8?B?RWhwS3BZeWlzMVpCS29pNjA2V1dCRzRaVklyUW5RKzMrM3VjaC9qc3A2emcy?=
 =?utf-8?B?N2JNT0pPREtFSFUrZE5PMDNmVEZBdS9BVlJ5SXlmVE0zMW9lYWlKMXBRODcr?=
 =?utf-8?B?VU5XN1VZYTdLTjF6bVlzVHExYjNwLzNRMElVZFZjU1JyMk9JVEsydG04VGQz?=
 =?utf-8?B?MENESlN6SWVmRTIrUWJLM3NVdlBQK0hHSXRuNm5rSUxYcUkydmRRcDBiNWYv?=
 =?utf-8?B?RXN4K0FLYVh6cFEvd0p3bFo3K09hRWFxMkxydllIOTBsNDdKU0hnV1ZWcSsw?=
 =?utf-8?B?b3cwR1hRRm5rV3g3OWZYOVJUVEw2WmFiQVA5dHAwS3BwaTc3MFpBUWlta0pl?=
 =?utf-8?B?U0lpdzJ1VVkySmluS24rdHNFNitlNWxOVlZLWWFTOWtlYVhqRGxNNDhtMEhS?=
 =?utf-8?B?MXIvTW93WjNMOFRTc3cwTG5OQWovZ21JVSt5RW12Y0ZxVUticWoxOGFZSS83?=
 =?utf-8?B?SDAyNDVsdGxDSVNtcjBKUERqTmpoTHlQZmR5Q01Va1ZMOHJSb2NDZFQ4cXQz?=
 =?utf-8?B?VjdqLzU4djVxdFZZeWhVSzQ5QlJmTDAxNmE5L0k5dUNrdEZmNGcyNHQ0WUJZ?=
 =?utf-8?B?WkNxMnlEa3ZZYTJUVlNqYmxnRDZoRlQ5UFBZemI1aDRsUVpJT2lEYno0MUN6?=
 =?utf-8?B?cnYrNnBuRFh3RFE5S0MwWHU4azBwa0dPbE5TbFkzL0t1TGFFNlgxUFVyeVZI?=
 =?utf-8?B?WWEvUXBoUmhBR3d2Z2c2YWZGTStJQVpEUExmS3hqUDBZTFRjbnorY0IvUmtu?=
 =?utf-8?B?L2pOVm5Jb1V6enBZYkFERU1vNVJsQXlyYWE5cERuY3hYTGw2bmVkTlErZkNO?=
 =?utf-8?B?MGViMlZYdjJPVVJhZGRGaTR5cC9qcTgwWlZxay9iZDNpd05YdVdGZG9VSlJ3?=
 =?utf-8?B?Y3YxRXJLbUdkeTh4MkZNZTZ1UmFtQ2RaM3Ixc05Bbzk2Tk1KMzdHYkhsc21m?=
 =?utf-8?B?bGg5bnJNQXdLRzZLMTBIR2ppQTREc29jdkpGSUxQdjRBQjh4Zm1OT0oyZjVw?=
 =?utf-8?B?RWRJbFhOT2R3RlIxZWs5c2dXSUV3bVRZK2x0S251WFZLWXFKaTkzRG0ySWJH?=
 =?utf-8?B?TEhmNktxMzJOclRRUk9OWHhaQUZtSElDNm5WTHpkS1ZLc21QNG12bFB6VjlR?=
 =?utf-8?B?YWpnUHNMVTRpNTcvRDhYZzRFRGpMZmtDMjBuM0pLVU5QbVBKZXV1VmRTTUtD?=
 =?utf-8?B?aUFMTHdNUFEyLzZWV3h5ajdySHlEVkN4bjdnUmtXSzVtMXFRYVRFNmFVYlVR?=
 =?utf-8?B?UGQ3UHlUM1MvN2VSM1pvVlVaUnE5OXIzbUxnTExGQVZHUFlhd2U0cFpIR3JP?=
 =?utf-8?B?cDZDbUgvVUE5TXhCU0dTbUJ4WFo4N2dBWnhQNFZQS1R1d1dHQis3MzY1YzBW?=
 =?utf-8?B?YXFJZGJyQWtnbEgxWHpoUFpaTHIyNUtoYTk5M21iMUV5MXFSQ2ZJRDR1bjk3?=
 =?utf-8?B?aDVRVStWbFZ0MUNJcGlIM1NIS2VrZzh6WlhJRGs3S0F5OFdkRENTUWFzUEpM?=
 =?utf-8?B?bjYrZlk4RkVic2w4UTV6S2ppKzUwRWE4TmlKbHl3Q0xCTTFxVjYzdVRzMy8y?=
 =?utf-8?B?WHV5VkNCNFB4T3c5VHNSZ2xTTllOOGhXVlZOOUNFa2RjdjdiM1AyUlAvdGI0?=
 =?utf-8?B?Vm4vdnE3OGY3bHdlWm1qNCtiZnFHekE1WnN6Rm9zYmRlaTErOVUvekphNFFV?=
 =?utf-8?B?alBxMlI5TTgyZTVFQ24zRFg2TFFLMTVSbkZ1ZFVnalh2YmIrZW9hV05xME9j?=
 =?utf-8?B?YVNlb2ZXeGhEY2gvYkRHRUdyekRoRDJkbEY4ZzQ2QmdjdFovQlpyRThvUDNB?=
 =?utf-8?B?T0JYUFlHSWFzSXZTQjJwNTBuMEhrTE5KS2JKQ0w2eTlkZUNpemxDOVFxQ2Mv?=
 =?utf-8?B?UXI4aWRISERPSTllanhVQVNUd1RGVnBuNzcxRUJHRjV6YzhIMERjTFZrN3E2?=
 =?utf-8?B?WnVMRlE2cFRYcXNnN3pXS2p0QVNIVzNOQkVSMWxGNmt2ZXZTOHdLZDZ6TldE?=
 =?utf-8?Q?mBTxX08Q42YRLcXAmdS2t/3aX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9aa398-a888-4baa-a952-08db7604bd78
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 05:18:13.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO0GH4Eu/Ntbdnzw8p4+3kQWu3scUQuQ4tsudGFBSvmHbrHljlkEyYd9t/Iv3iAHuQawdZ189gsw+xpEDMw7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5581

On 21.06.23 08:24, Jan Kiszka wrote:
> On 17.05.23 09:12, Jan Kiszka wrote:
>> On 22.02.23 08:32, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> as just discussed in the community call, I'd like to propose having a
>>> Xenomai meet-up at or around the Embedded Open Source Summit in Prague
>>> this year [1]. If you plan to go there - I do - and are interested in
>>> chatting about Xenomai topics face-to-face, please let us know.
>>> Depending on the feedback, we would make this more or less formal, from
>>> looking for a real meeting room to defining a time and place to have
>>> dinner and beer together.
>>>
>>> BTW, the CFP for EOSS is still open for a few more days in case you want
>>> to talk about your latest great Xenomai project at this event.
>>>
>>> Jan
>>>
>>> [1] https://events.linuxfoundation.org/embedded-open-source-summit/
>>>
>>
>> Just a reminder that we sitll plan to have an informal meetup there,
>> likely in some nice place for dinner and drinks. Besides Richard, at
>> least 3 more folks signaled to join.
>>
> 
> Richard and I just selected the Tuesday (June 27th) evening for that
> meetup. We would meet on the venue and commute from there, details to
> follow.
> 
> I would currently plan for about 8 folks to join and look for options
> where to go. So, again my call to let me know if you wanna join in order
> to reserve a suitable size.

I've scouted https://www.pivovarusupa.cz yesterday and reserved for 10
at 19:00 tomorrow (reservation on my name).

For those at or near the venue: Let's gather around 18:15 at the metro
station Vyšehrad, entry towards the Corinthia
(https://goo.gl/maps/YQcvKYc6DTvcXS3A9). We will take the metro for
Muzeum and then walk from there to the brewery.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

