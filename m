Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80B1D2A8
	for <xenomai@lists.linux.dev>; Tue, 23 May 2023 09:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G27gs6Qnj2FOFPQLRcWvdsYoNgAbuJ6smLLfuF1YwFrYF8AIttaV7+6XMV+iZzfUNuBe7+ZbELlbjl5Pjs0MJlfzZkL1vBsIiSJ+GngxUvM4RJux+K8QRlbu04Q28FlidN+UfitmL7VsrBXu/OAgkaETMn1FkvJ8aGPekV0nOEyYoCOOMzZULYUZyFFEx84M44xr4dmPUwhVx4fhI0N0C+Bb1cmFof8DUbxsGkP3prcEelOSo2vHVRckZfPE6QqsUs6AoTGdqnQX2EaijqKNgUmH+NosQtWfawu0PPnC3C16emlKbFkbmPWVS/isB1vUz2jyZLYMVTQP7+TZDk038Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvyzRJdU21M9Zl9FqdZqJKsr+H/66swSc05bMAraSMc=;
 b=j1uswHJxLcl5zl48xB+R+azhPQvrHH/0+B/Xv2+u7VRGkS9Q/mTxSTw/X9WaKaL1tiobe5Ud4wePUaTbg2E4lx+busbdp+0cCfRA6dXxTRVZZrTsBOiOGILeLcA3oqM+ZVuzH0YuzLGlwfp3bwDgIYsH8TzR4jMcvEmQ8VK+30ifHp0ynPkrfTlmnJJZzcR/ZjTt1GzdrcsyN0HFXdrf+SRWH1127FRmYhYoe8SJTnERvAR9ZyTUqPFegUCV8yo2PTwl/YB0hZ4WFi7ub3S/RsCQK1fKBvDgqdOA/eNnhcyux5zLxhh5ntqVQlBP/W8pPDXN+5hf4L4HwolPsuNsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvyzRJdU21M9Zl9FqdZqJKsr+H/66swSc05bMAraSMc=;
 b=uD+dcy2LtDPN0vStDZAlytwAt20PMbXinOYBJlFrC6woEkIlrizUUC2BX49AygDle3Osvi0Tk42JC4LZIPWB3WnWkmT2ViHhr2SFuevA9br6SMDSzQcbpkDzkynL3vJVHmoVbWRQIyca/SmR0hHTG4TZxTfYuCxptxOuaalwOKjRInOG8FyBzxGMwEPwRypQ+nId2RQac7SeoKClH67idYEpQMDPk/zU6dpYSR23DydafdG6+15KLRnL61TX9ZrkwLSSQGcGsUjCuxTQtHezJow7bhLEfdG/dliBo1vksAWHwYyXTb3ygp6tO2v5XeQxEFSIN+F+d4OoQRzpFJIMng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB6256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 09:13:21 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::181e:c26e:d585:c80f]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::181e:c26e:d585:c80f%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 09:13:21 +0000
