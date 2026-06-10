Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213638D414
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076080; cv=fail; b=YkuqSZNfGDIS+5XGsZIgJJ1CoMmADYMFrwsn55Ta03NJ54/XTSq2g4U5lLuo1wP/G2nCRcsm9QFe4KKF/WVtgatNoQ9B5JyJMR1R9UIsHFahcmM8mTlyXhHV484FI+Ef9k2SMF+ff48B28o5/DhbwqqWHGUXbP+Tz1Dt6u51a9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076080; c=relaxed/simple;
	bh=5zNUVQSSQg47LcbaYgiVldboKt8aEOi59VGucDMKrao=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esutQxpKZAZlc/a2YjIxo9thPWsgmTDils9pHe2dH2eFpnM7mWGI2n8aHoGiP/l6K3CqXcs5JbIumBwn6eu0xUK8PEFMV5Khp1DYGmrygtx9S7VxRp+uy8I0+m7ZkKKOwrBY/2R+eN8cLZb6aqpSoZ+6FJIbWnBv/EN4r7nhSWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Uo5LtqXA; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Uo5LtqXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWWDzhqqFdGpGmB8byO3gVLdvx5cIaF4tq76PA277YENDy5fif6Afh7/lkAg1TdsevIwGt4mzFvxgnY+oZCH1BqY1Mpe0HU63yWlk0pJsieWejGVdttYJJptI9lCw2eOtyq+tlo8M6C1QmY0Ol6UJe562p5McHczIV9nqH7dNjOzTDIALXDcPmgS3p+OXlWJ1JIMiBtTreYghoMLlchPdjhnOTFQCVMXYFI/GnHbobOy6ZcJ6GYaZkM57Og95jXjAAlKN/gVxHWVOdnCwBJHmynwg4I9OuzquJi46wi1b35kaW+oe261hxLCuxinuTdVxxaEK/ymd0WadtIjqALNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8LloBjMKLLABWjfgI8kO+9JP+6L2ulxf2m+VdmQktw=;
 b=GdsvhV+kU3koSPLQOH+QwockSwwletWBcsZ0oMrV7oKJprDBBk0gH0E5ZQrdPPSPm6lJtc0ZbigAKlPqMfEzs4GZ+hSFZ9ri4PUA9Czi6SbKeo9wPbPWNs2xGUP6D2RlbhILFLSYBlmbqnpv9JADOtr5QALr2BgPp5kjnvMqxzMyoOBtUWX6hF10DLusW1UP/GgxRaeP7X+eQyoyK4UHVgcRvSfD7XdnTqhJ5K5j9HGRC4r25uolpePDYgvV44B3EgRRgs0qpqIBlAYTNLWFJ/lzmY295CKuBkaqcTEnQ+HEYnzIvnuodXsdi9q0cQnAmOkqqWBLETtKC2fL9kHP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8LloBjMKLLABWjfgI8kO+9JP+6L2ulxf2m+VdmQktw=;
 b=Uo5LtqXAcbtEJnE46nGzt2Y3jNvzFUwsKn5fmnGLtOgExETDUj9e5Va6aN6zGbMgYoOJRKHDXgbEzZwT2Sb26dBnI1bYWMTXwXCblCFuLFL9lTQ3JR7nprB7mUGAyFGZ+UvPVbG0bIQIZ7aEpERcQDmAaAyjWo2AjIrv6zeRChU+ql5uOSfHDKilvn8F4UjwKuzUxCLZ9F2ICVWfl+2k9UoUnXRWZ1ClM8uFTYuhha5MQtqSMMCcvNXiHYbNtBbG5oarpWeqpoXw8mY3qwdgTukgFgwdlH9l046/5g+pp3NsecdcpbVt1QM9gJ6tkbkWWIIv446dFdFnvB4xFkdO3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:21:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:21:14 +0000
