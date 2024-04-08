Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBF7E8
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613308; cv=fail; b=Hu+Xe2OzbI5WAL3o51F6SKv+G3CUt9N9WNRpzkASWmY5MSfD4OdFMU40zCOPvJ72+WO8cDl68ug0WWyqBOH1ydFebuHzMuSTKuYJ/ricxF19vnwzTJ2nRUPlf5oO+wl9WxGRIJmEzIJvTTF8Z9yVYQGUgO6NOGNQw4uWxLZy7zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613308; c=relaxed/simple;
	bh=D3V/pls/rBeGtOTy8r+NX/p/MAMUvwFXz0V3lQbK5qo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tCKervWtOjC9HD1vI1B8ol7tlUcKJFaxEV9CEyGwZZcH9ALfDV/vvuiL2fam1fQN2FaYk65Sw2w9GuVaKpB59uOi0l7cy6RnOIIxo+Z4zyI2sN0E7iKm+79UgPrn00N56E3eF2JZZ08fMd+G/RN4q5ilZ2wNaoauy45kI0MIT2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xXuZzc4S; arc=fail smtp.client-ip=40.107.104.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xXuZzc4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtMhLII9NGEa3OTpP+esdLANvEQ387YGKMzKq8k2BXXXL/g4aGFMdj8HgJIo/5+DewxiZd6fFJ9Mh86EALkploeGCMltqEJ84kg8bNZshXUc5S/5xTf479v4GcCe/BTEWUMOgeXbFcf02TwnNGBEIvYxs0gG6vjTiyrQZu4YpShbpub48DTPUTGfW9fmvBi3bTq3fT649SiuWJdwWYH9CViZapJLSGvcF1XG5wWk+m7ITVPEw8MPgPtrtXUMnxZuGgE9ev5IKQE+JkI105BGUMFJwkEjBA+ch4H4AAAzckka3i6GPr3U6SJpC7bVQFHTl0mPpFD8pS0LxSGX4ZQz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeSIZthGq1I8uza69bhlXupFlDmtz/rH6cw3LdH4pXw=;
 b=JqbnWizMxktkxckdAq2hLKFJgxBf1f375pfzz7Hmf/9i9oY9xX6Wnzs7NjLSdoZTgJ83rBfMqxP8yxqS+4ocs7p75JJ+B6lwNOBm8NCymvc7gAtaSNLFv47EfNQN2r93oVw+CNhHoC7B6P2yU7Qh8bw/4CAvPgpALQLmT5vvi77i//MkhQug8qBKNJEKKxZ87cL8RFfHfD8Rc7uqwf20cdxGywVf24VygPmtTw8IOlJjySfpUKYAd1DkC3fxWwCKZC6DKjmdx60XtZSLBazbXyxlBY3Ts/wG7P807ECV3VSt9DK1QApOgicrq8DBLqQUbpDECuoEcN9/drmkfoUrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeSIZthGq1I8uza69bhlXupFlDmtz/rH6cw3LdH4pXw=;
 b=xXuZzc4S2H8ByYOhz40VXM4NcliRfEb80Jn3LqwY6eMPqn/fzdP+HV+lVkrHEIZ9rr5Thy/ec54ppgLIXTImIcmZ3njmCe6XnfPvc46zg7HsXGvNH/Qjvwo3PwSQlQLFm2mz3fJUlQ5YY+i9OQB8EsyO0AmBSxFVcnWUtlnqqtAkJypoYZD7VIFMNDxCrotHg6UMg8NNo8FYsgFTWzKeKv/5rO2XwJCBp3Oa+Rkk40uxlgCcDWQZ2WheF4XL40CVh9lai9OvkMV0RXmCMXVv0hXgSroKyPjAGz6mfys9IQaLGronQfkRkzddknWhk2Ruhw83jLFhY8KypO0FT39pDg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Mon, 8 Apr
 2024 21:55:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 21:55:01 +0000
