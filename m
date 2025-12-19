Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40C13D539
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135819; cv=fail; b=EVTLX4Jf/6mbxkrsLYO/J70TX5qotaNdo+VGQYCHKPiz/vEUUVdv4wRNwKUhHHloHn5p/PgUwPcxfiPBlEAx9iNcNptyywBSKgj48uwAROD2YvisTfmjMHl5tX1zt2Wwn7UnyxFBGhOe5GAwq/CDLnvythzjQ1TClP6S+3kI/PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135819; c=relaxed/simple;
	bh=u9ZUas+iy3p0bpwXLPs2lYgFzhzTK0QVxAxm+f3WaoM=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=uMQgdA4xkvGH1eFQWapM7/AIVm7BLj3+4h9d7EMjO+VQ0fvSDwVBEw6PvcMUG7W366N2HG07Nh3gQsNtCeaagG4Eu7i/oRrUhe3r1NsCtQqxetxhRjCPSJ5urdQ7a6BptNJTE13voKYB3LXzCjc6P85VoAY/Yz/whaw5b+u7Ffk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vm371F5Z; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vm371F5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA/R+INf/jAnghzR5VSdBjTm0ygbHEAGuUMXXA7/iY6dTLVBAcjvyB0LsakuAKi75mp+suAQZFS+VTIYF6JogpOs62Gmj2yHQVq0zUV4jhmQ7piCzRt1DYxQcfzGGTcIJbm1vSMMi7DmxufJEC17aiyWC5aykYKcxZZcqNiToKqxn8YmPsGj7e9rkTCR4SDqbSHk6n3Uj9BfSkJrEVXZkhlEdmgW6k8oUe8ru3JIvS9Mqye80Y0YlcZ7Y4WvXYu/o4OwD2dW0JQ0KJQEsDgPTgn5BWyLHRaT62BLP293MXnzUwZfjiC6g6U5NrxKPPP4BMpTniMVM6XxJuQ9MNOTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyfhC/+7EEWiLOQDR0OVzU23+FVcTTaZUi89ECkU7xU=;
 b=IkgsFWqFRj9TJwAbgeAxV+X0wz5OUbqK3NaRbBmWZiCkM5wPP5iubr1RSixLW7zGAMYrpSA5HGbJBaiOeCjdOf3WE/v/TV+0+pe5bqM9CHbp3fxWD8ceI45Zkef8GoxD77iXwz4SU/BM6qmD1SDb2r/+IGFqWleykCCkrJmO0tKJvDM/F7utKZxZXpYFOHNLLU8H3f4w4yPM0SxFrHXAJc1QqsCrW7CfwmleS/8eSXQJJ9J3hL1IHaK3pS4ZOAPsZpEbf1i4OjnZShfH4KAE0EFODPudApf8PkF8z0R1gZXGWvloJ1MuFPhZRqSbzyj19I8PYUGT33nO25R+OVQ0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyfhC/+7EEWiLOQDR0OVzU23+FVcTTaZUi89ECkU7xU=;
 b=Vm371F5ZbR2/hyZQyTKmdRL1ti6fnXdkH7ygI4UJOR+PC6imDRovlybOYB0yt8A78VaTJ8jQi35jtrsH0rNaXs8h8fKwST16lXiJFKN8DdTye4rXAQ7KrQA6oqtsFZv1+pwQdJ4rSHb23UIeCha7mV1i71Ktou74A5VQcKD+DFe8p927wVgJBtIkL9lSTAVelejFOFAMgUPGwSNhm/VhtQxpETVVK7gqTe2vdS7FUtHZJOO94dodqK6x84kZCvYlIIpClVnepg4YnV5qTxoWQ+k5JcxgiM32idJOhxtA2P7OD+4BmZjjqcl37z+EhF7Mz4aEXyek/18GvRtV1Xmz1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Fri, 19 Dec
 2025 09:16:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 09:16:52 +0000
