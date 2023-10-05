Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F628DC2
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N4PFcJSs"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6lZEVUnhUtEMzuwYKvaCs1QMw2zxuR/HZef4603HcCViIAD/ve99T5ILNPOrZU5bSuAM4ScJV9XM5WB1GiZKIIlnoFX/qTvtOysQfhDcbcoQ9tcjaPE2BKXqaUdeWCsIqiT67Z1vGOxFmHqCNvFMPhL+fp+jxq31/0LWeB1d7V0HY7S4BtW9AwlpeS9o2BBE21hzgB/5VoGnHQo/R54htk3TN1FPYmEWPzrF8x/LtZzZk0q93+8lXinBK2kVnEzxG/dikeKVrONpNEaDf2iB22iFbQ8fnfRP2QB7RZoVgKJtpwUCjtA1rk0PpZ7+VHrp5U3kWmy9KByLAkXHOrgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7L501GsqhfAO+dOR7h40rTW2BLGdGaV1I8KqZi+rDw=;
 b=Au998rEF/V9xM9xF4UqR6GiW8bLPjBzSrN/9AH82xhhmqygbwX0cKXrAgwHi8qZFVOTOlE0R5Puk066+TPqAKApiGuO8UrfrdAuRJLPLBmvYGn0tOWo5ERKQL1L9OXUOEaTkwUBkrsu4iqi0dudYQL1M0ciZMVnrTGrFwiF8mSl/7IJo+o7o4iExPSSsyZ3utNXcrkaF/m7UhzOHuN/BjMU6tkjHY6mNZVK3Q/8WQmXd99TSSvN/MDpsurOdFeg7nx8IQd+YZuvfTffVUMKhhICsywu+WVnFT5EKvsarR47ERvSA2ROiIDwxTWtrPndGo98CmqJCwGCxal4uP3zj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7L501GsqhfAO+dOR7h40rTW2BLGdGaV1I8KqZi+rDw=;
 b=N4PFcJSsMvKzzHm6RMWVgf2MmHcrlqpc8AvZ08pYPHDTmTTd1TMuTwZgYkiK4vzKp56Pk7mhonZ5YlXnB/DClWIMuHPARG4tHLZlmc/OjR/8u6tefolKbg6EUVPoFm2d8UCB5iP44Rgsf92SGu/lM1FQRC+ORfdv1JRi6FmHiGc1kwzJY9gnJyhxE2LPmPHVTHSkMLi96FXRNYsLEwZ3T5Elqq0Flkhrb+YhYrijBNt8ZOdZ5r26EPZrxcVVLq2H2tGWK7py3N1sJcuElUDkbqwRIz4HW86RNpYbSa/T3b5zai7xP6lnoBiU7yD2Q17jdvrWa1b9FXtcb3LmycaQdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 14:21:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:21:29 +0000
Message-ID: <773177ed-357d-48d5-af35-645ad192b209@siemens.com>
Date: Thu, 5 Oct 2023 16:21:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com>
 <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com>
 <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com>
 <962e9533-26a2-4a02-a5c8-21791e86fdf3@siemens.com>
 <471929520.3420035.1696428900861.JavaMail.zimbra@wolfram.com>
 <1711728904.3619924.1696515557888.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1711728904.3619924.1696515557888.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3131:EE_
