Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D228F9
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 13:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXiuqjBrrhfjlmmhxgprT5YixGocZSFsny8ZcvSPdWYLVdlt6lGZkjN2ctCNSX7jEzEeBmZTQc+jXMpnVWsy20v54TIbnKgXgO4objfdKCzbb3l8cJPNAwdckpeHiPwmZUHkEOOqDQnFKEirmetDxbvEYazcL+n+o2aWGdXYiMVY1Vw8PbY/YSwnMCyEkUljQEaNpkSyMKaWsZQbUgD7oEQ3QzocJ+ASlz6vFNHyl/Y2eh11dQaB5aJjEqc+cJQFUnd1TErseduDKYQSQg1RXC535sFgQGSPUDn21d2UtaJ00m2guS0OxKmi7veGpHeLRBOhzUAU+cUvKKXmws9mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zjUvSdD+Ut3TndWTjSIqsqrFJp9lWdjuXkEGVhj1yU=;
 b=GCzWcNe/t66g5ReERd37NaBaUceA/LysTd60oXuFWF1H0N9MiP3+5A+VBpy8wNGMjHEuTBFacHRY2bFFLaQLi/su+b1WY0TwRuWumLv5gXRoDqCC/1ViPs1O8x73hwTFDeGAZz+UXPhpXB2S4g8Zo6xYjZNcA088QcLT8ONiQIIt7SIeauqf2glRRcqugejqZGpTQdpqcFdMVR5IovdAI0z/GJ27EcCpvsFBf4O7/+Rp4FGd/9ONxc+yjylPYYk5nDPkSGh2wfhkMw2/D9mB4kxqbMweHbrhS62rGk3UWqvAFuYAIY6EgcN/BxjWfovHi9XZ1gGIaDE640kL8pleug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zjUvSdD+Ut3TndWTjSIqsqrFJp9lWdjuXkEGVhj1yU=;
 b=vDPqgEZExXaGzv4FenWc7dSk2X1QWTeeNhZJoY15RLN0rsuAr1Ev9RHGU1J+IixlCqsaUs5Iv2V8mPR7/oAgfL83lbJHgR3new0/p1OdsToLsDdaJjKHYR2nCVqqgWs02vjwmNQP1HNtL4O0e/ywTwFKAmeUzQxjJhW9/lulo7Xft86+WIix7o6tiZo7vbt0nfysjNdZ6EsedCK7aMkKM7Rt7ugbPtc1uTQXZ1ypOgRi+qLV5XY1ZqMpwBhQ6waUbgCP5yr03Khxv5IaRQxfgnZp16cTbJWzmI+M4f3tovvHEK3IoRpRlzO2/Liowcx1z/ZE0TPJq+1NBAhCMq+ijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:52:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:52:53 +0000
