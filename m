Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5B22EE7
	for <xenomai@lists.linux.dev>; Mon, 13 Nov 2023 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yufJwU88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdsw7Vr94KZkLThacMrvn7xt2JzNUnLUOu1BRBw6dy7dP0qZXQqh8HDopRvH8fTxrFi973rd8bm2u/XgzNVfiRt7KqgpBOhhCRUUkzrE9co73dpzWFjXCfKW9E8VWkZ//vdkhPuYKAPp2pcllrP9wjMTJ2W3PwFERB7IkjzFjMHovFSK9i6w8SSvaOS5ZzMuMETDB+4+m8SaJLJnc7VyISjsGfmi36p6e7ThAU9jK3v8dFpu19M6mlWjlQ6auqdSTI2/eKtez/WYEB0XRUMUKwvGJUJSadItrlWclbN/fg33S1ob2HdL3RUZFS4hbrT6Q+hC217XI9gYNcbPmbT5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZdHYApxk1eZeBKx/Q/cstTTRlT4/94obt9E31hIqSc=;
 b=TDVPbl83KnKm4w/3JndklzK0kbHt5Cge/otcf9ThdlyD0QlswdFe5ks1aME4u3L21rJQJuT2UrZaaqc/EzrtUFtK2CztUCKSWSGXw2k03xhOq/hxvSBRGeFXx6L96bjm4gS1w5wmDNh6+7+pEh9f1Ek/XSHXyr+RHG5crbEp/xTPFtjP7zL0YM9XgrU+BTHc5PZBpDOXCDQ5gz6JxxWWFA799awDrARCiE09IaK6FwBR52fGdm+Q9C9hrzVXh6Fb2EIUcjjM7qQKbWuRR5/LKb1H1+rHQQ64YN0cKh/85CEl8gLkl+Kz9vCcnOmc/VJnhLzFmedPk75JQoT//2b9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZdHYApxk1eZeBKx/Q/cstTTRlT4/94obt9E31hIqSc=;
 b=yufJwU88pdkkArToFcScbqBzI/RuARkxcHo2BTEnlTldGTp9KR9xuedzbrnaP4JcAxukvoa8GTuvmG29s/6JfVf82eSsNbPToswVaphWd7gmQEqPaPGdvV/91p52t8P1CfU2XWvqhljAr74b1oGLq2zfBjk/23P5k2VaNrfybjm3uzhJrz/hCd5DjncDeuswtruzlSQQvNoPsVkoG6yLiW+BjB9ZoHqf6ttFRkTYtOZo9C0RfYYduwYwgE4KqWYJqeMOBLAnwAlHqlmzynHFFrUl8+rSQ5iEzK/wC70Cp9HaTgtOO528pLCMr/gfGUhP58ywHY7TEESX+Xg3kUoVzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:54:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 17:54:26 +0000
