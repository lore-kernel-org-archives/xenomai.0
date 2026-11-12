Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468908;
	b=O3EcYWM7sfQfDnpBHiYADyeRQQav6N85jXXfQgr7xldmWsztOwClfA9d2FzL8GYrIO1l
	 A2hoFCg4sF4FWczLd2Q6zboxGV8aCRR/vv7UJ+5QJblyPZrD6w+oIOjFkOrEQUE7kOF/y
	 9jkj/EC+k+LLE/66SaZV5xXYy+NYT3OAM4h52WtGJeTJqq/HVdYRJdYSlLIoCBFMua7fy
	 550mdZo4i/smIJ+XxRnhOmnzQefEi5MjNNvZF6f/oYUrs5AufkRFjp0Z1lzvdq75ePFAg
	 i+nadpenw3HMXp5CuOR6Yyr0J8wXGaLtXIYxMkOAU8HzdYVKyLSuCavL2ygBVDwYbjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468908;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Dn0CPrnobk8roKu/KQG/BrpqvPOu15KtnhkkR2hq3KY=;
	b=K51yXHLEDVHV1Pw7uKYbIm+JrVsmFvEBeHAFemoBLpJrurkIWHAu3+L6P6oOTfo72aOW
	 SiA3LG+pWHW3PBAnZIEHeoZXbtpJPAsdCQ6pvNyZsaktjJA/imsF55XfXo//zfct0Eukc
	 dHUGFFdO/cxpfYSVthd/RnwsgYctdX2JX0t9rk6vQ41fi8FnO27Eyn1tgoEhs61734bKG
	 Bc8LBki2rNl+TRtd46lPzRgDSEa1aGqVECmgM/GjNHkvmZ2fmzPUlkdrpWMAOwpEKPsoi
	 HKkDwNSzmrywhU4NEIdvI6plMzk+PUoWmsR/tIjlMKz5l1L4zlys3lOZtsxGEoxt3jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WvndPbvO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.53
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C91606A323
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 07:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C91606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WvndPbvO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MstlAik9yDydyLw/dm4rvdatgYgGFf/1mrKxl0HvUDPxqk3CEhGrK/B7G6V7pE8d1WXLypRGyKTkNiyl5l17t9CA1h7pfEat0IeNL0elzpNvLvD26XrVxeCIALoP/1fDSuSFemsw6arVBNk3WHzVAvcUkLFuTL7EH2XxJhz4+9Y4UeAdXoG+UKnxVwjDPbDcHu2J7ierwx5LAw7FHScoz4zr/hhr8IZC3wGQYpN7LwwzKh3IpGtiQJTPu9wxs8IwmfLi+Lq1WvuUB/h4lWWuMdTWf4tV7pVQgS39uiboddqAwtJqh4s6ffYogKtj5aOqoouTvwxK78i6AZa84BFTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn0CPrnobk8roKu/KQG/BrpqvPOu15KtnhkkR2hq3KY=;
 b=NxSbW85SxKL2d1cqRa62yXezTwBHp0289keVSUCZ2Pw6nhuIfGI5B+7GwM0SWDIbdkvbtamWW+R1SJqHX6Ng4k8iW6YXV2SVdFATOXDTYFGTmyuPJQrSwJigR3KwGXin/j9qF30KNyw+18U62FmtyZA4aKuQjhj85i/MTGRRepEcA417ckhawWP+RsWSWir4VVcrfemQusScFAKVat9HgXw8/ZiUhW7eQ0uv5b9KFIV+LMrZActMHPQFctLOsiifSYdhutJxzywJFE2Z4otg6jMJZS5GGE3MFNRIw5GOosIvkqnEAAuS6mHJPn6cYMCX6hj8xUp9+mv8z9/DbHWE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn0CPrnobk8roKu/KQG/BrpqvPOu15KtnhkkR2hq3KY=;
 b=WvndPbvOLF37hZfnDm0vuc+tV12j133XQbXhDfQLT2Oi6tgRgGj7KV15pbMAyCkSmg5G8Y6gOe38aO6L8wTm2ZjmfVTkPytZKdejXQ5FO0HsT6ByRcxH/tzkyuI40taqg29cCagqSaapFlzxzE0lTu4+Q+r1XuBB8kmeqQXyH3LnTGghBLofoFge98AECPReHC/G4kn+rV816lYGqPDOYgX7HHT3kN1IqF++omH3NVoZnUGotgQnRUpyMCWrt1vX0F+9Wh+Uep5LqR9RBMr/ddxpQ8MyRmaSvekRdSVuuu3GI4lHvb/V1xdQyjViPah9iJbKVend7qgOs9+8zQizHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7777.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:64e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 07:35:03 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 07:35:03 +0000