Message-ID: <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
Date: Wed, 10 Jun 2026 09:21:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db6a633-e22f-4164-07b1-08dec6c0dad4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|55112099003|6133799003|56012099006|3023799007|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	klXJ1GML57r8NOkSg9XC0elu+tV5rJ+l0Tuh1ClSLNx8SpXmAvzaI1rZFtHbp31Ca+3b8H+e/YosE5LlZQfLGi3nlS3fIfB+3qj+uK03aLmbYrvujgANitYSWadAm/R1vGD/1206UlRC7ASROqbZVr18ylQS76T2b4TG/G8O987QRuRcLRUdaVhtP0FMvF5tpqO3oyWnZn1DyeF/s6tpO9XRjl/Ccy11bNGuwtOFlCslE0I9GGPUsIE6QzkeruBEuUQN/jXBV3ex9tT/B96wWblJx9E9IZQuAmQJMVvS46CUyDgv9U6LAetscqqAk2jTPtcfMCo2FjSVY+twP26N5E5yfsYd/xmuskKkdB6SWoKqRXuaZaYDBV/msYwSbdSg92l7Rgzu0rZ3c/UDuOD7/gQ8WHtXMU/I7K9PAdYMqjPo7bDnekARhkzgdUT4fwxJvxhjPHd+LKb8UMRXabjX3ghcntU0QKwHuMxuUeLvSWZcXeYIn0/B9NwE/yrtjaaOdoLLemsn5NsH4MQv2U2LN5ETEoZDV+TP58k5VJaf2fWVgxvB3z+sFttM54eA+4d2mm6cLvb3BmttrrDi0W8TRCEbyLf9NL6SFzGSuT/wLSD6BBunZXGqTAVt92XaTaWq4iB4vq6MTp6xFBIkqyyGu9q77oMJ7aoL1EI1TsndioBpMVE07e25+eVI8Pzeu+i5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(55112099003)(6133799003)(56012099006)(3023799007)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUpBdzRSZm1NcEc5MWxMcmpWOFJ6SmsvZWQ2ZGtrcEc3cmJUbHJVd0pFMjRJ?=
 =?utf-8?B?TVViRmdwWTcxUXRzdXNYeG5MVmdNcEI1N3pCZlU1ZjQzUWVKUXV6bU9FRVNL?=
 =?utf-8?B?QUptcW1CY2tYSEZZQjRIWmZLaW1RMGxERkY0cGFSSmVRbDUxZUw4MVNSdXZ3?=
 =?utf-8?B?NkNib2EreDd4MlVtWmlnZWVYOS9hMzdjL1M1UytvWmQzbHZMcWxsUDRXanJy?=
 =?utf-8?B?enRCNC9SUVBqK0lWaUdsWkE1dGxiQWtRUEZwdHRHOXVGVDZIWks0QzB3VDZu?=
 =?utf-8?B?QkVrTXBhUmZTcTZYYjZyZjlHUEdUYjRielhvMUpISDJZbm50TWx1U2gwYXVk?=
 =?utf-8?B?RlJ6bnhVcE9SbUttOUp0SHh4aTA1a1EwSHppNmNrQmJwQ2NEVktCYVI0WG5G?=
 =?utf-8?B?RjhLdWJwVWJwbE41aElOUG9wajdiMWFTVlIzeWMxZ2tiSXd5alNuQUVnUUxa?=
 =?utf-8?B?T2QrdzQvVVRlM2RuUlkwSmxvMkwyZGRORXBONzhteXU5UXhiU3hYdDJ2TzhR?=
 =?utf-8?B?eTZtaWVFL0hOd1cyNDFTVEFlTUdFaVU4ZURuU0w2RXdIaC9CQUtyTFJUNGV2?=
 =?utf-8?B?ODM2NnpMQVhvRllCeVJzQmJxbjJWV3UrYlJ5TU9WUVpuck9RcVlvMDAxNS9v?=
 =?utf-8?B?RDZPcDNZN0FLWjZ1QTIra2puQlorVmxIa0NpK2lpV01oZ2NWMXdrcm45Qnpy?=
 =?utf-8?B?bzZnaVFwU1VORFhUVXJIMEpKU2JxeHArVHQzS29yK2NmMlo5TGtzcjg1Qm1N?=
 =?utf-8?B?cS85NDRkaVJXelZMS2l2aVZVelZtT1N4d01EUDdvVU0vMmoyY25pM0JjVGph?=
 =?utf-8?B?ODlMY0FwRXJjeWtRSG1FbEhrSmFNNE9IV1BuMnVESElENVUzTU5MaC9ZU28v?=
 =?utf-8?B?M3g4WS9lWmVTeGpwTCtkbTRmQW5wTVNldXpERkJ5cThkc05TRGFWaXkvc2dG?=
 =?utf-8?B?Rmg4MTgyNWhnWjBXNU45NlhEUkI4SENSUzF6NzFmeXZtTVFJKzRjYUExOUto?=
 =?utf-8?B?Tm5lU3ZqMG1VNTU3d3E4RGRFRU54Wk41YkpzQUtMbzlVZDFDNzNTVTB4NUsz?=
 =?utf-8?B?blB1dU1kMHVoMDVvRGxrV2hKR3lkQzA0QzV1cWt0UnhwajI2UnBKRG4wQUZX?=
 =?utf-8?B?OFp3TUh0bFplN0dXQ2ZFS0FDMi9NeStiQWNVdm1HK29xTEZWOVJFeU12a1Fu?=
 =?utf-8?B?VXFidThmd24vb0pua2lya29sUWJoODQ5RFJ1c1A5S0tpR1Z5SjFxYmNXR1Rt?=
 =?utf-8?B?U1V5TXdSZ1dETy9jSDUxMjA1bWpNNS9kZUxkV2E5OGpWRDVidTRNWlNKOVEx?=
 =?utf-8?B?U0tSQmFiMkNFSjQyckgvR2I4enI5cjltWHRDcWg1RzBMaEpaZTJOSFdQa1E5?=
 =?utf-8?B?Sld6WGhsdWwwUEdUTnB2bWh2RXA5cDNWN0cxRlVwRzJOcmtiYTNac0hDTXdB?=
 =?utf-8?B?ODdpcm9SYjRhTlZ0Z3J5UjRPOTRYZ1V1RHcyRU1LN1haSWRDNjJqbjFiNk1I?=
 =?utf-8?B?alJYRVRkZkxFbVUybWVSK0MzeGl4MmhQRWM0b2FydlVXa3B5ejRMdHdMWnJW?=
 =?utf-8?B?MnZ5MnB3TjZodjRqVndxbXViM0wrVUtVRHRDMHltZk10TjAwd2R2TGFKaWN1?=
 =?utf-8?B?c256M1pUT05uNjhNcHBQOVpVcGwwUVRlaWR1SWNQUjJHbk8wUk1Tckc5OTYr?=
 =?utf-8?B?MTh3bnlEc3BSakFLTXhPMlpZbWpmS2RJYXFtWWlWeHpZZUtSVmVJbUo4eUFt?=
 =?utf-8?B?UzdJQTJvRVl1SkQzOXZyY0d4NTBMRWpydnl1QnFGNTJ6cnVpV3hzSWlmVXFZ?=
 =?utf-8?B?V3FQbUhBbFRuMENNVVJmTEJ4NlNUMjFqcVJNWnlTaEdrK1VvSEtCVkY1MFl6?=
 =?utf-8?B?bXF2S3FOamVRSkViY2dCcCs3bzRoWkNHcUFVblgwa0JKckZCV3NSeG1sYUNN?=
 =?utf-8?B?SFhjbzRRTFNTak5sQmFHYWhQc3FzVGUvMitNMGFub0p3T3VFejF0QndZTmc1?=
 =?utf-8?B?YTBRM3pHelJnSk5kUGh6dUNiUEplVytHYk5wY011UHNSVC9Bb3ZubXdDdmky?=
 =?utf-8?B?WW5QczlJQnVXa0ZYTnFjVWxGZUVTVkk2Y2pVQmhLbXQrSmFRWmxSNnl6ZjE4?=
 =?utf-8?B?dm1YZEFrYitZMVpWU2d2c3Z3V2VEbWRpZmtrVTRsSGpLNmxmSXlIUERSZVla?=
 =?utf-8?B?YVVxdnVVOWRENUtSaEJnM053aFk3UDN4TTdWQi9HNjhHazhZanlnTDk1dCtV?=
 =?utf-8?B?ZjRCaUh1MVRnc3pDSmcvaENLQkJFWHFKUHdOUUhkaUdXcHdFbUtXcU01Q0hu?=
 =?utf-8?B?djBsdmhDUlB4VHBzUHR4NVhzMHlIVmF2MERSVkxmcGVqakF6RWVJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db6a633-e22f-4164-07b1-08dec6c0dad4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:21:14.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7qwRnQ/5e9/xG/taKgzB2J90fOtrvGC/vD9tA1EklxteWTgRGd/HRwAbeybRXOa7HpYWc0vVZ94u0/b1mFfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5213

