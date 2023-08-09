Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4546B0
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 06:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC7v+L9NUTQGBJFtbRLIJztQ5/3ZLcLfxtvSNFBuEOBko40jpo9KJlWEo0RYI3P1c0unun7JBQvNUCwpQncXU8NR0G9aVHCEmKYzO+qB2PePDllLVETBpsN/3Bb1wbqeW2F6iaCORMQ6bIEOduff/b8/uGo5EwJ9FPT1GHN/jlvTNeq4W4ID/nYkNciUh0OydTSs64+Ju7HdNjzjIfwkNiXUVoGva0lHZQizcbpRVBldGHpPpvhXuzOMZ7urUYM+2I3Y5SGhuBDNULg9RRqTP6WxawfPucG0XvfephFujrHERdRCVxo7mYJZu930TsU1j6gch5TrFsIguqfEWTnJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m7fAwcRMa7VWOHI5qi5cBn/daB+ISNpqUTcjKztAqg=;
 b=jMrhls0uz+NugwVnqiVsMgc6Z6f5sQebb7EPclmZvN6Bkzr2MLtpBZqDlotjQRlpEDtCSlWhrSkSWPoeWi1PyodXvxqPeEigX6IR8dZ3RKJ1jSgc1ih/ZMnwB8mqlO96GtZY+rHKb9mWGfg6Pw0OMyoXInRGil14c+KhVU2pWpxwFcQN2xhh1CSniL6gJQAXhfwoEweuBv50SRYOZ4mDn7DgKqFw/j5dHsSmsj+voo4NypCiq8EJweFO88/MmD+AcN813zloudloj8S4p7PMRMiXKVOxEg+GWSZ/sicrTIzH+rZ1szhE3VohTRH6OBBvV+nKuyE268hUcu1VLELRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m7fAwcRMa7VWOHI5qi5cBn/daB+ISNpqUTcjKztAqg=;
 b=iakvwhGyB8876g1rIBOC9plrnCIo8oY1Mo4EHoyQ+tLf3np+9lElTwlovXhoXydlaWr6R1B8zo9USDiVYNMEeLjT0Vj4dFjyJuujQ3bANfV0dO9yCdYxatYYUyOsQkkpIWpdySkOzpZKvCiyuBJsQxf4lOrXoNqWOwo+AgfHmNboPMjDe7epHA0lWLao/sLOx559YExhQJ1X9+TKovFS5FAgaJyroJCHrkL2AE1MfzRn9gQKtwv0nwAVk6FS8DEXcOYz6B0UMlxGRVgZrZ5OCt1/TgR6HpWakIq30/gv78DvB5uSQ5eNKZQt71G44nxhxM5+ubPv/I2HwhwGXM5Hyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 06:47:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 06:47:14 +0000
