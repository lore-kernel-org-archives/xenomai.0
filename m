Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5DAD37
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 11:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxU2W1w6onnF+YaCp1k1bKhY5amNrdM3uPLuZ29vS0sCMqfiWWCMFWlYnf9gTNUEUzDTkpZsVLCa+TEkL4WrbMvEEmzcS26n1lZ21W50afHLNF+ktuAk7PGTtHkHE1Olvd0IfBaAcNbg108+R/68X+mv+d15c79wUeEO+qW9EP2wNepxGXmPy3EwXbgkI+76bWuNHh815VO5YUsn5yiW2rk8kvKFUK8tuYore2F31kkhtIz2/BmPgS7ie4d7U+pRKsUEnECZeoF5wIjAfyj22nnBmmWI82gXTGyODZ/0Q691EWfEiNgaPMOXfV+qPPyBeEkyU3Xm126OH4i/y3G6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBqaxVoF047e1IF1V/5t30WdbLr7/Ruz3RVpMB++cvA=;
 b=eLqUOxWcqrgoQIdTR+6uNjUMQ8CqZV34y0QljC8ZY8Pv3ribfNGw6GOonb/TcDTliSjLKyru/al/9o53C8C81Ivugk8WU4YP5CVAnMCcntkUsHNWZ6PFxiUsciaqp9BGtHA1ua4E03yGVK7Wpnmi9dltBFIuVeHr+IHXzXb/R5sIwtu4/Urq0a2FvMoGfXYNnqOSW4szr6vQUjMWcTdePMFt1WYxlpSJT7BpUx7TxLAsBY+fs1TGgnq/3AL1GYG+rzIkATR5zggLoo0769v+4wPgijBW8kqCyZoxOxrcjgTo5IgA6Ny2BDBKsHM4x7yiy16mCAYkzBuvtvyXJvYGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBqaxVoF047e1IF1V/5t30WdbLr7/Ruz3RVpMB++cvA=;
 b=Jv4RMnpgTdO8ZtQx6Mz2GWkRxIr0IXdf70prD9qjSDDkwwvmImmHUpUVr8MHqG+9y1vjKrT0B/EeEr+m8t8lBCJu00hR5BmWFMct2GP1EbvzG2s1bzCGoG86wSze1ya1o24KNh/y5IobbrNxAHvP+OVhET/5heZNyDW9YbTB50bYqWp491/v5mj0ZHzHEJGzVCZzo+fryW2hnu583qlfW+4iruPpooLhIsV6RSudRA8rf9CTHAkknufEHcJrboyuk9sE9rGPTeawmJ93VTonaag4JwulDRwGkG5OKQwC+tewJTjTRts0MC09MZMgS6tiWZSK/6+PqQdqGx5wK/nmDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 11:01:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 11:01:17 +0000