On 10.06.26 08:24, Jan Kiszka wrote:
> Hi Philippe,
> 
> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
> into XNHELD, a state only existing there. I suppose that was once
> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
> SCHED_SPORADIC - so let's dive into that scheduling class.
> 
> Turned out it was never documented, not even linked to the POSIX
> standard. But it also slightly differs from it (low_prio = -1 -> suspend
> on depletion). There is also no test case, so I asked an AI for one.
> That worked fairly well as it seems to have revealed an issue:
> 
> Could it be that we are not properly suspending the budget tracking when
> a higher-prio task from a different scheduling class is preempting a
> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
> if a thread is selected from a higher-prio class first, namely sched-rt
> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
> limitation/misconfiguration? Is that issue even affecting other
> time-slicing classes as well??
> 
> That furthermore makes me wonder if we actually have users of
> sched-sporadic. Likely a hard to answer question, as usual. But such a
> limitation should have been observed earlier under real workload...
> 
> Jan
> 

Here is a trace that proves how xnsched_sporadic_pick and, thus, 
sporadic_suspend_activity are not called:

         disrupt-1682  [000] d..2.    94.171753: cobalt_head_sysentry: syscall=clock_nanosleep64
         disrupt-1682  [000] d..2.    94.171755: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
         disrupt-1682  [000] d..2.    94.171757: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
         disrupt-1682  [000] d..2.    94.171759: cobalt_timer_start:   timer=0xffffc900008bbb00(smokey) value=60000001 interval=0 mode=0x0
         disrupt-1682  [000] d..2.    94.171761: cobalt_tick_shot:     next tick at 94.231756 (delay: 59995 us)
         disrupt-1682  [000] d..2.    94.171770: cobalt_schedule:      status=0x10000000
         disrupt-1682  [000] d..2.    94.171771: cobalt_trace_pid:     pid=1682, prio=30
         disrupt-1682  [000] d..2.    94.171776: bprint:               xnsched_sporadic_pick: xnsched_sporadic_pick, curr=1682 next=1681
         disrupt-1682  [000] d..2.    94.171777: bprint:               xnsched_sporadic_pick: sporadic_resume_activity, pss->budget 99964473
         disrupt-1682  [000] d..2.    94.171778: bprint:               sporadic_schedule_drop: sporadic_schedule_drop, pss->budget 99964473
         disrupt-1682  [000] d..2.    94.171778: cobalt_timer_start:   timer=0xffffc900008bc4d8(pss-drop) value=94216201725 interval=0 mode=0x1
         disrupt-1682  [000] d..2.    94.171779: cobalt_switch_context: prev_name=disrupt prev_pid=1682 prev_prio=30 prev_state=0x248044 ==> next_name=ss-d next_pid=1681 next_prio=20
            ss-d-1681  [000] d..2.    94.171784: cobalt_trace_pid:     pid=1681, prio=20
            ss-d-1681  [000] d..2.    94.171788: cobalt_synch_acquire: synch=0xffffc900008bd408
            ss-d-1681  [000] d..2.    94.171789: cobalt_head_sysexit:  result=0
            ss-d-1681  [000] d..2.    94.171799: cobalt_head_sysentry: syscall=mutex_unlock
            ss-d-1681  [000] d..2.    94.171801: cobalt_synch_release: synch=0xffffc900008bd408
            ss-d-1681  [000] d..2.    94.171801: cobalt_head_sysexit:  result=0
            ss-d-1681  [000] d..2.    94.231786: cobalt_timer_expire:  timer=0xffffc900008bbb00
            ss-d-1681  [000] d..2.    94.231789: cobalt_thread_resume: name=disrupt pid=1682 mask=0x4
            ss-d-1681  [000] d..2.    94.231790: cobalt_trace_pid:     pid=1682, prio=30
            ss-d-1681  [000] d..2.    94.231791: cobalt_timer_stop:    timer=0xffffc900008bbb00
            ss-d-1681  [000] d..2.    94.231794: cobalt_tick_shot:     next tick at 94.271741 (delay: 39948 us)
            ss-d-1681  [000] d..2.    94.231802: cobalt_schedule:      status=0x10000000
            ss-d-1681  [000] d..2.    94.231803: cobalt_trace_pid:     pid=1681, prio=20
            ss-d-1681  [000] d..2.    94.231805: cobalt_switch_context: prev_name=ss-d prev_pid=1681 prev_prio=20 prev_state=0x248048 ==> next_name=disrupt next_pid=1682 next_prio=30
         disrupt-1682  [000] d..2.    94.231810: cobalt_trace_pid:     pid=1682, prio=30
         disrupt-1682  [000] d..2.    94.231811: cobalt_head_sysexit:  result=0
         disrupt-1682  [000] d..2.    94.271767: cobalt_timer_expire:  timer=0xffffc900008bc4d8
         disrupt-1682  [000] d..2.    94.271771: cobalt_thread_suspend: pid=1681 mask=0x200 timeout=0 timeout_mode=0 wchan=(nil)
         disrupt-1682  [000] d..2.    94.271772: cobalt_tick_shot:     next tick at 95.130203 (delay: 858431 us)
         disrupt-1682  [000] d..2.    94.271914: cobalt_head_sysentry: syscall=clock_nanosleep64
         disrupt-1682  [000] d..2.    94.271916: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
         disrupt-1682  [000] d..2.    94.271917: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)

Jan

PS: I asked AI (opus-4.7) to confirm or disprove this, and it failed in 
its code analysis. It seems like the way the code is structured and 
commented misguided it in its conclusions. Sooo statistically human...

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