X-MS-Office365-Filtering-Correlation-Id: df9d603a-d3fc-4995-8e76-08dbc5ae5dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lr9ZZOJyPN72tOXU495DaLus3AN0KutcLVMBuskL8CKfKkbpiuS2fLaY/+Ncj0BiDFBgWud0pe9sOxWxPKhW3NrhnmN+x5s3MyUW30F7xF3M29z5ZRIH3Df5xYPEI40hqcIK+2q2O3ashv4WGS+OSDkmyna24LL88SKMJ0NF/EpoESjqPwHK46xcPiaZuFtXXaKumlMqYJjuq30h/+uipTidEoaIMJzgpQwX31hUTgn7NERANxw9l1HUGboYQuZRHZMk5dO53hDXi90gMrzVeS94eUMR0aDdGaAtOg3z8L/RsbjOSZxELSbvQwSuY30lmwN2aZiB0e6j3fe6yXix2VT3uudfkL09MdfIynnYwjUWw5VzwB2pESdr1PH+N8MfFnQ+cBLEpNCiM0gUFY1SIn8/+fDlT8TJGr8F8Wr5q0JMGDDAMVWwCHC1FMdC46JRJcZL6r4ZQ5OaSzvMUZumgzSwdTfl5N1BKgYcE3wWt1upEAqIGV2rDPq6V4zYh5xqfABsJL1bGt4JAKroi9bC2JHyxPC+MX9izkfRWS6pWgPpOLgImRfzsZyGaNW1uVo/xVPB5t2rIPTcIX0lmsXv8p2ZmshdaDR3001FG3HctrCxv+GGVacT9hRg2ziMQMiNOaTReATDCVOwN38VhDqLhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(36756003)(66574015)(2616005)(82960400001)(86362001)(44832011)(478600001)(41300700001)(8676002)(5660300002)(31686004)(6512007)(38100700002)(316002)(8936002)(6486002)(2906002)(66556008)(53546011)(66476007)(6506007)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFlbERFQ0FnMW44OVV5Ny91Y3htZlFEbjVGSm10bHpKZnZiZWxQMCtzbFRJ?=
 =?utf-8?B?RmhsVVVWK040aG5icWh4MXIxc3JMaDlRK0RLQ2loZHdJV0xoQmQrZFFueldn?=
 =?utf-8?B?K3Q0ajRHZktMa3Y4cjM3U2tZM0Z6cWJibjJ6Q05RM3BJVHkxZ2w5dHg3Q2lU?=
 =?utf-8?B?Rm5jR2JPWGN2OWRPdjNiem9IbEpOSXdNN2V0RlR4UGNWTGtuaDJ6MVppTkF3?=
 =?utf-8?B?WTJUM2xoYldvUEVEczl4L2V1b2ZGUVEwakQzWXBCMmJ1bTlPWWd0MWdJcnhB?=
 =?utf-8?B?NHhuSmxtUlFiYjk3T2VmaDdxem9QTFJmWENEbU5PQ0tWcllWSGlaQ3lZaHp2?=
 =?utf-8?B?VXRqbXJxdVdxUmQrbzgyT205TmFqRE1LT3QvUjFDeWU0aSs2VUQ2UGRTcVhw?=
 =?utf-8?B?SDBoYzVJTkdKcDVGTkRzOEZGYjlOb1ZhcEQ0MnExVlhWSzFmbEQ1V0trTDBo?=
 =?utf-8?B?VTczT01Ydy9FY0xoV3VXNktwb1BnTXFKalJmSTdxTnRleTdJbmF1SUhocXZW?=
 =?utf-8?B?OGVxMEo0SUlrbVI1ckF1RkE4Nm9vYU5ac0t4UW1YVGU3b0ViTmxYdm4vQXRW?=
 =?utf-8?B?R1hPcmExWnNiUzg2S081Vi9YcDUwbkErcUxEWTVpNUF3S3VqTW1UTE0vcERk?=
 =?utf-8?B?bkk3dFgrb2RDY0hrc2NXZGRuZkxiWjFDWUprQ3FTVFB2TGxRaGdyYXA5c0ps?=
 =?utf-8?B?aVh3L2xaMzBiRktBNUlrNXE0TnNjNE5rbjA3REJaQUkvWXdwNkZEdUE5anFY?=
 =?utf-8?B?K29oaGhMdE4zWmRFZUM5UHRKS1IrdDYwdFcwWmZDTVI2eDdWQm51cXN5YkR1?=
 =?utf-8?B?aUVxVDRjVVJSbUlHdC84VXZoVnZuZXUvaDIyOEFIS1VSOVlNK3NPN2JZZmJk?=
 =?utf-8?B?ZzR5NGNUQWNEUlI5RW9WNVdsSnFid2Z5L3duWWhDSHlMbmpadlNSaUhRVk5i?=
 =?utf-8?B?KzJ4WlUxT2dLSEdVYy9XRzgwYXVBS1lsaEhpU083dUg5eERLd0kyd3VYN0V3?=
 =?utf-8?B?N1FIV2hZdWcySlYweTJsS3hsdUhyZEFETGYveHZ1VjlwS0s3S3JDSXk2QXZT?=
 =?utf-8?B?TEprUzk0RzF4cTBoVGRQNlhrajM0LzZhQkdpb0FuWGRNM3paQUxpL2hwd2Vp?=
 =?utf-8?B?eHVXdURFZW53bHVPMjZzR0pyZGRKaHY1RlZ4TUJiVXBsbk5ySWRKVVk2ZGQ0?=
 =?utf-8?B?U1NLbUQyUi95QmJSbTRZVGgzY25EU0NPcHQ1YlhValA3UldSdm03aXIvZndo?=
 =?utf-8?B?T3BFRzZIL1NHV1luK0JGTjJnUmkwUjJMMlFYMFl2ejNNb1MveSszVE9OTjVR?=
 =?utf-8?B?anZWamNxOTd3dTU1TXp5Z1RiYmlVbFU1bTZIVTYySGdHVGR2NlNENHJOUWN4?=
 =?utf-8?B?OXVaLzVheDFCUlVzNjRTZno3NGxMOWRtR1haZzBLd2pWMHFJNm9tZUZTTm5P?=
 =?utf-8?B?NVZsWGRGclR1OG81Rkw1ajBGN2dlZjFkSjQ3VUNkZnYxbWs1Z2JNMXFnejRu?=
 =?utf-8?B?YmtTY1FIUnMxVjZFRVptcUxSNGJzbHlHQzZVaTVPeGRVUEhrV0lWTVo1NFAz?=
 =?utf-8?B?eFZoZVVTN2EwdUVBaWMwNU90cXc0dFRwQ2F2UXRGWmxHbERxU1NpNFhLUUlE?=
 =?utf-8?B?Tmc2dllBL3JWYXdiYnFiTWVQU0ZaOFRqUDdoQ1ZoRGtSSDI2SlQzQkdSUy9a?=
 =?utf-8?B?T1JvNXY0RVZlU0xUUG8rN2RIeUN5eXMzOVNjQWxNV05NZWYzWk0xNkVBZXRj?=
 =?utf-8?B?RUNKL1lBd0Z2VHZpeXc2S2NxTjljdDFXRTNMMGU0U3UybmZCMlBOY21iMkk2?=
 =?utf-8?B?TDBad1h4L3BNbFVMNEtkRUhsZmtJSXQ4UHpDMWJqendKZHp4cXVUTUxXdmw4?=
 =?utf-8?B?UTZiUCtnV2YvVkdjbnZnNVBvREJ1Zi9ncHFFVXZyZmt2VDI5bUlmbXhUTVg5?=
 =?utf-8?B?ZTB1QUkzdk9MbnY1RCtjU0U1eFU0UlBpVDludkY0dFBxeFRIK0FNcHUxd2xi?=
 =?utf-8?B?KzltY3AwYlhFSEd1dWRMK09Xc043cngrOXExdzQ4QXFvOHBTUExYbVRYRnhB?=
 =?utf-8?B?bFl0TWhaOU5UMGRWMEhWbXB3Y3ZCeFVtQytQV2VwOUUrNHZEZ2tsT01MeG5C?=
 =?utf-8?B?TnRpZ0dxamhmZmZ0QkhWblpLRFFqOWwvQ3pXdlUrSExzaDRmMFl5UnVtWlQ4?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9d603a-d3fc-4995-8e76-08dbc5ae5dd8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:21:29.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaHnxRxRNVmitCidpPM43EAp0WNa6KkUiePZcgVIOnqd2RLifFkmQcTM6T+HBOUhSrjh6pI5MHVchzW/qsnsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3131