Message-ID: <1dfb3ede-f16c-2bbb-c794-fa941ec10fe8@siemens.com>
Date: Tue, 23 May 2023 11:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] y2038: Part three - support for select()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
 <7e217082-c9a3-b834-6c8f-41a456e5933c@siemens.com>
 <3603f7e94608b074bdafe486f6b212201a8389d1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3603f7e94608b074bdafe486f6b212201a8389d1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f67a6b-802a-488b-1b82-08db5b6df43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQUeVku8vrozbx4bI81Xv0sX6O219SK75v7taS3sG7CJ3IK5yM/1AqC+nfD6+hwRfF85n4AAG45iisFXK781Sb7wD60n3qY8scrsF6XM6o/bklplxhC7WpbHNrvMU3IbDXckl6prRBkl2G0kOewkqVM+M4bhhrhNXsZqRh7+XnE6998ISPbfUpkStp1+S9fi7lhlig+KEPfsWWDsOnOw/plKF8jbmqrtbzaNXCjVyg3qxp5BgBs7rpHo0PNbCI6eZ3YcgV/W/ptmuy2pNtbMDvAsx+ECso4Z1Xs/vrjlc2oEYuMhAmSB/uYdqFT6DZKFKKoJuLREe0ftFxNYsg2fHSNaKYnvc9vAfyzxzb4ui619jr6BCv+t6oXMEY+tHqf97GH1SE23pYKRa+RBNlDnWLmVBLV9p3UR4oZfHXkFUOTsQvTkMulF1a5t6AowD3fu+lE+a4AlOrAV8VcJDORxpPkIBAYQvnxfDSnkDNaGIvwKcNFcX0LbLRlPEuwwCNOescHCibuLVw5jp46ew1Yjst9KvkvOVfKwraC4xBGnJZNP+3fNtQju2a3XudPYPrMvq65GtfBOOLOuRFpOOh1qcHQ7SyZmJQIGk0lElZ6t7Erpi5DWmyni6Q0dnkm/qhy2bcickillWldDXWqDx4Gm4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(2616005)(41300700001)(83380400001)(186003)(2906002)(53546011)(66946007)(66556008)(66476007)(6486002)(316002)(6666004)(478600001)(26005)(6506007)(44832011)(6512007)(5660300002)(966005)(8676002)(8936002)(31696002)(38100700002)(82960400001)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjQ2ODMwbHpkRysyelRLQkp6RlQyNDVUNkFSU0Z4U2wzT2xlbWc0QnNaMjY4?=
 =?utf-8?B?MXM5eUFPNlArSEhTbHVBRmErbWJ1bVd1ZUtDdHdTL3o4czRkbUkyZGtHdDY1?=
 =?utf-8?B?VkpQem1ORysxU29vNi9NNzFwVFdrWFVXV3BjOWhWN3E2UkZxVTNiZGNXOHBl?=
 =?utf-8?B?VXppUTZjWmlIMFJhRHZSRFlrQnF6K1BjM0x1K1Y3azFJUjlZQklUb1NBWU0x?=
 =?utf-8?B?b2owSXNlNjRKVlNJRFZucXZDZWlMcHViNGp2M0dTL3hFNE11R3FCNDRJTXNm?=
 =?utf-8?B?YmhoV1AxYmJrUjdWWThaN0FCY0NwT21XUFVaS3dBZ25qTk1VV1dPU2laN0kz?=
 =?utf-8?B?RUJBWUVCci83N2ZLNUZ5Y1hFaWM4eUM0dnl1ZWVKMjhTT1dHN3JtWkRoSjQy?=
 =?utf-8?B?eHQvVXl1a2t4eEdMOXRjeUNnSTdNL2piMVV2Z2NBOUdjVFhLajRJdThUM3JY?=
 =?utf-8?B?MDhadkoxZU9hM0h4RHBZVG03K25PREgyOXJYMzhreVoycGZnM3VOOThtZURL?=
 =?utf-8?B?b0pBY0pmK3lGeG5nN1F0MlFPSWoxSUR5MlQ1WmxrcnA4WGhHbzR4Z09idjdV?=
 =?utf-8?B?S012TGEva3N4dmU5cjFpdHg3S29mYWpZTitGYS92OFR2c1p5bjRnWjNKamgw?=
 =?utf-8?B?Q3hmOGdZaHE2SzFXL2c4MHlpc0t3Z1VOVEdvYWxVZlJUMmVheTRJems0VVpQ?=
 =?utf-8?B?VXA0eHZVOGF0WDNaNWdqemZ2Z2szY2QwVnBMN0FtbnZhS1VBZ1J5b2Vad3V2?=
 =?utf-8?B?K1ZJS3JvL1RCSWlHNjIxS09jeHc2VFJpamJOVURiREhQYzVmY0piVXh0aGxV?=
 =?utf-8?B?WWdYSlBqd0hYMUhTczlZa3BjckxRWmN0NHp6VUVMYjY0ek5rYmt2N0RYanQy?=
 =?utf-8?B?d3ZROEx4dUZnVVFCS083RTd3OWQ5MGwycXhIV1J2ajBhVG9TTHlyMEx5aE1u?=
 =?utf-8?B?VjVRVW1POUo1T3VRMEVmV3A0SFo4cDNTOVBIRzE4ZTN3UjR3SW4rN1p6WURy?=
 =?utf-8?B?YSswYXZ5d2M5bGRZamhHK010cFZiOEpDTDJ3aHE2dnFMaUpBTUxONTl4aFJO?=
 =?utf-8?B?Uks0djErK3RYUjMraFJmRTdKaFdUNGxSR0FYbjhTYm8xOSs5RGhISkdkTG4v?=
 =?utf-8?B?R2dIcVNDNk1XNERSWHcyM0VZTU5TM28yMmFETkhqSTkzckRpd0x5dDhmcjJk?=
 =?utf-8?B?cEkrNU9NRjlDSWVncndXbGhtVmFRRG9vZ3YwMVdLVGcyVFVzQlJvdisveWxt?=
 =?utf-8?B?RHhpejdTVS9mdGxjelNxOHBNbUFZVXNhdDBlY2dHSXpHLzM2cE5TdkU2UHR2?=
 =?utf-8?B?YmhwVVdldE4wQ3lZQmZYakViRzlPSkIyeXVwRm83aWFLTkMzc3dxd3lvVEtD?=
 =?utf-8?B?RExROUlWYXRkY0ZNbTlsdDJnR1pGT294Z29kRWxFQUVoOEYvZHNMQzMreDZo?=
 =?utf-8?B?N2ZYRXVLK3o3YTN6RGtWbk45dXI1cFM0V1lZQzNVUDRqWm1kSFRhaVpRTVpx?=
 =?utf-8?B?a2o4ZDJzakF5NE9QNkZCSjl6Z2JBakY2Q1hJSXVLRElZbWZSWlJ3MVowaERi?=
 =?utf-8?B?REJBR0xPSTRJZFRmTTBCazV6UU4wOTZTY2ZJb0c4QUhqRERzekcrelZJdG55?=
 =?utf-8?B?UnFhUTByNTU0eWV0Z2Fza1VEU0tSNmV3MVlUUURmODNLd0pzeHNuTEV2R09I?=
 =?utf-8?B?SEM4UGtlUWY4cStNVXRkalVsTzF0RjE0N1hhR0Q0dmJ1SXJpTzFGTW5uMmQz?=
 =?utf-8?B?UFBTR0FtNFhsbDUvbDBFVnNKeCtJQWtDcDNQT3o3eEJFNktNcXIwcUY1Ykgr?=
 =?utf-8?B?TUFhY1BUNS9LOUo5cFBvb1ZWT2dqVUZ6R0M4blZJZTB3TDFJbElLOHlHaXFR?=
 =?utf-8?B?WG9HMFFEeS9LQm9PL0NnSEpHYzhIWE9OeGhKeTBRNFYvQjZWZWJRTWMwT290?=
 =?utf-8?B?VndaQ1pmcCtMTno5SDJyQzVRWnE3eGZaNjZBSC9vQ3pyYWdmQXQyT0k4Y3pH?=
 =?utf-8?B?Sk8yQktSODdBQWl6ak44WHRGZlR4aFNsWnBJWm1Ba0ViSytJdjZNSGJHS3d2?=
 =?utf-8?B?Zi9ZUmlyWmEvd1RkbFdnOElQUUd5L0VtTlhwZWEyaTNScUg0SHEwY2kvZHBB?=
 =?utf-8?B?OGZBWHA2OXJqU1cwZk8zOURMTkNzRFVrOHhIaDVPeE8xVWpYbmVMNjVGN2tX?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f67a6b-802a-488b-1b82-08db5b6df43d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 09:13:21.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnI9k/T1Fp35iJeNHIEH4D+Eak5WTgB3SSiMg6oiePxAY+kexLsuCYHm1MOPCQFbKr/UOPhEIQaHvpGBWqo7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6256

