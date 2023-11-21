Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99482369
	for <xenomai@lists.linux.dev>; Tue, 21 Nov 2023 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f6rSiufZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNqhUK/rKyjQbPIL33VHUvwaZcJslDP9WQvFHNBiWk2E4JXuhn1gpsRs55W43UBZ4SvrQZCPjfHrJcxzEFrjvvAVChJzHLgV8gUuDlX1A16DWgR6bHDeOPUXUO12imIRhtuAcJ410OTh8PEBMiW+McDSk/tMfV9foXUd8OKNju6QngPukIToEiS8EzSexptUxtS9Xi2S0rLvWSBGIyh5EU9m2k59XjhM9BAxthXku3flSD/x9oVkD83f8/fId0Cryv4Z99lZqLIDzTDqJA60OMiXcykfhRwB954mcld6+dhRnzok4EHNSrjJFFW/dtWiSPh2zfWjZDOB+o4lSh3yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6GBwAH1uXrK205LPXl3CfaAV5fXAfb8G7SU4TZ0syE=;
 b=eIun24/9JQUs+9FCYqawswnuBJMxpsucFGCL0F4LUQXKViLQaoGCfPjD+lmLi+YrzxJ8YJJH4ORXuDqB3YOjAsQDkhb+xfUiTBFhPOKQ1i+ZreqwKMpLPzqLKVBg+04axA/pGygQ49OVrGXAIPm92Wfk0Kgms9jgfI+o7VUegD9PKtwaAbC6pFs93tMyYrnZ1PR8/w4GQMhJkZ2JSaT/WZqH6aj778uYd1Kk282lNieiwCi5SB53vr03idS/RPKgT7WULeGJ1ofMJrJJWTH+8nDKYz0rSKQtrbPbBrvi0y8WLeUw2urdvhYevwXZYp1x5li1/i/3MkFiKRsYB5e8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6GBwAH1uXrK205LPXl3CfaAV5fXAfb8G7SU4TZ0syE=;
 b=f6rSiufZOzQTkSWJ/DhvLwzvV9qDvYRbxHVEjtHDQpo0ZOdGAfwLfy1ZXDlkbdwJJ+h+0+HLFh2jkchWTZlLMMwUbmjRm0Gcs/9Fu8Ciwy4RX/sjCXtya8iQAF5hs9zmX0ltIKcbzF36967tfkavTadAUV6fNp3hgA1SIvtDLNXHHHFBVX/GJGWHvWHcAcyvV/KYSe31P3QpW17DV7vGBPHJ/R10RMBqrvqqNvfKYg8pIzslvGu5Q1uzygUWu9JSRjrD2kMVmWDWavQBRDAYUBmmERbDJAakppNNJXvmk4FFN6r5Qb+ryzy/Rv8BvpkpdqIg/MXZniwhhtgbVIElEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 00:06:35 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:06:33 +0000