Message-ID: <229a4014-508e-e1dc-6546-2e01d3ff9252@siemens.com>
Date: Wed, 9 Aug 2023 08:47:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] y2038: Add time64_t support to scheduler and
 thread APIs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd1a4c6-7214-46f4-d8b7-08db98a47733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2v6lNcm4XKxg/0cjqQfMX+1rVs9GlKvQAY/6hUKbyV73ZPHVN52KnVAfTqBrmH9jLpupkMhxLqMtjOD9XOp3E5wciVtQ6+A24gqPuYp3l63XCrtBJ0TqFV0v/mhP/skdYT6Q0SzKIgNjk2LBksplM1i4EwrDXGSfeGVRrxvHsN3a7FXuBDk6Wo7TwYMU6m6pThyGK2W2CkzO3ibs7ElhGyaq37yd9PEXUpLxhip+viAiTBqNIaeshZaANVr01wPiRxZSvuHlu6aMA+VtTIMSOiAm259PlA1FBP4yMBSKScdY7zxIvgverjyulVbIccU5oFbpZ/9BXOmRsyM06XyNaZoZCkVS7hV6X3K0tMTsmhDxZmzWWaUF3h1AMQucdPMi4af4Pck8ngnUYj+81et5PMTeldSp3UaJdNYavUQmfMXSLyZKjrjEjZKVS7+vXM+XcEho6CsywiNZMqRVCq6yopsHiQCEfMYDgtjQOeyImp4hStgO4GqYJH9uRA423lcXOqGAoBB8t7LRxH5u7G/sdQYwNnzLKruYSmWSwcj6bwrwOGIMYDxBG+43VUaTAI6yhISWk6Il1mgLTgC81P/507oyKity7cDU5v9339T5EKaUW7m5LMoCZUhicBtmLbxFeObc4KDokMUMaAIzgtZ9FHJDRDPmvac72AekeCm0goMAra/vZWj3+pYAAQzNMYwz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(1800799006)(451199021)(186006)(8936002)(8676002)(44832011)(5660300002)(4326008)(316002)(41300700001)(86362001)(83380400001)(31696002)(2906002)(6486002)(6512007)(966005)(2616005)(6506007)(53546011)(26005)(36756003)(66556008)(66946007)(66476007)(82960400001)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXg1SDg2RGdENnNyQVpsM1ZPbkxtQVhMZFp4eXdNQ0t1Z1NHK0p3MGJsZ1ZT?=
 =?utf-8?B?VW1IN0U4V0kwSkJuaWJTaUVSNXNZSWJrb3RJR1lpcGxkbXBzOHdid01ic0lM?=
 =?utf-8?B?bm9TNUdQNmRaREcrcUNVbzVUVnZySVpTTERsQmFZeXk2emlwVG9OYnlVV3Bv?=
 =?utf-8?B?S0tkWi9kSUZQM1pseHJpUUJKV0lpOEZTbUFWNFpFb2hLUjdyZGNKTXJ1SkRB?=
 =?utf-8?B?ekRFU3hENGh0Z1BXYTFHZCsydllUL3JmQXVUWHpobzRvQzU5UW1JUldQbTgy?=
 =?utf-8?B?andLK3dlYVVZOE02L2dxTFkxSmV3UjlHS3pGb05Gb2NJS3JteEc2SlJoVlh3?=
 =?utf-8?B?VTZhbFg2eDdtZFIyTjhuTXg2SkJsUzlHMXRlNFlIdW1SQ0RDMmxHU2h4RHRU?=
 =?utf-8?B?bk1JOVlFbXBvdlcvaHJ4QWpYK0ZiZmZTa0JNSHNkSDd2MS9iNjBYODVGblI4?=
 =?utf-8?B?MXJTZnZ4NzBGSGVienJNMXF5dXZLZ2ZYWUltWGhCN0tBK1d6QWFHN0pPeGxE?=
 =?utf-8?B?eXh2Vk5uM0hIQVJHanpsSnpNb21pY2h2K0F5YlFjRmtEamIvZTBDWkZRNVNk?=
 =?utf-8?B?OTJvbXUvWVAyQnFUcHlSYU1oWTgxSW11VDdzOUtPTHd4bU5NejZRUzdQa3lU?=
 =?utf-8?B?VXFJZzBiWUM1UUhvcSszSVRsWGRvcTdQKzVzOWhSTGtLeXN6QTlSenZqem9K?=
 =?utf-8?B?b0Evem9lcnBUTHVHM2lYVFgrY0E3U0daaXljbDBYNWF4c0ljWm1PM0ZwYUQ4?=
 =?utf-8?B?V0JFcU1aNm5xa3drMW1qY2s1bytxblBPS0FiYm4wLzVXdFVYS3phM1pWakxX?=
 =?utf-8?B?MlM3QjVyMVJXMVo1Y0JYaDR2b3d0SUFnajFrZEJNcWNLelhIQWNPRUczajZu?=
 =?utf-8?B?U1UvcmVOc1R2UVFESUl2OVdEZTNwTkZZUmRpSU1ZeXdqb09RbzdZQjlBbnVJ?=
 =?utf-8?B?Y0VBK3M0OHVOWnQ0MGx6WXlEbmFRRURKc3llMUY1alF1b0JYcjVSK2FGL2Nm?=
 =?utf-8?B?TzE1cXh1b1JkZzRYREhJMXpJNWtyNmVWTjljb280dkxVM1ZWbndiZzlLemo1?=
 =?utf-8?B?MFpDa28xSXBRUEpaZXV3UldvWVlOQTdIWE5tQWdLODdxY0JTQWIwNno1Tmcw?=
 =?utf-8?B?M09uYW1EcTdIcEN4dnE1blpsbVlFQTNsaU5kRElRWjhTYjNka2tCMXpKMjJi?=
 =?utf-8?B?UXFxc1JXNVV3MUNzUDEvSDRTQzRhTUxNaXBQMGowU0ZTV1h0SXE3YlMyL0dU?=
 =?utf-8?B?aUJGRkJwM1d4dUV3dElRbFdIbER2bzUvd0w1RFY3U0dRN2NQSmc0NFJJVjlY?=
 =?utf-8?B?dnhhWWVQM2hmWHVuZmFCMFpjdVlyUEFERjF6UDBQL3FhclVPWVRkV1FvQTJD?=
 =?utf-8?B?emwrUUFVNWx4VUlCZm96OTdTVjM0TlB0SjdDRWRKVm52bWRLVUppRGR1WlY3?=
 =?utf-8?B?Q0ZIL214eHpjSjlPQWtjSzRkRTYrVkxQTnBYZ1dDa0R4NkRoZWVtNmplM1d1?=
 =?utf-8?B?VVN3QXpaemVoWkZpbmd1aVI4b0FDWnVIanBrNzlITUFIdWxYY1BoRjJ4Ym1Y?=
 =?utf-8?B?UEVVSjc4dXRzSjltNFN2MEQvVUhIeDI5NExxNVFDU0dDQ29MWjlvN1ZXUUNY?=
 =?utf-8?B?TjU3ZGxCZitpTk5WMFhMN2FPTkg4OG9Ed3IzMHU3blhOWGZSR3BPTUVzQ0tk?=
 =?utf-8?B?cmlsM0cvQ1dvVkNhN1FWN091eVNqdUUwV3dtb1RLODhNSmpuRHNHeHZ5YkV0?=
 =?utf-8?B?SlZsREFXZlpwSzlqeTBUR1EzMGt0ejBheFF1a2Nac2tTSVBVbkVGbWx2dDJI?=
 =?utf-8?B?ZkZFbjBpcWp3YTJEUS9uZnNmRDZMY3FSNlBvTlBLaWlTT24wYW1tZVRibkly?=
 =?utf-8?B?UlJQaXliNXRLbFEzQWR2dFhFeVVGaHRPdUJXRy9jbDFhUXpMWjRIQWNYM0hZ?=
 =?utf-8?B?cDgrQStoZ3BqWHBXNUlHVWJxZHNQa01tclF3dE9oVEdic1lieE9pdXEwakRN?=
 =?utf-8?B?U2E0TWtKVG1vN0ZVaVBJS242SUtvbFMvM3g0aHFOdzJIYWdiQzNJYTBtQzh5?=
 =?utf-8?B?eGFoSG1SRng0TkE5Tjk4VmhSRUl5QU9GSWtCamNIc0ZXNFpkUk1HWmZ6ck5R?=
 =?utf-8?B?dFExNkhzVUhTOEFRKy9ZL1ZEdVhoNGwvbDh1cHNoaHBtdXllYzREV3d3TG9Y?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd1a4c6-7214-46f4-d8b7-08db98a47733
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 06:47:14.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4z119WOTQ5ghx4d2CzvHJfr4NXBf5HLBzHOFNNZXWyQm8DF/clCHp7VRouRyVsrPlDng0l5SNIn3GWuYXUQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6415