On 21.05.23 12:07, Florian Bezdeka wrote:
> On Wed, 2023-05-17 at 13:01 +0200, Jan Kiszka wrote:
>> On 17.05.23 11:34, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
>>> next/master branches. The full queue [1] holds ~7 patches. I'm trying to 
>>> split that up to keep reviewing efforts low.
>>>
>>> This series brings y2038 support for select().
>>>
>>> select() is somehow special. Linux does not support a y2038 safe
>>> implementation for select() itself. If the application needs y2038
>>> support the application has to use something like the pselect() service.
>>>
>>> To make select() y2038 safe glibc wrapps select() and wires it to the 
>>> pselect() Linux service.
>>>
>>> Xenomai (cobalt) does not provide pselect() yet and it's not easy to 
>>> implement that. The reasons:
>>>
>>>   - The underlying xnsynch infrastructure is not prepared for waiting for a
>>>     combination of file descriptors and signals. (Let me know if I
>>>     overlooked something!)
>>>
>>>   - Implementing pselect() would require up to 6 parameters that need to
>>>     be forwarded to the kernel. Xenomais current limit is 5.
>>>
>>> To get select() y2038 safe a "pselect64() like" service service is being
>>> added. The signal part is skipped.
>>>
>>> The wrapper for __select64() will be added later and will convert 
>>> struct timeval to struct timespec64 in user space. This way select() 
>>> provided by libcobalt gets y2038 support but pselect() is still not 
>>> supported.
>>>
>>> Best regards,
>>> Florian
>>>
>>> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>> Florian Bezdeka (3):
>>>       y2038: cobalt/posix/select: Refactor __cobalt_select()
>>>       y2038: cobalt/posix/select: Adding pselect64
>>>       y2038: testsuite/smokey/y2038: Adding tests for pselect64
>>>
>>>  include/cobalt/uapi/syscall.h                      |  1 +
>>>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 +++++
>>>  kernel/cobalt/posix/clock.h                        |  6 +-
>>>  kernel/cobalt/posix/io.c                           | 94 ++++++++++++++--------
>>>  kernel/cobalt/posix/io.h                           |  8 +-
>>>  kernel/cobalt/posix/syscall32.c                    | 24 +++++-
>>>  kernel/cobalt/trace/cobalt-posix.h                 |  3 +-
>>>  testsuite/smokey/y2038/syscall-tests.c             | 70 ++++++++++++++++
>>>  8 files changed, 190 insertions(+), 38 deletions(-)
>>> ---
>>> base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
>>> change-id: 20230516-florian-y2038-part-three-3093da9fecf8
>>>
>>> Best regards,
>>
>> Thanks, applied.
> 
> Hi Jan,
> 
> some testing over the weekend discovered a simple problem. The timeout
> write back is skipped by accident. The fix is quite easy but I think we
> should add a test to smokey as well. The testsuite did not report this
> problem. 
> 
> Should I resend or should I fix it on top of next? Asking because this
> series has already been applied to next...

We can still fix that up in next. Just send the updated series and let
me know which patches should be dropped from next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

