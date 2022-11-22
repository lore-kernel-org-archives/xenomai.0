Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848B107A1
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 17:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOkpyC1GdpbJGr8gaYzCA+JfD5REj3Ph/5zuBhP1Qqy+5EKYrhUEdSxcLIIcmOv6DH/8fBksrptU80N+D8IbkqhhgzKvgehvjZ/B+v0uY0Odb8n7KhsbEI7I/EquPwAoRi6G1isM07kOx4O+qpfboP1qtq/XcUYGzl76OmmGTuN69E6iV8pStnlYZFHdlxkzXRxOvig355icLt6JQ7HNvkTPeERtlPow3Iov9KgRJAmLbNLvz3ySNCW+txppb2pTkTGgB6v+BVOUqHzfh3jqLVygPckQjBRBFwPwESO0om41n2Uz7e8nBOJgHgBX/2cgcQd/y7fCW27ZWh0bptOVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhYdnVO08203xsxr0wcpxWbG79vfsRmKtrK+qx+xHbQ=;
 b=Ofu5O20m/LFooKSGJWpCVB24iFST23aA5Cj/yXOxW1Pbl0eGEzLyh3pbrkOFofmg05m5x6t+VBVkTabzxNTBkV0rElPgQ8bms623E/E4f93/Swiqykg6j8E6ij3rG9O4ytLm++t9W1NUdrtW7uir+NcMbbpQbQZzZK7HYU4WOoN5aSyexef3Y+9zdf1hUQ4ak7/z9/LcHrj4xjUKIKVLPPCCzjIVtLcCmppMHk5QFXuaK6akdyGydUyzRken42+2pnEzeYlgQDh8TN+K5HEeS+la1qOYx8993dHXeruYsmv8YDCEXTuBPF0kfWpi5H2KloETYAp2Kwx6VXKGlvKyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhYdnVO08203xsxr0wcpxWbG79vfsRmKtrK+qx+xHbQ=;
 b=tsUQA138BlbVk2UNrix2kVd8QRggT1PUoac/rm+Crdlm81sFUcS8HJo/KCBQnIUOt6Q/xTkGqxI5Q7B2hfY+WQYLHhcdhtr5v7xjMyaitn4ch+72utETMjr5FHekTR/Fxre/G368ncDs1VMG+DS8pT5H/jEhe7vq4+jksqkvi4dVmLwkz39vlswN6+UbOi7sVbJ4gFWfo4M8tXIpeOw79+YvpaY64jI4F8i1iMc3C5JDLzy+N9qJ8G2OneEbavTsvl6hs9AhcJF47V9qpsvXUvrTMxywthjDICiK/MHGlFa2e3RGVitme1V7YMP4YaNslcBQCdaDoW8S9UOzKNrtzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:50:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 17:50:35 +0000
Message-ID: <ce6ce20a-f81a-cc38-3183-a5935246af91@siemens.com>
Date: Tue, 22 Nov 2022 18:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: "suspicious RCU usage" in heapcheck driver
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <0835bd39-0dc8-e767-b39d-ee316f6b7ffd@siemens.com>
 <87a64j9zxm.fsf@xenomai.org>
 <0d485cdd-62eb-37e0-c60c-826565d957b4@siemens.com>
 <875yf79stt.fsf@xenomai.org>
 <81338678-744a-4ede-875f-d04f8d38255c@siemens.com>
