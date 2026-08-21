Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020098.outbound.protection.outlook.com [52.101.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDF3DDAF4
	for <xenomai@lists.linux.dev>; Fri, 21 Aug 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305613; cv=fail; b=Bnn/YecUyUSmj5RPq039Bx0TFYQx/RnTzoA4nTJSeVGcrpoENyd2ZiVS9BSMAIxRRZQ2RkoNpivByfz4eMPxQThjpNMsvRS79Tddp5V1JDR8IUgHhouELQnB9gwGZbU7CRfo30mGZdpYeC1waXPnkn9112pO3dgmFM9x/eKvq4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305613; c=relaxed/simple;
	bh=u8fXQ233rnM2fdJjUNXTCPr+2qSCcD8vAUQPr19nQa4=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=R+08I9Y3ZaeV3Jw2bARii6XbN6MwDMpptm694I3I+I5rCdNmCUvlC8quClsS5NJO+4R/2oTjNwVJK/vbda7/3UV9+AVhMLlugvcTioG7tPM/wSOA1Il5AblrhAJm1rca3zMC06B30+pdDD8yTGD3KwngAxUaBEZXhBNwrX7ohts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heig-vd.ch; spf=pass smtp.mailfrom=heig-vd.ch; dkim=pass (2048-bit key) header.d=heig-vd.ch header.i=@heig-vd.ch header.b=vanZtwW4; arc=fail smtp.client-ip=52.101.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heig-vd.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heig-vd.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heig-vd.ch header.i=@heig-vd.ch header.b="vanZtwW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZmZz4t1G3NDbR8VFvT0WIOUhSvO5AbVgm2IyUKCMgimtLIIsqy07ReD6XGDpPYYsIUHmostntD2FEJbWNYuv+bbmKV2QvJ7/UNapLH/2Hzml993ay6OulzJdm0+zi/5YiqAKP6VGSMp3bo2UFK1Kq/Xw7hJzJaP+HnqeQgXmbDgnshH/9HbHq+Bhiih2JMKTIismM4e3ue5hUx7lzUZQj7SMjmIxED1T/v/K9/GJeN6VgRLoI2a8TUQ4owN3TNA+iActWJdvp3H63CPcZPWw6LhkhiA7S0Cq5SFrwsn6oUhD6iNkzQP+GTL1hpK8wZcUzGXItM8HCINkNu+c/QDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTIYjzbr3CVIbSLrYK/54dIWGXfnPWpH/zqhyNZAaDg=;
 b=CPbZb6XOnL/e6DolL3St+Nxp18/+UPMjqfN3BAoEGHB/bG0Y34MmFInIkDGK4+kBpH+bguWy6AO7j/ehFowQABqCHSSgOz4z/BpWsHJFD/Eg7kGi8OajPlHgoQ+PUwfrJ5Cp/PlP3dpYkGXKVSKpbMVakvfqx8VBwCeBFP8OZiWk344mgxqQYbHzWZ3T2ZC8StqDiTyFfWHXZ6JhIOBtIMiccsqTGndvqrAKWZtyujSuXgEcOaTYj9n0JtTINTEEV9sv3NDwa2K0HR7ofNl4sqFkHsJEPIRqJR136UAAGWy2pq5omC5Op7mqhubT72sDKFcl3pqMkpEG69I0qdWl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heig-vd.ch; dmarc=pass action=none header.from=heig-vd.ch;
 dkim=pass header.d=heig-vd.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heig-vd.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTIYjzbr3CVIbSLrYK/54dIWGXfnPWpH/zqhyNZAaDg=;
 b=vanZtwW4RPdDCF6eR0+lncVZil64xiYRb285XK0QjAGjq4DKWlNMyc9pj5KmrAylUZpNKqHZQDs2DV8D8OgVLBZwKqOB0whLM7pGtr3U+S4KxBWAcmKbCtJrZymmSwSfAHSiMnr6EKIxs8uaYNkaeVvKOSfJOZM29cM0HhAjFph8yfwT+vQhO5R9KQTyFqtDw4oDZ2mFiLyZ22qle3JlopodEUGwCgmvE29fWpCTC9WCCcaolEaSbfu6VeRma2YIkrowzECFsPL9VM+5avdD+9oG1HHJUhSg1+TCZfNq0q0bE469hBMFF2cw86xSze1UghR4zJ219lqPC4YPlCBnWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heig-vd.ch;
Received: from ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::14)
 by GV0P278MB0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 09:46:42 +0000