Message-ID: <ef5c24d0-5376-4e5e-9c7e-2bdea1fdf1d3@siemens.com>
Date: Fri, 19 Dec 2025 10:16:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] Lift minimal kernel version to 6.1
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:610:55::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 64161821-9dfb-4027-4310-08de3edf5931
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWFiemV5NnVoY0IwWnVtNlVVMVd2ZFNHcU56NTFzTFFJeS9QRzR2WDRYbC9x?=
 =?utf-8?B?WjE5dTBpSmxvZzh6ZDAyT3l1bFVJYTRJMm52NUR3aDF4OTBnRTBDNGd6V0JZ?=
 =?utf-8?B?TjlkeVg0U2dvN2FObE1nSEhORXI3MCt5Z0lSa1Y4UW1Sbm9ZZCtiTDdyemJI?=
 =?utf-8?B?c29keE5ab2taQzA0VXpBK0FxZ3ZuUHVvVTdXQUFUOGMzTkV5NXJmZ2Y0TVhT?=
 =?utf-8?B?NEgrTjJQL2hEQXZoMy8xRUswT2dhMDhxVG9TVVgrcWVZUVdtV25mbWFXazFw?=
 =?utf-8?B?YmI2VHhTMVl0alhDNDgvWkZ0SGZMSXNNK3NOYUhyRzc2VGhQVDJVYVNEaEN3?=
 =?utf-8?B?OHk3ajlKb1MzSVlvRlJzajE3MnpYRzVRajJpSzR0UmdoaUtGamhyMmVPRHJC?=
 =?utf-8?B?R2pneEhyZE5MeFdQQldPQW9LcTB1eFlzRWpmWFp2S2VzUWxjWjZMMnIzMlJt?=
 =?utf-8?B?cy9CV0dZd1MycGVaK2Fxek0rb0tha2tzVlBNVlIrL1lnSUdudFIyd2tMdk5q?=
 =?utf-8?B?MW5OaW9HZDZ2OWpBcEZkejZZQldZSjdWR0ZPUFpDWWYremVnWStFMzQ2Q0tG?=
 =?utf-8?B?bkNUQzRMa3JzSVRLakpteVNSK2Q0V3d3ZGZ6OUNieHFMYnEwRmpZY2ZQVFM2?=
 =?utf-8?B?T2EzS1NzcXM2NVFjRGRjTWZzbm9QZHRPV1hMalIvSVhsWGZ0MkdZZHlORzdR?=
 =?utf-8?B?TENKQUxEbmI0Tks2V25KWkFoUVlVUW9lbmtCeC9MMWtUcCtobXFTM0JzN3Fz?=
 =?utf-8?B?UTk4a0lCcFo3YzU1OVlpS2NZWVFqbUVyTHh2NjBHb1E1MmVRd3ZJMjJBOXRp?=
 =?utf-8?B?ZVplZnd5OE1ydXYrRUpMUEYrRlEzNUV4S0xGL1RJTVN5a1UvalpLSTFEVVF2?=
 =?utf-8?B?UXd0UlpaeHJnSXBpWS8vai9RY0pNU0Q2dG5PdE9tYUYvVDc1Y2kzVExrczJD?=
 =?utf-8?B?SFlPNUZhMWhIdFNlUzUrRnloREtBWFBERmNyN0hPcmkrQXI2MjI1NVQ0ajNV?=
 =?utf-8?B?aHZVVzNrblYxajNBUndWSStQK1psZ25xUVVsYVlTelEzZkJEK2FMaTJucmc5?=
 =?utf-8?B?TnhhOXEyalhFUEI3QVA0ZHpDcXZnb05lTjk3WlJDN0VOYjRVVXVDYnpXTkhS?=
 =?utf-8?B?TUFLNHg1a3VvVHR6L1U5TFBxblFKRFpUMGJDNitlSkI0aDA3TkozWG51MWh1?=
 =?utf-8?B?WnlLc2JSRDNBNkN6cnNOYjhCMTh1TEE3Z3JIWGtLWXpzbFhmWG5zdDlPeU80?=
 =?utf-8?B?OVVXRG1BaFlqbU8yL1RkS2xVL1NBU0laU3pQRGVlaDhsZnB5RHpUaE5ZZTFs?=
 =?utf-8?B?cDRUcTk1ekFGS1FUcWV3YzJ5Z25aQ0JSVUxiMitZa1Z0UUphamsxY21KSVhQ?=
 =?utf-8?B?eENaRnJoMDRkWUhRRUl1YStiMGd3QW1mVzJ5YkN3elFjYW9hazB1eEpZNEg2?=
 =?utf-8?B?ckxzMDZWTkpNWGROU0lOZXE5QUhsT0tucWtOajJHbzFUdjVOVFZ3dy9kV2FR?=
 =?utf-8?B?eUxtSDlYamtwMXdqYjFUdXphc01KbU5rbFplMHpieVplOUdHTDVFZStTbjRs?=
 =?utf-8?B?amthUXJzV0haK2EwTkk0RDBsbTYyV0ZkclFHRE1VNms2R0ZkakdUQmxzZ0lG?=
 =?utf-8?B?UkFROC9XU1VLaExweUt4cnlxTzFrM1JJamNVNWVoZWxjNXExV3NuWXhGd1Jm?=
 =?utf-8?B?Y0FrWmtRNHQxdVJtdFREaW1wcmo3bkZrbzdxNk9UV3pLeVVKZ1VhV0U3dm1H?=
 =?utf-8?B?a3o1UHRINytOUmRBeHpTc1A4RnNoZWNBeHdSTDFvRUNRci9ubmMzeDJzWFBH?=
 =?utf-8?B?cktlU05GQTNmM3pUdldJcDFOSTlSM1k3VlJxUlU5MVpGejMyWFFQNGl2MzBG?=
 =?utf-8?B?cndSMjhwT216Q1MrSElHMmRJQmVyY3dVdE04STl3L0w2c3hwT01ac0pvSEky?=
 =?utf-8?Q?n73ULV5hF9+lL+D8063KAo498pUYVUd/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtBdkFBTVU2M05pMHR1ZmpGaTZnNUc1NitKaUt2enc3T1JhWDdzWCtIVDdG?=
 =?utf-8?B?L1gvWllqSHhKclMxVFl2NUdJMGhPQ0s1dm03OWJXWkpuVFFDSzhGTkh6YjJ4?=
 =?utf-8?B?Z0ZLSFBxcW5UMjNwZVpqMjFzY0NoRWg1d1ExSnBDQjlBZ1BtdFVqTncyQXpu?=
 =?utf-8?B?WW9YcldKM0ROeDZSMElzRGkwUVNvKzZaN3NJQjVGd2IxbEhnb0crc3hJbWxB?=
 =?utf-8?B?OVNhWEFDUXYwMURjNjBUSGNGeWRBQzJtWVlrbG1CMUcySmxsWmorWU94YVVh?=
 =?utf-8?B?ZTZINXlCZGxKZllGNWZCTmlhbU9xcUo1YlFCZmtzMk1RQjVPZzRNYTdtY1Jr?=
 =?utf-8?B?aERYR1podTVEU1VRbWJGanFOS2dlVmd0aFJwWGRFazN5RjB2YUNyOXllM2My?=
 =?utf-8?B?enltSFFaMFlwNVVFbHBMcjZ4L3dOS2gyaTlrUFFNZHhmVGp4cU9uUXg2VFFH?=
 =?utf-8?B?aWZCejZGY0NxODBleDl6U1RvUkZwN2t1VWZhU1E0bkpTTXhuV29SY1pRbk9h?=
 =?utf-8?B?MkpocVZ3L0dXNnp0UGk5UmhLM0E0TEpSbVJxWmYxcnhOdmZjWUZCMWlhbXo4?=
 =?utf-8?B?MFEyaFE3dGt0blRZU0hjcG9URUVhKzcwMWd2U2ZWeWNjMzFOMzJRL2daU28z?=
 =?utf-8?B?WVZ6VWZaTGJLa2laOFN1Y1BjMzRXYUxWYXVua09vbUNQYmxHY3hKS3AvUzBl?=
 =?utf-8?B?NnNsL2lTS3lHMm1pMmkrMWs0blFHZ0gwRngwUWdwYytuaGlrOEYzY2dhUC9t?=
 =?utf-8?B?TzREWnNhZGRXYkJmdFZYbUd0czc0N0VLbG1NUk1LeVhQVzU1VkZBdjBjR2pQ?=
 =?utf-8?B?TEUzV3ZIWDJEazZNT1h1Y0MyVkhSRWJNdzdSNW1rMFBZZTZFRTA5SzF4Sk1C?=
 =?utf-8?B?NlN1WGR6ZXBJUURMZWZXYTBmUjVST3huZmRpZ3NsL1RyZjROeFhBa05WVG55?=
 =?utf-8?B?Nkh0V2F3dmFFeHljUDRZWkRINFlDc0MwZFlQZ0sxaTBVZ3J5YXBVa2lvd0dw?=
 =?utf-8?B?elNLeW95SVhScWVkZUNQdnpWZ0d6SHdMbEJlU2sxa25xN3BFZnFad2RGWXg5?=
 =?utf-8?B?SVNpOTB3UXlLWUVJQ1ZNL0dKMUR2Zk9YVUtZWGNNa3JFNHBoSW9JR2Q1UHZD?=
 =?utf-8?B?SUxBVXVhNTVGZ2xaMDNhR2RqSzhJZmFHbTJYVEpodHZGUFVUdWoxM2JMVVd4?=
 =?utf-8?B?OE55NzNWdFVuL3hrdWl1bWZveExkb3JTWkxwWURmY1dYcWRUekNKbTBxc28z?=
 =?utf-8?B?TFdsVUFWSWM0MkYrRWY2aWs5RTByWDVnMFRyZzJiRWJqdCs1b0JLeE9nK1lQ?=
 =?utf-8?B?dUovV0E1eWRUTlMxRS9abFJuNDZmbmFLVTA5TUxoY2lVbCtNV1NaY3d3d0Qy?=
 =?utf-8?B?N2RaMWlYL1I2b3dEeEU4U3FodEoyUFBTQ0dSL1ZuTmpLdEw1dzBySzdveFgy?=
 =?utf-8?B?M0E2SzZzVG8xcUFqT3J3cm5FNFFzempkSzNvMHlsbHRNODB0Yzc4eDhhVVdp?=
 =?utf-8?B?VFcrMTc2cndHVEdJcDEvYk51N0ZyVm91elVwb0Y5bjRGU0E0MjREcHAySXp3?=
 =?utf-8?B?eldTU0FqeW5WZDlaZXBNNys1bmoyVnRkQmUwNm5XL25YRm9BZFBSSzZ1S21k?=
 =?utf-8?B?aTNGZVlPNUM3S0RXNCszb21SRHhUYU5xVjU1ZHBLa2NxNUJPQ016TVBYZGZJ?=
 =?utf-8?B?RDNrT0Uwc3N2NEFENDg3Mkp0Y0FlSFVsZk80SHNJejJteTBIelBwNmthcmt0?=
 =?utf-8?B?NVROYjZRRkQ1aGtudWM5NFJYcHVLd05UN1NualZpQm54YXJEODRCUmRWV3B6?=
 =?utf-8?B?NS80L01xVmQzZi9wZmRhS29rdjV3ZExkTDEwQVRvYTErRGhmcndIQnRNdmlk?=
 =?utf-8?B?RXJuckhMU1dSdGZkZEhJVGRTOVlhVGszL2p1RGtPdzVlOFprQWZrODJuQ0Jm?=
 =?utf-8?B?ZUpYL0NNOHV4eExmaUExMXZlN1dLbkxNNndDVXo5UGV6TmVWZ3hWNWxyWGF1?=
 =?utf-8?B?OElHWHFUS25ScVNFTnhobjdTWmxURXMzNUJZUWRGR2NvL3VKWEwrWEdnNjBZ?=
 =?utf-8?B?VkFhVHNxWTNCdWYvSVRaR05SdW1IQ1E3TFQvV2FZV3M2WDVVc3kxS2xlb0ll?=
 =?utf-8?B?WGhjU1JhNk1hbEIrOHp3bTh0WHE0dVlmWk1GcVdoYmZZMzJVNklhV1lMVit2?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64161821-9dfb-4027-4310-08de3edf5931
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:16:52.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkBZYC8qW5FFFH7VNu8d4JmOmD+ktiRQ7l+d1jz8HupPXzOPCynqVR7cIm3YqdTmIcbdp5FqPzeSKaLpHDl7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4089

