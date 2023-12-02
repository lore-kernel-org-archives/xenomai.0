Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500A168BF
	for <xenomai@lists.linux.dev>; Sat,  2 Dec 2023 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WoqUW4AW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jeu5OVbHZLo8O3aaC1at6gogpFIzxwAq4zF7TcRkmpKlVRY1UtrcIKPcp4VpOID68IKXfMlHKYoKo0Nbg/QQqToN578ZFhPxnpKwbbmU5aaBe9iwmFihVMDE6hZ5jheL1f1Mohp3S4Qenj0j6dCbb6QtPzY5dMu8ULSbzObjyWBOiDrmXG10TbujuIvMSMkj4P+MQTwFsWPYC6EAYy2cY2/uKTKgKodI+XrisD4XizLTts8zSCId5QyM+4RXsIArBbkVowjuk5nJ90OKo51j4TroxcHme5zVwZKMFShe2wt4a0OcfZYEGFl6cQCTgSdmIAje27u1sCJJ1zauRud7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV/XG9c/Nu8QCT0sEt0ymXWOIYPtyaMN21MDyBwOcYs=;
 b=KQR2gUlREMuSSCophKhRRHPprxmetpb2ENLVtb/rmokcQFznRa6rj9uJhhJiTggO0to2tV/HraVISuero0BcwS2MxfanbYC7aBBpNkQ0T3AEZUfuDVg6+pl7neqdOG9NwD8tm4n8erZHgYvYWuv1H4/7E+zHMXoRor2b9BGcYV7X4VSLQIepItQa2BmzKfpw1S6yPkPwavsO0+SSvFBbiXl6wOhZSthZ1206rm5eMNp+4McTeHoEQprnFRSq7uHtjwev31LtOVyWtP4iZcMBmWrLODfUK0IpgvI0C0KI6Zipb2H3rdDqC5OlFZhBwwx++SlIFDrdOopuiIO1g5xlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV/XG9c/Nu8QCT0sEt0ymXWOIYPtyaMN21MDyBwOcYs=;
 b=WoqUW4AWoqIaO5uB31K/AALruEoH+hdZ81CTdJ3kXI49CogLOTsOBNgszVYsRZFHuq0tnJuoofbhISPkZ7ASfe8vsWjie0pi0t/y6KkvVUEkPVe1+IGacVIYwhMwSa5N4JbcW/kJ6EuEzCOv2gBdBGSZEiLvNL0JgTLBvDxvMtEBtCTJNjjaBiM1/GbY3/4VQuOmUeF1MElLyQyx+chl3VA97mnfhCWB2St+toFDojmD3OgaGuzwlHCSnf9tmSKTNlGc5z0784uYE5hkcrLpDLPEywkJtFvO5y6famo98pyoROPxmX56/Nj4Op1ythcWoMhAkPmNtAoO3svLOfkQ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 00:37:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 00:37:15 +0000
