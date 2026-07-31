Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38F35FF6C
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478234; cv=fail; b=CMGk4x02yUvHquMJxb2amTzeD8YlkvF/TzEfpGk2NDLmFfThnE0JVmX6RcLnkz6AlI/J1N+oEwH47QlSTY0ObzX3ZyccjtcZ8YxJ1MScpkVsA7VMC4EPeDiKU2oWbfsFCGrONvSqGy1PhuzauKV2sgTFm6Srezv1OBR6YuM0Jj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478234; c=relaxed/simple;
	bh=pXCiPC+wGk8mxxBUCg1AowCKOITMcrA/lxBWIKCRElk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HWMO44nhL4WoJyz206c/iMB0yZgAptrHJR2xJzMNiPDUZHu3EXnpwVIl4Hyafb9zuvQmkq907Ixe9RGOMZCRyZy2Va82Kq6RLq0TP/7hf9iGBkr3V18mCBfl0MbdQ8QH72CsLJcECveEKiafMaOLnJ18qXH03+RMJ8ghkAgni9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LObxxfuq; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LObxxfuq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0ohAtxh+0iPZSlSSwUziYC7S+0zrCMo6SfXNOokRVKoEpzwjEdPY16t1jEQf8T3vRNuvhNnZPuHONnJNWMiVlw0vjxc7evhxt6ADEmGS8JM2FvXj4P0kK4bB7jtFj5TIMBvbR5bUcH7yu1wULnYczdCxltaJunJlJuhy2YWaE1Vb22UhpW8FH9Oz8k/GgkiA0mgMCRM26oFaAKqY150zsGKLObBJWC8VDhUgHxuKPC3xVZ0TDAldIgdtsshuCW8bPmiiI9VZL9bbyMdcUCysEH1tP4BJkahRopKmIcXwTRr5jQj5ARb+dJsZqu0b8+UKNQrdJDbJ0UlQeKRQV28Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yswMiM9rmei+X0o6/pqjH3X1d9odrkn9Re9R9FXY7Ec=;
 b=BVloye7Vkx1Lph/dtKPIKzplB9SLZKL6dvxdLzku5I8Fsi7NCi8xvCXkmSxB2MokRW8wduK4gSXicUJJygHDwkI1LaLsawCsziqLfNdRCj50IyEIoytBMQqwMBTVRrnRkKmtyIuRl4/JTQvqBHovvidOQE3uh0P00V37QUsOVFs7Nv4bnXYmHCw2+iixgjpIUeNmNsFsbLRKESu4SvGHoDWNGADa8Q2mDSmB1KgU2MXZPANBBImibGXs/XW/fy69bc/zHtGlj4oneCpw5mv5+X6+mc73ou/C97fjkT7FrDVWZEPZxoVkaHNHfZCiYBbKUa/Qpm/e/71T4z5e9i1fTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yswMiM9rmei+X0o6/pqjH3X1d9odrkn9Re9R9FXY7Ec=;
 b=LObxxfuqT6DtJX8Ar4GWxTyfQYgCE0BvXhLLzpoYTgWNlaqcgIXFSg/mseeY1zt/UcUC2rH73IBo/toRNLKcEcTO0qRecAoqNI+E/bbfln0hr8bPMCe7E2rd1hxejmIGK+P0Trcz7gYDPGfPt9vGuHncL1/ff54XC30CI9CaLBeHkXw6+KEvWTwwNcunZc/ofHwkfs/sk3mwFDV5g0yY2MxLRLTCGWk9JHSoB32puK9ODPGC1yv8v2uyfXlDPOf0i+jGGUFJVJC6DmPKWqYobl/lK+Gyv3yoayZNChcblIHD1bg+R5WIjKRxj56anAK2M9r9N9bzziIEYPDKQuHuBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:481::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:10:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 06:10:28 +0000
