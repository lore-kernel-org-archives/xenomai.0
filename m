Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE3376BC2
	for <xenomai@lists.linux.dev>; Tue,  2 Jun 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385786; cv=fail; b=BMt8Ax1qyHdiausWX8dh/skEyYesMjxVJ9gG1MFQIQawLQKErpBDeIvuT7lKLE3EO5pCXk9recZWQyUKqcFgSTSyy0JI50sqs3lsRK/swb8/gtRnrvmKkd91CfB0Ib5n+CAg3qDbCLO4OrsM176YzY58eaBGVVswuYr+hWXFRlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385786; c=relaxed/simple;
	bh=kqdogkKVOAf77YTnao91NcTaEq3zlo1rW3Wm28TRkYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lWHhd+iKuTisjwQ8/tyxenEJo5w+pHa2+NZoWnbw9bLig2YUZ1L9pSnuRM69SPDnxZyG/9hVRc4rcrMgfjsN1Qti4r5rH9f1CW0efCARMdnz+OQYUPqIDS/97oQJV+o0h0n20sofguIL1NOj48FMeYhXReArPL0KIiwYQ8+elzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JIMpFrcH; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JIMpFrcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnQB0ADA/UMmjmVdks9sR1S+A6bK1fWNz3Qu/wNswk8wTeF9regeE9mZq9/GtTFz08NoMUXeH54u3WJPliHDQJg1RcjcfsxIiNBhK7jGF9bMCQC6w1kRo/PCUI8H2Y+lhbGH+Ng4joXUIbA80oax7jTgRlLr7zMA6RoPHbCsdbQ9xMICBqHCI1MHUUtMWo8e5jpWGZpFMiz7bEtxTiUZuEqb2CoUaVCQOiETykm2I3GQIuSNUlVktBNLIUX1DOX1TbS7rit01tzphjUTZ5Al2E04CCczn7HRVSWZDdt4cbEJusbJdo71eou30CGAx3sZYKwal0pINAbJT0i1k9/j2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eokjh+uEVHezkigMvnrLz+ODrJG4lcMyJYqaVYRmYJI=;
 b=uaGwmg2IRhF6GJgyuJi5McYRmnGMYUZlGZWusOfWI+/0yhH4tNK0lt2tvKS3XzC0eC32SK33mofajzBOi3YMuFdW3attfGGED4tQeMLGUB619NWSuIXjlMlTulOCE/RWzwWkMcZY6PFs+VqDVLCEN31ey7bEnMMyIaaCbrlaRByraeaIdvL4y95vunxjI8PBIerVzXymyqZ0XODU9nqQEmi2V5f+Tuta+cCKvLvJEW5pzYGVpi/ij0ap3NYxo2kTkra8nU4OFQ4x+QZUdU6GeuqGSMZdPCEbRlK/TTvbCEjiMC55RuGzvYR1LkP/6mqAlrmn3uirWNob1lkvV6adJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eokjh+uEVHezkigMvnrLz+ODrJG4lcMyJYqaVYRmYJI=;
 b=JIMpFrcHSM8HpkTiKDlU67qnUSyGJsuleq0CMN7LbuE0htlSWmX1JHtG4tL1P1Wl6/6spdjz60Ji84EFm6c9OGa2LSugP8oLOTuFIyJCqz9Oun8JcphwGNbWXjqMELgaVhjYmARfHw8R7CWHrk2q3LZUKQrpks+UIaSnr5YgLOFQaOpYuXQOOl73CNeHxx/QKPi4w5W8caO0OOCMKdcCdHJY11M2A0hBrbr09WE7Kz0MIqE77rHDlsiqpAhc4MlQK048mP+sUBjVtpXkRh/hQ5DrQskoAgwhNGcG19Mm4x7ADM/ZAKFSUi86Al4Vjbpb99QSE+WhyUUEOEM9tipJkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB9044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 07:36:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Tue, 2 Jun 2026
 07:36:17 +0000