Received: from ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
 ([fe80::255b:c033:72ca:da2e]) by ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
 ([fe80::255b:c033:72ca:da2e%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 09:46:42 +0000
Message-ID: <41c60236-8977-4102-9db0-65fd8d9f1ec6@heig-vd.ch>
Date: Fri, 21 Aug 2026 11:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: revl + timer
To: Philippe Gerum <rpm@xenomai.org>
References: <ZR1P278MB1040F902CEB569D53789E125D2A52@ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM>
 <8733waovge.fsf@xenomai.org>
Content-Language: en-US
From: Brunet Yorick <yorick.brunet@heig-vd.ch>
Cc: Xenomai <xenomai@lists.linux.dev>
In-Reply-To: <8733waovge.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::26) To ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:5b::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1P278MB1040:EE_|GV0P278MB0019:EE_
X-MS-Office365-Filtering-Correlation-Id: e09f860f-135c-44b2-35f7-08deff691b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|786006|19092799006|23010399003|366016|22082099003|18002099003|13003099007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	36hNAuleG0kGiFPyGVLxjqXNvVBaFS2bu60NFq7u6PtEDXsAv3THA+pIBYLTXeDoIGoG3OaHQy394NREv0gfG+GEhjnhYYpiTbnnv7//qlbmdzZA8n/JiGXsK1VLg8YE1dS2AtwHnPzietVZk7Rpor3vpxJSGi9pdqnUuHUHwdiDhXPDKcOmbWVWdnx5fRzTmNIh+m3JoXr3vwul1QLOnYvDqYxU1vDJIZ2i30gB0VZBuRKfxQ5SKo6u24JCHO5i9Zhrw7H5Dd36m9KyzS+OZRGmgUpgToSY+ZAdDDO4CewwVdBPWCfJ+LlidXQRjgyCkVqQLzQSwzojJnWDxKq3ZfKmzXPF7nI0to3+JenOFMfYUMBCOBGTVLpmcqN5cE/V+n+0fnVpiMmnB9VKTaE/b8QvoC5yruYGCs5B099pa1KDE4zjXAW5tKz0jV0CvRa0Tcd6vqdhXYikfj8nEbjEzP7dPFMp5wf+PD30XsdB7uc5VTrA/k01QASJJB13sYkfL/hmqVZN1eNKZ8e+UGhxfEQgnLfNKrB/FVu/H2Z0nCNoMoSCdj5jxDknLmXzUGlIBrWZyNcoMyd611zxRkCE3xC2QXDEwOxpooyTQ8NQRjf2QDHjq+uwBOvGbMCG99Dt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(786006)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjJuZUVoTTBxamJnYUZRN0VETURsYWlIaWdQMStCVUNkbnREdEJxRElHeG9O?=
 =?utf-8?B?bTNLejhnVXVRMzZuYVlnSDVIQktlZXVsd2JnLzJLQnNjWWJGLy9CMmMxL0RG?=
 =?utf-8?B?S0lJVlM4MVdET0dnZWJJYS9PRnoyQTRVU1VubDIxbmRTQloyZXczd09hRjVM?=
 =?utf-8?B?S2UxdUk0M0xKOE5qNmV1K0NuR3FSOWNadmR5OEdPQkxuam02dGZKZ1RPYnBz?=
 =?utf-8?B?L1dtaWRZQko1a25GQ3N5OUhvVW9VS2FvVHcxS1FxdisrRmxjMmoxd0h4NXdX?=
 =?utf-8?B?TURrU2ZJaEI3dHk0NjZpMC80U3Vvc1Zuc09wYWZVUWFMemRtV21wNUZ0cWNw?=
 =?utf-8?B?cGIzR2xtZ3B6a2NKNDVZSXlxVDJtVklJc2pNUjJ0em42TWt3V25JazUvc044?=
 =?utf-8?B?YjAycy8yeTVBOS9HTGJNVU1TMlZ4L2k3U2xoNkJ4RVJMVW0xUzdOb1Q5M1Ra?=
 =?utf-8?B?bVlMNkJ2bGVYUUNqOVcrckZKL3RENHFhOTA2NTJYT1REcXUwZ3RlODJYRGdk?=
 =?utf-8?B?L3B0eVd1a0NPb1VKZU1pL2VIRHNQYkF3QWFLdjhoQ3F4RVdmTk5TSUUzcTJr?=
 =?utf-8?B?WlA5OG9pWDVHaENwMnZ2NHBjMUNrSXNEa1J4YTE1UWdxb0ZzM1F3M202enRU?=
 =?utf-8?B?MGROWm1meFN3S3BiZUYxVVhBMURqWmM1dzBRZzc4UDNwMFQrV01JcnlubHh5?=
 =?utf-8?B?S0cxWnVSNW9DUUJNSEpPUnl3alBCQlZmUmpySDZaQTFzTGFjNVZGdng0Wm1N?=
 =?utf-8?B?Zy94WWdHQ1FFSnh2dUJZU1duM3JFd1ZVYjNOU1prVlh6eWlXNWZZVjZqK0xF?=
 =?utf-8?B?U1JqZjhwdWVWWUp2YmVrL1lwZmljeFl4Y3o4UDNYU0xUb1MrMVlCWXp2bnE3?=
 =?utf-8?B?bVFUc0tqRiszc0crNE5sdjdKTE5WQnhqUnBJelBWZm1KN1p2NDl3LzR5b3p6?=
 =?utf-8?B?cFJobSt0b2lZRXNLZG50TVBwa0tpYzZxNTRTSHpjenFUblg5d3VUUjVhcnVR?=
 =?utf-8?B?dTdmZllmRWVnRVErQ1gydlhTY1JlWk1OQjZ3WVhEd3BNdjM4dmJKVGRaeUZo?=
 =?utf-8?B?S1N6YTZiWlR6bmFrQWdQck5LOThqQnVyYmRaeTNrM3gvQlpxNHFLdHdjVC9x?=
 =?utf-8?B?TGgxQ1hpTDJ0dy8vQS82REFrK3pvS0F2REYxZWcvYkxPRGVpMFBwOW5udzk4?=
 =?utf-8?B?clB2eTZLbVZNWisxNDZtOGE0eHVwUjV4SjV6NGZRVUVudmFkRnM5dnJsYlAv?=
 =?utf-8?B?VWFPRFc2UnRrTFhPcGJVSWQwQVBaMGQwSVZGMjhQekQ2dUNsdTdsa255Z2ds?=
 =?utf-8?B?bGxLeFNzS0pDckIwMTI2dFMrUnhnaDM5b09rblVKajhZc2ZhSld4a1pLTjZv?=
 =?utf-8?B?NUtsODNEUVFjVXhuUkdaMnQ3ZDFoeHlVdTFJUEE2ck1zL2RyWkhweDVudEhy?=
 =?utf-8?B?MmtxQ25yRjk3Z0JmNFFDZnNRUnZCKzQ5M3Z6SWZEbisxZncyd2lFZTI1aUFo?=
 =?utf-8?B?cndzdFU0cG93MWk0c1NwQzAvdFB2ZUVQYTlFYzlKTGZqempBeFJGVGF0Um9p?=
 =?utf-8?B?QnR4VTRmdWk2ZjlmeHE1cEMvR29BRHpiQXNiL0FtZUVwOG92dHAzbFlQVXhm?=
 =?utf-8?B?akdpanErNXJSNk0rT2dHamRxL3lOUkZqelR1YkRJbzNsZlVTR01qR0p6ODlx?=
 =?utf-8?B?aEV4RFZIMTh4bFRKdUhNNE96NWwrZG1OME5pUUJHZ1d4K20wcExXTzRGazdI?=
 =?utf-8?B?VmlXbnN1bTZyVy9OUHpVOVRCV1FUNVVKc09ISjJjL0dhVlNQYVpBMTdtVlRy?=
 =?utf-8?B?d2M4V3QrMTNtQUQxWEMzdXNEeXh4d0RJcWdFdFN2VTlqWVVPQmhOZFFiMnZy?=
 =?utf-8?B?eUF3VVIyM0M0SXZEZkxabEVETjNocUd0MWJzRm9JMlhFS0lOR0V1MVd2NU1Z?=
 =?utf-8?B?MmFlSUpvdXFBNUF5ODZVQ2JBMWQ1eWJpelIwWStDRXdUbEJWdk9aSnFUdlph?=
 =?utf-8?B?TUNyUHcwSVJnRlZkRkhuZ1U3dFpzNnBFbGthU1VYTVZZVXZxR3J4N01aY2E4?=
 =?utf-8?B?WW1KZHZ0RG9wSFZ5aitEYnE3OWpEUmRva0JWNXRncW1pL05ySWk3QmJxYlB5?=
 =?utf-8?B?b2F0bmY1T0dhUHA5RTZnamh4dWxFWWhOOGRQd05qSWk2cGRaNHB6dGRSOGRS?=
 =?utf-8?B?ekFYcjNvOGh1dnFqbHUvM05qeWk0ZmI3ZjAzM3ZmdUdNKzE4RkhIUkE5OWRU?=
 =?utf-8?B?aFpXMGtaS2FObnMzMUUrNnp4aFdqZjgyb09TRE5aNlc2YUh0LzUxN3BZTWJq?=
 =?utf-8?B?blRiNHdsWGZkMlk5VHBDcEFqd3BFUlB1R3JJS2VrUGluWjhqSzdINFptVE9q?=
 =?utf-8?Q?jcfsMnKNIb0ddcaQ=3D?=
X-OriginatorOrg: heig-vd.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e09f860f-135c-44b2-35f7-08deff691b1f
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:46:42.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a372f724-c0b2-4ea0-abfb-0eb8c6f84e40
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QEaL+8Y2R2rV+UxsOVkq8vFRER7a2dhtle5TQtlU0SUN0J2Ub9d94JQF2zmWBqUZGskDCVZC6hgIZ0zeZHdZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0019

On 8/19/26 19:45, Philippe Gerum wrote:
> Brunet Yorick <yorick.brunet@heig-vd.ch> writes:
> 
>> Hello,
>>
>> I originally posted this question in the matrix channel but got no answer. I try with the mailing list.
>>
> 
> The matrix channel is dead, at least nobody is monitoring it anymore due
> to lack of sustained interest from users, and lack of time on my end
> too. This is the reason why the matrix URL was dropped from the website
> information a year ago or so. I may have to close the channel and lose
> the messages posted there. This mailing list is indeed the right place
> to inquire about xenomai stuff.
> 
>> I have been using `libevl` for some time. I am now testing `revl` as I want to move forward Rust.
>>
>> As a first step before going on the embedded board, I'm using "qemu virt64".
>>
>> First, I noticed that https://gitlab.com/Xenomai/xenomai4/revl/-/blob/master/Cargo.toml?ref\_type=heads doesn't refer a valid `evl-sys` as it points to the main branch and not a tag. I had to clone `revl v0.6.2` and change manually Cargo.toml to
>>
>> ```
>> -evl-sys = { version = "0.32", git = "https://gitlab.com/Xenomai/xenomai4/evl-sys" }
>> +evl-sys = { tag = "v0.36.1", git = "https://gitlab.com/Xenomai/xenomai4/evl-sys" }
>> ```
>> (or v0.32.1)
>>
> 
> I'm not sure to understand the issue. Cargo should pick v0.32.1 since it
> tries to upgrade automatically as long as it finds a newer compatible
> version, e.g.:
> 
> $ cargo build
>     Compiling autocfg v1.1.0
>     Compiling proc-macro2 v1.0.89
>     Compiling unicode-ident v1.0.1
>     Compiling memchr v2.5.0
>     Compiling glob v0.3.0
>     Compiling cfg-if v1.0.0
>     ...
>     Compiling evl-sys v0.32.0 (https://gitlab.com/Xenomai/xenomai4/evl-sys#381404f7)
> 
> Which is evl-sys v0.32.1, as it should be:
> 
> $ git log -1 381404f7
> commit 381404f7ab5a38744b6a771f60a4620b865d208d (tag: v0.32.1)
> ...
> 
> This said, I agree that using tags would be clearer and follow the
> recommendation from the Cargo docs.
> 
> NOTE: in the version/tag information v0.x.y for evl-sys, 'x' refers to
> the libevl API number this FFI is compatible with, and 'y' is a patch
> level fixing minor issue(s) in this context.
> 

That's strange. I get the following behaviour:

```
revl = {
	git = "https://gitlab.com/Xenomai/xenomai4/revl", tag = v0.6.2" }
```

in Cargo.toml gives as a result

$ cargo clean
[...]
$ cargo build
     Updating git repository `https://gitlab.com/Xenomai/xenomai4/revl`
     Updating git repository `https://gitlab.com/Xenomai/xenomai4/evl-sys`
error: failed to select a version for the requirement `evl-sys = "^0.32"`
candidate versions found which didn't match: 0.36.1
location searched: Git repository 
https://gitlab.com/Xenomai/xenomai4/evl-sys
required by package `revl v0.6.2 
(https://gitlab.com/Xenomai/xenomai4/revl?tag=v0.6.2#1d771341)`
     ... which satisfies git dependency `revl` of package 
`evl-periodic_task-rs v0.1.0 
(/home/.../evl-rt/linux/usr/evl_periodic_task_rs)`

>> Then I tried to use the timer with
>>
>> ```
>> let timer = timer::Timer::new(clock::STEADY_CLOCK).expect("[ERROR] timer create failed\n");
>> let now = clock::STEADY_CLOCK.now();
>> let period = Nanoseconds(1_000_000_000_u64);
>> let first_expiry = now + period;
>> timer.arm_periodic(first_expiry, period).expect("[ERROR] timer arm failed\n");
>> loop {
>>      match timer.wait() {
>>          [...]
>>      }
>> }
>> ```
>>
> 
> Which error is this, precisely? e.g. using .unwrap() on the result
> instead of expect() would give better details.
> 
>> or
>>
>> ```
>> let timeout = clock::STEADY_CLOCK.now() + Seconds(1_u32);
>> assert!(clock::STEADY_CLOCK.sleep_until(timeout).is_ok());
>> ```
>>
>> Both cases fail, either on the `timer.wait()` or `sleep_until()`.
>>
>> My system is composed of:
>> - uboot
>> - buildroot (I included the libevl r59, revl v0.6.2, and evl-sys v0.36.1 packages but I'm not sure that it was necessary)
>> - linux-evl v6.18.29-evl2-rebase
>>
>> rustc 1.97.1 (8bab26f4f 2026-07-14)
>>
>> The Cargo.toml of my project is:
>> ```
>> [package]
>> name = "evl-periodic_task-rs"
>> version = "0.1.0"
>> edition = "2024"
>>
>> [dependencies]
>> revl = { path = "../../../../revl" } <--- points to v0.6.2 with changes presented above
>> libc = "0.2.189"
>> embedded-time = "0.12.1"
>> ```
>>
>> Do you have any idea on the issue ?
> 
> 1. revl::init() was not called prior to issuing any of those requests. I
> would suspect ErrorKind::Other to be returned by Timer::arm_timer().
> 
> 2. Thread::attach was not called prior to attempting to sleep in oob
> mode on the steady clock. In such an event, receiving
> ErrorKind::PermissionDenied would make sense.
> 
>> How can I retrieve more logs from EVL?
>>
> 
> There isn't, this is a system call (low-level) interface, so no cosy
> application-level message logging in such layer.


I did not write the full main.rs in my previous message.
Here it is. I changed .except() to .unwrap().

```
use embedded_time::duration::{Nanoseconds, Seconds};
use embedded_time::fixed_point::FixedPoint;
use revl::sched::SchedAttrs;
use revl::{clock, evl_eprintln, evl_println, thread, timer};
use std::process;

fn main() {
     println!(
         "{} v{}\n",
         env!("CARGO_PKG_NAME"),
         env!("CARGO_PKG_VERSION")
     );

     // Pin to CPU 1 which is dedicated to RT
     unsafe {
         let mut cpuset: libc::cpu_set_t = std::mem::zeroed();
         libc::CPU_ZERO(&mut cpuset);
         libc::CPU_SET(1, &mut cpuset);
         if libc::sched_setaffinity(libc::getpid(), 
size_of::<libc::cpu_set_t>(), &cpuset) != 0 {
             eprintln!(
                 "[ERROR] Set affinity failed: {}\n",
                 std::io::Error::last_os_error()
             );
         }
     }

     // Initialize EVL
     revl::init().unwrap();

     // Attach the current thread to EVL core, undergoing SCHED_FIFO at 
priority 8
     thread::Builder::new()
         .name(&format!("Periodic EVL thread {}", std::process::id()))
         .sched(SchedAttrs::FIFO(8.into()))
         .public()
         .attach()
         .unwrap();
     evl_println!("EVL thread attached\n");

     // Create a timer based on the monotonic clock
     let timer = timer::Timer::new(clock::STEADY_CLOCK).unwrap();
     evl_println!("Timer created\n");

     // Set up a 1 Hz periodic timer
     let now = clock::STEADY_CLOCK.now();
     let period = Nanoseconds(1_000_000_000_u64);
     let first_expiry = now + period;

     timer.arm_periodic(first_expiry, period).unwrap();
     evl_println!("Timer armed\n");

     // Loop waiting for timer events
     loop {
         // Wait for the next tick to be notified
         match timer.wait() {
             Ok(result) => {
                 // Read the current time via EVL clock
                 let now = revl::clock::STEADY_CLOCK.now();
                 let dur = now.duration_since_epoch();
                 let secs = Seconds::<u64>::try_from(dur).unwrap();
                 let nsecs = (Nanoseconds::<u64>::try_from(dur).unwrap() 
% secs).integer();
                 evl_println!("{}.{:09} - TICKED\n", secs.integer(), nsecs);
                 // Overrun warning if any
                 if let Some(overruns) = result {
                     evl_println!("Late wakeup of {} ticks\n", overruns);
                 }
             }
             Err(e) => {
                 evl_eprintln!("[ERROR] timer wait failed: {} ({:?})\n", 
e, e.kind());
                 process::exit(1);
             }
         }
     }
}
```

 From revl doc, I suppose that revl::init() is correctly called.
I'm not sure about Thread::attach() though.
The doc gives this way of doing but I have the impression to create a 
new thread and attaching it but not attaching the current "main" thread.
I haven't found how to attach the latter though.

Concerning the error, even with unwrap, only the following text is 
printed. The error seems to be empty.
And neither "Timer created" nor "Timer armed" are displayed (may still 
be in print buffer).

```
evl-periodic_task-rs v0.1.5

EVL thread attached
[ERROR] timer wait failed:
```

Thanks for you help.
Yorick

