Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007AD531
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 16:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glmj7Dk407a3Ri52iOddyhtGdHbGqxoHsB7I8fCL1imRwrFzrppDA8EhQQxIW7qj3hBOKcxpHI9TZxUeTsAF+Fv4/Jlwv8dAF2VHU1GJ2FmxlxyirtsV24o3Faicnt0aUN9ZDrNighsfYxEboXR57G7JleR8reHTt1HgkdL4PLBXgqFc1MGfXVIPNlAD1i3J9xQsbxjx0FMPmdSeCNnPP/hCfDw7HymonfoqOuuALNLZcAGsmhjglXCCMYaNK+ksGTx9TfLV6fmSqxMZKWcFmTlo2LlajYWIft3giwii0GjZWrz8J1+sY7CsptOVG/TNG5QxeoyprxrJ+6ENdMahXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjxwfD+2yL9Z0ivUKCbGmc4PiAxAfB5871IBtKMmXN4=;
 b=EtkNHTvA2SY2BSsLYpdgU6CFw1ZPkWqpDBUD9DPk/T//xmQAeNOeyRUpt1HRzH23yIFeAST55Slwnr9qOh3q6NPo3SBR0vhyDWG1oNduZrn9y8CP1F22GCc4ljX5GfamxFttz8ZAVrYS8kbnz+W4Z0fA47CZ7EvWEbGsVILc31VLSCF4I1uEKxm0MQFtIyLWjJQeZgZbOsGRtIUmvhWy+Q2REUbS4/UiBiYiVVNqOyO4vWJ7NflwOeFmH/QLcWU9IKIc3xiJ6NjoSRSspODpWgPrNPPUnOQAO0tqynfkZnex0aRbicGUehLJHFYj14VJa5hJ7KHziHv7Ml1AW7uk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjxwfD+2yL9Z0ivUKCbGmc4PiAxAfB5871IBtKMmXN4=;
 b=Xdw3srj23w+huSzeSG+peDxjf/hX/83vkPatMdPB27vbwV/EZnPjk3UbESYEa6CihF2x70BQZBuuaMgMoat04mkJL+HUlBxzdgxgkvGftL5ncfkvzV70ZNZmDUYvcJfM6lylVif8YqnGB4iRSBy90zXq34US/K3wpo7eSvE9lX9YZk4iEHZD6IivXDe1mQhGotsBBnMrdh3OtvpRWjCvrUqBlWjmGhtMUF7nb7XlUSJg4JBMtlSDH55//wp/hYCDEzGI4jASSKmcj2ZoZHTXDmjCVc1ierpsgqRxtwrDZPbWwA51aubKEfQlDcc0S5SPc+Qj2GItWaJ6e4AElQDavw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 16:20:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 16:20:34 +0000