Message-ID: <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
Date: Sat, 2 Dec 2023 08:37:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: fa263b45-462c-4089-0114-08dbf2ced4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y7qqtZDbWktzQZll5MwUeyBmwzcpj8cFN2gxsKX11T66ZR8eWF553T2YBz3KUlIjDf4n7vUVULV7TZTRrt5St7dtvv7T+iuYlvvQw/OKW/Yai4RoB0fAIcu0azVYVhIJzrTcRn1GGZAYVEC1b91BlygFiLQBeHjUJlBHvSzeJUCU9ed5Z/VH2S1PG/KEOw06ScD2hERWagsTt8RhFY4nf2zl6gVErOicGMxAtk8xeEtbh3MSO7jHqJGUx2h6wnv/t8SGKRG+5NvEZISOJtHxwiCU+UP6kSPmdRCSZmHv2ejD+/H1AjcqFTcTa/jXHQJh+LE00nVE+wDgtYLVZjZwOQeu9X9AGv+6U3B0gXzFBabsxmOaVlwLc3gJPPVdgX5NGVCrXgJUGDZE6gIJxg/IlwXZG9w/HWbUxfSDy6cWZ7Ez1AmTc1wmoDTySiO3vqYs7UlcBHDK84R2/LMt7m9sQBGwnEn9Z0brmRgHt6ew3dqelMmxdUVbfzRjIdUe/kt1ZLjN8SGJ6/81c1VKlB5jty7eqs1NpQVdrRYiEYrBNoXpQhZQWIF7Ex/IYp6BLGOkTwTO9HALUcYc315GZSYsckIT8DUaDziM2gEUDT8KqXvXet+UtntqNawelpnpbCCb3GysYpeiV2OqPcK92z+bYKWI0c8c1z620L0ZgHK0GSVy04mVwemR98jgBx2j8jgm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(8936002)(44832011)(66556008)(66476007)(8676002)(31696002)(316002)(66946007)(478600001)(110136005)(36756003)(41300700001)(86362001)(2906002)(5660300002)(38100700002)(83380400001)(26005)(2616005)(6506007)(6666004)(53546011)(6512007)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFIvSG9yNWkyUXlsTGtxdUJweVpoaHJZRTR0eHlwS1VTNlZNWktCd0RLakpt?=
 =?utf-8?B?bGdpUkV2Z2psZUFBbWNQWDFyYjJmLzFSQVFKMTNnZnhFajhGY0UxTFB3Zjgr?=
 =?utf-8?B?WHNpeDZrMWVzMWo5UDdYTlJXMytFcEUvdHppTVhBaUhEOWVuRVRMZGI2NG9v?=
 =?utf-8?B?UUMzSGRpcVNsdmI4ejRyN1BvT2JCQmYrQzBxN3pqeCtmYlliK2NEODFvWG1r?=
 =?utf-8?B?ejR5d1J0c1hWaFBoSlk0ZExKanhBL2QyZEJzcWVKZlhKVFJnQ3pVVFhhVFhJ?=
 =?utf-8?B?UzZTL1E0RUMxZ3VMek5pN0lDZ3ZCUVA2V1V4N2dHR0t4VzE2R3FqTFBjYUxL?=
 =?utf-8?B?VHFvKzZXZmFTTHZralFWeU9CQ0lHV0w5a3J2VDAxQ3ErWVcybURtV2R3aUtU?=
 =?utf-8?B?bFY2SXFHSmlsaE03dElkaVoxZ0RWR2RkbGVzNVFMamxjbFRXQzNhR2gxc2pM?=
 =?utf-8?B?cWVjdG83T3dlcUx5VFR6aFYzWFhteWg5Z3FLY3I3REtocnhmb3FaNEl4STlH?=
 =?utf-8?B?bnVRbUd4ZXNSRUVIVWxwZU9iYzIrRnZHQTB2WnZhWmt5TlEzSWZDbUkyK1dw?=
 =?utf-8?B?WDNWMVhwTDMzR3J0QXdVS3htT1pUSko5Smd2VFNHZFZOOXJDcEpRWU8wT0U1?=
 =?utf-8?B?NC9SelV1eHNwRHRhbGVKd0Njakc1MmRxREJ4SlJvQ01sb2IvWGpmdGpvM3ZK?=
 =?utf-8?B?YU42dDF4T2diM2lNcjlFemNFMzIyKzYzdlluNm9DakdVYzQ3bVBSSTdnOW53?=
 =?utf-8?B?K3I5UXVEOVhzOFk3ZjVxb0N0eGRoQStiQXEvNDZHWDE1M0FVZUFBUmxSVmVH?=
 =?utf-8?B?UHR5N01seUZEb0MyMXQ4eS9pMkE4RFdiWHdaSGZDbnpES0Frd3dDUFNyZnlj?=
 =?utf-8?B?cG1Ma3JXMUxhaG05eVIyb1FCdHhmU3Nxcm4zNlp1WE9OZTJ0Sm1jcTJDTTg4?=
 =?utf-8?B?MnhGdzNjV1JQb3BXWTF1L3MySFlJYmhWajRxd1VJMTBKVndodzdOQ3pPODQw?=
 =?utf-8?B?SEt2c0N3Wlh1RHFOOXc2blN2dVNnSHRDUk84VTFiZmwyVlgyOEFoVGtvOEdV?=
 =?utf-8?B?dEw4N0JpNlZTKzE4WmFQdjJDTzB4Mis5b2YvQjYvbW55VUhFNmFvL2tZbEl1?=
 =?utf-8?B?ZGlKdkVscXVHYXlYeVJVK3hSY0lVVVd4V1FuaDVmNlNBWmtjVEk2VDhVSisr?=
 =?utf-8?B?UU1SNHJhcng4NTB0dUc2eDFkSjJoMThoN2NiaDNmU0FQU0dPbEZ2TkVpTTdI?=
 =?utf-8?B?cnhWQTk4TkJ0Y0E4ZjlZeDVyS0dmVjBRTVlxV0cycEsrVzd3dWhHeDNCZys0?=
 =?utf-8?B?eUJ3L0ZqaDJWWVVDWFBrYWgzK2lYeFVySGJ2b1VSc0RjejhmdlNNT1VOL3Z5?=
 =?utf-8?B?UVZrWEJPNlAvTi85ODlFK0c4cjdaR29HUmo2ZHBCNG9JQlBmMnRNYlNNbnhZ?=
 =?utf-8?B?c2YzR0lEamVRTGxTSVRMdDdxdUxTK09pbFhpRC9PRWtFcEhwMVpVQ25Zb2FM?=
 =?utf-8?B?L0o2d2F5Y3FqakdRNXlNVFZoL1kvc0d3aFU5WlpqZGVuQ0FJS3JsRmdSb0lV?=
 =?utf-8?B?Ym0wVFhVWEo1WXpWQnNvdXJxU25BSkl5MDBrd0lQZlNrdVhvZ0RPZ21naU0y?=
 =?utf-8?B?cHhWc0hONHVRZ29McGxZTUI5SDh3eFg5dzRwdEw0UGw3Mlp6V0JsbGVBMVVs?=
 =?utf-8?B?aWFEK0l4M0xkaWt0dVVmNFV3dE82NFRCQ0V1aEUzeDhua3NTa3NCMVdzZUlB?=
 =?utf-8?B?azVjSTBBUXF3Q3hta05UTnhqQVBhSWQrZXp2TitXLzRobVdSSFlxL3l6WHM0?=
 =?utf-8?B?ZUNPOVE0NDVJcXpGaSt0R29ud2JvVFR5Q3FVSjN4SUJnYy9sWTM1Q3FmV2pU?=
 =?utf-8?B?d1RObWcybnVkWWdwNC9DR2c4NDNRSW8wa0dodHBWUVBFUHliMEJEZzhidXlR?=
 =?utf-8?B?TU5HUHVLNi9hcTg1b2NvbTNqOTNWaVp5elBxdEFmZytPYUFjM3huQ2MvS2Rw?=
 =?utf-8?B?eFArNlpwbmRZd0NQcmtBdks4U1FsUWtuQVRFUjg4YndYejJqMFlQc3NqTnRx?=
 =?utf-8?B?RDFuRzQ5bjNkeG1IYUd4dkY0ZWhoTVdpRnAwQVpBd2NUbXVxdzZ1Qi80ajdT?=
 =?utf-8?B?OTRtUjI3THRtL0thdnIzN21NVE1QT0d4U2V5cm5vdWlFbUZ1b2dXS1hOQURu?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa263b45-462c-4089-0114-08dbf2ced4f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 00:37:15.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHSZKv9gMa9P7FRFoeI7s9BgD4G2U6gE2DObXfpYLPZxM/povVEqnG891QKToU6M5HHKphaREAxVFNUIRfbV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932