Message-ID: <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
Date: Tue, 21 Nov 2023 08:06:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYXPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:403:a::32) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ff6508-1537-49f5-ca26-08dbea25b7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hwbJT0CXKPa05MAy0m8pCyRxY3lteGeMlRDLSl8UWcS1EPBvSCIOFPiEHdT4NvKIOuHr5svSkd5kWyG6GKOeGjw6woiHyNMV8UySbct3Rjwiz0O47afuZyuY1mwkq6iY5K0tQ6J0PGEnrcEhFcFfphY9Toscw93ZqEWxlIBT4/2t+M+EpR606BgAUwpwAJ0JjUGAATgl1RaSAtPEln5EFakdEdyR+fZik5GSKfwZDJy05qwnSFBBBHQWS5lxD4Skxoj9KiDqTjDybbXQRLiASdR8rzZlK9/cZoiHDfL0LalTIl7vsWiNMw0m04oCyURP0/4DCR0TPvuc3KoKzsDfbk5pzRJd7wCxDEIm3C+ucIBYpboHFcD8k/XHTHjmrSUlldvx9/oq2CSybV13Ph8f6hTIH/8NvRl0RfRU2ihATeQKGVLXtbdKzjGHKxWmbiTlEFwwp1BIX70jPuGCC7IZaVL1HvPlgZdvOshmoJ9TRGHKCri+wnrE/o7hplyv7I9uzo8Q41/6YXtOTkpwHBIBGA85HN0valzQ1JdyysGH3cR3g+xH7tl+nKNFNrTW/PKkW6toyolwHTCR5w+9XDN8h1Cz1EpMBUTXv8UwmRMay3e78BzNwRfVRk8BwxyydipTQbo7+1WX8IAx96ueZJOo8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(2906002)(66556008)(66476007)(66946007)(316002)(6916009)(38100700002)(6506007)(6512007)(6666004)(6486002)(53546011)(478600001)(83380400001)(26005)(2616005)(5660300002)(82960400001)(31696002)(36756003)(86362001)(8936002)(8676002)(4326008)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWFiL0VXSjgzcUNmTFJLdjlYNlkvdzllbnhldCs0cEZQZUJJN1VuZWR6TUNJ?=
 =?utf-8?B?L3JoQlJJKzNiK1c2aTNBaHd5T2NtQUJPZiswVExsdllXd29OU0JZQW5XU3Za?=
 =?utf-8?B?M2dzazJCNVR0d2dYZXg1UVRFQjRJL3oyc1pobCtuWTBocStqVDlWMWRsdkUz?=
 =?utf-8?B?RHFlaGZlRWpoNlM0cHFGNENmVEMzekFTN0tZVGNRQ0wvcGhNOXdGcHFOL3dl?=
 =?utf-8?B?UjU4YWlhN3ExS3VJaFRyc0djdm9MQnVGV05OQmMvQ3pYaEtnMlR1cnQ2Tkxw?=
 =?utf-8?B?Zzk0NFlLTVo2aU9xT3o3ZXQ0L2J1a0QxNDBLNUFRbktxQ0FCN2EvbGs2YW0v?=
 =?utf-8?B?N2IrdmNYbGdOQU5QN0Z6L0N1MmlEQ2tlM0xtYnJySC9ybEc2NC9iUThLL3dy?=
 =?utf-8?B?b0MwcUFQRjRIQ3g4TnF2Tm5tWmpEdFVBUHhDNzB5MWNwOHo4ekljWWdMSmxO?=
 =?utf-8?B?U0hGb2RCeWlObkgxNmhMMVFCWnY1d3d6WmlMS0lNa3Nsem1uaUxYWlZLWDlt?=
 =?utf-8?B?Q01XZXIvc0FobjQ5NUdoc1JPWGcvNXoxMUVDSTcyWGdFSVNNTkpUWlRldk1X?=
 =?utf-8?B?VktJc1c0Y2xzdEZSeHZFRnViTFhReTVNMEE3eUhlcEZ1Y21La1Z4ZTY3aEdV?=
 =?utf-8?B?M2JyaGVqN3JycEZ3azRWT1BKZzQ1Zm5uTmxCYzhJVC9yWG5vTzNnbWtrYVFR?=
 =?utf-8?B?NWlIaTNsa284TGJOd3ZwNHZHcXFlOXdZSFhqVTJCOTM1aXQzcGVXVEtiblh2?=
 =?utf-8?B?MWNmZGowOENIYUlqVFpFdnhLaXlWS3ZoUU5meHVjcnFTcDI5WFZsR1MybHNV?=
 =?utf-8?B?Ynh5QWw2RGtDVkxjeWZDM3RxYjBIQlhtWnRTL1VnV3hWbURDNytSaHRMbXRR?=
 =?utf-8?B?N0w2ZEFIVFcySzY1ZmVlVmgyNmhvRDVlQ0NjWGszRmxCclpUeDZ1UzFNMTRW?=
 =?utf-8?B?NWlQV3kxeEZKRmFVOGJyWE90Y2Frbm1XL2h6UmJMaFNjQU9VZXdnWWFRT3dD?=
 =?utf-8?B?QjZFQmdyV1plNGZLRWVrS0c0VFBPaGlVaFdrUnVaVUlsVnhhdmh2Z0Rkbm1F?=
 =?utf-8?B?RTV6M2dsODRjSkVhdTNpdTVhWXZZdWQySUZmbGNEQmFtOGhWbzBiR3JQWkF3?=
 =?utf-8?B?T0g0ZjNoajlvcTFKWEhFNzVVYk5ZODZDVi9hVDhLTUhqR04wVm0yWmYxRmQw?=
 =?utf-8?B?TWZ5ZkgxMHpWQzlKczh3UFBlVXY1S0NUOTRsekN5Z1l0U3RBTDlvMExSMDcr?=
 =?utf-8?B?alJDZTJTcjVXeEUzb2pRaGRtc2tYdnpzbzkyeEtjeEtVR0lPQ1VFcXZ0OVIy?=
 =?utf-8?B?b2hkUmkxVXNaZ3F5OWtiS3ZxMWpxK3Nja0NvM0thZ2dBM3d1bVJ5RmlHYXFN?=
 =?utf-8?B?d1FUaDhLVDR5RC85SkFPbWNNaXNuZjBuZEFDZ09CeENnbURiRlc3by9jRFJI?=
 =?utf-8?B?OEVjRU1mUDRiVUpvdU1mYVRIa0k1eUU1bUp2Z3BZelJHbUl0dGdLcy9XbVNi?=
 =?utf-8?B?Qk5UR21tZW5VMzQ0bFRoSWFIUDlYSFJ5MlBicjJvdTBCL3dmenZESDFsRmZ3?=
 =?utf-8?B?S0xsOStwWlZVM3BESzdQUnptbFI1YlU1OGFjMzFEY3FhY2tXV0pNYTZXQmJK?=
 =?utf-8?B?UEc4QXlmb2Fwa3FZU1Y2KzJkTlFpZ2dTT0QzZ2FSQi9QNyt0V0huMTlGT3hW?=
 =?utf-8?B?L0ZhdjhNR2x2bVM3bGRwZXpGVXFNK2JWNENsUm1xZGxWNlRhcFJCWTA2QitZ?=
 =?utf-8?B?VkI3UERvb0Q0S2pycU9yY0xRYU1leXJuektqRUdnZ3d3YUZJM2o0amZWOUdM?=
 =?utf-8?B?NVV6dmZVUUM1L1ArM0Vuclg3ZUpYd28xclpuS3kvVTUrSUZKVUJQWWhyYWRi?=
 =?utf-8?B?LzJWSEg3OXJEeWMzSXhpVzk4a0hNa0hHa1EvcWhBQmhoSkliMzdaSDFRaDJm?=
 =?utf-8?B?cTRPNlcvMHo1MHRBSjBLbk94ODR4VFp0TFZYa2JGcmRjcTR5QVZDY3hpOGU0?=
 =?utf-8?B?MlNOaVFQVWtCWWt1QUJYam5hVTMyZlcyNFpjaEdYOFk3UGJYeXhqd0k1RXhU?=
 =?utf-8?B?amUzcU5LYnEyQ0p0eGdnQkQ0Wko0RzJEaFlMMFl4NGM1TWVxSnF2V2VtM0Mv?=
 =?utf-8?B?Sk5oaWRWNXUwYW1RUDQvSFNvZExjVUFvZU01QlRWODNycisxL1d5ZHJuMytE?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ff6508-1537-49f5-ca26-08dbea25b7da
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:06:32.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRWQC99qHFCfzYRUKUCHWURw9ANlgNTRToP/UT/kZnfam2RAV7IggsRGOEZdGk6Cy07vKTh3MaMm/z+m0FivmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6156

