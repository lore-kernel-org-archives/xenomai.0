Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B1ACE03
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347890; cv=fail; b=Sn+odhJuok+0DfT1J3MdLDlG61zeVdvlaKWTIb1U/Kb4EX8uMMuclKuPZKg5Qe0wQvSjGxkSSS2pD5SoVsR96uq2pscx0H8zoLfykcntkJGSTbrEOxKP7umtglcsd08Ht718J9J9N4bkYu6+AieXS5ZQsn5LlqAGQ6E3JNqWKOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347890; c=relaxed/simple;
	bh=hitUVk8bXAZvzouSLFt/DhBhmbWMMK2DXf1h9JU3FY0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mf4n8XpOyps4kjvwx7Gld6K4JK8mXoAOi4FwnraCsu/pbybngPyxW4lWKg198pLSg4w4Ht/ZPuNKH7Rr3tHN7TjrB/glqQDYhXnmvV6ORWwoOnObIoIs/LqYvXVmVV3oUZOIhO+22r31TiLJMWznflWgev0KvQTVoZWh0kgT8CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w1CLDbpf; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w1CLDbpf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ly8hLgORt5n5geIla6284o9hpj6kwN2gd+tdRgY1mvZwHDbWak4qs1Cpl0j2oHnFXhW0oSjWgtaGn1QswCFSQ8OCaSbA91haZd0apAHBUYApmPcc2SPmtr9vV8ABxFREwafFwTEbvnS02nSykqXNl3GmTOkUqKaDKpnNw67uj1it8bHkrLXlgLiWswHctKGc4FCcSyiDSma3OL6mq/g1XEeI4SINrp5NFHiRI0xk6j2n9FK1cZ9vdy3Q6mWSPAwWc3BTL7is+D0ANmxGUWJDkzx33L+tfAyDDejTBEy7fsbaWu2RrAH56zmSZes7JhASEOSRJU2LeQGh9oh4vG44dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1H2AMeL+DXMk3ygsUB9sqhLcP1AToeUDe/OyXi/I5k=;
 b=n2w9BmEjeKXX06CMcwlPRsy0F8SiOk8x/3nLtpoNBTHkRfuMCi/Z4YXa6w7oZ+92YCJQ6LTXpVe0DyNaHm9ws2r1NN3rBnt0663q2Eqy1EYIHknUB5Bigtrof21l6eK5qoBbBF4eZy7k7n949R2WElDnLBdUAttYbmakOyBHndgx73vHn79fCap5Yp36UpY3oJ8K6TwVraLsmTu3Fhm4O+uF36LEpeMeVsWX/U1iBoMce8q/kCChYR0yX9rczgkuYiWZEs4k5/8ZxVhrOk3N2rcGklshh0ttWy0S2j0ajkpepCxWR6s7miEMEwJH4snc+FrlGo6SzfDtSoXlCg44dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1H2AMeL+DXMk3ygsUB9sqhLcP1AToeUDe/OyXi/I5k=;
 b=w1CLDbpf+mwrP6C3vysP2u41GArprnRYkcxGwizEgWs3S4ZhCLkXEfxcpuggtZW61tPf/1UCLsoRKaSYtIBfH5HWMtgIS1PtUrPj1m0eNA50jNsHWtnZmOoTSS3jZbTHlYVhsh+umxIhH1TUMoiiK4i7Kl7rN3qKWuoYiEYU+Q42QS5c3MiHh+IMe5bqwY3F8WC5GRuB6pHpN1jvNO2p7nygg+9ZoW7hJ0DG7wVBgdHuutR1XlDSuUdapVVL5rPE1ANWfj5ZUydm/PwSPfkjT0+1cTv4ArmQ2ZFcnR9xwpddqYsdSA412kE02zOHVkvaRv6lhBukZ1UYWyETGgxFeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 10:51:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:51:21 +0000
Message-ID: <9277fd2d-24b5-4d50-b768-5c8554e35d6c@siemens.com>
Date: Thu, 26 Sep 2024 12:51:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Get wallclock time from rtdm driver
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>,
 xenomai@lists.linux.dev