Message-ID: <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
Date: Mon, 13 Nov 2023 18:54:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f26e6a-4702-46d0-2a0e-08dbe471939c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8RCrlqLCM3Eqmlzsgw9/5A3Ur2175pOaYFH+BFgedu5ZMTqvbFStS4Yb6H9XFRrTIsT//KU9PM/UHpOk2Kv3DLQybtV/jpwmSecj6l4h0LTVa/OPX36fPyXXIbEJ3RUkUCGV5F1JMB6IcHgrU8+h8FZGz5XYHziuBihcwfepG+Jzvz5kcODVlxzywgSb55xL35uERMUZoaNV7oVh8J2jIJexCsmNwisDYqCOodukClHIDdUXVIBSuFKxWDievpeYnRChW/zhtI1guTjHIW1JCdGQxdH9+mJn9vnJYQ89gdQiRnPuWNqM8zn43rQrBCP6Dq8MYrs5g8XmssbRQgKvbqD39ssifhPDBEpbrhERCHG0V4OerRKS2Ut1NnYkgOLcQFNY+Fgbz6Ere4iCvbi2Zm+/5wAJnGgdB5FhU7PWlzbnK2A8uY+kEQLn3zbLF0VUnJs3j0OyZz8Bybk2WtuWqUbmaG6+NhC0qB+Vj+L+hlfpt7kyuCahKbmfUcTmMlFcEWNGWdhOUDFowKgtlKKziuHnSPo6jzBLiwDwKmTRz5Vup3ki7IUugtFVHTsRqT28i1FqDQIuISNtOEEMAxkN2R6du+n1oUIqbdN50XQjkYbmEEnTjF+6muClPDlsbeWD9mbWZK+uT1sTUJZz0AhLPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(66476007)(66946007)(110136005)(66556008)(86362001)(31696002)(36756003)(38100700002)(82960400001)(6512007)(83380400001)(26005)(6666004)(2616005)(6506007)(53546011)(41300700001)(2906002)(316002)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WklsTS9jTHhNVGtpc29SMFhTYWsxSi9nOWVBT0VvdkYwRkYreStobW5yUVZv?=
 =?utf-8?B?WFduNjhvWDFWS1VlckI0RWVaU01oc0l0MkNtdEQyR1E5QXdBeWhhMFNuNzJu?=
 =?utf-8?B?cGlvSVFaUTJ5aFlHMUpUK25IOC9wUVNWL3o4Zmx3Z250M2w3Z2VORUlWWWdQ?=
 =?utf-8?B?ZEdiZkhLSE94enJTWlh0b0NoaE9QeGdUZG9zcE1PcDZDTWF0WDZnMXZhMDYv?=
 =?utf-8?B?SitzSlgyaXRBVUVIRzFHeFMxZHdMT0pwRmRkejhaQU9qbDk5YkcyTnkySzlO?=
 =?utf-8?B?RW91Ykp4ajdnTk1HM25YSXlYTThzcmZsc3FiSzNqU2MzMkMvTXZGYmdHdmxW?=
 =?utf-8?B?eTQxSDhPMVpuT21VRXJwK0JuSy8xRXltOERNbHB2VDVXL1NCelZ3RlMrRjhB?=
 =?utf-8?B?Z0Z5WlV4UngydUQ2SFpHdWdTangyQTNoMGJ4dGc4NC8rb2lOc2hWQzdOQWVK?=
 =?utf-8?B?ZG9wUXpud0ZBMHJTR1B4cWFVeVJ1amwyNm5jcVR1dnpZMGdad3NKYjV3ZFF6?=
 =?utf-8?B?RGY0c1IxOENLTS9udjlLQ2FaNmNiWm9ZVjJHb3RMaW5UVDAzdkJwYWpCTXVK?=
 =?utf-8?B?T1lYRkMxTElvTVByT1o3NHJuUVAvK1FBU2xVMmZ1N1E2S0hnYTJVZlRaMk5B?=
 =?utf-8?B?R2Zqa3NwbHJ4aS9UeVBENDd0a3NJYnhST0xzRjRlR0tUZXVGZ2szWjlvSEQ5?=
 =?utf-8?B?ZElwTHNVQjVraXVybVlwT2FCVjBMbnhKcklKdGc4eVhVSjNQeWRLdlJEK2pa?=
 =?utf-8?B?L3R0WE04TGg1bG4zeFlCYS9mZFNUNldiSk9pT3lod2JReFFudldzS3J4M2tv?=
 =?utf-8?B?elQrSkxNZ2hUczQ4RTlXaUNKSUszSDlQR1RnMnR0cU4yNVVCQWFEdWsvaXpO?=
 =?utf-8?B?MDlNd2h4dFhiU3JVcUx4WHBWTHR3d29qYjVUMmZ1M2FiVXRxdDZqMmh2cm5S?=
 =?utf-8?B?amh6RTdHRjN5dVFpeXJuZG1keitmQ2NvUENhSzNFNTVjcnBqbjFpbHQ1Snl0?=
 =?utf-8?B?S294VmpWcHF1K2MyS3V6YkVTektyVi9DS09oeU5XL08vbHM1VFFwdkJHVjZN?=
 =?utf-8?B?OFpPd2hiaFJ0bEdWa08zc0UyQ1RMRko5eGoyM1NqcGJ6bGpEMzMyMThvZEVz?=
 =?utf-8?B?elluZ29UYUxMOC9iS0NWbUtCUUlVUDhxbFFyZGhJTUNJTUdXOWpscVRZSmps?=
 =?utf-8?B?cXV2QjNQK0JYbC8wNWJRM2tZR3lWaG94ZmU4MzdqVHFyQnJYeENNZU5ZODNx?=
 =?utf-8?B?dTZZbm5KRUdva0x5LzBLWndvY3hKemVPTVNGYkRqTU9pTE5MZ0Rqd2kvYS92?=
 =?utf-8?B?MGNQVnIzN3RxZUxvVFhDeXg3SFNhcGc4VG1uTmtpeTAzSDVzSmtnMVZmT3B3?=
 =?utf-8?B?R2lGSHF4ckQydFpjYWFJRHBjUmxJOHdIOU04SGFkR1hzN2x3S0F2N3puczJI?=
 =?utf-8?B?a2ZVZXhUTnpQWUFvTGVjT0RGd0lnRGE4aEFHNzRra2hKYTNlNVFDWW8wcldv?=
 =?utf-8?B?eDBLZ1J6QTd6NUxxSXdnSWw4UGVhTFdqVkw2OTVLa21UYnZwZUkyaXVucDl4?=
 =?utf-8?B?a2RqZjR1T3VER1ZjK0pLdXdvR0FxeHMyaG9QdHBRNXdKRFJXOGNHbjVRTDJZ?=
 =?utf-8?B?aS9lZTdEM0YxSzZtbGZtelVZc1h2KzhEajNTaXFpREtSekpoOXhJaW44UkpG?=
 =?utf-8?B?ODN5di9mQmN0NVR0QXIyZVpWY1AwbFJvQmtJUVd6VjhqZ0NUS1lwKzlMUzhO?=
 =?utf-8?B?enJDZCt0eFFTc2RibzFxNmJLb2JYSXZQYVBDdDUxMW00ekV0VVJuWDhmUzZU?=
 =?utf-8?B?SmQ3cFVtc3RPVEdVRDc4aXJiNFh6ZW96bzdCVTdNTjlMWkJJc2M5THFrRk82?=
 =?utf-8?B?dWNVQk14TWlrTlhlZEVjYUdRcHVKa3Q5WUNqTFo2ZzhYZktyamhrS0V6K2Mr?=
 =?utf-8?B?aldTUnUxRFpsazdDTDZrWmU3N2xEY0pVL3R4aUg5L0FMRlg3NEdQSCtyMUU5?=
 =?utf-8?B?L0F3RThPU21ocjUreFdFYzZqclFIR0VOeC8wQ2NvL0ErUTh0YUJUR0RKSkox?=
 =?utf-8?B?QnVvRnc0WHVTSm8yOXhaNHRNUDVudEJSdjBJWXJqaEFGM2FrUHNnOGJEblNl?=
 =?utf-8?B?SmdXeXFaOEd0OXJ3bGhad1Y1NDFGNmdvcXVXT3krM0JtNnMvL25kWE1MclZx?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f26e6a-4702-46d0-2a0e-08dbe471939c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:54:26.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj5iSyoZzL89rGBvP9T/7+27+OKHlrLraDvdRefY8cL7DkZmg4DqMLJnq9qW9c3ov3GxGS7Ky0bqO7veDnoTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6117

