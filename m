Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298A3FF1
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 13:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPW5R2i8iVURh1+cibSTGMqYwmBIQSj4G8DSYj475XeTEAlyNpSxMVAde0CgnnrSJa1OSdasz5f59qvBVt/1D9b2fD2jF4VgJxcYzcd+4K1OZsgrynkwsQFDCrLn1/PA58gQYtgl4flzroFnTYcHXrPFO8R3r7UvxSHxEzn3da89B7rKbpJivhf4hgYepcTa7EISUXQoKKEa/kEgXaTdgvdo4VYD89qNYBn16tZTVLzWl82AD91g0dpHnBxHP+Qq7gHYec6JefqI9o0CTUYwn8YI8+yawi1pr3/AKtdTa3adm3mUmirsiCj3Ot1mn8UI+tdQuh8bdt1UVT/3lma6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR8Lxwadw/LfHwZ8ugWrh/MPVVOIYoYbj6IYpjVI/iU=;
 b=Nv258Y7VJ7h7DpXTzU40q/DWnvMhkQeP95Lij06IvZFailNqKeMNTgZ/JQcdm3Xk3eDam9i3cl1QefV191h7vnWgQ6gTtCPklCl5qWhZXWSSVuaKj3sb+HMWMFvbog7UxlQdVuXjBEjh2wEa0C3V6qKHZOCfLmrN8dm8SFKq38/GCeUldpZhfg5Vt0MrIjmA5ixzkoZNpaqZtuRZtgNDrrdeADIUIc0o580JZ/lQR47yhonkY0NzkIGAjHMsgrDbgjKQOCedZn6ykM8Gc91S3TUSjDDdlb1BtZCK5S7wBKIsx5wMY+mhRLwBI7SGpBxlU5f+IuORV0K35GrkNSoMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR8Lxwadw/LfHwZ8ugWrh/MPVVOIYoYbj6IYpjVI/iU=;
 b=KI8GUPfk/uwxOgx/epFsQwfaEhGv+NgAJSj02R+cCOji8UDEQ9ID81pUE9g1ucMSrvQ5kaxNpeV5Dx0emB4+RU78G34uk6ux2BRsbHqN7KlLzRfcIcu4/pAHMb4IXYl9T7bJBdhJ2c0vyAU3L9LYOzsVm6vO8qrpxH9s62fOXbfhWPSkzArc7VGCGDXAlOPTXwK+rf3FWhDblpCI09hq1/h7T67h/jAaFw8TqaTBzBze6mEi+PPfzVoI02Ak6uxNccfK/oj4zMfHf00wlyesmtdMTC79RIxsXgsLXUqTOkZyIWtCH9v3SOeIN044Noypr74rjVfovGpMS2D+19fkrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:362::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 13:58:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 13:58:04 +0000