Message-ID: <8a63a50f-1745-48a7-b50e-a91ac9a83927@siemens.com>
Date: Tue, 2 Jun 2026 09:36:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v8 11/11] riscv: dovetail: add core support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
 <20260531055304.2890455-12-tobias.schaffner@siemens.com>
 <da5d431e2b95e3f3077f151d2259f0164b5b2722.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <da5d431e2b95e3f3077f151d2259f0164b5b2722.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5291d3-c7b6-4dec-3759-08dec079a1a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1GMhIVGVuqyJi6oonGHzOFYWo4NBlBn6a5lrmrc8Ykwcxi69d/Bvq8VAJyh5HBTCrLviKSgQrzwB/jkajZztO53h8QPs54RrCQG3ri1Zzff45J2cpzmlTgnQgbUlxykAgVpKX1wzOefz8iLj3q9Pkwz2nGek8ZGMw2BkH4hTFQ5hoOZmzdLTF424H31DrFVSM8aJp4CHjeSAeLbd52DCr9IV+pOtENIXyepNpXaiS/Qi5l9ZlUMS5pvNwaxEXexincYvgmz+RwQ7YPpfnl23X6AObyrbaTR8F99kSoVj/EB6Z/94WxSHcHBAz/V3GuUUSiflcFXJO8lPOOA9R+M1L41Yk6hSVfVHiiWRb1waC2smNtRSEzTFdr9SW/w2VtYwri3ol33dwKwyKH/jGH9cBTtnTC/a9Uq3lPPgcuDzUQsAkm81YynZ87ATMP1Kigt9vU6ledpoTeS+CaQYNketFELXZacOvLzC5mrdEAKb8egL3rp9cG9n6VUMOM2qNLYo2316zxjgrT7qPDtB9BD0+4UtsHPIopF5tKF2Z05BiHLJfExFAS0SAtaQ5kQ/6I8zt0Ed6i1RR7AJm4Fuphq3jIiLSDp2R0o76Hx4dRh4os5/3KT/4wMza9zdaf36WhOmQji666TmcbEayAYVJvSTbNTTWBMZe5ZtxmxYk1tQQpSBSrIdRGS7J9l+0uyin3gj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnYybTkrcmU1UHF2YTFCZHdXaDkxakdIY3lMVmdMbllEODhtc1FVUS9adldZ?=
 =?utf-8?B?dCtwQUg0VlZmT0sySkhhTGZiVkI4SVo0U3JLZDd1UU9hOFNwYm9vektkUW4z?=
 =?utf-8?B?YjE2YzVTVHhEbXdLeXB0VEV4RGR1RkpLcGphTGVudTdVMHk3cHRReFVGUzdv?=
 =?utf-8?B?ejFMaWNOREpRdXlkZnNWUzN2SnR3Q2U2NytYRHo0UG15cy93Y2xPL3VIaHU5?=
 =?utf-8?B?M0NEYmVrakJNVmF0NUY3NUprZlBpWEFha3hkY3RBSnRNTURQZ01DbFlubjN5?=
 =?utf-8?B?VTk0blNNN0Z4czVxNzExQ2FneWNqNVFyemRVRUpocXBRQmdKdUpJb2NHT1FE?=
 =?utf-8?B?Ym5nb1RSSGhOUjcwMVFyMnZWZXZhVmJhcW9JOG9iN1gwYzBhK1VNZThSejV4?=
 =?utf-8?B?SjNKZExWTWRwckJMYkNDMndvcGYxMzlzaXlKZWdLeDQ3RFYyKzFRMzN3U1BB?=
 =?utf-8?B?V3p6Nnl1K2o0bnNLV3FlbUhwa0FnNzFEWG8yU1o3RFZUbmxLTXU4VzcxUUw1?=
 =?utf-8?B?MFNIZ0VnUG5tVEZZeCtiUW45MW1FMVdQdW0wcWU2MWJvdHB2aXlHWFBPRDcw?=
 =?utf-8?B?TUlPUFBYUkc1OHU1MGowTXJWTkFkMTJHZ2N4eW1nUGdEenV5Yml2L2R2NUFr?=
 =?utf-8?B?QTlweVdDb2VWVnN4ckx0SUwrbFJMNS8xQ2dOQUY4NXpTOHRvcFI1NWdQR1l2?=
 =?utf-8?B?bWdZNm1KOTR4cnVkL053U3B3VUlrZXk1b3hjdlJxYjA5NFNRZ25ucVp6b09K?=
 =?utf-8?B?eXNZWTI3NnIrNTVGZkhFS3FaWXVOM2dYVUNMQnJvb1RmbEQvd3YvcDkwR2NJ?=
 =?utf-8?B?YnpxUkRCbEZ2ODVRMUF1Q3M1djFWcWF6dEJzOFBZUTdrRHd3OGcxUW04dXNj?=
 =?utf-8?B?UldGS2JnZkFCRTJjdDVHMFZhc1F6TGtHM1NIYjJNWVN0RmIvOTB0QXZGUmxY?=
 =?utf-8?B?QVNRN3JsRjFKQkI2OXNxcEMxRmk5Smw2Z3lhbWE0UVd5bmR3MGpxWERleFZG?=
 =?utf-8?B?aC91ZWV3NTR0RFFHV0VjUVplY29VZEdqNER5bkd3NVpRamwydnlwbk00dzFs?=
 =?utf-8?B?dnIwTDJrSlFDRitRQWdLZEhkNGdBM1o3eCtrMGRPWDJuR3E1WXRHdTV0anZN?=
 =?utf-8?B?N2lUb2QxQ3hHSW0zMFBEYmJSdmQxQ1FlM0lCWE1DRjVSTGx3ZVozNUsvVWMw?=
 =?utf-8?B?cE1lZkNhdTY3RjlMWHpKNzl6bVBNUGw1UHhxOGh6YnozeTJpaHM4Rk1nQVdB?=
 =?utf-8?B?bDQyVElSV3dGVldwZWw4NDl5T2dKb3RDOHI4cTkvMHEyTHhwZW5OY0VuZHBL?=
 =?utf-8?B?UGlDTmhGRU1PTlpSemJwaUloY29qZ0haRjI0bFdXZ1lwTTk4a3llWXhnZVdU?=
 =?utf-8?B?cFVKQndKLzIvMlJzYS95TW5IcllmbmtLTFUxS2lQck4vV1lxa3hxVUdjMFFr?=
 =?utf-8?B?bnFYUlZLeW1COUlkSWxNdi96aXUyNnp0OFR3UjRuR2x3VW1KT3hQbkl3ZGZl?=
 =?utf-8?B?R1VhSHBLa0NkclI1YlJYb250Qkg4RnB0UW1EUFdqclVSUEIxZ3N1UHI5Nm1R?=
 =?utf-8?B?YzhWSjl2VHloVkl2aEVPeG5tY0FKTkpDTVlRTWx0aWw1dlhVQklUT0xaQXNo?=
 =?utf-8?B?S1VhVVMzbFJqTzROMEg0ZUhGWHlvZld4SWNEblRvVEVSVGVJRnY0SnhEQjR2?=
 =?utf-8?B?ZW9NenVPS2YrNGxDaW80bHl1VzYvYmY5KzVSVmVUM0xaRng2OXV4bzJQOUNN?=
 =?utf-8?B?V3ExdjBGMi9rQ21IQnFpbm16ZEthTVlaT2QwKzhNNHBDS3ZTRW4yc0htK0o0?=
 =?utf-8?B?Q3FBYjBhbHh3UzlpRDZVUWdtcWJpYnVOckFUbVVMbkVPcC9DY0FJTjNFSlNW?=
 =?utf-8?B?UHVQZGlVbFE0M3VYWHU3Z1BDNDVZT2MvcDE3RTkyeml3bGdhekdheHczVWNl?=
 =?utf-8?B?alNSQWtjYkNmaVRoSk9Hdk92Z2dTSDBxSGpRRFh4azVGdTZQaEI1d3U0NVFs?=
 =?utf-8?B?OThXOS9rM3ZXUGhubHV3RnFVb3laN2dpSll2YkphQmVjVWVtV2tyVTBLeWxG?=
 =?utf-8?B?UEY3bU5MUkYyc1lxbFFhOHRRVzRYVWtKWm5aSXlIUE1wbFRhb3hkdmg3a3py?=
 =?utf-8?B?aWFVZ1Q5djhCQmh4RmtpRUErd1psRHZ2MGpXTU5TQzg1Mm5vekphM2FnQXk4?=
 =?utf-8?B?bVhMS1RERkVuK3NqR1JnQWUzZTg1a2hzK0VvbkFqZ1ZjWERQMzd3Tkorc0Vy?=
 =?utf-8?B?R2hWM0Y5b1lveEZybjJwb2dIcjJTNWt1ZjRWaHZQbi9ZRkxIbFh6WHBpaENB?=
 =?utf-8?B?Rm5yc1duNHRIT20zN3FsREVjUGZxdXd0RWZqSFJkUjJxcEQ2WUZPMDd6aWJE?=
 =?utf-8?Q?uxQBoxqJG6Sk7Dp0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5291d3-c7b6-4dec-3759-08dec079a1a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:36:17.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q2qs3aeXTnXV4wKzuUQASDrbNZCQbBxdy2AsP+A3Q4hFJGF2Z8ehDlhg5glZz31srk5ikSzQ01xj9gNzvfv7CySv+/jxXIkIYKeYsE4qnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9044