Message-ID: <7e217082-c9a3-b834-6c8f-41a456e5933c@siemens.com>
Date: Wed, 17 May 2023 13:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/3] y2038: Part three - support for select()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: e4aaef64-787a-4e47-c14b-08db56c609fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7bMV+Gz7FaNN3BcRz0qsuxAPkdABziQAwHZNUA1SSjViED6n7bRZFCY/w2Mdp4ufNoiHutuBw3PFP8BZqL0qtRZ4R7MLWd5xCBo/GuSAFbWVV3jhEQzrQFYASlu8guuULy7l02EcxgB8KQySPqfv9IWy+SZAbUlIH+ZgPiHApfdyQPRlPo5/qvaauXxozeutvI+C4dDnsaEebnWeWrgrKYaPmIED+xbkoSNhaq5rL0jwKtL5gMcPxz5yHdAra+7+TNrkzmXkYNfWD/ic+bcVKlnPjby2mwnHmoZXQSJpxYxd21XCPUz2RUochKTqJhJ3DoHLSSMn35DUB757GXcDdpjIANzD8l3xSOiP+lnLBfn22rBgfH0D7T37yN15IW7Yqjl74uV6eCh99VJpg5n/QUgnIJV6FxW4hNFXrXSWwjNC6DICoht/skVSIC6H2DCtGWchSbjaiF4fQuEFG25BEH6e4bloQG0oEk1907HNKhFH4ksFWEEGpdMibXkbDsk7fwY7yFdosZTD9zoAGklpKKp4Q2zE9hPtXp5tlwZCNdbGZHQbhcpX1Rm0xTCcZLkysEUqqCjbzmgKDnAbRjNLPpKOkUPJPEn24KcLqneqAzli92Y4Kxks26KPmI0fj3Zex36aV/vyUSprC7P2lhMqzdqvA5qu6uMYvHwXLttA+ql+3YNw8cUrYfdNcD352MpA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(31696002)(966005)(44832011)(5660300002)(83380400001)(8936002)(8676002)(2616005)(2906002)(186003)(36756003)(38100700002)(82960400001)(86362001)(6506007)(53546011)(6512007)(26005)(316002)(6666004)(478600001)(66946007)(66556008)(66476007)(31686004)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDV0ZWF2OS84OWZUcEZyakYvYnMybk5qQU90WjdGRDVwa201NG1qRy9hNnJC?=
 =?utf-8?B?U1Z5K21LU0ZvRzZWR0F6WU5PMEFEWk5uVHp6Q283dzV5c1R6Z2JzM2dZeVdm?=
 =?utf-8?B?d3RlUDFheU5qN29uY2JaVUVpbFRXbVB5ZWJaNjdKd0JZZ1JhOTgvWnZNeENn?=
 =?utf-8?B?em1acnFGUFRtMDNua1RtZ0lwNkdjR0FvN1l6UVVaSmJlS3NkL0tFaWpzRFRl?=
 =?utf-8?B?T3hxU2tsRlUxdzF1TnRFd3dqbFVMaEtwTFhhd2RZNXY2TXBoSmcwaUhobS9C?=
 =?utf-8?B?bU9BRFBkcTNtNUJyZEhacU5BbURDbTZIWmFoSGk5V1RiUXBNYnFLVXVxdjRP?=
 =?utf-8?B?NVZHcStGbWVTR0l1WWhKK09hMDBxR2tYZ3Q4MndKRjloWmpyaEJidzF0T0VC?=
 =?utf-8?B?YkFaYTg3YU1NM3dDL3JNL2NzQTVPbzFUbGRqenU0ak1sSGpuVy93Q0VyNFBG?=
 =?utf-8?B?anRDSFZDT29jTzFjVDUvN2JOTk1Vb3BYVnQ4aGF1eFBIRkp2c0lFbTFSVnBJ?=
 =?utf-8?B?eExlb2YxQXQyQXRZSEZyQkxzYnQvMW9oVlhWTUN6MlczdGxMZ29obVFrZ3Z3?=
 =?utf-8?B?VDdYWEtDL0JiVW5nc1Q5SGh3N25Vcmlsc3A3Z3NsdWN6OHlBMThPUW8zcGEx?=
 =?utf-8?B?MXZLNjNqMXdoUlVDTGZxaWJRbk9Hd2VnM2hhUTRTbmlDZVU3Rk0xaXdqR3h2?=
 =?utf-8?B?NHg5ajFPL1hTdFcvSDhYWVVydEQ1aTBtZnR0UTVqVC9mZ1VqK0lVRFJpV0Vl?=
 =?utf-8?B?RzAxK3dFMVEwM2hiT3NiVSttUkpWRzJCUDRPTXVLc2NaUzNsa21SZW91Rmh2?=
 =?utf-8?B?cHBFT2Z4WWtsTDByb3B1TUo4R3A5Z0Q0MnJRYW43KzNCQzZhT1dyYVJJckdP?=
 =?utf-8?B?Y2FsWllTSTlJVzBZSlhnbHNrVFdVbnJTRU4vY2E1bm1SK09SNHlOSExlUitB?=
 =?utf-8?B?aFlIc2VaM2VQTTNlYnpxcVhYZmFjaDBaeEFLQ0U5QTgxNnZmMGQ5ekFSWm5N?=
 =?utf-8?B?L1AwcW93cklpQnNQakFXVmRVOUdIa1V5SzQwNjArcXhsY0JEZDBSZTY1R2hp?=
 =?utf-8?B?UE1hZzRnRUJ0QWRPb2lmWGZzNEZ1RWoxN1o4M2dPN0hndkVhUjVPU0pxSWtB?=
 =?utf-8?B?YzQ2YlJ1a04yR3pkdmR2ZzF1cHFHNzhRNVVGK0hGYm9Fckl0SE5reVg3c3Iz?=
 =?utf-8?B?bWZyQWUrZXRWTUxGYkhjSS9IM3phY0tDVTJCNE5laW5PdVJNOXkxeTUwOXdm?=
 =?utf-8?B?M2NSd2NkNkRlLytCSUN5b2xQUjZkdU9PM1daR2ROYTE5am5nKzZTYnhSeGcx?=
 =?utf-8?B?MzIvK3pacW1TRXpIT3I2WWVxcnZ0Um5LYlBKNTYvZld2amFVZ0YrUUhwV1lF?=
 =?utf-8?B?RDRROTExZzhiT25CNStCTE1lczBmcjVDWjFkMTRDNWxEV1VMNXNLc2YvNnd5?=
 =?utf-8?B?WXVIVk9ZeVk2YXBOSjRGM3gyUjBMTmg0L0tvK1RwZWZ6SDhwbDdXQURKOUIx?=
 =?utf-8?B?bG5lbUtsUGRQMUtEaDh2QXU0MnNLMVpFNnJ6MW9hSHN6QTNIdktKTnNFYzNa?=
 =?utf-8?B?VDJDd2c4aW8rK1dIS2JtN2tmRGhyaENmRXBvc2VNS3BQOFpZWVdjektUZzdm?=
 =?utf-8?B?ZVFwaVdsRnN1WUJEQXhWMWhjS29tWCtNWmxJNU5tSCtZRjdwbDlDNnh4ZzFq?=
 =?utf-8?B?aUZDQVZKNENGNkhZYm02UFZzMGsyMy80b0RBK2pkaW1qb0liVmhvZHp6NUc1?=
 =?utf-8?B?dUUyMThhcTliUXhtZGIyczJGZVpQUWJNUjhyMTIzVEkxZW5md0xjQjR1bEhz?=
 =?utf-8?B?QnduZGMxY29wakE4VE9sME11cmVOMjZBVXJlZHI1M0FMRk9ZclBXaG1GbHBv?=
 =?utf-8?B?OEpsNTJKU0xJbmhuNGpYaWN6aEwwb2ZhcjlLdUlHLytZZVNUUWQ2SHZkbFBD?=
 =?utf-8?B?WWlaMnhIOEtoR3ZyNVZjbXdwMkdoT09sZDlmdTZScG8yT215QS9UQTJHQlpN?=
 =?utf-8?B?U21rK2dSME5lVVhWL0Q0SWNnUHl3MFc1ZW1PU0V3WXBSSHFIelRFYktWdHlG?=
 =?utf-8?B?SFFtcWNZOG92L2IvOGNjVVJUSjJwNm02cW9JMEpRQTZIZDU2QXEyK0dkUEVn?=
 =?utf-8?B?enh2TUUyWmVxOGx6NEtBUWd5WGdQUmN2dGVsZC9ubXE2NWVXYmZNL3lZbVhC?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4aaef64-787a-4e47-c14b-08db56c609fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:01:17.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAy5npUrKan+2e2zvXRzKMVZwLqq5BvWBKJE2sY8fHZbC+py8AZ2ChcLDdvY1QS2N+11UMjDwAQ1RGupBGf03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6081

