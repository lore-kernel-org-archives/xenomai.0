Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966E5CB4
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 11:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOHRbo3+po0JOcLD2aBYS5GtUhaGig0tSMxzLUJ7siKufuC8zWhDswDpwHNIbFcCJ58+C1h/KaH7tlHVcnVZ9CjVnyKfABGuyuEI8T6TBl5PslxL+eDryJHjfDfdz1O3p2q6pweEq6986yp/CHzEs4PSUkcdNfVENBmGh4X/5O8F5SzVg5aQOHexNKAVasKm4cBPCoNAgNWhrdEw0P5BvvIm18DARoKVcJ1ayswKLwqO27MYAgcvSMxVQ6j7oX0i2GEia00rQv7ZMesg+JN+w3oMp4uzANPOqeJ3oamERLNoRnF0lnkF3mXkIBquowh19xHlHo1F75cvODllOyel+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REDQN6p5PM/PX0QrHWPVdtrgrss9dPQPfrrekbLXgmQ=;
 b=lEjRLC8NAfI+aE6h0tJNi8tlDuFE4M6WuoEnAS4DIB1ufvmXimF51o4tDY4veSi0eLrEBjFaIQDUbRt9BRzbV4aq8LYgAbwKnlXwBBJOjnt4rW15Qup5/RZ3gHyMaPqrkKRfF2KjtcLC862tBBfRRhoawgxg7zLGt5QRJVB+HqJKZRsBkAvh8++/QZf5a5gW2XJA2T1LUmhtkrx11SVczEwZWOJG8MwbpR4FV1ioUQB9aihvu4XyyJ01gcSYmmNXsg6j+TFrlzJRkI7jyvMaExeMshojF6IhuuP7Oazmedm5Zz7Cct9Z8abwersE/huFNz9mmCo/yvDxOLQ3NdqvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REDQN6p5PM/PX0QrHWPVdtrgrss9dPQPfrrekbLXgmQ=;
 b=jl7c+kmGSSEpyPgshzTt+BNBJocgcY8szcnx/fjoIszFl6onEh740ixb0xUxWnEEK5j+KqL6R21PZ/T2fWWypEGEhfwUpneQbJjMmFQiGpDpZ4FehgMG/WWYsWgxx2uxIzQTDzq4gohy9cLcM0Xv3tm/+e0ZBNH0Fn5P60V6/yNTPo6KfkCszJ3j59s8EmWD50LhzUJfZmBSQ6Ap+IS8738WZgIe3oFRvB0Pe58Qaj92sFiUNe7b0zuNiRYn58oOmnnzcthfQCbQFhL4/jHkjefCqyyxa4Px8joZ06W/EfBj0X0LmF2fE+t/t2zxxqeVRaGKLFzRaTQQJbqEbenMrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 11:39:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 11:39:45 +0000