Message-ID: <3d0898f0-329a-cdd1-a5c7-f674c6178cc4@siemens.com>
Date: Mon, 7 Nov 2022 17:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
 <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
 <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB26545ED41E498275501328E9FC3C9@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB26545ED41E498275501328E9FC3C9@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 025090ff-6194-4abd-ad9d-08dac0dbffc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nw4CX190YIeB98QPt/CcH3ZeW+9SoPAaLQLvEPQSZIon/P2Gut8GAOrDl1L3z7Wj9HfF+vAkksnod3Mjp9uhJn6mBLFjyzs1QULzCKZ/+X53vGUH4FyenTCInzrLhtlRayTTp43sTE8DP7Pkc0kH3bpIjgdJVdjDH/LYHG7TPiC7taWYbzQYdQPsNs83iJaj5t95P3XUkPxJ6hvU6wYa1dvs08Ofz9/jb8uLugcidbnfDRlz7oGKvmQVS0NN1ESi/A7XMlSi+Y/1xiP4YROfq2xlRuQ0mnX8F5bdGIgjW6dDJB89utM8p2zPfgTDPZogKgEjD3IZqEPYk8d46Zb720pWzHunbvxxztPqjCckMjLG42SeeggK+4tbd06Xdf7juyPU90L3z1gpe/VOHXlX7tUN+FdHEfAcbRsjZCAvWNwyinNqaSNbXnVKeOWJO/rbz6dDAPkQbuSQ/diCm11MvmXToP0YsmAMh4DnrmKkgHN8JzKhCWUWKcS5dKQ71TA+ft9JDj+mpa4Ec9hTrcg2D4U4YQ8lEL0e6lQxokIJnFLe9pCm7yurcUtqvkU4q6SZsGE3F57gRt5/aWlet6s+t7dtuoyh1JdXqZpAfW1U1Q0csXVp9XOlsS7U2gg0JMI6fEHFWW2Dgrg9T8exCuW55A5mzkFxo80bue131TasYG9U01fDx4TGrWTPREVlpUzvcT7/Swt4lekmIoIXRVaaVbWIaMuAU6Ti7KDUjPy4UP+LgsZPtixPF5EU7W0fK0hhxHgwZDbEdN2yPzFYpaDltB5nAU9QGJDwVGiqm/DLLk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36756003)(54906003)(110136005)(8936002)(5660300002)(6486002)(83380400001)(2906002)(44832011)(478600001)(66946007)(66556008)(66476007)(4326008)(8676002)(41300700001)(316002)(53546011)(6512007)(26005)(2616005)(186003)(31686004)(38100700002)(82960400001)(86362001)(31696002)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3F3NEx2SURIQTg4bCtpeU5PZzBvczRtR0M1end1OXMrcmlSM21iNWhvNWN0?=
 =?utf-8?B?RFJjTXdGa0dYZE9ZYUpJV3lPZTZZUHpDRXkxVGh3QkVNWkY3S1dSd0ZJTWQ2?=
 =?utf-8?B?MEFkaGFWbCs4UVBjN3NFL0VBYjM1b3ovRW1NZ0dDZ3dFcWFMZUZlbCtDclR0?=
 =?utf-8?B?ODJ4dXl3MVM5S2FDa2FBeEgrZnJPT1pqY1B2dHNOKzdEdlBNUUVFL0NWMmt2?=
 =?utf-8?B?RC9Gdkd1M0FHZW40N05VME5FTXcvU2xHL1FUVlMxY216L1oxM0hCSHIrR3Nr?=
 =?utf-8?B?ck1ISG9JaHo2RUF2dmt4OWIyd0RBWDlqbjEvMmxuL3NuMU5IZUlLTlJzb0Jm?=
 =?utf-8?B?eXZpZk5adkR0aGRkR1Z0RXNadjVlREtuNTFJbkUrdmhJRDRuQXhFZXRLTHVZ?=
 =?utf-8?B?eUdpQ2FnakdzQktQWGFTZFdWUzhmeC9zMUo4dTZYNnRTT3FqN2pqSHZtS21v?=
 =?utf-8?B?NmNxQm5TL2YzTUtoUFQ5N3oxN2JvWlN4U3JkY0hvRU9iNWxmVWlVS2EzT3k1?=
 =?utf-8?B?NkJpV2lXeDNpSVU5bHVvdHdPRExXZXY5VkJMOFJhWXdPOFpQazJXbUExWkFl?=
 =?utf-8?B?bXM1K0pWMEwzZ0wxK3NCQXNhalFqVHdOQmRpK3JvWFdJRERjZ2hxVkpGa1pj?=
 =?utf-8?B?SmptVDh0WHVGMWkwY0hkRGkrc2k3ZDBrWWhRNGpwMnE3VXIyQUJnVWxnbHFq?=
 =?utf-8?B?bS8vRWdRQ2RXRVA1QS9ORWNDTWx0OHdtK1VaNzd6M3F1UlY5aVFURndSekxL?=
 =?utf-8?B?M08yRHl3RitDVzUrdFRiWldHUWN3TjhpWEMydGJVeEtyQld0RXJVOWhZNEZh?=
 =?utf-8?B?Rk9FU0V2azF6Z3l4R01STWQ1WjdkcVhlaGFIM00rYVFPS0xCQWlST3VCWThq?=
 =?utf-8?B?SnNWZGdmZG9TRGo1TzVTZnNjSTA2aXg3Tnp0dDJmbzY1VlhlUGhKeHl3SThm?=
 =?utf-8?B?MzhHN3A0ZDFzdlNLdElWemQ0TG0wS1V0eGphZTFxUzBxM3lPdndzRWxqZjZZ?=
 =?utf-8?B?eDNSMDh1UFNiMFZEK254eGJyQmU0dm1qWjNXdGUrWTIvaEZUb3haaGNsVXYy?=
 =?utf-8?B?R201TkxrbW90RDE4b2dQOStjS2ptcHhmeVBsNU5Fa1MvaFlmbmMwNFFkU2VJ?=
 =?utf-8?B?emw4TjhtRjdxS090cFlsZEJyOXl4ZDVLRTF2U0R4VThNeEplK1hBcTN3Z0ts?=
 =?utf-8?B?dzJkUzVaZldJcXpwbDVKaVRtaGFFSFpReDE0Mk91UVkzRGZOT1ljRlpJaTJq?=
 =?utf-8?B?aDhJdFk4UDZJU3ZSZ3oyTWdybkoyN0M5ZDV5R1FZRWl3K3cxYU40TTlsd1hY?=
 =?utf-8?B?RXV5SjhqVUNhcTE0d0k0QnVPT0FLWGkwQ2lmZ1VBT256NVJUOWVrVXp3Yk1D?=
 =?utf-8?B?YkppL0M5OFFRRGYxdlpBOUJaS2ZuMjFHQjdkTzh2ZVd1dVpSNmZOTUxmZDIz?=
 =?utf-8?B?MklLR1RKWEorRDBIOU10UXNGS2lyaitPSHBKWTA2ZENoUXFqWmRkbXZKRjFi?=
 =?utf-8?B?V0M2aGsvckoycmMvU092NGluMWFBK3RxeDBUSUdDRUIzUFkyRStFK1d6eHJi?=
 =?utf-8?B?K0hqSVhMcm51MFg3ZmZLV0dJVVVWMVBxSk1MSDZyVkFGdXVlaWRLS0hZREFF?=
 =?utf-8?B?Z2pRbldKMTY1OEpLVHRSeFdxTHVTb1k0bVZDQjhibW1vVGQ4Nk53RVNBMUM1?=
 =?utf-8?B?dmNLOXg4ajhwcXprZVp4Tm0yV1FvYzNsTHJoNWtLbHRBQTRqenVwMTNMMTI2?=
 =?utf-8?B?SzJWQkxGcGVpQ3JaQzFxdkNBaXNleTRpdU4ySjdaQWZwWndWNk9oUXoyOGtJ?=
 =?utf-8?B?YXFSTlZHeVQwUG5jUFZja21tcThUSVVwWlZlZjUwOEdVU25ib0hTOW1Lbytx?=
 =?utf-8?B?TnpOZXZGQkw4bFBlVXFsOW9KeGpMQm44V240YVY2YkhXd3pPazdxYW9nWlFI?=
 =?utf-8?B?dzhWSHAzUmxrdmQ4ZDcralpsSWRKMG82KzNuSVd4N1phdzlRWDNyTE5GM3hR?=
 =?utf-8?B?S1ZLWldjdG9tenJ5TzY1cm8rTmNvRkc0Nlc0VFZiY1cxWVR0M0pheDlseFAy?=
 =?utf-8?B?KzBSWjc1RDQrZ3lHWWE2emVDK1hSWjhZZWxLQzRuTWZSVWNidzJVY25FT25Z?=
 =?utf-8?B?aUR2VnJNcnU3WjNxK1VoNm9yT0g0V3FDK3FjbytlNnB5bCtSWklFb0pXSGxZ?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025090ff-6194-4abd-ad9d-08dac0dbffc3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:20:34.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTdGw5xPT6onPMDc5DC88fWa2mosTeBgovQJUIDQfgSFk9sl2EAO0VHwtdU4Y0n9E/t8Y9trH9ONnnyhmlV0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5803