Message-ID: <5aa4e1d6-ac3d-43a2-ad51-4986cc224730@siemens.com>
Date: Mon, 8 Apr 2024 23:54:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Improve tooling support, move away from function wrapping
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <97d031173f62c694001f166abbd756d4b1cb6390.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <97d031173f62c694001f166abbd756d4b1cb6390.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1b6ERTz1TzhYSCdMagRUtVgHeI87Kr/LwWb3PR0MCA8iv15gw14ZpgGG4VyJ6qRBQbNwOdvHQJwm5fvfh2LCIqwVxxXmAZyyZe1O3bzBfTCEjs4UAd33l0B/bUzXtOF96alntQI+W00UwTZjb4ESiDryzZ/LJerAnsNIKu1QAvi99jnbPRJoTPXcGQSfnMHZH9in5vNC2jAKYFRTv/21bDE8lr49ogAsnCd53bHFd+4W52h2hJ66V0eKw7uCBNe/S8NEIpvgzytxHKTDI6x05F3wsN4uBWYMu/Hf5cSXxyjXiOjnuuduy9N7t6D3tNW8PTe8dXSc1Av/Tim2Le4kwukvkYgjj/Ta0ICS+6n/Dy2N4XHIv13p724zPV124GY91CSqixfHyGtM9N20oFl1fcc9NUOVYOMzN1EDAydKdaA90uDIgb+uEVOF0cKtmTERhCt1AuoRcuKh1k4B1zK+8gHLN/11W7DRP3zmLUtHXQmCZnsKGgkIgcHvflaoed1tNVWw6wl7Csn2QFdzyo91dzOiS3hikwOneUfoIk8bwpB9wuy6W5md4UWjSP22d4CfWa/fE13f/XVe+6Umr7T0ERLD+LCNNp4L/x3ZlR/DpCUwDEXTzAV2kOT4NNk3UBqAGWt/wahAI7k619MWAWADS7rjsHgsmhswisVd4zjUYEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpiNTYrQzRHNTkwYjJURDN0UmRSa2VsaTlMN3ZuN2NWSTMrZE5XM2Jza0pE?=
 =?utf-8?B?ZDJvSTFLQVNkNEQvOHdJazB5SVVOQTk3K3dwY2dIaWVTNDRST2ptWUEvZXpr?=
 =?utf-8?B?NWRldEtPZU1EbDlpV3JKUThjL2FXb1pnV1VjbE1BNjRGN2RCek9qaEEwNXov?=
 =?utf-8?B?aUJpTm55YUdzblN3ZTdNWlFSU3VhVVVkdWk3M3N1Y2dldUdDS2t2MkZOMDlR?=
 =?utf-8?B?TVBYVXA3blppWG4vZUduRVVFMFJVTWJyS0xDRUhsUUtkUHFEZ3lYYVl6cTBn?=
 =?utf-8?B?c1NiMGd2dEVoR09MZS9kd3hUTFh6Zm9LR0NWTWNOMW5xVVgzTVBncUZmWUhI?=
 =?utf-8?B?dEN3MW5IUDZqc3RTaHBiWU5QSkhCbDdDOVZXL1c5cXZHTG1Sak13eXh0SHg4?=
 =?utf-8?B?d2ErNFRVRytTbWZiemYvM3lPUnhnL05HeFVYTmh0RitBbVc1S2dnaDZpcmI0?=
 =?utf-8?B?M3JvNnQ1clZJc0hTRFMya2RkS09kQU1jblMxYlhOOFlGbHl5VTc5VjBrbmJ6?=
 =?utf-8?B?cWNvTDEyYnZZSEtSYXhzTkxEbWNhV2k4OHV6LzNIV3lvcFNvQnpyRWFhVnFF?=
 =?utf-8?B?NWthSW5NOWlXYkNPSEl6dG83SE5pOXB2R1RBazU5by90MGdoMjFBNVd4eWtu?=
 =?utf-8?B?L1ZGUTZCSHJsNVJvenhIQkt5OXFLOUJXOWFNR3FIc210cG1IYlB3d0JkNjNu?=
 =?utf-8?B?ZmM5M2VwMFJPQ2cyTlBBMWRKNHVtSlV6R2IrcVBXcVpuOXR6bkVlbDg1VVhw?=
 =?utf-8?B?VTVEV1NJNUpROFhxNzNKbW1WZ1R0bEpDQmtSUkJpNjFBTnhLUzFYWFZXS0h6?=
 =?utf-8?B?c2s0SjFiWTRrdCtiUjNwQTAvWmgxdXdGejFERFNpeng0b2FrM2R2NjU1OFc4?=
 =?utf-8?B?Mm1DMEVmZWJwKzAvbk5Kckw1RXRNeTVOdUZnU1RKQjcwTUQ1MGVKdlBsOUJa?=
 =?utf-8?B?dXdXdi9rYlQ5dmlKVldGS3FaMndld3Ztb3U0c2EySVZxYlIyNzNjcFdRKzVM?=
 =?utf-8?B?OVlBTE05aVFNWm1Rd1F3ajdUS29IV1pESmRmZEJhMks1NnBQZW1ZbnVxQWZl?=
 =?utf-8?B?R3o1Z0lHSUcwYm5yNW4xUTNDVjZhd1ZmaC9xT0tIbnh1TGN4U2Rzd2JFTkc4?=
 =?utf-8?B?SDJDbmhJaFNKSW01UkhmYU5tam1KUWlXVlBtVjdIOTNYc0c1S1RQVEsyRGht?=
 =?utf-8?B?SjFyMC9qZjI2QzFZaTUzeVN5TzIvUXMwQ3ZjNFFOM2VIbGJ4dWx5NkVocVRS?=
 =?utf-8?B?VVgvRnpQaFNKWVUvakNLUDNvbDYzb2dGbWpjaDl4cXgxbXZOUUc2c1dTcEg2?=
 =?utf-8?B?N1RSaXFkU0UxNXhuOElDa2ZEc3FCVENSUFcvWnQ4VGRoaHQxeVFhVXowWm9x?=
 =?utf-8?B?aXdSb1BhTjFvVVNBSGtYN1d5aEtscGthMkNSc2VkWlo3UXFidkhER0lOc3ZR?=
 =?utf-8?B?OUxTQUhLQ24ycGk3eXRISW9tS2trYVlLY1RPM3lPWkV0TVNkTmFLSHc4WHFy?=
 =?utf-8?B?OEQ1amNYbFlRdmRxR1Y0aWxnemtLMWg4dUphOGFDMUlQbDFtUXNhRnpvcllm?=
 =?utf-8?B?OHJBRWIrL1RLSmp3L09wRklnc29IQXh0ZWFGdTk2bjdkZG45T25WVWZSYVZO?=
 =?utf-8?B?MGp4eHBiRU1LM05jMEdoOFQxdmhkaHllbUdCYm9zWDZ5ZFloclp0Wk9xUzRZ?=
 =?utf-8?B?VFpnMXVXSXBQamgzSStDVkJJVTY5Rm5jNFFiZFFDc0U2QURCRGNIR281bDRC?=
 =?utf-8?B?ZjNuc3RSS0l4a2VUVUJSRk82RTcrRXIyN3JPcUduYW8vT0thVmNaTVpPbnVq?=
 =?utf-8?B?LzhZcE4vNVlvTGlSQWQ2bm01T1YvMk91cW1XaE4vbUxzL0UzcFpNMGpaWTgx?=
 =?utf-8?B?RnZnSlRWN2VEUjhmbjQ3QTEveThDUWhxYWRXRlQxdXAzVGxHY0dla0NKZEFw?=
 =?utf-8?B?SW5yeGV6YW40aUNLWGxIUDBOa25VL1hkUE90N1I4bjdIQWhOaWVwNEJiWVIx?=
 =?utf-8?B?Q3RxeVJmVFdQSnN5eHd1MExQMVpNTWtBTXZkek11NTU2UFplbm1xb3hLcVBu?=
 =?utf-8?B?MWRkU3BaWXBMUFhyOFE4aG0ySWFIc3lDeGNneXA5c2JTbyswazFvaW02cGNk?=
 =?utf-8?Q?PjVQVDg2UAIQDeeq5FtmfC2Kc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b687b12-b60c-42d3-03dd-08dc58168a92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:55:01.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JroQCrOdUpz+Ao4g+DQHTVigOJvXMx8LCnDy+hBFvji2GEZmBHAf9TPwnxYGMbTuz0ZDJcV5Q+STrxcCD7zJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618