Message-ID: <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
Date: Mon, 7 Nov 2022 12:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:610:60::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7097d149-d705-4a61-3da5-08dac0b4c4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1FRNtiWnslFaCIFbXxY1HQ2cQp9hiMPoD3GCAcMQbLSOlxrRoIoRkVNIr+sOS/UoPbhK1GUMVpV/oGbPFiF3y898UmVYlhmN+wIBJeCmFTHUXbo4B1dFIYEphfCkfeAQ8K+tfHFMP2ji2AFgVQHC/yNiFVAt4ijnjlNheTrcKXz2oqwWuM4hvz+nVzG/FC03hV8+2Db6g2a2pi82GowFGgcpCaQ4syxixQK2uQKZbvZjHeRWbn1Z2QNj61FZlDP5+OaSROWTxdZgNONNRlRB8/B7IYLXIkQ6Iv24FLVMkTR/UAPdgAoIgpRh3uJMAhv83OUtXcQfBDwYa1+GkAgQ0aaj8Z56Mo6pbmZx4XjPnvEuwTtVkDkt3//GS/jfuL5ZLcbnNH1P/qxFCwihWlCPHIjMFloAQS7fVjVn75LfruJ2cUZI0JExaOOSvY5/jb6gk6SAojp4GXbaZ1EEjZvkSJ9NeJwUoqpgUs34YC80n16O2Fq1RHEWnhz/XFxskdUGce/apJA/u4Ut89hiJz58TGmY839iJarLkvFygQgTX7pVOywE6Lgbu50qtH64BbeJ5uTnGZ5jItZbu2LUvv82FMcmfIaGKBodY8D5mQTJuQouq1NfRzofO8vFrYEbNbzSuheT7M3WWuhoYoAMiEK0G4hql9YAeQvx1WW6UFZ1a4sspx4951P32wvQVk+lvjiFcSDqu03ADv64k6s17hnnWfdQ5mlwEMQXNz0ffRtBQ4fUxs9jLi/wSE3KcI8l57AWQwPNKRY0hkvQE4yGmEEpS9aw7fGMBPxvXgvXYKNat0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(8936002)(44832011)(5660300002)(31686004)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(36756003)(478600001)(38100700002)(6486002)(86362001)(6512007)(53546011)(26005)(6666004)(6506007)(54906003)(110136005)(31696002)(186003)(2616005)(83380400001)(316002)(2906002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJZN0lKQTZMQ1lRL3NaY3dZMVpqUHdiR2JkRFNEL2ZndVlWdDFVb1BPNDd0?=
 =?utf-8?B?aU5GMlRqci8rVTd1U09UUHpGUUhjZ0ZaOG9EcVpKT2trVEQ1SG05ZXgyNjkr?=
 =?utf-8?B?RDl1RzYvdS9FdmYxMGVERWRJTGlUUWdHd2NDYjh6NFAzZkQrZkNJaWt4OG4v?=
 =?utf-8?B?cFJyeHhyQStyVHRWN2NXUDRPdnpoekZoYjFJK0pmNUc3QVVhQUNBeWszU0tG?=
 =?utf-8?B?M29wZm5ZelRUN3E3U3hlNUhsR3pjdTArWkxYK0xQWitxZzFFcjZzTVJnbWM1?=
 =?utf-8?B?Wm9aU2xKZ29yekhUTTVTSE1ldWhZdTBzbVYrcEtBaVlaZGUxTUdkQkxqMU1i?=
 =?utf-8?B?T0hTZ2U4NFZsU29OL2tydXI4Nlo5WXgwNnNtdEpJSTlUOEVnd1QxeEhDbjdI?=
 =?utf-8?B?L1c2TkhRS3NTa0xXa3k1OHI0M295aGFKdWZWdm1jcGxOd3U2OGZKOWgrbjJV?=
 =?utf-8?B?MFZBSjR5azVvcHhpMWoyNlNNaTF6THE5SG1LK1ArQnlqS0FUTitVaGlmMzZD?=
 =?utf-8?B?RlpqaUQwWmYyM0MzUk9GZmRpRFBDSXl0dThjWTVKamFzV0dmdDhIRHpFV0RI?=
 =?utf-8?B?K1VmNHFaY000YXNzc0ZMenFaYVZxSXF5ZU9WMVpqdFBwTXZVZ1Y2M016ZXBE?=
 =?utf-8?B?S0xuT1RCV3JmTi9qTmhSZlJnb2QzVHpDQmxQUGRrZS9CV1YwenNFQVBrbVdP?=
 =?utf-8?B?dUUzcjNoM0xJWU44YVAyUE1LSTlnVHFHK1phK0poRDBqUzJITjJtaU9YWkNM?=
 =?utf-8?B?aXhMQ0FvWHh3ZllDQzY3RGhPMVVQdzF3NlJycllFdGNSVjhFcUJFMzFZU2sv?=
 =?utf-8?B?RXVMSExzNTFZQUQvMEdvMy9vSnBOeUZaREJNVVRtUERmRDg5ZGQwSFViYTcx?=
 =?utf-8?B?TnVaQTJIUXJNK1h6ZUR1ZHRFZDQ2OEJjR3Yzd1BNN3lHWktrVVVFLzR5QkZQ?=
 =?utf-8?B?c3BtN2VCSVZkU3lRL2I5WTQyenY3RldWWkdCNkxlK2FIcWk1UTdrUVpVbm42?=
 =?utf-8?B?NE1SbTB5MmE5aEUzcVQ0a1krbnVnZG83dVJ6d25nQ1FhbHF6UkJ0MDBwL2kw?=
 =?utf-8?B?U21nMHByRHhLcXZjT1BDRTlUY1lXOGhjeGgwVVZ6SmNVbXBKcVNTTHVjZTAr?=
 =?utf-8?B?U3hMMnB3SkJsczlBaVNEUWJySU5xdVpTZHFjOHV0K2w0ZVgvU3pIK25DYk1l?=
 =?utf-8?B?eFppWndVQUQ4cWRYZlJ0T3dDc0s4Z1pHdVlKRXE3ZUI3UkoyNFFUeHNKWVBU?=
 =?utf-8?B?UXdNREpnazlpbkhheDVoSWNBVnhhOTBCQjlLM00xcnZQWjdYWDhZc1NGcEVE?=
 =?utf-8?B?Z2JJcFQyZllVcm9Dc1g4WFVIalVCQ2VSdzVTdGVteFJIVW85V3Z6Mmlhd3g1?=
 =?utf-8?B?ZXZVS0gxa0NDSEVxRXMvYVJVbnVJWW1pUTJ0dzVXN0lnTEFYL3lreGE5TWJw?=
 =?utf-8?B?U3RGNXNtMGJxRk11cEZmaXhzeFFPSFc3MFltZnZONDZxL0UreWNRallXamRy?=
 =?utf-8?B?cXdSeHBYKzl0NTJtODI3c3BQdm1XK05YUlNUQkNieGdXN09JQ1VZeEhmSWQ2?=
 =?utf-8?B?Vy81ZnBMU0pacDJ0ckh3TTZ2bUtTd2djQnVzbGJNVWU4eWlGZ2NyVHBMVjRU?=
 =?utf-8?B?Z1dvdnBtdkl6dDA4anZrNHd3Ri9udVE3M2xRQVBlUXVtcHMvTStEaVNRcU1t?=
 =?utf-8?B?c0NnamhKK1NMMlQzZjVkcU92VU5HWFh6ZG9NdXRVYU1QSVRGOXdSbmEzZVlx?=
 =?utf-8?B?Y2E1NEI5Z3pNaExPQlBWOFJuYnNzMGQwM0FRaXBCS241UnNnUkNMNmhadmdM?=
 =?utf-8?B?UXIwQjh4dk5WSk14Qm41enlucWk3Y1YzS1pLblNDTlNDTmFrLzdOdEZGUGlS?=
 =?utf-8?B?cGcxU3BIZldYOTcyalVKczFyQTU3RTdRREZhSXlQdW1takZkekprMHM1Tmt2?=
 =?utf-8?B?ODRNaWFEYmxuaXVXbTB3ZG1WUVg0UDZ6UkZYMVVaWjV2RE03Mm1RN0UzeWNm?=
 =?utf-8?B?Q3Nic1VLeDRlUjlXQUtlNi8wSElLUGU1Nm93SkhCUUxNMDNvSmErazMxT1BD?=
 =?utf-8?B?SWVDVVB1VWlFN1VXOHdKUDlhekVFMGNDV3FibFR5SUpBeGxmdTM4VE5lTzls?=
 =?utf-8?B?aHQ5SHdnRGtFQnhaVlRvSExYQjZqdzVVS3BDem1GdnBGZ0wza2dhODJYMUlK?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7097d149-d705-4a61-3da5-08dac0b4c4e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 11:39:45.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QALboGBaoeh5wbvqzxOGAvvbJ1H/5vWCWIuLh+ucLB5Wjx8hb1Eij+/nCMtjFOKadbypEOncvkgsMsqQuG+KOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5420