Message-ID: <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
Date: Fri, 31 Jul 2026 08:10:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5p2O5bCP5a6B?=
 <lixiaoning@sinsegye.com.cn>, =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
 <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
 <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
 <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c621778-b702-473c-753c-08deeeca6b02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wnfyiIui7nfAxKvaqjxAW8Q9afG0CC+Bd8hq0ot1LaCeJGBWI0yBau/U2Da93hH6Fi+6FfFpcdHa16TpV/SxmLvSxnAsvF6dfg4lxBvbLfk+WsF0GU4qaZtQJSisZHVGU10mI5w6uZDn3MgsMERyV03Ff4kHqdP5sKTxt0Z0k0KEY8szJ0yq2jw7IUP+y7s4+er9KCqs16bDFCRmmFM3bLGeOGRu6E/SKRcy/n0LpVxQaatISa36qHQQ/ZyxzAaU8UTMbU9HD1L+jwINJz7xo+6bIvSqVUqW+U9t3QAOv2S3mT+HqNyQgzB9iYZtH7PIZoCBxtNuyGeYWLRF9oL799epWZjYVMyU3Nhp36s26NU10k3KtPWzM1ufV4ogwEqKYPMTSYRCes5LoMbwcDpO8sXcYlOsPnY8uRy6oEtbthWaF9656UcV2aWVk0rF3T9TBewMoVlB9UaaT0JaVrBmiBGTANwYEGRsFOShVAvHF9NIT6TdoSw00tdlL0ZflVrya6nT81O8XCzUg3EwWBsBcn0VqPCX3hxfLg+vz+IkkT1zdUIOWOcxSOZzPaHF7iLMTy14jnWNSYtiyawmY8Szx1wF0AzV7bgXNrCdQyHYNbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1o3VXQ5dDlUci94Z0VYdk54WlZYZllkc2s5MHNjVjFZMk42NnAxVUdpWFBO?=
 =?utf-8?B?R1RkVWI4T2pTNWY3STVmbHZESUp4bkgweURrdjdsbzdpbkhLSks3a2xSVUpY?=
 =?utf-8?B?RTFRb2cwR281cHhFUW5lbzhlUEV5a0ZTYjVTQ05kc1JzTDVBWmJEdFlFNklS?=
 =?utf-8?B?MFA1Zlpvb01nYnYwNWJsQmgwSlNpYXBsM09YdEZQWVVZWk1EY3grMCtvTXgw?=
 =?utf-8?B?VWwyL0lXMXpoYWhxdHNEdmZ2QVBCUUdSdlphT3pkc3A1UzJ2a01nazBsMUd5?=
 =?utf-8?B?RzU3cDMrVFFiZFcwSEQ1VHdNTXpDME5nbzRDMmdEKzJaMW40TTJDWVViVFNo?=
 =?utf-8?B?UTdtdG9DTlF6Sk1KU0tFR0oxNHhNeEt4cUUybEtvVkRLM3RWUWx3YjFhaVc2?=
 =?utf-8?B?STZTMU80UUpCMHh2NkViZ2tOZ2pReHE2djdXajlObXBtcHpKUzRDSURVbzcr?=
 =?utf-8?B?NnBldlA4blJPUG5MZCt5a0hhOTdmbi93dzdRUnRPdm82VUNZRlVPTXc0RVIw?=
 =?utf-8?B?TzN5TmtCNTk5bmJJM2JHcEFhcU53WkdSQjlJR1QvNHFDaVBrMVdQaEJLTFUw?=
 =?utf-8?B?d3Vvb3BqWGFEYk91elI0blhLendSMG9PMkpleDBUKzYvRnlQbmVqcVMwQjZV?=
 =?utf-8?B?M3E3SE1hbXlLY3p4VVFUajBpQnB0Q0RLYTJKbjNkdTFLUUhxTEdqOWtaNlQy?=
 =?utf-8?B?d003VlNOeWtoeU82MTkzVEUzT2VIbnpWc0NDaVF2ZWVaS0MwQnJKK0wrd1F6?=
 =?utf-8?B?L1NwMzl6VmhrWG9yaFBiVnljamRNMFNzbTZSeHRRdUtOWXoya2FWSnRub0N2?=
 =?utf-8?B?WWlWUXlBWGJoYXcwUmorTjFwTjVPOWdyTEVwMUNkejU4NmE1Q0gzS1d1SlFH?=
 =?utf-8?B?SVNsVmlId0RrTWgxbk5EazVwT1ljL24rRC9oQS90R0hWL2ZyZUhpcWRjTDlx?=
 =?utf-8?B?LzdqYm84dU5DS1poNjIxNE12U1pEdU8xTGdUWmhvRTNNRHhtQWphS0RYMXdl?=
 =?utf-8?B?U0R3U3FDK0lsWXVkWXFaVXRGVkJJUnFyTXNXM1Bnekw2b1BwNG1scVppL1Er?=
 =?utf-8?B?VGJIR3JmL1lUSFJWOHgyRlJ6QU1JbjRkM05EWm9rRWNwSkxHRVZUVzZUc1J5?=
 =?utf-8?B?dE5panJOZWI4UXVlQmNsQlRYbWNRWWRlTm1Bd3Njby9IRHkxM1pmZDVXcVdW?=
 =?utf-8?B?QVNDZjN1WXVucndCNEE4OWNUdFZnNllDa0UrSUd2ZTNuZ3paVDZocU9pbEhy?=
 =?utf-8?B?ZXpzMG5BS0JYT3lPQlJVdDF3OHRaOFcyWjhkVWtmVlFhbVJlRm1Oc3BlM2lC?=
 =?utf-8?B?UDlqc0Z3Nk5DeDdVWTZySkF1QUZ3QWUzZmpDUGtDb1R6MjllbU9HZXlIYzRv?=
 =?utf-8?B?Q3gzbVpGOUNMNFVEOHF5YWVLUWVONUE3Z254NTlDbG9yV3h2S0lINDRNSm42?=
 =?utf-8?B?TC9FZjdQUmRHaUk5SXBkbFBxVENOd2cza1EvYTcrd3FOeldLcmlHWnZzRUZn?=
 =?utf-8?B?R3Rnc2FDWlRZWEpFRU4yaVVFOHZTS040amxHdkNMMTMxWFVJQVN2TFYzM3A0?=
 =?utf-8?B?emdMOWw0OTdZdi91eUo3WTA1R3EzT1M1WXJjTlA1YU8xeVN4SWtnQTA5Tndr?=
 =?utf-8?B?cUdwdGJGenYrS09yZzR2Lzh5b082NWRwMW8yV25KM3RKT05mNm9RSXZhVGNT?=
 =?utf-8?B?MDFhbFpMUGRGVkxOM1BOMDJtSDFmRWcvUGgwRGtmV3NVT1N4dVF2N0t1Zktl?=
 =?utf-8?B?QzZGSjdvek4xcDl4d0xxN1Y0QXRhWGFEMFlGanZNOVpDQ1E2RU9tU1k1UnVs?=
 =?utf-8?B?c1I2a3plZXgrVTdkb25yZVBlbmZzckt3aE1TMTdPbFBabHBPb2RIeWY3bCtr?=
 =?utf-8?B?SlRuVzk0YlpBdnB6Ty9EMHhySkw0SDhkeTY5Q1JMWTdjcXdUV1p4ZU01d2VJ?=
 =?utf-8?B?Nml4eHJCVXhhZGR4M013K2I2d01Hd1pQNTRieVVDU1FDOU0zWU5XbkdHREd1?=
 =?utf-8?B?RjF2Wkp6WFZZeXR2VWxEbktYYzN5L3pza1RJeUhJZ044dDRncFFmNXBNenVY?=
 =?utf-8?B?OWZhRGQzVERobmNjT2M5ZlZvRWpBSUs3WmlLMXdtY1ZiVkpOQmN0QmxDWVpW?=
 =?utf-8?B?MVZEVXVuZGYzMzY4ck9ZOTZhUVFSYzVNVFc0eEdkdTdJaThFNkZodXkraC9V?=
 =?utf-8?B?OVFKdFJuOEZnVXJPNlhZN0h1aitlODdvcGNWTm1XQk5pa1pENzBnQTBRQXJy?=
 =?utf-8?B?QWpBUzFQY0ttNk5DYlljUERnQ3BmK2dGeHgxcGZHTHVrcWFFN0trR01ReGVh?=
 =?utf-8?B?aWdzWU44RHB4RGw1U1ovWGwzN01OSGk4NVd4eWJ0cVdjVFpEd2o4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c621778-b702-473c-753c-08deeeca6b02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:10:28.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXbOlPmh20VzQZks7nhrXkUeEWRLapXGxrWuSnm4KHFUrbyQOULu8+JJuWtgBdPDBG2MHo+OcbIJLriI7u0W8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7933