On 02.12.23 01:31, Mauro S. wrote:
> On 01/12/23 02:31, Jan Kiszka wrote:
>> On 30.11.23 00:24, Mauro Salvini wrote:
>>> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
>>> <mau.salvi@yahoo.com> ha scritto:
>>>>
>>>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>
>>>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>
>>>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>>>> Hi all,
>>>>>>>>>>
>>>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe
>>>>>>>>>> kernel.
>>>>>>>>>>
>>>>>>>>>> The application I'm running (a complex application, with about
>>>>>>>>>> 60-70 RT
>>>>>>>>>> threads) has a simple loop in the main function, something
>>>>>>>>>> like that:
>>>>>>>>>>
>>>>>>>>>> while (stay_in) {
>>>>>>>>>>       ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>>>       if(ret) do_something
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> The main loop reads the buffer to receive some commands from
>>>>>>>>>> outside,
>>>>>>>>>> and when the application gets a SIGINT, the custom signal
>>>>>>>>>> handler simply
>>>>>>>>>> does "stay_in = false" breaking the main loop, and then the
>>>>>>>>>> program
>>>>>>>>>> closes.
>>>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling
>>>>>>>>>> multiple
>>>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>>>
>>>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>>>> ...
>>>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>>>
>>>>>>>>>> I also see the thread in "w" state (waiting for a resource
>>>>>>>>>> with timeout)
>>>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>>>
>>>>>>>>>>     0  16328  rt     cobalt     50   21ms279us        
>>>>>>>>>> w          myapp
>>>>>>>>>>
>>>>>>>>>> Sometimes, in a non reproducible way (at least for the
>>>>>>>>>> moment), when the
>>>>>>>>>> process get the SIGINT it never exits, remaining in this status:
>>>>>>>>>>
>>>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>>>     0  16328  rt     cobalt     50   -             W         
>>>>>>>>>> flxcore
>>>>>>>>>>
>>>>>>>>>> The state becomed "W" (waiting for a resource without timeout)
>>>>>>>>>> and in
>>>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>>>
>>>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>>>
>>>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are
>>>>>>>>>> many that
>>>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>>>
>>>>>>>>>> This is the backtrace in gdb:
>>>>>>>>>>
>>>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>>>
>>>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>>>
>>>>>>>>>           /*
>>>>>>>>>            * If we got interrupted while trying to re-enter the
>>>>>>>>> monitor,
>>>>>>>>>            * we need to redo. In the meantime, any pending
>>>>>>>>> linux signal
>>>>>>>>>            * has been processed.
>>>>>>>>>            */
>>>>>>>>>           if (ret == -EINTR)
>>>>>>>>>                   ret = cobalt_monitor_enter(mon);
>>>>>>>>>
>>>>>>>>> But the problem is that the lock (monitor) is no free. Someone
>>>>>>>>> else
>>>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>>>
>>>>>>>>> If you dive into mon at this point via gdb, you may find the owner
>>>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>>>> get_monitor_state() does.
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thank you Jan.
>>>>>>>>
>>>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>>>> But when I try to print the mon variable, I get
>>>>>>>>
>>>>>>>> (gdb) print mon
>>>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>>>> (gdb) print *mon
>>>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>>>
>>>>>>>> Seems that the memory address is not in the core dump, but I'm
>>>>>>>> wondering
>>>>>>>> why
>>>>>>>
>>>>>>> Did you create a core dump or tried to attach live the hung process?
>>>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>>>
>>>>>>> Jan
>>>>>>
>>>>>> Sorry for the delay, but every time I modify something I need to wait
>>>>>> for the issue to arise.
>>>>>>
>>>>>> I'm working on core dumps. The previous core was incomplete, as
>>>>>> you said.
>>>>>> I needed to set the coredump_filter kernel cmdline argument to
>>>>>> 0x7f to
>>>>>> have the complete coredump.
>>>>>>
>>>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>>>
>>>>>> (gdb) print *mon
>>>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>>>> mon->state_offset)
>>>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>>>
>>>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>>>> thus 10 is the owner. Unintended recursion?
>>>>>
>>>>> Jan
>>>>
>>>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>>>> that atomic_t is treated as a 2-complement number.
>>>> Then, the owner is the caller ID. I'm wondering how it could be a
>>>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>>>> I will investigate a bit more on it.
>>>>
>>>> Thanks.
>>>
>>> Maybe I found something: in the backtrace of every core (cores are
>>> generated with SIGABRT) the first two frames are referring both to
>>> cobalt_monitor_enter(): frame #0 is at the source line where the
>>> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
>>> function declaration source line:
>>>
>>> Program terminated with signal SIGABRT, Aborted.
>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
>>> #2  0x00007f0d76612748 in cobalt_monitor_wait
>>> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
>>> ts=ts@entry=0x7ffe7d7380f0)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
>>> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
>>> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
>>> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>>>      at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
>>> ptr=<optimized out>, size=<optimized out>,
>>>      abs_timeout=0x7ffe7d7380f0) at
>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
>>> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
>>> size=19216, ptr=0x55b104844180 <Request>,
>>>      bf=0x55b104844168 <ReqBuf>)
>>>      at
>>> /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
>>> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
>>>
>>> Could that be a clue?
>>
>> That alone does not tell a story. We know now that - at least according
>> to the monitor data structure - thread with ID 10 is holding the lock.
>> If the very same thread is trying to re-aquire it, this will cause a
>> deadlock. And if that is true, we need to find out, how that could have
>> happened. I have no idea about that so far.
>>
>> Would you be able to factor out a simpler, sharable reproduction case? >
>> It also looks like as if the reader is receiving some signal while
>> blocking. Is that expected based on your workload? It may destroy timing
>> constraints, even without the deadlock.
> 
> Yes, I think it is expected, the workflow is the following:
> 
> - a daemon starts the program
> - upon an external request, the daemon terminates the program sending to
> it a SIGTERM. I think this is the signal received while blocking
> - when the SIGTERM is received (a sighandler is installed by the main
> thread), the main loop (where the rt_buffer_read() is) breaks, and the
> program performs some cleanups and then exits
> - in 95% cases, the program terminates well. In the remaining 5% cases
> the program hangs on rt_buffer_read()
> - if the daemon detects that the program is not terminated after 30
> seconds from the SIGTERM sending, the daemon send a SIGABRT to generate
> the core we are analyzing
> 

OK, makes sense. Based on this description, we may indeed have an issue
around Linux signal processing here. Now it's about making it reproducible.

> I'm trying to reproduce the issue with simpler programs, but without
> success for the moment.
> 
> I will update you (hope with better news).
> 

Thanks in advance!
Jan

-- 
Siemens AG, Technology
Linux Expert Center

