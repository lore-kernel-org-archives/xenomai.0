Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F12D249B
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105026; cv=fail; b=GV8R3wcUlg67jU+3RKpzmF8a+SUIvPiC8Vzfn9w1IXEmhM6jih4zkUlLoTVEAItL9wkviBLTxRqEuA3ga9UKmIV1VuBiacKf7jzO3r6Kj5gFioGlu8uur9hqQI8ei/EJlZTS01qg3jskF0h1BvE1mDwvSaKIrWYx8+nKMxI9K0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105026; c=relaxed/simple;
	bh=6pWP2fuCk6K6e9xJ2hmxjS7XiPOc7hhoaQSlSoDY2Bo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHDYeW4hu6WZWYA9tPTPJKaj/jwweixxY13WQW4Od9wz7XmFKJmf2QaVOW9Cv5u4iMj9hAiqJnNqfzqxdVx0+CUzb7cAvfdPfRRfYkno8s8BlVP1/arqd7zqBSqcUZgd2p+0xgP9SRxRRRqVxvO8L3LNznq8mbteUW6UYzzzGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H37pDzHN; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H37pDzHN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXgfkDGrxFz85Eu4m7kHa5qc17b7IPNnkwlJtps2Q9W1e2JBUCsR2BJ8gQ1lQMCm4MMyJJVMnzQXgHpUCsHOcRzw2g8HKqejPRkchVGhlmO4yNoIqGUhuXflQs6rzqhidGzGSFsex0P2T0V4d5cuF3Y+pke3jsYeEUdD1faAZHb5VJIdb4WNYQ6DQ1O1OvLrn8Fn98NRKk9NS+BubRz2putqJRuo2QQzaULUgqu4MFmkvOsD91l9sajkKYEqvcYlDuSMMCKs5KaAOuMPSv8MJJVrcrZvp7F6aSJ6KBjzFI7i1f3H6gWVLp9VvDKhE3I2w2fuft0XZZw4ogz3vO0X+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YpbesIAqTzza+T7SaYBelgIaIzDwsrtMzEGJGmFYMM=;
 b=B3KxV6avi7v1SRFsTDjz2xgTBRwcVPTHE7a4Ip+iPAUz3IGnnMGWndGEUhEiA473bEq3IUzInZSypZZeb9L7xW9/eVSW6FFAZIa0o2UKbyougdxbWf9N1O3tvMs2OGZQR8zIGhWd6Dqditraq5JzcZggOxijo/URkijMb/B29/2Ioo5z+Sm3VSVImljkEbj+aXjvF4ItC2SsOOUbJO2ezbScIBtVrrJLndvZiDNidNcTaoqkzeEXMdkAONBwlRDowt5aWfE1E01btm0MZd2zUSrE3KIiOcisP3TXTVzx9suf9TX2HBkYB0J0/HgOi+SLxE0CCJmkAhstt321IerMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YpbesIAqTzza+T7SaYBelgIaIzDwsrtMzEGJGmFYMM=;
 b=H37pDzHNrJZ87+jMVHrR1p6lNCg2b+kSTJnn8Xv09+GKMSeuTKOwqXwA954tpyJoiAQMY9a6VyHtBjiC8yMXW0eLzvUyQdKjU5uflWWEqwNmNFYp/TSfctGVRGaatRpKx+0vyQ8Z+n7gyI9ZXRmBCLmp1hTwNRIRKQ0xUe12qsUMczd+0k7EitX2yDcsUI/f/BY2XpxUk1mM0aMUdSAysKZaDX4z3v90RRzDxEo3X3rj6bt94saC1XeGi5R9E4fGcTiKO4DK/9FmtKhn5btwtFRxG+RTjleuN1dpPCikKTcbxRDgzgtq+LKxNSghBBd1DtfxcpMmlAuT5FoYTuGkxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 11:50:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:50:18 +0000