On 31.07.26 08:01, 刘杨 wrote:
> Hello Jan,
>     No Xenomai user‑space programs are running on the customer’s system.
> 

So, you are getting a stall in the absence of any Xenomai load, but
while running a Xenomai-enabled kernel?

Another thing you can try is turning on debugging switches of the
kernel, specifically

https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/cfg/lock-debugging.cfg?ref_type=heads

Jan

>> From: "Jan Kiszka"<jan.kiszka@siemens.com>
>> Date:  Fri, Jul 31, 2026, 13:44
>> Subject:  Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
>> To: "刘杨"<liuyang@sinsegye.com.cn>
>> Cc: "xenomai"<xenomai@lists.linux.dev>, "宋健玮"<songjianwei@sinsegye.com.cn>, "李小宁"<lixiaoning@sinsegye.com.cn>, "马君"<majun@sinsegye.com.cn>
>> On 31.07.26 06:25, 刘杨 wrote:
>>> Hello,
>>> I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i915.modeset=0 in GRUB to prevent the i915 driver from loading.
>>> Since trace‑cmd logs cannot be dumped when the kernel hangs, I configured the following sysctl parameters:
>>> plaintext
>>>  
>>> sudo sysctl -w kernel.panic_on_rcu_stall=1
>>> sudo sysctl -w kernel.ftrace_dump_on_oops=1
>>> sudo sysctl -w kernel.panic=0
>>>  
>>> The full serial log is attached. Could you please help analyze whether the log contains sufficient information for troubleshooting? Thank you.
>>  
>> I'm missing cobalt events other cores and an annotation inside the trace
>> where the error was noticed. That's why I proposed a different recording
>> method.
>>  
>> Also, as the RCU stall detection may be delayed too much to still see
>> normal operation in the trace, you might have to tune the timeout
>> (https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu-cpu-stall-detector)
>> until we find an earlier problem indicator.
>>  
>> Jan
>>  
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