Message-ID: <962e9533-26a2-4a02-a5c8-21791e86fdf3@siemens.com>
Date: Wed, 4 Oct 2023 15:57:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com>
 <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com>
 <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:610:11a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: dba4db7f-3fe8-4070-b18f-08dbc4e1edfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9jVCrEOpmqGtV9+QrlpGvFpaTGB3jR17QMMETnWZP7FQldvcwJBsRq+c+NbSdGuYmXIIu9rj/X+RQo39u3/kMq3xULwa7Ibx7cCckPjie68/8RHME8GbL56mChknzwt5ZzsR8ZnsIFeZt7Xoic8McUgVNXIi8g9Agl+3vKdRRtzHHBnBQmePSrMkjW5Eu73gKrgT2T8SFfbTcYVnEkcthjRGAz7OpL8CfVsm9akoUmD61ydPgvcQHMGRODt9bzD6Dgv5DgdVA6vU2cWmYEGQfb/WhL+BpmoF1tbno1uQdayzwpMY168wPZzAOw1MEcuIFTRXZon+e7jVpkOV//sPCrvFjVV6PGwoBZpJiwuzPPbs/VUErYGKmGdIPMr6WBOtHpob/DS2H9949yDsiIgXh5Q8jMFhV022P/RYTK9oYZvBMeIJVZfd+8b8hClzKSdxQbNyaNFiLSqmIHS99BeihVIXRlHuFzk9+jNWWM+ODGT044LTqfHkipmTqns6jvYt3g4L/bSjKKrxvjnN9sI50jW3Ssg9kMpTBhyNzgKS78ApFoZbVnr1uL3/onqAUbWdXFB+fIqXkXbNaSsPWp7dDkcLCmhh6QL1p+2p0uJRbK4iasz2O3QSxBwYCwHF9CMHnqWlbgHbynJ3L533/1qGfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66946007)(66476007)(66556008)(316002)(6506007)(6666004)(6512007)(26005)(2616005)(478600001)(6486002)(82960400001)(36756003)(44832011)(5660300002)(41300700001)(8936002)(8676002)(83380400001)(31686004)(53546011)(86362001)(31696002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW9VR3l4UE9xV2ZTUXUwc3VqR1dNR24va2ZpSGxkeEFFOTRFQVVPY3Y5S3N2?=
 =?utf-8?B?RGVlazNPYjhGb0ZkNU9yWXAvd1ozUWtYVkxrdGh5aDNVaHRkTEZod1lTbVZi?=
 =?utf-8?B?UlVNbHp2eXU0Ti9zVEpRdERocG85ekhJbDVjL3YyRTZrRUY3MkUvVnY1cElM?=
 =?utf-8?B?Nit5WiswZGx3UTRjZGsvV1FaWStFYmJVaXc5a0lQSlQwamxsN21TUy9ZbXYx?=
 =?utf-8?B?YzZVQms5MkFrc2lqeVM1VDRzQWl5SDZXU0c3ZmNNL1JUVlVhbXZ1VnhLVVUv?=
 =?utf-8?B?dEVBS0xZUUZJaFdlZTZ1UG1lWDRhalMwbHZZTWhaTmhON1hiNzVVYWRMMHZa?=
 =?utf-8?B?SkNVZHUyWkh6T1JlRFB1UWZwMjBkYmFwaFljZERXRlJPY0pPMThtV3hoSTJN?=
 =?utf-8?B?UHhqR0dOVXluSndsMzdtOEU5L0xNUzN1ZWhFcTl0SzQvVmZaNksrWXBqZkFZ?=
 =?utf-8?B?LzFLQk1MOVk5WkNFK01UcnV4S1ZEaUhVQ01kdVk1M21wMm9LMDJnaTYwK1pI?=
 =?utf-8?B?M2NQV3VnaGc4MklNTVVYVktLbkszRms2REN2djNVU0owdVM0Yko1TFdUTjhx?=
 =?utf-8?B?WHhpUkg5Y0pxRWR2a21UQWd4SFBMTHVaWm1KM2Zya0hXd3B3UFlUNnpUMFFw?=
 =?utf-8?B?cXRLV0g5R1dnU0VBRlBobDNkV0FJNFdnd1YvSFlhYXoyRFo0NzBYSEFnbXRn?=
 =?utf-8?B?aHVVWjROUnFxRTQ2c2t6VWtyaE0xL0h0QmxYY0d5UHE2V2lzaDJCejQrbXhW?=
 =?utf-8?B?a1F1RjFkYWlISG5zRGhZUWR3MU5JbGI5UEFBWlFWSHhLN1VCdVl3eDNEcUEz?=
 =?utf-8?B?TkVGMHR5Sy92bGU2OHN0VWxrS0prY1dxUWhxQ3JVOW0zVXBvZlJZcyt5QVRO?=
 =?utf-8?B?OHNJemZaN2VJa2s3Sis1TFpRTjlMUnZhRnZSRk5rN2VSTnlkODNmS0dISG93?=
 =?utf-8?B?WWFlZDhuOEhISnF0UzRPWkJnVWQ1ejBtbGVlWTI0MGk1ek9vczRKMm9uZVNH?=
 =?utf-8?B?T25aZllTdzAvc1ZudVVWM0pGNHIzT2puS0ppTGRlYzFMeTNCOUNlS0FMZ1Bh?=
 =?utf-8?B?MGpQbExvdmQwRFZOUmg3OXRVZWdWMlRCb3EwYVpjcE1YYTliamJGcitUVE0z?=
 =?utf-8?B?WnlrMytZazYwZ0Y2NjBsZVE3ejJrRkZsb1BCdnZkZHplMC93MjFrdUQ4THFp?=
 =?utf-8?B?bHJ3T2Y4NCtVM2xUZDhqL21nUWptRHdQVnc1MnhEU0txdmxVYnExeUx4QlBo?=
 =?utf-8?B?VEZib2JOWXNONFhZQkI4N2RvQ2JkTXNlRTRza3lLWjlKQ0pETzl6aGxBVWMr?=
 =?utf-8?B?U3FmekVGRXRoWlhFdFlYcGpXanBjZmJKTWxvQjJsOGVtMWR0cmNjcnZVRVh4?=
 =?utf-8?B?bWhvQUlIMUZBb3NvU1cvRnprTUFHNE9QSG53anFZWlBWNmNFcFdXczFyYXJ1?=
 =?utf-8?B?aG1pSlpvYmpsOTJma0h3UVJXeXNoY1FOTytQdytUdGR5ZjlvRjEyYmNPMkx3?=
 =?utf-8?B?bWFXUWtCQ3pLUWJXVzhHQ2RYZ3QrU2JpZ3NjN0V6cXNSTDJXYUVXanB4aDFh?=
 =?utf-8?B?WDFJUk5TZWZzWDByOVJEajhXQ1FQSHVpS0d5b2hiUjFFOXFQZzNHVFlaRjZs?=
 =?utf-8?B?MGgvcEJGanB1UldadFBBTENPQTE2T1pMZWovYUhQcGV6bXRjbzNWVVV1VVlm?=
 =?utf-8?B?RklrSDNubDVGSFh2RVFzaHBaY0tpRXBudTkvRFY5cE0vMUdTS1RTS21VMGll?=
 =?utf-8?B?Nm1aMk5RSEhBVzB5Mmw5MEdpWitkY0dKR0xTdlorMSttUmZ6dmQ0OG1CKzRu?=
 =?utf-8?B?NVF6T0dLVjN3cUxPTDJXUVlvWWJVZkNPQmxJRU5kYXRyZTFnWEdkcmduWE5r?=
 =?utf-8?B?YjZqWWQ3aG5YZWo4TDdVUlE0UmRTM0p1VGNxbXN6RktoN1l5WWRTbS9Ka09W?=
 =?utf-8?B?aGs2UUV1dmlYVE44RWhoS25XRkRyS1BzQlhXVWgyelV0emRRdjBVdWcwcnk0?=
 =?utf-8?B?dGdjdWY3WnJIdXVab3FtWEkyWUtiSGJKZndTYUVWL0k5ckc1Z1FsZGZsNERh?=
 =?utf-8?B?TTVsUE9laDV5aysvN3Jzc2VNQmt6cDhGZW0ydW5sdXZjbkpFQlJVYXpNVTF6?=
 =?utf-8?B?TDkwaC9uMlI3ZjdQenkwN2YzUzRoMlROLyswMm1RYjJiOXlpQ0VtZUxndzRu?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba4db7f-3fe8-4070-b18f-08dbc4e1edfc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:58:04.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gmDtY8OBk2tcAB17sIwbnT7+zaheOHkVUhEyPyVvIvQiX9lUmFbxGNT6fZr0pvUx8NMt3AeIbNu+8Ep8IkJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7772

On 04.10.23 15:01, Per Oberg wrote:
> I just had another hickup. This is 100 pct reproducible
> 
> To get it up and running I had to remove rtpacket,rttcp,rtudp,rtipv4 and then forcibly remove rt_igb driver and then rtnet. This gave me another set of errors, also listed below. 

What does "forcibly" mean here? Actually "rmmod --force"? Then you get
what you deserve ;).

> 
> [15018.436248] ------------[ cut here ]------------
> [15018.436249] [Xenomai] switching rtnet-stack to secondary mode after exception #6 in kernel-space at 0xffffffffb837064b (pid 1438)
> [15018.436258] WARNING: CPU: 0 PID: 1438 at /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x26b/0x2c0

You are not using the latest release, not even of your stable series.
This is needlessly risky.

There is some imbalance in the reference counter for the socket, and
later on are complaints about leaking buffers in the pool. The real
problem may rather be that you didn't shut down the interface properly -
or that we don't do that when pulling the plugs in the order you describe.

Can you reproduce this rather generic issue over latest master as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