From: Jan Kiszka <jan.kiszka@siemens.com>

To limit the test matrix of the next major release, lift the minimally
supported kernel version to 6.1. Drop any compat code for older kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../include/asm-generic/xenomai/wrappers.h    | 24 -------------------
 kernel/drivers/net/drivers/at91_ether.c       | 10 --------
 kernel/drivers/net/drivers/e1000e/netdev.c    | 10 --------
 .../drivers/net/drivers/freescale/fec_main.c  | 18 --------------
 kernel/drivers/net/drivers/igb/igb_main.c     |  8 -------
 kernel/drivers/net/drivers/igc/igc_main.c     |  8 -------
 kernel/drivers/net/drivers/macb.c             | 10 --------
 kernel/drivers/serial/16550A_pci.h            |  2 --
 kernel/drivers/spi/spi-device.c               |  8 -------
 9 files changed, 98 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index b611c405c8..a68c3b1951 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -43,30 +43,6 @@
 		.proc_lseek = seq_lseek,				\
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,11,0)
-#define IRQ_WORK_INIT(_func) (struct irq_work) {	\
-	.flags = ATOMIC_INIT(0),			\
-	.func = (_func),				\
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,14,0) && \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
-     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,220))
-#define close_fd(__ufd)	__close_fd(current->files, __ufd)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
-     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188))
-#define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
-#define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
-#define pde_data(i)	PDE_DATA(i)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,2,0)
 #define timer_delete_sync	del_timer_sync
 #endif
diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net/drivers/at91_ether.c
index a5ef40c579..4bd2ec76ba 100644
--- a/kernel/drivers/net/drivers/at91_ether.c
+++ b/kernel/drivers/net/drivers/at91_ether.c
@@ -303,9 +303,6 @@ static int __init at91ether_probe(struct platform_device *pdev)
 	struct macb *lp;
 	int res;
 	u32 reg;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
-	const char *mac;
-#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -358,15 +355,8 @@ static int __init at91ether_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0))
 	res = of_get_mac_address(pdev->dev.of_node, lp->dev->dev_addr);
 	if (res)
-#else
-	mac = of_get_mac_address(pdev->dev.of_node);
-	if (mac)
-		memcpy(lp->dev->dev_addr, mac, ETH_ALEN);
-	else
-#endif
 		rtmacb_get_hwaddr(lp);
 
 	res = of_get_phy_mode(pdev->dev.of_node);
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 0679688e20..dad685eb7b 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -3912,11 +3912,6 @@ static int e1000_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	/* AER (Advanced Error Reporting) hooks */
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 	/* PCI config space info */
 	err = pci_save_state(pdev);
@@ -4240,11 +4235,6 @@ static void e1000_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	/* AER disable */
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 69a3517621..cb0eda73bf 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1250,15 +1250,9 @@ static void fec_get_mac(struct net_device *ndev)
 	if (!is_valid_ether_addr(iap)) {
 		struct device_node *np = fep->pdev->dev.of_node;
 		if (np) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
 			int err = of_get_mac_address(np, tmpaddr);
 			if (!err)
 				iap = tmpaddr;
-#else
-			const char *mac = of_get_mac_address(np);
-			if (!IS_ERR(mac))
-				iap = (unsigned char *) mac;
-#endif
 		}
 	}
 