Message-ID: <ccf75b59-e0e0-45c7-a7bc-7d3bfaa3ee3f@siemens.com>
Date: Thu, 12 Nov 2026 08:35:02 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] x86: dovetail: Notify the core before emulating
 UMIP and vsyscalls on #GP
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5607cd24-d544-43ac-8508-08df408f76fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261102123227099003|10067099003|261009223027099003|261026121527099003|261026140227099003|11063799006|5023799004|261021121427099003|261022105027099003|261021123027099003|261022075727099003|3023799007|6133799003|18002099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QVMcILWe0CLL0rsnpPv5We9kuqPiGeMlrSpeWgxg+oCrKR03anCBPZTs26J3jtX+bgNNwlSPVS5JnQEv+i3a1MuSygefzr/GyA79taK8HtxYEa79FuCMIcxF+lW6ZbCesnTzflVZZ3lUOwzjbVhOM7ld+pKK2tZh5avODIg6hG2jcZdwP1gXc2S3E4LlSLzREZBkjhxEVP3Bda8ubvN0XEjV7KgQYWslb42htPgKCy7/b2OgOZXxzox0NMi2DvilY/nv8dx/+c2/tbbvsK5EfLfTTYUjclZq8NLMdF+J+Bk2ZKLEJdvrSnpkM6Ln4+wvBPFKgBg403ZRkiZs9UozptPP51b0+4Y0lM1mRMmRd7Yr2Rd86NrmVW3B5j29N0+o0HCOpnmkNZpfg6+vT81ZF4LAALqsNxlHJ0cJ79DKwqWYlZCAHSSkpEYEpOADHMJAbInRRqpizKJT7y9IH4g7sNznz0b9GpQWIh/D3up+gySXHweJZn9YZN8k6QuJPfW3CGPcEdx/R0e9DMt8jraH2XHpX70jyLqpE/YG4YYwDxz0lDrD2HjwJWAEEjjrPU4wii4J0tvA7IbulqMoqwGh9wlgwR+lny7dAzfpYcs4zQv2onb0DeVJxE05Jjb7EM1vNo3xFWA0bjH3upN40eLeQ0i22ydyon2hgHwgXXReVpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(5023799004)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(3023799007)(6133799003)(18002099003)(55112099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0dQNXhRR0tCMHFFeksyMVZaQTlEN1VNSVJXYWRCd0tFb0l1VUVoYnNpQXda?=
 =?utf-8?B?OHhmS25Jc2hDcXNXb3lQTzJDQ3h2NHBkcVAwVFRnQ000UEFvMUQwM3AyLzN4?=
 =?utf-8?B?VXVoMTh1RERzdkJtOENiTERncDNpQ1dqSFhnbzRoZEZQWVBQSUt0ZkVNeUk3?=
 =?utf-8?B?Szl6WCtSYTZoOGQvQzI1TjRPd1RsdmUvakxiRFNqYytWditsTTNPSllRWWpZ?=
 =?utf-8?B?MkRSUGs5STMveG94ekM1OGROaGNvdDZycXVVWWhtdFJXVVMrS1A3cEFlL3di?=
 =?utf-8?B?aExYNUFSdW1lWWpydHptaFp1Q3c4ampYWjRXLzBLanNlTlJyRGpjN1JjNzhq?=
 =?utf-8?B?UkxlWGRreFdEOUdiUDlxck9PWEdseDFmZ1RDRnk4NnFjaEp1dVVaRnVpYXhm?=
 =?utf-8?B?M0pVUUkxZ2hIYm1oV3BNbUpNdHd1VEtReUhxc3hsRDVhMkpPUGdhdzZsY0Nw?=
 =?utf-8?B?MldIMlJqRjhxUXN2VFBLMlp1RVR0c2g4MHZMVzBuMTNzZkFDZmFIR2lIbHVt?=
 =?utf-8?B?YzBSQlUvUTBxSjhoVkhOWnNaYkp5K3F2blMzMmh4TXA2TzQxZ0NZRG02UVdj?=
 =?utf-8?B?RnBIM3RDakluZEZsblpXbDU4S3Z6ZktpQkZyNWtHbEdPU2p2ei9tUVRsZTdR?=
 =?utf-8?B?QTZxYzA4OUJ5dVB4RlZLaU41MHVFQjVVV3VlR2svWE5EOWY2dG5HbDVHMzRT?=
 =?utf-8?B?SjBJUkNIMDUvZzAzd25WMWpSclpUem40bnFSOE8yUEV4aVo1OUVldTNkd1Nt?=
 =?utf-8?B?RWpUK1FOd3ZWUUNickZwbnJQYnlMR1p6MWUrUGpSSzZvMWlhbzB3NFJaOGRT?=
 =?utf-8?B?dEdYd1FVWVJTclI5SGxkVFhMWkVkeU4wbGVncmR3MStaUXNoZG0wQ2tURFV5?=
 =?utf-8?B?eTBUZEM5ZHVmVmJOcSt2Ui9Ud1AwMHg1d21DUzROdEV0VmJvcldTc3NsK25r?=
 =?utf-8?B?VjJZN1NiODdxV2RFdEQ5RWNhR3ZUWk40QStDMkZDMHBrdFFhM28waWc0c3Z4?=
 =?utf-8?B?aHB3NHlFcFBqWWNjNEwwMHU2UTB6RjBEZXE1Snd1dWxiK0NNRHNDdHZuOCtv?=
 =?utf-8?B?bEJ4dXhPY2oyOUxoT3JpM0RRUlorTG94dlJ1ajhoOERuN1lnTE0zRDgrSnJt?=
 =?utf-8?B?djlXUTY5ajFsU0ZYYUNyblJxSUd3azRjS2doTnpWaTBOZUdOYmZkUHcrTFQz?=
 =?utf-8?B?VEp0c3AyT3NYUHlHRUdJWFR4VFRlVVBKT042Y3JRazh2TTVXdlVCdk9qS0ly?=
 =?utf-8?B?MjRXU2poK0ZGY3NHUG9QWjF3Z1lDTGNEZmJidjA3L0hjV3MyNEF0clVMaVZB?=
 =?utf-8?B?VDFHMXNqRTBUeXcrMUtMOW54cDZGRVB1OHRyUmpmNXZLOFNlSUt6Rmsrb2RK?=
 =?utf-8?B?a210ZEtLTUJ4aEZkMzlqMXU2RkVqZFFvZ2VoME1ac25FRXMxWEZkbCtzMndO?=
 =?utf-8?B?am9LK2cxSCtXVnZxcTdLUTlVcG8yQ0NaU2ZnQmJ2NytQYXY4SkFOeUtsQW9I?=
 =?utf-8?B?WFNadFdYa2QyWW9hZnNmam4yakZBR2wwZ2ZUcng3eCt3ZnZYUjdkb01IUUx2?=
 =?utf-8?B?SXIvU3NoV1RwNGtJenlKSjQ3aVJwcmNYd3VyWmJYNG5JYU9tV01EcGVGUk5Z?=
 =?utf-8?B?WlIwOFZTZ3JSNW1wYnRBbDVkZlVwaWNydFNhYVpCWFZDcUZyVTRGQVVSWjBN?=
 =?utf-8?B?dDQzaEx3V29wNUZuUlgzNWFsL3puZmxNWTJYaTNmQUY5cFRlbitRTXRPTUNJ?=
 =?utf-8?B?azVsSVFYc1FDdURndWU5N3RFcG5DdmlXWVVtMTZ0R01iZXJXOW9lM0djWmpj?=
 =?utf-8?B?eGR2RVRWeXZNRGVmeWhuNkJvTElqZVp5VEd1VVBLQUFFcjZmdE5zZExNeG9l?=
 =?utf-8?B?Y3NSN1prektST3FsR0FKREJ0Si9kY0pweVJuYXZTQ2NtKzdSdjU1WjViS3Zo?=
 =?utf-8?B?OWxQaVRoQXFRMkducmZ4TzZvaVRWZytvMkdIZmM0eGRWcit0RTV6a0RjbUpp?=
 =?utf-8?B?V3EyOFNGYVZJcFd4bW12bGE1bEduRUthMEoxUkMreWVoNjI2M1duS1Y3SGtW?=
 =?utf-8?B?bGZ0UnVnSHJKYnZUaW8wbFhmVkhDU29rVm00YlpIQXliZnNpVnJTQ1JPSjIz?=
 =?utf-8?B?d2dpdSswVXQ0Y3A2NHZzYldtTEM1dkc3R2gwdUhVTkk3SkhyOWsxOTRiVDUy?=
 =?utf-8?B?R2pRbG0vY2txZWRtRlhWcW1XREtSZkVhdzRUVElrVU9UQWt5MzZ6UHFQOHFK?=
 =?utf-8?B?QzBHRkRRYlh2c0t0dmtxTUl4eEhJb1AxNkY3QjhXZytNaDU4Y2VwOFE2U1ZB?=
 =?utf-8?B?U3JwUVZvbVJYYllnVmN5NjVjaWJWOUQ2ZmIzd0Z4enRzSTdNOTc2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5607cd24-d544-43ac-8508-08df408f76fa
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:35:03.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHepG2jiRyvMdRyDgeWHJZeJI2oIV4n0lSpLalD22RsT2ILIezPpwtbE1w/hlK9L9ALfMn2R1Di7I50E/mL3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7777

From: Jan Kiszka <jan.kiszka@siemens.com>

exc_general_protection() runs the user mode fixups before notifying
the companion core about the trap, so they run on the oob stage when
an oob thread takes the #GP. Two of them cannot run from there:

- fixup_umip_exception() takes mm->context.ldt_usr_sem, a sleeping
  lock, to emulate SLDT. If the result cannot be written to a memory
  operand, e.g. because it lies outside of the user address range,
  which copy_to_user() rejects without faulting, the emulation sends
  SIGSEGV via force_sig_fault(), taking the in-band siglock. The core
  is never told about the trap, the thread returns to user mode on
  the oob stage and re-executes the instruction. If the write faults
  instead, the core gets notified about the nested page fault rather
  than the #GP.

- emulate_vsyscall_gp(), which handles vsyscalls on CPUs with LASS,
  runs the seccomp filters, sends signals and invokes the gettimeofday,
  time and getcpu syscall handlers. gettimeofday reads the timekeeper
  under its seqcount, whose in-band writer may have been preempted by
  the oob stage on the same CPU, so the reader may spin forever.

Without LASS, vsyscalls trap via #PF, and do_user_addr_fault() already
notifies the core before emulating them.

Notify the core before the UMIP and vsyscall emulations. A thread
using these instructions or vsyscalls from the oob stage is now
demoted, as for any other trap requiring in-band handling.

The vDSO fixup only redirects the register frame and stays ahead of
the notification. So does the iopl fixup, which turns CLI/STI into
NOPs for tasks which called iopl(3): notifying first would demote such
a thread on every CLI/STI it executes.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

New day, new LLM patch. The reasoning about what could go wrong from OOB 
while emulating makes sense to me. I'm also not seeing any regressions 
that could be caused by migrating earlier, enforcing inband - no 
legitimate OOB call path should have taken this route so far.

 arch/x86/kernel/traps.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a082670f0e1f8..26a30aa31960d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1030,14 +1030,22 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
-		if (fixup_umip_exception(regs))
+		/*
+		 * Dovetail: the UMIP and vsyscall emulations may take
+		 * sleeping locks, run syscalls and send signals, which
+		 * the oob stage cannot do. Have the companion core
+		 * demote the current context first, like
+		 * do_user_addr_fault() does before emulating a
+		 * vsyscall in the #PF path.
+		 */
+		if (!mark_trap_entry(X86_TRAP_GP, regs))
 			goto exit;
 
-		if (emulate_vsyscall_gp(regs))
-			goto exit;
+		if (fixup_umip_exception(regs))
+			goto mark_exit;
 
-		if (!mark_trap_entry(X86_TRAP_GP, regs))
-			goto exit;
+		if (emulate_vsyscall_gp(regs))
+			goto mark_exit;
 
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto mark_exit;
-- 
2.47.3