On 20.11.23 22:23, Mauro S. wrote:
> On 13/11/23 18:54, Jan Kiszka wrote:
>> On 11.11.23 16:03, Mauro S. wrote:
>>> Hi all,
>>>
>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
>>>
>>> The application I'm running (a complex application, with about 60-70 RT
>>> threads) has a simple loop in the main function, something like that:
>>>
>>> while (stay_in) {
>>>      ret = rt_buffer_read(...);  // with 50ms timeout
>>>      if(ret) do_something
>>> }
>>>
>>> The main loop reads the buffer to receive some commands from outside,
>>> and when the application gets a SIGINT, the custom signal handler simply
>>> does "stay_in = false" breaking the main loop, and then the program
>>> closes.
>>> During normal running, I can see the timer associated to the
>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>
>>> 0    291/290         2ms970us           -           myapp
>>> ...
>>> 0    609/608         34ms860us           -           myapp
>>>
>>> I also see the thread in "w" state (waiting for a resource with timeout)
>>> doing "cat cat /proc/xenomai/sched/threads":
>>>
>>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
>>>
>>> Sometimes, in a non reproducible way (at least for the moment), when the
>>> process get the SIGINT it never exits, remaining in this status:
>>>
>>> /proc/xenomai/sched/threads:
>>>    0  16328  rt     cobalt     50   -             W          flxcore
>>>
>>> The state becomed "W" (waiting for a resource without timeout) and in
>>> fact the remaining timeout is not present in the row, also in
>>> /proc/xenomai/timer/coreclk:
>>>
>>> 0    291609/291362         -           -           myapp
>>>
>>> (BTW, seems that some timeouts got lost, because scheds are many that
>>> shots, and this happens also on other timers in coreclk)
>>>
>>> This is the backtrace in gdb:
>>>
>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>> /usr/lib/libcobalt.so.2
>>
>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>
>>          /*
>>           * If we got interrupted while trying to re-enter the monitor,
>>           * we need to redo. In the meantime, any pending linux signal
>>           * has been processed.
>>           */
>>          if (ret == -EINTR)
>>                  ret = cobalt_monitor_enter(mon);
>>
>> But the problem is that the lock (monitor) is no free. Someone else
>> holds it, and your interrupted reader does not proceed.
>>
>> If you dive into mon at this point via gdb, you may find the owner
>> (according to libcobalt's view) when you resolve manually what
>> get_monitor_state() does.
>>
>> Jan
>>
> 
> Thank you Jan.
> 
> I rebuilt the Xenomai libraries with debugging symbols enabled.
> But when I try to print the mon variable, I get
> 
> (gdb) print mon
> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
> (gdb) print *mon
> Cannot access memory at address 0x7f3cb524e62c
> 
> Seems that the memory address is not in the core dump, but I'm wondering
> why

Did you create a core dump or tried to attach live the hung process?
Maybe the former was incomplete - for whatever reason.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

