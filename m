Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2092.outbound.protection.outlook.com [40.107.20.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB36A323
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577600; cv=fail; b=DXnguybKwsRVp3V05mofJSxHskiI8SseRQm+txIqPEulW+UfToMc1sY3KxW5pU9w+bRH48AG6OPzxvb8XM+Zkuy7QZP0WnLdGiPzrSQArElfCDZCQackaRyHBI4UtJI7S49B57Q9qqkcCLB1OW+DkF0EbYBBwC93+q74+0vMmHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577600; c=relaxed/simple;
	bh=oheNTFJOEXRBkinSxfrUaP7lagDyeHRfnbUICOdkMHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzCIn5fjS24GTYr5xE4LG+Eqm+Uq4dcMHSqOoDJg9EzDPkoH8J0NdyPWjrSl7A+3D/bR5oxoI+E0g133uxT4fqJzSFdVCx4gxkXG42gbgn6r6OI2wW/jDiIZtUo4WFWcWDevXyKom2MUAycBvWG3fQbQyTkf7gGILTKGT6pmIsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VV+CoRVP; arc=fail smtp.client-ip=40.107.20.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VV+CoRVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaBq4t79ZvJpJD+HOVXFYEzRLjhlXj3CxaAL9nWZHGBtPXcwDIvgnS5pU6e/ATwksmvxYd9qmzOzbjoYZ2G2zPuXj/qn2Jo6uZt2vYZHPbjy4j6qBrsgwWDxtKWrXxsi8zAnOHtUZRf0t9pXsYYPQ1DZX2mTglbrTOsJ6VLYs07yhkL6vkL0V3vE2NvgfGPqGqCjZlZnZudcr4biQu7gG43cScJQZ2E7Ypi6mr2jBtWgEy3L8036HAigg5W6kCYmzgn84YxLXoqSGxvMMLgKbsD0ZqWEkpOd43u9m+AEwBpBljwfJNqbNM5beQCOJ9GwQjtBFkXBhMlBHLYD0pFVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQO9i5WFMNyhhpNw/phw0uZEQML+UxHNAC6erQJZqqI=;
 b=hoiOS0hUgMTBfZcP97+NQxOCKl2W91/M8sGbg2xvD/RPP4CUr5sFhVyXLXWt51kVF72ia3hrfdL6hkL8lcWZrI0Ah3HgJ5oKAzB3GMbCdInfnyApYzWQWeZQLUpOTcg2prafvjzVc3FF8UL9cGVAQ+12HnzBBHVBVubhkLPOF1cGtWKOmX8xWUvf9BlaI2y4jOiJSlgO0XU/5mPC+4D9XauJR6pmTew7/bzshLXcuoWqlG/V93lBbS0Uxbxe3cmlEaVXroCJH7tnpZKwIC+Dgog7NZWEQyUWggv9JYZ5yilSsP8Ir9my+NB6BSJI7e6PgLQecKltPZ4pG+Z4V6jqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQO9i5WFMNyhhpNw/phw0uZEQML+UxHNAC6erQJZqqI=;
 b=VV+CoRVPW00LuLUvVAiNZPo+GPsog0v7Y46pokqzshxZARjtRkXaerlDHVU5cQk7c0xKva/b9R191DwaVczcUU9c+OajvegKDq2uV0kNA61z5k6qxznPIYzXAWrlnCl4B07Oe6Zrj96VmmqzQzoSOAkK10NBxY/tESqkKz4qgp1VvGMjknDtDxyX1WyZpdCq1Bbz3tUhfeibAIrk0bgcydvFaQikyhQprFjmLxgcsW2WbqW7AjfIHnY+/zdJDpdAR3K1u7mbZ9kt4FaKWq1hvyiSeRA6s4kQwL7CTctOZfP0srn4Ue73gQEShunc6i4SuYkxRbzG0FB9bNYMDPIncw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:59:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 11:59:53 +0000
Message-ID: <dc20fdf7-0bf7-43cb-8ff2-6a8dd261f879@siemens.com>
Date: Mon, 8 Apr 2024 13:59:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@sigma-star.at>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <874jv7rxb2.fsf@xenomai.org> <5809272.1B3tZ46Xf9@somecomputer>
 <3ca2aaf3-f47e-4fbf-8d46-b5da9542bc3c@siemens.com>
 <CAFLxGvytJP_ibg0ex4zgyahaxNJH2b_M=Nu3ZBWtrm9neRoW9w@mail.gmail.com>
 <41296dbe-5e83-4f7d-8963-5c985e83ab30@siemens.com>
 <CAFLxGvy0dQtnfjsgvAyv=8m4JubED7UTwdcvF_8eTkBc5+i+iQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvy0dQtnfjsgvAyv=8m4JubED7UTwdcvF_8eTkBc5+i+iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RKcj5o5Ga655DhyHgmG68CgteuJoHIqVV99PU/WPhG7C0weD/hVSsLjPs3IcWr3jaPOaxgeKM/OvGvDJOyOQ00iGKNsW8/TxE0BiF3BDh0bRr9G7K0mUcPH+na9eQQ78XlY4fwvMS2wKGeyqSUU9Tdunz/yHLV9MLTemSN6tYR+wywvyl5D5xwQbazFJCMuMbyQG6s8/6POLcjP+oCqH7OUMgX/LDJoETS+QxTb2lYV1LDMKKN3Yxd+18/I0al+3Y6Ki1m3oFrH2jZo3H0Rmbxjwctppfb9NAjF1FqMQ9hbb0VqU5jv0GNKOdwxI08e9joZHjQ6Dk7cAqSn9tcCgwOr9mOKEN795Ilq0WjAxBj3Wqsv3uBLQ1ottAOjFSs6lsYE504V4b4GvOcWDBn5GWKSKZF4SMYLnsR4rypcmfXE4uux0zQrAbF7xhdcUsXJiqhpfAzYTcAL2je2sas6DK5XWXInEIvsUaF7sXJh5TXdSEJLZjJySuiVf3PVLKSUOxl8thndLtGQi2qKHq1jYRkiL1jPB7/MzOzv/smF7rMycE/luVizSiip9G14M+r/OeKhj50TbobvmwWMbCirFOABEO5a0g0Vq8On5B3UP/9U07YrDnXWaM+4JrYFan/s9EjtnNBYVYfto9209ou0RycSlZXVbT7d6aC2lAmSeiQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlpTT2grRDJQTS9TMjNNOHlVTVVjWnFRQVp5QTh2QitUL3lINHl5ZmFYdHRN?=
 =?utf-8?B?d0tVR1hMOXM3bDF5WGNvT1pmTVQ4TDFNYzNmU2Z3dDRrMUptcW5jSkg2aUEw?=
 =?utf-8?B?ekdjUEpncENiRHBNYXhUTkhSTXZaQ2FvSStmOS9MVk0yZEJHb2U0UXQ2aGpO?=
 =?utf-8?B?NVFMMThnd0hjZE9Eak5udzd4QXVZZGNnZzUzMnlDejJiZEJGQXNKTnE3dExo?=
 =?utf-8?B?a1NzYUIyVkt2cXQvYkJ6WjlyWVFrWFpvZk5yUDVNVVF2NWtQTENBZExieThF?=
 =?utf-8?B?bGVjY2htUkJHYXRzQ0thdlhid3hXcHZTQTBRY0NZaWhHREk4UTdYYkJEOTZW?=
 =?utf-8?B?UFBzTlByVnRWazV1cVFSRGlqRDFpaFlqbUhYdjFVTHh0L1ljVSt4emovOFkz?=
 =?utf-8?B?TjN2TUVRZURBOU55eTE2MnR0T3VkcUhmSUd0QXV3MVdJY2luRFFmVmhOaGFL?=
 =?utf-8?B?ZjJLUUZjREdMVzZGMFFyYU9zR2N2M2w4cktMOE56NzgrNnhSQXBXU3ZFM0Yr?=
 =?utf-8?B?Mm0vVE13N2k2TmVnRjB3eVBZNGFYNld1MW1Wai83REtpejUxSUxTYm5vbHpX?=
 =?utf-8?B?OHhLWmNvOHgwdHlXWm9jQXhvT0c4dlVCUWJVekJvcGJlaXlVcnhQdVM1MWtr?=
 =?utf-8?B?UktxWUR3aXVMd3BXb004RVFpbk5WT1VEUk5WOHR6enU5TUlpcER1UDVXN0Zy?=
 =?utf-8?B?WmlVUk1MeWc5Q2QwbUxaWDZDL0NHSUY1MkY4eWc1UzF1WXducFRBYS84SWVH?=
 =?utf-8?B?ZzI2UVc5V2JZWlRjMkIyQ084b2cwR3RtL29HSnozS081dzFDSzlYUlJqRFZJ?=
 =?utf-8?B?RXpKa2trcXRvemRhVzBkY1IrTFhPRFVFdUUyOTlmMTExUksrUW5XcFJBN1dr?=
 =?utf-8?B?RVA1K0xQOFlueFhHWktXVEM0VGUxYXBqWkczeENxVkd4MUlHZ0xRTnB1L3pk?=
 =?utf-8?B?SE5LaHZGYUNocjdZZ0h6SVF1YTNQT0FCbCthNjFVei9HWXBwUUptK09aRktJ?=
 =?utf-8?B?TEg1V2hHV3VHRWtVY2xHSnB6TjQwQ0pVZ0FtWklRd1YxQWZjOFV0SjRmVXI4?=
 =?utf-8?B?MjM4S1Blb0oyWjdTbC9kRGluTUJYUnRqSzAveWdRY3J6WForalJkUUdKcmNJ?=
 =?utf-8?B?VGtHeUgxdHdUSXhpaWRUNSs2UFpzeXRQSlVPdWtCUmxrUkpZeitqSFdEcWNi?=
 =?utf-8?B?U2FEcUZJKzE0NkxpQUI0SGFiaTR4OFp5OTRZZ1A2RVJ2UzdTLzBnTXhBZ29M?=
 =?utf-8?B?NTN6Q1ZCdFF5YTNaQk0vYUdHV1dZWWFLQmp1MXpLcGFiWW1vWEQzanMwbE9B?=
 =?utf-8?B?T2F1aklneFhRa2FZVjh4RTBGVENuN2s5SzZNdGFKQzdJMWhVK3FUcHAzeXJi?=
 =?utf-8?B?WkdQRXc3bGlUS2NUbWtialliTCtETURKNGRaS0NyUzU5UjYvYWFvUUVoSjZB?=
 =?utf-8?B?SWtZSCtjTlhMUEhvMnc2UlBTRXF4UzhsMnRPVHBOR3VHbE5ZYm1zUGtEckIw?=
 =?utf-8?B?bU1takRFenJOYWhKeEU2QUN3NXZEUVpIbGZsaGNCaCtZd1BWbEN5YmNVSHVv?=
 =?utf-8?B?djVjc0txSXpZWnUwRWU2YXBsWXdCWEdaZmwrbDViY3RIQTNIcSt1NldSVXZC?=
 =?utf-8?B?bVdZNzVsem9GcW51am5seW45Qy8vcVpCOS9TUnFjL2RBa0FNeXdiSVVFYjJ5?=
 =?utf-8?B?Z2ZkVDUvaEdjTGtlcU10QTFDVERVVjRmL3FlOHhaOXBYZDZyTll6NGd3NkdE?=
 =?utf-8?B?U1REcno4eXc5ZW5zbW44MzdoVlJtbGtDWXJLQkxiekNmbDhNY1NmV1NuNmtY?=
 =?utf-8?B?VnQ3enpnLzdLekVQM1NNYUd5MWZZOGViM08zb01ub2oxTk43WVBzdnhxTlB3?=
 =?utf-8?B?N1BSVnVGZUhqcjZRMU00YWtxdExsalJCZUJ2YmJsTnQwVHorbXRobTJuSDhF?=
 =?utf-8?B?NEJ4YVZIU01uOXV6ckp5K0JsaU53NGM2aUw2WlJBa3d4QVo4VnFmbkMrSzdq?=
 =?utf-8?B?eEtaT1FYRGViUFp6SnJ6ZkdNZEhNWmh0NEFKOCt4WEsrMlNWZmphUVNoaXBx?=
 =?utf-8?B?dGV1Y1dDbXV4Vmk2MFpGcnljb2NaN1VTenVPUFhYVzVzNkh4MENieTJ1eWZk?=
 =?utf-8?B?enQ5WnJQTHJTVU9xaFloRVZuc3lNSjVXNjVMMW9QTUlHdXM3RzRvK2h5UC92?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8746a0e-947e-4705-e232-08dc57c36674
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 11:59:53.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykrHkRp10kMKnKlgwVielDMq53rd+iwXjbJOe65c4svzugLlQIisoLrg96ij2CfoyW6eBxqWl8a2wD9grUeC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3828

On 28.03.24 08:28, Richard Weinberger wrote:
> Jan,
> 
> On Mon, Feb 12, 2024 at 5:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> Yes, I do have some first hacks here as well. ARM and ARM64 is not yet
>>>> ready for this, unfortunately.
>>>
>>> Can you please share your hacks?
>>> What is missing? I'll happily continue your work.
>>>
>>
>> Just refreshed [1], and the kernel side hacks are attached (mixture of
>> Johannes and my WIP changes). Blocker is really the level of kernel
>> enabling we need/want for non-x86. Those changes can be many. Also a
>> problem is the information forwarding from the exception handler to the
>> oob callback - missing in many cases, see also the dances needed in
>> xnarch_setup_trap_info().
> 
> In commit 7e13c6997 ("rt-signal: kernel refactorings") I see the
> following change:
> 
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 5394c85d0..275a9f726 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -56,7 +56,8 @@ void handle_oob_trap_entry(unsigned int trapnr,
> struct pt_regs *regs)
>                xnsched_run();
>        }
> 
> -       if (xnthread_handle_rt_signals(trapnr, regs) == 0)
> +       if (xnthread_test_state(thread, XNUSER) &&
> +           xnthread_handle_rt_signals(trapnr, regs))
>                return;
> 
>        /*
> 
> I guess the idea behind is making sure we handle only faults from user mode.
> But isn't XNUSER also present if a thread is executing a cobalt syscall?
> So, I think instead of just testing for XNUSER we need to check using
> user_mode(regs) too.
> 
> What do you think?
> 

I think the idea was to exclude kernel threads, but I'm not 100% sure
anymore. I agree that testing for user_mode should have that effect as
well and exclude kernel oopses - if we don't filter them elsewhere already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