Hi Florian,

On 6/1/26 10:53, Florian Bezdeka wrote:
> On Sun, 2026-05-31 at 07:53 +0200, Tobias Schaffner wrote:
> 
> [snip]
> 
>> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>> +static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
> 
> I wonder why this can't just stay do_trap() ...
> 
>>   {
>>   	struct task_struct *tsk = current;
>>   
>> -	if (!mark_trap_entry(regs))
>> -		return;
>> -
> 
> We could call mark_trap_entry() here ...
> 
>>   	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>>   	    && printk_ratelimit()) {
>>   		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
>> @@ -150,6 +152,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>>   	}
>>   
>>   	force_sig_fault(signo, code, (void __user *)addr);
> 
> and we add the mark_trap_exit() call here .
> 
>> +}
>> +
>> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>> +{
>> +	if(!mark_trap_entry(regs))
>> +		return;
>> +
>> +	do_trap_raw(regs, signo, code, addr);
>>   
>>   	mark_trap_exit(regs);
>>   }
> 
> That part would get unnecessary.
> 
>> @@ -160,7 +170,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>>   	current->thread.bad_cause = regs->cause;
>>   
>>   	if (user_mode(regs)) {
>> -		do_trap(regs, signo, code, addr);
>> +		do_trap_raw(regs, signo, code, addr);
> 
> This is the single caller of do_trap_raw() and I'm quite sure that this
> is not correct as we would not enable hard_irqs when handling a error
> trap over userland...
> 

In this case it is already done. The callers of do_trap_error already 
called mark_trap_entry and we want to make sure we do not call it a 
second time. The do_trap handler with the mark_trap_entry/exit calls is 
used in the handle_page_fault function in mm/fault.c.

But I will try to further simplify the page fault handling. Maybe I can 
get rid of the page fault special treatment.

>>   	} else {
>>   		/*
>>   		 * Dovetail: If we trapped from kernel space, either
>> @@ -177,6 +187,8 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>>   #define DO_ERROR_INFO(name, signo, code, str)	
> 
> That was my final finding. I think I'm done with reviewing.
> 
> Btw: I'm seeing some strange behavior on 7.1-rc5 on x86. The system is
> slower than expected and triggering some test timeouts. Rebase to -rc6
> is already done. Trying to update all the necessary branches now.
> 
> Best regards,
> Florian