@@ -2157,13 +2151,9 @@ static void fec_enet_itr_coal_set(struct net_device *ndev)
 }
 
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
 		      struct kernel_ethtool_coalesce *kernel_coal,
 		      struct netlink_ext_ack *extack)
-#else
-fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
-#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
@@ -2180,13 +2170,9 @@ fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
 }
 
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
 		      struct kernel_ethtool_coalesce *kernel_coal,
 		      struct netlink_ext_ack *extack)
-#else
-fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
-#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device *dev = &fep->pdev->dev;
@@ -2238,11 +2224,7 @@ static void fec_enet_itr_coal_init(struct net_device *ndev)
 	ec.tx_coalesce_usecs = FEC_ITR_ICTT_DEFAULT;
 	ec.tx_max_coalesced_frames = FEC_ITR_ICFT_DEFAULT;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 	fec_enet_set_coalesce(ndev, &ec, NULL, NULL);
-#else
-	fec_enet_set_coalesce(ndev, &ec);
-#endif
 }
 
 static int fec_enet_get_tunable(struct net_device *netdev,
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index d757396479..aedf526b63 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2029,10 +2029,6 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
@@ -2467,10 +2463,6 @@ static void igb_remove(struct pci_dev *pdev)
 	kfree(adapter->shadow_vfta);
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 29501b6108..a3a6b71135 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -3693,10 +3693,6 @@ static int igc_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 
 	err = -ENOMEM;
@@ -3925,10 +3921,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
index 6da5761479..36b258012e 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -1570,9 +1570,6 @@ static int __init macb_probe(struct platform_device *pdev)
 	u32 config;
 	int err = -ENXIO;
 	struct pinctrl *pinctrl;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
-	const char *mac;
-#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1690,15 +1687,8 @@ static int __init macb_probe(struct platform_device *pdev)
 	config |= macb_dbw(bp);
 	macb_writel(bp, NCFGR, config);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
 	err = of_get_mac_address(pdev->dev.of_node, bp->dev->dev_addr);
 	if (err)
-#else
-	mac = of_get_mac_address(pdev->dev.of_node);
-	if (mac)
-		memcpy(bp->dev->dev_addr, mac, ETH_ALEN);
-	else
-#endif
 		rtmacb_get_hwaddr(bp);
 
 	err = of_get_phy_mode(pdev->dev.of_node);
diff --git a/kernel/drivers/serial/16550A_pci.h b/kernel/drivers/serial/16550A_pci.h
index 161874d1cc..95d1b90586 100644
--- a/kernel/drivers/serial/16550A_pci.h
+++ b/kernel/drivers/serial/16550A_pci.h
@@ -36,7 +36,6 @@ struct rt_16550_pci_board {
 #define PCI_DEVICE_ID_CP112UL		0x1120
 #define PCI_DEVICE_ID_CP114UL		0x1143
 #define PCI_DEVICE_ID_CP138U		0x1380
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,17,0)
 #define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
 #define PCI_DEVICE_ID_MOXA_CP102U	0x1022
 #define PCI_DEVICE_ID_MOXA_C104		0x1040
@@ -48,7 +47,6 @@ struct rt_16550_pci_board {
 #define PCI_DEVICE_ID_MOXA_CP134U	0x1340
 #define PCI_DEVICE_ID_MOXA_C168		0x1680
 #define PCI_DEVICE_ID_MOXA_CP168U	0x1681
-#endif
 
 static const struct rt_16550_pci_board rt_16550_moxa_c104 = {
 	.name = "Moxa C104H/PCI",
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 9fb1501fe8..f3963d81d7 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -124,19 +124,11 @@ static int spi_device_probe(struct spi_device *spi)
 	return 0;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,18,0)
 static void spi_device_remove(struct spi_device *spi)
-#else
-static int spi_device_remove(struct spi_device *spi)
-#endif
 {
 	struct rtdm_spi_remote_slave *slave = spi_get_drvdata(spi);
 
 	slave->master->ops->detach_slave(slave);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,18,0)
-	return 0;
-#endif
 }
 
 static const struct of_device_id spi_device_match[] = {
-- 
2.51.0