On 05.10.23 16:19, Per Oberg wrote:
> 
> ----- Den 4 okt 2023, på kl 16:15, Per Öberg pero@wolfram.com skrev:
> 
>> ----- Den 4 okt 2023, på kl 15:57, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>>> On 04.10.23 15:01, Per Oberg wrote:
>>>> I just had another hickup. This is 100 pct reproducible
> 
>>>> To get it up and running I had to remove rtpacket,rttcp,rtudp,rtipv4 and then
>>>> forcibly remove rt_igb driver and then rtnet. This gave me another set of
>>>> errors, also listed below.
> 
>>> What does "forcibly" mean here? Actually "rmmod --force"? Then you get
>>> what you deserve ;).
> 
>> Yes, intentionally. I expected that the "rmmod --foce" would reek havok but I
>> thought that perhaphs the actual havok caused could give more pointers to the
>> actual problem.
>> I wanted to see if I could recover from the first crash (not the one from my
>> first email) without rebooting.
> 
>>>> [15018.436248] ------------[ cut here ]------------
>>>> [15018.436249] [Xenomai] switching rtnet-stack to secondary mode after exception
>>>> #6 in kernel-space at 0xffffffffb837064b (pid 1438)
>>>> [15018.436258] WARNING: CPU: 0 PID: 1438 at
>>>> /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x26b/0x2c0
> 
>>> You are not using the latest release, not even of your stable series.
>>> This is needlessly risky.
> 
>> I am currently updating the kernel and xenomai libraries to see what that can
>> do. I could not, however, find any patches that looked relevant for the issue.
> 
>>> There is some imbalance in the reference counter for the socket, and
>>> later on are complaints about leaking buffers in the pool. The real
>>> problem may rather be that you didn't shut down the interface properly -
>>> or that we don't do that when pulling the plugs in the order you describe.
> 
>> To be clear, the
>> "[Xenomai] switching rtnet-stack to secondary mode after exception #6 in
>> kernel-space at 0xffffffffb837064b (pid 1438)"
>> happens after a fresh reboot, not something I kept alive with artifial life
>> support.
> 
>>> Can you reproduce this rather generic issue over latest master as well?
> 
>> I'm working on it. Hopefully not.
> 
>>> Jan
> 
>>> --
>>> Siemens AG, Technology
>>> Linux Expert Center
> 
>> Per Öberg
> 
> Now tested on Linux 5.10.191-dovetail and Xenomai 3.2.4. 
> Cannot reproduce the crash anymore
> 

Ok, that's good news. If you happen to identify missing patches in 3.1,
we can probably pick them for that version as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

