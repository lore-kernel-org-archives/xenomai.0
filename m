Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3E47606A
	for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706993; cv=fail; b=Y93316Zne41bcbZek9MestY4uY7o7mQJ61xVliQn4o9DzGoxBYYUg5FyEYmwts+RbZWbJsIYGfr1J+fjuUhbXwXgrGJwvh9VGfHmy68V5w4lVoixySBNxd7nlAGp+wjpeglXKrx7yDCA0Dm+4HTiOPYYBYMYAAr0fLu7tOLykl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706993; c=relaxed/simple;
	bh=f5CkVGoruAsJY0ZXU2dNjY8T/yvwPBhRQeR2wDaimKA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LmOU3YIPD5qVRdOm9SVbA0ZVRt2hHGpaJYl3GmlX9UVG7h1URJJ2BR5VBt+r7nG+1oP+9Wszc1vbOAUuMkmFYYFP+1WEVrln6pQ4xRl502FHioOX4voNgSTTn0hvC+s0fwF9ph54aRaBij24CVVsGnJirJ3KsKrqH4/tFf4Fld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RIPJgYST; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RIPJgYST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc45am80TkoRSABm7XFiy0bRRYrGDSB/A2q4/dqKMltyVK2QGfna7nFPZ6Yc5frSQqdQA0t0GTP6UWfmXcM4pAeI7MEfJCTQ007tjb6fD51hcVTpE66NVNi2Y+mfg1yTNRIQHWfndh9C0/9fW5AWe7R3ljAFc6QiQ+eGxByK3gUx6Vtp3rmepve3D/+zlqO1lVsexRCdBvzhcsNmDu12ROHTXeW7xwgeUMwDcLQeeuW/Ngfss4qLfa6xoMsnMp0V6uMeEbKUq6jgcrkpmbnK+rqu07goNiDof+yWHEtAID84CSbdc7cJL1a/VCwTL3722BFzrUscS5rV3ocq82b5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jClNmQy4bsnH4Hb68C64ZEazeUR++aoQaKnzkUA4kN0=;
 b=hz02XBZ2kOTgEO5YFlzfJZd9BJXskWFo36zVbqlrFShIbXV/BpYdRAlEH/X301JfwiYWKOSrobjYGO0Cxuk5D9aVfYmisGK7cOBGHmJD4ZRLwy+m6sbcoS2ghl1R5sYhJNn3yQ3DdP7sJN3Gp60Cpb85ln/tFht4OHu9yQgOqXChaqCnmeMZX8tgVZx7BQqP8tSxpIkTqD2+kqCfm3jD8+jowHo+4okYbzVDNzulHIIM0q/ANp0uZzvjUpU15XzHex0xsj+Akgm+BvPeh4FxpFlV/sRN2kRBbYPxC4fOwpBg/SW0/BoO6mLdfz0hdV6ZTEQ6T6dNdDqxyIDvBKTfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jClNmQy4bsnH4Hb68C64ZEazeUR++aoQaKnzkUA4kN0=;
 b=RIPJgYSTyavXAZoKGXuoZdMrxjBNwk1mRrnilw8Zze1kHvV1UDS/NGwCDgV/R7sKexzhxi7Ovm0U6mRERQq9eXdXSR60w2ACP5gXRGt1+3NeN/fy1Nu5aEGtu6Uri5RsZM+mczLKUIHXTI4pdQx9wosriafNWAHW3VdlBxTzjmL1Ugl9ACMFpBfeABHi6UtkP46LsPztpGHlWQyr2V/vDD6IdJmELFAB5jEluw+6yZtCSpBqTYZUTLNwZS24RiIbAwfWSEsidKEKgMB3y4c2oW/rJiv2q1U7SoXogagkITBFLXez+DLCuuxJtW4qnPXF0Azp6u280TMPnRnmRwFWAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:56:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:56:27 +0000
Message-ID: <e12bf382-c4f6-4ada-8355-9c2c53d8a5cb@siemens.com>
Date: Wed, 22 Jul 2026 09:56:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Hang during smokey posix_cond test w/ cobalt and PREEMPT_RT
 enabled