Message-ID: <e7e97c32-31a6-867d-f888-322703b06886@siemens.com>
Date: Mon, 12 Dec 2022 14:52:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/3] switchtest: test different migration types
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaeb0ec-e56e-4c8b-372f-08dadc482a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	viQxPOq9+3B1ddvZShGTNf9M7wi2lBfYukxKfk953k9m3V34dzs432Cc+UlVhRC45ObBeLPdBUwq1uRNpkiAnGMRS7l4FK5jPYcnyRyf25xuTzshI/1gibP1H6pK1vDJcRQMKlMIckthr1ycGC1nAp2gyZDzuPWfIFdEfSnGhhZy8eqxDecm8cakFClIFU60AH/ZAligu8DRTasQjvIdLape2Zq+geN3+NJIE7WWpoU7sZHFE01Dcvmm0l9+t+7sPU9GGqhKtlmLsrCYsqoWir/6HUTf4c8lz2hdovbGnjT8kirgke+npVo0qiGWI/uAoqR+7yZ67RuQ70bldo74XMXZh8/4fnuxZiVDr5nFlIXUuN1BAtn+HRTrgsoqEC16ONZ2xkA8IyWJg1loITyCitYwjBV5DLBWvgQCQw24wo58S5mEWukqjEXkicZshiRpnRm6R5NtPPdXKVxy3UWqyD5id9pay10a6gKkcz5QEOfrb1LfpmPv1lToxWl62aqihkZLZSJKskSra8x2XNF2fwW8ah39Qw12n4bN0n5Dm6FO318RHE3N/2D/fFhlngN960kc88Xa6dRdWybqk33gC6HziIwyD2ZlGjKmjxu+/38Lx2/wwUu0TKQEisdyHGXejXl1p/OB1Tq5Pj883HEz8X2Gd7VDgVY3nyYH0g7pPXsv3NyBk2avugjyX0DJB6iC9YmK2IFmKinLCSRMd+C2ny5iMiRa5UkAVLt8yml+qGY/wqzb6jeiwMMkWICofJae
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(478600001)(31686004)(107886003)(5660300002)(41300700001)(8676002)(4326008)(6486002)(316002)(2906002)(2616005)(36756003)(8936002)(66476007)(66946007)(66556008)(44832011)(86362001)(6512007)(38100700002)(6506007)(53546011)(31696002)(82960400001)(26005)(186003)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFLMjhTQndUL0NRRHJVd00wdkpmNUU0NWZsZTE0clFnc0VxTEpWb2NlYTU1?=
 =?utf-8?B?dkxXa0VabVE1R0NsbS9sME9kYjdKeVhmWWFRMUFnSE8wbEIrbFI0WXI2NXVT?=
 =?utf-8?B?d1U5TWFPUzBJWUxFaVJkR1A4aXY4Ykg1V2RyODIycmY3MHFFeXNoQmEwUjB4?=
 =?utf-8?B?ZlZvRDJCeExPaU1MRlJwRzFYbUs5ckpDNVpmUDRlc2cyQ2pQNTd3OGc5ek9G?=
 =?utf-8?B?WDZSR2lVUzRkR1BnbW85SlV2enJRUVpmeHJ3am1oSnQ3ekV4bi9HeWhtUHlC?=
 =?utf-8?B?UWR4d1BIdEtySmo1OFk0b2NqTUU2dEYxWXBFNWpsZTA1K0NCL3NVLzRGeXZN?=
 =?utf-8?B?Z2w2bW1xS3BVM2tEekJGRndQZUJTZVpqV2U4VzBQdmx5aklUdlFLa1dqMWdn?=
 =?utf-8?B?akRTVVhPQllQUlNXazhOODcrRUczMjF5TURlVVduQ2NTY1drMEFuMERicHRu?=
 =?utf-8?B?T0szb2N6TldsN2JpQmhzY1dqR3Q2WkRKOEQ4VGJyQ1RFUGh6TUZRY0FZZXRL?=
 =?utf-8?B?SEhYNnBTd3JpalhtVjUyZGlFWDBBRTZ1WDhsVTlYMTUxQUtvT1lGeG53bHVq?=
 =?utf-8?B?ZXhxNDFURzZKMVZ2U0pBRWhDV3U5ejRBVUE5clZpWWhjZC9WdHF5UW9vMWJO?=
 =?utf-8?B?ZUlaMFM3bWZOdGxTcVMrcTA0TTJJVzh3bUY3SzhEYy9LZGY4TDZBN3hPdDQ5?=
 =?utf-8?B?RitzNGNTU2lBNy9sU1V0QlBtU09CZzZhakthZVZEb21VdG03TTB6TEY1MWtN?=
 =?utf-8?B?bkhzSG1EaDdxZDFGdTZ4SVJibEVXaDNycHZoSEwvdGhWYWljVnVCU2xlVmJl?=
 =?utf-8?B?UG5yU1RXTUFETVNoN2tYMTJVaWdXM3JBRGRyWUJhSi8wVXVMUURyKzE3UTQ4?=
 =?utf-8?B?bXdOZ3pObUtzOEF5dDVSQ2srQmVjS3J3WXhiWEhVM1M2WWtyOUZwOUhjMHZI?=
 =?utf-8?B?NzNpRDZiVTJlVkduZlJTVHErTmk2NWlrbzY1L2wzL2pvTXFkc2NOeU9PbXd1?=
 =?utf-8?B?eUNZeEd3NlJVTGVzQzhpcXdobHhmdFIrRHhSTUx3VGN4dytEcFJQTTZ4ZmJX?=
 =?utf-8?B?V240MUZ2WGdTc2VGb3JzajBJbEFIS0tnemE0WkRKRWs1ajBvQ2dIZktzZ1Y5?=
 =?utf-8?B?Z3BLVlUxVEo1dWkyTHNldHJOVGNYUTR0WTVLV1YwaHRXcXZtS0QzZDU0Q3l2?=
 =?utf-8?B?aHlDSXZxOFU3TFhuY2tCY1RjV2dlTjdibWlJS3ZPVkJPU0NTeEprT1EydHN6?=
 =?utf-8?B?WXJDellCaDE4dmdkMWRHeFhOVmVxQ1VGTXVMeVZKcjlFaVdmNG1rQ0xPa2Jp?=
 =?utf-8?B?UUU4azhkOWRkUFMrdEx2UVFibnJMbThqbkcraUM1L1BwdVhtR1N1L21MYk9X?=
 =?utf-8?B?TmJnUVR5WS9TeTBVV0dwWlIxTCtkOWQwS2xIL3hCaytpQ1hsRlQ0R1VIMFBh?=
 =?utf-8?B?OGxvU1ZWNFh2aGVIZlBzYk1YY1VYbEZYeFdxcUllQ1E4OWJ4M0wvdXBJeE5r?=
 =?utf-8?B?OEFvSFVGSEg3Z2pSR0hJdjVNYU1kVVEvREhvQmtNbUFtYm12dncwV2RZSzNI?=
 =?utf-8?B?NmRjdEtvSGpVV2ZmeG14Y2pTRmRXdFFhMzNnWTNFQUJnYyszZFJTYVdpTndi?=
 =?utf-8?B?NzE4S1c2YklFdS8vM09UV3dJemZlZFpWd25ZSUkrQ2FtdkRFMXdyaFhUbDFS?=
 =?utf-8?B?V3h3MTJJcDdmTGdTK3JNTWJPczdmTGtNVUpkKzFjTHJiSVd6dy9xT0FncGkw?=
 =?utf-8?B?SXRTMDc5VzJ0RXVETUNXUmxCeHpWUGxNY2RhdExORDhxN1N2bVpxK2d5WjlW?=
 =?utf-8?B?K1FEV2VsRTlQMnRCbFdsZHFJcDl5a1o4clBhYkF1UHE4TzFTT0hvbFN5RW1X?=
 =?utf-8?B?R2RnV1JvNmhmMDFxYlBpYVhWNFRuUXR1VUo4NHdiOWwwaUh2K3RaUkRNOTlp?=
 =?utf-8?B?VkVRNnl4ZDZSTlByVTloZjRTcDNuQ3ExR1FYYnhXN09UdVBISTJoOHRGQzlH?=
 =?utf-8?B?eVkzNkFxL1VRUHN5WmZGRmlRT1ZLZHp2MlVna3V5OGZrUWpjYlhZQWpGSVd1?=
 =?utf-8?B?ZHdFOWVFR1MrQ3IySUZ1MEp6a25qbzZJSE1vbi8vSjlCMmN0Q0tnajljeEJ1?=
 =?utf-8?B?dWVFZkxqT2t1cXlqVHhqNHRQMjUvYkZ6R0RVQzkvZWpuMXV4WFp4OVpKSTBO?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaeb0ec-e56e-4c8b-372f-08dadc482a6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:52:53.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO/3kKc/NMnoGJtk/2SiaWcIJvPA/VsYfE71zmA5FFgI6+ti3t/ZynjiIotNqgLlYXySHPGvfmS2uAfLneSioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6381

On 12.12.22 13:16, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Switchtest only tested intended switches between primary and secondary
> mode in userland.
> 
> Let the rtuo thread also test fault based migrations and migrations that
> occur while in kernel mode.
> 
> This patch series will also test the bug that was fixed in
> 829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5
> 
> Changes since v2:
> - Fix style related comments
> - Improve commit message of patch 2/3
> 
> Changes since v1:
> - Squash patches 1 and 2 aswell as 3 and 4
> - Call the correct rtswitch_to_xxx function after mode switch in the
>   switchtest driver
> - Only switch to secondary mode by using a linux syscall or by a call to
>   cobalt_thread_relax()
> 
> Tobias Schaffner (3):
>   switchtest: split the set_mode method
>   switchtest: test multiple secondary switch cases
>   switchtest: test mode switches while in kernel mode
> 
>  include/rtdm/uapi/testing.h         |  10 ++
>  kernel/drivers/testing/switchtest.c |   8 ++
>  testsuite/switchtest/switchtest.c   | 143 +++++++++++++++++++++-------
>  3 files changed, 127 insertions(+), 34 deletions(-)
> 

Thanks, applied to next for full testing. But it wasn't based on next -
had to manually apply patch 3...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