In-Reply-To: <81338678-744a-4ede-875f-d04f8d38255c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: edbcb903-b711-4bd3-9620-08daccb20e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bCDsk8RUKty3FT/XBo3JN2IqTgDQhBExYOM6xV10nAZ3USXdqAleFa6Z8/yeaGlLzxg5f03/MMfKlMijZ+K0lDM8lo7bUapMWDQAMob+NRfB1c6sEkAxnUBdNZJ4+NqTo8V4luf8GBXPGqd6RMYtefd6kQynst/asb+k2Dt4AcCRGzj5ni2b1gysLEqygxSZLIyccWnVvLLePkGy/ozBkHrcCU1P9wF+It1UNruJrev0CUvCRUXfgVRBwAFijdmrXzntCTzkZXFVOa0T+8jTsEzERc0xJvgR6Y+jjmL0x/FNyhQtoLUtIpGCCihzrQEV10OnG7C8r+RjnzmoZsLsf0qjz/Grdao62wqB2GUeTe+1K2iVCX3XaVfJLEXqARyIU7S0zajNvw+y4r1d5wr6xzFT/Evfxw29l4b6Dn6WV02OsNngyTGVBJuNa0gnuqpKdZ2n7bh3jUsv3DsQGRPfsiuIbhNoqBrZ6Q4Qtmy2jrwC+05Q19+3pwBTQe2Uz3otwPV/zZmZcDIDR/SdKFvfunTxUGRRWdEO8OED1d3gw4y+HWUozUZJZeQ6QPQZjvE524fjQ8fjE0ZTCTvQpEu29ncsRrlrnHprPNr/VmAl0Su1VTp8aKw/hdQyRQsPkHfcYF0zEIyQ3BDVCo0+cLesbYBSlgvnrJal+ggGgpwWUfrTPeb07QjBgyeqMLdZ2QZozhUxY+mRUQWdk79acu+TXulrWb5bGe+QHRafU1HvgZfID2Dt5quVfsFpBGfZtWJB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(4326008)(41300700001)(66476007)(66946007)(66556008)(6512007)(8676002)(86362001)(31696002)(38100700002)(6916009)(26005)(316002)(83380400001)(2906002)(2616005)(186003)(36756003)(8936002)(44832011)(5660300002)(82960400001)(478600001)(966005)(6486002)(31686004)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnhyTGx3SVlneER6MDIvNktVOThNcWpFV1h3KytYYjkwb2E3V051dXp2TGJj?=
 =?utf-8?B?TDczNG5uWEovUzBDeTRwRGp4emtENTJteU04Y04vVEZLMll4RGFQcjNXQzhO?=
 =?utf-8?B?RkJqbm5ZSjkrZENoUXJIclVLeXcvNlAzTE1FVURVbC9VK0YyVEkvYUxJSDB2?=
 =?utf-8?B?L0k5K2ZFbmlPYkU0WjJZNm5RTVhjVC9sT25RN254bGh2OUpzYVBMMzhLZ1Fu?=
 =?utf-8?B?clRiZHBWMGYzYThpeEZvZTlvZWdkVFZuU1ZOTnR3UWJ2dSswTVpZaVpBQ21w?=
 =?utf-8?B?WWhrcUt2VjR6ejIvTko4S1QrZzB0NzZZYWhvT1NtWGlKRHIxVUQ2OWdhZVFl?=
 =?utf-8?B?bWM5bWt2Y05KOFZML2Q3Qi83cUxvcXpka2tlbFEyY2hHTnE5NzVOUmdNQjJo?=
 =?utf-8?B?UE5PRlZ1b3dYbVM0L1VrVzJoOTNEeHFKOG9QNzAvbWUwQXJLcFczT3N3V3k0?=
 =?utf-8?B?a0JYTVpnc2c3N2tkV0pvL0pMQUR4bnAxUkJreTBOamw4OVhiQUtVVFE2MzRW?=
 =?utf-8?B?amY3YzUwWlBEMzJLRjdTN3JJTEFLTVU4bDFzb0pmQ3JyU0tmNk9wVms4dGlP?=
 =?utf-8?B?UFFleTJ3dk1FMElHbXByY2V0NGFkN3lKMjF0VVp2RkErZ3FEN0FUM1doeXd4?=
 =?utf-8?B?ekE1UjA4dHVTVkFpdERYWWlOQkpVR29PdnkvTkVOa21jdCtYdjdHb1crUmZt?=
 =?utf-8?B?dEg1YWpWR0pUQytNd3QzaEVUaHluQmNsd0YvSEptTGxVRXFYWG5Fd0cwQmI0?=
 =?utf-8?B?T2dxNGFaQU4zbVZTdjc2eDdUckVXR0M4MlBrTHhtQWo3MkV0MGRIMnA5WmpX?=
 =?utf-8?B?QXBTeE1JL0NKVHVUc1ZoZGhoMFZsb2FyUDFoTjlwSk5XckVzbklETE5LY3NW?=
 =?utf-8?B?dTJ2WDd3YW1vTVN4TnV4Q3VoQncxUE5kUStYa1NBaEc4MWZxenh1bDNrQXRx?=
 =?utf-8?B?QWQ3Mzl4c0RiQ20rVlczenZNaFl3dzlxWm5EZWV4K25QeXBTa2lYRGNyTm10?=
 =?utf-8?B?MzhrczJGRWVKUTdMNkVPalU2ZnBXUHJVbDBPSkRTL3Qvb0MrblQ4ZGJPakVI?=
 =?utf-8?B?ZU95SzFVaGdMaHdSS1RqNUtXWm5UeTV6Q2N3eXptWHNQeVZOa3hKVUQ4Y2E1?=
 =?utf-8?B?MjVza1Fab1NMendoTGVJNHdwNS85d3Q4Myt1SkMxbzhzbTdaSGM0MGErVHhs?=
 =?utf-8?B?aGtvTy9aejBjczdvOXY5UUJyNzZpeGpkRm03V01DLy9JdUs4dzhuY0pIclJB?=
 =?utf-8?B?SlZWbmM2SlhWOFBwbVVXS3A5dDVLQWlBb0pERm1Lejc0MUtVRmFtNFU4ZVYr?=
 =?utf-8?B?eUwyZGVYTUxiYitsaDN6aStFN2xnMEVlcnN6ZmZYVUo4aWVVaWNtNnpmRmRN?=
 =?utf-8?B?cnZhMWk3UHNPRlZwT0ZjZUI4TTk1dGYwTEhLV3JWTEVXVVlsb2pPSThBcFVw?=
 =?utf-8?B?bG9jcmlKMVhNWkFIaDJmaVBUTkdybXdMekRqM3gwdlBSTDdSZnRNak9LWGM5?=
 =?utf-8?B?WFN2RS9LQTdoamRXaExpaW9qcXBFUSt0Uk82RTg2NFVVeWxKNHNjaU4xZ3B1?=
 =?utf-8?B?aHlEVVBsa1pObDRHZzM3aCtvSkEwbHZwbTFzRzlGOS9JakRLNXRxR1hiS3E4?=
 =?utf-8?B?dGkvRlZhVTJnSnlidzFGa2orc04zdWpBYnBWdTZGR055VmIrcDl6OThNMWQ5?=
 =?utf-8?B?NzNKTzNYczVnZ3NsRWtsRDZENE9LYmkvV3N4RnUwaXdiWURRaFVtbzFWSnl4?=
 =?utf-8?B?ZnhxbjMrOVBKMlN3aFZydlVqYlpyeUZ0ck5CN0tXeVhYdDVMR3VjQm1MbHVF?=
 =?utf-8?B?QUhoM0Izb0RNZ3lualMyNFdQNEN5b2dMN3VqZ1VNQVZoUHk3Nnk4RjJDQ0d3?=
 =?utf-8?B?MGhBbDZJRVJkR3luTGZQOURZa3BFYWJBZDlBUHJybFBkc2l5RXdkbCs0bzA2?=
 =?utf-8?B?SU1Xc3dKZkk4UHU1TzkxUmdsVytNdFRaMlNLSlZLdVNjZ0lXT3FId3BORktF?=
 =?utf-8?B?LzQrWEpvbXZlL0NuNzloWmxLRC9LVk9Ic1ExVytKUkhkMnB3SEhZZlo4cWFw?=
 =?utf-8?B?NUx0OSs2cE5xY1JxU0VNWUxaakZJOGlDOW5Ib3o0Q0wySzVGTmxmQlREVEh2?=
 =?utf-8?B?SUd2Q3ZjemZ0SXZORWJVMXRoaVZkVUVBNUhZZFJKcTBPQ0MrTVltOUdwQndq?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbcb903-b711-4bd3-9620-08daccb20e1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:50:35.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DmWkX3KxL31LIs8FqqzgUZnsPJO2jTVyw5eZ1E++ULjca1P2YbKxqv5Rb8fKLjTLxwIm7zsENQqeokiOPAhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6611