On 11.11.23 16:03, Mauro S. wrote:
> Hi all,
> 
> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
> 
> The application I'm running (a complex application, with about 60-70 RT
> threads) has a simple loop in the main function, something like that:
> 
> while (stay_in) {
>     ret = rt_buffer_read(...);  // with 50ms timeout
>     if(ret) do_something
> }
> 
> The main loop reads the buffer to receive some commands from outside,
> and when the application gets a SIGINT, the custom signal handler simply
> does "stay_in = false" breaking the main loop, and then the program closes.
> During normal running, I can see the timer associated to the
> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
> times "cat /proc/xenomai/timer/coreclk" e.g.:
> 
> 0    291/290         2ms970us           -           myapp
> ...
> 0    609/608         34ms860us           -           myapp
> 
> I also see the thread in "w" state (waiting for a resource with timeout)
> doing "cat cat /proc/xenomai/sched/threads":
> 
>   0  16328  rt     cobalt     50   21ms279us         w          myapp
> 
> Sometimes, in a non reproducible way (at least for the moment), when the
> process get the SIGINT it never exits, remaining in this status:
> 
> /proc/xenomai/sched/threads:
>   0  16328  rt     cobalt     50   -             W          flxcore
> 
> The state becomed "W" (waiting for a resource without timeout) and in
> fact the remaining timeout is not present in the row, also in
> /proc/xenomai/timer/coreclk:
> 
> 0    291609/291362         -           -           myapp
> 
> (BTW, seems that some timeouts got lost, because scheds are many that
> shots, and this happens also on other timers in coreclk)
> 
> This is the backtrace in gdb:
> 
> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
> /usr/lib/libcobalt.so.2

This relates to lib/cobalt/internal.c, cobalt_monitor_wait():

        /*
         * If we got interrupted while trying to re-enter the monitor,
         * we need to redo. In the meantime, any pending linux signal
         * has been processed.
         */
        if (ret == -EINTR)
                ret = cobalt_monitor_enter(mon);

But the problem is that the lock (monitor) is no free. Someone else
holds it, and your interrupted reader does not proceed.

If you dive into mon at this point via gdb, you may find the owner
(according to libcobalt's view) when you resolve manually what
get_monitor_state() does.

Jan

> #1  0x00007f5b15bb0748 in cobalt_monitor_wait () from
> /usr/lib/libcobalt.so.2
> #2  0x00007f5b15bd7497 in syncobj_wait_grant () from
> /usr/lib/libcopperplate.so.0
> #3  0x00007f5b15bea691 in rt_buffer_read_timed () from
> /usr/lib/libalchemy.so.0
> #4  0x000055d2d6e7e689 in rt_buffer_read (timeout=50000000, size=19216,
> ptr=0x55d2d6e82180 <Request>,
>     bf=0x55d2d6e82168 <Flxcore_ReqBuf>)
>     at /usr/include/xenomai/alchemy/buffer.h:129
> #5  main (argc=<optimized out>, argv=<optimized out>) at myapp.c:421
> 
> Do you have any hints about that?
> 
> Thanks in advance, best regards

-- 
Siemens AG, Technology
Linux Expert Center