On 17.05.23 11:34, Florian Bezdeka wrote:
> Hi all,
> 
> I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
> next/master branches. The full queue [1] holds ~7 patches. I'm trying to 
> split that up to keep reviewing efforts low.
> 
> This series brings y2038 support for select().
> 
> select() is somehow special. Linux does not support a y2038 safe
> implementation for select() itself. If the application needs y2038
> support the application has to use something like the pselect() service.
> 
> To make select() y2038 safe glibc wrapps select() and wires it to the 
> pselect() Linux service.
> 
> Xenomai (cobalt) does not provide pselect() yet and it's not easy to 
> implement that. The reasons:
> 
>   - The underlying xnsynch infrastructure is not prepared for waiting for a
>     combination of file descriptors and signals. (Let me know if I
>     overlooked something!)
> 
>   - Implementing pselect() would require up to 6 parameters that need to
>     be forwarded to the kernel. Xenomais current limit is 5.
> 
> To get select() y2038 safe a "pselect64() like" service service is being
> added. The signal part is skipped.
> 
> The wrapper for __select64() will be added later and will convert 
> struct timeval to struct timespec64 in user space. This way select() 
> provided by libcobalt gets y2038 support but pselect() is still not 
> supported.
> 
> Best regards,
> Florian
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       y2038: cobalt/posix/select: Refactor __cobalt_select()
>       y2038: cobalt/posix/select: Adding pselect64
>       y2038: testsuite/smokey/y2038: Adding tests for pselect64
> 
>  include/cobalt/uapi/syscall.h                      |  1 +
>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 +++++
>  kernel/cobalt/posix/clock.h                        |  6 +-
>  kernel/cobalt/posix/io.c                           | 94 ++++++++++++++--------
>  kernel/cobalt/posix/io.h                           |  8 +-
>  kernel/cobalt/posix/syscall32.c                    | 24 +++++-
>  kernel/cobalt/trace/cobalt-posix.h                 |  3 +-
>  testsuite/smokey/y2038/syscall-tests.c             | 70 ++++++++++++++++
>  8 files changed, 190 insertions(+), 38 deletions(-)
> ---
> base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
> change-id: 20230516-florian-y2038-part-three-3093da9fecf8
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

