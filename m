Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD9BE60
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd3uXDWEOPVzcMJiVU6QLijX3Y2Np7UHJpLY8YA5n3PbxjYtmh3CnxE4L3pRTtXYq3U0Y7nCGgWAWzpNp+0kG1xHvMjJd7Fde8bAfboHNOl/bM2CxG8MBbzId5g3yAiX2tPcZduIwgXBOEpVJfTR1c8VIiJr9G5mUCPXsIqJQrlyq5QVqz/qqirAMRstvsaJ2aCfdy7ZvVDIbnzD31yK8MpBh/bHOsKfuAyQ1afLxjFO2Ru+uNvYuCUdYcIeeEeyG50Fy9w2MRmqPceScWow3Om4+Twr/jzvHYY8c0Zs/RyxAwJFgymBIAYkTg3IPiweoawLJuU3SH0GU3LxUkhwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAwomOH/8QskVQoJVLm2mzr3PcG3EycgWDPC6g7860Q=;
 b=myz9AxCITP/btBsFPZGe91E3DGtD4mUIvt89O52/P1bLE36F0ypLR5rmoaCTgg/P5UPdp0FS1y4znPlU1gFOxgiYs8KtZ9aJgqI9U8woRa13LeojrT9CjlOW82vaolwNB7/y04Vpi/ZVMftcMBGs1M8EA4BhnIBVNbCLN5orxZ2YAP45l5s/Q//sFAt8ctgzbqgA4qKTz2lyO8bhTFw4yhOS2HChVyvmK1k+AFzCSXWIUqTkdcc6ejTCEbx8QMkvPkugd/i++ixzmwvMod+0k90mxpmgsT2d7rkXXHq2H5d7tpRx18FSIvLjGCVxihvEF90gb8xmuNHqrrvhCshgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAwomOH/8QskVQoJVLm2mzr3PcG3EycgWDPC6g7860Q=;
 b=KHdWLz5hTcI8XhIBQ040J+8+hhWaPCyP7+Yx+g0dKXJLYDUH7eL1M9gGULP+saXFIOCCDM5WYSMB/ZowJojXOLFCAtnXr0G/nUQVpLR9zxw9DZgEbvbkO+5JQJSJcG+bhRx83rlxW1wQGGhOIdP4weWfbwK/gwVbRAQWzYeNpyZjFruDtfaL4Vy3X0wB6alMXVupG+BiuDGOC62ELZ5BixBeClnRBw255kaocphtD9Bkxiv/vg+Xedx8PXIF0DHTN/XDcUGcE/uBkZA3W8DWpNOquebx9Uq3xhdJ7OSUT6YI2Fr9PtHHevoIc+lOoJqu0QOXHXF/noVKl3g+uKXE6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 13:51:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:51:47 +0000
