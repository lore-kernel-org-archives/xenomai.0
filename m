Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7026FA2
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 07:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNB30OOLT188xw46EQ0Dqbm10eYavZ874MqhDG90wV0yVxNpXc1AiRaCAJONgPDBjuxOxulggjZe5sZiwc73RTMIppHJqgGiuoon9ByGwaEgIPFdmK8s3sXtvGe9FTNJELPtMitZmKy0sn5dDSWKh2HCvXieGPTSj3eJHcxpUAo0icaNzyZOf3vcK+Tf56UFgcjjTDrf0wLl70LuEZtQzwJdrGT0RoyFLBV6XoglH6CuH4WyfHCJa+nRWaeM+MkqVyEqza9cd5MiVjGOzERkU++f9IfzXhTbRcwgyXQPUOfVQsukoPMlQ+eZfK0a1XrhlwEOqNsoCOC3y/dFJu3hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq+cgeLy2TLsoeHLVmoMFegwRDefoJp5momXfhtq6fY=;
 b=GmwD+Ibb7MXK5ky/K1K0yKtVW7Z/WLkjiibyy7NcSG6jfS35n48MGtTohJUFpbHLrAPI7RvLKQlGNvaagroaAiWKN66RwiGzxcZvyCYeaEn76wk+2B84EmpI8yBASto+MLrpY5J0LFGjfCantElJ2USUrthzCFLKTALyZhlxhEGKEaEFLR6NY6gmQiIoN34qytrg8enl+W47hvCf6gAdv4KOILjVEhJw1lHNgFqj6WkjFyvn1Kg526bNO4nhZZwCZ569Y4TrD311ob+IOXoU8E3Z+qAUPfU7zpNZV9L+6D+wHuAr/kgE+jqRUpjk8mFqrC29d2GQ5Y1RCNHe0+iZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq+cgeLy2TLsoeHLVmoMFegwRDefoJp5momXfhtq6fY=;
 b=b6XPfmKexI4oM2ZKgInkuORg1Sz/AYf4hqkk/wgAubaYywlCHxQab20SvIOzXmDAgQDDmvZI07P9mCDhM8IH9Wh19ixkNbHzCP2ji9rwNoj/x96xfgJUgLfbuNRnu+zQFeF/RtiXRgxDj8ujQqfWpn/WdpV9cu5sihJ2cGc7lOM6g4mPBOWkjiQQnmOqNqv7RNkvJbgMHBg01MMJugS0xk8/A+ikbohAYvSt+ynnG3xsfU97sOu9sQ9w/DAkfYwvwmDDjInNACKoysfokp864WDSFbm/SeQrQW+P0kG5GzqStfJVc4LhZcAps2GecWwW7fBZOmAEYLfDSX5o6TKEwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 07:12:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:12:51 +0000