Message-ID: <15c0e815-03d3-4a60-b0f0-185e0eea5b4f@siemens.com>
Date: Mon, 18 May 2026 13:49:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
 <20260518-wip-flo-gcc-16-v2-4-f93562624fb4@siemens.com>
 <b84b91e1-4316-4b5c-8190-73bd46742c1a@siemens.com>
 <abcd8f3cd377cd33e7033220af02cd097d0ca3b8.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <abcd8f3cd377cd33e7033220af02cd097d0ca3b8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 29651d43-d518-47ea-07a8-08deb4d3a256
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	SvmahEh+283y7D5NL34SrTEMTtesrH5xYbvQ7Jue7+ms9bb6Kb7mIWoDjtCx9Z0qSMspVc7o5HCO+310niovVxyRybY44AFvF7zeT2tpugdan2enSu6SFbjCRONOd5dlX3D8BqrdD5mYKJRXEA0lGiRd1XPoqIw98AE593C062x5LsqvV7YcvPGFhGoFNLGvnyK/iG37jPSNr+QS9wsOJtNvExAdP5Pjzw5IcrHTeKR9SxjqsWF/R5X64RMgZnaSTDahbxZUvKHOz7ydi8Imhco+RmF8e32SHy/r50pIiJ532WA9odXYg94zophCVOi6H5I/OEPoS3uWWjHzvSdrnZh1ZKtqbYc1gXgPmVKZE+j2yAnE3yjAu5l7+mnWKH/MyyU6Q9QwUkwFSbuhgwoTW0pJU58o2sarniz9VyJqN7DiEJp94Rs35AnH+EqPIndncIKq3DDl2Y1NH9BaLjVYy7HZwE4Y4jNH7RwTs4rr6oPF2YEjbvUrEesPN5r0g5PEtZRfPS7FiNr8VvlZky9Eych7Wkkms5/07kgZcGYwSlJvu01WSOtscedQnBCswROvFxCFGmEn+A7HFuIKAP3FvgxAe492MoMsCbP6/QYd9fwr4QYDOApGUAFp3zVGw2WPzogOiQA6vV/QQu9tpG1g5Oc5eJY06YesIyqvZBcFmXrPcO34lmcw9xUNXI2SNt5U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0VMR0c1dXVYZ1dUY0hKcE5nbExmNklQcHpOOE8yeEJRQ2YvVHdyZGszMzQw?=
 =?utf-8?B?OEk1ekoyMXNHSGxldS9xR2M2OHFyUEs4YXMrQ29mUnczSmhnVHdmeTBZUC9p?=
 =?utf-8?B?dysrblF0dWw3N3VUMWN1VFRyMGRnT0g0SmlVTTRRb1dnRU9VYU4zbzRFNWdi?=
 =?utf-8?B?NzFQZHJNdkhmQ3N0czkySmpvRVBhSytHSjFQbDl6cVplVG5WdlYrcGU0dGJ4?=
 =?utf-8?B?MnV6N1lqSG1JZ1FFQXVqd1c1dVltVDloRUoxVXpwYThhYkloVHJkN0h2TElH?=
 =?utf-8?B?R1J0bnFqMGxiMUZoT3Z1ZWd5RStINlA3cVVqM2E1OTdVdjY1RkJGSldqS0lY?=
 =?utf-8?B?dDN4VlpXMXl0OHBBSDduMjhQSjZaMDl2YWNLUTgxZGZkNml2bURCOE9rZTh5?=
 =?utf-8?B?ekxkSnFnaDF5MUdCZ1VsWTJyZG9Pc1pxNEFNNFZlbVdzVXhzYlhKNS9HU2dt?=
 =?utf-8?B?V1BpVEEyYlpxdWpJOGNMTUR5MjhNMHhqUktKMllFWmFVUmNPdnd6NWpnVXVt?=
 =?utf-8?B?L25manUyOWFuRE92S0twRzNMdlpLcGNJUzFqQldBcXN4VGhNVHY0NmhvdUtZ?=
 =?utf-8?B?UkEyS0VQZHhTUlovbVp6RUNERDZmVVEvY25BK3VLZ2tQOFUzQ1ZDeTViQmxq?=
 =?utf-8?B?dzE0SWRxUHZvbCtEdGFSNVRwZ3NiL2xPbURTZlBNSS9WNXB5MXBoTmdKR2ow?=
 =?utf-8?B?WWFjdHpRS0lGRkcza05KMnk0VSs3clZidldQdzhyclV0Zitieit6cTQ0QzBV?=
 =?utf-8?B?RmpMMXlDRFNXQS81cmIvTjRGZVZ5YUQybHI0RTN5WHdPcHZzTjB0N0c5Qy9S?=
 =?utf-8?B?a1l6cE96UUE5bGdVU1lyTkJram5Sa1ZKWmIrQlZ1L1lqWko5dkhiaTlheW4y?=
 =?utf-8?B?NVpLTC9NalNZd3lYTFdTOVRpYTlrZXVZMVlnM2VTVXJiV2FUQ3U4dG0zMHlp?=
 =?utf-8?B?Q2MxU045T014aXVOR3BDVFJvZXFkWlM1UWYxbzdXc2crZm4xTHdjMkNIM2FZ?=
 =?utf-8?B?Uk1uL3JEQXZoV2VaMndnRzF4SjRoTnJzQnYxWGdVL2tSdUhOYW9HQVVPVjNw?=
 =?utf-8?B?aUNWRVhlbnNXZkluSlZDeS90c1dmbXk3M2V1ek9NWkVKSVZWd2pKRUo5M3Mv?=
 =?utf-8?B?eDlWajdGNVJRYXlQaEc3aW9hS0Jpa09DVVY5Sll2NzNSUlA3ZHl5RU8vYXAy?=
 =?utf-8?B?Tnh6TE9vRVc0V21kOHp1OTk3OVIzdzlNM2N5bEpVVTJOaHM0UTlHVHpDQ3Rp?=
 =?utf-8?B?blVtcENkQkNtT1JqcWpnK2p0dFRDY3FhUHFrMUtKWE1IVjZCQkFtZml1d3pB?=
 =?utf-8?B?Tkg1RHlVb0E5U2dWalVCOGJ4V2RTMmZWYnFFNllRUFhHS0JTakJKZVhsTUZk?=
 =?utf-8?B?Y2Vmb1ppVkdDM3A0NTFWVnVzK05iZXlsOEZrbnZvQnRKbDk1NWNrRFVJcm9E?=
 =?utf-8?B?MjR5dkFheW94RldZblFsRHljOFZDNmJvSFh0emZDdmIyVldtVGNOSG56VWZk?=
 =?utf-8?B?ckxvN050a3V1WW43c1N4TEtqcktoUmZLdW9MTCtOc1BnMThHdi95OEF2U0pZ?=
 =?utf-8?B?amh6OW91UVJaME9ZVkpUZ2FoSVAvZmFYUHFzbk1IcGVyRExwSzFtWTNDci8w?=
 =?utf-8?B?T2NBYWVidDR5SGFtYjBQWEhpd2I4WGk5THZ5MkN0NXFYK0lla0k4SWNsQkZL?=
 =?utf-8?B?czFhYm5GR1JKUXlzYm1tV2RqeU13aHdJZzJqc3kyK3NZMjFLWUFuZTRxSkRQ?=
 =?utf-8?B?QndHN1RGdWl2eFNjWWtZNCtFMUl3SUlJYVpyMEZoMmVuWlhBNVNmL3BIYk9Y?=
 =?utf-8?B?eFIvSTVtdlpzOUFqcEtINFVkd3ROMDRPRkZFT3FHcE1vV1F4N0hOQmNiZEtL?=
 =?utf-8?B?MTh3cHJnMlZDdmdwd1VVeStQaHpQNEZjeDBDN04vV3lzeHlvU3d1VlBPKy9y?=
 =?utf-8?B?bld6VWhTMXE2RTQxVGsxWkkrUjRTOVE0dmlNVmJtUUpVanhXUWptWE4xM2tN?=
 =?utf-8?B?TjNVejRKM3BTRlV6MGRxU3k2ZXVLNWhlUGpXbzl0YWRxcG5rUmxOWi9OL0RS?=
 =?utf-8?B?MEZ0SHdHZlhhamFYN0RWTkpNbGRyeTJ3VHhaVlJoOFVZNGZpN04zamVsZGVt?=
 =?utf-8?B?NGJvL1pYU0RMOUR0UW5kWHNXSFpqaGgxVC9OeWtjSGpaUmlMbXlGQW9nTjJv?=
 =?utf-8?B?R1l0WDVJQ0VSUnIveFlEc0Z6UlBycCtCY0pXMFVFMnRnak5YSTNZay9pa0Rn?=
 =?utf-8?B?YnhsYTcyTGxETnM1UmV4QUpxL1hlY1pxWHRoblJiVXlZcFg0SjVaSUl3Z2h0?=
 =?utf-8?B?Z3BBZ0hBdE1sMFVaQURLWHIwT1ZJQlh6TWxzeVByTVVDUzNqRHc4NTN4Z2Zp?=
 =?utf-8?Q?jbyb+nnNRL90HKTLOVEkfxUmwIvnpsQCnUHqfp7u/K8v6?=