On 01.08.23 11:29, Florian Bezdeka wrote:
> Hi all,
> 
> this is hopefully the last preparation series necessary to turn on
> time64_t support (a.k.a. y2038 support). 
> 
> With this series applied the Xenomai specific APIs around scheduler and
> thread APIs will support time64_t when requested. The final "turn on by
> default" switch will be part of the final y2038 series (which is hopefully
> the next one).
> 
> The remaining stuff can be found in my y2038 queue at [1].
> The Xenomai hackerspace wiki is up to date and represents the current
> state of the y2038 work. See [2].
> 
> Best regards,
> Florian
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/florian%2Fy2038
> [2] https://gitlab.com/Xenomai/xenomai-hacker-space/-/wikis/y2038/Y2038_Roadmap
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v3:
> - Added fixes for compat issue around struct rtser_config (rtdm)
> - Move to types with fixed size, Patch 5
> - Align struct xn_ts64 with struct __kernel_timespec (__u64 vs __s64)
> - Link to v2: https://lore.kernel.org/r/20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com
> 
> Changes in v2:
> - Removed patches that were already merged into next 
> - Instead of introducing new time64_t syscalls the entire uapi around
>   thread and sched has been moved to "time64_t always"
> - Link to v1: https://lore.kernel.org/r/20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com
> 
> ---
> Florian Bezdeka (7):
>       cobalt/posix/syscall32: Remove unused mq_fetch_timeout
>       y2038: cobalt/uapi: Migrate struct sched_param_ex to time64_t
>       y2038: cobalt/uapi: Remove __user_old_{timespec,itimerspec,timeval,timex}
>       y2038: cobalt/{thread,sched}: Remove obsolete compat handling
>       cobalt/uapi: Move to data types with fixed sizes
>       include/rtdm/serial.h: Move to data types with fixed sizes
>       include/rtdm/serial.h: Fix compat support of struct rtser_config
> 
>  include/cobalt/kernel/compat.h                     |  49 -----
>  include/cobalt/uapi/event.h                        |   6 +-
>  include/cobalt/uapi/kernel/types.h                 |  54 +----
>  include/cobalt/uapi/sched.h                        |  52 ++---
>  include/cobalt/uapi/sem.h                          |   6 +-
>  include/cobalt/uapi/thread.h                       |   4 +-
>  include/rtdm/uapi/serial.h                         |  35 +--
>  .../arch/arm/include/asm/xenomai/uapi/features.h   |   2 +-
>  .../arch/arm64/include/asm/xenomai/uapi/features.h |   2 +-
>  .../arch/x86/include/asm/xenomai/syscall32-table.h |   8 -
>  .../arch/x86/include/asm/xenomai/uapi/features.h   |   2 +-
>  .../cobalt/include/asm-generic/xenomai/syscall.h   |  29 +--
>  kernel/cobalt/posix/clock.c                        |  23 +-
>  kernel/cobalt/posix/clock.h                        |  28 +--
>  kernel/cobalt/posix/compat.c                       |  72 -------
>  kernel/cobalt/posix/cond.c                         |   4 +-
>  kernel/cobalt/posix/cond.h                         |   2 +-
>  kernel/cobalt/posix/event.c                        |   4 +-
>  kernel/cobalt/posix/event.h                        |   2 +-
>  kernel/cobalt/posix/io.c                           |   4 +-
>  kernel/cobalt/posix/io.h                           |   2 +-
>  kernel/cobalt/posix/monitor.c                      |   4 +-
>  kernel/cobalt/posix/monitor.h                      |   2 +-
>  kernel/cobalt/posix/mqueue.c                       |   6 +-
>  kernel/cobalt/posix/mqueue.h                       |   4 +-
>  kernel/cobalt/posix/mutex.c                        |   4 +-
>  kernel/cobalt/posix/mutex.h                        |   2 +-
>  kernel/cobalt/posix/sched.c                        |  16 +-
>  kernel/cobalt/posix/sem.c                          |   4 +-
>  kernel/cobalt/posix/sem.h                          |   2 +-
>  kernel/cobalt/posix/signal.c                       |   2 +-
>  kernel/cobalt/posix/signal.h                       |   2 +-
>  kernel/cobalt/posix/syscall32.c                    | 239 ---------------------
>  kernel/cobalt/posix/syscall32.h                    |  45 ----
>  kernel/cobalt/posix/thread.c                       |   8 +-
>  kernel/cobalt/posix/timer.c                        |  14 +-
>  kernel/cobalt/posix/timer.h                        |   6 +-
>  kernel/cobalt/posix/timerfd.c                      |  14 +-
>  kernel/cobalt/posix/timerfd.h                      |   6 +-
>  lib/cobalt/clock.c                                 |   2 +-
>  lib/cobalt/internal.h                              |   5 +
>  lib/cobalt/timer.c                                 |   4 +-
>  lib/cobalt/timerfd.c                               |   4 +-
>  43 files changed, 174 insertions(+), 611 deletions(-)
> ---
> base-commit: e1567904ecbac671aa9bf6cc0fa150bf43bfb4e9
> change-id: 20230630-florian-y2038-part-four-upstreaming-0c10a5eccfc1
> 
> Best regards,

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