On 22.11.22 12:55, Jan Kiszka wrote:
> On 22.11.22 11:38, Philippe Gerum wrote:
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 22.11.22 09:00, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> while preparing Xenomai for recent kernels, switching prandom_u32 to
>>>>> get_random_u32 [1], I triggered some RCU warning:
>>>>>
>>>>> [  515.060011] =============================
>>>>> [  515.060011] WARNING: suspicious RCU usage
>>>>> [  515.060012] 6.1.0-rc5+ #10 Not tainted
>>>>> [  515.060014] -----------------------------
>>>>> [  515.060014] ../include/linux/rcupdate.h:740 rcu_read_lock() used
>>>>> illegally while idle!
>>>>> [  515.060017]
>>>>> [  515.060017] other info that might help us debug this:
>>>>> [  515.060017]
>>>>> [  515.060017]
>>>>> [  515.060017] rcu_scheduler_active = 2, debug_locks = 1
>>>>> [  515.060019] RCU used illegally from extended quiescent state!
>>>>> [  515.060019] 1 lock held by smokey/1435:
>>>>> [  515.060021]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>>> __is_insn_slot_addr+0x5/0x120
>>>>> [  515.060049]
>>>>> [  515.060049] stack backtrace:
>>>>> [  515.060050] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>>>> [  515.060053] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>>>> [  515.060054] IRQ stage: Xenomai
>>>>> [  515.060055] Call Trace:
>>>>> [  515.060056]  <TASK>
>>>>> [  515.060058]
>>>>> [  515.060058] =============================
>>>>> [  515.060059] WARNING: suspicious RCU usage
>>>>> [  515.060060] 6.1.0-rc5+ #10 Not tainted
>>>>> [  515.060061] -----------------------------
>>>>> [  515.060061] ../include/linux/rcupdate.h:768 rcu_read_unlock() used
>>>>> illegally while idle!
>>>>> [  515.060063]
>>>>> [  515.060063] other info that might help us debug this:
>>>>> [  515.060063]
>>>>> [  515.060063]
>>>>> [  515.060063] rcu_scheduler_active = 2, debug_locks = 1
>>>>> [  515.060065] RCU used illegally from extended quiescent state!
>>>>> [  515.060065] 2 locks held by smokey/1435:
>>>>> [  515.060067]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>>> __is_insn_slot_addr+0x5/0x120
>>>>> [  515.060073]  #1: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>>> __is_insn_slot_addr+0x5/0x120
>>>>> [  515.060078]
>>>>> [  515.060078] stack backtrace:
>>>>> [  515.060078] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>>>> [  515.060081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>>>> [  515.060082] IRQ stage: Xenomai
>>>>> [  515.060083] Call Trace:
>>>>> [  515.060084]  <TASK>
>>>>> [  515.060086]  dump_stack_lvl+0x7d/0xb5
>>>>> [  515.060106]  __is_insn_slot_addr+0x10e/0x120
>>>>> [  515.060112]  kernel_text_address+0xbf/0xd0
>>>>> [  515.060126]  __kernel_text_address+0xe/0x40
>>>>> [  515.060129]  show_trace_log_lvl+0x18c/0x3f0
>>>>> [  515.060152]  ? dump_stack_lvl+0x7d/0xb5
>>>>> [  515.060162]  dump_stack_lvl+0x7d/0xb5
>>>>> [  515.060168]  __is_insn_slot_addr+0xd8/0x120
>>>>> [  515.060171]  kernel_text_address+0xbf/0xd0
>>>>> [  515.060176]  __kernel_text_address+0xe/0x40
>>>>> [  515.060179]  show_trace_log_lvl+0x18c/0x3f0
>>>>> [  515.060196]  ? dump_stack_lvl+0x7d/0xb5
>>>>> [  515.060206]  dump_stack_lvl+0x7d/0xb5
>>>>> [  515.060212]  inband_irq_save+0xa/0x30
>>>>> [  515.060215]  get_random_u32+0x2f/0x230
>>>>> [  515.060228]  heapcheck_ioctl+0xa42/0xbb0
>>>>> [  515.060244]  ? ktime_get_mono_fast_ns+0x3b/0xa0
>>>>> [  515.060260]  ? rtdm_fd_ioctl+0xec/0x340
>>>>> [  515.060270]  rtdm_fd_ioctl+0xec/0x340
>>>>> [  515.060284]  ? CoBaLt_fcntl+0x20/0x20
>>>>> [  515.060286]  CoBaLt_ioctl+0xa/0x20
>>>>> [  515.060288]  handle_head_syscall+0x115/0x5c0
>>>>> [  515.060301]  pipeline_syscall+0x85/0x120
>>>>> [  515.060307]  syscall_enter_from_user_mode+0x3f/0xa0
>>>>> [  515.060312]  do_syscall_64+0x15/0xb0
>>>>> [  515.060317]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>
>>>>> From my understanding of the code path we are taking here, it's a non-RT
>>>>> IOCTL that should be fine to take random Linux locks or disable Linux
>>>>> IRQs. But 5.10, 5.15 and 6.1 all complain about being idle here. Any
>>>>> idea where we may confuse lockdep?
>>>>
>>>> This syscall is processed from the head stage otherwise it would have
>>>> been routed to handle_root_syscall() I believe, so the issue is most
>>>> likely with rcu_is_watching(). There is a fix for this in the linux-evl
>>>> tree [1], still in the -next branch ATM, will be upstreamed soon.
>>>>
>>>> [1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/03d19b028241d0385ea72e91481d7468d806ffe8
>>>>
>>>
>>> We are coming from head stage, but the caller should have been migrated
>>> to Linux before calling the ioctl_nrt handler. The whole purpose of
>>> that
>>
>>> [  515.060082] IRQ stage: Xenomai
>>
>> As a matter of fact, the core thinks that rtdm_fd_ioctl() did not relax.
>>
> 
> Indeed! Just confirmed with a WARN_ON_ONCE(running_oob()). Then we have
> a different issue. Debugging that one.
> 

Argh, test_seq() switches itself back to primary after its non-RT
initialization, then eventually calls the get_random_u32 which fails,
and returns to secondary before returing to the caller.

So, the problem is that old prandom_u32 was oob-safe, get_random_u32 is
no longer. I don't think it is worth to harden it for this testcase, so
we need to look for some alternative algorithm. Pseudo random should be
fine here, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