To: Dominic Rath <dominic.rath@ibv-augsburg.net>, xenomai@lists.linux.dev
References: <8b51814b-b91a-480b-bb7e-2cbf13660f21@ibv-augsburg.net>
 <ebb378df-45d1-469c-928c-523f16a39460@siemens.com>
 <f50bdfd0-3f00-4893-8303-13e7de4997ff@ibv-augsburg.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f50bdfd0-3f00-4893-8303-13e7de4997ff@ibv-augsburg.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: efceba22-5d1e-4b68-bdef-08dee7c6bc02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|55112099003|10067099003|56012099006|11063799006|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	19J/Q+Eg22/RwyG2iTBZMQ8eMdDWbp4WfFmY9TQkfSN3KEuZDYIFmZSMF9UGckU1EpKMHx7CmqlTsDCuNQyEwBU82tctzbG27kkqJPZV0PYAvbluk9vXTDLlCMJBToXyZzM+5n7yl3iJH/wvnL0MHuoLcv8Cl529ZcvKD2aBMc41Vm/SnY4sr/EkLT/yrgOnW3N0vQdnAVGxMhoaQyNulmmTdE3FmEoPO8pH89gKwbOoGSz0c0WFpWQAnIn8RUHeitBu22alcbxGUp7a8Mwzd6RyjhH8gL29RP0Wh2xVvXem3J46HSTfDYiMzp5m+m9dpvrz8HVghyXdUFyg+G/igkrXH9Z24yo+jPVcq0Qr7ERzrQJ9h11NviG4Tu1IXVQ0PW9giPkQkRAnH5cEWuQYMejh8eSlh7wR1t4FVK+hMa9/ZXbCpFJNlvQ/OX38cWaXH2Gcw58PpkQHl1rw2Yw7zQ3n604AksHFhbOx0MNtdZDlG5dXTe1dm/xbOtnigK8gJ0qyhp+0mLj0VqD24WErWRXciV3OG3yPb73VJQEDl/XQjoCWnrtEIjFie0GcAbpzRSoyWoEZPDvYI7Y/6c5RW8BS10ijacse29ecFBeNWzMlEV086yRyROTGhKmKg1xeTmWGiULO5Gg1D0bLppy2/yqScBZDiV+zi9m323rCK3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(55112099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGJaU1FPNVVTR3JFZFgvTnRxb2ZLUjRVZzZJaDgzalZtaVBqcXRsNUZrbUdx?=
 =?utf-8?B?Rk9sdHBIaGREcHl4N3pmd0tmeEpqREJFTUVYUkNNSk9HVUNteHRZbXQ3djAy?=
 =?utf-8?B?TzZ6SGE5bEVzSWtlcEF5UEZSRFZxS1R6MGdNOUh0RXBFNHhzMmNocGkySE04?=
 =?utf-8?B?REpaVWxqTzFOQUJrbXJRSmlWVm9wdjkweVNuRFJRayt4S2VaODhTQkxqOGhl?=
 =?utf-8?B?ZGdzYzhIWEhZZVRqenFCSkdIazUydnd5Y3B2ZnNzUmxWOERIU2tGVUhwYUg1?=
 =?utf-8?B?bVhHUC9Bam5GaDRCdXpBakhQRjBkQWluNEJNQXBNRVZnWEx5cHkrcW5wR0V2?=
 =?utf-8?B?M05HZWUwZ3JLdjlOWW5PanlrTnRFcWZncmdENGZqV2UvQlR2YlVTWXNTTXJW?=
 =?utf-8?B?b25YdVFnczdTVXBYUDI4RVpycmgrRW83S2wxM0hJdVBkOVFZMElzZXJTS0Vq?=
 =?utf-8?B?NlZDZC9ZUzNlVG9tL2habzEyOVhCREw1TnRBdDNaUkdscGtVTTA4cFEwdGVm?=
 =?utf-8?B?NzQxMDRMeWZ3Qk9HQnZKSU1nVVg1bUlJRHJhRTlSYUVVSGdkZ2VBcWVJOTBN?=
 =?utf-8?B?R0diRllKbFp4SE5VSkdza2syaE4wbzY2YlQ5MFFxOWZVYmpnc2ZxWTh4TVBu?=
 =?utf-8?B?Unl2ZWRhOENEK2QyMGlmL2pPMklvMG1pbFlJOHdoZDMvK2dGWVFScnJRODRt?=
 =?utf-8?B?czErMFAxK1ZUbjBzeW41QmJnNWJKNFNjQTJBcDFDOXNGZGR4K2VGalliQXFa?=
 =?utf-8?B?L0xORUI5ZUo3SDJQSDVXV2xSUG1DdU5IQ0pJbkRId1A3WmtxdG1Sb3hIdGFv?=
 =?utf-8?B?VFg0YUpGakE3cndKMVFIdlFZYnB6dEhrS3ovd3ZCRS9oUmFwSWwrSDBJdlV6?=
 =?utf-8?B?NE5VQ0R0UU1PWFBpUzNlcTdVanBwL1BTZTB3bDhJdFNOaC84cGNBZHVUNjJ1?=
 =?utf-8?B?L0ZLYnNXVzJHamRobWpCQkZIajN5MS9SdlhNYW8xTmJXM1BXUHJPUW9GTFRy?=
 =?utf-8?B?QkJ6TTJjaC9XQS8yNnJSaFNtWk1GTklwZTBkeld6NHJ5SDBXMjgyMXdZbVU3?=
 =?utf-8?B?NzJoalcvWENBTVN5K2lmS1B1dVhoYVdWcG14SzhTek1DUzJqODFWY2hBUlBM?=
 =?utf-8?B?dytCOWZUam5BdWN0K2ZITk5sK2FBL0UyMTJTWkFkRnRDczVEOE1DRWJOQTIw?=
 =?utf-8?B?QTk3RXc0UGZDbVRBeDBEOXdQN3lsWEVuZkRIUzhuWE9PMGZIaFp1Zzk3RnpJ?=
 =?utf-8?B?bVZPZFN2ZnRsclljeS9IQW03N1lXdXJRd0xwdlU5UTJrL29zTExLUDFmeGlZ?=
 =?utf-8?B?MkFXVDV5ZlFHTU4zcERsQWhqUW1iK3pFZDE1YUg4eTB2NzBRam9jR0toM0JZ?=
 =?utf-8?B?Sm1URkJaMFlabkFTZVVscU4vUHVYTEdreS9SdTI0MnZXYzZsd05WTGRZWlRk?=
 =?utf-8?B?SDB3aWFvR05uQjJEbktRdTNJdFZDUHZycjVYaHJ4YzRtMlNhbEhZZ3g1ek1y?=
 =?utf-8?B?Z3gyMkF6cDdKL1hyWElPclM5d0hua2hPcUpNSElydjg4MVF2OHk5ekJPK2V2?=
 =?utf-8?B?WDhvVXRxRmxqR3RnZUpoamtVQXhaWWdPcmcvYkVlRGFTY0pSYWF0ZnVieVdk?=
 =?utf-8?B?MEJHS01TRHZOR280M0dEeVk4NzZneVY5djdweGNzV2I0aE9JY3pzdnFIMVNo?=
 =?utf-8?B?N0xTUExXNStCNC9raEFrSzNXc04xOStLOThrZEV2aGRsTmhzb01oOG9XejZI?=
 =?utf-8?B?UjZiTWVjRXhtL3VvcnVYTjBhUHp3RWY3MjVaNzJ1bkF3ZU1IN0hyYnA5VmhC?=
 =?utf-8?B?RDYxSk03VGV2dzZHNXJ4SEVWYUw1M1R1ditHWSs3eWdtd3V2a1VRdHN4ckd5?=
 =?utf-8?B?WUo3UlhzRllLallHWHR1NERjMFlmdXJxckoza1JUaE1KWEZ1d2wrRjd2YzhH?=
 =?utf-8?B?dStvYVhqUDZ2dk5lZGVSamxjejVIMGNnclc5WktqMmxDTHZ3NlJxeW1OWjlR?=
 =?utf-8?B?RDJiQkRYVllkOUVtSDdFMjIzYTQxcHppK04xcTU4YkNiNlU3Z0lEbGZPd3lE?=
 =?utf-8?B?WHcwbTllTzRabEtiTm9sTTNBZk5mbnZmUm5wY0lyTU0xU0ZOT1dldUlRMnk2?=
 =?utf-8?B?K0VvUW5JRTVkWjVpZEtISks3QjdDZlNFQm93THFwMXZYMnFCVVJ0Qm8wRFEy?=
 =?utf-8?B?QitIcWpVb0svQnl1dndGYlhTaG5aTTk3bTNjTUNKaVI5ZTRXRWhSZ1k1TXE5?=
 =?utf-8?B?Q1ViU3hrOE1yV1Vac1dObCttakpKdGJZYmpLZ21uYzlvV0RvZUxmdFZaeDFt?=
 =?utf-8?B?WFJoYlZtTUlkMkNGMXhPcndubnVYOG43RnZsam1vVUk3SnBEYmxMUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efceba22-5d1e-4b68-bdef-08dee7c6bc02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:56:27.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81o5RZM7/JoVN18WWz2py6NsYaO+q6aQMIDOPLd83K2riw2LRGv3wDyQAOP18TMlXbV+ZVZRVQpSWiEb2X2cnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3135

On 22.07.26 08:59, Dominic Rath wrote:
> On 7/21/2026 10:03 AM, Jan Kiszka wrote:
>>> What I'm not so sure about is the following:
>>>
>>> - is running Xenomai 3 with cobalt on a kernel with PREEMPT_RT
>>> supported, i.e. should this work?
>>>
>>
>> Conceptually, yes. Practically, this combination is very likely
>> undertested (e.g. not part of our CI).
> 
> Understood. Thanks for the explanation.
>>> - is it conceivable that the main thread continues execution in the
>>> Linux domain before lostage_task_wakeup got called? Or does this
>>> indicate that there's something else wrong with our setup?
>>>
>>> I've enabled all of the Xenomai, dovetail and PREEMPT_RT debug checks
>>> that made sense to me and I'm not getting any errors, but of course I
>>> might have missed some useful CONFIG option.
>>>
>>
>> Did you already compare the event flow you are seeing with a reference
>> flow you could generated from qemu-arm64 image of xenomai-images? That
>> may help looking for the essential differences.
>>
>> Furthermore, you could patch xenomai-image to turn on PREEMPT_RT for
>> 6.12 on qemu-arm64 as well and possibly run your test in that setup
>> (provided its portable enough).
> Thanks, that's a great idea, I haven't thought of that. The test is the
> posix_cond test in smokey, i.e. nothing of our own, so I'd assume it is
> portable.
> 

That test is regularly run on arm64 as part of our CI, but only on
kernels without PRREMPT-RT.

> I'll make sure to give this a try and report back, it just might take a
> couple of days.
> 

Perfect.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