References: <10db-66f53180-5-49b09a80@50985025>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10db-66f53180-5-49b09a80@50985025>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9013c000-d1f2-4fe7-9744-08dcde192830
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDJQVjZISk1URlpYNDJ1N09Sa2RCS1hGY281UHJrU2J0eGkzSEhodjFXbmR1?=
 =?utf-8?B?Z2pRU1NwWnd4RmpwTzB1RmduZEQ5YXVWcU16VHI2dVBSaWlrL0hJak1NN2R0?=
 =?utf-8?B?bTg2b3UvOEY4Wm9wSktjbzhVYm02T21lRkZEN0wzdGJZclY2QjFPb0xmb0xx?=
 =?utf-8?B?VmIrRTAzY1FqL1RvMm5wY09LY0lpSlZ0bTloU294TnBESVd1UFpqODl1N1Rp?=
 =?utf-8?B?by8wRFlqVkNwS01GUU1yZ0FYV1hVRGZpZitHY3QvUXBXY3ROS0IwWUZvUStO?=
 =?utf-8?B?MlRBTkRLaVk4WEU1NjFKRUhpN2dlR0xHWDAyVytIT1IwaFdyS2UzRFpndG9x?=
 =?utf-8?B?MCt4WUFiN01DQmN4K2taYy9kLytuL0t3bTZzZ1dYM3NTeUFvdlR6V2dsckdq?=
 =?utf-8?B?ZGl0bzNTMmg5NVpXL3FEbjhlYlNVUHZCL1pKOFNhenBwRzM0WnhwTHJMeFVM?=
 =?utf-8?B?ekQ4MDJ5NjYxMCtta2dhcFpoTURqS05aYS93OXp4ejBrcUZ4WGZpaVN5Z1RE?=
 =?utf-8?B?N1FXNFlGWGJmNDE2WGJaNkRMM041V01tRExFZWZTbWdMU2JobThXZW03Tms4?=
 =?utf-8?B?ZVVDcmhrOXEwL0U4T3ZRNlVpSHcvSVZtdTQ2NnpsVTZNVnBadFVLZlIwYWU1?=
 =?utf-8?B?UTZWRlhHbFZmSVRpWFJQSHpmWmNOUU5mMXZmbFN2VUdvZXBFQUFXanA5eWxQ?=
 =?utf-8?B?Zmg1T0xqNWtsSkRPTUozc3pKS2UycXhjWE9ZNUJFWFlvYmJFOTFLbUs5anJr?=
 =?utf-8?B?dEJmN215Yjk0R09YQWg4T0VVN1laRzV3MUIzTU9ZYkxpR2Y1LzFTQ2dUeElG?=
 =?utf-8?B?M1IvV0JLZXY2MStLQkdEc1hITDZMVks3QTU0dk5SVktKQXczU1FoWHFWL2FM?=
 =?utf-8?B?N2QvRmZKbkZCR25JOGJyckNsbncxakNWMXlTMzA1bHRyOGdYdFphNytGWmV2?=
 =?utf-8?B?NUIrRVQ5NEZGMkZYc3A2UVdlV0RNdVNzRllybGtrTnlnSS9ZdzR1RjJZblBM?=
 =?utf-8?B?MDhPaHVwellzVWFmbUh5T1YrZEJaZ0R3SE1YZ3krN2VsNUc0bFByNU50YjlK?=
 =?utf-8?B?azhMSTRJNkVjYUQ0Ri9QT1Z2UDBJaEpQOFpGWlMxS2d5YjZJazRBaXhNQmRU?=
 =?utf-8?B?aHdtekRtZVZZVzZpL0kzZU0yVW1UdkY0SFZKNHU2UUR0TzJvOUhBRk9NeC9N?=
 =?utf-8?B?NzFtekFpSTdtU1F2OE5hVmk1RlRGbjlPWVErVXkxeGhjUmEwZk1aajBFNzN0?=
 =?utf-8?B?K0FWdnd4R1I4YkVIQW55MlVIWGFlbVJxbmxVQkM0c2VEZ2duYW9HUkE1TDhi?=
 =?utf-8?B?NzRRazlkQ3BmTTFpRS9PNUZDc2JVeHdQN2xiU0NpT2dRTk5Ld0Z6Ni9KdUFh?=
 =?utf-8?B?ZncwYm5JLzBzMWtvRC9lQ3lJWDc0RC9vMlVpdGJOSElmOExEazd1eFNCcjhX?=
 =?utf-8?B?SlZoYzRDT0ZGOFU1ZVFTQUxiWFQvc2xlbmZqVjYzY0FJRklRTlNZM0ZudTRi?=
 =?utf-8?B?byt0TmgwQnF1LzNydC9QRVNTWTBYR2xSTmZZK0hrU0VySjR5T1JjZE9iOTNi?=
 =?utf-8?B?MzF4dmw5RjE4elZoV2UzT3FzQlVuUy9kYkJPbkxibVpXSTJKbTJOUCtzUmZC?=
 =?utf-8?B?SDZIYStrZDFIRFVLVUVlRUlPWS9sTW4zQm0rakpQQ0VLaHcxQkhHNHIxKzhZ?=
 =?utf-8?B?aWRTWXlLaXNWY005TEtjV3NyNmN5cEpRK0JkMlFEOHU0clFjdUUwRk44NVZk?=
 =?utf-8?B?SmpyMTJmQ3M2dnpwbW53bVVKTlUzK2FHK3crdnV4ekZiVFUwR2daL0NJWHph?=
 =?utf-8?B?cjM1NmU4cFB3dnIxTGJuUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckRVR0oweFRudy9ZRnl3ZDRiZGUxaXg2bVN1cHFmQnYyZTdaSGpmK0pwM0ht?=
 =?utf-8?B?c2duWjh4NjlyS0h0bEozVzc5dTQ4c3J5Vm11ME4zbDNjaFlXaEp4Mzd0cWRv?=
 =?utf-8?B?M0QvTjZDdWxXRG4ycmxTR1BqU0NKWlNuNUJCZk5TdWRUbG1pOER5ZjFEL2k5?=
 =?utf-8?B?em5obHpoVFJhOFZraUNyQ0Mzc0c0amQ5c0lTNkJvMXZuVkNzTVpvN09vNzZt?=
 =?utf-8?B?NHllYmJ6bGFNSXpHa1ZJVC8rV0RCVVZ1d2dkVEVXSTdCREEreEJHUHBRRHpK?=
 =?utf-8?B?SnNxRVZKUnRYUGx4cXMyeDlDTlhsVEk0ZUlNTm1sMGF0U3FpZHZ5VUlZU1Z1?=
 =?utf-8?B?MkdSTjFBMnRQbXhoZm1Cc29KY3VoUmRZMVZsVnRHeE91NUFGdEVlUkM4QjB5?=
 =?utf-8?B?Vm14OVdaYTAxTHZiWTRPejRFWTdmUEFLRk8rL1lSZ2RHME1TWmwzUzNPUm9n?=
 =?utf-8?B?dU1HUnVQU1N0L1VQR2VFUGhnMUp2dTVYU21wQkxiZkJuUWVSQytRUXdZY0hE?=
 =?utf-8?B?NjVTUGkvVWxwb2wyVGpNYm9iYzlMRFc4Z0xOeStwbklKcEtMVitsWjBiazMv?=
 =?utf-8?B?c2NmZXZmM1ZXZVAvcGZTbytaV0llME9FZHpzQXZneWk3NWhWdnMrQnYyQkNE?=
 =?utf-8?B?eXZoQmxFcmQ0RysydlBUc3A3a1NzbWpkYUZSUFd4VTdCUjJTZXRlRnhzcGx4?=
 =?utf-8?B?Tm4zV2NySFl1VTRLVGVRd0psaWxteFRIbU5VT3kweXlJNmVQVGI3cWcwd3pF?=
 =?utf-8?B?Z0FqTTN4WjFrS0RUbnV6Q0h4RGNvbWN5eGNJMmlPbis4Wnh1anltQkJnU09t?=
 =?utf-8?B?VC9mM1pKUzdjTVJNRTlLRXEwblNOWmJwNWE1cnhrYmxFMWlQU1lVekV0ajVS?=
 =?utf-8?B?VVhleE1qbzhvZjBMT3hXMTJjNDBwcGY3Qks3S3o0R2J2M0NaTktVNEFON1ZV?=
 =?utf-8?B?R2tJbGJpLzdMSjRKQmhaTzd6d2FYUkNzVGphWFIvblZVNk1Uc3NZZlkyMndB?=
 =?utf-8?B?dU1qK2cvRmpsVWRodEpoNlZDdG0rU3FjTkl6bGw0MW00RUpiOGxQZlRzTlpa?=
 =?utf-8?B?MGN5b0hUVm8vOUgzUTdmMGFpTTZjZ2hpcys0SHdOWVAyVHZhK0hUb2ptNWJL?=
 =?utf-8?B?a1N5K3VQUDc3dFVoOGhYaWlBU3ZVMjNEQUh3SzVOMld1VEEvbThtR2tMOG5h?=
 =?utf-8?B?N1BGZ0owbUkrYS9nc2d6Uzc0ckdKUjNYckpZTmd4bzRtdjZCNnhmcVVsdHRI?=
 =?utf-8?B?a08rbVM4eEJCNU1pNWV4Q084QmNnYmI2bGFjR0hEM0pna3JTY1hzRkdSS0Zq?=
 =?utf-8?B?SmhNTDh5cXlCYVFHRGhkT1ArZkZlRUgvVjBVQk9wVXVmMjJGU0RFRTBWaUxp?=
 =?utf-8?B?T0llVnZFaGoydzlRM1htYmUwSDU1S09tVW5VdGtiTjlUdWtYRUxnanFCeWdE?=
 =?utf-8?B?bVBpRkJ0RGVRN0RSMmN4UnBiNmdiUExhV3NOaHZ5ZjZJdnJwYUN5VGhOOWZH?=
 =?utf-8?B?emg3SGw4OXhNa2JGQit6VjAwcW1DQU9TNEVWcnYxa2V0YTNhN2tBN0RqejVs?=
 =?utf-8?B?YStoQ2V5UmFDenEzM1V4OEd2ZjdGMGFwdFVSR0poKzk0WnlkeFZtdWgxeVVm?=
 =?utf-8?B?eWRGV1RMNC9nUU5PQm4rQ2xvcGNNK3ZTREZMR3FXMGJmM3JiNnVKa2M0eVVC?=
 =?utf-8?B?dW56ZzdVR21FbUNuMDV0bW9WaUZPdFZKOWFYR3Y2Um1lUng2bnNERkpsais0?=
 =?utf-8?B?aHVqQVFXYVBXNUtSYUZiSHoxZ2lHSU9WdW92VkpSU0ZWTWtrRGg1ci83d3RZ?=
 =?utf-8?B?VGtuSnNQWnlFQzlMT0FQckVsUGlGLzE5MHRQUjJVMzhDWlBYa2VQVTJyTEVB?=
 =?utf-8?B?dnVTVlZ0SHlOR3JpdS9UOEdxYXU5WTh0M1V1dVBYTm1ZZURPcGJJYjJEaDI0?=
 =?utf-8?B?ZW9HOFlxNlArQ056TFBma3pSQjVZL0JWZEoyWkdMZGRuRjMvMFZyWEMzZGwx?=
 =?utf-8?B?Wi9SUVZyYkovSi9ZY2FHRnZkQnI5NDJ0TTFhNEZpbzR5czQ1QVA2WGwyNEJv?=
 =?utf-8?B?cXd1V21GNnNobXFFQVhVRXZzNHpBVnBERDhqTnpiQ3BrcVh3eXp2d1pZdTFG?=
 =?utf-8?B?QjNFWWVrdlBDTjZDcmMrazNic0FuUHZMcWs0Vm1tbWNaVVRhTmRhRXh0TmZ1?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9013c000-d1f2-4fe7-9744-08dcde192830
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:51:21.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGSE5qqZOt7LaSjnD/YXe8xIVJES1PAubk9LN1007WP1CSoJEn8uICgmuUHqPPF4E83XJMbSW4jvT1XqnAHWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5445

On 26.09.24 12:03, François Legal wrote:
> Hello,
> 
> in my driver, I need to get the current wallclock value. I tried rtdm_clock_read, but this seems to be the boot clock and not the wallclock (the one that is updated by ntp/...)
> 
> What shall I use to get the actual wallclock value from my rt drivers (the equivalent from clock_gettime (CLOCK_HOST_REALTIME)) ?
> 

rtdm_clock_read should give you CLOCK_REALIME, rtdm_clock_read_monotonic
CLOCK_MONOTONIC. Which version are we talking about here? And which kernel?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