On 08.04.24 17:56, Florian Bezdeka wrote:
> Hi all,
> 
> as mentioned in one of the community talks I'm currently looking into
> increasing the tooling support of Xenomai. We had that on our internal
> wish list for some time now. It's time to look at that.
> 
> The initial feature request was talking about valgrind support, so I
> started with that but stopped further investigations because a lot of
> code annotations were necessary. Main pain point was that all memory
> writes done on the kernel side were not properly detected out of the
> box and had to be annotated manually to avoid "invalid read" reports.
> 
> In addition I did not like that we would have to build two versions of
> each library. One with the annotations inside - useful for debugging -
> and the prod version, without annotations because of possible side
> effects or performance issues. (I did never actually measure it...)
> 
> So I moved on and looked into using the gcc sanitizers.
> 
> First major pain point: libasan (ther library behind the gcc address
> sanitizer) intercepts posix services/functions. That does not work in
> combination with the function wrapping done by libcobalt.
> 
> To make that work we would have to walk away from function wrapping and
> implement an interception mechanism that works similar to the libasan
> implementation. That works - at least technically inside as small test
> application.
> 
> Function wrapping (in Xenomai) "defines" the following three
> symbols/functions for each function that is wrapped. I'm using
> pthread_create() as example here:
> 
>   __cobalt_pthread_create(): The RT/Xenomai implementation
>   __real_pthread_create():   The libc implementation
>   __wrap_pthread_create():   A weak alias to __cobalt_pthread_create()
>                              Can be overwritten by the application.
>                              Usage of __RT() and __STD() allows to call
>                              the cobalt or libc implementation.
> 
> For backward compatibility we must keep the interface, especially the 
> possibility to overwrite __wrap_*(). 
> 
> The demo library/application (see attachment) shows that moving a way
> from function wrapping allows to keep this "API" and allow usage of
> libasan / address sanitizer. Some details:
> 
> - We could move from function wrapping to our own "interception" 
>   mechanism. Highly inspired by the libasan implementation.
> 
> - We could change the COBALT_IMPL() macro to implement such an
>   mechanism.
> 
> - Overwriting of __wrap_() still works
> 
> - For each function we want to intercept we do the following:
>   (see library.c)
>   
>   - Declare (not define!) a weak symbol
>   - Introduce a trampoline function (__cobalt_t_*) that calls (jmp)
>     the __wrap_*(), which is itself a weak alias for the __cobalt_*()
>     implementation
> 
> With that, most things work already. There is one missing piece: The
> __STD() macro would no longer work, as there is no __real_*() symbol
> anymore.
> 
> To make that work, we have to search for the original symbol using
> dlsym() in the library init phase, and remember the address of the
> symbol / function.
> 
> In case libasan is active, searching for the posix service (like
> pthread_create) delivers the address of the interceptor. Nice.
> 
> 
> 
> Before I start the real integration into Xenomai, what do you think?
> Any feedback is highly appreciated.
> 
> 
> 
> Topics I will have to look into:
> 
> - Performance. I have some bad feelings regarding the trampoline
>   function. Maybe there is a better way in libasan already.
> 
> - I'm looking for a way to get the init stuff (__cobalt_init() of
>   the attached demo) automated.
> 
> - Architecture support. I don't like the ASM part of the current
>   demo. But I fear there is no other way. At least arm64 and arm
>   should not be a problem. Some bad feelings about i386...
> 
> - Clarification needed: Is there really an application out there
>   that overwrote one of the services by implementing __wrap_*()?
>   Maybe we can remove that feature?

I'm not aware of any, and I could imagine dropping this "feature" along
such a change. We would get rid of the trampoline this way?

> 
> - Other sanitizers: I only played around with -fsanitize=address
>   so far.
> 
> Feedback / ideas highly appreciated.
> 

Besides the interesting new feature to have asan support, avoiding all
those --wrap options for linker and the *.wrappers would be a value as well.

But there is one catch: The linker-based wrapping so far allows to
assemble a binary where some objects use libcobalt and others remain
unwrapped. To my understanding, libasan's interception always works for
all parts of a binary, no fine-grained control possible per object as
those boundaries are removed during linking. Correct?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