Message-ID: <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
Date: Wed, 17 May 2023 09:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Meet-up around EOSS (Prague, end of June)
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
In-Reply-To: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3224:EE_
X-MS-Office365-Filtering-Correlation-Id: 457e093a-832c-4397-f74f-08db56a620ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rKmoiDB9lrfI31pGXlufeIQqG62dg6sT1Ba2xh5ihQ7ZBJEPDIo/7TOqkODpE2K7YUO628EHXm6zWXaNTnKjBJiXRYfvtkA4amxsSKGNlhCgXIAvcB+d0Z29nwa8xbAOgOS8m/OYCEnGQoT9aIrxfeuBfW2DLU5tiP4KPZZbLwrka6HgtBv5PzR+35U6dHY6ZzMGemGcL8E4xYLu0qS4qKdpara/Qvyfcdaau1B4+J9czrxc3EcVTdsvt8UYPegE77qx1lik5iln0kmnBJmih70aR/z+B5NoirkwkNS9x/Ic3OzfaFIsKfw0+byB3YO2AB3cmWJfFh9Ep0YxjTRb/9YquUD0GFYpaFIiui4bhZNPZHFzNvzLnDaMlca2odu4ejLCV+SPK0XhFP2GQo5YzuR9BDBAKVhR2MP78zibslqD0B3DvfEWimTEwfCw5EJMkutQTTPR5JVSQLIcAW8V4icVPUaJn+cWq8T9K6SEOxWU62SFgx/oluqMNhum8tvOGhh0AScHut4TSWET6dUARAOauo1TztiLzWm5ihxSm7vwm3lTelAKzz3LS75R5GDImcpXAfh3SqbsOnshHwGWXAKEzQE2vutzNvnl1iiIAe09nB+L5MI9Or4CfsbzR5qisbgNaeCUeml35hxaWodooQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(31696002)(8676002)(316002)(8936002)(31686004)(86362001)(66556008)(6916009)(66946007)(66476007)(44832011)(38100700002)(82960400001)(2906002)(4744005)(41300700001)(478600001)(5660300002)(6486002)(966005)(36756003)(2616005)(26005)(6512007)(6506007)(53546011)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhYWHZLdW40V2ZRRnRJbXJqR3NPR1gzelZCTk9GMVc4ZlRoZzR6MW9uRUJW?=
 =?utf-8?B?cEd2VDNoSmN6SDZtSFE1ajI0MktvU0QrOXpNdmYyQVp4UEs0TWdmTjVNcHpp?=
 =?utf-8?B?ZE9KSG9UdzBGTXhGaG5wNkZiOTBtbXFtV0lHeGtHekJsVkxPelhBZDVLNGM0?=
 =?utf-8?B?dXQxVHJ0WEx5ZStFZGdpNDg2azZUWjMwd3pDUER3Ym5XTVZvam53d2tZVnhk?=
 =?utf-8?B?NzdqZzR5VC94YjRDaWNXR21wYlc5YTRHakQwZkFEZkhOM2ZwTXZVYlVqeFph?=
 =?utf-8?B?RzdZV1QweGJXYTh6L2NnT3pxNTVpNTJiM0JKbnkzT2plK01xMnhjOUcwTGlV?=
 =?utf-8?B?OUtoeEFIWXJ0TURmZ011d2dCSEZTNlkzc3NBbEV6ekt0UGFqR29vQjhicStz?=
 =?utf-8?B?bDNYTG8xbTVGL0FBT0tKcnd2dk1BSUp0Wlh5SjV3SjhOdmdwWEp3WEdqL1NZ?=
 =?utf-8?B?aHhIbUROMFgvOXlydktsOUFPUk5tNjVBTVNtaXpQQkV6QXBvcTZ3Ly82N0Z6?=
 =?utf-8?B?cUR3aDZSangyc3JoRVZMNmo2MjBCSXFlZkdLb05CNUdhLzEyN01yMEVGTFZn?=
 =?utf-8?B?ZzFsNUlvOTJFUlRyYWI0YlpsbnlsQng4V0dKRGJXMzM3dG5RaEVBYWNVUGxt?=
 =?utf-8?B?NzJtZ3Jvc0ZCYkJWUDdnVzFJNlVRWU1HZHhSRnRUWnJadlkzdGdVaFZqM29l?=
 =?utf-8?B?NkVIVVBzdHZURDF1T0s5SFNTMWJnRklIYjdrMVVrd21pTEVKRjhDYW56M0Ra?=
 =?utf-8?B?bFVjRWJMOG95VEw4WGZycHRVQ0gySUVJazdPSlk1YTAxZncyRTNjUGMwRlJo?=
 =?utf-8?B?RG0wcXlyOUJIenBQVU5DOGx1TU02VmRWbDJVbG5ERVlqMmM0cGZ6NHc1QzVi?=
 =?utf-8?B?Q3FCUXdCZUNUMUlyWnVkZVlwZENNQzFUd3g2OUFHbURNMTlCc2RpTmVwUExx?=
 =?utf-8?B?RndCbzgyckNFd25PRXFQd3oyQ3Jya0M1QTg1b1RwVS9yVWxHTzFidFFwdU96?=
 =?utf-8?B?REFmTXdBaDNia1RGQ1N0dXpvRE8zSS9tMEZYQ0pRdUlablJvd01BRy9kbWNK?=
 =?utf-8?B?cllmNjhFOUhqMEl4Qm9lRlFXOGZCdzVUMjFqejB1dFhNRVVyZWhjV0NuNGpC?=
 =?utf-8?B?MDVUMDFEUWQwN2lRM0cyRTRhQUtYQ1c0Sm9wM1dIMUVrYVZkaGJ6bFZab0dt?=
 =?utf-8?B?RnhBUkZOdzNnNEtRTFVYSFRweUg2TitWMTdqUndWZnVsMy92aDVjZVpvYlNt?=
 =?utf-8?B?VWZ5c1UwaE02RGN3b1FjUjJDUmJxV1RJK2dWL3FDWVFCWkdvWWt3ZGkxWGx3?=
 =?utf-8?B?TjMwMlVvTnRUNlFobjhsTTd1Kys1aWhXSTB3OG5xRkhudk4xbGhVSEF1QS9N?=
 =?utf-8?B?NW9YMGZjeXBuMk5XSTlaNzhHMldoR3Q3VnhsVG1CN2lxQjF6WmMvTGVPK2M2?=
 =?utf-8?B?UkpSUVIwVWVDSnNXSGxMWDY3RlFKUnFDa2N3L25FaXZtL3hPL0UwajJyNmxt?=
 =?utf-8?B?QXh6bDZYMlNJbTdNZ1hhMW1FWWdKU3ZObTAwc0IvRDJwTHl6cVowTUpuWHE0?=
 =?utf-8?B?K2drS1QxWE1kMTZnVUVhUUdHK0k4SkUvUFFmOE43NXEzZnpiSVBIc1FGanVW?=
 =?utf-8?B?RDhob2dHTHNUWnV4NlpwcW0rR0lKbG5vVStFSjZMRXlWKzRzbllJL3JrWmc5?=
 =?utf-8?B?cUdTa1dWTGlyNEdxbXBES2h4NCtlWXVZNUJwd09zQkY5VHY3RThCMXpmU2Z5?=
 =?utf-8?B?eDVWYldsQUFaODd6MzhtYkpGS2EzaHRYMGJ1enM4djFSSGlrUVhPbjFnODNi?=
 =?utf-8?B?NnpWcXRBdmtjSlRzS0ZBeXI2eUtsalNpNy9INkVBcElseUU3VFM5ZEIwcjgz?=
 =?utf-8?B?UDhYV0VtakxJcUFXSWRrKzZEYnNVaW05SGVJYmJmVWF2Yk9ZNEVsQUtsYVAw?=
 =?utf-8?B?UVdvenlNMC9Mc2FtSFhiNW1sZDdpRTYxeWxESS9uOUNIWTNMTlRxL1hXZ1JF?=
 =?utf-8?B?V080SjROS0huL1hwVXJnMVUxL3lwM1dBcXZlTXRSYlNzTTV1VXhzRHJoOUVo?=
 =?utf-8?B?RHFSRkN0NktmczJFK0dSK0ZsUHlqWkJHQU9TTWdZSHFzR2xVaGQxTzZheFRC?=
 =?utf-8?Q?NBc6/x+viak0XzNKXL3igNeZG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457e093a-832c-4397-f74f-08db56a620ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:12:51.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jABManXJUj9OBpE3HrYqT+PXQQ2D2A3vfsBOM2d3rVG3pxFQSX2fDxscQYciSN6mASpZECCl+j6ZSzTp1JqioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3224

On 22.02.23 08:32, Jan Kiszka wrote:
> Hi all,
> 
> as just discussed in the community call, I'd like to propose having a
> Xenomai meet-up at or around the Embedded Open Source Summit in Prague
> this year [1]. If you plan to go there - I do - and are interested in
> chatting about Xenomai topics face-to-face, please let us know.
> Depending on the feedback, we would make this more or less formal, from
> looking for a real meeting room to defining a time and place to have
> dinner and beer together.
> 
> BTW, the CFP for EOSS is still open for a few more days in case you want
> to talk about your latest great Xenomai project at this event.
> 
> Jan
> 
> [1] https://events.linuxfoundation.org/embedded-open-source-summit/
> 

Just a reminder that we sitll plan to have an informal meetup there,
likely in some nice place for dinner and drinks. Besides Richard, at
least 3 more folks signaled to join.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