Message-ID: <4c8551a6-8c70-4605-8ebc-76b2e3a558d5@siemens.com>
Date: Fri, 1 Sep 2023 15:51:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0f4eb9-56ee-41ef-c494-08dbaaf295cd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 +h40mbZ990wdtAewLJGZPJ9+Gyoo6GLokAMCDeCFo5kEK6PcNRQ8H+3Lsz5ec8ZobWaXI73TocmwBBKiNYJrd4GxqTxG4WDuYJ0aN1uNYVx/62QZwjBR2mny7bqiOgEZypm2Y4Tg5tPSsRThTOYMrUKGSTOm+Mth1K0UeuvBZ4Kia2eV3SX0TPv/YUV0sOMKz27akX58WtVH0qlTs2J5/8o2Wx5baklSpiFxyGpEO/jH7JuGV+KBcmD/4iCHHVO+m2a6iai1FiIZH8uxefR6Gtz16KNNJ/mNGNOMC1J9I6NLuYjZvJnGgZaznt+baa8QveAQ8t204YzXRCILUNvvI2Z/Fgti8PYhHtsEuJdy9HI8VnqgQ9NMkYschQbh5g5tnl1UOepo7ynDXj+3pjAInPGE04fJq9W68ZVo7RqJIeLJHNYflbiAj+b9uefvxR0x9NpoGSRh/85war1CiJS0R8m3bV95xiCP9xUH+E49+Q15xU9xOzE769LnksCCz1BptOg5kqz0XVsD80SkVIhAhk87IUtusbOjBDzKIEunjD/u5BgKXwLeRImntmk1chZYEQFxYlZLjpvFN4o7xO6OOcwRVATsyVfw1tSiQEWZN+tOCAG+zWkaoA52a11OajHBD9AnVOx8t4G5fWHZb71Adw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6512007)(6486002)(36756003)(86362001)(82960400001)(31696002)(38100700002)(2616005)(4744005)(2906002)(26005)(53546011)(83380400001)(478600001)(66946007)(5660300002)(8936002)(8676002)(44832011)(41300700001)(316002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YW43OERZM3dMaEdtWFMzM0FZY3lOd1pRUTlHazdGKzdTNVlXTG1SS0pjVGpF?=
 =?utf-8?B?c0JYUXpidkdMTzRiSktOWGdqdnplaDh2SGxuVHRIR01lOXliMkhLTlU0US81?=
 =?utf-8?B?WGNmRTZZUnlrcHVNdGI0eitmZVB2Zjg3WkFzTDMwQnJYMGo0RmsyZ2poT1Nq?=
 =?utf-8?B?d2pIQlh6aXJUd1lXTS9aRzQ3amtHaitrNm53RUp2UEx5alFpL0NrNE1pMjNG?=
 =?utf-8?B?Q3pGSFpNOXRnYkIxenJOYnd1Y2dsTS91SGNsaytnZUdzN0NwTG45WXJUR0dj?=
 =?utf-8?B?ZGFLZk1xeWs0MmhjVjZERjdJMTJ6STRTOTh1NW9rdXpXbVo2ZHgrQmpxRFEr?=
 =?utf-8?B?Vnp1a2l3VVdsdnZaYWQyTCtrM1lSMS9Rdmp5K3p5Qm9vajVQQjREc29pU1lu?=
 =?utf-8?B?amFqanUvRUtUZC93cVc1V1d3N1JaMXN4b0xRTVV5MWsyK2doeEZVa2tudmtP?=
 =?utf-8?B?TVJCQ2R1aEhUUVdvMFZsN3QvVkxHeDdTRDNNRmU1bml4NEV0SVNIRnJHRjZr?=
 =?utf-8?B?RDgxQnpTVjZTTDZ4T1RQUmNOQ1ZpVEtGZlZIREVhYTlvZWZ6NFNmaXNPUHpB?=
 =?utf-8?B?bzJZb1FST2JGMXFhRmNpOEVJdGZBeWJpRmJPWGUxOWgySURYSWZNV3dHQWhK?=
 =?utf-8?B?eitWdVg1bHBGb1ZnT1RyeVpDTUpLZnpMYXVQT2pZdEg5aStnc2l1VFpubVcx?=
 =?utf-8?B?NWtEblFkY3lrdnU3QzVNUmFkTXZwQ3R5U0o0R25ZL2NKcm9JakE1emRCZERO?=
 =?utf-8?B?Q29qUjJ3YWVWNDV1MjBwMmh0UE9raTlFenNUK0gweUN6cXVQM2RwUTFoeXp2?=
 =?utf-8?B?WmFyVTV1UlVJanE2R1JQZTYyNUFPcjBJL1lLUnVxSk5jQ0hGV0pVWSszaWd6?=
 =?utf-8?B?VmloeEo1RHB3d2RLUmdmNVM3ZTMwQVRGRU9uTEEwSlYvTnd6cXlxY0hTdWhX?=
 =?utf-8?B?Y2swNWZIUXI2cUR4Q0RUYlVETVdnbG1ESWtoOTRidGpZMEVXb0NNRXJsSnNU?=
 =?utf-8?B?WDhERzZ1d1d3eU9WY3l2dHA4MjVkVTV4elB0aXlJOXdxdHpvM3pQZlBmNGtR?=
 =?utf-8?B?WUloZk1uNmN2SjZxRGtkVXFGQ2ljcTJ6SlQycEQ0cjlUZk1VT2l3L0Qram9z?=
 =?utf-8?B?RkE4U1NDSXdHRW9abWRLaXdGU1JCT0VVNUJoZkxmdSt1WjN0eFNLamlPMWha?=
 =?utf-8?B?QS9FOGxOQ28zTjcvWmhqdkRMc0FmelVBZkhsRGZCQzU5Ym1rOEZQNElxMG01?=
 =?utf-8?B?dTc2bGNUSW4rTHZyNjBXUDVTZ1poMTRRdjNwakdDWXhjanR6Q2JIbDg3UmdZ?=
 =?utf-8?B?NjlVZHA3SWtLT1JYY3MwbHNHYmhORHpVVmFmTFJvdmdIWS83QzhJVVBENFN3?=
 =?utf-8?B?enF3S0UrRmNheEx2c0VsTEEzMXpJWndOR0tMWW5ROGphTlNzdlRYaWlYUjVt?=
 =?utf-8?B?V0J6d0kwZ201WDJYTDR5ZTZ2aE85WDU5SjBjKzFDZm9LYmhkbkRlYUNxTElH?=
 =?utf-8?B?WUJtVDBLUkNaSGs2SXR5ME1DRS83ZU9wUGtvNFV1M2ZGdzBpQnROQTU4WnVN?=
 =?utf-8?B?aElDeTJ3QTNoWkZFQlEyT296YWVXdGFZR2ZmQXJ5Y1B0ZldoelJtc2lsWndi?=
 =?utf-8?B?Wmg4aWdhUnozZGZDVmtqWGlkOXVpNTVPSStuM2lTRzB2QTdRWDNYRGdLazdB?=
 =?utf-8?B?RmRwTmhodzNNOVA5YlNRL3M2a1hZNFQ4SSswQ0wxOGVQSmVIN2hSdExtM21v?=
 =?utf-8?B?dDcyazFaRmE4RlBSQnA1UjhIMEdua1pOMjBiQVhjL1AxYkRrdGZNdTJYR0Ur?=
 =?utf-8?B?WlEyb21lMHdNaCtLYUF2N2hQR3ZjWTl5TlprUkhyVlpxeHFSZVVLTlFUY1da?=
 =?utf-8?B?RjBnSUlzNHJGU0phNm9oK2lPUXlpZGZpRmFSR25zOGl3dHZST3FvMWxSR01w?=
 =?utf-8?B?T0w3MFUrbjJUMFc0bGR2MVpadmNFTVJIZmNhcERzTkNqd3Vod0szdlo3QU5O?=
 =?utf-8?B?REJ3b1Z4QnZ2N2ZtWTM5a0FxSFluNTA1NnF4YlYrcWt5aUpVa2RERVE5RmpT?=
 =?utf-8?B?ZnZTZzd5N1lUM3dNOTQ0S2FXaHdjcTRuSUFaSTBTZng4UXVlR2MvNERQM0tY?=
 =?utf-8?B?a3B0ZTNkVWdXYkhVZG1GNlkydC92NGhPam1BOEw5SjdvQ2laYVMrdnhDM0Vj?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0f4eb9-56ee-41ef-c494-08dbaaf295cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:51:47.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoZO4Kd8674BMD516LLCIRbE816dGGu3A51Sg2FdDrZg1lrMiJKYdjwYjxQfg7JW8z7hXb/ggQKiRGeGxl8XYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7142

On 16.08.23 12:18, Johannes Kirchmair wrote:
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)
> +{
> +	switch (vector) {
> +	case 0: /* divide_error */
> +		*sig = SIGFPE;
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = FPE_INTDIV;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case 1: /* trap_error */ {
> +		unsigned long condition;
> +		get_debugreg(condition, 6);
> +		set_debugreg(0, 7);

This looks suspicious: We modify DR7 unconditionally, even if we do not
handle the signal? Is that OK for the kernel code that takes over then
because it will simply do the same?

Jan

> +		*sig = SIGTRAP;
> +		info->si_signo = *sig;
> +		info->si_errno = errcode;
> +		info->si_code = get_si_code(condition);
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	}

-- 
Siemens AG, Technology
Linux Expert Center