X-MS-Exchange-AntiSpam-MessageData-1: TJd/rEmb1zdkog==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29651d43-d518-47ea-07a8-08deb4d3a256
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:50:18.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LauHLDLisMDEqDECvbZ+mQAhIChipq6BQEEYQj7ehdeMHjnm9XScEFlzpzf5zoD2dMA2V70eXbQR/xb3kKR17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6737

On 18.05.26 12:24, Florian Bezdeka wrote:
> On Mon, 2026-05-18 at 11:21 +0200, Jan Kiszka wrote:
>> On 18.05.26 11:02, Florian Bezdeka wrote:
>>> Fixes the following compile errors:
>>>
>>> rn-1.c: In function ‘alloc_task’:
>>> rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>>>    16 |         int ret, n;
>>>       |                  ^
>>> rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
>>>    15 |         u_long size, alloc_size = 0;
>>>       |
>>>
>>> task-2.c: In function ‘backgroundTask’:
>>> task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>>>    19 |         unsigned int safety = 100000000, count = 0;
>>>       |                                          ^~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> The counting busy loop has been replaced by an interval based busy
>>> loop.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/psostests/rn-1.c   | 7 +++----
>>>  testsuite/smokey/psostests/task-2.c | 5 ++---
>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
>>> index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
>>> --- a/testsuite/smokey/psostests/rn-1.c
>>> +++ b/testsuite/smokey/psostests/rn-1.c
>>> @@ -12,15 +12,15 @@ static u_long tid, rnid;
>>>  
>>>  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  {
>>> -	u_long size, alloc_size = 0;
>>> -	int ret, n;
>>> +	u_long size;
>>>  	void *buf;
>>> +	int ret;
>>>  
>>>  	traceobj_enter(&trobj);
>>>  
>>>  	srandom(0x11223344);
>>>  
>>> -	for (n = 0;; n++) {
>>> +	for (;;) {
>>>  		size = (random() % (sizeof(rn_mem) / 8)) + 4;
>>>  		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
>>>  		if (ret) {
>>> @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  			break;
>>>  		}
>>>  		memset(buf, 0xaa, size);
>>> -		alloc_size += size;
>>>  	}
>>>  
>>>  	traceobj_exit(&trobj);
>>> diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
>>> index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..be1b6ca18c5354ba092d55b3655bae9a294f2ce7 100644
>>> --- a/testsuite/smokey/psostests/task-2.c
>>> +++ b/testsuite/smokey/psostests/task-2.c
>>> @@ -2,6 +2,7 @@
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <copperplate/traceobj.h>
>>> +#include <copperplate/threadobj.h>
>>>  #include <psos/psos.h>
>>>  
>>>  static struct traceobj trobj;
>>> @@ -16,7 +17,6 @@ static u_long sem_id;
>>>  
>>>  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  {
>>> -	unsigned int safety = 100000000, count = 0;
>>>  	int ret;
>>>  
>>>  	traceobj_enter(&trobj);
>>> @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>>>  
>>>  	traceobj_mark(&trobj, 2);
>>>  
>>> -	while (--safety > 0)
>>> -		count++;
>>> +	threadobj_spin(1000);
>>
>> That's just 1 µs, isn't it? That sounds rather short, not only for VM
>> setups.
>>
> 
> Arg, this is crazy. I measured the execution time of the previous
> counting loop on my nested virtualized test system and tried to get down
> as much as possible until CI would complain. Turned out: This test is
> actually never run in CI...
> 

Haha!

> There is a comment in psostests.c that this test (as it was) is broken,
> so disabled.
> 
> To get that running on my nested VM setup here I have to increase to
> something around 2ms.
> 
> Let me spawn another couple of CI test runs, maybe we can re-enable that
> test - or delete it entirely?

Someone who wrote it may help us to understand its original purpose:
adding Philippe.

testsuite/smokey/vxworkstests/task-2.c looks similar on first glance,
but it is not disabled.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