On 07.11.22 09:42, Jan Kiszka wrote:
> On 02.11.22 16:48, Jan Kiszka wrote:
>> On 02.11.22 16:34, Heber, Stefan wrote:
>>> Hello Zqiang,
>>>
>>> We tested your 0001-IPIPE-ignore-xenomai-FPU-operation.patch on our system (Linux-kernel 5.4, Xenomai v3.2).
>>>
>>> This patch makes the problem disappear with our tiny testapp on our system, too.
>>> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.
>>
>> The patch is surely no solution, but it points to the direction where we
>> need to dig. Unfortunately, I still didn't find enough contiguous time
>> to start that.
> 
> I'm starting to understand the problem:
> 
> Somewhere between 4.19 and 5.4, the kernel moved FPU restoration for
> incoming threads from the thread-switching code to
> prepare_exit_to_usermode(). However, this path is not taken when
> switching in a primary thread, at least when it's coming from secondary.
> Need to look for the right way to account for this now.
> 

A first, so far promising fix attempt:

diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
index 7e28903a42..8bd2cd912b 100644
--- a/kernel/cobalt/arch/x86/ipipe/thread.c
+++ b/kernel/cobalt/arch/x86/ipipe/thread.c
@@ -443,15 +443,19 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 {
 	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
 
-	if (!tcb_used_kfpu(to_tcb))
-		return;
-
-	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
+	if (tcb_used_kfpu(to_tcb)) {
+		copy_kernel_to_fpregs(&to_tcb->kfpu->state);
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	/* redo the invalidation done by kernel_fpu_begin */
-	__cpu_invalidate_fpregs_state();
+		/* redo the invalidation done by kernel_fpu_begin */
+		__cpu_invalidate_fpregs_state();
+#endif
+		kernel_fpu_disable();
+	}
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	else if (xnthread_test_state(to, XNROOT | XNUSER) == XNUSER &&
+		 test_thread_flag(TIF_NEED_FPU_LOAD))
+		switch_fpu_return();
 #endif
-	kernel_fpu_disable();
 }
 #endif /* ! IPIPE_X86_FPU_EAGER */
 

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