On 07.11.22 16:09, Heber, Stefan wrote:
> Hello Jan and Zqiang,
> 
> We tested Jan's patch on our system (Linux-kernel 5.4, Xenomai v3.2).
> 
> This patch makes the problem disappear with our tiny testapp on our system, too.
> And the problem disappears also with the systemtest from our huge application.

Great to hear! I will meditate over a good commit message - and if that
change actually catches everything.

Jan

> 
> Stefan
> 
> -----Original Message-----
> From: Zhang, Qiang1 <qiang1.zhang@intel.com> 
> Sent: Monday, November 7, 2022 2:18 PM
> To: Kiszka, Jan <jan.kiszka@siemens.com>; Heber, Stefan <Stefan.Heber@zwickroell.com>
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Wang, Rick Y <rick.y.wang@intel.com>; xenomai@lists.linux.dev
> Subject: RE: Memory corruptions upon strcpy and similar when being interrupted by scheduler
> 
> On 07.11.22 09:42, Jan Kiszka wrote:
>> On 02.11.22 16:48, Jan Kiszka wrote:
>>> On 02.11.22 16:34, Heber, Stefan wrote:
>>>> Hello Zqiang,
>>>>
>>>> We tested your 0001-IPIPE-ignore-xenomai-FPU-operation.patch on our system (Linux-kernel 5.4, Xenomai v3.2).
>>>>
>>>> This patch makes the problem disappear with our tiny testapp on our system, too.
>>>> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.
>>>
>>> The patch is surely no solution, but it points to the direction where we
>>> need to dig. Unfortunately, I still didn't find enough contiguous time
>>> to start that.
>>
>> I'm starting to understand the problem:
>>
>> Somewhere between 4.19 and 5.4, the kernel moved FPU restoration for
>> incoming threads from the thread-switching code to
>> prepare_exit_to_usermode(). However, this path is not taken when
>> switching in a primary thread, at least when it's coming from secondary.
>> Need to look for the right way to account for this now.
>>
> 
>> A first, so far promising fix attempt:
> 
> Hi Jan
> 
> Thanks for the patch,  I have tested it base on Xenomai v3.2 and linux-v5.4
> This problem disappear.  I expect Stefan's test result.
> 
> Thanks
> Zqiang
> 
>>
>>
>> diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
>> index 7e28903a42..8bd2cd912b 100644
>> --- a/kernel/cobalt/arch/x86/ipipe/thread.c
>> +++ b/kernel/cobalt/arch/x86/ipipe/thread.c
>> @@ -443,15 +443,19 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>> {
>>       struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
>>
>> -      if (!tcb_used_kfpu(to_tcb))
>> -              return;
>> -
>> -      copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>> +      if (tcb_used_kfpu(to_tcb)) {
>> +              copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>> -      /* redo the invalidation done by kernel_fpu_begin */
>> -      __cpu_invalidate_fpregs_state();
>> +              /* redo the invalidation done by kernel_fpu_begin */
>> +              __cpu_invalidate_fpregs_state();
>> +#endif
>> +              kernel_fpu_disable();
>> +      }
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>> +      else if (xnthread_test_state(to, XNROOT | XNUSER) == XNUSER &&
>> +               test_thread_flag(TIF_NEED_FPU_LOAD))
>> +              switch_fpu_return();
>> #endif
>> -      kernel_fpu_disable();
>> }
>> #endif /* ! IPIPE_X86_FPU_EAGER */
>>
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

